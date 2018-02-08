Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518055357; cv=none;
        d=google.com; s=arc-20160816;
        b=YJLfd3y8aeZp2p5raybQ3KLV9vZOvDtuBqsneBTby9YvTneWnajiwwQe5l32uuerMU
         crg4kDcgP7SB0rX9p5LWhnscWVWXylYOCJDJ7ch9hBVSBJ3+Bw4drSSVzhO7r8B8Q9IV
         rbM46DK6A8cawSksQvjgs9vUyrvty5210Pn05w9CJtqMyq7VcxRb1TfypOM/p6z4B4vl
         ZWoZ9BSzGEPipdp8c6c0HZIYJ/lZ9oUrmR5QtTLS9/tLvnGR3j7+kUmnmPXsQtoy5JeZ
         +URknhXjeY33Lu3jXLK+jvIPFcwpnCl57/FNDV/vOiVYtJCzCvUI7+i4DOaBBkd7yfWO
         +Fgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CMkL/dkrblrfioNSwlNYuKNfTkkc+C9pVt6ijV4CZPc=;
        b=XflW+f0NNZ36N4MNDCt22S1JlWZY9zYEVNrV2BTlzydi6DyKCQROzXjM1QS5Fn/GCM
         rH2USws4/I7U59I+aUczQJ6esX9GmXq8eISFX80GJacnw6fdFQF32uvwyvKBGCrjBvNy
         oYrEDN+xPpThKjNRV/RpggBEIrzJ4tMPx5CgYLoAXz7Djh620wigxfxEN734QflDZS89
         cjLdJORxbELbrIn62G8jXqXesbioFMrAnpCnW5zzRKBARjLLN60yURY03SBU86Oioyyz
         dWdkz1X7gtf7TLRkNnTJQRbbpHQ+JaFFnFvRJhInyjNOGl+0r/oI2IC9gba5j8VKxJ1G
         9Rgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ImTbFKff;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ImTbFKff;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224i1lR6RQsf9X2AyN/TEMOjRquyl1vv5vl+/4KI6Fhzgezg8N9VzAVyjUDL9pOiGy6lM9yZhGaXHlx0tLOZq5o=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASr5yJ8HY8vRye12UyV7rcx_N=4Abz8fz9AQDh4y8TsYg@mail.gmail.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com>
 <1517877294-4826-2-git-send-email-yamada.masahiro@socionext.com>
 <CAFkk2KQNQV2GAXW+hyMvE+J5mMp+5g3SuYdcGA-JjGk5fE=VUA@mail.gmail.com> <CAK7LNASr5yJ8HY8vRye12UyV7rcx_N=4Abz8fz9AQDh4y8TsYg@mail.gmail.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 03:02:36 +0100
