Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x226Xepm3omDagaLFr0G4/1f8iIMzrcLLltmAzLJkoIpm2yhLOz/0AtPcKA4luTFLx/qYvGBl
ARC-Seal: i=1; a=rsa-sha256; t=1519144286; cv=none;
        d=google.com; s=arc-20160816;
        b=nGI6gD+jy7YRBLV0ct/gp2Aaqb3AfeXK6RxgQk3LL1yRvXoV/pgbhYN8giOA2mKF8F
         /Z1fH3gON3/pKI1t/vMCukgzhFOqM8bxNNvVZVZL/d+GmkZkmgD4oAklavpa3wtvfPm3
         Z7i8bi9m4THypRFm2Z+eSHB4JsByv41t0KDnUBcMKBAin0UUbcj2IpA5w9vVSED/L8Ji
         heZVEOt2IGuDq7xjAVzzzHiypBWw7zJ8xCwEU3ZER+a1xRjFlsBWeB6eZxBb2hz5RP92
         7GG9r77F7PmC4ew7FRrAy7coKQCj0Z4Be+akr3Q8yjpPtZ9wWJOVdpJLtNO7XvL4qI4G
         xbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=mXBHay+ORCT+pVLT75Q/yVzvyY4kNO8g3cOgAYIPSq0=;
        b=S+JuJSIDY2xmU+gIN+ZS5IxHmeHbSCN/FAGw67hsiy4uqcnQeiREvOmnY7AOZDnREL
         kAktTPRIJHLYN1islJmX/BsQQsKwEeN94fkGqHwXws63zEdIDOytPAD4yqeG9JsazNTI
         AP9eVI2lt90CuriQOICRvSun5cooz7ZZImR/8zTNcuZkiYem1B4hYBiTvY0YaEHCpqIF
         uX36ph7+FCWshpxwUA+QLYuAkN9tL+NtyYImD/Sob0Dtp9mnnw0INl24UhrmLxjWFluh
         QOGuF2ORg6G4mfifHnCxVVmPUD1OifV+aetNYk+Krcy30JvwVAe3yYxV4v7GKoJWMIUg
         RWCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=FnIm0ino;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=FnIm0ino;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.82 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w1KGUqGN027254
X-Nifty-SrcIP: [209.85.217.173]
MIME-Version: 1.0
In-Reply-To: <1919455.eZKeABUfgV@blindfold>
References: <20180219092245.26404-1-richard@nod.at> <14335276.CH3Xr2i6I8@blindfold>
 <CAK7LNAQT8jEHt39xG7BvMMWjObdvCCpPhJAA83LFut4ewUVQsg@mail.gmail.com> <1919455.eZKeABUfgV@blindfold>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Feb 2018 01:30:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDG3TaMsSH__u9W_RmxcwrMZsrfn82L3Cf8Ec9N2jodg@mail.gmail.com>
Message-ID: <CAK7LNARDG3TaMsSH__u9W_RmxcwrMZsrfn82L3Cf8Ec9N2jodg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at,
        kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnaud Lacombe <lacombar@gmail.com>,
        Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>,
        Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592938239435061945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-21 1:16 GMT+09:00 Richard Weinberger <richard@nod.at>:
> Am Dienstag, 20. Februar 2018, 17:00:39 CET schrieb Masahiro Yamada:
>> 2018-02-21 0:25 GMT+09:00 Richard Weinberger <richard@nod.at>:
>> > Am Dienstag, 20. Februar 2018, 16:18:11 CET schrieb Masahiro Yamada:
>> >> 2018-02-19 18:22 GMT+09:00 Richard Weinberger <richard@nod.at>:
>> >> > Don't source the kernel config file in shell scripts.
>> >> > The config file is not a shell script and often imported from untrusted
>> >> > sources.
>> >> > What could possible go wrong? ;-)
>> >>
>> >> Please enumerate your real problems.
>> >
>> > Build a kernel where the .config contains something like:
>> > CONFIG_CMDLINE_BOOL=y
>> > CONFIG_CMDLINE="`echo hello > world`"
>>
>> Same for Makefile
>> if a string symbol is referenced from Makefile, like
>>
>> CONFIG_CROSS_COMPILE="$(shell echo hello > world)aarch64-linux-gnu-"
>
> Correct. But you forget that the .config file is often imported from untrusted
> sources. Like on LKML, "my kernel explodes, this is the .config".
> Jonny random Kernel developer then takes the .config and builds it...
>
>> > I'll send a v3 because I forgot to convert one function in the shell
>> > script to the new bash array. kbuild bot FTW. :-)
>>
>> You do not need to do so.
>
> Okay, let's wait until toxic .configs appear in the wild. ;-)
>
>> This patch is so ugly.
>>
>> Also, changed shell scripts have '#!/bin/sh' shebang,
>> but you are adding bash as a requirement.
>
> An alternate approach would be this:
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index 5c12dc91ef34..ff0a7c62344b 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -161,6 +161,13 @@ static int conf_set_sym_val(struct symbol *sym, int def,
> int def_flags, char *p)
>         case S_STRING:
>                 if (*p++ != '"')
>                         break;
> +
> +               p2 = strpbrk(p, "`$");
> +               if (p2 && !(p2[0] == '$' && p2[1] != '(')) {
> +                       conf_warning("string contains forbidden characters");
> +                       return 1;
> +               }
> +
>                 for (p2 = p; (p2 = strpbrk(p2, "\"\\")); p2++) {
>                         if (*p2 == '"') {
>                                 *p2 = 0;
>
> That way the conf tool will sanitize the .config before shell scripts will
> source it.


This approach seems better.




-- 
Best Regards
Masahiro Yamada
