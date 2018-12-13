Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C0C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5869E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544674895;
	bh=W14iNjL5prFtXssrAezogBdWYOtqCQcslOu1nXO2DPI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pihsoYJ9l5e3pmGxXP62J3F4xKX5dFE+M35ztObcuyH/4m8CX5mtf/XSbel4gPDNq
	 BoQitcwLXJa6KGYmaOSlwdZKJVNHDQmkb04IufTCOjbyQbCP0lvYqq5zzFctsJTJ2F
	 zuOMmv0cqbTGITbS2I/XwGzunQzVp+Nceux1U3cY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5869E20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeLMEVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:21:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLMEVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:21:33 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F58120873;
        Thu, 13 Dec 2018 04:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544674892;
        bh=W14iNjL5prFtXssrAezogBdWYOtqCQcslOu1nXO2DPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DQINxOMOOCFIuAe2R4TB6ZnzeW3Ezuo3snFQfJm5vi6IKT48y0cVyYRrsOsB47Udd
         Xzws+IyRtWWtwXBzhaHIG3J1aIMo7y9qjnhSNM9fvF6QOqBEd9/Gqvz/4uxRfnAAc/
         12FcqbKYMtOfIbTXLfCmP0RW7GnIJvcBXajNEG4s=
Received: by mail-wm1-f43.google.com with SMTP id n190so929533wmd.0;
        Wed, 12 Dec 2018 20:21:32 -0800 (PST)
X-Gm-Message-State: AA+aEWYZ0uAkorIpdb0g3qgicBZGdU/taUDhYl0C8rvHrxIQWHVDkAOx
        YJuAekjpzkurFGaLXAyCdmDgW/096FGcTOk8ej8=
X-Google-Smtp-Source: AFSGD/WqpPeGLayPIhjYGwhngaZHSOvb9r2Rsqf3CKrLR38I1BFy6vfuMSd5MfSw3shFHTrqMoMCmBqO6zlPh3fD85g=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr8940947wmu.52.1544674891066;
 Wed, 12 Dec 2018 20:21:31 -0800 (PST)
MIME-Version: 1.0
References: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
In-Reply-To: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 12 Dec 2018 20:21:04 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrQoLNonZDHqCJqV8iihxhB1u4vu23HORO0GbN4fz7xzQ@mail.gmail.com>
Message-ID: <CAGp9LzrQoLNonZDHqCJqV8iihxhB1u4vu23HORO0GbN4fz7xzQ@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
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

It looks good to me. Thanks for bringing the improved version soon.

Acked-by: Sean Wang <sean.wang@kernel.org>

On Wed, Dec 12, 2018 at 6:28 PM Ryder Lee <ryder.lee@mediatek.com> wrote:
>
> Remove prompts to make all pinctrl cores to non-visible symbols and
> make sure the target SoCs would be coupled with the corresponding
> cores.
>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> Changes since v1:
> - Revise commit message
> - Change all pinctrl cores to non-visible symbols
> - Drop EINT_MTK in PINCTRL_MTK_MOORE
> ---
>  drivers/pinctrl/mediatek/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index d8cb584..1817786 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -17,7 +17,7 @@ config PINCTRL_MTK
>         select OF_GPIO
>
>  config PINCTRL_MTK_MOORE
> -       bool "MediaTek Moore Core that implements generic binding"
> +       bool
>         depends on OF
>         select GENERIC_PINCONF
>         select GENERIC_PINCTRL_GROUPS
> @@ -26,7 +26,7 @@ config PINCTRL_MTK_MOORE
>         select OF_GPIO
>
>  config PINCTRL_MTK_PARIS
> -       bool "MediaTek Paris Core that implements vendor binding"
> +       bool
>         depends on OF
>         select PINMUX
>         select GENERIC_PINCONF
> @@ -45,14 +45,14 @@ config PINCTRL_MT2701
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
> @@ -93,8 +93,8 @@ config PINCTRL_MT6797
>  config PINCTRL_MT7622
>         bool "MediaTek MT7622 pin control"
>         depends on ARM64 || COMPILE_TEST
> -       depends on PINCTRL_MTK_MOORE
> -       default y
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_MOORE
>
>  config PINCTRL_MT8173
>         bool "Mediatek MT8173 pin control"
> --
> 1.9.1
>
