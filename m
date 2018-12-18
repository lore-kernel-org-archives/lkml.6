Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0067AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9026217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="AAdnqlM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbeLRNIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:08:53 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34897 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeLRNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:08:53 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so4163963itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 05:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YG/noF5r6WrVPI0SHnz7dCop6MuyGFe2j9giV5trjck=;
        b=AAdnqlM7fYQ8tMx630IQpcXdKfh2sagOr91HKUjzh7uGctzI2Zf317BOQnOv3897St
         VS5nYhhQ79OPMlBnvCCH4GBv5Rwpch8zGBcRyFuG2XVWcdmVqCCwz53dMJxOZhd48hWO
         VlE00UBAsn1oN4rRAUBig3Lmu8M3sb9dJY03L6anwu1ggq0/ZfUPQN++LV1Al+Z9ogay
         DXCZ9VEp/fk3K0wIQbd8v1kCnMjHwQ5ZV3RmnIjyi8NX6xx8EXmhc1EfJWj8aYswbcfg
         pLgVWCvhebYXxlTijrsS6YRvTMxUcPT4xWrYRIsa296nnJbTeb8/WhtlZio+ZxSsJVzL
         fuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YG/noF5r6WrVPI0SHnz7dCop6MuyGFe2j9giV5trjck=;
        b=AdAL6KwDiREDn1M5M96KTk03RLv0ruDfMo7NYrXMnwE6/dhg+D7MjN54EdGqx5I7bO
         LOClqvryX2f/j3V/n70G1tKUUZI5RJXrU3tEmZBJbq5pKF2gBmCdkTVqLj1jtFYkS0FE
         u7X4nc66HNY/Un4eM6CHrCoLLhdlCf+rfL7x2cTME0F13uismnjfrxCZNzMJUaTDDtld
         NGGfLxZXmvK9W1PH4bdHP/S3L2sfFew2OJMZHkE/TBBCs3u7mnRODJrAPJUeFwyn+dwA
         sIjms8hWUQfOSkJ+aPQNl281dyc4vyerRXGAA3c++RlNqRPjyY6P3qKywfZLxasWi1+b
         bwfA==
X-Gm-Message-State: AA+aEWYOVCBb0uTQQfFPTJG5rCRevRxVr8lI4C89yduKAshS89n/FBuE
        hkPiZ+1eJGkCBU2IaQzU9R6154yPl6N9+jhJzAGeAw==
X-Google-Smtp-Source: AFSGD/UJuaU1fUfwc+gZrg9zFpkR3yaPQZnFNErdBmNeVxlRoOPE59bORX/+FHQrXGw/5K/DDkQgd4lZ+prpXDuKvoE=
X-Received: by 2002:a24:f909:: with SMTP id l9mr2668293ith.74.1545138532086;
 Tue, 18 Dec 2018 05:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20181218105813.GA6957@localhost.localdomain>
In-Reply-To: <20181218105813.GA6957@localhost.localdomain>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 18 Dec 2018 14:08:41 +0100
Message-ID: <CAMRc=MexeOcqNgMr1Vq=T1NTeizP20fj3vx3EwxQNv20Cc6bAw@mail.gmail.com>
Subject: Re: [PATCH] regmap: regmap-irq: Remove default irq type setting from core
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, ldewangan@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 18 gru 2018 o 11:58 Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> napisa=C5=82(a):
>
> The common code should not set IRQ type. Read HW defaults to the
> cache at startup instead of forcing type to EDGE_BOTH. If
> default setting is needed this should be done via normal
> mechanisms or by chip specific code if normal mechanisms are not
> suitable for some reason. Common regmap-irq code should not have
> defaults hard-coded but keep the HW/boot defaults untouched.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> So let's try removing the hard-coded default setting from generic
> regmap-irq code as discussed with Mark here:
> https://lore.kernel.org/lkml/20181217180722.GG27909@sirena.org.uk/
>
> Core code should not care about the default trigger level - such
> settings should be done by code which knows the target
> platform/board.
>
> I was not able to test this change as I have no max77620 which seems to
> be the only user of regmap-irq type-setting in tree as of now.
>
> The patch was created on top of the regulator-next tree, with
> "regmap: irq: handle HW using separate rising/falling edge interrupts"
> from Bartosz Golaszewski cherry-picked. This should still cleanly apply
> on regmap-tree.
>
>  drivers/base/regmap/regmap-irq.c | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regma=
p-irq.c
> index 603b1554f81c..8b216b2e2c19 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -625,26 +625,20 @@ int regmap_add_irq_chip(struct regmap *map, int irq=
, int irq_flags,
>         }
>
>         if (chip->num_type_reg && !chip->type_in_mask) {
> -               for (i =3D 0; i < chip->num_irqs; i++) {
> -                       reg =3D chip->irqs[i].type_reg_offset / map->reg_=
stride;
> -                       d->type_buf_def[reg] |=3D chip->irqs[i].type_risi=
ng_mask |
> -                                       chip->irqs[i].type_falling_mask;
> -               }
>                 for (i =3D 0; i < chip->num_type_reg; ++i) {
>                         if (!d->type_buf_def[i])
>                                 continue;
>
>                         reg =3D chip->type_base +
>                                 (i * map->reg_stride * d->type_reg_stride=
);
> -                       if (chip->type_invert)
> -                               ret =3D regmap_irq_update_bits(d, reg,
> -                                       d->type_buf_def[i], 0xFF);
> -                       else
> -                               ret =3D regmap_irq_update_bits(d, reg,
> -                                       d->type_buf_def[i], 0x0);
> -                       if (ret !=3D 0) {
> -                               dev_err(map->dev,
> -                                       "Failed to set type in 0x%x: %x\n=
",
> +
> +                       ret =3D regmap_read(map, reg, &d->type_buf_def[i]=
);
> +
> +                       if (d->chip->type_invert)
> +                               d->type_buf_def[i] =3D ~d->type_buf_def[i=
];
> +
> +                       if (ret) {
> +                               dev_err(map->dev, "Failed to get type def=
aults at 0x%x: %d\n",
>                                         reg, ret);
>                                 goto err_alloc;
>                         }
> --
> 2.14.3
>
>
> --
> Matti Vaittinen
> ROHM Semiconductors
>
> ~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

Works with my work-in-progress max77650 driver that uses the new
type_in_mask flag.

Tested-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
