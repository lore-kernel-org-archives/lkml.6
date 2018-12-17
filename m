Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8609EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA1F20675
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="anF8KtfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbeLQSX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:23:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42943 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388786AbeLQSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:23:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id 68so7896087qke.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=P4GuFcNbaeLR0enY0NKknfehQDA9aBA5NA7dHQ7FTFc=;
        b=anF8KtfH5h2u/u82lNXVbLnHnW4pRnT8emNbzdMGu4BVrB6/eK5wFEc29YYbAerAD7
         8TFU2Ikpx/oTA3wsOw1h3HHmT2g6P1K8dYE1MjqHdLadMKKWEVNNECn2+pfgb4O6TPzC
         W66NLk1F8RRLiJKu4NV4aP4pNyXJ8kTICIsH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=P4GuFcNbaeLR0enY0NKknfehQDA9aBA5NA7dHQ7FTFc=;
        b=pnrk2gCfdWwIzTESFNnizEt/E+xYi8wWeaP51HmTCFdl38/KeLppmXcOLkL2oBq3t4
         lMQwh2AicccxDaDx4IuXZjBom7ifRIGJVURi3EY48Tz12z8sFVyODDFy2ktCpFrquCxm
         gFUT5AdseNx/tt2nh5aFljnLCZhoBO3UDLiQDNISjWi5dhtVrcv/vIv5DcTQ7jxWmn7e
         30Nax/pfzoCnIlmjCs8sP/sub65+23FXmDR3lEywxzqCk0DJNbLfLvld5K84i+dP85Iq
         XJE1hQTVT0fVCxUsXwCUfNrnsT+27igV0UtCjidKQI9hKZ3VnmAA/n7rxCQ9B7wyYhIO
         DEAA==
X-Gm-Message-State: AA+aEWbyQMKbBD3pfiJkLdYkn+yJcyKclhb6mMUToXhJBa2pnAyWkwL+
        1sdtZkq9n8uu5/ekKBst8rnuxw==
X-Google-Smtp-Source: AFSGD/XZyrsTzjtpaEzU+kGYptY/buHBFtYNi8KH/A9Ew6NwUND1DLZc3TjqMKW8qwnyT1lL52vBOQ==
X-Received: by 2002:a37:1ad9:: with SMTP id l86mr12842072qkh.54.1545071036115;
        Mon, 17 Dec 2018 10:23:56 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id 5sm10590138qtw.50.2018.12.17.10.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:23:54 -0800 (PST)
Date:   Mon, 17 Dec 2018 13:23:52 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tri Vo <trong@android.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
Message-ID: <nycvar.YSQ.7.76.1812171318310.3623@knanqh.ubzr>
References: <20181215212304.19390-1-natechancellor@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2018, Nathan Chancellor wrote:

> While building arm32 allyesconfig, I ran into the following errors:
> 
>   arch/arm/lib/xor-neon.c:17:2: error: You should compile this file with
>   '-mfloat-abi=softfp -mfpu=neon'
> 
>   In file included from lib/raid6/neon1.c:27:
>   /home/nathan/cbl/prebuilt/lib/clang/8.0.0/include/arm_neon.h:28:2:
>   error: "NEON support not enabled"
> 
> Building V=1 showed NEON_FLAGS getting passed along to Clang but
> __ARM_NEON__ was not getting defined. Ultimately, it boils down to Clang
> only defining __ARM_NEON__ when targeting armv7, rather than armv6k,
> which is the '-march' value for allyesconfig.
> 
> From lib/Basic/Targets/ARM.cpp in the Clang source:
> 
>   // This only gets set when Neon instructions are actually available, unlike
>   // the VFP define, hence the soft float and arch check. This is subtly
>   // different from gcc, we follow the intent which was that it should be set
>   // when Neon instructions are actually available.
>   if ((FPU & NeonFPU) && !SoftFloat && ArchVersion >= 7) {
>     Builder.defineMacro("__ARM_NEON", "1");
>     Builder.defineMacro("__ARM_NEON__");
>     // current AArch32 NEON implementations do not support double-precision
>     // floating-point even when it is present in VFP.
>     Builder.defineMacro("__ARM_NEON_FP",
>                         "0x" + Twine::utohexstr(HW_FP & ~HW_FP_DP));
>   }
> 
> Ard Biesheuvel recommended explicitly adding '-march=armv7-a' at the
> beginning of the NEON_FLAGS definitions so that __ARM_NEON__ always gets
> definined by Clang. This doesn't functionally change anything because
> that code will only run where NEON is supported, which is implicitly
> armv7.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/287
> Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Did you test that this doesn't create issues with gcc e.g. complaints 
from the linker that objects have incompatible architecture 
specifications or similar annoyance? This already happened in the past 
but I forget the exact scenario. If you already did, or after you do 
validate with gcc as well, then you may add:

Acked-by: Nicolas Pitre <nico@linaro.org>



> ---
>  Documentation/arm/kernel_mode_neon.txt | 4 ++--
>  arch/arm/lib/Makefile                  | 2 +-
>  arch/arm/lib/xor-neon.c                | 2 +-
>  lib/raid6/Makefile                     | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/arm/kernel_mode_neon.txt b/Documentation/arm/kernel_mode_neon.txt
> index 525452726d31..b9e060c5b61e 100644
> --- a/Documentation/arm/kernel_mode_neon.txt
> +++ b/Documentation/arm/kernel_mode_neon.txt
> @@ -6,7 +6,7 @@ TL;DR summary
>  * Use only NEON instructions, or VFP instructions that don't rely on support
>    code
>  * Isolate your NEON code in a separate compilation unit, and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp'
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp'
>  * Put kernel_neon_begin() and kernel_neon_end() calls around the calls into your
>    NEON code
>  * Don't sleep in your NEON code, and be aware that it will be executed with
> @@ -87,7 +87,7 @@ instructions appearing in unexpected places if no special care is taken.
>  Therefore, the recommended and only supported way of using NEON/VFP in the
>  kernel is by adhering to the following rules:
>  * isolate the NEON code in a separate compilation unit and compile it with
> -  '-mfpu=neon -mfloat-abi=softfp';
> +  '-march=armv7-a -mfpu=neon -mfloat-abi=softfp';
>  * issue the calls to kernel_neon_begin(), kernel_neon_end() as well as the calls
>    into the unit containing the NEON code from a compilation unit which is *not*
>    built with the GCC flag '-mfpu=neon' set.
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index ad25fd1872c7..0bff0176db2c 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
>  
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> -  NEON_FLAGS			:= -mfloat-abi=softfp -mfpu=neon
> +  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>  endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index a6741a895189..4600b62d845f 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,7 +14,7 @@
>  MODULE_LICENSE("GPL");
>  
>  #ifndef __ARM_NEON__
> -#error You should compile this file with '-mfloat-abi=softfp -mfpu=neon'
> +#error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>  #endif
>  
>  /*
> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> index 2f8b61dfd9b0..bfec7c87c61e 100644
> --- a/lib/raid6/Makefile
> +++ b/lib/raid6/Makefile
> @@ -25,7 +25,7 @@ endif
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>  NEON_FLAGS := -ffreestanding
>  ifeq ($(ARCH),arm)
> -NEON_FLAGS += -mfloat-abi=softfp -mfpu=neon
> +NEON_FLAGS += -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>  endif
>  CFLAGS_recov_neon_inner.o += $(NEON_FLAGS)
>  ifeq ($(ARCH),arm64)
> -- 
> 2.20.1
> 
> 
