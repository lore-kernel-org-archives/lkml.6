Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663F9C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295D3222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktm4SudR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387713AbfBMJxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39548 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfBMJxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id f16so1673820wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hx7G0whfY6I3zwZKz00ap7A9CQvAiNh6dmR960MQEDo=;
        b=ktm4SudR7tZVQbeQ+LACuslEuTLfIykOouJt0PnexDGs+5ssD9yD3WRD6CK/gB4dUz
         AdX5H/KZWSwhf4rPjaf80hRzd2s0xtsLWtK0xNMutIJJ/2Gza6PdG6TbcOi3xAIQaSWs
         zwkHry5QE/u+sI0BiypGoINZoTG4pH4bcQsN1COEjLYD/CS2ZER3WAOPQC+WI+FacvH3
         U4AtMwxwZReyyhyBe0DIt0RBAVWXCJf+hRWyUw3KqUSiEsIVHddSI7HKRYfwwF27dowo
         dRR6T05ZDaeJA82Zn8A/iBouq27ZmGfNJajfGQWDdbuhnUg0cWADVGsUjknAarULujOB
         MZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hx7G0whfY6I3zwZKz00ap7A9CQvAiNh6dmR960MQEDo=;
        b=Tdz2Kmw0+shHaQwiZEjHgYCh+tH+HiJ7r8Ris8Ucy/AyDXteau7acZDuZMS3Bf1UPG
         GW82S/YZ9x1/VPDfUbLuyUHfszoaMqe7McwznuOGDswUt4SO6euFSRqVQMNSSYMSaKtv
         aAEHpjdvm5552Ww+SU980ndjzfVdDtYtrTcmTmV0hW1fZ0j6JNHmp+NdIpHnzIV3ru6T
         fYIOGh5tmOVmF6YWIf4tNroz8UQ2m8r4aasBEylsZ5T2GSLQcSHEBx0m9cTchH7rlVO0
         5IdQMayHFyafIs2nx/0NTm7IOYqkR81bukRtVlQ/EpldCAYqZ/MGxC+7o0Jnb1su0GHp
         GdCQ==
X-Gm-Message-State: AHQUAub1dj2XtXIeNfl2S+aG50knQz8sslfC0oyVLKlHjEMANKCoKhGa
        9qAZ8k+AEWLrvNX0srPNkaMGtw==
X-Google-Smtp-Source: AHgI3IYu/T9qYu/15HxxYkaZnyTtTgVPScr/bbW28zdFwO/s0wW0xt9c2065rXDNP2+J8QJ1P7zSWQ==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr2667949wmd.67.1550051612753;
        Wed, 13 Feb 2019 01:53:32 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id 2sm36787848wrg.89.2019.02.13.01.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:53:32 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:53:30 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
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
Subject: Re: [PATCH v4 05/10] mfd: max77650: new core mfd driver
Message-ID: <20190213095330.GF1863@dell>
References: <CAMRc=MderQf20_8aG4-otBkCv60FSNSSqV3NVALPkFL-MqmJbg@mail.gmail.com>
 <20190212095457.GA20638@dell>
 <CAMRc=MdyT7nMJ7dUTf6M3PvRdynaCurb_TftMyA4eCwzpR9fVA@mail.gmail.com>
 <20190212101835.GB20638@dell>
 <CAMRc=MfYeVbvY6O03xq4eLN9TVpAKWCAXPk0eP5LSBCU7VU9fA@mail.gmail.com>
 <20190212111403.GC20638@dell>
 <CAMpxmJWXOb1HW4QiEn8gMp3Nh05ahE0CMLXkac+hEKRjtGxTHQ@mail.gmail.com>
 <20190212132016.GA4781@dell>
 <20190213092553.GE1863@dell>
 <CAMRc=MeTMq_GWzQB6LBvts1csMftj=On5sB22jsJZzQzONxbNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MeTMq_GWzQB6LBvts1csMftj=On5sB22jsJZzQzONxbNg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019, Bartosz Golaszewski wrote:

