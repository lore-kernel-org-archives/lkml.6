Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C4EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460ED20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T61bxU2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460ED20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeLHQoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:44:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40319 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeLHQoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:44:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so3372583pfo.7;
        Sat, 08 Dec 2018 08:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fr4i+rQk80cGKL45k8oAJNafJmbFKBOUVzE5zVwQUWo=;
        b=T61bxU2IECa0byQ6N33lFA3Y34fcWaK46kQSWUjKlQJIcvy/CGGnxato2gSTloaZSG
         KXWOH3BVEKtVaQ1Dg3bpmTMFuuFvsoNBrOmMEpWyIyS7rc8VAWxi9X6kFenLffu6Yvh+
         IU8kv70s3lQD7OC4PySbfShqzw5API4KtqNJOgCppeeWIfDPTQ+o2BT5HfT17/Cm+O72
         V0USOenyuiT/gVTbfuxUPzKdKckYgpfbTFPJW58HFxbjYbzrJHYvYJYlRfhLzkGz5oCd
         k9KDAbsAOtxKI27jJNoOAwBNkFjKVYG8Kps/+yLjrWAH0tXloE7W7bFd9VpX2/2cVdfZ
         KHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fr4i+rQk80cGKL45k8oAJNafJmbFKBOUVzE5zVwQUWo=;
        b=Xyzw7Zzh5PYVwfYlmeShHeTRe3W4743g0UIppVtOY156qXX5VG77qFLkf69UTHYKp+
         96xMmTZyXGtP/dycZZBM/4GvIpKdzZZFnUiORMBqIi2BLrU5A1eCVrR76bNUtJfV/N/y
         4afGOLeuzBIjEGBAr0Zaxc6haiRTSMeZLbxaE/6GUnktUnSjLk7Uw+3Wx1kuXhqIm2+x
         MQMuCLlqeVK1gjB9toRp/WLRET7swsV1vxWC6fF9BWQFAZiLVoEBCQgBcJ+PbMcRJmn3
         qa47SPUFYsg5c75zWx10ymSYuXFEbnPxYgc+lbdHs9serDCRk2MzoNt1ZPGAoJMjeUYH
         859w==
X-Gm-Message-State: AA+aEWZ8SZFPjDc+OfsYrXyrtTIDMWPbQBEtWwFvvliBR6oxcuT//Njz
        rNTDBdqK1TPM1cLbP4g74c0=
X-Google-Smtp-Source: AFSGD/UMWlr1RH4eXM3OcbJSo0SZMyJEKd6OXfeWi69ZSFjVV9wb2GcjyIXmZ8S7GRMKUeqS1Yzqyw==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr5527912pgc.11.1544287457901;
        Sat, 08 Dec 2018 08:44:17 -0800 (PST)
Received: from Shreeya-Patel ([103.212.140.153])
        by smtp.googlemail.com with ESMTPSA id w136sm10113626pfd.169.2018.12.08.08.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 08:44:17 -0800 (PST)
Message-ID: <043e51316f5acf9004d11ecb77a5485d3fe41494.camel@gmail.com>
Subject: Re: [PATCH v3 2/3] Staging: iio: adt7316: Move interrupt related
 code
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 08 Dec 2018 22:14:13 +0530
In-Reply-To: <20181208161207.47ee755c@archlinux>
References: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
         <20181208151638.8759-3-shreeya.patel23498@gmail.com>
         <20181208161207.47ee755c@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-12-08 at 16:12 +0000, Jonathan Cameron wrote:
> On Sat,  8 Dec 2018 20:46:37 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > There is a function adt7316_irq_setup() where irq_type is being
> > set. It would be good to move devm_request_threaded_irq() function
> > and assignment of chip->config1 in adt7316_irq_setup() to unclutter
> > the code in probe function.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> 
> As commented below, this didn't end up as tidy as it might have been.
> It would I think have been simpler before patch 1 or just merged with
> it.
> 
As I was introducing a new function named "adt7316_setup_irq" so I
thought patch 1 should come first because we are setting up the
irq_type there.
But yes, this made the code complex to review.

