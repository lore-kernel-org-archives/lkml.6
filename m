Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776922081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 01:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eL3X1wYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeLaBIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 20:08:47 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:17409 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbeLaBIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 20:08:47 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id wBV18WCf009935
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 10:08:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com wBV18WCf009935
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546218513;
        bh=JLP+EVt919toIhoySfufQZmmr8QvC/jh0wLEsCsZQFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eL3X1wYYnvJqcJFkWE6inBuoovKudMfdj7vTECC3X3pZekfH9eXfiGeU7xHE8XM8U
         6MoIayeq/4OHpk3kHa/eunLVS9pvmoa7/gS5W0X1uIHBfJyLZN7FvVnGhIaXQQp35H
         9M1jI9qx6zW+jpKGb64MaEtO6hWXzFtZPho/mnL+CJG8B1QujMD2cAPVt3io7AyIdn
         Sce2gl/jBuuOv9gkMVkq+Sn1dqcJzzUQQDrJP14v22ehEsBhROu7UUoLdFVxKO2ffC
         bQ3sfomU3jvgC99+WCMHd6RXCh5qWiDm5lcal+ixeYZ+ghgroYgtMDAYrRPkadzgSM
         iK/JYN5IZ+kFw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id p74so15919646vsc.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 17:08:33 -0800 (PST)
X-Gm-Message-State: AA+aEWaPTGDbfgfe8x9V65DHN6SKf44rnS9PkgA0CeUhc3b+CKmGqV6V
        PfCZ6ipJsseodLfaR3bnOSN06pF9XIqfcglpsJk=
X-Google-Smtp-Source: AFSGD/UNSaPJzDuLbP6xURS75tXRPZq+9OUgz7VoYp06vFqhtl7YOgHCdT7O4aOzd5sj3Vbq3jTY4E+iZ4q6lblV76E=
X-Received: by 2002:a67:a858:: with SMTP id r85mr14187186vse.215.1546218512147;
 Sun, 30 Dec 2018 17:08:32 -0800 (PST)
MIME-Version: 1.0
References: <1543218130-5800-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543218130-5800-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 31 Dec 2018 10:07:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8X8R0Xc9HfmMDmGEse1PNVLrNhqXgcu30ByvjjuOxyg@mail.gmail.com>
Message-ID: <CAK7LNAQ8X8R0Xc9HfmMDmGEse1PNVLrNhqXgcu30ByvjjuOxyg@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove unneeded HAS_DMA define
To:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 4:43 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> kernel/dma/Kconfig globally defines HAS_DMA as follows:
>
>   config HAS_DMA
>           bool
>           depends on !NO_DMA
>           default y
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>  arch/nios2/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 7e95506..69c4af1 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -37,9 +37,6 @@ config GENERIC_CALIBRATE_DELAY
>  config NO_IOPORT_MAP
>         def_bool y
>
> -config HAS_DMA
> -       def_bool y
> -
>  config FPU
>         def_bool n
>
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