> śr., 13 lut 2019 o 10:25 Lee Jones <lee.jones@linaro.org> napisał(a):
> >
> > On Tue, 12 Feb 2019, Lee Jones wrote:
> >
> > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > >
> > > > wt., 12 lut 2019 o 12:14 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > >
> > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > >
> > > > > > wt., 12 lut 2019 o 11:18 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > >
> > > > > > > On Tue, 12 Feb 2019, Bartosz Golaszewski wrote:
> > > > > > >
> > > > > > > > wt., 12 lut 2019 o 10:55 Lee Jones <lee.jones@linaro.org> napisał(a):
> > > > > > > > >
> > > > > > > > >  * The declaration of a superfluous struct
> > > > > > > > >  * 100 lines of additional/avoidable code
> > > > > > > > >  * Hacky hoop jumping trying to fudge VIRQs into resources
> > > > > > > > >  * Resources were designed for HWIRQs (unless a domain is present)
> > > > > > > > >  * Loads of additional/avoidable CPU cycles setting all this up
> > > > > > > >
> > > > > > > > While the above may be right, this one is negligible and you know it. :)
> > > > > > >
> > > > > > > You have nested for() loops.  You *are* wasting lots of cycles.
> > > > > > >
> > > > > > > > > Need I go on? :)
> > > > > > > > >
> > > > > > > > > Surely the fact that you are using both sides of an API
> > > > > > > > > (devm_regmap_init_i2c and regmap_irq_get_*) in the same driver, must
> > > > > > > > > set some alarm bells ringing?
> > > > > > > > >
> > > > > > > > > This whole HWIRQ setting, VIRQ getting, resource hacking is a mess.
> > > > > > > > >
> > > > > > > > > And for what?  To avoid passing IRQ data to a child driver?
> > > > > > > >
> > > > > > > > What do you propose? Should I go back to the approach in v1 and pass
> > > > > > > > the regmap_irq_chip_data to child drivers?
> > > > > > >
> > > > > > > I'm saying you should remove all of this hackery and pass IRQs as they
> > > > > > > are supposed to be passed (like everyone else does).
> > > > > >
> > > > > > I'm not sure what you mean by "like everyone else does" - different
> > > > > > mfd drivers seem to be doing different things. Is a simple struct
> > > > > > containing virtual irq numbers passed to sub-drivers fine?
> > > > >
> > > > > How do you plan on deriving the VIRQs to place into the struct?
> > > >
> > > > Exampe:
> > > >
> > > > struct max77650_gpio_pdata {
> > > >     int gpi_irq;
> > > > };
> > > >
> > > > In MFD driver:
> > > >
> > > > struct max77650_gpio_pdata *gpio_data = devm_kmalloc(dev, sizeof(*gpio_data));
> > > >
> > > > gpio_data->gpi_irq = regmap_irq_get_virq(irqchip_data, GPI_NUM);
> > > >
> > > > gpio_cell.platform_data = gpio_data;
> > > >
> > > > In GPIO driver:
> > > >
> > > > struct max77650_gpio_pdata *gpio_data = pdev->dev.platform_data;
> > > >
> > > > int irq = gpio_data->gpi_irq;
> > >
> > > Definitely not.  What you're trying to do is a hack.
> > >
> > > If you're using Regmap to handle your IRQs, then you should use Regmap
> > > in the client to pull them out.  Setting them via Regmap, then pulling
> > > them out again in the *same driver*, only to store them in platform
> > > data to be passed to a child device is bonkers.
> > >
> > > *Either* use the MFD provided platform-data helpers *or* pass and
> > > handle them via the Regmap APIs, *not* both.
> >
> > Right, a plan has been formed.
> >
> > Hopefully this works and you can avoid all this dancing around.
> >
> > Firstly, you need to make a small change to:
> >
> >   drivers/base/regmap/regmap-irq.c
> >
> > Add the following function:
> >
> >   struct irq_domain *regmap_irq_get_domain(struct regmap *map)
> 
> We already do have such function and a lot of mfd drivers actually use it.

Even better.

> > As you can see, it will return the IRQ Domain for the chip.
> >
> > You can then pass this IRQ domain to mfd_add_devices() and it will do
> > the HWIRQ => VIRQ mapping for you on the fly.  Meaning that you can
> > remove all the nastiness in max77650_setup_irqs() and have the Input
> > device use the standard (e.g. platform_get_irq()) APIs.
> >
> > How does that Sound?
> 
> This does sound better! Why didn't you lead with that in the first place?

I'm not even going to dignify that stupid question with a response.

> It's a pity it's not documented, I had to look at the code to find out
> irq resources would get translated in mfd_add_devices() if a domain is
> present.

Where is it likely to be documented?  MFD is pretty simple and seldom
needs explanation.  A 3 second look at the API you're trying to use
(instead of blind copy & paste) would have told you that it's possible
to take an IRQ domain as an argument.

It's only the craziness in this patch which forced me to look into how
Regmap handles IRQs and come up with a subsequent solution which fits
your use-case.

> In that case - I really don't see a reason to create a superfluous
> structure to only hold the main regmap - we can very well get it from
> the parent device in sub-drivers as I do now.

The whole point of this solution is that you don't need to pass
anything non-standard (i.e. not provided by the current APIs) to the
child device.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
