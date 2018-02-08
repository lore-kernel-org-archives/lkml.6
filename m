Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224LmlMbMftbNzJ55JPCBgmuxap9JpMwOy9vdG1ieI0qrsRS5H8oUZxFrJ8HWXWv14y4SU3v
ARC-Seal: i=1; a=rsa-sha256; t=1518054645; cv=none;
        d=google.com; s=arc-20160816;
        b=EPYl+dgmHl+Q3ISf44SRLXdq9SQwTyIxRrJ+W9e1qf/VZzCYF/TQxVxvLpJ5GufbYA
         A5SQ5TcBNj2xdbfqtWWEyHmAmSNw5v0+YGy35dGkHJDvMkL51wweAePhxWpH5xH99OGj
         rKqeY1gexFy+COfPb7gL/K6ii1/PqG0sWPCZEQyUP3LLZEA9cOB+d+9WuPApzp8jLFtf
         im2IgTNC2NnCNxm3h7YTyHFPSmaMUunsyaC4IomTqyZJzBQEFVAHsskKxFRL8VKAUU1Q
         1g5p5JqwtIK9pGdyZQQ+KEaUwhkBPs2VdPIqXwZShmgcPpRcTYmA7UUPpLY08nGDS7M2
         7HCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=3KG/ekbLEvhK/DmBysLOnG5zuBtux5gSrWo1TCFZuxM=;
        b=kN3O/SLVkqT5I7Oqy6uuY4cYUBMOkYnVe22lbsKz86C8jjCzfdITu6m6yPQMyLSCy6
         4VhLeouQNgCCm0fYgZN4r7e0LWkp4GbwHe+X6OkIKCAl6bB0SS0xmlUOWFfpGLk5GbZd
         0EuFUXFzn/hTV0niOMcCEkaZsFWkRNclxfsLdQUaWd7tadKdnGHswK3/QJr5VhB3/oDQ
         ysuJp0gvl0HU3G1jnQ85ReO86wTLttxb77thDuwj9LOiS8UNb4Ue94mo1+ta2ixsAkbn
         /q3GZWCUERoflgPHRslqfQoT7uGR+GtRioK3TrYpim7ROGunI8LRMNG48TSLth8KGcFd
         vlIg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=PEarKnCp;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=PEarKnCp;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w181oFsP023898
