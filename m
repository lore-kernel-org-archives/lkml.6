Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE214C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927892184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QOlS0Cs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfAWQNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:13:10 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32777 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfAWQNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:13:10 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so2413415otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2lJs6KZUlKzXCnyp12rxk610mifbXCkwmrcMc+1WLcQ=;
        b=QOlS0Cs0XaYTw91TNji89nAwkWFI4H4eaDUoaXADD8zzI4cDtLjzNbqlM2VCbIlyEF
         +bEaNUbGdg4GP+Fkk99qIxyoE2qkWq6xN7OAqIjaf6xbXjxCtKLzU2EUqIUuhIfM2fUL
         xr7E4EI23HPpn1a4wRWXkjRPVdrMmV9AUy+YYLsqY1CfeSUP0Y9rBzd+a21Pl4Ag7LHE
         2dA/kmNAJwND5O9x7QaklvXESwgNxN+DxC2EW6NQRM50+y+NTiHjCkCmvHGBWxySSxQy
         VLTPN1UShvaJI4bPWsDjzYN5LcotyJOFcQX6wPaMGLwOn6AumFJ6le8aSlvY0FybFqYm
         DCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2lJs6KZUlKzXCnyp12rxk610mifbXCkwmrcMc+1WLcQ=;
        b=PYULQZeXv2wFp3LnPBSB1NWOlCiGoTEA+zQkw3ndbKsKek5F6ooUJvVOXYwwgCsp6n
         XGlsok3AodD6aH+ByEXCI9fE6LNgw0rE8yziTimh0QZjV3imK6Cvd2mG1NCw4RCd/3Rp
         PwADz6CEuE7ZXr5CFH+11pqf2PUtI6B8sCU8Zoqgjo/dJNFTTrT3tH1SRE/fb5FYYaZA
         023daQXEIbt9bU5v26mH14+RoOqXHdlzVMumQosZpD7SzfExsd6wLEqqXlNTvmdYMSgP
         HMVbeme7c1lSCXL/lXuaw7wpXSNxsSBHhLZ5rcoRq7bVAHlIcliBV7h7/Hpcg3FVCi1k
         UZ4w==
X-Gm-Message-State: AJcUukdy5J213DuDKGNugPgO3Y+nWbCtTWUrRrdjzcknHU7lxVYOpnrI
        Tl+gIXyCLAB0li9Z9CZ4PvZAAvd1QTI6w0/HMiOopQ==
X-Google-Smtp-Source: ALg8bN66bRrGOOCpUnjjMFFHfKajJIxBjdhsV3AwAMmjBYogUjXCFVIqS8DCRlONYxsLeby8hCX3MIREr1we36MhxN0=
X-Received: by 2002:a9d:635a:: with SMTP id y26mr1722083otk.27.1548259989295;
 Wed, 23 Jan 2019 08:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20190123084912.13376-1-yuehaibing@huawei.com> <f1c0c8d3-49de-bf5d-32c1-1717ea238107@ti.com>
In-Reply-To: <f1c0c8d3-49de-bf5d-32c1-1717ea238107@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 23 Jan 2019 17:12:58 +0100
Message-ID: <CAMpxmJWMMukZ4XPcpb55EGNKoXjmaOFW9SVAT=0SxhHvtkTrzQ@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: davinci: drop pointless static qualifier
To:     Keerthy <j-keerthy@ti.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 23 sty 2019 o 11:32 Keerthy <j-keerthy@ti.com> napisa=C5=82(a):
>
> On 23/01/19 2:19 PM, YueHaibing wrote:
> > There is no need to have the 'gpio_unbanked' variable static since
> > new value always be assigned before use it.
>
> Acked-by: Keerthy <j-keerthy@ti.com>
>
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/gpio/gpio-davinci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> > index bdb29e5..f250454 100644
> > --- a/drivers/gpio/gpio-davinci.c
> > +++ b/drivers/gpio/gpio-davinci.c
> > @@ -465,7 +465,7 @@ static const struct irq_domain_ops davinci_gpio_irq=
_ops =3D {
> >
> >  static struct irq_chip *davinci_gpio_get_irq_chip(unsigned int irq)
> >  {
> > -     static struct irq_chip_type gpio_unbanked;
> > +     struct irq_chip_type gpio_unbanked;
> >
> >       gpio_unbanked =3D *irq_data_get_chip_type(irq_get_irq_data(irq));
> >
> > @@ -474,7 +474,7 @@ static struct irq_chip *davinci_gpio_get_irq_chip(u=
nsigned int irq)
> >
> >  static struct irq_chip *keystone_gpio_get_irq_chip(unsigned int irq)
> >  {
> > -     static struct irq_chip gpio_unbanked;
> > +     struct irq_chip gpio_unbanked;
> >
> >       gpio_unbanked =3D *irq_get_chip(irq);
> >       return &gpio_unbanked;
> >
>

Good catch! While it would probably never result in a race condition
as it is always called from probe(), it's still wrong so patch
applied.

Thanks,
Bart
