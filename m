Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A977C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4F223A6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 01:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VSUPvNAx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C4F223A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeHJEHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:07:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34572 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeHJEHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:07:38 -0400
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com [209.85.161.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id w7A1dtEq015463;
        Fri, 10 Aug 2018 10:39:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w7A1dtEq015463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533865196;
        bh=ZMC7X7IRqnL4wJfRTIDYw7XpButkDZb3WCYLW4dSCFc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=VSUPvNAx4SYCV+jdwr8JeeheA0pJCJ+ixMoz7VhiE/9Wcsts5MSRzoEETv6NBEzBz
         oUByUl88Nx0sTWR5I4nN7wJl2eIeZg4+ahzxKxD32VNPo8Dq5A63Zjzg95+oWtW4KW
         W6B3Qt6TfUum5T5VMNdLSLmwEzWKLuyzd56/QMa7xnsuKeTRB9QXFLf87CPqDZUJox
         tY3+Je9KFGl6LcbfRJts/7iP0srrh3p4s2/iy+xm8kJ75PrZmslcgKtEgzsnmdR1W9
         f6QHrUno9yPOZppCmZPMA0fOy/qz8VcaMkGVhNq2ZrZJoQK49kbVKKNWcBU+iIJ1uA
         IbsM9ijbNEH9g==
X-Nifty-SrcIP: [209.85.161.48]
Received: by mail-yw1-f48.google.com with SMTP id j68-v6so7418541ywg.1;
        Thu, 09 Aug 2018 18:39:55 -0700 (PDT)
X-Gm-Message-State: AOUpUlEIr9lGuQX1vKqaD5rngD3/aGTpRKTkN7uNlxDI0TNfXt9o6ImG
        au3caHZSC5bYAFtNB9VTszCV1DfSNjtSUB81Ah4=
X-Google-Smtp-Source: AA+uWPzq59wlqnn7rmTeSxfCUYj0bHjqdFmt+PzPVQr36Kz4jk8zZT1fDihgw2R4ZA9p6LMtMmbxlUVgtunojP97Xn8=
X-Received: by 2002:a1f:9004:: with SMTP id s4-v6mr84767vkd.10.1533865194453;
 Thu, 09 Aug 2018 18:39:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 18:39:13 -0700 (PDT)
In-Reply-To: <20180809201554.168804-3-namit@vmware.com>
References: <20180809201554.168804-1-namit@vmware.com> <20180809201554.168804-3-namit@vmware.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 Aug 2018 10:39:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ6djK_mOAGFj_y8qmm7=7mzGpCQd=Uxu330z_wMfZxkQ@mail.gmail.com>
Message-ID: <CAK7LNAQ6djK_mOAGFj_y8qmm7=7mzGpCQd=Uxu330z_wMfZxkQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] Makefile: Prepare for using macros for inline asm
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

2018-08-10 5:15 GMT+09:00 Nadav Amit <namit@vmware.com>:
> Using macros for inline assembly improves both readability and
> compilation decisions that are distorted by big assembly blocks that use
> alternative sections. Compile macros.S and use it to assemble all C
> files. Currently, only x86 will use it.
>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>



I added this in the previous version.

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


When you send a new version,
please make sure to add Acked-by/Reviewed-by reviewers have given.

Thanks.

> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  Makefile                 |  9 +++++++--
>  arch/x86/Makefile        | 11 +++++++++--
>  arch/x86/kernel/macros.S |  7 +++++++
>  scripts/Kbuild.include   |  4 +++-
>  scripts/mod/Makefile     |  2 ++
>  5 files changed, 28 insertions(+), 5 deletions(-)
>  create mode 100644 arch/x86/kernel/macros.S
>
> diff --git a/Makefile b/Makefile
> index 7a3c4548162b..39d790e74e0d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1051,7 +1051,7 @@ scripts: scripts_basic include/config/auto.conf include/config/tristate.conf \
>  # version.h and scripts_basic is processed / created.
>
>  # Listed in dependency order
> -PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
> +PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
>
>  # prepare3 is used to check if we are building in a separate output directory,
>  # and if so do:
> @@ -1075,7 +1075,9 @@ prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h \
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
> @@ -1143,6 +1145,9 @@ archheaders:
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
> index a08e82856563..a4b90ac1629b 100644
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
> @@ -258,6 +258,13 @@ archscripts: scripts_basic
>  archheaders:
>         $(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
>
> +archmacros:
> +       $(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
> +
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
> index 86321f06461e..d7b7aadb6cd8 100644
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
