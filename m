Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C36C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03881222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF9o1fqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfBMJ0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:26:00 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33123 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfBMJZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:25:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so1403539wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=N/24VafAe3SbghCeTmnYviQLVXiAQGmM8THLiXIbj28=;
        b=MF9o1fqXqDMnX8uDQo5tq6toCuEqUHnshHwlMFXoeEgkxWTHhh02AAmKCq7dC+VVp4
         U0qAcMyJlrw5VORFEDk6DqgaJ5aA5V8fzgfykdvW8uLCvvwZd7AdFOHu2snxMYznUiJ+
         Oqn/U/s5WP1NXZihrNDdn0jI3cABn8h2F7NbInJgciiZtVE30qNqaTQYmU2qx4OV4SfF
         qLjSIE+zkhBCfPwdOk/zvyamW+FJMUurqMYrdev5WDn5jcnJt06R+/QE+z8JzqY8ADRv
         dFU8tPMKAnW11JCMl60Z6eSA18akYZUrOCry3LGaWyEt401hJh0XIqoN8Lzwt6VWBcWU
         /lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=N/24VafAe3SbghCeTmnYviQLVXiAQGmM8THLiXIbj28=;
        b=ot9dgtkGDEMwfzsU8rcGcAU7p1zZHuMvfs6TeUZOjnIzBISUQvzrqmexfQ/sg2ddO7
         +uFYSu0nTgIRuCsU0SMoh6XMeXlF+ufqUp9ijNwk8K0Beglc/DNArbN7LkK0axQOjA+2
         ZrMRSroCkG4RewaeMyMnE+lQBElWrs7gLvbHcJlsguJE5vNfrzn98Bh93+g37VpLT+61
         x9jIfiNNVIltwP/3sPpAL3FNHqd44FWqzP9UdwgjIveZvSAUUXRFwTh3L9bIWuhzEFYj
         A9EgcGIFF9UO/jcsRq3sHthSUgl04sBPKsC4iWDI0ZNM8F0zdXWTRL3kPLMTu8RTvnvN
         xnmQ==
X-Gm-Message-State: AHQUAuYSc26Tpwu+yJoXUuH4een2+uWaoJNrnnz6DypORerBw4EmSuQF
        djfGe+8x1B7ddKQ2kgci8QuW3Q==
X-Google-Smtp-Source: AHgI3Ia5bMOqYSj7v0YFFuRwBwyRQ542WRb7Awxxpv+T8+p+1Yxd4HQI2D2it+hUFBcNZlcE2NDp0g==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr2535037wmc.68.1550049956751;
        Wed, 13 Feb 2019 01:25:56 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id y18sm2881256wmi.5.2019.02.13.01.25.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:25:55 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:25:53 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
        Linux PM list <linux-pm@vger.kernel.org>, broonie@kernel.org
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190213092553.GE1863@dell>
References: <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
 <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell>
 <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
 <20190212132016.GA4781@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212132016.GA4781@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Lee Jones wrote:

> On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> 
> > wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisał(a):
> > >
> > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > >
> > > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > >
> > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > >
> > > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > >
> > > > > > >  * The declaration of a superfluous struct
> > > > > > >  * 100 lines of additional/avoidable code
> > > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > > > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > > > > >
> > > > > > While the above may be right, this one is negligible and you know it. :)
> > > > >
> > > > > You have nested for() loops.  You *are* wasting lots of cycles.
> > > > >
> > > > > > > Need I go on? :)
> > > > > > >
> > > > > > > Surely the fact that you are using both sides of an API
> > > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > > > > set some alarm bells ringing?
> > > > > > >
> > > > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > > > > >
> > > > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > > > >
> > > > > > What do you propose? Should I go back to the approach in v1 and pass
> > > > > > the regmap_irq_chip_data to child drivers?
> > > > >
> > > > > I'm saying you should remove all of this hackery and pass IRQs as they
> > > > > are supposed to be passed (like everyone else does).
> > > >
> > > > I'm not sure what you mean by "like everyone else does" - different
> > > > mfd drivers seem to be doing different things. Is a simple struct
> > > > containing virtual irq numbers passed to sub-drivers fine?
> > >
> > > How do you plan on deriving the VIRQs to place into the struct?
> > 
> > Exampe:
> > 
> > struct max77650_gpio_pdata {
> >     int gpi_irq;
> > };
> > 
> > In MFD driver:
> > 
> > struct max77650_gpio_pdata *gpio_data = devm_kmalloc(dev, sizeof(*gpio_data));
> > 
> > gpio_data->gpi_irq = regmap_irq_get_virq(irqchip_data, GPI_NUM);
> > 
> > gpio_cell.platform_data = gpio_data;
> > 
> > In GPIO driver:
> > 
> > struct max77650_gpio_pdata *gpio_data = pdev->dev.platform_data;
> > 
> > int irq = gpio_data->gpi_irq;
> 
> Definitely not.  What you're trying to do is a hack.
> 
> If you're using Regmap to handle your IRQs, then you should use Regmap
> in the client to pull them out.  Setting them via Regmap, then pulling
> them out again in the *same driver*, only to store them in platform
> data to be passed to a child device is bonkers.
> 
> *Either* use the MFD provided platform-data helpers *or* pass and
> handle them via the Regmap APIs, *not* both.

Right, a plan has been formed.

Hopefully this works and you can avoid all this dancing around.

Firstly, you need to make a small change to:

  drivers/base/regmap/regmap-irq.c

Add the following function:

  struct irq_domain *regmap_irq_get_domain(struct regmap *map)

As you can see, it will return the IRQ Domain for the chip.

You can then pass this IRQ domain to mfd_add_devices() and it will do
the HWIRQ => VIRQ mapping for you on the fly.  Meaning that you can
remove all the nastiness in max77650_setup_irqs() and have the Input
device use the standard (e.g. platform_get_irq()) APIs.

How does that Sound?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