X-Nifty-SrcIP: [209.85.213.41]
MIME-Version: 1.0
In-Reply-To: <CAFkk2KQNQV2GAXW+hyMvE+J5mMp+5g3SuYdcGA-JjGk5fE=VUA@mail.gmail.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-2-git-send-email-yamada.masahiro@socionext.com> <CAFkk2KQNQV2GAXW+hyMvE+J5mMp+5g3SuYdcGA-JjGk5fE=VUA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 8 Feb 2018 10:49:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNASr5yJ8HY8vRye12UyV7rcx_N=4Abz8fz9AQDh4y8TsYg@mail.gmail.com>
Message-ID: <CAK7LNASr5yJ8HY8vRye12UyV7rcx_N=4Abz8fz9AQDh4y8TsYg@mail.gmail.com>
Subject: Re: [PATCH 01/14] kconfig: send error messages to stderr
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778719993235?=
X-GMAIL-MSGID: =?utf-8?q?1591795667414662371?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-08 5:24 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> These messages should be directed to stderr.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  scripts/kconfig/conf.c  | 18 +++++++++++-------
>>  scripts/kconfig/zconf.l | 27 +++++++++++++++------------
>>  2 files changed, 26 insertions(+), 19 deletions(-)
>>
>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>> index 307bc3f..90a76aa2 100644
>> --- a/scripts/kconfig/conf.c
>> +++ b/scripts/kconfig/conf.c
>> @@ -75,9 +75,11 @@ static void strip(char *str)
>>  static void check_stdin(void)
>>  {
>>         if (!valid_stdin) {
>> -               printf(_("aborted!\n\n"));
>> -               printf(_("Console input/output is redirected. "));
>> -               printf(_("Run 'make oldconfig' to update configuration.\n\n"));
>> +               fprintf(stderr,
>> +                       _("Aborted!\n"
>> +                         "Console input/output is redirected.\n"
>> +                         "Run 'make oldconfig' to update configuration.\n\n")
>> +                       );
>
> This could use fputs() too, moving the stderr to the last argument.


In general, I am not keen on replacement of (f)printf with (f)puts.

If '%' does not appear in the format literal, compiler will automatically
replace the function call with a faster one.

My compiler replaced both fprintf(stderr, "blah\n") and fputs("blah\n", stderr)
with fwrite.

At this moment, right, the compiler cannot optimize it
because it never knows the result of _(...).

If we rip off the gettext things, it will be optimized.



> I think the _() thingies around the strings are for gettext
> (https://www.gnu.org/software/gettext/manual/html_node/Mark-Keywords.html).
> This would break it if there are existing translations, since the
> msgids change.

Right.  I will keep  inside _(...) as-is just in case
to not break gettext.




> More practically, I doubt anyone is translating these tools. IMO we
> should remove the gettext stuff unless we find traces of translations.

I agree.  Probably, it should not hurt to eliminate gettext,
but out of scope of this series.


>>                 exit(1);
>>         }
>>  }
>> @@ -565,7 +567,7 @@ int main(int ac, char **av)
>>                 }
>>         }
>>         if (ac == optind) {
>> -               printf(_("%s: Kconfig file missing\n"), av[0]);
>> +               fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
>>                 conf_usage(progname);
>>                 exit(1);
>>         }
>> @@ -590,9 +592,11 @@ int main(int ac, char **av)
>>                 if (!defconfig_file)
>>                         defconfig_file = conf_get_default_confname();
>>                 if (conf_read(defconfig_file)) {
>> -                       printf(_("***\n"
>> -                               "*** Can't find default configuration \"%s\"!\n"
>> -                               "***\n"), defconfig_file);
>> +                       fprintf(stderr,
>> +                               _("***\n"
>> +                                 "*** Can't find default configuration \"%s\"!\n"
>> +                                 "***\n"),
>> +                               defconfig_file);
>>                         exit(1);
>>                 }
>>                 break;
>> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
>> index 07e074d..0ba4900 100644
>> --- a/scripts/kconfig/zconf.l
>> +++ b/scripts/kconfig/zconf.l
>> @@ -184,7 +184,9 @@ n   [A-Za-z0-9_-]
>>                         append_string(yytext, 1);
>>         }
>>         \n      {
>> -               printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
>> +               fprintf(stderr,
>> +                       "%s:%d:warning: multi-line strings not supported\n",
>> +                       zconf_curname(), zconf_lineno());
>
> Whether stuff is translated seems inconsistent too.


Right.  Many people change the same tool, it is difficult to
keep the consistency.




>>                 current_file->lineno++;
>>                 BEGIN(INITIAL);
>>                 return T_EOL;
>> @@ -294,7 +296,7 @@ void zconf_initscan(const char *name)
>>  {
>>         yyin = zconf_fopen(name);
>>         if (!yyin) {
>> -               printf("can't find file %s\n", name);
>> +               fprintf(stderr, "can't find file %s\n", name);
>>                 exit(1);
>>         }
>>
>> @@ -315,8 +317,8 @@ void zconf_nextfile(const char *name)
>>         current_buf->state = YY_CURRENT_BUFFER;
>>         yyin = zconf_fopen(file->name);
>>         if (!yyin) {
>> -               printf("%s:%d: can't open file \"%s\"\n",
>> -                   zconf_curname(), zconf_lineno(), file->name);
>> +               fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
>> +                       zconf_curname(), zconf_lineno(), file->name);
>>                 exit(1);
>>         }
>>         yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
>> @@ -325,20 +327,21 @@ void zconf_nextfile(const char *name)
>>
>>         for (iter = current_file->parent; iter; iter = iter->parent ) {
>>                 if (!strcmp(current_file->name,iter->name) ) {
>> -                       printf("%s:%d: recursive inclusion detected. "
>> -                              "Inclusion path:\n  current file : '%s'\n",
>> -                              zconf_curname(), zconf_lineno(),
>> -                              zconf_curname());
>> +                       fprintf(stderr,
>> +                               "%s:%d: recursive inclusion detected. "
>> +                               "Inclusion path:\n  current file : '%s'\n",
>> +                               zconf_curname(), zconf_lineno(),
>> +                               zconf_curname());
>>                         iter = current_file->parent;
>>                         while (iter && \
>>                                strcmp(iter->name,current_file->name)) {
>> -                               printf("  included from: '%s:%d'\n",
>> -                                      iter->name, iter->lineno-1);
>> +                               fprintf(stderr, "  included from: '%s:%d'\n",
>> +                                       iter->name, iter->lineno-1);
>>                                 iter = iter->parent;
>>                         }
>>                         if (iter)
>> -                               printf("  included from: '%s:%d'\n",
>> -                                      iter->name, iter->lineno+1);
>> +                               fprintf(stderr, "  included from: '%s:%d'\n",
>> +                                       iter->name, iter->lineno+1);
>>                         exit(1);
>>                 }
>>         }
>> --
>> 2.7.4
>>
>
> The unrelated gettext stuff aside:
>
> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Cheers,
> Ulf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
