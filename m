Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA393C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802E320989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548737964;
	bh=CeLuN0McvnCGe38oF81pKGW5d9TS5ez+UchVhZOt4m8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1YSXsNrP/kF8J4jxPUpy5hBsuIcuzZWNLvdLRKyN5ydfpQqodzZCDmgE+4Wu73aTR
	 WuaKio0p1kFVj+H1IPR5n7lge0zgIW6rEvROtLgYM6/NDgYwyedd7LTfiR+4wUV0fp
	 e0a1vtu+enQW2UZ6xxJ3cOYJWKKA0bks5oE74hKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfA2E7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfA2E7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:59:22 -0500
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ADC8217F5;
        Tue, 29 Jan 2019 04:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548737961;
        bh=CeLuN0McvnCGe38oF81pKGW5d9TS5ez+UchVhZOt4m8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v/gwvdva3OHF0eZ2nDZY6749cNZ0NzQ7k59/awuPmwhSXZiEsE7bFW7r7P9Rxnd0P
         A51Yt+W25vEOzC2Uu2xp9Lfgd4MaZqSkljowE9khj33OvSfioxDvNNmPnYQ76iJxgg
         HL5ZSJcqNklU4H5HPn3je7qUR97edUVz0ufZ/C6c=
Received: by mail-wm1-f47.google.com with SMTP id d15so16325831wmb.3;
        Mon, 28 Jan 2019 20:59:21 -0800 (PST)
X-Gm-Message-State: AJcUukewDdffk0krGOx+4l+yLADY1ZFxOL3CLYOgZ+6u5461oWetDCSK
        /vDAjJkP6GFTvUCFJiAeefRssrd7Gh7N4yc6eTI=
X-Google-Smtp-Source: ALg8bN5NvYxieaQOYfQ+LbULym89D+Or6inidv/e+8OvybVsvFydwB9lBvaVwXSD/sYldf6Yg6eozb+vwm21xpzvjmc=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr18922742wmc.129.1548737960035;
 Mon, 28 Jan 2019 20:59:20 -0800 (PST)
MIME-Version: 1.0
References: <20190128223521.2690-1-voytikd@gmail.com>
In-Reply-To: <20190128223521.2690-1-voytikd@gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 28 Jan 2019 21:02:04 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Message-ID: <CAGp9LzoVZQx2fb-ETY=sGBB3Xx81jC8t2krczv7h=dVNE-ph2Q@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: fix dependencies for PINCTRL_MT76XX
To:     Dmitry Voytik <voytikd@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 2:35 PM Dmitry Voytik <voytikd@gmail.com> wrote:
>
> How to reproduce the problem:
> $ make tinyconfig
> $ make menuconfig
> then enable:
>  CONFIG_COMPILE_TEST=y
>  CONFIG_PINCTRL=y
> and any of these:
>  CONFIG_PINCTRL_MT7622=y
>  CONFIG_PINCTRL_MT7629=y
>  CONFIG_PINCTRL_MT7623=y
>
> This combination causes build failure.
>
> Fix the problem by making PINCTRL_MT76XX to depend on CONFIG_OF=y.
>
> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 1817786ab6aa..a005cbccb4f7 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -45,12 +45,14 @@ config PINCTRL_MT2701
>  config PINCTRL_MT7623
>         bool "Mediatek MT7623 pin control with generic binding"
>         depends on MACH_MT7623 || COMPILE_TEST
> +       depends on OF
>         default MACH_MT7623
>         select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT7629
>         bool "Mediatek MT7629 pin control"
>         depends on MACH_MT7629 || COMPILE_TEST
> +       depends on OF
>         default MACH_MT7629
>         select PINCTRL_MTK_MOORE
>
> @@ -92,6 +94,7 @@ config PINCTRL_MT6797
>
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
> +       depends on OF
>         depends on ARM64 || COMPILE_TEST
>         default ARM64 && ARCH_MEDIATEK
>         select PINCTRL_MTK_MOORE
> --
> 2.20.1
>

It seems the commit 2d2d478576d71000b29c52668c5712c825ee9af8 already
fixed the problem or is there something I'm missing?
