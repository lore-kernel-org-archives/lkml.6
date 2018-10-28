Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D5C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6429A20672
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ektcp63m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6429A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeJ2FkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:40:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38915 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeJ2FkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:40:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so2172411pla.6;
        Sun, 28 Oct 2018 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdIVM9hysnX97hObu18s1bHs1pSm+N/OszU8FKBvCsw=;
        b=Ektcp63mxrajj+zePK80E8BoM63YtlXmmlcZmZZR4PSsQnl+O8jD+OHE/RNxTIwtB0
         iEHHuZzWNqNBJNQJHgidp2oW1pNeZTEfD0VgV3I5mSGWAMNKB3Y1tphZ6qcThpuaXxhr
         SMBYCZU6s3OstnBMm3UDVcNVnKgQriQ1C48EHuSQWVXkQxiqsjwTJ3NCTuSHE4wyJbc1
         s+mpy46fgFPczR7m991sey75Vx47QFhfiUp24jg1y/dnzOHMJhcGL9JwL/H/JMpd9CNK
         Ons+ylNEB1Cnu+RXAIXtzS84jKcC9stB0TeMScHetmVUQ24wbsRWK8jGgf0pBO+L0c6K
         9FTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdIVM9hysnX97hObu18s1bHs1pSm+N/OszU8FKBvCsw=;
        b=CtKLy5v7gp/5P/zO0QW+YpmMYwmTaQjatPmrKGgzCIfrAQkIl37cIKXsKX+hiiL3kJ
         0vf/347yR3fzgnpbRg2LA9FOHaqjPAwzfcvSg2SG/mnoDVbqWrStY0LVLWtUJRK5R5mm
         mMeSq1WOFLMfsqQUbM7JpLM8s+VuRQPbzivJT4MOy5QGHcR8XNCvUsz5+lpc1ZpLgZTI
         +SHj8teKaeL7ve8Q34trBJJvBAOyK4a5E3BnkzMHyFwlFJoUbtJZeCBMMvRW8zS7f6T4
         Q8JCeyjwwgc+qgqP8QwggGZKH83pDUOdJfS3IW1eGVtDUVmEJq7+rjALR2wBH4fujC5q
         lmkw==
X-Gm-Message-State: AGRZ1gKt0qL6NLYAtfNp27bx1+ze2BTNVRtswp5ikNICZBfwXLojDjTK
        UzZaVddtu0geYtQ+DxAcbj8=
X-Google-Smtp-Source: AJdET5cCEr0oPnxmOgbQgadbofP9SUZnjxWdxlGA659mzCMhCF3iWhrUn4ccZ69zKeA+3ankaJFFNg==
X-Received: by 2002:a17:902:6f16:: with SMTP id w22-v6mr11920886plk.309.1540760054730;
        Sun, 28 Oct 2018 13:54:14 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id f5-v6sm15192761pfb.123.2018.10.28.13.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 13:54:14 -0700 (PDT)
Date:   Mon, 29 Oct 2018 02:24:07 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181028205406.GA31715@nishad>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
 <473e6abfe959e1ac78fe65bf8dc53ad25ad3b358.1540712249.git.nishadkamdar@gmail.com>
 <20181028145108.1079227f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181028145108.1079227f@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 02:51:08PM +0000, Jonathan Cameron wrote:
> On Sun, 28 Oct 2018 13:23:23 +0530
> Nishad Kamdar <nishadkamdar@gmail.com> wrote:
> 
> > Replace platform data with device tree support.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> The whole gpio in or out thing makes less and less sense to
> me and seems to contradict the datasheet.
> 
> If I'm not missing something I would just get rid of the option.
> If I am missing something (not hard in the datasheet which, whilst
> fairly clear, is a rather long ;)
> 
> Jonathan
> 

