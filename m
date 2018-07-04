Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7025BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9CC20779
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GioVhdqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C9CC20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeGDTOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:14:35 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37872 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752571AbeGDTNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:13:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id c11-v6so4979824lja.4;
        Wed, 04 Jul 2018 12:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoEXi07qEj1DXsbklMFeG5ogGA8DiHcsoC4Yw2C008g=;
        b=GioVhdqmMrzFsTSx+Ek6X1fysNk+ua1vCnnyPeUGHAxCa98WHDC03nAE28KYtzXCws
         MoRgd6gd0FnPVtvuyK9xVF/Ja88p9zDqbhTmY3TOVc/3URyKyBYR9j0eJ339bGZIVpIG
         /AZXeInE9ccm9JfVADg2PazCDATKMEyaNVO2PidoJPgjEzJfoQIOz1ChK/2bEEoabTNr
         4m/B8elcx1NlpEwZwHwwZ4XgcWilx635vcCClgnqlImYVyDyHiFRCDfREXniAAr4NEkT
         5Ccfzx+/SmUD+umq0yVtyHzkQOIxeZiKgDsEbNcbR5gUJt1lLeHrs6DHTVyVmGj353jk
         87Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoEXi07qEj1DXsbklMFeG5ogGA8DiHcsoC4Yw2C008g=;
        b=DOkuwzi/eMHk3A0QZioLfRm0d9NX6jnSQFWjHvH7ji2W1fASXEf/XIW5qajJGfeWCR
         YUqZBYaa5YknwDhbjUqgruwNftxbldZY2AXj6rQ73+hZ/R+l/gG8X9g1LMH/T5F5pbX8
         YuFzQhJx1IfQgo8luSTbmsYZpE592wk0g3PRqCl1wacggxM1IoAEysmYoBBG3sIoMb5w
         QStyC7ZeI0hZjrQRSzbu9WZ7MjB1hAkAmmi6blsaQs9OEd21Xo05I/o4OhN+WVUIATj0
         YiJZ2FHeF5w3aCqTMYMY/qUbcKIvxrwiiNpIHFrIxENSpxnnOTqytKKD0AMUoZHRl2YQ
         hWeQ==
X-Gm-Message-State: APt69E3HKwYjHVu0L737SC38CircZ6vgENHNXin9Ptjf4Bc5HK7pETgI
        53bbtFqZ4MTQIaOGgNK1g+Y=
X-Google-Smtp-Source: AAOMgpfRY9S8kU7di2onaLjpoI+SQiXLS7YN8n4gS52kUs4eDTnGK4EARSWNnG0BpoSRpW0xuWIlmQ==
X-Received: by 2002:a2e:7c12:: with SMTP id x18-v6mr2161163ljc.71.1530731588357;
        Wed, 04 Jul 2018 12:13:08 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h20-v6sm939400lfl.77.2018.07.04.12.13.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 12:13:07 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Phil Reid <preid@electromag.com.au>,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Peter Rosin <peda@axentia.se>, patches@opensource.cirrus.com,
        linux-i2c@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH] gpiolib: Defer on non-DT find_chip_by_name() failure
Date:   Wed, 04 Jul 2018 21:13:42 +0200
Message-ID: <7058252.SGNltMTCCa@z50>
In-Reply-To: <20180703193141.747fa950@bbrezillon>
References: <20180703172635.32508-1-jmkrzyszt@gmail.com> <20180703193141.747fa950@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 3, 2018 7:31:41 PM CEST Boris Brezillon wrote:
> Hi Janusz,
> 
> On Tue,  3 Jul 2018 19:26:35 +0200
> 
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> > Avoid replication of error code conversion in non-DT GPIO consumers'
> > code by returning -EPROBE_DEFER from gpiod_find() in case a chip
> > identified by its label in a registered lookup table is not ready.
> > 
> > See https://lkml.org/lkml/2018/5/30/176 for example case.
> > 
> > Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> > ---
> > If accepted, please add
> > 
> > 	Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> > 
> > if Boris doesn't mind.
> > 
> > Thanks,
> > Janusz
> > 
> >  drivers/gpio/gpiolib.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index e11a3bb03820..15dc77c80328 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -3639,9 +3639,16 @@ static struct gpio_desc *gpiod_find(struct device
> > *dev, const char *con_id,> 
> >  		chip = find_chip_by_name(p->chip_label);
> >  		
> >  		if (!chip) {
> > 
> > -			dev_err(dev, "cannot find GPIO chip %s\n",
> > -				p->chip_label);
> > -			return ERR_PTR(-ENODEV);
> > +			/*
> > +			 * As the lookup table indicates a chip with
> > +			 * p->chip_label should exist, assume it may
> > +			 * still appear latar and let the interested
> 
> 					^ later
> 
> > +			 * consumer be probed again or let the Deferred
> > +			 * Probe infrastructure handle the error.
> > +			 */
> > +			dev_warn(dev, "cannot find GPIO chip %s, deferring\n",
> > +				 p->chip_label);
> > +			return ERR_PTR(-EPROBE_DEFER);
> > 
> >  		}
> >  		
> >  		if (chip->ngpio <= p->chip_hwnum) {
> 
> Looks good otherwise. Let's hope we're not breaking implementations
> testing for -ENODEV...

I've reviewed them all and found two which I think may be affected:
- drivers/mfd/arizona-core.c,
- drivers/i2c/busses/i2c-imx.c.
As far as I can understand the code, both depend on error != -EPROBE_DEFER in 
order to continue in degraded mode. I'm adding their maintainers to the loop.

Thanks,
Janusz



