Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD538C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A2C2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="t0teInFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A2C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbeGLCUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:20:45 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20815 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732787AbeGLCUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:20:45 -0400
Received: from mail-vk0-f52.google.com (mail-vk0-f52.google.com [209.85.213.52]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w6C2DQha029459;
        Thu, 12 Jul 2018 11:13:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w6C2DQha029459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531361607;
        bh=9hg9OpriGNGc5k6EpxfGpmhJIN4iUUjGMvxPTfQiHtE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=t0teInFK9FCIuZS0ZmLg1QhPSlus9u9KQmHn1T3UZ9Y5eUu8+619CKE/Im4BlXWMz
         YQ3gDvwcJI8JkWf9SsWIS/xlR6+1eBHyPssLDr1bhYM64P/Q9S/zS+xMxJHV/DZyDD
         e2CntpwMSvFv6KXMGPCPQJAIEnL8sjc7EtSSwb/FCmxvTrqaHOFKzQvAQ1g1ov57IO
         ogRWrxLCJgNMXSwg/wi47YI4j2OzJLbJtj4L3OHWxaGPfCVA1YSmR7W21Tiu74xIxQ
         akczHxhnWx5Qc3aV/EiF1v/HnOyR3V7DkPuZrrbaphP+UlIIAlpkBey8wnAdlFEgw+
         MiUZv2h7tdHSw==
X-Nifty-SrcIP: [209.85.213.52]
Received: by mail-vk0-f52.google.com with SMTP id 125-v6so15526991vke.11;
        Wed, 11 Jul 2018 19:13:27 -0700 (PDT)
X-Gm-Message-State: AOUpUlEsCBvyq3Srw1yhVaNqXf272dC2TAJHG2CT0cHNCr85ZzrmmPJM
        LdF+zWkw6pEwx+csrp/x71bHUoMsscDM8Y/ODlE=
X-Google-Smtp-Source: AAOMgpf5z+Gc9lVjIIso4OC2ojyDQKMLhEdxa157xsd5q2+ARvXkBVUxrmb2FCNdUzcgUeUpMVkFOlhMSS7m+bX9NbI=
X-Received: by 2002:a1f:88:: with SMTP id 130-v6mr175457vka.154.1531361605964;
 Wed, 11 Jul 2018 19:13:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 19:12:45
 -0700 (PDT)
In-Reply-To: <ghwou4prif.fsf@lena.gouders.net>
References: <1530758389-30862-1-git-send-email-yamada.masahiro@socionext.com>
 <1530758389-30862-6-git-send-email-yamada.masahiro@socionext.com>
 <ghva9simch.fsf@lena.gouders.net> <ghbmbk0wbj.fsf@quad.gouders.net> <ghwou4prif.fsf@lena.gouders.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 12 Jul 2018 11:12:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9WjCMVqtq1ivxOqNERVbnC5fQbzrPrGCfz0aAbk_DEQ@mail.gmail.com>
Message-ID: <CAK7LNAT9WjCMVqtq1ivxOqNERVbnC5fQbzrPrGCfz0aAbk_DEQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] kconfig: make syncconfig update .config
 regardless of sym_change_count
