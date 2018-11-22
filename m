Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAFBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DD920684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FgwjJkVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DD920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438200AbeKWDTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:19:50 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39474 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391469AbeKWDTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:19:49 -0500
Received: by mail-it1-f194.google.com with SMTP id m15so14594467itl.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRmyzSWtXB06FJQfKje3Md4E5TZ6OkvRHlicFPLZadQ=;
        b=FgwjJkVeaYtB7L/Qr0qXOSJapiA21V5g3vd++N2rs+CyqZWit1l+pVHjBiqCEfhbfe
         ye1J7LfdIPrSvRB3p3BXDOBjCpGxpsE5znbqlusSJGr2E39JxhwnRGIeAngiEPpBmYP7
         KnF1eUQShoNZyR948R3c5vjaAOd94J3KYtS5L0KCpqrujvBUgqKo5mBbNDkLusuaZont
         E41WTASXmwucrNU42ibLym8HlMm2HEW/A9qppBgsEPY9sopzh7f43a62wpMQkwBhV4wv
         7q+3kq8cFhH9r6Oev2nDZojewf/OR+W2WYhzviXRTHUYJR9ql3a/a8ranej52gTlA+yU
         Xh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRmyzSWtXB06FJQfKje3Md4E5TZ6OkvRHlicFPLZadQ=;
        b=g0HCIHungnVZ6vsY4/CNF59C+uxlFJ6Hwv+rJJjLYBJu8/BdKA86T/xxp1pdMYP3sW
         rnsVOGGfTr6qwSJ0q9x0odnpGfoHCioGcWN0fSGeD6Zxk7cchTnYHklcsxv9VGarXhyD
         tQorJwomBxNmEMs9d0U2pMuMNqsrmJDKrQT9g6dsOYNVucYuzMlJvX+XM+/FEM7OChGK
         xA8TW8+qP+El8MIKQHp3T9dIPgVYv4JqDdTq/48ODiD2uqYjANwVVYarFpt3xkPt0DN8
         w3YdEEx1wUZqDk5lYiHN+CgMxDcdJfaDjhfWapsJKDwkXGfJsN2CgFa6wKnfmaY5AuVo
         4Dfg==
X-Gm-Message-State: AA+aEWb9SHrtIMZ2E3S3ZCbtN/JPpMZnreyPeq8Md2qYsMhCItAWrnOC
        q7F2Mk1za9WZPab/Bc8vPVpr5PRq23FTPJjDpKnjJw==
X-Google-Smtp-Source: AJdET5dHZ7rdvM9OAvl4rFqmbR4E8Kc6dGCPnQt2tzH9NyEVbkgvK0OKaJ+bLsI9aZi5D3NMXfEuDzAVIFeG6Fvq1LA=
X-Received: by 2002:a24:f909:: with SMTP id l9mr9764991ith.74.1542904781310;
 Thu, 22 Nov 2018 08:39:41 -0800 (PST)
MIME-Version: 1.0
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 22 Nov 2018 17:39:30 +0100
Message-ID: <CAMRc=Mch4+wehvUE8zmofRYYL=PUmKOUJMYFbNvTqQC1C6b+YA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: mt7621: report failure of devm_kasprintf()
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
> kasprintf() may return NULL on failure of internal allocation thus the
> assigned  label  is not safe if not explicitly checked. On error
> mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> (unlikely) failure case should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> ---
>
> V2: The dev_err() for the unlikely case of the devm_kasprintf()
>     failing was removed on request from Bartosz Golaszewski
>     <bgolaszewski@baylibre.com>
>
> Problem located with experimental coccinelle script
>
> Patch was compile tested with: omega2p_defconfig, SOC_MT7621=3Dy,
> GPIOLIB=3Dy, GPIO_MT7621=3Dy
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>  drivers/gpio/gpio-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index d72af6f..1ec95bc 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -244,6 +244,8 @@ mediatek_gpio_bank_probe(struct device *dev,
>         rg->chip.of_xlate =3D mediatek_gpio_xlate;
>         rg->chip.label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
>                                         dev_name(dev), bank);
> +       if (!rg->chip.label)
> +               return -ENOMEM;
>
>         ret =3D devm_gpiochip_add_data(dev, &rg->chip, mtk);
>         if (ret < 0) {
> --
> 2.1.4
>

Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