Ok, I'll drop it.
> > ---
> >  drivers/staging/iio/resolver/Kconfig    |  1 +
> >  drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++---------
> >  drivers/staging/iio/resolver/ad2s1210.h | 17 -----------------
> >  3 files changed, 9 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> > index 6a469ee6101f..cc1202ff813d 100644
> > --- a/drivers/staging/iio/resolver/Kconfig
> > +++ b/drivers/staging/iio/resolver/Kconfig
> > @@ -15,6 +15,7 @@ config AD2S90
> >  
> >  config AD2S1210
> >  	tristate "Analog Devices ad2s1210 driver"
> > +	depends on OF
> >  	depends on SPI
> >  	depends on GPIOLIB || COMPILE_TEST
> >  	help
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> > index 0234869e9d74..5ecdb5785132 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.c
> > +++ b/drivers/staging/iio/resolver/ad2s1210.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/module.h>
> > +#include <linux/of.h>
> >  
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > @@ -76,7 +77,6 @@ struct ad2s1210_gpio {
> >  };
> >  
> >  struct ad2s1210_state {
> > -	const struct ad2s1210_platform_data *pdata;
> >  	struct mutex lock;
> >  	struct spi_device *sdev;
> >  	struct gpio_desc *sample;
> > @@ -84,6 +84,7 @@ struct ad2s1210_state {
> >  	struct gpio_desc *a1;
> >  	struct gpio_desc *res0;
> >  	struct gpio_desc *res1;
> > +	bool gpioin;
> >  	unsigned int fclkin;
> >  	unsigned int fexcit;
> >  	bool hysteresis;
> > @@ -314,7 +315,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
> >  	}
> >  	st->resolution
> >  		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> > -	if (st->pdata->gpioin) {
> > +	if (st->gpioin) {
> >  		data = ad2s1210_read_resolution_pin(st);
> >  		if (data != st->resolution)
> >  			dev_warn(dev, "ad2s1210: resolution settings not match\n");
> > @@ -376,7 +377,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
> >  	}
> >  	st->resolution
> >  		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> > -	if (st->pdata->gpioin) {
> > +	if (st->gpioin) {
> >  		data = ad2s1210_read_resolution_pin(st);
> >  		if (data != st->resolution)
> >  			dev_warn(dev, "ad2s1210: resolution settings not match\n");
> > @@ -603,7 +604,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
> >  	int ret;
> >  
> >  	mutex_lock(&st->lock);
> > -	if (st->pdata->gpioin)
> > +	if (st->gpioin)
> >  		st->resolution = ad2s1210_read_resolution_pin(st);
> >  	else
> >  		ad2s1210_set_resolution_pin(st);
> > @@ -644,7 +645,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> >  	int ret, i;
> >  	struct spi_device *spi = st->sdev;
> >  	struct ad2s1210_gpio *pin;
> > -	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> > +	unsigned long flags = st->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> >  
> >  	struct ad2s1210_gpio gpios[] = {
> >  		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
> > @@ -673,16 +674,14 @@ static int ad2s1210_probe(struct spi_device *spi)
> >  {
> >  	struct iio_dev *indio_dev;
> >  	struct ad2s1210_state *st;
> > +	struct device_node *np = spi->dev.of_node;
> >  	int ret;
> >  
> > -	if (!spi->dev.platform_data)
> > -		return -EINVAL;
> > -
> >  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> >  	st = iio_priv(indio_dev);
> > -	st->pdata = spi->dev.platform_data;
> > +	st->gpioin = of_property_read_bool(np, "gpioin");
> 
> Hmm. This bothered me in the earlier patch.  How are we meant to configure
> these pins... (and this time I actually loaded the datasheet)
> 
> A0 and A1 always seem to be control signals written to the device so
> I don't really understand why we would ever want them to be 'inputs'
> on our host.
> 
> RES0 and RES1 are also control signals. Clearly marked as logic inputs.
> 
> The only thing I can think here is there is an evaluation board out there
> were we are not in control of these, some other controller is.
> That is a pretty weird board if so, hence I would only support the version
> where we use GPIO outputs from the host.
> 
> This will further simplify patch 1 and get rid fo the need for this
> non standard bit of devicetree binding.
> 
> 
> >  	ret = ad2s1210_setup_gpios(st);
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> > index 63d479b20a6c..e69de29bb2d1 100644
> > --- a/drivers/staging/iio/resolver/ad2s1210.h
> > +++ b/drivers/staging/iio/resolver/ad2s1210.h
> > @@ -1,17 +0,0 @@
> > -/*
> > - * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
> > - * AD2S1210
> > - *
> > - * Copyright (c) 2010-2010 Analog Devices Inc.
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - */
> > -#ifndef _AD2S1210_H
> > -#define _AD2S1210_H
> > -
> > -struct ad2s1210_platform_data {
> > -	bool			gpioin;
> > -};
> > -#endif /* _AD2S1210_H */
> 

Ok, I'll make the changes.

Thanks for the review.

regards,
Nishad