To:     Dirk Gouders <dirk@gouders.net>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-09 20:39 GMT+09:00 Dirk Gouders <dirk@gouders.net>:
> Dirk Gouders <dirk@gouders.net> writes:
>
>> Dirk Gouders <dirk@gouders.net> writes:
>>
>>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>
>>>> syncconfig updates the .config only when sym_change_count > 0, i.e.
>>>> any change in config symbols has been detected.
>>>>
>>>> Not only symbols but also comments are contained in the .config file.
>>>> If only comments are updated, they are not fed back to the .config,
>>>> then the stale comments are left-over.  Of course, this is just a
>>>> matter of comments, but why not fix it.
>>>
>>> Hello Masahiro,
>>>
>>> I am currently looking at and testing this series.
>>>
>>> First: For this patch I would suggest to also edit the syncconfig
>>>        section of "conf --help".
>>>
>>> Further, on a slow laptop, I was suspecting, this patch to cause full
>>> rebuilds of everything, each time I ran "make syncconfig" followed by
>>> "make" but could not verify this on another machine, so perhaps I am
>>> just (for testing purposes) removing the wrong files (modules.builtin
>>> for example) -- I am still testing.
>>>
>>> But, what irritates me with testing is that (also without your
>>> patches) two consecutive "make" produce different output, one of them
>>> always shows a warning and this is reproducable.  I just want to make
>>> sure there is no other problem that influences my testing:
>>>
>>> $ make
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND  objtool
>>>   CHK     include/generated/compile.h
>>>   DATAREL arch/x86/boot/compressed/vmlinux
>>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>>   Building modules, stage 2.
>>>   MODPOST 211 modules
>>>
>>> $ make
>>>   CALL    scripts/checksyscalls.sh
>>>   DESCEND  objtool
>>>   CHK     include/generated/compile.h
>>>   LD      arch/x86/boot/compressed/vmlinux
>>> ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
>>> ld: warning: creating a DT_TEXTREL in object.
>>>   ZOFFSET arch/x86/boot/zoffset.h
>>>   AS      arch/x86/boot/header.o
>>>   LD      arch/x86/boot/setup.elf
>>>   OBJCOPY arch/x86/boot/setup.bin
>>>   OBJCOPY arch/x86/boot/vmlinux.bin
>>>   BUILD   arch/x86/boot/bzImage
>>> Setup is 15580 bytes (padded to 15872 bytes).
>>> System is 8069 kB
>>> CRC e01d75ec
>>> Kernel: arch/x86/boot/bzImage is ready  (#15)
>>>   Building modules, stage 2.
>>>   MODPOST 211 modules
>>
>> I spent some more time with the behaviour described above and bisected
>> to the commit after that two consecutive invocations of "make" (on an
>> already compiled tree) seem to do different things.  That commit is
>> 98f78525371b55cc (x86/boot: Refuse to build with data relocations), so I
>> put Kees and Ingo on CC.
>>
>> I did the bisecting on another system, so I'll provide the output of two
>> consecutive "make" on an already compiled tree on that machine:
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   DATAREL arch/x86/boot/compressed/vmlinux
>> Kernel: arch/x86/boot/bzImage is ready  (#48)
>>   Building modules, stage 2.
>>   MODPOST 165 modules
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>>   LD      arch/x86/boot/compressed/vmlinux
>>   ZOFFSET arch/x86/boot/zoffset.h
>>   AS      arch/x86/boot/header.o
>>   LD      arch/x86/boot/setup.elf
>>   OBJCOPY arch/x86/boot/setup.bin
>>   OBJCOPY arch/x86/boot/vmlinux.bin
>>   BUILD   arch/x86/boot/bzImage
>> Setup is 15644 bytes (padded to 15872 bytes).
>> System is 6663 kB
>> CRC 3eb90f40
>> Kernel: arch/x86/boot/bzImage is ready  (#48)
>>   Building modules, stage 2.
>>   MODPOST 165 modules
>>
>> If I comment out $(call if_changed,check_data_rel) in
>> arch/x86/boot/compressed/Makefile, two consecutive "make" produce
>> identical output i.e. seem to not do different things:
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>> Kernel: arch/x86/boot/bzImage is ready  (#49)
>>   Building modules, stage 2.
>>   MODPOST 165 modules
>>
>> $ make
>>   CALL    scripts/checksyscalls.sh
>>   DESCEND  objtool
>>   CHK     include/generated/compile.h
>> Kernel: arch/x86/boot/bzImage is ready  (#49)
>>   Building modules, stage 2.
>>   MODPOST 165 modules
>>
>> So, I guess this different behaviour of two consecutive "make" is not
>> intentional but I am failing to understand why it happens.
>
> I think, I solved the puzzle and perhaps, that saves others some time:
>
> The problem is that "if_changed" was not designed for multiple use
> inside a recipe and in the case of compressed/vmlinux, the 2-fold use
> created a kind of flip-flop for situations when nothing has to be done
> to build the target.
>
> Because each of the two users of "if_changed" stores it's footprint in
> .vmlinux.cmd but that file then isn't re-read, one of the two
> "if_changed" calculates that nothing has to be done wheras the other one
> recognizes a change in the commandline, because it sees the command-line
> for the other part of the reciepe.
>
> In the next make, the roles flip, because the previously satisfied
> "if_changed" now sees the command-line of the other one.  And so on...
>
> I am not a Kbuild expert but the attached patch fixes that problem by
> introducing "if_changed_multi" that accepts two commands -- one whose
> commandline should be checked and a second one that should be
> executed.


if_changed should not appear multiple times in one target.


I think the simplest fix-up is to
create a new command that combines
'cmd_check_data_rel' and 'cmd_ld'.


quiet_cmd_link-vmlinux = LD      $@
      cmd_link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)

$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
        $(call if_changed,link-vmlinux)




Kbuild also supports if_changed_rule,
but the usage is more complex.

There are only a few usages:
https://github.com/torvalds/linux/blob/v4.17/scripts/Makefile.build#L288






> Dirk
>
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index fa42f895fdde..f39822fca994 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -107,8 +107,8 @@ define cmd_check_data_rel
>  endef
>
>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
> -       $(call if_changed,check_data_rel)
> -       $(call if_changed,ld)
> +       $(call if_changed_multi,ld,check_data_rel)
> +       $(call if_changed_multi,ld,ld)
>
>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>  $(obj)/vmlinux.bin: vmlinux FORCE
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index b2d14f1136e8..3bf419319e09 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -265,6 +265,23 @@ if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
>         $(echo-cmd) $(cmd_$(1));                                             \
>         printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
>
> +# echo command for command stored in $2
> +# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
> +echo-cmd2 = $(if $($(quiet)cmd_$(2)),\
> +       echo '  $(call escsq,$($(quiet)cmd_$(2)))$(echo-why)';)
> +
> +# Execute command arg2 if commandline for command arg1 or prerequisite(s) are
> +# updated.
> +#
> +# This is safe for multiple use inside a recipe; arg1 and arg2 may be
> +# identical.
> +if_changed_multi = $(if $(strip $(any-prereq) $(arg-check)),                \
> +       @set -e;                                                             \
> +       $(echo-cmd2) : ; \
> +       $(cmd_$(2));                                            \
> +       printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
> +
> +
>  # Execute the command and also postprocess generated .d dependencies file.
>  if_changed_dep = $(if $(strip $(any-prereq) $(arg-check) ),                  \
>         @set -e;                                                             \
>



-- 
Best Regards
Masahiro Yamada
