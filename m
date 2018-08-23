Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585DFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 02:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00622208FC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 02:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I20NGB/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00622208FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHWGLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 02:11:00 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49947 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbeHWGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 02:11:00 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w7N2hKdC023390
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 11:43:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w7N2hKdC023390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534992201;
        bh=pr4KSdFDa2kSutSW4zW2TlTft+HohByN6htWclmlZUE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=I20NGB/uWOqxno6+jd7l09lDUr9G1iHv8mow1Gt/MIPavylzdZRswyooAtuDGsDxP
         Xn5mMq+TSE8PETydNbRyH3jbPOtpU3CDNiMy4WQXARSHjg3BNOcpr0b8nWzEw+6FZb
         8sZVogZA9rG9Y/88KY0Ub19C2m84Pl8h6IdfB4P+pHt96tIvHddA9IFWAZ5BaJS4ca
         AuShgjNrLqPdGgcjlOhiDN8tvur5ylanOOay9PCN0uNkP4xbt3r/DHU1H0xczXpnvV
         R8201d6JGq9BwXjklnyGpfCZgnRtbkxtMGFV8vcwaZivNeAHFkl3Dal8j6qty/VgLF
         PZyMMG337L9kQ==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id l2-v6so2316113uaf.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 19:43:20 -0700 (PDT)
X-Gm-Message-State: AOUpUlGb9V69OFC/PFY51Q2jo1OKbE3TUrsR1bmgu57l2JUHw/3gvWpI
        5hzIqgsUjMHGW1jnaHhng3ia2HqTZNMFNeayxAI=
X-Google-Smtp-Source: AA+uWPwcr0Dp6ZH+JhOTEbInIzb6XPPK99wQeLt5R8vStLAeWaLBGIrUVMFtgR6lF2TE1Xeo4H0ELwpd1xrb7+5rThQ=
X-Received: by 2002:ab0:14b3:: with SMTP id d48-v6mr39362716uae.88.1534992199514;
 Wed, 22 Aug 2018 19:43:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Wed, 22 Aug 2018 19:42:39
 -0700 (PDT)
In-Reply-To: <20180822233724.110454-1-ndesaulniers@google.com>
References: <20180822233724.110454-1-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 11:42:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxpmGK=PMt-qMDYvaYcO=SZ9HWudGYqC11aJ-kGXaVoA@mail.gmail.com>
Message-ID: <CAK7LNAQxpmGK=PMt-qMDYvaYcO=SZ9HWudGYqC11aJ-kGXaVoA@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: make compiler-*.h mutually exclusive
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        asmadeus@codewreck.org, Daniel Borkmann <daniel@iogearbox.net>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick

2018-08-23 8:37 GMT+09:00 Nick Desaulniers <ndesaulniers@google.com>:
> Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
> recently exposed a brittle part of the build for supporting non-gcc
> compilers.
>
> Both Clang and ICC define __GNUC__, __GNUC_MINOR__, and
> __GNUC_PATCHLEVEL__ for quick compatibility with code bases that haven't
> added compiler specific checks for __clang__ or __INTEL_COMPILER.
>
> This is brittle, as they happened to get compatibility by posing as a
> certain version of GCC.  This broke when upgrading the minimal version
> of GCC required to build the kernel, to a version above what ICC and
> Clang claim to be.
>
> Rather than always including compiler-gcc.h then undefining or
> redefining macros in compiler-intel.h or compiler-clang.h, let's
> separate out the compiler specific macro definitions into mutually
> exclusive headers, do more proper compiler detection, and keep shared
> definitions in compiler_types.h.
>
> Reported-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Eli Friedman <efriedma@codeaurora.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm/kernel/asm-offsets.c     |  13 +-
>  drivers/gpu/drm/i915/i915_utils.h |   2 +-
>  drivers/watchdog/kempld_wdt.c     |   5 -
>  include/linux/compiler-clang.h    |  20 ++-
>  include/linux/compiler-gcc.h      |  88 -----------
>  include/linux/compiler-intel.h    |  13 +-
>  include/linux/compiler_types.h    | 238 ++++++++++++++----------------
>  mm/ksm.c                          |   4 +-
>  mm/migrate.c                      |   3 +-
>  9 files changed, 133 insertions(+), 253 deletions(-)



If I build ARM linux with Clang,
I see the following error.



arch/arm/firmware/trusted_foundations.c:34:13: error: variable has
incomplete type 'void'
static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
            ^
arch/arm/firmware/trusted_foundations.c:34:20: error: expected ';'
after top level declarator
static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
                   ^
                   ;
arch/arm/firmware/trusted_foundations.c:77:25: error: use of
undeclared identifier 'trusted_foundations_ops'
        register_firmware_ops(&trusted_foundations_ops);
                               ^
3 errors generated.
scripts/Makefile.build:307: recipe for target
'arch/arm/firmware/trusted_foundations.o' failed
make[2]: *** [arch/arm/firmware/trusted_foundations.o] Error 1
Makefile:1057: recipe for target 'arch/arm/firmware' failed
make[1]: *** [arch/arm/firmware] Error 2
make[1]: *** Waiting for unfinished jobs....





__naked is defined in <linux/compiler-gcc.h>


It was previous included by all compilers,
but now it is only by _true_ GCC.


Even if I move the __naked definition
to <linux/compiler_types.h>,
I see a different error.



arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
references not allowed in naked functions
                : "r" (type), "r" (arg1), "r" (arg2)
                       ^
arch/arm/firmware/trusted_foundations.c:34:13: note: attribute is here
static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
            ^
./include/linux/compiler_types.h:277:33: note: expanded from macro '__naked'
#define __naked         __attribute__((naked))
                                       ^



I do not know what a correct fix is.







-- 
Best Regards
Masahiro Yamada
