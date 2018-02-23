Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x224eU50GVcyPf2wHmj9Wb96DovNAu0p0+yGmPFCtG4HQCXJejq+hZQq+ocfBsGZzcdJfK0Xy
ARC-Seal: i=1; a=rsa-sha256; t=1519359258; cv=none;
        d=google.com; s=arc-20160816;
        b=XJikfKuE96gD5qV+1kqUyj1h4ssPY8Ty64SxLpkv8L1CVQa0/ILlOsvpXBW/UlLYAa
         MSZXVp33u3e/GpgtElj9EzDBWf3zVyqjsslYRVoN5Y2IjpCfTD/EdAw/EmC+v9UiFSbP
         eCrCOLEQNLIZTpMPkRcQ1crE2fuaLglIkspp9D1r71aTA4bSYftDIeotzgy1dwF2r0+d
         xU2AS+dbYCSIuRI/LJSf36UFIsLFiMteuhXYlZXK7bR6+fmQaKxVd9fj4OZihRHilfS8
         9rZhRTZh0MRVcrXmg+1/MDHaCQ72d/Cmt/SQwlI3zxLd0Hgvv7LS8/eXRGvL14IKiXgm
         G7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=YPc/9tw76OX/Df3ykfNT3CmFibgPZdigU6g5FuIjFOE=;
        b=Svlwmxd4Wh032hOeGv38gtR/8q2HC/2NRDYGrs9gQQxQciussKgyy2UjVqtu+33XZZ
         7/kpmMmmXwtbigeodrNldsUYij9mS+ZW1dB31xtQXbGS+M+9bTMklSia98cQasqk5lty
         jzmZC+Yz0gRtQI26qLbxEtJoZbaRDthAT35znPPpNEuu3zXeaT+imdgWGCvxmaRvA/uu
         CN4dgRHT9+Hv66PWxDYT5MurJKCWOCG5s4ffozVM03SP+kJ/qmJADThYDArEJo3T5OQY
         n+x9t3CqnXNuhA384wqv/nNa/DIgIBVhWcvcePCQuexLWNM6I/sHDlD33DjpXve/HSKn
         Oa9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mwsjx9mV;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mwsjx9mV;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w1N4Dkdw032245
X-Nifty-SrcIP: [209.85.217.176]
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1bRC5EwXJ8=xcaZqf5c7=8h12spJ1XCf1NFvCS-7qDnw@mail.gmail.com>
References: <20180216214117.1947175-1-arnd@arndb.de> <20180216214117.1947175-3-arnd@arndb.de>
 <CAK7LNARvbsMc3JpcxZjvmc3UjvACx3t66cLM_aSDcADiPA0V7g@mail.gmail.com>
 <CAK8P3a0DAu1q3jLMN=JjrNAd4a4UVFcEcLF2h1VgSvXjZsU++g@mail.gmail.com>
 <CAK7LNAR2GO21TMP=viR1sni_17zFZ+03TUh8pak1etVYEF8kTQ@mail.gmail.com> <CAK8P3a1bRC5EwXJ8=xcaZqf5c7=8h12spJ1XCf1NFvCS-7qDnw@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Feb 2018 13:13:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARivyj9O-a2AupMjanmqjUZwRP8E5EH6AMLL7_Q9Y8zZA@mail.gmail.com>
Message-ID: <CAK7LNARivyj9O-a2AupMjanmqjUZwRP8E5EH6AMLL7_Q9Y8zZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] Kconfig: improve handling for all{rand,yes,no,}.config
 fragments
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "Yann E. MORIN" <yann.morin.1998@free.fr>,
        Michal Marek <mmarek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592595410017482900?=
