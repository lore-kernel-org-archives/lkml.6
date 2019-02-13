Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D0C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95377222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="awgZ8iC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbfBMKQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:16:02 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33405 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfBMKQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:16:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so3067585otl.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2AOMFkmSuPcytqgXCEu3RzHPPkZxR8MIeAZ6P+B8Ud8=;
        b=awgZ8iC3XabQa1xT9DTcNLYxIZqTObDndrn6HQ07Q/kdZxVPbYxuBPTkLMflTJHCKi
         bE8jB9PPzJnK9GItYDwAXjtqv5lStk6KUo4tz6G4AZoYxysLcK1q4ALRo4NulTHLQZwU
         FAgcH89GirnP1sKHZbc2kQVbz/vpvLsWxjk6e05lPh9Timtd02/QbdHajimDwPNP7YcQ
         hCAwuxezw3tuma3iTFn613BbPqlqE0i91jZXHDMaQx6UIaqTFY7m+UNOCMULbnLLTveN
         LQ19O3elIccMQRSq7RLIQE4hNYCXPcqsZfZMU6kFsrxR60hXObwJXk2yl9+G1VuXWYX6
         mCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2AOMFkmSuPcytqgXCEu3RzHPPkZxR8MIeAZ6P+B8Ud8=;
        b=uGmvp2eTt2afKW//eO1Q0N0hlilTWJC46vzhhSFOtDBb7K5LUP74nRFNlTBFxoh967
         chpfkrhY4XtZAYqyfqV8MqnEpJWBS/BZPJjhKzlzrMo9rYSmFJnu/SnpCKu2CmPET1hN
         R92IE5MWmUr4z/PNr6Mu81qVbJBFrD0qr6+aPk3ApaJSqBPirNI6Jh2zCoGDR1QnN0m2
         je8IT86xIk/hiIXNlHBPjAfSlgHFiuhQ/TnfbN/b9C8/EWdfFSlv1tY5q/kJO9C8RkT7
         hCfpNQQ16ybKyVCGyfmaQXB/ygW+/v8qXPtc6VUoBMlCKzCuIUvNg5BGk16Nn9awaVRH
         Nbtw==
X-Gm-Message-State: AHQUAuZF1fSdtInBvFPu1Apq+xGx88oXvkL6mwERaFUKudmHmmocJ8aA
        ITWV80eWwVrmIzFPqqdQxDfntMKXBASgad3Q8I02Xw==
X-Google-Smtp-Source: AHgI3IZBXBpOsilK4BHRTOgFGZqxf8/FeVnltpx3EhHrmo46c7w0HDlP089GjHuwhzLtR6r//aqI2pwkSFKcMX2roog=
X-Received: by 2002:a9d:32c7:: with SMTP id u65mr7660639otb.236.1550052959791;
 Wed, 13 Feb 2019 02:15:59 -0800 (PST)
MIME-Version: 1.0
References: <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell> <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell> <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell> <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
 <20190212132016.GA4781@dell> <20190213092553.GE1863@dell> <CAMRc=MeTMq_GWzQB6LBvts1csMftj=On5sB22jsJZzQzONxbNg@mail.gmail.com>
 <20190213095330.GF1863@dell>
In-Reply-To: <20190213095330.GF1863@dell>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 13 Feb 2019 11:15:48 +0100
Message-ID: <CAMpxmJXqEwNtyT1ahmRd05QOjhdi0rT_-5S9Lk8O-PmV8BuA6w@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
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

=C5=9Br., 13 lut 2019 o 10:53 Lee Jones <lee.jones@linaro.org> napisa=C5=82=
(a):
>
> On Wed, 13 Feb 2019, Bartosz Golaszewski wrote:
>
> > =C5=9Br., 13 lut 2019 o 10:25 Lee Jones <lee.jones@linaro.org> napisa=
=C5=82(a):
> > >
> > > On Tue, 12 Feb 2019, Lee Jones wrote:
> > >
> > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > >
> > > > > wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisa=
=C5=82(a):
> > > > > >
> > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > >
> > > > > > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> nap=
isa=C5=82(a):
> > > > > > > >
> > > > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > > > >
> > > > > > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org>=
 napisa=C5=82(a):
> > > > > > > > > >
> > > > > > > > > >  * The declaration of a superfluous struct
> > > > > > > > > >  * 100 lines of additional/avoidable code
> > > > > > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resour=
ces
> > > > > > > > > >  * Resources were designed for HWIRQs (unless a domain =
is present)
> > > > > > > > > >  * Loads of additional/avoidable CPU cycles setting all=
 this up
