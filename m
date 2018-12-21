Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C07FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC16217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YimIdrgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbeLUSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:11:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391186AbeLUSL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:11:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so2849128pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 10:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+s0cCpjIWVQiboFpL5zFPaKNhtl7rE4uoN8aqs1kLI=;
        b=YimIdrgGY5kOVlG+kPdeha0dYALLoL0bjb1JmPeUURrqxIDlMdxfvYSpiGsZ0iGmol
         gCWlw+WkTsc8JvRW7g19ZIDhPwGQ7eDw87yKddTzTA7BhtzCQ8LRK9HdvT4SEPN9QP40
         A20cT9XO+yZMY0u9a52rdr1fVMJZDDZhPA3p5QIVWJn0JOAj1ljqSb2duLO4h8VDzQi2
         ZlDqExCtiF15mDyzzu7lxMprzH2n9y1Ipl4Hanx+LdH/3uQ9I1Bc05z5TNcxiw+ApspW
         2AZVxK0qNh3VgMfyPoohoap0Ri2yyK2ut+hUq0QH8zoAMHVHmeMC7fcQ63ZGXMpkfAaP
         gFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+s0cCpjIWVQiboFpL5zFPaKNhtl7rE4uoN8aqs1kLI=;
        b=KZ0ZrJs9GWYbUZOC6WLm69eR6UC1PB30N771PzITfFa9NgdOohdOsjIr1lC6erhpUR
         NAw2uIv9FftBWsI9/Apc69GpfUP0ekw/Ys/vKnYsnZywrKrBh7gtIPDfK6DQBTnol9qF
         qmJPjSPzh5GZZNiuiUw8QZgZTj9UFLrMVZrbJEp6bW6WomoY3gM0tzT+tRRSGJ585JZw
         RFPQYQDuU7QwjY4EJ0T1HGZJ8WLaJUWw5iX0fiu9fa2W4/KjxDf8N4gQ+GL5H70abemg
         LHWHL/GVwPJSEv7LaPMnVe9FmEdy9w+e0l4IHoO3mdToV3sur5ql5a/n8YYGv0IASmpr
         pVog==
X-Gm-Message-State: AJcUuke/0EOykkQw6J5jfqS815Hm0nARfpYkgmmEnq+h+Mmg6jgjN2+y
        0DIufz9JKsfsNc6CI+WT1Ygbj4M4y3Is7vEwDSkuUw==
X-Google-Smtp-Source: ALg8bN7lftdti7rNkwuau6n+UL53WBYOLTn2sRichzFPafU22RR8xqToudo0eJodzgc4hxheyd66mmmDj0JlmSCWJVY=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr3374238pga.202.1545415914314;
 Fri, 21 Dec 2018 10:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20181215212304.19390-1-natechancellor@gmail.com>
In-Reply-To: <20181215212304.19390-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Dec 2018 10:11:43 -0800
Message-ID: <CAKwvOdkfehycubxKDLs9vZvKWE4QR+EyerxNSaV72aDwySx8eQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: Ensure that NEON code always compiles with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-doc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Tri Vo <trong@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 1:23 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
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

Nathan,
Thanks for sending the patch, and thanks to Ard for the suggestion.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> @@ -39,7 +39,7 @@ $(obj)/csumpartialcopy.o:     $(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:  $(obj)/csumpartialcopygeneric.S
>
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> -  NEON_FLAGS                   := -mfloat-abi=softfp -mfpu=neon
> +  NEON_FLAGS                   := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>    CFLAGS_xor-neon.o            += $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
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


-- 
Thanks,
~Nick Desaulniers
