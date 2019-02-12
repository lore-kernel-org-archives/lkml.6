Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A18C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF515214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSp+CuCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfBLNUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:20:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfBLNUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:20:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so2630535wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EDAIw774Db9K3TDJlAs9vNTmZAl7FoIEHd7WSGrIJWs=;
        b=NSp+CuCfHMCahl8z8WotVc9DYLBptiZY7B1X4gNH9J02MnuET21AXRr5k24sRne71y
         wIB65jwsfD+bT/ZPgVLUVcewLcs05l3dzXDkdj/HOwfKiiMzJcGQ8/HBbUyqGIL5T9hu
         DVJEA6cfnBWsDtUfLZqTqtODjEQ6L5ibvsAQAPtIA8f3K+1lmwk9YcHtZ/uFsBi/YNLN
         ODxTt8x48vkW3alvzFFjZ/+2OXzzOX0tdsciL1duxbGIHQU6rdieZ/a8AhJUmn97XZFa
         ermHridUqTiqj4IxF4wZHXjNWE8BzctsZJO/hVMHRRohwQHunCfKL8PFOmeQDb9EL5Uz
         1eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=EDAIw774Db9K3TDJlAs9vNTmZAl7FoIEHd7WSGrIJWs=;
        b=lC13wXeo3I5SHyqiLdASMZHvCTHayCb/oqw9JHsPmuypmMMtsjneI2zTTRIQs5ga74
         /hpmh8tvZpdFlax/Bkh999Fz1Sq4pbTmMJn0cP0Vw6FY9GODSfYyF33PJ6e6xLJLEoNv
         2yV05CtxQhv3gvn7T/23vmX7eLhB7HuXuG6ope8+fq8vdFf2KngrUxjbC0iASBI+pMyV
         +cJixNsn7mCaBhJe0BatvNqWUW4gFJ3CpLDQ0QbQBq/U3pII2L4OD825L+FSa8eRMSIr
         v3wKg6/PG2sSGYiH31hblFMa0yQHewijSXmJBn8LEUH65jKzZADHBlPBMRDVqWoU/H4c
         e+pQ==
X-Gm-Message-State: AHQUAuY63lRMULlmnOBN+QkxUxfpsak6h0o3ek8nRhLuc4j9qX/Jm33W
        qvVWCHRookYX7UypHXQFdAgTAA==
X-Google-Smtp-Source: AHgI3IYIgLssaIJObTDnXfP4Mo3B7Tfh3uluB83n7Hxw5Z5ZhEkU5AjXUrWeawSBHjuddNHFqgotkA==
X-Received: by 2002:a05:6000:14c:: with SMTP id r12mr2870824wrx.172.1549977621835;
        Tue, 12 Feb 2019 05:20:21 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id y22sm38723822wrd.45.2019.02.12.05.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 05:20:18 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:20:16 +0000
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
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190212132016.GA4781@dell>
References: <20190205091237.6448-1-brgl@bgdev.pl>
 <20190205091237.6448-6-brgl@bgdev.pl>
 <20190212083642.GT20638@dell>
 <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
 <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell>
 <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:

> wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > >
> > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > >
> > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > >
> > > > > >  * The declaration of a superfluous struct
> > > > > >  * 100 lines of additional/avoidable code
> > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > > > >
> > > > > While the above may be right, this one is negligible and you know it. :)
> > > >
> > > > You have nested for() loops.  You *are* wasting lots of cycles.
> > > >
> > > > > > Need I go on? :)
> > > > > >
> > > > > > Surely the fact that you are using both sides of an API
> > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > > > set some alarm bells ringing?
> > > > > >
> > > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > > > >
> > > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > > >
> > > > > What do you propose? Should I go back to the approach in v1 and pass
> > > > > the regmap_irq_chip_data to child drivers?
> > > >
> > > > I'm saying you should remove all of this hackery and pass IRQs as they
> > > > are supposed to be passed (like everyone else does).
> > >
> > > I'm not sure what you mean by "like everyone else does" - different
> > > mfd drivers seem to be doing different things. Is a simple struct
> > > containing virtual irq numbers passed to sub-drivers fine?
> >
> > How do you plan on deriving the VIRQs to place into the struct?
> 
> Exampe:
> 
> struct max77650_gpio_pdata {
>     int gpi_irq;
> };
> 
> In MFD driver:
> 
> struct max77650_gpio_pdata *gpio_data = devm_kmalloc(dev, sizeof(*gpio_data));
> 
> gpio_data->gpi_irq = regmap_irq_get_virq(irqchip_data, GPI_NUM);
> 
> gpio_cell.platform_data = gpio_data;
> 
> In GPIO driver:
> 
> struct max77650_gpio_pdata *gpio_data = pdev->dev.platform_data;
> 
> int irq = gpio_data->gpi_irq;

Definitely not.  What you're trying to do is a hack.

If you're using Regmap to handle your IRQs, then you should use Regmap
in the client to pull them out.  Setting them via Regmap, then pulling
them out again in the *same driver*, only to store them in platform
data to be passed to a child device is bonkers.

*Either* use the MFD provided platform-data helpers *or* pass and
handle them via the Regmap APIs, *not* both.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
