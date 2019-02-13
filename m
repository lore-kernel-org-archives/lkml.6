Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B44C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677821920
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xjqUn6bd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391504AbfBMKjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:39:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45249 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfBMKjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:39:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so1853268wrn.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rF6hDIv3cmYj7Li/1ZKjWzmBdQxwnPKRNjT1kF5p5lU=;
        b=xjqUn6bdlHOok8qczM5bVvUhouKJLqXSv4YKiQFX0aNHKdzTOwnxPeSPkJ+jm1NFvz
         yutU9YqkHq3kNPyDwzJBaPLiS6tIWYNMRQhQ+flx4wXHWQ6lwcJduCmQ9N4YpTiiy+H8
         8E8OxE1wSFIxjB3cM/k979U2ny9QVyQG+NUcPBSm42pewB2d1lmulKBfAUr9Gf01Xb07
         yvWyx0IGTJ7+hzrwpsT8VCtsugF0cMq4upbM0cD5/Ndpten+nMHw8pNSfLzkaKFWAfc5
         laAQPePuzgufgIMltAmq0w7mDAmtEI3GXJuroQFx4/s8iGxO5JVL56GLqCWT/bWmk4Gt
         hwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rF6hDIv3cmYj7Li/1ZKjWzmBdQxwnPKRNjT1kF5p5lU=;
        b=kbgb6Wcgoy1K3/LxF126dCAFvM2VvH6+UPoCNWFntctlIRnsjb5MZq78ltVV84gsaV
         p5UZ2f0K2uiq273vfyEetVE/gGELmvm7rALRzt/G7lOpgH96vNaS4Z9zZaH7q3GFda5A
         FH+SEdzZC6rXrqLOxfM0bhO7et2AI//dSdyxxhuLutnkVL4mGwAqaRf9oAXtuGyf9sII
         HcEgN6ygymTelaDhfrQBeiVPjn2I5HeO/L2p667QoEI9iIf2ZrS27FV1NpKYd7xYjQXD
         Zchyt7hEqIg6AZy6dQw2m3BiskjNeFC5DvqjpYEfGnLB3m2DRFZdfKn8UppYA5C7xRO5
         qM7g==
X-Gm-Message-State: AHQUAubVhJN/Gzaxw6V/aHE4ZLbe3nhKG7qnhsPkXWuiU6fjJsyvsRU7
        fNFkiAuySPPlQnr9cUXlh1j7Pw==
X-Google-Smtp-Source: AHgI3IYD6+DYsA23ne8j5xsBnLgABwdhAxfC61g5wY/dDpfH3TXHZsqZVH5vinKpkV/Y5Uo+J8iqhA==
X-Received: by 2002:a5d:5285:: with SMTP id c5mr6152013wrv.167.1550054389610;
        Wed, 13 Feb 2019 02:39:49 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id f134sm4881743wme.31.2019.02.13.02.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 02:39:49 -0800 (PST)
Date:   Wed, 13 Feb 2019 10:39:46 +0000
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
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190213103946.GG1863@dell>
References: <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell>
 <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
 <20190212132016.GA4781@dell>
 <20190213092553.GE1863@dell>
 <CAMRc=MeTMq_GWzQB6LBvts1csMftj=On5sB22jsJZzQzONxbNg@mail.gmail.com>
 <20190213095330.GF1863@dell>
 <CAMpxmJXqEwNtyT1ahmRd05QOjhdi0rT_-5S9Lk8O-PmV8BuA6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJXqEwNtyT1ahmRd05QOjhdi0rT_-5S9Lk8O-PmV8BuA6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Bartosz Golaszewski wrote:

