Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8F22081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjAd73s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8F22081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeKFRkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:40:07 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37472 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbeKFRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:40:06 -0500
Received: by mail-it1-f196.google.com with SMTP id j79-v6so4552315itb.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 00:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EryubihZoKULAjl30o3HEqReVvgd3gLMapyF8iRD4k8=;
        b=XjAd73s8HrgLzNQWXLrwS/ayqgGXuhkDTCGAmnbHB5OvBPwUt9y1KYLUc+3glqIAmc
         TMduL///K9L2BzkmJ+mR46a2dVkk6orgBJRbCQvE2XE9iHyzDSIpUp6KrlK3o03/dolv
         2nL7eXRrBQGtWvKS0PWGaYVqxEQshj/jk0dMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EryubihZoKULAjl30o3HEqReVvgd3gLMapyF8iRD4k8=;
        b=PdwfVK9N68LOUSjq3SzFRBXo8bGIeOBU53shC25nkO39dsAhRxywUCIcSUvt2hTgqM
         Sa0cGqWyUaavKxBK27CT75vwRxSxHX3tCe5Mc6UaC+NaK7ClCgi0MDZPQxoU7p2X85B3
         lR04O8FwZEK6P06kw/q/4k9p1trNpGCjxkBbusa52AGgCFkS7ApAJCMgIO8jNb6cpXyL
         z8vwPUOUnAvFTkX7DZPaIxQnAKbEQO73p0AM429DrVo+tGmli6Km6trQuEFe4l3PaFHV
         cmn0PRr6ZlZPvA9ZvK0FhFgkKydIztV8gsmZ+LPHHZOaQ6WrXh3ek4k4NexZJSyy23PL
         Xswg==
X-Gm-Message-State: AGRZ1gJjmSN9peKyQ8Tiv0pIBGeFfw7dJkvj9j737R5ZHApWAmYgvD8F
        HnG0LbiNeNv2/7YYeMhjqf6aCuDj9OwmbcebNGSBCw==
X-Google-Smtp-Source: AJdET5dCCZZaPRoeWGx5XcWAsgIVzAXrCjfIAcv2qxhBvj4RBct49/vka0dTYFHxj3EGy3YEVTi6v6chxeEjShVihj0=
X-Received: by 2002:a05:660c:383:: with SMTP id x3mr1029852itj.121.1541492164826;
 Tue, 06 Nov 2018 00:16:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Tue, 6 Nov 2018 00:16:04 -0800 (PST)
In-Reply-To: <20181106001441.42934-1-jeremy.linton@arm.com>
References: <20181106001441.42934-1-jeremy.linton@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 6 Nov 2018 09:16:04 +0100
Message-ID: <CAKv+Gu_i_Oaee_JTEuVd+yVsSzj-_ULUKp_NmMGT3Xh+oQBZKw@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: Fix arm64 test build
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matthew.brown.dev@gmail.com, Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Catalin, Will)

On 6 November 2018 at 01:14, Jeremy Linton <jeremy.linton@arm.com> wrote:
> The lib/raid6/test fails to build the neon objects
> on arm64 because the correct machine type is 'aarch64'.
>
> Once this is correctly enabled, the neon recovery objects
> need to be added to the build.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  lib/raid6/test/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/raid6/test/Makefile b/lib/raid6/test/Makefile
> index 5d73f5cb4d8a..79777645cac9 100644
> --- a/lib/raid6/test/Makefile
> +++ b/lib/raid6/test/Makefile
> @@ -27,7 +27,7 @@ ifeq ($(ARCH),arm)
>          CFLAGS += -I../../../arch/arm/include -mfpu=neon
>          HAS_NEON = yes
>  endif
> -ifeq ($(ARCH),arm64)
> +ifeq ($(ARCH),aarch64)
>          CFLAGS += -I../../../arch/arm64/include
>          HAS_NEON = yes
>  endif
> @@ -41,7 +41,7 @@ ifeq ($(IS_X86),yes)
>                     gcc -c -x assembler - >&/dev/null &&        \
>                     rm ./-.o && echo -DCONFIG_AS_AVX512=1)
>  else ifeq ($(HAS_NEON),yes)
> -        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o
> +        OBJS   += neon.o neon1.o neon2.o neon4.o neon8.o recov_neon.o recov_neon_inner.o
>          CFLAGS += -DCONFIG_KERNEL_MODE_NEON=1
>  else
>          HAS_ALTIVEC := $(shell printf '\#include <altivec.h>\nvector int a;\n' |\
> --
> 2.17.2
>
