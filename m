Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74528222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK5g6dY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438031AbfBNJoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:44:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34931 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395221AbfBNJmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:42:53 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so5377879wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LHtcHrnSQhmETBrAVX+/ROQ2NPjs6N4/2wSyqqigMag=;
        b=WK5g6dY52UdybYrWUhtCYhHZYev8lLHS8GhU3R8Zo96paK4X6Zq9iuHFQYmAjK3Et8
         ORYCtUFsLw4pp6hOeQUkq+6edptz6ku7c16PVYMMt4p7m7un6gXqcNl6I4dgepd5Ef+k
         oKuaxBhLAT9fAceEG9k7LJrj9GM8pfav2WSsnb4dA5NIn1l8ijh/FhLR46gd2A254Jp2
         hxRyEQN8c+dqegh1JrojYWFd+WSKcjOsC3fRt6oxzOYR1pWR/TGCylJmCV4QG6F082eg
         VX0eokjsoi/39ORsZ8TXJv4U/YRYgzs6TjsFOPHBCe1ZKutelvu0DzsQGgBxwTZDRb30
         P+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LHtcHrnSQhmETBrAVX+/ROQ2NPjs6N4/2wSyqqigMag=;
        b=s44JIA2/dkKyhXhCP59iuzmfqB2HIFcKDWOOYGH9pq29kN3tUSuNeLsCe+4MpAbCto
         MxyXgnHW+aUi+vHgGSQHNL9N1Ff7Y45Tfk+k6qeW+sn7gNrAi9/fBE2iWAaQCST5xX7r
         94/PO81iLGQ3V9u7RFLaqQmvBdeC+3p9EFXpB4la8FDaK51BwCJC45Abe+zjGcQcL8/f
         HWsPyRxGGMv5E6sxi1D+WP0033+I3ZKcnqfQKZ1z+DFWKgM6QZVZCBd/LuEzwWvdB9LQ
         AG8x6AFSIi8jjOc/fusCyw6Enld6vbQV4wj1jhhub8R/hjSZWdG9xJEqsbHZAC+/F8P8
         xjHw==
X-Gm-Message-State: AHQUAuY9/BhIP7XqpvWgYRlei+u0cZeVJ6179NnolguoaX8W29S9ENG9
        HqO4IZ//wDHphCu9aoTY+561fQ==
X-Google-Smtp-Source: AHgI3IaIrdxNOZKO1wGF1ZKCspCGV+63la7Cuw6LGAKMTC5yX7r+BhHiDVDzkGNU2FUBwRUKguCKgw==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr1954542wmb.125.1550137371660;
        Thu, 14 Feb 2019 01:42:51 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id b197sm4158597wmd.23.2019.02.14.01.42.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:42:51 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:42:48 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Message-ID: <20190214094248.GI13737@dell>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
 <20190212203408.GA1863@dell>
 <CAKdAkRQZ+ug7tpkE4x_8iTbUm9JnyF5wWrUnPRASi98t25LTbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKdAkRQZ+ug7tpkE4x_8iTbUm9JnyF5wWrUnPRASi98t25LTbA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Dmitry Torokhov wrote:

> Hi Lee,
> 
> On Tue, Feb 12, 2019 at 12:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Add support for the push- and slide-button events for max77650.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  drivers/input/misc/Kconfig          |   9 ++
> > > >  drivers/input/misc/Makefile         |   1 +
> > > >  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
> > > >  3 files changed, 145 insertions(+)
> > > >  create mode 100644 drivers/input/misc/max77650-onkey.c
> >
> > [...]
> >
> > Moving things around a bit:
> >
> > > > +static int max77650_onkey_probe(struct platform_device *pdev)
> > > > +{
> >
> > > > +   irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> > > > +   if (irq_f <= 0)
> > > > +           return -EINVAL;
> > > > +
> > > > +   irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> > > > +   if (irq_r <= 0)
> > > > +           return -EINVAL;
> > >
> > > Ugh, it would be better if you handled IRQ mapping in the MFD piece and
> > > passed it as resources of platform device. Then you'd simply call
> > > platform_get_irq() here and did not have to reach into parent device for
> > > "irq_dara".
> >
> > These device IRQs were defined and registered with the Regmap *set*
> > (actually init()) APIs and thus should be pulled out using the
> > appropriate reverse Regmap *get* APIs here in the device.
> >
> > Registering them with Regmap *and* pulling them back out again in the
> > same (MFD in this case) driver, only to register them as platform data
> > is certainly not how I see the API being designed/used.
> >
> > > > +   struct regmap_irq_chip_data *irq_data;
> > > > +   struct device *dev, *parent;
> >
> > > > +   dev = &pdev->dev;
> > > > +   parent = dev->parent;
> > > > +   i2c = to_i2c_client(parent);
> > > > +   irq_data = i2c_get_clientdata(i2c);
> > > > +
> > > > +   map = dev_get_regmap(parent, NULL);
> > > > +   if (!map)
> > > > +           return -ENODEV;
> >
> > However, this hoop jumping is a bit crazy and for the most part
> > superfluous.  Instead, create a struct of attributes you wish to share
> > with the child devices (containing both regmap (which you should call
> > regmap and not map by the way) and irq_data) and pass it as either
> > platform data (preferred) or as device data.
> >
> > If you choose the latter, you do not need to convert from 'device' to
> > 'i2c' to do the look-up.  Since this function (probe()) is provided
> > with a platform_device, you can just use platform_get_drvdata() to
> > achieve the same as above.
> >
> > If you go the preferred (platform data) route, then you should use
> > dev_get_platdata() instead.
> 
> By doing what you are suggesting (introducing platform data) you
> introducing strong dependency between MFD and input piece for no
> different reason. With the current implementation the parent can be
> reworked completely without involving onkey driver.
> 
> I find such clean separation desirable. We are trying to move away
> form platform data where it makes sense.

Never mind.  We found a way forward where everyone wins!

Thanks for your time.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
