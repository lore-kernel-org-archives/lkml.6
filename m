Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C19FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233CE208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wDrWT2WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233CE208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbeK0Sqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:32946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeK0Sqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:46:38 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456252133F;
        Tue, 27 Nov 2018 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543304977;
        bh=P0UPadyNC7uElLRqBXxGLEWk4VOx9BdktcmmR1/lSuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wDrWT2WWPBsTcog4TinnV2IlPdIkFb/m27vTEbUt9FatjH++WH0dqnlxkmrytLphr
         DcFLbLe1GYRDyzQx54XZbJ9+DMl8DpJpuyfBjOhx+oeLabtJ3rhhwZbEa8i2nXuPow
         cuue6ZxaQASlGFH2qIpzAfZDrTKyXXlb6eyP3Azs=
Received: by mail-wm1-f44.google.com with SMTP id s11so21138217wmh.1;
        Mon, 26 Nov 2018 23:49:37 -0800 (PST)
X-Gm-Message-State: AA+aEWYcCZPEwgV8K/VE+sHCFmDRJd7t1QftO4wqO4fJ8T/B4/ZFIfXT
        5k7+l8vXlMYDifP5Dtltrf+JDohJwUyV23QtYZk=
X-Google-Smtp-Source: AFSGD/UPYPchpSKU3EfBi2IggsD+k7EEw9zc8Rxf3ZjSoNFqP4IpZmUM0m0RV0MIC88aYb33474fn8LNC4Ahyppl38U=
X-Received: by 2002:a1c:b406:: with SMTP id d6mr4692681wmf.129.1543304975695;
 Mon, 26 Nov 2018 23:49:35 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org> <1542823573-20228-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-2-git-send-email-hofrat@osadl.org>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 26 Nov 2018 23:49:26 -0800
X-Gmail-Original-Message-ID: <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
Message-ID: <CAGp9LzoT7ueXyyVSYQdWOU0JkQDWMVcwCuSE3gJnEn0fLLjCBA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
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

Nicholas Mc Guire <hofrat@osadl.org> =E6=96=BC 2018=E5=B9=B411=E6=9C=8821=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8810:13=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> The error cases of mediatek_gpio_bank_probe() would go unnoticed (except
> for the dev_err() messages). The probe function should return an error
> if one of the banks failed to initialize properly.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> ---
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
> +               if (!ret)

it should be if (ret < 0) ?

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
