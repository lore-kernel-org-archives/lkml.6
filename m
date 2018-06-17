Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFE3C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 661942083D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 00:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NBynSE/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661942083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756976AbeFQAlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 20:41:55 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:55506 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756930AbeFQAlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 20:41:53 -0400
Received: from mail-vk0-f51.google.com (mail-vk0-f51.google.com [209.85.213.51]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w5H0fcGQ024414;
        Sun, 17 Jun 2018 09:41:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w5H0fcGQ024414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1529196099;
        bh=L1XxTZ17u5DlPCiiIdrQqbheU5wxlgVVIP0uWteZBqI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=NBynSE/GGY4MV4rqbHowMcD5gmHiInaI/jUCa6wHzlcBqwQV9yU1L0568YZGPQwKB
         1R6efS1DAAPeg0WA2Kfr1q0l/JcMHAsJKzeLNax/LbXBzl/jmWqelbZkkozO+Z8BTr
         hZXV4JNHoeTxRtElsizuIVSrb4iY4sxuwMz+p/bYr30q02CU+mI+QK5QeEoYd3pTSH
         3kQcXtlYIP4vIcmyclJu0yYJiLPyKXQ0XxYY6ModzAlq8h7xCmMam7K2feM902UnAr
         UebQ/OZnbktC2HTsQ2b2iOPUzInNTuIRhLtDRRlZjHjkP+Hko07KldH5hHa9citBhm
         B4vYj/mzlOp3g==
X-Nifty-SrcIP: [209.85.213.51]
Received: by mail-vk0-f51.google.com with SMTP id b134-v6so7626908vke.13;
        Sat, 16 Jun 2018 17:41:39 -0700 (PDT)
X-Gm-Message-State: APt69E37u+vmztmhwItf/gNSkMeBEm8bqNCCfjkuAdsR2Z/4bWa+kP0r
        Y1sVtQMaD/ZOwi3qN7be625uOw8+oDCbGlkxwz0=
X-Google-Smtp-Source: ADUXVKIFL5VsuV1ZDuyJxLRqKACVjmdAGJoXOwd5ZRH2Ay84aoyY77YvUkxD076Hb2PrT573mv1XG6a0Fv0qYIzOf7E=
X-Received: by 2002:a1f:2348:: with SMTP id j69-v6mr4174985vkj.160.1529196097886;
 Sat, 16 Jun 2018 17:41:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:20ab:0:0:0:0:0 with HTTP; Sat, 16 Jun 2018 17:40:56
 -0700 (PDT)
In-Reply-To: <D9AF0864-EE2A-4C2E-A5A4-C002DEB95B2B@vmware.com>
References: <20180612115050.185112-1-namit@vmware.com> <20180612115050.185112-2-namit@vmware.com>
 <CAK7LNATmjTi4Odp5AfbVHCemn7S_tB9nKvgNOf5sp8BiVJma7Q@mail.gmail.com> <D9AF0864-EE2A-4C2E-A5A4-C002DEB95B2B@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 17 Jun 2018 09:40:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdmie+Y4haU5bCMb8s4RztHzOcFXUxGxjcCqsbwPN7uw@mail.gmail.com>
Message-ID: <CAK7LNASdmie+Y4haU5bCMb8s4RztHzOcFXUxGxjcCqsbwPN7uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] Makefile: Prepare for using macros for inline asm
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

2018-06-14 7:19 GMT+09:00 Nadav Amit <namit@vmware.com>:
>>
>>
>> I have not fully understood this series yet.
>>
>> I do not have enough skill in x86 architecture,
>> but just some comments from the build system point of view.
>>
>>
>>
>> I guess this will probably break the parallel building.
>>
>> Kbuild can build 'prepare' and 'scripts' simultaneously.
>>
>>
>> I locally modified the following line:
>>
>>
>> diff --git a/Makefile b/Makefile
>> index 2dea909440..6ad484a 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1030,7 +1030,7 @@ $(sort $(vmlinux-deps)): $(vmlinux-dirs) ;
>> # Error messages still appears in the original language
>>
>> PHONY += $(vmlinux-dirs)
>> -$(vmlinux-dirs): prepare scripts
>> +$(vmlinux-dirs): scripts prepare
>>        $(Q)$(MAKE) $(build)=$@ need-builtin=1
>>
>> define filechk_kernel.release
>>
>>
>>
>> masahiro@grover:~/workspace/linux-kbuild$ make  defconfig
>>  HOSTCC  scripts/basic/fixdep
>>  HOSTCC  scripts/kconfig/conf.o
>>  YACC    scripts/kconfig/zconf.tab.c
>>  LEX     scripts/kconfig/zconf.lex.c
>>  HOSTCC  scripts/kconfig/zconf.tab.o
>>  HOSTLD  scripts/kconfig/conf
>> *** Default configuration is based on 'x86_64_defconfig'
>> #
>> # configuration written to .config
>> #
>> masahiro@grover:~/workspace/linux-kbuild$ make all
>> scripts/kconfig/conf  --syncconfig Kconfig
>>  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>>  WRAP    arch/x86/include/generated/uapi/asm/poll.h
>>  WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>>  WRAP    arch/x86/include/generated/asm/early_ioremap.h
>>  WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>>  WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>>  CC      scripts/mod/empty.o
>> Assembler messages:
>> Error: can't open arch/x86/kernel/macros.s for reading: No such file
>> or directory
>> make[2]: *** [scripts/Makefile.build:318: scripts/mod/empty.o] Error 1
>> make[1]: *** [scripts/Makefile.build:558: scripts/mod] Error 2
>> make: *** [Makefile:1050: scripts] Error 2
>
> You are right. I tried to filter out the use of the switch (exported as
> ASM_MACRO_FLAGS) for empty.o. Any suggestions on how to do it properly?


You can do like this:


diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 42c5d50..a5b4af4 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,6 +4,8 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y    := modpost mk_elfconfig
 always         := $(hostprogs-y) empty.o

+CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
+
 modpost-objs   := modpost.o file2alias.o sumversion.o

 devicetable-offsets-file := devicetable-offsets.h





modpost is an exceptional hostprogam - it depends on
target compiler, which makes the build order complicated.

I want to compile under scripts/ only with $(HOSTCC).

I am planning to change modpost
target-independent by detecting
32/64 bit, little/big-endianness run-time.
Then, empty.c will go away.


In the meanwhile, CFLAGS_REMOVE_ will do
as a workaround.


-- 
Best Regards
Masahiro Yamada