> śr., 13 lut 2019 o 10:53 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Wed, 13 Feb 2019, Bartosz Golaszewski wrote:
> >
> > > śr., 13 lut 2019 o 10:25 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > >
> > > > On Tue, 12 Feb 2019, Lee Jones wrote:
> > > >
> > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > >
> > > > > > wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > >
> > > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > > >
> > > > > > > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > > > >
> > > > > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > > > > >
> > > > > > > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > > > > > >
> > > > > > > > > > >  * The declaration of a superfluous struct
> > > > > > > > > > >  * 100 lines of additional/avoidable code
> > > > > > > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > > > > > > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > > > > > > > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > > > > > > > > >
> > > > > > > > > > While the above may be right, this one is negligible and you know it. :)
> > > > > > > > >
> > > > > > > > > You have nested for() loops.  You *are* wasting lots of cycles.
> > > > > > > > >
> > > > > > > > > > > Need I go on? :)
> > > > > > > > > > >
> > > > > > > > > > > Surely the fact that you are using both sides of an API
> > > > > > > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > > > > > > > > set some alarm bells ringing?
> > > > > > > > > > >
> > > > > > > > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > > > > > > > > >
> > > > > > > > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > > > > > > > >
> > > > > > > > > > What do you propose? Should I go back to the approach in v1 and pass
> > > > > > > > > > the regmap_irq_chip_data to child drivers?
> > > > > > > > >
> > > > > > > > > I'm saying you should remove all of this hackery and pass IRQs as they
> > > > > > > > > are supposed to be passed (like everyone else does).
> > > > > > > >
> > > > > > > > I'm not sure what you mean by "like everyone else does" - different
> > > > > > > > mfd drivers seem to be doing different things. Is a simple struct
> > > > > > > > containing virtual irq numbers passed to sub-drivers fine?
> > > > > > >
> > > > > > > How do you plan on deriving the VIRQs to place into the struct?
> > > > > >
> > > > > > Exampe:
> > > > > >
> > > > > > struct max77650_gpio_pdata {
> > > > > >     int gpi_irq;
> > > > > > };
> > > > > >
> > > > > > In MFD driver:
> > > > > >
> > > > > > struct max77650_gpio_pdata *gpio_data = devm_kmalloc(dev, sizeof(*gpio_data));
> > > > > >
> > > > > > gpio_data->gpi_irq = regmap_irq_get_virq(irqchip_data, GPI_NUM);
> > > > > >
> > > > > > gpio_cell.platform_data = gpio_data;
> > > > > >
> > > > > > In GPIO driver:
> > > > > >
> > > > > > struct max77650_gpio_pdata *gpio_data = pdev->dev.platform_data;
> > > > > >
> > > > > > int irq = gpio_data->gpi_irq;
> > > > >
> > > > > Definitely not.  What you're trying to do is a hack.
> > > > >
> > > > > If you're using Regmap to handle your IRQs, then you should use Regmap
> > > > > in the client to pull them out.  Setting them via Regmap, then pulling
> > > > > them out again in the *same driver*, only to store them in platform
> > > > > data to be passed to a child device is bonkers.
> > > > >
> > > > > *Either* use the MFD provided platform-data helpers *or* pass and
> > > > > handle them via the Regmap APIs, *not* both.
> > > >
> > > > Right, a plan has been formed.
> > > >
> > > > Hopefully this works and you can avoid all this dancing around.
> > > >
> > > > Firstly, you need to make a small change to:
> > > >
> > > >   drivers/base/regmap/regmap-irq.c
> > > >
> > > > Add the following function:
> > > >
> > > >   struct irq_domain *regmap_irq_get_domain(struct regmap *map)
> > >
> > > We already do have such function and a lot of mfd drivers actually use it.
> >
> > Even better.
> >
> > > > As you can see, it will return the IRQ Domain for the chip.
> > > >
> > > > You can then pass this IRQ domain to mfd_add_devices() and it will do
> > > > the HWIRQ => VIRQ mapping for you on the fly.  Meaning that you can
> > > > remove all the nastiness in max77650_setup_irqs() and have the Input
> > > > device use the standard (e.g. platform_get_irq()) APIs.
> > > >
> > > > How does that Sound?
> > >
> > > This does sound better! Why didn't you lead with that in the first place?
> >
> > I'm not even going to dignify that stupid question with a response.
> 
> It's not a stupid question and you're being unnecessarily rude. As an
> expert in the subsystem you maintain you could have answered simply
> with a "this is wrong, retrieve the irq domain from the regmap
> irq_chip and pass it over to mfd_add_devices, the mfd core will create
> appropriate mappings".

Could be culture clash, but I found the question offensive which is
why I chose not to answer it.  The reason is actually explained below:

 "It's only the craziness in this patch which forced me to look into how
  Regmap handles IRQs and come up with a subsequent solution which fits
  your use-case."

Thus the fact that a) Regmap used IRQ domains and b) the IRQ domain
could be fetched and reused here didn't enter my thought process until
I delved into the inner workings of Regmap.

Yes, I know MFD pretty well, but I only tend to deep-dive into other
subsystems, particularly ones as complicated as Regmap, when it's
necessary to do so.  Now I know a little more about it, I can provide
the feedback you suggest going forward.

> > > It's a pity it's not documented, I had to look at the code to find out
> > > irq resources would get translated in mfd_add_devices() if a domain is
> > > present.
> >
> > Where is it likely to be documented?  MFD is pretty simple and seldom
> > needs explanation.  A 3 second look at the API you're trying to use
> > (instead of blind copy & paste) would have told you that it's possible
> > to take an IRQ domain as an argument.
> >
> > It's only the craziness in this patch which forced me to look into how
> > Regmap handles IRQs and come up with a subsequent solution which fits
> > your use-case.
> >
> > > In that case - I really don't see a reason to create a superfluous
> > > structure to only hold the main regmap - we can very well get it from
> > > the parent device in sub-drivers as I do now.
> >
> > The whole point of this solution is that you don't need to pass
> > anything non-standard (i.e. not provided by the current APIs) to the
> > child device.
> 
> I don't understand what you're saying here.

I'm saying that the structure you speak of is no longer required.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
