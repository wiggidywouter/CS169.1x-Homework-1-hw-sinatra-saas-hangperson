class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(char)
    raise ArgumentError unless /[a-z]+/i === char
    char.downcase!
    if @guesses.include?(char) || @wrong_guesses.include?(char)
      return false
    elsif @word.include?(char)
      @guesses += char
    else
      @wrong_guesses += char
    end
  end

  def word_with_guesses
    @word_with_guesses = ''
    @word.each_char do |char|
      @word_with_guesses += @guesses.include?(char) ? char : '-'
    end
    return @word_with_guesses
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.size == 7
    return :win if @guesses.size == @word.chars.to_a.uniq.size
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
