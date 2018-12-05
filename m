Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8748C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0772082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVYBbuwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0772082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbeLEHhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:37:45 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39760 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeLEHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:37:44 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so18779436itl.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z76If0p+l5i8rlrL5R28Djtm7LDYPTVAIf0MqlMbqMk=;
        b=OVYBbuwiJanc+Q0bDCmTelZkKYgn9PTeVkDuj6aOvU1h0ERxw1ES5z05T0OFe4Vzi+
         /ibR1ORs/7k3pgX+kR7HIoMGF6wZgkuveJjn3AeErH+p2dmvLejtGZ+roRpXl1dWlZyU
         U9yE24m9LiDof1MYukKqog87XwO88pLKIwhXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z76If0p+l5i8rlrL5R28Djtm7LDYPTVAIf0MqlMbqMk=;
        b=m1S217Rwi3cAew4sSMLKU2uH2c7LE2nFEnNuvarFVd0s+/H5XFy2nO4fRzzsbRnaP2
         d8NfZRhmKJNW7NveSle6T8BxLGEb5IDaaa4v/G+oNnMMVNMUH4XQGoWQ9QJhgh3so0GG
         qJUBer+jCL7/v/BR3ERzZkc2mIG+wMEBXiOIyI7ijzEIQxC5+/2onNlFgAkqWhjG+60J
         5NlGEUUZZYL9gKBbbmmoGxa4PIyMu8UPkiY3U7MS0WlRjvgW7O05wvXRCsJp8SNv4NDC
         5LSb1/wSKUuYfsAmzunJedEjwXGkd2qLjinGDIdP76uyi6mXSpKfgjtSRM//E/SwleSB
         ln0g==
X-Gm-Message-State: AA+aEWYow0nHFi9bTayHNpZb6SrQ0B/xaFa/uQV0MRH/hX3c/UiXMjpV
        Cd628doszckeI9TbF40dM+Pj/uKawTSdrDBhLewA+w==
X-Google-Smtp-Source: AFSGD/U1CGTfQ45w7yMuwmETfrPAE0jLsyuJcfuIXJrn/27Yh8JJItcfWnh0wk+b5LRnnCy4ng7DWeKm8Asu4Y9shNc=
X-Received: by 2002:a24:710:: with SMTP id f16mr12835659itf.121.1543995463471;
 Tue, 04 Dec 2018 23:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20181205014213.943-1-natechancellor@gmail.com>
In-Reply-To: <20181205014213.943-1-natechancellor@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Dec 2018 08:37:32 +0100
Message-ID: <CAKv+Gu9doPESm7sb03m=55U6Md=ir8KesRmmMiBeDf+VFm98Cg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: Remove '-p' from LDFLAGS
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2018 at 02:42, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> This option is not supported by lld:
>
>     ld.lld: error: unknown argument: -p
>
> This has been a no-op in binutils since 2004 (see commit dea514f51da1 in
> that tree). Given that the lowest officially supported of binutils for
> the kernel is 2.20, which was released in 2009, nobody needs this flag
> around so just remove it. Commit 1a381d4a0a9a ("arm64: remove no-op -p
> linker flag") did the same for arm64.
>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/arm/Makefile                 | 2 +-
>  arch/arm/boot/compressed/Makefile | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index 05a91d8b89f3..e2a0baf36766 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -10,7 +10,7 @@
>  #
>  # Copyright (C) 1995-2001 by Russell King
>
> -LDFLAGS_vmlinux        :=-p --no-undefined -X --pic-veneer
> +LDFLAGS_vmlinux        := --no-undefined -X --pic-veneer
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux        += --be8
>  KBUILD_LDFLAGS_MODULE  += --be8
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 1f5a5ffe7fcf..dcd07bd24b85 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -131,8 +131,6 @@ endif
>  ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
>  LDFLAGS_vmlinux += --be8
>  endif
> -# ?
> -LDFLAGS_vmlinux += -p
>  # Report unresolved symbol references
>  LDFLAGS_vmlinux += --no-undefined
>  # Delete all temporary local symbols
> --
> 2.20.0.rc1
>
