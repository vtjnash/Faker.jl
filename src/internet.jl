using Dates
using Random

internet_rng = MersenneTwister(millisecond(Time(now()))+rand(1:100))

reseed_internet(seed) = internet_rng = MersenneTwister(seed)

safe_email_tlds = ("org", "com", "net")
free_email_domains = ("gmail.com", "yahoo.com", "hotmail.com")
tlds = ("com", "com", "com", "com", "com", "com", "biz", "info", "net", "org")

uri_pages = (
"index", "home", "search", "main", "post", "homepage", "category", "register", "login", "faq", "about", "terms",
"privacy", "author")
uri_paths = (
"app", "main", "wp-content", "search", "category", "tag", "categories", "tags", "blog", "posts", "list", "explore")
uri_extensions = (".html", ".html", ".html", ".htm", ".htm", ".php", ".php", ".jsp", ".asp")


ln_fn() = "$(last_name()).$(first_name())"
fn_ln() = "$(first_name()).$(last_name())"
fn_hashes() = "$(first_name())##"
ln_question() = "?$(last_name())"

user_name_formats = (
                     ln_fn,
                     fn_ln,
                     fn_hashes,
                     ln_question
)

domain_name()="$(domain_word()).$(domain_suffix())"

company_email()= "$(user_name())@$(domain_name())"

free_email_domain() = free_email_domains[rand(1:length(free_email_domains))]

fake_domain_email() = "$(user_name())@$(domain_name())"
free_domain_email() = "$(user_name())@$(free_email_domain())"

email_formats = [
                fake_domain_email,
                free_domain_email
   ]

function email()
    return email_formats[rand(internet_rng,1:length(email_formats))]()
end

user_name()= bothify(user_name_formats[rand(internet_rng,1:length(user_name_formats))]())



safe_email()= "$(user_name())@example.$(safe_email_tlds[rand(internet_rng, 1:length(safe_email_tlds))])"


free_email()= "$(user_name())@$(free_email_domain())"

domain_suffix()= tlds[rand(internet_rng, 1:length(tlds))]

domain_word()=
   ( company_elements = split(company(), [',', ' ','-']);
    sal = "";
    for i in company_elements
               if length(i)>0
                   sal*="$(i[1])"
               end
          end;

    lowercase(sal) )



url()=url_formats[rand(internet_rng, 1:length(url_formats))]


ipv4()= "$(rand(internet_rng, 172:255)).$(rand(internet_rng, 0:255)).$(rand(internet_rng,0:255)).$(rand(internet_rng,0:255))"

ipv6()= (res = "";
    for i = 1:8
        res*= "$(hex(rand(internet_rng, 4100:65535)))"
        if i < 8
            res*= ":"
        end
    end;res)


mac_address()=
    (res = "";
    for i = 1:6
        res*= "$(hex(rand(internet_rng, 0x00:0xff)))"
        i < 6 && (res*= ":")
    end;res)

uri_page()= uri_pages[rand(internet_rng, 1:length(uri_pages))]

uri_path(deep="None")=
    (if deep =="None"
        deep = rand(1:3)
    end; sa="";
        for i =0:deep
           sa*= uri_paths[rand(internet_rng, 1:length(uri_paths))]
            i < deep && (sa*= "/")
        end; sa )

uri_extension()= uri_extensions[rand(internet_rng, 1:length(uri_extensions))]

url_formats = (
    "http://www.$(domain_name())/",
    "http://$(domain_name())/",
)
uri_formats = (
    "$(url())",
    "$(url())$(uri_page())/",
    "$(url())$(uri_page())$(uri_extension())",
    "$(url())$(uri_path())/$(uri_page())/",
    "$(url())$(uri_path())/$(uri_page())$(uri_extension())",
)

uri()= uri_formats[rand(internet_rng, 1:length(uri_formats))]


#=slug(value="None")=
    if value == "None"
        value = Lorem.text(20)
        value=#
image_placeholder_services = (
    "http://placekitten.com/$(rand(internet_rng,1:1024))/$(rand(internet_rng, 1:1024))",
    "http://placehold.it/$(rand(internet_rng,1:1024))x$(rand(internet_rng,1:1024))",
    "http://www.lorempixum.com/$(rand(internet_rng, 1:1024))/$(rand(internet_rng, 1:1024))",
    "http://dummyimage.com/$(rand(internet_rng, 1:1024))x$(rand(internet_rng, 1:1024))",
 )

image_url(width="None", height="None")=
   image_placeholder_services[rand(1:length(image_placeholder_services))]
