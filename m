Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43145C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9402147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJLpNCkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfBHFpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:45:33 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44190 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfBHFpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:45:33 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so1768353edd.11;
        Thu, 07 Feb 2019 21:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d1K97yQCTgEnjmiqKMOIJc6tEcBbJInO4C63MztXXOU=;
        b=JJLpNCkD/Hjn8Qa1bKQOwzO+a0hOwtwRH7E5S5XPBfkBcUaSPMAubFhJgkpLrdOTiN
         9xqRBOyXIvNyb99XalSYa5ZfPJtyEUrAwXM4G04IJjA/xnao2MQKGGPscDS2MD+3ttUL
         Jtn09ZqI0RixjuzE1J73CrwfRt8wRNiU/lRlxlHifUxpM8H4/FTxwydEwI2HmiWifJPM
         /6qZGNSWMykbcntUSOP8sKoblqf/kFllo/6HbQ9P5fpw38TAE1CJzmryavbkJXFpIQ2g
         bxB8TB0dSitgZuNuERt3a4l2eeQ3TWuEXx7JGw8E7ICqKUrI2PDRHPlIlTN1WKLiTfdj
         NSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d1K97yQCTgEnjmiqKMOIJc6tEcBbJInO4C63MztXXOU=;
        b=FbsxJO3ED18JA2EsYmxQNGqgEAu2xvIUrf+vYrIzdSo4BmorcrBTkRFWfUUTH4c2Li
         2JHHT9eHwPNpiZ74T7ySrLlx20ExG3Fdr6eog+P8yTBDaWRWsbzmB9B84W+7xO8TCfJ9
         +c0XVruUyvpgeCOKUvdUEA9XdC2e0ZgzRQBbi1nnoW1gEI8sdbnCvK6tr6/rxPxZ5wDU
         DogfqrNbKdJkCHKGA7GQbMEQy3+a7CrCQIFHhG45nrDYLH6yLuJcFVpesi3lvtfR9QEH
         2CR8mJsfLERgZZNcB0pTqGuoXPqg3sS1DM6Li29cXiiXaaSyHPStPzbwkCr52FpXW4g8
         xFCw==
X-Gm-Message-State: AHQUAuagEA8B//S+BzDeNERpwCnSKuZRmMBfHOWnuBdILxhbZT2zv+33
        CBwUFomios+DEKaVfHnGgbGDkZPhHe4kEw==
X-Google-Smtp-Source: AHgI3IaWqsqfesFwn86ZmbDQjEuUK1SDvvEvskNDtnwVww6SxU3CCCftQnNZIIztUhhB+DbUaqfXAw==
X-Received: by 2002:aa7:d7cf:: with SMTP id e15mr14920518eds.69.1549604730864;
        Thu, 07 Feb 2019 21:45:30 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f6sm360625ede.53.2019.02.07.21.45.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Feb 2019 21:45:30 -0800 (PST)
Date:   Thu, 7 Feb 2019 22:45:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     ndesaulniers@google.com
Cc:     yamada.masahiro@socionext.com,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
Message-ID: <20190208054528.GC9647@archlinux-ryzen>
References: <20190207220155.81351-1-ndesaulniers@google.com>
 <20190207220155.81351-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207220155.81351-2-ndesaulniers@google.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 02:01:50PM -0800, ndesaulniers@google.com wrote:
> This causes an issue when trying to build with `make LD=ld.lld` if
> ld.lld and the rest of your cross tools aren't in the same directory
> (ex. /usr/local/bin) (as is the case for Android's build system), as the
> GCC_TOOLCHAIN_DIR then gets set based on `which $(LD)` which will point
> where LLVM tools are, not GCC/binutils tools are located.
> 
> Instead, select the GCC_TOOLCHAIN_DIR based on another tool provided by
> binutils for which LLVM does not provide a substitute for, such as
> elfedit.
> 
> Fixes commit 785f11aa595b ("kbuild: Add better clang cross build support")
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/341
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 3142e67d03f1..0eae4277206e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -492,7 +492,7 @@ endif
>  ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>  ifneq ($(CROSS_COMPILE),)
>  CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
> -GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
> +GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
>  CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
>  GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>  endif
> -- 
> 2.20.1.791.gb4d0f1c61a-goog
> 