> > > > > > > > >
> > > > > > > > > While the above may be right, this one is negligible and =
you know it. :)
> > > > > > > >
> > > > > > > > You have nested for() loops.  You *are* wasting lots of cyc=
les.
> > > > > > > >
> > > > > > > > > > Need I go on? :)
> > > > > > > > > >
> > > > > > > > > > Surely the fact that you are using both sides of an API
> > > > > > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same=
 driver, must
> > > > > > > > > > set some alarm bells ringing?
> > > > > > > > > >
> > > > > > > > > > This whole HWIRQ setting, VIRQ getting, resource hackin=
g is a mess.
> > > > > > > > > >
> > > > > > > > > > And for what?  To avoid passing IRQ data to a child dri=
ver?
> > > > > > > > >
> > > > > > > > > What do you propose? Should I go back to the approach in =
v1 and pass
> > > > > > > > > the regmap_irq_chip_data to child drivers?
> > > > > > > >
> > > > > > > > I'm saying you should remove all of this hackery and pass I=
RQs as they
> > > > > > > > are supposed to be passed (like everyone else does).
> > > > > > >
> > > > > > > I'm not sure what you mean by "like everyone else does" - dif=
ferent
> > > > > > > mfd drivers seem to be doing different things. Is a simple st=
ruct
> > > > > > > containing virtual irq numbers passed to sub-drivers fine?
> > > > > >
> > > > > > How do you plan on deriving the VIRQs to place into the struct?
> > > > >
> > > > > Exampe:
> > > > >
> > > > > struct max77650_gpio_pdata {
> > > > >     int gpi_irq;
> > > > > };
> > > > >
> > > > > In MFD driver:
> > > > >
> > > > > struct max77650_gpio_pdata *gpio_data =3D devm_kmalloc(dev, sizeo=
f(*gpio_data));
> > > > >
> > > > > gpio_data->gpi_irq =3D regmap_irq_get_virq(irqchip_data, GPI_NUM)=
;
> > > > >
> > > > > gpio_cell.platform_data =3D gpio_data;
> > > > >
> > > > > In GPIO driver:
> > > > >
> > > > > struct max77650_gpio_pdata *gpio_data =3D pdev->dev.platform_data=
;
> > > > >
> > > > > int irq =3D gpio_data->gpi_irq;
> > > >
> > > > Definitely not.  What you're trying to do is a hack.
> > > >
> > > > If you're using Regmap to handle your IRQs, then you should use Reg=
map
> > > > in the client to pull them out.  Setting them via Regmap, then pull=
ing
> > > > them out again in the *same driver*, only to store them in platform
> > > > data to be passed to a child device is bonkers.
> > > >
> > > > *Either* use the MFD provided platform-data helpers *or* pass and
> > > > handle them via the Regmap APIs, *not* both.
> > >
> > > Right, a plan has been formed.
> > >
> > > Hopefully this works and you can avoid all this dancing around.
> > >
> > > Firstly, you need to make a small change to:
> > >
> > >   drivers/base/regmap/regmap-irq.c
> > >
> > > Add the following function:
> > >
> > >   struct irq_domain *regmap_irq_get_domain(struct regmap *map)
> >
> > We already do have such function and a lot of mfd drivers actually use =
it.
>
> Even better.
>
> > > As you can see, it will return the IRQ Domain for the chip.
> > >
> > > You can then pass this IRQ domain to mfd_add_devices() and it will do
> > > the HWIRQ =3D> VIRQ mapping for you on the fly.  Meaning that you can
> > > remove all the nastiness in max77650_setup_irqs() and have the Input
> > > device use the standard (e.g. platform_get_irq()) APIs.
> > >
> > > How does that Sound?
> >
> > This does sound better! Why didn't you lead with that in the first plac=
e?
>
> I'm not even going to dignify that stupid question with a response.
>

It's not a stupid question and you're being unnecessarily rude. As an
expert in the subsystem you maintain you could have answered simply
with a "this is wrong, retrieve the irq domain from the regmap
irq_chip and pass it over to mfd_add_devices, the mfd core will create
appropriate mappings".

> > It's a pity it's not documented, I had to look at the code to find out
> > irq resources would get translated in mfd_add_devices() if a domain is
> > present.
>
> Where is it likely to be documented?  MFD is pretty simple and seldom
> needs explanation.  A 3 second look at the API you're trying to use
> (instead of blind copy & paste) would have told you that it's possible
> to take an IRQ domain as an argument.
>
> It's only the craziness in this patch which forced me to look into how
> Regmap handles IRQs and come up with a subsequent solution which fits
> your use-case.
>
> > In that case - I really don't see a reason to create a superfluous
> > structure to only hold the main regmap - we can very well get it from
> > the parent device in sub-drivers as I do now.
>
> The whole point of this solution is that you don't need to pass
> anything non-standard (i.e. not provided by the current APIs) to the
> child device.
>

I don't understand what you're saying here.

Bartosz