I didn't merge both patches because both the patches were having
different changes. If I would have done that then there was a
possibility where someone would have said to split the patches.

> Anyhow, I might combine the two whilst applying. However before I do
> that I'd like to leave this on list for a few days to let Alex
> or others have time for another look before I apply it.
> 

It's ok, I'll merge both patches and send as a v4 to you. I'll send it
after 3-4 days so we can get other reviews by that time if there are
any to come.

My vacation has started so I'll work faster now.

> All heading in the right direction!
> 
> Thanks,
> 
> Jonathan
> 
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 34 ++++++++++++++-----------
> > ----
> >  1 file changed, 17 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c
> > b/drivers/staging/iio/addac/adt7316.c
> > index 86b2c3d53588..97dd48153293 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -1807,11 +1807,12 @@ static irqreturn_t
> > adt7316_event_handler(int irq, void *private)
> >  	return IRQ_HANDLED;
> >  }
> >  
> > -static int adt7316_setup_irq(struct device *dev, int irq)
> > +static int adt7316_setup_irq(struct iio_dev *indio_dev)
> 
> Hmm. This has ended up a lot more complex than ideal due
> to the effective two layers of rework.  
> 
> I would either have done patches 1 and 2 as one patch or
> reordered them so the rework preceded the change
> to DT.  It's not that important but it would have lead
> to code that was easier to review.
> 
> 
> >  {
> > -	int irq_type;
> > +	struct adt7316_chip_info *chip = iio_priv(indio_dev);
> > +	int irq_type, ret;
> >  
> > -	irq_type = irqd_get_trigger_type(irq_get_irq_data(irq));
> > +	irq_type = irqd_get_trigger_type(irq_get_irq_data(chip-
> > >bus.irq));
> >  
> >  	switch (irq_type) {
> >  	case IRQF_TRIGGER_HIGH:
> > @@ -1821,13 +1822,23 @@ static int adt7316_setup_irq(struct device
> > *dev, int irq)
> >  	case IRQF_TRIGGER_FALLING:
> >  		break;
> >  	default:
> > -		dev_info(dev, "mode %d unsupported, using
> > IRQF_TRIGGER_LOW\n",
> > +		dev_info(&indio_dev->dev, "mode %d unsupported,
> > using IRQF_TRIGGER_LOW\n",
> >  			 irq_type);
> >  		irq_type = IRQF_TRIGGER_LOW;
> >  		break;
> >  	}
> >  
> > -	return irq_type;
> > +	ret = devm_request_threaded_irq(&indio_dev->dev, chip-
> > >bus.irq,
> > +					NULL,
> > adt7316_event_handler,
> > +					irq_type | IRQF_ONESHOT,
> > +					indio_dev->name,
> > indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (irq_type & IRQF_TRIGGER_HIGH)
> > +		chip->config1 |= ADT7316_INT_POLARITY;
> > +
> > +	return ret;
> >  }
> >  
> >  /*
> > @@ -2124,7 +2135,6 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  {
> >  	struct adt7316_chip_info *chip;
> >  	struct iio_dev *indio_dev;
> > -	int irq_type;
> >  	int ret = 0;
> >  
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
> > @@ -2168,19 +2178,9 @@ int adt7316_probe(struct device *dev, struct
> > adt7316_bus *bus,
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	if (chip->bus.irq > 0) {
> > -		irq_type = adt7316_setup_irq(dev, chip->bus.irq);
> > -
> > -		ret = devm_request_threaded_irq(dev, chip-
> > >bus.irq,
> > -						NULL,
> > -						adt7316_event_hand
> > ler,
> > -						irq_type |
> > IRQF_ONESHOT,
> > -						indio_dev->name,
> > -						indio_dev);
> > +		ret = adt7316_setup_irq(indio_dev);
> >  		if (ret)
> >  			return ret;
> > -
> > -		if (irq_type & IRQF_TRIGGER_HIGH)
> > -			chip->config1 |= ADT7316_INT_POLARITY;
> >  	}
> >  
> >  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1,
> > chip->config1);
> 
> 
