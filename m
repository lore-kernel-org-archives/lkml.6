Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34A2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B99920864
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B99920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbeGMThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 15:37:39 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39264 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbeGMThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 15:37:38 -0400
Received: by mail-qt0-f193.google.com with SMTP id q12-v6so28048631qtp.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 12:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0LYaU+TH0cCk7XMF3bvWHXX33qJNOdPPUVwLSMIgr4=;
        b=VXiwaA6kTfRfN+ZHwuLFdH9+6RnFGTlbiez/qmfNHmfFou9dLfpqYiiOB20AP0FE4D
         y0gToiCVh1WrWj+hBZ00AFeifiv7WxjEAKXr0UZzez+RaWS7GzDFGD3sWvJbRM6hDYRp
         SFiJHTvNxI/+mRWiwLuSGHdWzF4zLMZWEIRAsLbAjzD2g4UwHCb4r51kLCLKzXa2QIB/
         KJ0QxcUwVsBgp3GtFUlqDu5DphKQQNY1k3F+Z4N1wCP8L2N90/IJEzMMENeRyfW55MUW
         UfvAxvk0aiRRO/5LjT3fhK72rrQg53GCms8Qzyj5+6sGkSjgQ3kDoiAs4jc97oHLvgrI
         vEIA==
X-Gm-Message-State: AOUpUlG4YvnzM0ODcZCHcMRULrbeRScEWr2Fgusg+BPPDtD6PrRiwGUr
        bH2FIx3ppJyBC5nO2Vc7GHabvA==
X-Google-Smtp-Source: AAOMgpf51WE1rC21Awa3jc90Emq0dKPNdVfRNvF0zxFvioOsqTD4LynMZbOuv+pVzGql4nrWmDks6A==
X-Received: by 2002:ac8:1493:: with SMTP id l19-v6mr7152296qtj.129.1531509701017;
        Fri, 13 Jul 2018 12:21:41 -0700 (PDT)
Received: from ?IPv6:2601:602:9802:a8dc::1941? ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id 140-v6sm16953137qkm.18.2018.07.13.12.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 12:21:39 -0700 (PDT)
Subject: Re: [PATCH] arm64: build with baremetal linker target instead of
 Linux when available
To:     Olof Johansson <olof@lixom.net>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <contact@paulk.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180713150701.GA3049@arm.com>
 <20180713153033.20540-1-olof@lixom.net>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <33f65453-5b6d-0684-8a91-7e9940846143@redhat.com>
Date:   Fri, 13 Jul 2018 12:21:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713153033.20540-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 08:30 AM, Olof Johansson wrote:
> Not all toolchains have the baremetal elf targets, RedHat/Fedora ones
> in particular. So, probe for whether it's available and use the previous
> (linux) targets if it isn't.
> 


For the Fedora toolchains:

Tested-by: Laura Abbott <labbott@redhat.com>

> Reported-by: Laura Abbott <labbott@redhat.com>
> Cc: Paul Kocialkowski <contact@paulk.fr>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   arch/arm64/Makefile    | 9 +++++----
>   scripts/Kbuild.include | 4 ++--
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index e7101b19d590..efe61a2e4b5e 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,15 +60,16 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>   KBUILD_CPPFLAGS	+= -mbig-endian
>   CHECKFLAGS	+= -D__AARCH64EB__
>   AS		+= -EB
> -# We must use the linux target here, since distributions don't tend to package
> -# the ELF linker scripts with binutils, and this results in a build failure.
> -LDFLAGS		+= -EB -maarch64linuxb
> +# Prefer the baremetal ELF build target, but not all toolchains include
> +# it so fall back to the standard linux version if needed.
> +LDFLAGS		+= -EB $(call ld-option, -maarch64elfb, -maarch64linuxb)
>   UTS_MACHINE	:= aarch64_be
>   else
>   KBUILD_CPPFLAGS	+= -mlittle-endian
>   CHECKFLAGS	+= -D__AARCH64EL__
>   AS		+= -EL
> -LDFLAGS		+= -EL -maarch64linux # See comment above
> +# Same as above, prefer ELF but fall back to linux target if needed.
> +LDFLAGS		+= -EL $(call ld-option, -maarch64elf, -maarch64linux)
>   UTS_MACHINE	:= aarch64
>   endif
>   
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index c8156d61678c..1e13f502b42f 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -163,8 +163,8 @@ cc-ldoption = $(call try-run,\
>   	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
>   
>   # ld-option
> -# Usage: LDFLAGS += $(call ld-option, -X)
> -ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2))
> +# Usage: LDFLAGS += $(call ld-option, -X, -Y)
> +ld-option = $(call try-run, $(LD) $(LDFLAGS) $(1) -v,$(1),$(2),$(3))
>   
>   # ar-option
>   # Usage: KBUILD_ARFLAGS := $(call ar-option,D)
> 

