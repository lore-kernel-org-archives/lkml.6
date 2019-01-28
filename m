Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DC6C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63822148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfA1IN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:13:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34119 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1INz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:13:55 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so13437113lje.1;
        Mon, 28 Jan 2019 00:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mDH2EBeuVoPNQ28shq2o7cEzMyblSwKtoSJoNnp5B7U=;
        b=mxD/50dkp4J1JHSx61IbNaRgK+QU/eBeHlRP7B4BJonWcBOh82pG1LBHEgMSDFNrut
         HN8vViQGrHSDBTZTHBPR4yVsdzfiuL4+8yGk95Mx7lLGldRdBN/M+wpbdMJYk9HGdrYf
         ujbYX+OiQJGoTWLy5EvKLU7Ks/CgZG8yQRWwyBaPQNEjzJpaoZBzNPE+wgXe0dRz1vJ7
         HVCG4x49+BpoBY+7MPjplLd7LfffR2JDQJIJv8blDIu5m+++Aoze8JPOQ5sIcWx6CJca
         UkuRZDDh1TfPcDhHLYMfQT4BFE+cEAM+ABeik449Jxf39nAqHR8WzDn7fDp/L4TNsWtI
         Bb8g==
X-Gm-Message-State: AJcUukcAl1K7QxoDpkjDWMLHATdnE7GxaroAjVCvI7+F8hnTrook4W59
        3+k0byLxjJTVwefqc3tJTQk=
X-Google-Smtp-Source: ALg8bN5XiLCONylg2aC6T/SdpHwq5xUWV2QXoVhOpZ9Gd6Y0ijp8JaIyaViyFHsxDFyrgyllJ+E/CA==
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr16234002ljb.11.1548663232370;
        Mon, 28 Jan 2019 00:13:52 -0800 (PST)
Received: from localhost.localdomain (dytkl7s9vpj00trvf9g2y-4.rev.dnainternet.fi. [2001:14bb:410:9dbf:b161:fde8:3a24:e96c])
        by smtp.gmail.com with ESMTPSA id w12sm2801890lfe.80.2019.01.28.00.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 00:13:51 -0800 (PST)
Date:   Mon, 28 Jan 2019 10:13:47 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     mazziesaccount@gmail.com, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/10] watchdog: bd70528: Initial support for ROHM
 BD70528 watchdog block
Message-ID: <20190128081347.GD2030@localhost.localdomain>
References: <20190125110625.GA29348@localhost.localdomain>
 <1d05ec19-daf6-f1d9-f80c-57fc92906d22@roeck-us.net>
 <20190128080035.GC2030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128080035.GC2030@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 10:00:35AM +0200, Matti Vaittinen wrote:
> On Sat, Jan 26, 2019 at 08:36:14AM -0800, Guenter Roeck wrote:
> > On 1/25/19 3:06 AM, Matti Vaittinen wrote:
> > > +/* Max time we can set is 1 hour, 59 minutes and 59 seconds */
> > > +#define WDT_MAX_MS ((2 * 60 * 60 - 1) * 1000)
> > > +/* Minimum time is 1 second */
> > > +#define WDT_MIN_MS 1000
> > > +#define DEFAULT_TIMEOUT 60
> > > +
> > > +static int bd70528_wdt_probe(struct platform_device *pdev)
> > > +{
> > > +	struct bd70528 *bd70528;
> > > +	struct wdtbd70528 *w;
> > > +	int ret;
> > > +	unsigned int reg;
> > > +	struct watchdog_device *wdt;
> > > +
> > > +	bd70528 = dev_get_drvdata(pdev->dev.parent);
> > > +	if (!bd70528) {
> > > +		dev_err(&pdev->dev, "No MFD driver data\n");
> > > +		return -EINVAL;
> > > +	}
> > > +	w = devm_kzalloc(&pdev->dev, sizeof(*w), GFP_KERNEL);
> > > +	if (!w)
> > > +		return -ENOMEM;
> > > +	w->bd = bd70528;
> > 
> > Unless I am missing something, only the mutex and the regmap pointer
> > are used from struct bd70528. With that in mind, it might be desirable
> > to copy those pointers to struct wdtbd70528 to avoid the additional
> > dereferencing at runtime.
> 
> You are not missing anyting. If we ever add support for another PMIC
> variant we will probably be using also the chip_type. Untill then only
> the mutex and regmap. (And maybe the of_node if we have any RTC
> properties in DT). So at this point we just use regmap and mutex. I will
> change this.

Oh, but actually we are also using the WDT state setting function
provided by MFD. And this is taking the struct bd70528 as parameter. So
maybe we can keep it like this afterall? 

> 
> > > +	w->dev = &pdev->dev;
> > > +
> > > +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > > +	if (!wdt)
> > > +		return -ENOMEM;
> > > +
> > 
> > struct watchdog_device can be part of struct wdtbd70528. Two separate allocations
> > are not necessary.
> 
> Correct. Thanks for pointing that out. I'll simplify this.
> 
> > > +	wdt->info = &bd70528_wdt_info;
> > > +	wdt->ops =  &bd70528_wdt_ops;
> > > +	wdt->min_hw_heartbeat_ms = WDT_MIN_MS;
> > > +	wdt->max_hw_heartbeat_ms = WDT_MAX_MS;
> > > +	wdt->parent = pdev->dev.parent;
> > > +	wdt->timeout = DEFAULT_TIMEOUT;
> > > +	watchdog_set_drvdata(wdt, w);
> > > +	watchdog_init_timeout(wdt, 0, pdev->dev.parent);
> > > +
> > > +	ret = bd70528_wdt_set_timeout(wdt, wdt->timeout);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to set the watchdog timeout\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	mutex_lock(&bd70528->rtc_timer_lock);
> > > +	ret = regmap_read(bd70528->chip.regmap, BD70528_REG_WDT_CTRL, &reg);
> > > +	mutex_unlock(&bd70528->rtc_timer_lock);
> > > +
> > 
> > I don't see the point for the above mutex locks. This is just reading a
> > single register. regmap itself provides locking for that already.
> 
> It has a purpose here - but I'd better add a comment. We want to get the
> initial state of WDG here. If the probe is executed when RTC time is being
> set we may read the state just when RTC is (temporarily) disabling WDT -
> and we might tell the WDT core that WDT is disabled - even if it is
> actually enabled. The mutex prevents us from reading the WDT state when
> RTC is being set.
>  
> Br,
> 	Matti Vaittinen
