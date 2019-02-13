Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F06D222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMI05su8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbfBMHab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:30:31 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34106 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732822AbfBMHab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:30:31 -0500
Received: by mail-it1-f196.google.com with SMTP id j17so885701ita.1;
        Tue, 12 Feb 2019 23:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PGOtFQP2glJh8X2lYD7XOqlwPMjpkV+z0GGZhUQueM=;
        b=OMI05su8Y6mGlUPLyMHePKvd66LqGIi5rhwHBSNFOUS8y2saTp0eCjCxgwHZc/RfkE
         sx6tuYIVwUbd0ak8yiwaJ91VI5MVVxGKG8tem7pL1gn8WGhY4K4wa4bVcKQGYjpQaBpM
         FfI7289nZ0HuoWunkOJjBbdvSXKg89ykakqgJq9BJPcWvh1o0H3Rmi3UiNlKUVYPZd59
         EQddw2uCWckrqoVHrxWdFnXAXbwpCsreWInU2zALfpoGiP4MJlejob9CoZCjvdTnXODi
         tzZyqKSJE15gZ3YL6CbeKDaa/Lf2n4JI6qazC1Hm1YuCLBPIm2GBStqw8WuP4QHZTdjv
         sEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PGOtFQP2glJh8X2lYD7XOqlwPMjpkV+z0GGZhUQueM=;
        b=Nsd+tdqIV+uTtVLwjc2fuuXuE00RJYpuB3AsC/gWFFiEiyRClMazufQ7fPaaUph8wt
         5a1llvelpeVc1V6HKXSjFnOPOS61sPDXXFEYc/3AmrwSHoBPQT/WBEJpGQFrD++33pom
         zey5SETDbxZcREAGT2IK1/ZWXCpPkmMtAJDAm0EP5eypqZ7KQduFnANmjRR2imtrOx63
         hjkscXQSJ6+w68oKIIQZD4Iyg+2vlylj3SDJIjYDvpVG61XcDZulZHalrhWkIdgcKmZl
         rraY6PAcJgOTP41pA+9V6ir2A2JB0u3OVpfpORIhByn82+84xnXDc4OHVR6w0I+lWKsm
         PZDw==
X-Gm-Message-State: AHQUAuYo8pze6s/RdwDXkiFKRk3FjOv7NHZwmuZ8osqnrkBtu/2ipSs8
        MSNpIbvkBtL3i/65RSc9LdCGmTuSsZWXH2NKY8E=
X-Google-Smtp-Source: AHgI3IZ2qRfONjHmOZBrNNAvyuxuAjCPsqzSM4h6iwmMQdn4um0DSblnjn0C5Ezt/9WkClQYhKuWBL2gtsVGBPEmZFk=
X-Received: by 2002:a6b:9106:: with SMTP id t6mr4847187iod.298.1550043029362;
 Tue, 12 Feb 2019 23:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws> <20190212203408.GA1863@dell>
In-Reply-To: <20190212203408.GA1863@dell>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 12 Feb 2019 23:30:17 -0800
Message-ID: <CAKdAkRQZ+ug7tpkE4x_8iTbUm9JnyF5wWrUnPRASi98t25LTbA@mail.gmail.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Tue, Feb 12, 2019 at 12:34 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Add support for the push- and slide-button events for max77650.
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  drivers/input/misc/Kconfig          |   9 ++
> > >  drivers/input/misc/Makefile         |   1 +
> > >  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
> > >  3 files changed, 145 insertions(+)
> > >  create mode 100644 drivers/input/misc/max77650-onkey.c
>
> [...]
>
> Moving things around a bit:
>
> > > +static int max77650_onkey_probe(struct platform_device *pdev)
> > > +{
>
> > > +   irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> > > +   if (irq_f <= 0)
> > > +           return -EINVAL;
> > > +
> > > +   irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> > > +   if (irq_r <= 0)
> > > +           return -EINVAL;
> >
> > Ugh, it would be better if you handled IRQ mapping in the MFD piece and
> > passed it as resources of platform device. Then you'd simply call
> > platform_get_irq() here and did not have to reach into parent device for
> > "irq_dara".
>
> These device IRQs were defined and registered with the Regmap *set*
> (actually init()) APIs and thus should be pulled out using the
> appropriate reverse Regmap *get* APIs here in the device.
>
> Registering them with Regmap *and* pulling them back out again in the
> same (MFD in this case) driver, only to register them as platform data
> is certainly not how I see the API being designed/used.
>
> > > +   struct regmap_irq_chip_data *irq_data;
> > > +   struct device *dev, *parent;
>
> > > +   dev = &pdev->dev;
> > > +   parent = dev->parent;
> > > +   i2c = to_i2c_client(parent);
> > > +   irq_data = i2c_get_clientdata(i2c);
> > > +
> > > +   map = dev_get_regmap(parent, NULL);
> > > +   if (!map)
> > > +           return -ENODEV;
>
> However, this hoop jumping is a bit crazy and for the most part
> superfluous.  Instead, create a struct of attributes you wish to share
> with the child devices (containing both regmap (which you should call
> regmap and not map by the way) and irq_data) and pass it as either
> platform data (preferred) or as device data.
>
> If you choose the latter, you do not need to convert from 'device' to
> 'i2c' to do the look-up.  Since this function (probe()) is provided
> with a platform_device, you can just use platform_get_drvdata() to
> achieve the same as above.
>
> If you go the preferred (platform data) route, then you should use
> dev_get_platdata() instead.

By doing what you are suggesting (introducing platform data) you
introducing strong dependency between MFD and input piece for no
different reason. With the current implementation the parent can be
reworked completely without involving onkey driver.

I find such clean separation desirable. We are trying to move away
form platform data where it makes sense.

Thanks.

-- 
Dmitry