Message-ID: <CAFkk2KQ4K8k3HBpadC0nSq4eM8gt9ZNhGBetAcofMeY32opTCQ@mail.gmail.com>
Subject: Re: [PATCH 01/14] kconfig: send error messages to stderr
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Marc Herbert <marc.herbert@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609778719993235?=
X-GMAIL-MSGID: =?utf-8?q?1591796414452915993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 2:49 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-02-08 5:24 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
>> On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
>> <yamada.masahiro@socionext.com> wrote:
>>> These messages should be directed to stderr.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  scripts/kconfig/conf.c  | 18 +++++++++++-------
>>>  scripts/kconfig/zconf.l | 27 +++++++++++++++------------
>>>  2 files changed, 26 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/scripts/kconfig/conf.c b/scripts/kconfig/conf.c
>>> index 307bc3f..90a76aa2 100644
>>> --- a/scripts/kconfig/conf.c
>>> +++ b/scripts/kconfig/conf.c
>>> @@ -75,9 +75,11 @@ static void strip(char *str)
>>>  static void check_stdin(void)
>>>  {
>>>         if (!valid_stdin) {
>>> -               printf(_("aborted!\n\n"));
>>> -               printf(_("Console input/output is redirected. "));
>>> -               printf(_("Run 'make oldconfig' to update configuration.\n\n"));
>>> +               fprintf(stderr,
>>> +                       _("Aborted!\n"
>>> +                         "Console input/output is redirected.\n"
>>> +                         "Run 'make oldconfig' to update configuration.\n\n")
>>> +                       );
>>
>> This could use fputs() too, moving the stderr to the last argument.
>
>
> In general, I am not keen on replacement of (f)printf with (f)puts.
>
> If '%' does not appear in the format literal, compiler will automatically
> replace the function call with a faster one.
>
> My compiler replaced both fprintf(stderr, "blah\n") and fputs("blah\n", stderr)
> with fwrite.
>
> At this moment, right, the compiler cannot optimize it
> because it never knows the result of _(...).
>
> If we rip off the gettext things, it will be optimized.

No problem with me. Just some personal OCD. :)

>
>
>
>> I think the _() thingies around the strings are for gettext
>> (https://www.gnu.org/software/gettext/manual/html_node/Mark-Keywords.html).
>> This would break it if there are existing translations, since the
>> msgids change.
>
> Right.  I will keep  inside _(...) as-is just in case
> to not break gettext.
>
>
>
>
>> More practically, I doubt anyone is translating these tools. IMO we
>> should remove the gettext stuff unless we find traces of translations.
>
> I agree.  Probably, it should not hurt to eliminate gettext,
> but out of scope of this series.

Yeah, out of scope.

>
>
>>>                 exit(1);
>>>         }
>>>  }
>>> @@ -565,7 +567,7 @@ int main(int ac, char **av)
>>>                 }
>>>         }
>>>         if (ac == optind) {
>>> -               printf(_("%s: Kconfig file missing\n"), av[0]);
>>> +               fprintf(stderr, _("%s: Kconfig file missing\n"), av[0]);
>>>                 conf_usage(progname);
>>>                 exit(1);
>>>         }
>>> @@ -590,9 +592,11 @@ int main(int ac, char **av)
>>>                 if (!defconfig_file)
>>>                         defconfig_file = conf_get_default_confname();
>>>                 if (conf_read(defconfig_file)) {
>>> -                       printf(_("***\n"
>>> -                               "*** Can't find default configuration \"%s\"!\n"
>>> -                               "***\n"), defconfig_file);
>>> +                       fprintf(stderr,
>>> +                               _("***\n"
>>> +                                 "*** Can't find default configuration \"%s\"!\n"
>>> +                                 "***\n"),
>>> +                               defconfig_file);
>>>                         exit(1);
>>>                 }
>>>                 break;
>>> diff --git a/scripts/kconfig/zconf.l b/scripts/kconfig/zconf.l
>>> index 07e074d..0ba4900 100644
>>> --- a/scripts/kconfig/zconf.l
>>> +++ b/scripts/kconfig/zconf.l
>>> @@ -184,7 +184,9 @@ n   [A-Za-z0-9_-]
>>>                         append_string(yytext, 1);
>>>         }
>>>         \n      {
>>> -               printf("%s:%d:warning: multi-line strings not supported\n", zconf_curname(), zconf_lineno());
>>> +               fprintf(stderr,
>>> +                       "%s:%d:warning: multi-line strings not supported\n",
>>> +                       zconf_curname(), zconf_lineno());
>>
>> Whether stuff is translated seems inconsistent too.
>
>
> Right.  Many people change the same tool, it is difficult to
> keep the consistency.
>
>
>
>
>>>                 current_file->lineno++;
>>>                 BEGIN(INITIAL);
>>>                 return T_EOL;
>>> @@ -294,7 +296,7 @@ void zconf_initscan(const char *name)
>>>  {
>>>         yyin = zconf_fopen(name);
>>>         if (!yyin) {
>>> -               printf("can't find file %s\n", name);
>>> +               fprintf(stderr, "can't find file %s\n", name);
>>>                 exit(1);
>>>         }
>>>
>>> @@ -315,8 +317,8 @@ void zconf_nextfile(const char *name)
>>>         current_buf->state = YY_CURRENT_BUFFER;
>>>         yyin = zconf_fopen(file->name);
>>>         if (!yyin) {
>>> -               printf("%s:%d: can't open file \"%s\"\n",
>>> -                   zconf_curname(), zconf_lineno(), file->name);
>>> +               fprintf(stderr, "%s:%d: can't open file \"%s\"\n",
>>> +                       zconf_curname(), zconf_lineno(), file->name);
>>>                 exit(1);
>>>         }
>>>         yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
>>> @@ -325,20 +327,21 @@ void zconf_nextfile(const char *name)
>>>
>>>         for (iter = current_file->parent; iter; iter = iter->parent ) {
>>>                 if (!strcmp(current_file->name,iter->name) ) {
>>> -                       printf("%s:%d: recursive inclusion detected. "
>>> -                              "Inclusion path:\n  current file : '%s'\n",
>>> -                              zconf_curname(), zconf_lineno(),
>>> -                              zconf_curname());
>>> +                       fprintf(stderr,
>>> +                               "%s:%d: recursive inclusion detected. "
>>> +                               "Inclusion path:\n  current file : '%s'\n",
>>> +                               zconf_curname(), zconf_lineno(),
>>> +                               zconf_curname());
>>>                         iter = current_file->parent;
>>>                         while (iter && \
>>>                                strcmp(iter->name,current_file->name)) {
>>> -                               printf("  included from: '%s:%d'\n",
>>> -                                      iter->name, iter->lineno-1);
>>> +                               fprintf(stderr, "  included from: '%s:%d'\n",
>>> +                                       iter->name, iter->lineno-1);
>>>                                 iter = iter->parent;
>>>                         }
>>>                         if (iter)
>>> -                               printf("  included from: '%s:%d'\n",
>>> -                                      iter->name, iter->lineno+1);
>>> +                               fprintf(stderr, "  included from: '%s:%d'\n",
>>> +                                       iter->name, iter->lineno+1);
>>>                         exit(1);
>>>                 }
>>>         }
>>> --
>>> 2.7.4
>>>
>>
>> The unrelated gettext stuff aside:
>>
>> Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
>>
>> Cheers,
>> Ulf
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Best Regards
> Masahiro Yamada

Cheers,
Ulf
