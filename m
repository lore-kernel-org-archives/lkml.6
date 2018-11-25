Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5846BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1881720865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 11:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvJi5hCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1881720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbeKYWoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 17:44:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKYWoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 17:44:21 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C953120855;
        Sun, 25 Nov 2018 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543146805;
        bh=o3O4jBFYpjdgqtN/BIvR7kmfD7hVw4ewm2xJxQGrKKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uvJi5hCiikL4SUXWtIKEirjq4EEk3ChpruOD54AmlqN0n3cp3ZsWzBHVjEOv1zRDc
         xKM5x9Suk6LQfxwI/phD9sd64MJUnktC1pPLFFvuSWC0Yx4guQ/aWfcDOlLRNVDHLv
         WL8uVzGx2xsEgzopTL+3RSKIXUSC+vNSapj4NJFE=
Date:   Sun, 25 Nov 2018 11:53:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 5/5] Staging: iio: adt7316: Use device tree data to
 assign irq_type
Message-ID: <20181125115320.08833521@archlinux>
In-Reply-To: <394a787d3afaeb6314c517739697430102170027.camel@gmail.com>
References: <20181120170036.7403-1-shreeya.patel23498@gmail.com>
        <8f659e4351a9b2511658b01c0b18bed94ef72802.camel@analog.com>
        <394a787d3afaeb6314c517739697430102170027.camel@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 15:02:52 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> On Wed, 2018-11-21 at 08:21 +0000, Ardelean, Alexandru wrote:
> > On Tue, 2018-11-20 at 22:30 +0530, Shreeya Patel wrote:  
> > > ADT7316 driver no more uses platform data and hence use device tree
> > > data instead of platform data for assigning irq_type field.
> > > Switch case figures out the type of irq and if it's the default
> > > case
> > > then assign the default value to the irq_type i.e.
> > > irq_type = IRQF_TRIGGER_LOW
> > >   
> > 
> > 1 comment inline
> >   
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> > > ---
> > >  drivers/staging/iio/addac/adt7316.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/addac/adt7316.c
> > > b/drivers/staging/iio/addac/adt7316.c
> > > index 9c72538baf9e..c647875a64f5 100644
> > > --- a/drivers/staging/iio/addac/adt7316.c
> > > +++ b/drivers/staging/iio/addac/adt7316.c
> > > @@ -2101,8 +2101,7 @@ int adt7316_probe(struct device *dev, struct
> > > adt7316_bus *bus,
> > >  {
> > >  	struct adt7316_chip_info *chip;
> > >  	struct iio_dev *indio_dev;
> > > -	unsigned short *adt7316_platform_data = dev-  
> > > >platform_data;  
> > > -	int irq_type = IRQF_TRIGGER_LOW;
> > > +	int irq_type;
> > >  	int ret = 0;
> > >  
> > >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> > > @@ -2146,8 +2145,22 @@ int adt7316_probe(struct device *dev, struct
> > > adt7316_bus *bus,
> > >  	indio_dev->modes = INDIO_DIRECT_MODE;
> > >  
> > >  	if (chip->bus.irq > 0) {
> > > -		if (adt7316_platform_data[0])
> > > -			irq_type = adt7316_platform_data[0];
> > > +		irq_type =
> > > +			irqd_get_trigger_type(irq_get_irq_data(chi
> > > p-  
> > > > bus.irq));  
> > > 
> > > +
> > > +		switch (irq_type) {
> > > +		case IRQF_TRIGGER_HIGH:
> > > +		case IRQF_TRIGGER_RISING:
> > > +			break;
> > > +		case IRQF_TRIGGER_LOW:
> > > +		case IRQF_TRIGGER_FALLING:
> > > +			break;
> > > +		default:
> > > +			dev_info(dev, "mode %d unsupported, using
> > > IRQF_TRIGGER_LOW\n",
> > > +				 irq_type);
> > > +			irq_type = IRQF_TRIGGER_LOW;
> > > +			break;
> > > +		}  
> > 
> > It would be an idea to move this part [together with
> > devm_request_threaded_irq()] into a "adt7316_setup_irq()" function.
> > To un-
> > clutter the code in the adt7316_probe() function.
> >   
> 
> Yes, seems like a good idea!
> Even other drivers are doing the same as you told me to do...thanks :)
> 
> I'll do the change after Jonathan picks up the other patches and will
> wait for some other reviews to come up if there are any.
Agreed. This suggested change is good, so I'll leave this patch for now
on the basis it probably makes sense to do it as a short series focused
on that one element.

Thanks,

Jonathan

> 
> Thanks
> 
> > >  
> > >  		ret = devm_request_threaded_irq(dev, chip-  
> > > >bus.irq,  
> > >  						NULL,  

