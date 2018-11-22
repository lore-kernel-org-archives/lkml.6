Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B47C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D2120684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="dCGgTr1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D2120684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbeKWDYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:24:54 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44487 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389348AbeKWDYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:24:53 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so6990471iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YxlPOiV22RfNMQEloQv2e9ZPx45lrowLd1cOOLHxrU8=;
        b=dCGgTr1V8PBHi8oIVJDOQ1IVFfJlAUkf50rik4u2/Y/KLofqvdlEtaPVZ+x6BkWV/z
         M/al7IMHvu8xyI2PXXjHQfxbRY3cFX+rqcbbPDm8S0GgIyf7bDIXDjgu7C1ZctvGDJQx
         Cv5mKF8ySNLqlkCKRmjJYsg2kkue3CN08wNtwcnb1rxJK1Nra7Hqu5Xv6CbzaJ/6O0Xu
         jwtX117M94xn+IHp00yI8C8NTqEb6KSYvIgxDdJJcruO0/ayn38WUUXI1j4MGb7APNwQ
         EcmhreAiBfxJCP+E6uGfxopmM/zv80CDUb3+c6wdaWwGxRgYT1cyMqfS5GNQm+EjopFf
         e5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YxlPOiV22RfNMQEloQv2e9ZPx45lrowLd1cOOLHxrU8=;
        b=UI5sJTmXsoEgUOIgqgyjBSOW9uSGGtT4LXuvuSVm7LqncnWskuM5uv13/YYsZOdWIm
         D5VE1sgEZUGKowEH4BWGHAxqN+yip9U8xIppfYsesLyxIJ8aXqu6TVCoVUQTGJg2gP0U
         vvq+dBqdxBu4/8vFkoKlFGRsQfpkAnRSqSh93nzVLpXp3AQl0jDOtzvo2cYOc6IZyHXb
         j556dgWgrJwcgFFURJsKBII+P34pKdqwMRQcq8x+bu51ttLkR7ilLsQBntd7XZs35fS7
         e6/LPEqd9DpCfA7KpZeG0YjlAedvM+TaxjVf1Y3znjkogaHuylzRJwIU9OQ9mi7L5e7o
         4txQ==
X-Gm-Message-State: AA+aEWb7h4vIpHKEBC39xhgMdTfMT5cveBTNdlDi9FyiT5M5CFFYhvvs
        wlDfICvfbRZwXIbyZN8gtForYeM0PBaLEy8WM+J7LA==
X-Google-Smtp-Source: AFSGD/UBK8icDnI4WXk6RTOsuSpm9kIZleGuvsbb1SrfWZZ2x/fKwzOQ+KfnlIcRX5Zbe3F8qN71c7U/Ou4cIRZqXyo=
X-Received: by 2002:a5e:8d13:: with SMTP id m19mr8679747ioj.258.1542905084256;
 Thu, 22 Nov 2018 08:44:44 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org> <1542823573-20228-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-2-git-send-email-hofrat@osadl.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 22 Nov 2018 17:44:33 +0100
Message-ID: <CAMRc=MfcKOnDTEkTpe7X7vRq2PjV=fST7qjef+tbV8Tv-kWELQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: mt7621: pass mediatek_gpio_bank_probe() failure
 up the stack
To:     hofrat@osadl.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        sergio.paracuellos@gmail.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 21 lis 2018 o 19:13 Nicholas Mc Guire <hofrat@osadl.org> napisa=
=C5=82(a):
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
> +                       return ret;
> +       }

Looks like are resources allocated in mediatek_gpio_bank_probe() will
be freed automatically so:

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
