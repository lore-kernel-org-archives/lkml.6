Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2A9C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2930C23FEA
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 20:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuso1QmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2930C23FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeGEU4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 16:56:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44344 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeGEU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 16:56:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so7017282ljq.11;
        Thu, 05 Jul 2018 13:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gzMT1cSZbCGff5BKrjRPltQiXPbWPdjiFgo76ko8LCA=;
        b=uuso1QmTAf8f/4aUfOYK5o0UtNVyYVm56whpO1vg+SK3AmJZ0ZJRFbyjWofcSkRA1n
         ES2JVHXBiIUFWoiS1oz3RH0ocLNqtB8b5xpv9p7WQfEHz1wIspNlG7WHqM1cc5NLlm6c
         B76cPXu2rm2l9S+/phlN9sO6xoQXhPolrqvzt5VYcAIfBdeWgMknDVg6/qs2FdCT0Y8m
         ImV3CD1f3rZ4Ch/ESfHUar5uKZiqdZA5Vilej5Zm4io7dwRhdFdetLdORj4pfhAymLj+
         e7Bjvbb3SDR2BR0cnOVvsLg0d/fjwdpvCs9kiQ78tK0wXNZ8UNKIVnRxbOsjlnVng1U9
         jpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gzMT1cSZbCGff5BKrjRPltQiXPbWPdjiFgo76ko8LCA=;
        b=ltn8Mlg1Pk9u39D74Xd6LuNe+S/xs94nc1b3TApvV3P3gm2+Ro+dvBNRzI0rPeaVmG
         aTpYkzj90RavYZwIUJBHYsSPhlXxJTrTi6kRdYsWuyw3CX/d45whayCpIXFTPOqSFTY5
         9rRD0r2ikwFwkPBnTOSWejDgx7p/0nC8r5sZvw8PCAQsNpfIEFc4nBvH31N2t/rHIdlL
         yZ2DBGI1RfAsnVhKcM3ZRI/I/8rzs7IPg+kHgre2TH1i086apep+z1qRcQl58O86WJbK
         Ym/k1GjxYDnTIDD6m4sW564d4FrIhvh0jmRm5ivEFTSsY8FHw8yrM+Yft2jjaOl1yTAG
         AeJQ==
X-Gm-Message-State: APt69E1KMgicXjoaClhKfPIrurd0cs0iqCZ5F1HxjygHcK+qLZjYG7nk
        JK+pr12YIwP/zkdIbWaudw0hV2Y5blM=
X-Google-Smtp-Source: AAOMgpe19njpsT4FRkI4shjXLoCBScX14jFgRH6kRDTplOZIf0hWm2/JZPeslb+lJSL4ieDj1XMP/A==
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr4887852ljr.38.1530824168822;
        Thu, 05 Jul 2018 13:56:08 -0700 (PDT)
Received: from z50.localnet ([31.0.83.69])
        by smtp.gmail.com with ESMTPSA id x21-v6sm1648744lfe.70.2018.07.05.13.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 13:56:07 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date:   Thu, 05 Jul 2018 22:56:40 +0200
Message-ID: <1579112.qQSMXVQn9s@z50>
In-Reply-To: <20180705055037.GI496@dell>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com> <7058252.SGNltMTCCa@z50> <20180705055037.GI496@dell>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 5, 2018 7:50:37 AM CEST Lee Jones wrote:
> On Wed, 04 Jul 2018, Janusz Krzysztofik wrote:
> > On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> > > Hi Janusz,
> > > 
> > > On Tue,  3 Jul 2018 19:26:35 +0200
> > > 
> > > Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > > > Avoid replication of error code conversion in non-DT GPIO consumers'
> > > > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > > > identified by its label in a registered lookup table is not ready.
> > > > 
> > > > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > > > 
> > > > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > > > ---
> > > > If accepted, please add
> > > > 
> > > > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > > > 
> > > > if Boris doesn't mind.
> > > > 
> > > > Thanks,
> > > > Janusz
> > > > 
> > > >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > > index e11a3bb03820..15dc77c80328 100644
> > > > --- a/drivers/gpio/gpiolib.c
> > > > +++ b/drivers/gpio/gpiolib.c
> > > > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct
> > > > device
> > > > *dev, const char *con_id,>
> > > > 
> > > >  		chip = find_chip_by_name(p->chip_label);
> > > >  		
> > > >  		if (!chip) {
> > > > 
> > > > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > > > -				p->chip_label);
> > > > -			return ERR_PTR(-ENODEV);
> > > > +			/*
> > > > +			 * As the lookup table indicates a chip with
> > > > +			 * p->chip_label should exist, assume it may
> > > > +			 * still appear latar and let the interested
> > > > 
> > > 					^ later
> > > > 
> > > > +			 * consumer be probed again or let the Deferred
> > > > +			 * Probe infrastructure handle the error.
> > > > +			 */
> > > > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > > > +				 p->chip_label);
> > > > +			return ERR_PTR(-EPROBE_DEFER);
> > > > 
> > > >  		}
> > > >  		
> > > >  		if (chip->ngpio <= p->chip_hwnum) {
> > > 
> > > Looks good otherwise. Let's hope we're not breaking implementations
> > > testing for -ENODEV...
> > 
> > I've reviewed them all and found two which I think may be affected:
> > - drivers/mfd/arizona-core.c,
> > - drivers/i2c/busses/i2c-imx.c.
> > As far as I can understand the code, both depend on error != -EPROBE_DEFER
> > in order to continue in degraded mode. I'm adding their maintainers to
> > the loop.
> From a quick glance, the -EPROBE_DEFER handing in Arizona Core appears
> to be correct.  Would you mind explaining what your concerns are in
> more detail please?

Hi

That's more about handling -ENODEV rather than -EPROBE_DEFER.

Before the change, if GPIO chip supposed to provide "reset" pin was not ready 
during  arizona_dev_init(), devm_gpiod_get() returned -ENODEV and device was 
initialized in degraded mode, i.e., with no control over the "reset" pin.
After the change, gpiod_get() will return -EPROBE_DEFER in such case and 
arizona_dev_init() won't succeed in case the GPIO chip doesn't appear later 
for some reason.

Thanks,
Januszz



