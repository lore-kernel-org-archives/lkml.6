Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47232C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015AF206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7uyTR8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389301AbeLQTfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:35:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34876 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeLQTfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:35:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so416125wmh.0;
        Mon, 17 Dec 2018 11:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sTAKS+Vyc7ODkqW5h+mrhKCUCTFsO23j0Ib/dkzKqV0=;
        b=f7uyTR8IpNTJQFDNddjUPpaMlMplz3Lj/Ynio1pZvXo++F9VWslCZXEr4r96cOK5dW
         KBTtyAWfLgDakyQzoyAQYKtMsyVjcyy22Qd+mD0kjmCDqfTNtWY0k+XHxLFOsy+/jI24
         a23D3hqw7nXKeSx/1tUmkqk1QFxEuXHqywxhL4yXKyW1Tw4hgSzHl69TF9nItO1BBQ0j
         sJpHcB8EzKchPyZufOOEtJP8B/Dm/dO2deK6d5jgK78g7seCsPEzVpAUeRBVk7eV1BVV
         fIQRjlPyIft/wImSpv3sFp1PC9yh1o79FDzSeuKOOVtSO65wkH7WUDWJc9B3o/CSXi/q
         b6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sTAKS+Vyc7ODkqW5h+mrhKCUCTFsO23j0Ib/dkzKqV0=;
        b=lKOa7iFzOf0rgLDeE96MizlAmcuC4mUsngq1/10GCDdJTkcxc07Q9QTnoA1P9+LLq0
         NrZXICx/f3DVbXxLnincLNYkDRyYycARSRENi0B+XC4BwVGo5W46HccvD22r1+XHwZNY
         E3VttJbO5gO8SqLzq/fmXin6U1X/WFFl7Vquf7g5rQDBGuvL1GjcLdDNS6eo5oz/hqpv
         mIh82+uGgxnrfyD1OkPALPoP8rajOO24HjkXpuVf+zy9Sf4qMxkV30daMyOcERtO+7Wp
         ++Ft/Lcu6tlHTrftCXedYK2r0AgboygOlX8crQ0bHkFd016pHXJSCi1lvGE23iRYjsQ8
         RE6A==
X-Gm-Message-State: AA+aEWb+GTVmE46Mx9EaAPfurgxJDBOdC99EDG8M18OFfDsohZwa91Ik
        reH2LYkA70RBVyogXM1koDI=
X-Google-Smtp-Source: AFSGD/UAcrep4XoH8YXIr83xXW3TZH4SWqsJnEACpB2Ui1NxroWxCXcgG7k2+mNbBTM2OAZivNb7AQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr389555wmg.53.1545075300306;
        Mon, 17 Dec 2018 11:35:00 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e9sm716361wro.16.2018.12.17.11.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 11:34:59 -0800 (PST)
Date:   Mon, 17 Dec 2018 12:34:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tri Vo <trong@android.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
Message-ID: <20181217193458.GA6671@flashbox>
References: <20181215212304.19390-1-natechancellor@gmail.com>
 <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 01:23:52PM -0500, Nicolas Pitre wrote:
> On Sat, 15 Dec 2018, Nathan Chancellor wrote:
> 
> > While building arm32 allyesconfig, I ran into the following errors:
> > 
> >   arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
> >   '-mfloat-abi=softfp -mfpu=neon'
> > 
> >   In file included from lib/raid6/neon1.c:27:
> >   /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
> >   error: "NEON support not enabled"
> > 
> > Building V=1 showed NEON_FLAGS getting passed along to Clang but
> > __ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
> > only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
> > which is the '-march' value for allyesconfig.
> > 
> > From lib/Basic/Targets/ARM.cpp in the Clang source:
> > 
> >   // This only gets set when Neon instructions are actually available, unlike
> >   // the VFP define, hence the soft float and arch check. This is subtly
> >   // different from gcc, we follow the intent which was that it should be set
> >   // when Neon instructions are actually available.
> >   if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
> >     Builder.defineMacro("__ARM_NEON", "1");
> >     Builder.defineMacro("__ARM_NEON__");
> >     // current AArch32 NEON implementations do not support double-precision
> >     // floating-point even when it is present in VFP.
> >     Builder.defineMacro("__ARM_NEON_FP",
> >                         "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
> >   }
> > 
> > Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
> > beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
> > definined by Clang. This doesn't functionally change anything because
> > that code will only run where NEON is supported, which is implicitly
> > armv7.
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/287
> > Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Did you test that this doesn't create issues with gcc e.g. complaints 
> from the linker that objects have incompatible architecture 
> specifications or similar annoyance? This already happened in the past 
> but I forget the exact scenario. If you already did, or after you do 
> validate with gcc as well, then you may add:
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>
> 
> 

Hi Nicolas,

I was 99% sure that I checked GCC before sending this but I just did
another run to confirm and everything links successfully. We still use
binutils for assembling/linking the kernel so I assume that I would have
seen a warning from ld.bfd even with Clang.

Thank you for the review!
Nathan

> 
> > ---
> >  Documentation/arm/kernel_mode_neon.txt | 4 ++--
> >  arch/arm/lib/Makefile                  | 2 +-
> >  arch/arm/lib/xor-neon.c                | 2 +-
> >  lib/raid6/Makefile                     | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
> > index 525452726d31..b9e060c5b61e 100644
> > --- a/Documentation/arm/kernel_mode_neon.txt
> > +++ b/Documentation/arm/kernel_mode_neon.txt
> > @@ -6,7 +6,7 @@ TL;DR summary
> >  * Use only NEON instructions, or VFP instructions that don't rely on support
> >    code
> >  * Isolate your NEON code in a separate compilation unit, and compile it with
> > -  '-mfpu=neon -mfloat-abi=softfp'
> > +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
> >  * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
> >    NEON code
> >  * Don't sleep in your NEON code, and be aware that it will be executed with
> > @@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
> >  Therefore, the recommended and only supported way of using NEON/VFP in the
> >  kernel is by adhering to the following rules:
> >  * isolate the NEON code in a separate compilation unit and compile it with
> > -  '-mfpu=neon -mfloat-abi=softfp';
> > +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
> >  * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
> >    into the unit containing the NEON code from a compilation unit which is *not*
> >    built with the GCC flag '-mfpu=neon' set.
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index ad25fd1872c7..0bff0176db2c 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
> >  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
> >  
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> > -  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
> > +  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> >    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> >  endif
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index a6741a895189..4600b62d845f 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -14,7 +14,7 @@
> >  MODULE_LICENSE("GPL");
> >  
> >  #ifndef __ARM_NEON__
> > -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> > +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> >  #endif
> >  
> >  /*
> > diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> > index 2f8b61dfd9b0..bfec7c87c61e 100644
> > --- a/lib/raid6/Makefile
> > +++ b/lib/raid6/Makefile
> > @@ -25,7 +25,7 @@ endif
> >  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> >  NEON_FLAGS := -ffreestanding
> >  ifeq ($(ARCH),arm)
> > -NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
> > +NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> >  endif
> >  CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
> >  ifeq ($(ARCH),arm64)
> > -- 
> > 2.20.1
> > 
> > 
