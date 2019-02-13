Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E5C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1DF222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EFA7WHEV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfBMJf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:35:59 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36875 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732231AbfBMJf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:35:57 -0500
Received: by mail-it1-f196.google.com with SMTP id l131so4120670ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IGFucyNPVieMLaVnWkuy5Tzc3BWUfQMsBVB3yZegDnM=;
        b=EFA7WHEVMnZDRaiXqDsgW2imJn/dwQcsTVmMzQYEU/3mC5z5P1J3NitrL+RQFJhSk+
         ZvYA0qxV+GhWvJyzW5QREGr9aRqQbsCBf13UhxCSMkZiq9OSIvZL4BWA7pmZJ6JgXm1x
         nBD29OtRlOLBW/BlW8LhatoL4sdJwyEdnEac1QFDzSY4fVy1Bz7MrwC57f9i7fcmgjOo
         BKV/axm1Q4tlfw726gM/D3dNGvjkZL1SlKOrkMvtZ9h+rM5N+b5jONKx7dC9cqoEzCBI
         E2xCi2D4CCMVSSZfQX26HZAkNai6JdIQTN2ghJhSEkpu8t7Wpe8c7O17PWH5eco7yzKp
         BD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IGFucyNPVieMLaVnWkuy5Tzc3BWUfQMsBVB3yZegDnM=;
        b=Q1GAAwMj475Ey/Lua4qfhavCo693ns4h/xeIoulfe44/uR+OSHzpJdPGbTBPizOgK9
         COlyLI5AIpCOgifMOAXgJNQHWOJhetrtEhU6k6zrJDZhk73h5huJoSRf/8UvSP9hnpkQ
         eFOAxmSfDx5O1P9z2cpLqswZLv/lLNJclG2JU21w6PZUkzhhAs3l2/CxmUaBHLnvrB/m
         kThpwuY1qmpq/1CDfINXd/dLOkwbrEKN8qMhqC0VQsWbV6QGTfrrOpsm+CXag5qgbUDt
         EUkT6XrN/2CmPRU9Kvf2pyvIOF6QcShgtWD66wqIfKuBbRWflkweXSTy7lE01gCjdGn6
         ptAg==
X-Gm-Message-State: AHQUAuZY+qSZGoDEzrH500R5UVurNNdW+hMAUweueBJAmm9Kh4IRbRye
        AcTDgm5F/+D14YXJSJrzkpnbg1Eamd3bNzWSPJor5g==
X-Google-Smtp-Source: AHgI3IaLNR53mtTEIOAfxomSAoZ+WD9btViYKITb6770K82JlRHDDwNfAbMMuLsM2Xxccv7KT80NkH0dZ3Wtxm8fcPw=
X-Received: by 2002:a24:9795:: with SMTP id k143mr1567414ite.74.1550050556697;
 Wed, 13 Feb 2019 01:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20190205091237.6448-6-brgl@bgdev.pl> <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell> <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell> <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell> <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
 <20190212132016.GA4781@dell> <20190213092553.GE1863@dell>
In-Reply-To: <20190213092553.GE1863@dell>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 13 Feb 2019 10:35:45 +0100
Message-ID: <CAMRc=MeTMq_GWzQB6LBvts1csMftj=On5sB22jsJZzQzONxbNg@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 13 lut 2019 o 10:25 Lee Jones <lee.jones@linaro.org> napisa=C5=82=
(a):
>
> On Tue, 12 Feb 2019, Lee Jones wrote:
>
> > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisa=C5=
=82(a):
> > > >
> > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > >
> > > > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisa=
=C5=82(a):
> > > > > >
> > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > >
> > > > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> nap=
isa=C5=82(a):
> > > > > > > >
> > > > > > > >  * The declaration of a superfluous struct
> > > > > > > >  * 100 lines of additional/avoidable code
> > > > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > > > > >  * Resources were designed for HWIRQs (unless a domain is p=
resent)
> > > > > > > >  * Loads of additional/avoidable CPU cycles setting all thi=
s up
> > > > > > >
> > > > > > > While the above may be right, this one is negligible and you =
know it. :)
> > > > > >
> > > > > > You have nested for() loops.  You *are* wasting lots of cycles.
> > > > > >
> > > > > > > > Need I go on? :)
> > > > > > > >
> > > > > > > > Surely the fact that you are using both sides of an API
> > > > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same dri=
ver, must
> > > > > > > > set some alarm bells ringing?
> > > > > > > >
> > > > > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is=
 a mess.
> > > > > > > >
> > > > > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > > > > >
> > > > > > > What do you propose? Should I go back to the approach in v1 a=
nd pass
> > > > > > > the regmap_irq_chip_data to child drivers?
> > > > > >
> > > > > > I'm saying you should remove all of this hackery and pass IRQs =
as they
> > > > > > are supposed to be passed (like everyone else does).
> > > > >
> > > > > I'm not sure what you mean by "like everyone else does" - differe=
nt
> > > > > mfd drivers seem to be doing different things. Is a simple struct
> > > > > containing virtual irq numbers passed to sub-drivers fine?
> > > >
> > > > How do you plan on deriving the VIRQs to place into the struct?
> > >
> > > Exampe:
> > >
> > > struct max77650_gpio_pdata {
> > >     int gpi_irq;
> > > };
> > >
> > > In MFD driver:
> > >
> > > struct max77650_gpio_pdata *gpio_data =3D devm_kmalloc(dev, sizeof(*g=
pio_data));
> > >
> > > gpio_data->gpi_irq =3D regmap_irq_get_virq(irqchip_data, GPI_NUM);
> > >
> > > gpio_cell.platform_data =3D gpio_data;
> > >
> > > In GPIO driver:
> > >
> > > struct max77650_gpio_pdata *gpio_data =3D pdev->dev.platform_data;
> > >
> > > int irq =3D gpio_data->gpi_irq;
> >
> > Definitely not.  What you're trying to do is a hack.
> >
> > If you're using Regmap to handle your IRQs, then you should use Regmap
> > in the client to pull them out.  Setting them via Regmap, then pulling
> > them out again in the *same driver*, only to store them in platform
> > data to be passed to a child device is bonkers.
> >
> > *Either* use the MFD provided platform-data helpers *or* pass and
> > handle them via the Regmap APIs, *not* both.
>
> Right, a plan has been formed.
>
> Hopefully this works and you can avoid all this dancing around.
>
> Firstly, you need to make a small change to:
>
>   drivers/base/regmap/regmap-irq.c
>
> Add the following function:
>
>   struct irq_domain *regmap_irq_get_domain(struct regmap *map)
>

We already do have such function and a lot of mfd drivers actually use it.

> As you can see, it will return the IRQ Domain for the chip.
>
> You can then pass this IRQ domain to mfd_add_devices() and it will do
> the HWIRQ =3D> VIRQ mapping for you on the fly.  Meaning that you can
> remove all the nastiness in max77650_setup_irqs() and have the Input
> device use the standard (e.g. platform_get_irq()) APIs.
>
> How does that Sound?
>

This does sound better! Why didn't you lead with that in the first place?

It's a pity it's not documented, I had to look at the code to find out
irq resources would get translated in mfd_add_devices() if a domain is
present.

In that case - I really don't see a reason to create a superfluous
structure to only hold the main regmap - we can very well get it from
the parent device in sub-drivers as I do now.

Thanks,
Bartosz
