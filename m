Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39AF0ECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3202205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 00:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLdzNOA6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3202205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730234AbeGSA6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:58:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36899 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeGSA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:58:53 -0400
Received: by mail-it0-f68.google.com with SMTP id p17-v6so6919733itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 17:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/Bgl3wnCn+UE6CkXJqOTh83mz28iJo4ehfDHuq4ZHak=;
        b=RLdzNOA6FE7YcBiTcVypolUyO0lZESb2eyOmgSz8Eqq5cVzm2HU6nDwgOv485oXpXD
         LeoW3q+Ld3SA+gkWG6CpTvuRkV7OSR/xxt7EyS2IQtTmpkhtvKQBLL1dx3O3Xv04UZBN
         0719HWLwimGwPigN9bmZIIGqZDUsZL5McAemc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/Bgl3wnCn+UE6CkXJqOTh83mz28iJo4ehfDHuq4ZHak=;
        b=KTrcchIbw/D6ot1enviVAXBxvmHosBctiw9yNuhcmkaSdo3H6NKlGw5406Iv10Gn6W
         Wat+BwPTFlPm0oLILlpt2MIqIDD9sjUHPiXp+fdbVANjjgPAkWGeC8TUM95ZEiwKCjTC
         wanXukiqupAm+7OMrviTRbZy0vq02eNX0p2I7klZnFviIY+EIdGhQwouqJ6h1W43oOs3
         HYQCyVtQyfdCJuVHBPMqsuVQQtdCI98/+USYMbl2WjdHqY65fw08m9cCkGoQCz3r+rr2
         B44tddVH3iZ5J1La2/v2NVStgdEqCCYbrgyMo7wJ76BybHfYRsJlhoEWEoGmlebpbeS3
         ScXA==
X-Gm-Message-State: AOUpUlFT2f77tf4gVdO4jwF1j9TH7yN0bPjMl7an4qZsqB/4kQeqV7lV
        ai2ADto/fKw9knzyqj0z0IEUI30RJPkHtXebzlPfnA==
X-Google-Smtp-Source: AAOMgpdXPebYPeQyAbxwRri7KqPUr5uNt49bMxSTZyvdSCf1LzCDewNmH+eCi8cqSA3eGeRK6S3nMpjNzO+mFTGrr/k=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr2602705itc.68.1531959510288;
 Wed, 18 Jul 2018 17:18:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 17:18:29
 -0700 (PDT)
In-Reply-To: <20180713153033.20540-1-olof@lixom.net>
References: <20180713150701.GA3049@arm.com> <20180713153033.20540-1-olof@lixom.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Jul 2018 09:18:29 +0900
Message-ID: <CAKv+Gu_TkTj5sD-FjTF=GQnNvSVNF37gCpQHxJAHy0+n=SmUbA@mail.gmail.com>
Subject: Re: [PATCH] arm64: build with baremetal linker target instead of
 Linux when available
To:     Olof Johansson <olof@lixom.net>,
        Andrew Pinski <apinski@cavium.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <contact@paulk.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 July 2018 at 00:30, Olof Johansson <olof@lixom.net> wrote:
> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
> in particular. So, probe for whether it's available and use the previous
> (linux) targets if it isn't.
>
> Reported-by: Laura Abbott <labbott@redhat.com>
> Cc: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm64/Makefile    | 9 +++++----
>  scripts/Kbuild.include | 4 ++--
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index e7101b19d590..efe61a2e4b5e 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,15 +60,16 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS        += -mbig-endian
>  CHECKFLAGS     += -D__AARCH64EB__
>  AS             += -EB
> -# We must use the linux target here, since distributions don't tend to package
> -# the ELF linker scripts with binutils, and this results in a build failure.
> -LDFLAGS                += -EB -maarch64linuxb
> +# Prefer the baremetal ELF build target, but not all toolchains include
> +# it so fall back to the standard linux version if needed.
> +LDFLAGS                += -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
>  UTS_MACHINE    := aarch64_be
>  else
>  KBUILD_CPPFLAGS        += -mlittle-endian
>  CHECKFLAGS     += -D__AARCH64EL__
>  AS             += -EL
> -LDFLAGS                += -EL -maarch64linux # See comment above
> +# Same as above, prefer ELF but fall back to linux target if needed.
> +LDFLAGS                += -EL $(call ld-option, -maarch64elf, -maarch64linux)
>  UTS_MACHINE    := aarch64
>  endif
>

Did anyone check if just removing these options altogether would be an option?

The commit that introduced them does not even mention them, but only
mentions adding -mabi=lp64 to the cc/as flags:

commit 3d6a7b99e3fa29b92d6288487e057e0a596bd2b0
Author: Andrew Pinski <apinski@cavium.com>
Date:   Mon Sep 18 11:20:20 2017 +0100

    arm64: ensure the kernel is compiled for LP64

    The kernel needs to be compiled as a LP64 binary for ARM64, even when
    using a compiler that defaults to code-generation for the ILP32 ABI.
    Consequently, we need to explicitly pass '-mabi=lp64' (supported on
    gcc-4.9 and newer).



> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index c8156d61678c..1e13f502b42f 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
>         $(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>
>  # ld-option
> -# Usage: LDFLAGS += $(call ld-option, -X)
> -ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
> +# Usage: LDFLAGS += $(call ld-option, -X, -Y)
> +ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
>
>  # ar-option
>  # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
