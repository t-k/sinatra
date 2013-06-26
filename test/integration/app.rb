$stderr.puts "loading"
require 'sinatra'

configure do
  set :foo, :bar
end

get '/app_file' do
  content_type :txt
  settings.app_file
end

get '/ping' do
  'pong'
end

get '/mainonly' do
  object = Object.new
  begin
    object.send(:get, '/foo') { }
    'false'
  rescue NameError
    'true'
  end
end

set :out, nil

get '/send' do
  settings.out << params[:msg] if params[:msg]
  settings.out.close if params[:close]
  "ok"
end

class Subclass < Sinatra::Base
  set :out, nil

  get '/subclass/send' do
    settings.out << params[:msg] if params[:msg]
    settings.out.close if params[:close]
    "ok"
  end
end

use Subclass

$stderr.puts "starting"
