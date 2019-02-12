Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D844C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B9021B68
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LpRCutjt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfBLUeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:34:16 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35829 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbfBLUeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:34:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so49962wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=k2rTYGUMoziXNB0Eh+P6HjdMe2voTeBpEVqv0rfRBao=;
        b=LpRCutjtNEQM2DRD1kxfRJ+4msYKaBBlXQ5GDaRTIArRd+9Uibdfwwh51wVtDMzZFB
         XolHgZP2K9nlmA+HcnhWwqOl760LzNavM+mzVGRWfteab/JcQDV79tMyeAxMeSQUqgq5
         QDgrZ+rSI4cf1iGspedccvo1BtTTtfrw9jwdASQgl7dVA+5A1Xage48Q1fb9r5lcgTD7
         FONGT1oRkpPWnisMyU5kyY8rd48c6W4/z/F+TEx+57/aNWvJ8V8U2U9K/yPBGu8hKT2O
         LNtDn6lINm8/bROVH/7n1ACAnhtfZA/CblbffBo7IL2htz3QbR1mox/3wDgnGu1XfeIt
         bULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=k2rTYGUMoziXNB0Eh+P6HjdMe2voTeBpEVqv0rfRBao=;
        b=N+qsQDyrRGsBVM6oz/dU44byK4xw9CYEi3DsiaCNfLBI4li3DJaSnsaAy9U0j0uepo
         kp9jw48EwnxkqLCRa9IBDxRyJdnvN+x2AU/JKvlKZ1zCSpnIMe0eVO1wgjfHDmUtHLIB
         /hppeEFNKoF/Cd73BaJrexKGHtRX6LOfHKVNRWLdQ+3BOasTc+2zvmAG1FbbWwdtwPLc
         0qdC6QVq+fp+UthGZ3ISLH3W+cRtbQHQ9aWiKKxmp37Z4+tINZC6YJsdT/WX1jCk4U+z
         YOYzou4eQ2NKusU3NUCfnu7EsQvsC2rTSs5Qw62aowu7cB/xH/sZrcLaTa12mNxsoqSn
         oUsA==
X-Gm-Message-State: AHQUAua4VPqTUE2sErxay7FMwWgSdYIetIYkVOgdxmFlIAY5azVSjV9/
        AmhjOMnnfXJm2zu5YpiKnM2D8w==
X-Google-Smtp-Source: AHgI3Iaxif/6MOnjS7T/zAr1mU9N4u21uXGGg5QZglxA0VrEPA2YsD9qO2CVSqj9sga2qedRIylS3Q==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr4214555wrn.290.1550003650623;
        Tue, 12 Feb 2019 12:34:10 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id s187sm4019022wms.8.2019.02.12.12.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:34:10 -0800 (PST)
Date:   Tue, 12 Feb 2019 20:34:08 +0000
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
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 12/13] input: max77650: add onkey support
Message-ID: <20190212203408.GA1863@dell>
References: <20190118134244.22253-1-brgl@bgdev.pl>
 <20190118134244.22253-13-brgl@bgdev.pl>
 <20190119090318.GB187380@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190119090318.GB187380@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > 
> > Add support for the push- and slide-button events for max77650.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/input/misc/Kconfig          |   9 ++
> >  drivers/input/misc/Makefile         |   1 +
> >  drivers/input/misc/max77650-onkey.c | 135 ++++++++++++++++++++++++++++
> >  3 files changed, 145 insertions(+)
> >  create mode 100644 drivers/input/misc/max77650-onkey.c

[...]

Moving things around a bit:

> > +static int max77650_onkey_probe(struct platform_device *pdev)
> > +{

> > +	irq_f = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_F);
> > +	if (irq_f <= 0)
> > +		return -EINVAL;
> > +
> > +	irq_r = regmap_irq_get_virq(irq_data, MAX77650_INT_nEN_R);
> > +	if (irq_r <= 0)
> > +		return -EINVAL;
> 
> Ugh, it would be better if you handled IRQ mapping in the MFD piece and
> passed it as resources of platform device. Then you'd simply call
> platform_get_irq() here and did not have to reach into parent device for
> "irq_dara".

These device IRQs were defined and registered with the Regmap *set*
(actually init()) APIs and thus should be pulled out using the
appropriate reverse Regmap *get* APIs here in the device.

Registering them with Regmap *and* pulling them back out again in the
same (MFD in this case) driver, only to register them as platform data
is certainly not how I see the API being designed/used.

> > +	struct regmap_irq_chip_data *irq_data;
> > +	struct device *dev, *parent;

> > +	dev = &pdev->dev;
> > +	parent = dev->parent;
> > +	i2c = to_i2c_client(parent);
> > +	irq_data = i2c_get_clientdata(i2c);
> > +
> > +	map = dev_get_regmap(parent, NULL);
> > +	if (!map)
> > +		return -ENODEV;

However, this hoop jumping is a bit crazy and for the most part
superfluous.  Instead, create a struct of attributes you wish to share
with the child devices (containing both regmap (which you should call
regmap and not map by the way) and irq_data) and pass it as either
platform data (preferred) or as device data.

If you choose the latter, you do not need to convert from 'device' to
'i2c' to do the look-up.  Since this function (probe()) is provided
with a platform_device, you can just use platform_get_drvdata() to
achieve the same as above.

If you go the preferred (platform data) route, then you should use
dev_get_platdata() instead.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
