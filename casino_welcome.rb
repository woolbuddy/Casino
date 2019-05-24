require_relative 'main'

def welcome
  puts ""
  puts "****** Welcome to the Casino! *******"
  puts ""
  puts "Please Enter Your Name:"
  @name = gets.to_s.chomp
  puts ""
  puts "Please Enter Your Bankroll:"
  @bankroll = gets.to_i
  puts ""
  puts "Is this correct? (y/n)"
  puts "#{@name} $#{@bankroll}"
  @reply = gets.chomp
  if @reply == "y"
    menu
  elsif @reply == "n"
    welcome
  else
    puts "Invalid Response"
    welcome
  end
end

def menu
  puts ""
  puts "What would you like to play?"
  puts " "
  # puts "1: Blackjack"
  puts "2: High/Low"
  select = gets.chomp
  case
  when select == "1"
  blackjack
  when select == "2"
  new_high_low
  else
  welcome
  end
end



def new_high_low
  @d = Deck.new
  @shuffled = @d.shuffle_cards
  puts ""
  puts "***** High / Low *****"
  puts ""
  place_bet
  make_claim
  compare_cards
  play_or_leave
end

def cont_high_low
  puts ""
  puts "***** High / Low *****"
  puts ""
  place_bet
  make_claim
  compare_cards
  play_or_leave
end

def place_bet
  puts "Place Your Bet:"
  @input = gets.chomp.to_i
  case
  when @input > @bankroll
    puts "Insufficient Funds, Lower Bet Amount"
    place_bet
  else
    deal_card_player
  end
end

def make_claim
  puts "High or Low? (h / l)"
  @claim = gets.chomp
end

def compare_cards
  deal_card_dealer 
  if @claim == "h"
    claim_high
  elsif @claim == "l"
    claim_low
  else
    make_claim
  end
end

def deal_card_player
  @card_num1 = rand(1..52)
  p "#{@d.cards[@card_num1].rank}" " " "#{@d.cards[@card_num1].suit}" " " "#{@d.cards[@card_num1].color}"
end

def deal_card_dealer
  @card_num2 = rand(1..52)
  p "#{@d.cards[@card_num2].rank}" " " "#{@d.cards[@card_num2].suit}" " " "#{@d.cards[@card_num2].color}"
end

def player_card_scoring
  case
  when @d.cards[@card_num1].rank == "J"
    @player_score = 10
  when @d.cards[@card_num1].rank == "Q"
    @player_score = 10
  when @d.cards[@card_num1].rank == "K"
    @player_score = 10
  when @d.cards[@card_num1].rank == "A"
    @player_score = 1
  else @player_score = @d.cards[@card_num1].rank.to_i
  end
end

def dealer_card_scoring
  case
  when @d.cards[@card_num2].rank == "J"
    @dealer_score = 10
  when @d.cards[@card_num2].rank == "Q"
    @dealer_score = 10
  when @d.cards[@card_num2].rank == "K"
    @dealer_score = 10
  when @d.cards[@card_num2].rank == "A"
    @dealer_score = 1
  else @dealer_score = @d.cards[@card_num2].rank.to_i
  end
end

def claim_high
  player_card_scoring
  dealer_card_scoring
  if @player_score < @dealer_score 
    puts "You Win!"
    @bankroll = (@bankroll + @input)
  elsif @player_score > @dealer_score
    puts "You Lose"
    @bankroll = (@bankroll - @input)
  else
    puts "Draw"
  end
end

def claim_low
  player_card_scoring
  dealer_card_scoring
  if @player_score > @dealer_score 
    puts "You Win!"
    @bankroll = (@bankroll + @input)
  elsif @player_score < @dealer_score
    puts "You Lose"
    @bankroll = (@bankroll - @input)
  else
    puts "Draw"
  end
end

def play_or_leave
  puts "Would you like to play again? (leave / play)"
  puts "Balance: $#{@bankroll}"
  decision = gets.chomp
  if
    decision == "play"
    cont_high_low
  else
    menu
  end
end

welcome