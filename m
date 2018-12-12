Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DEAC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F7C20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544644406;
	bh=BYgV/+3DcIdkFyzb3CQNEnDGu6LB+hzzCchKujS2hn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WzZNih4uYEwcL+/UZe00LCBGqRvNobNPS0W2EkQDZZ/9QFuNV59bTvGT5GL+YmcUD
	 +RQWmXXsns9Fb8ll9DnfxBCJeSz06MQ+Rs+XV8K4wwzJHvC95ZpM4JLG39ILUs1R1O
	 dnviiLm51ZaRBWXktAMWINkntWle7Jcj5tg7p2+0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F7C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeLLTxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:33856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeLLTxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:53:24 -0500
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F3E20873;
        Wed, 12 Dec 2018 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544644403;
        bh=BYgV/+3DcIdkFyzb3CQNEnDGu6LB+hzzCchKujS2hn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJEF/grX90WeAxTUwKv5hE4zPaTnF3S3BgywcmFHwQJQ//iSgFM127ndJlkaAwY/S
         C4WEcTLfoPRwQFZW5snPxrbthlD4v4OAvahVdQri4HLBWav9G2tQb4/Zp1MqTMLEYV
         1+LFOMUxS34sPm754jmWi7t4elSHb7QSDz0K1KHI=
Received: by mail-wm1-f52.google.com with SMTP id c126so93780wmh.0;
        Wed, 12 Dec 2018 11:53:22 -0800 (PST)
X-Gm-Message-State: AA+aEWZ5ewwnIJGoH5F8bXc7nnfiqHLbWXGYwv7+HlmvAG+ejDR8XQDa
        PMsuPijuxY8C6pVRztWlaUEYJXTSzbc0FVax4ZQ=
X-Google-Smtp-Source: AFSGD/VrVpuI1Q7N+eDOG3tCtP0hLvUL4czloT4v6TZZCSn7tOJz/ePRa4m6pvq/9rA3L3CbJgOiZOgKEDhu3v/+irA=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr7914496wmh.92.1544644401276;
 Wed, 12 Dec 2018 11:53:21 -0800 (PST)
MIME-Version: 1.0
References: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
In-Reply-To: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 12 Dec 2018 11:52:48 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzqz6ZpbZ+241HKGZxLA7EwBnw+6s2EgTy3VXaoh6Xo6Hg@mail.gmail.com>
Message-ID: <CAGp9Lzqz6ZpbZ+241HKGZxLA7EwBnw+6s2EgTy3VXaoh6Xo6Hg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: mediatek: improve dependencies for PINCTRL_MTK_MOORE
To:     =?UTF-8?B?UnlkZXIgTGVlICjmnY7luproq7op?= <ryder.lee@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        weijie.gao@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 1:59 AM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Improve dependencies for the pinctrl drivers which select
> PINCTRL_MTK_MOORE as its core layer.
> ---
>  drivers/pinctrl/mediatek/Kconfig | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index d8cb584..3a41dc8 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -23,6 +23,7 @@ config PINCTRL_MTK_MOORE
>         select GENERIC_PINCTRL_GROUPS
>         select GENERIC_PINMUX_FUNCTIONS
>         select GPIOLIB
> +       select EINT_MTK

The change can be taken away from the patch as the patch EINT_MTK is
optional to the moore core.

>         select OF_GPIO
>
>  config PINCTRL_MTK_PARIS
> @@ -45,14 +46,14 @@ config PINCTRL_MT2701
>  config PINCTRL_MT7623
>         bool "Mediatek MT7623 pin control with generic binding"
>         depends on MACH_MT7623 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7623
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT7629
>         bool "Mediatek MT7629 pin control"
>         depends on MACH_MT7629 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default MACH_MT7629
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT8135
>         bool "Mediatek MT8135 pin control"
> @@ -93,8 +94,8 @@ config PINCTRL_MT6797
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
>         depends on ARM64 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_MOORE
>

We can add a change allowing PINCTRL_MTK_MOORE to be a non-visible
symbol in the same patch according to the general rules
kconfig-language.txt defines. And also turn PINCTRL_MTK_PARIS to
non-visible in another patch would be good.

Apart from that, the above three changes are fine with me, it helps to
be more consistent with other driver and the target SoC would be
coupled with the corresponding essential pinctrl driver.

>  config PINCTRL_MT8173
>         bool "Mediatek MT8173 pin control"
> --
> 1.9.1
>