X-GMAIL-MSGID: =?utf-8?q?1593163653311586095?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-22 1:57 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tue, Feb 20, 2018 at 6:04 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2018-02-20 18:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>> On Tue, Feb 20, 2018 at 10:26 AM, Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>> 2018-02-17 6:41 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>>>
>>>>> @@ -621,14 +622,24 @@ int main(int ac, char **av)
>>>>>                 case randconfig:        name = "allrandom.config"; break;
>>>>>                 default: break;
>>>>>                 }
>>>>> -               if (conf_read_simple(name, S_DEF_USER) &&
>>>>> -                   conf_read_simple("all.config", S_DEF_USER)) {
>>>>> -                       fprintf(stderr,
>>>>> -                               _("*** KCONFIG_ALLCONFIG set, but no \"%s\" or \"all.config\" file found\n"),
>>>>> -                               name);
>>>>> -                       exit(1);
>>>>> +               /* try ./name, arch/$(ARCH)/configs/name and kernel/config/name */
>>>>> +               if (!conf_read_simple(name, S_DEF_USER))
>>>>> +                       break;
>>>>> +               arch = getenv("ARCH");
>>>>> +               if (arch) {
>>>>> +                       snprintf(fullname, sizeof(fullname), "arch/%s/configs/%s",
>>>>> +                                arch, name);
>>>>> +                       if (!conf_read_simple(fullname, S_DEF_USER))
>>>>> +                               break;
>>>>>                 }
>>>>
>>>>
>>>> I am not a big fan of hard-coding the kernel directory structure.
>>>>
>>>> We already do this [1], but I am thinking of kicking this out.
>>>> [1] https://github.com/torvalds/linux/blob/v4.16-rc1/scripts/kconfig/confdata.c#L33
>>>
>>> Ok, I see. How about adding a way to detect that we are build-testing
>>> with randconfig instead?
>>
>>
>> How about implementing something in scripts/kconfig/Makefile?
>>
>> merge_config collects config fragments into 'configfiles'
>>
>> I was thinking of a similar thing.
>>
>>
>> If KCONFIG_ALLCONFIG is 1,
>> scripts/kconfig/Makefile searches
>> './', '$srctree/', 'arch/$(SRCARCH)/configs/', 'kernel/configs/'
>> and sets the found file in it,
>>
>> If KCONFIG_ALLCONFIG already contains a file name, it is used as-is.
>>
>> scripts/kconfig/conf.c will be simplified.
>
> Yes, good idea. I'm struggling a bit with the implementation (fitting
> it into the
> simple-tagets rule), can you come up with a prototype?


Just a prototype for the Makefile part.
(We need to agree with the search order specification, though)


------------>8-------------
configs_dirs := $(srctree)/kernel/configs/ $(srctree)/arch/$(SRCARCH)/configs/

allconfig_files = $(if $(filter 1, $(KCONFIG_ALLCONFIG)),$(firstword \
        $(foreach f, $(1), $(wildcard $(addsuffix $(f), ./ $(srctree)/))) \
        $(foreach f, $(1), $(subst $(space),$(comma),$(wildcard
$(addsuffix $(f), $(configs_dirs)))))), \
        $(KCONFIG_ALLCONFIG))

allyesconfig: override KCONFIG_ALLCONFIG := $(call allconfig_files,
allyes.config all.config)
allmodconfig: override KCONFIG_ALLCONFIG := $(call allconfig_files,
allmoyes.config all.config)
 (likewise for allnoconfig, alldefconfig)
randconfig: override KCONFIG_ALLCONFIG := $(call allconfig_files,
allrandom.config all.config)
------------->8-----------


If a user specifies a file path in KCONFIG_ALLCONFIG, it is used as-is.

IF KCONFIG_ALLCONFIG=1, the input file is searched in the following order.
( [1] - [4] is the same as the current specification)

[1] ./allrandom.config
[2] $(srctree)/allrandom.config
[3] ./all.config
[4] $(srctree)/all.config
[5] $(srctree)/kernel/configs/allrandom.config +
$(srctree)/arch/$(SRCARCH)/configs/allrandom.config
[6] $(srctree)/kernel/configs/all.config +
$(srctree)/arch/$(SRCARCH)/configs/all.config

For [5] and [6], if multiple files are found, KCONFIG_ALLCONFIG
is set to comma-separated file paths.

scripts/kconfig/conf.c must be tweaked a little bit
if we need to read multiple config fragments.

Currently, tinyconfig for x86 comes from common part and arch-specific part.
./kernel/configs/tiny.config
./arch/x86/configs/tiny.config


What do you think?







> We also need to decide what happens when e.g. both a ./all.config and
> arch/${SRCARCH}/configs/allrand.config file exist, should the first path
> take precedence or the more specific file?
>



-- 
Best Regards
Masahiro Yamada
