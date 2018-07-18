Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76DBECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0CF20693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lGNZJ+/a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0CF20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbeGRCWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:22:10 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:20322 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731151AbeGRCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:22:10 -0400
Received: from mail-ua0-f169.google.com (mail-ua0-f169.google.com [209.85.217.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w6I1kfWW007955;
        Wed, 18 Jul 2018 10:46:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w6I1kfWW007955
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531878402;
        bh=0owLTkB85CI57Ombt+bd+OqIjL7cTUdiRo0I8caHz6g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lGNZJ+/a7pgxucwskf32WmiJDQfHwe2cj004ZxqrSreMfVnd5tOBROQ+5/OpW/sK4
         uzstJN/8i6RXZ4o2Eh+yjlmOMnaZ/5GQ4FIJ/L2olF4gQGpCfwd2V4UMdfKKORYAti
         cYuUtQet6dvATw2VQd1nDe8AIsaJ40U2SLN/idrplBPZ7CSJMvJZxXyXov9SmH3e60
         GyfhB2hVypFJYnOAYytu/Nu64pVbPBGUOFj2VVyHRD/8b3J0DP5Hsnu/rjhCcKxZ/4
         1LiReygRkgt6rL/8gbIJ0p/COCk39Zz2SyA0Ni1g8VcwXLvuUzcm3kENL460YzJe5W
         FJLTNykmEWLEA==
X-Nifty-SrcIP: [209.85.217.169]
Received: by mail-ua0-f169.google.com with SMTP id y10-v6so1940721uao.4;
        Tue, 17 Jul 2018 18:46:42 -0700 (PDT)
X-Gm-Message-State: AOUpUlHLiMuiJTUoR9IjGAN4XgdOxgmDU6g4QXgHcsjtEVVPq71QcbPK
        MkhahJyb7Ivccul9Z1ej0ScWFx1DLvSratx6wQs=
X-Google-Smtp-Source: AAOMgpeG8i0fU44I1rj6FYztbIaMW6cedSoWWdT4nGxfy/2jbZo5crTVV1wpUXWF7J4TeHqf9LxGKzagm6hx/xL4HAw=
X-Received: by 2002:ab0:4705:: with SMTP id h5-v6mr2691341uac.140.1531878401153;
 Tue, 17 Jul 2018 18:46:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3308:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 18:46:00
 -0700 (PDT)
In-Reply-To: <20180622172212.199633-2-namit@vmware.com>
References: <20180622172212.199633-1-namit@vmware.com> <20180622172212.199633-2-namit@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 18 Jul 2018 10:46:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNASaZd9fupgu4vxc6+tnCnNMdrCi7LTwS56K1LaKODoCtA@mail.gmail.com>
Message-ID: <CAK7LNASaZd9fupgu4vxc6+tnCnNMdrCi7LTwS56K1LaKODoCtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] Makefile: Prepare for using macros for inline asm
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
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

2018-06-23 2:22 GMT+09:00 Nadav Amit <namit@vmware.com>:
> Using macros for inline assembly improves both readability and
> compilation decisions that are distorted by big assembly blocks that use
> alternative sections. Compile macros.S and use it to assemble all C
> files. Currently, only x86 will use it.
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---



Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>




>  Makefile                 |  9 +++++++--
>  arch/x86/Makefile        | 11 +++++++++--
>  arch/x86/kernel/macros.S |  7 +++++++
>  scripts/Kbuild.include   |  4 +++-
>  scripts/mod/Makefile     |  2 ++
>  5 files changed, 28 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/kernel/macros.S
>
> diff --git a/Makefile b/Makefile
> index ca2af1ab91eb..66c1da72c156 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1056,7 +1056,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
>  # version.h and scripts_basic is processed / created.
>
>  # Listed in dependency order
> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> @@ -1080,7 +1080,9 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
>                     include/config/auto.conf
>         $(cmd_crmodverdir)
>
> -archprepare: archheaders archscripts prepare1 scripts_basic
> +macroprepare: prepare1 archmacros
> +
> +archprepare: archheaders archscripts macroprepare scripts_basic
>
>  prepare0: archprepare gcc-plugins
>         $(Q)$(MAKE) $(build)=.
> @@ -1148,6 +1150,9 @@ archheaders:
>  PHONY += archscripts
>  archscripts:
>
> +PHONY += archmacros
> +archmacros:
> +
>  PHONY += __headers
>  __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
>         $(Q)$(MAKE) $(build)=scripts build_unifdef
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index f0a6ea22429d..363c3d8ed964 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -235,8 +235,8 @@ ifdef CONFIG_X86_64
>  LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
>  endif
>
> -# Speed up the build
> -KBUILD_CFLAGS += -pipe
> +# We cannot use -pipe flag since we give an additional .s file to the compiler
> +#KBUILD_CFLAGS += -pipe
>  # Workaround for a gcc prelease that unfortunately was shipped in a suse release
>  KBUILD_CFLAGS += -Wno-sign-compare
>  #
> @@ -258,11 +258,18 @@ archscripts: scripts_basic
>  archheaders:
>         $(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
>
> +archmacros:
> +       $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> +
>  archprepare:
>  ifeq ($(CONFIG_KEXEC_FILE),y)
>         $(Q)$(MAKE) $(build)=arch/x86/purgatory arch/x86/purgatory/kexec-purgatory.c
>  endif
>
> +ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
> +export ASM_MACRO_FLAGS
> +KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
> +
>  ###
>  # Kernel objects
>
> diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
> new file mode 100644
> index 000000000000..cfc1c7d1a6eb
> --- /dev/null
> +++ b/arch/x86/kernel/macros.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file includes headers whose assembly part includes macros which are
> + * commonly used. The macros are precompiled into assmebly file which is later
> + * assembled together with each compiled file.
> + */
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index c8156d61678c..8eeb5636a2a7 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -115,7 +115,9 @@ __cc-option = $(call try-run,\
>
>  # Do not attempt to build with gcc plugins during cc-option tests.
>  # (And this uses delayed resolution so the flags will be up to date.)
> -CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
> +# In addition, do not include the asm macros which are built later.
> +CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
> +CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
>
>  # cc-option
>  # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
> diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
> index 42c5d50f2bcc..a5b4af47987a 100644
> --- a/scripts/mod/Makefile
> +++ b/scripts/mod/Makefile
> @@ -4,6 +4,8 @@ OBJECT_FILES_NON_STANDARD := y
>  hostprogs-y    := modpost mk_elfconfig
>  always         := $(hostprogs-y) empty.o
>
> +CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
> +
>  modpost-objs   := modpost.o file2alias.o sumversion.o
>
>  devicetable-offsets-file := devicetable-offsets.h
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
