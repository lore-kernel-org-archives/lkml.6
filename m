Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0773214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SbfOHbVi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0773214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbeKVDTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:19:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40001 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbeKVDTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:19:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so5503523oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 08:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EIusMxrGSc1BIr0wrnhU4S6fpPtN2h+O41y+wIqsiGY=;
        b=SbfOHbViSueBDoPLs2EGvI9iH3ILhrMXbtGQdYV8E5BJm+Ms8EqtEUV5y3pojzVPfw
         rvLIR9Clh2z55RcqsmYGXY5bM0Yodiz7fRzO4jkOlCmYHXz96Oc8ITaIUelyTdzEeHQ9
         WdxRm0Om+Gqt5HebOClPFpLSfRI/YcB5mTQbZyaGPpY20zqZ01rGI0cqxdAPEF3E/Rgg
         QjOtEfoQHy2KeTLkY+K9UTXp5lyPB2JWMaBCWhT/SjqgFrjiA4mQ4VusHJoYmkPTFNzw
         vLgCErjRY2NrHjTsx2h+c9W1bKDfgKS8b5qZuCRvXKUxpfOfR9CtYhom6gNVDVjvcmmC
         5SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EIusMxrGSc1BIr0wrnhU4S6fpPtN2h+O41y+wIqsiGY=;
        b=meZgmS0oI2WVoH0Lq7plI7r6WiUt41o7z4++6TEOOWOr5nCdS5k8awul6+fu5kvQe5
         q8xRQl95ARS1laeP9D63a8En15C2WCj3HYHgT+sHbPaoL6CdNvdjbcDVgi4Vut+TDKgl
         HrXELO6zMR+O64SXTiQRdop1znHns04Tfwz6cz4Ir8H1+YzyW5JcYVruCdkrkFxkr0+x
         clgSccDP/fv3cLwvzko2kmOaODShIBa+IuOstYDdTFOWzdEPiBXjlv6sQO2+Ws25AWFj
         pJB0PKfC2P30/QuDihTfsTxc0YM/rfrag8mm7kKRHCD1cqOP/eIqwVrK1Fqw2FC9Y59X
         xrrA==
X-Gm-Message-State: AA+aEWbpNHtcCL73KRObfxsxNRXEsLIIYJnJjiUst6isapJDvng1JdGE
        FZYjimapkK5oxC7A58heja1xPIrrCkDXiP7ci4iK4Q==
X-Google-Smtp-Source: AFSGD/XIjnpa5HQB7tHoN6H827ZC/GOqbcn//05Z2Q69cQ6OYXN9o5CUJJQTV74qIS7/InPa0c//UEmAK919gtnfP4Q=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr4100344otb.236.1542818635168;
 Wed, 21 Nov 2018 08:43:55 -0800 (PST)
MIME-Version: 1.0
References: <1542818142-27800-1-git-send-email-hofrat@osadl.org>
In-Reply-To: <1542818142-27800-1-git-send-email-hofrat@osadl.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 21 Nov 2018 17:43:43 +0100
Message-ID: <CAMpxmJUNYWqk4PEKcZ5o5PMR3RhMhudK+Pf+Pfo64mvJ8ND2wQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: mt7621: handle failure of devm_kasprintf()
To:     hofrat@osadl.org
Cc:     Linus Walleij <linus.walleij@linaro.org>, matthias.bgg@gmail.com,
        sergio.paracuellos@gmail.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 21 lis 2018 o 17:39 Nicholas Mc Guire <hofrat@osadl.org> napisa=
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
> Problem located with experimental coccinelle script
>
> Patch was compile tested with: omega2p_defconfig, SOC_MT7621=3Dy,
> GPIOLIB=3Dy, GPIO_MT7621=3Dy
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>  drivers/gpio/gpio-mt7621.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index d72af6f..42f0c67 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -244,6 +244,10 @@ mediatek_gpio_bank_probe(struct device *dev,
>         rg->chip.of_xlate =3D mediatek_gpio_xlate;
>         rg->chip.label =3D devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
>                                         dev_name(dev), bank);
> +       if (!rg->chip.label) {
> +               dev_err(dev, "Could not allocate label\n");

No need for an error message here, an -ENOMEM says enough.

Bart

> +               return -ENOMEM;
> +       }
>
>         ret =3D devm_gpiochip_add_data(dev, &rg->chip, mtk);
>         if (ret < 0) {
> --
> 2.1.4
>
