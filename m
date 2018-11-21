Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2852FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08F720989
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVfs2+IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08F720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbeKUUGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:06:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41810 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbeKUUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:06:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4695728plm.8;
        Wed, 21 Nov 2018 01:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TQfDm2rJSEWujJYXBAhTMvO2sOclXoeXPdcVrwnOzeg=;
        b=PVfs2+IY/X5/h7egQC3ejbNmOfk/6e0Se0YYNleZhz6+fiTWt/zt0vbu/B86UItj+z
         G1dDoGLF8Ao1NodReUqV4L+SFJcelvSsG0dczefwnytcJAlN8m7VF99TEus3dkNS1pGn
         VsU/XjP7/+91DHy716qjWJh4+39HMufIWIUsRt16DNEyNpoJBug4WZQBR2VIfPcz1t8a
         fPoyf2DnNGILwg0uGcPMS3fx5vUUoy4CKv2eqT1Iso94wQzb9NMvit0xvSoDyHPJKaSd
         sfaxc2NIblOUCsW4cUAZX70tJmMsYmUJ137xfkosnatKaDTtb8JsdhpMQ8lyEi1Px1lb
         rVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TQfDm2rJSEWujJYXBAhTMvO2sOclXoeXPdcVrwnOzeg=;
        b=d6gNe1Ob0mbLLY/wMDmpF/BQWdOUvas3oMiybDX+qBWsQ7V0v7NsdMYBlz4/TB9NsP
         auFlWA/03GhLKp0jMCjSIfyPeykPd4J7Qq7sUDmoTY+h5XfdGJsYK5TW6ZzMIqdyrF8L
         U4Spby03LFJFLvKb+i9AGl1GZiBtirp3i2ZNQBWxPKFNmpFNaBTXzl3YAFHD3wRpD8zt
         nreUDKnLsyaz4scIzznBlXAa2GRVrEfeCfAGbHkUuLCjl/ntTiKqWW+rVZ3Vgh9PHfhC
         fSYqo8mScL0nUQ5uRlZd0kHP7pLVC4c85eVWKqaGUmIVC3piMkokRksF5HB3lFnBr092
         Cm1g==
X-Gm-Message-State: AA+aEWaARRk4WYatgdOEDEmh/BJhOcjuKC9S3mv3kgS0/JSg9giS79qx
        k8eufoSOPYJIrdUuqJglhS0=
X-Google-Smtp-Source: AFSGD/UlFUYlZ0vtoumdmtRC0/iVpdmTUe1kbTFiN0hc+VYvmjubxgLY9OfotrzYldZzXErsjwbhjg==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr5987080pld.240.1542792777153;
        Wed, 21 Nov 2018 01:32:57 -0800 (PST)
Received: from Shreeya-Patel ([103.212.140.139])
        by smtp.googlemail.com with ESMTPSA id w136sm34445735pfd.169.2018.11.21.01.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 01:32:56 -0800 (PST)
Message-ID: <394a787d3afaeb6314c517739697430102170027.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] Staging: iio: adt7316: Use device tree data to
 assign irq_type
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Date:   Wed, 21 Nov 2018 15:02:52 +0530
In-Reply-To: <8f659e4351a9b2511658b01c0b18bed94ef72802.camel@analog.com>
References: <20181120170036.7403-1-shreeya.patel23498@gmail.com>
         <8f659e4351a9b2511658b01c0b18bed94ef72802.camel@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-21 at 08:21 +0000, Ardelean, Alexandru wrote:
> On Tue, 2018-11-20 at 22:30 +0530, Shreeya Patel wrote:
> > ADT7316 driver no more uses platform data and hence use device tree
> > data instead of platform data for assigning irq_type field.
> > Switch case figures out the type of irq and if it's the default
> > case
> > then assign the default value to the irq_type i.e.
> > irq_type = IRQF_TRIGGER_LOW
> > 
> 
> 1 comment inline
> 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c
> > b/drivers/staging/iio/addac/adt7316.c
> > index 9c72538baf9e..c647875a64f5 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  {
> >  	struct adt7316_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> > -	unsigned short *adt7316_platform_data = dev-
> > >platform_data;
> > -	int irq_type = IRQF_TRIGGER_LOW;
> > +	int irq_type;
> >  	int ret = 0;
> >  
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> > @@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	if (chip->bus.irq > 0) {
> > -		if (adt7316_platform_data[0])
> > -			irq_type = adt7316_platform_data[0];
> > +		irq_type =
> > +			irqd_get_trigger_type(irq_get_irq_data(chi
> > p-
> > > bus.irq));
> > 
> > +
> > +		switch (irq_type) {
> > +		case IRQF_TRIGGER_HIGH:
> > +		case IRQF_TRIGGER_RISING:
> > +			break;
> > +		case IRQF_TRIGGER_LOW:
> > +		case IRQF_TRIGGER_FALLING:
> > +			break;
> > +		default:
> > +			dev_info(dev, "mode %d unsupported, using
> > IRQF_TRIGGER_LOW\n",
> > +				 irq_type);
> > +			irq_type = IRQF_TRIGGER_LOW;
> > +			break;
> > +		}
> 
> It would be an idea to move this part [together with
> devm_request_threaded_irq()] into a "adt7316_setup_irq()" function.
> To un-
> clutter the code in the adt7316_probe() function.
> 

Yes, seems like a good idea!
Even other drivers are doing the same as you told me to do...thanks :)

I'll do the change after Jonathan picks up the other patches and will
wait for some other reviews to come up if there are any.

Thanks

> >  
> >  		ret = devm_request_threaded_irq(dev, chip-
> > >bus.irq,
> >  						NULL,
