Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2269C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EC72402E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b18rAcUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EC72402E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeGFGJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:09:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753134AbeGFGGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:06:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so2934163wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 23:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+P6I++MAi9n1lN0d+Fqh4Wl2C6SKGuGiRjzdma+NG4E=;
        b=b18rAcURdrz4qVi9UX8kvr7oJxovhLgkpfrAswrbe5GqOuLVCbmTOtzUVR/vtwkfea
         A6SZDWrSsbyXkfIFJEvPLzdWZXogJhJ3uBf53RgRHtf07Ncw+zQsf9g7ig/GT5+KR3I/
         svAuwSooQ8QDOKncE3TRfcQMIRZ/25rh2wiSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+P6I++MAi9n1lN0d+Fqh4Wl2C6SKGuGiRjzdma+NG4E=;
        b=B4/Q78y+dJUS5a3JoeNu0QhZ6id2Ov11rPXnqYNGA5+8LU+rXZ7e6ktlupmKMFxmgX
         9sQt9gtsl+4pYzEYUX+m9Y730ao1bUDlE7jqcG8VZSOh6buXSuv3joPpjAu6SUqmdsKl
         +/yAAuWK+9u4XTvR6I0fmMosZikqqZprbWfYX7lcRfsFtBy+meNymvvfll5MMM9/1q/T
         tFfNM7eIPgZd1MhqT1Ruefzh061G427btI2bxAhsjSJtygvstc8rFmB6TV36+gp0SUOS
         BqrVsnuaHNC2fdpd/il3TwfctSbQb31UaVNlLKtfPFNMJhW+zXzdO0bC+dKyYSZFwcar
         BaWA==
X-Gm-Message-State: APt69E1S/xJ+rfTR20spjAVEN+1pd2rFitS5JfZeUIbSvsyjKS0BnsHE
        H4CKjZ+AhhlIvY0alq/nWnBHPg==
X-Google-Smtp-Source: AAOMgpcQCdR/H8Al1CJImaRyNEXQFc3JCh8gEL0axvrNe4gYAUDXVbLwMHGhwobvSd4wsFI5hRvIXw==
X-Received: by 2002:adf:a6e2:: with SMTP id t89-v6mr6979524wrc.231.1530857172455;
        Thu, 05 Jul 2018 23:06:12 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id s200-v6sm16933185wmb.44.2018.07.05.23.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 23:06:11 -0700 (PDT)
Date:   Fri, 6 Jul 2018 07:06:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com,
        rf@opensource.wolfsonmicro.com, broonie@kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Message-ID: <20180706060609.GT496@dell>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com>
 <7058252.SGNltMTCCa@z50>
 <20180705055037.GI496@dell>
 <1579112.qQSMXVQn9s@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579112.qQSMXVQn9s@z50>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul 2018, Janusz Krzysztofik wrote:
> On Thursday, July 5, 2018 7:50:37 AM CEST Lee Jones wrote:
> > On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:
> > > On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> > > > Hi Janusz,
> > > > 
> > > > On Tue,  3 Jul 2018 19:26:35 +0200
> > > > 
> > > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > > > Avoid replication of error code conversion in non-DT GPIO consumers'
> > > > > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > > > > identified by its label in a registered lookup table is not ready.
> > > > > 
> > > > > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > > > > 
> > > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > > > ---
> > > > > If accepted, please add
> > > > > 
> > > > > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > > 
> > > > > if Boris doesn't mind.
> > > > > 
> > > > > Thanks,
> > > > > Janusz
> > > > > 
> > > > >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> > > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > > index e11a3bb03820..15dc77c80328 100644
> > > > > --- a/drivers/gpio/gpiolib.c
> > > > > +++ b/drivers/gpio/gpiolib.c
> > > > > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct
> > > > > device
> > > > > *dev, const char *con_id,>
> > > > > 
> > > > >  		chip = find_chip_by_name(p->chip_label);
> > > > >  		
> > > > >  		if (!chip) {
> > > > > 
> > > > > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > > > > -				p->chip_label);
> > > > > -			return ERR_PTR(-ENODEV);
> > > > > +			/*
> > > > > +			 * As the lookup table indicates a chip with
> > > > > +			 * p->chip_label should exist, assume it may
> > > > > +			 * still appear latar and let the interested
> > > > > 
> > > > 					^ later
> > > > > 
> > > > > +			 * consumer be probed again or let the Deferred
> > > > > +			 * Probe infrastructure handle the error.
> > > > > +			 */
> > > > > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > > > > +				 p->chip_label);
> > > > > +			return ERR_PTR(-EPROBE_DEFER);
> > > > > 
> > > > >  		}
> > > > >  		
> > > > >  		if (chip->ngpio <= p->chip_hwnum) {
> > > > 
> > > > Looks good otherwise. Let's hope we're not breaking implementations
> > > > testing for -ENODEV...
> > > 
> > > I've reviewed them all and found two which I think may be affected:
> > > - drivers/mfd/arizona-core.c,
> > > - drivers/i2c/busses/i2c-imx.c.
> > > As far as I can understand the code, both depend on error != -EPROBE_DEFER
> > > in order to continue in degraded mode. I'm adding their maintainers to
> > > the loop.
> > From a quick glance, the -EPROBE_DEFER handing in Arizona Core appears
> > to be correct.  Would you mind explaining what your concerns are in
> > more detail please?
> 
> Hi
> 
> That's more about handling -ENODEV rather than -EPROBE_DEFER.
> 
> Before the change, if GPIO chip supposed to provide "reset" pin was not ready 
> during  arizona_dev_init(), devm_gpiod_get() returned -ENODEV and device was 
> initialized in degraded mode, i.e., with no control over the "reset" pin.
> After the change, gpiod_get() will return -EPROBE_DEFER in such case and 
> arizona_dev_init() won't succeed in case the GPIO chip doesn't appear later 
> for some reason.

Yes, I see that now.  Thanks for your explanation.

I'm bringing in the big guns (CC'ed).

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
