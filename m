Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3DEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54A208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0V197y76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D54A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeK1Hht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:37:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeK1Hht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:37:49 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95AA72145D;
        Tue, 27 Nov 2018 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543351122;
        bh=OrKIgcXat3dDm6mzK4AX60q00jnPz3jrpeSERtos1lM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0V197y76KG7CQq+Nt9ZCCJuOSoB76rYNci9agEN2Baj6WKN6DQDHjPKwUEtqv/WCf
         OZ6q9AkFGp0jc3JG2U5EMX5IvZDW1jPYncPKHjcQtSa9qx3vYX2gvyclDqwhYBkhQf
         Auo7tXGD79oFdMpr6zk52eEVfop7eqhI4J/d+ggw=
Received: by mail-wm1-f48.google.com with SMTP id y1so364594wmi.3;
        Tue, 27 Nov 2018 12:38:42 -0800 (PST)
X-Gm-Message-State: AA+aEWb/LoJ0ZuaUkbsMmnEv+gQJHlxP2vmkkFdft00EC3LRn0HMfVne
        2Cl/1vmVb+3SHreXJahznwCwDRShFfaaE2StT/4=
X-Google-Smtp-Source: AFSGD/WVXU+N/N9Ljxtxr3WiuE3GdHtkPDeYVv3yi+ZUwbros4SduyOMr0aXV3wyRAsCRKcvIAYvfGGY+C8uaz81CVQ=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr374576wmh.92.1543351121070;
 Tue, 27 Nov 2018 12:38:41 -0800 (PST)
MIME-Version: 1.0
References: <1543338018-708-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1543338018-708-1-git-send-email-hofrat@osadl.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Tue, 27 Nov 2018 12:38:29 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzp=D72LZCk-h5XU9V2DePLHKTRCmioKEjZRjHGW6P_y6g@mail.gmail.com>
Message-ID: <CAGp9Lzp=D72LZCk-h5XU9V2DePLHKTRCmioKEjZRjHGW6P_y6g@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
 up the stack
To:     hofrat@osadl.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        sergio.paracuellos@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Mc Guire <hofrat@osadl.org> =E6=96=BC 2018=E5=B9=B411=E6=9C=8827=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:07=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> for the dev_err() messages). The probe function should return an error
> if one of the banks failed to initialize properly indicated by
> not returning non-0.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Sean Wang <sean.wang@kernel.org>

> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> ---
>
> V2: A logic error spoted by Sean Wang <sean.wang@kernel.org> the
>     success case is 0 and thus returning early should be on on
>     ret!=3D0 and not on !ret - thanks for catching this stupid mistake !
>
> Patch was compile tested with: omega2p_defconfig, SOC_MT7621=3Dy,
> GPIOLIB=3Dy, GPIO_MT7621=3Dy
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>  drivers/gpio/gpio-mt7621.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index 1ec95bc..68fca8b 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -297,6 +297,7 @@ mediatek_gpio_probe(struct platform_device *pdev)
>         struct device_node *np =3D dev->of_node;
>         struct mtk *mtk;
>         int i;
> +       int ret;
>
>         mtk =3D devm_kzalloc(dev, sizeof(*mtk), GFP_KERNEL);
>         if (!mtk)
> @@ -311,8 +312,11 @@ mediatek_gpio_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, mtk);
>         mediatek_gpio_irq_chip.name =3D dev_name(dev);
>
> -       for (i =3D 0; i < MTK_BANK_CNT; i++)
> -               mediatek_gpio_bank_probe(dev, np, i);
> +       for (i =3D 0; i < MTK_BANK_CNT; i++) {
> +               ret =3D mediatek_gpio_bank_probe(dev, np, i);
> +               if (ret)
> +                       return ret;
> +       }
>
>         return 0;
>  }
> --
> 2.1.4
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
