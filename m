Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F25C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F1120874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beKm2o94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbeLQVcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:32:04 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41983 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388057AbeLQVbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:31:08 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so11153512ioc.8;
        Mon, 17 Dec 2018 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKxcgbmVgrnYzOEvNC+E0VaiE1aK1XC9JnB0F71H8a8=;
        b=beKm2o94nusHOf6fuMk/dauO0FrlUl7LM/3Drezp3v1GQhUZH5f4n9A9JZKPhqd3qc
         /XNps1Bu6IEMf5blDX3ugwz/vFqQeTYvTZgV/BaJ8xCoKXMy8vaMrcgccVH5lNtTg/gp
         DnvXE9gXhjfH9f7lQOXRGEVqH1/nP8zKuVM2bNLbSX3eToXX/sXk7lU8yho3p6FxtQbq
         Xn7/UL1rx+6mtBkvsxa3hrM4dIdpq5N10pyDlX8dD1oAh3hdooxw44Cv/rZjsw+aqKDS
         a85MyEDGXmK57zKwBkxhn+7ns0IRnJS14U+27BkZWRreHJ8mZPP2lLeh97qqSARBv7kR
         nvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKxcgbmVgrnYzOEvNC+E0VaiE1aK1XC9JnB0F71H8a8=;
        b=cVgbFA1Le4EuZ8x9ed5U0HxqnJ/pDyIg6N4CgROC6VMfjC8i6DMzsYLOP59SDKxuXv
         fZbge8weX0sggCwIBFoy03RMffNyug5NN3sWg0kgBF38q7qr40WY0Vn50LXuRjwaf5Ms
         YSehapbp4wkV6iy7XhvYZgaHsILf1ZldoYm+AMuxn8WuDU2Bw9Grs31rJ4B4ctVZnJcs
         JDQoi3IHRTS7BnaP1VBfeIPu4SsAYrcWm+Uf/Vpa4eAlR8NINfEwmtkt/AOxFbKiYt9z
         bqQBFRprV8A5ScKfldMK/OPTOFyz1r3sxofQiZUxRDfwd/pv6l4w775yWA1RK5y4FzWI
         TLNw==
X-Gm-Message-State: AA+aEWYGETsFqKnHMvQSGPUqPRGcqFaSw6DB2XGsS4IrDVuhXKa2RwDw
        cKos65LNu7f5FllzlA5+GHxW7nzzPKUP9w==
X-Google-Smtp-Source: AFSGD/UZdGT5gkouOL6y7vpIq/HvUXFiYe+4BEwGGz8TgkXyNI5BHxU1OKUHuarTBLuq4xnaj5OCtQ==
X-Received: by 2002:a5e:8c12:: with SMTP id n18mr11551649ioj.231.1545082266686;
        Mon, 17 Dec 2018 13:31:06 -0800 (PST)
Received: from r2700x.localdomain (c-75-70-96-103.hsd1.co.comcast.net. [75.70.96.103])
        by smtp.gmail.com with ESMTPSA id c102sm213008itd.38.2018.12.17.13.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:31:06 -0800 (PST)
Date:   Mon, 17 Dec 2018 14:30:59 -0700
From:   Jeremy Fertic <jeremyfertic@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] staging: iio: adt7316: fix dac_bits assignment
Message-ID: <20181217213059.GA11856@r2700x.localdomain>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
 <20181212005503.28054-4-jeremyfertic@gmail.com>
 <20181216113756.70d76d0a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216113756.70d76d0a@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 11:37:56AM +0000, Jonathan Cameron wrote:
> On Tue, 11 Dec 2018 17:54:55 -0700
> Jeremy Fertic <jeremyfertic@gmail.com> wrote:
> 
> > The only assignment to dac_bits is in adt7316_store_da_high_resolution().
> > This function enables or disables 10 bit dac resolution for the adt7316/7
> > and adt7516/7 when they're set to output voltage proportional to
> > temperature. Remove these assignments since they're unnecessary for the
> > dac high resolution functionality.
> > 
> > Instead, assign a value to dac_bits in adt7316_probe() since the number
> > of dac bits might be needed as soon as the device is registered and
> > available to userspace.
> > 
> > Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
> 
> I'm a little confused as it seems to me that in the orignal code
> if we were setting high resolution 'off' we would fall back to 8
> bits for either type of device.  Now you just have a check on the
> device type?
> 
> The result will be that we read more bytes than we want to
> in show_DAC.
> 
> I'd need a pretty strong argument to persuade me it is worth
> supporting the 8 bit mode at all btw on devices that will go
> higher.  It adds interface complexity and the number of usecases
> where the saving in bus traffic is worthwhile are probably fairly
> few!
> 
> Jonathan

Thanks for the feedback Jonathan, and sorry for the confusion on this one.
My commit message should have been clearer. This is not a general purpose
option to change the dac resolution. It is specific to an optional feature
where one or two of the four dacs can be set to output voltage proportional
to temperature. If the user chooses to set dac a and/or dac b to ouput
voltage proportional to temperature, this da_high_resolution attribute can
optionally be enabled to use 10 bit resolution rather than the default 8
bits. It is only available on the 10 and 12 bit dac devices. If the user
attempts to read or write dacs a or b under these settings, the driver's
current behaviour is to return an error. The dacs c and d continue to
operate normally under these conditions.

With the above in mind, dac_bits should have never been assigned to in this
da_high_resolution attribute. Before this patch, if the user didn't write
to this optional attribute, dac_bits would be 0 since it was never assigned
to anywhere else. This would result in incorrect calculations in show_DAC
and store_DAC.

Jeremy

> > ---
> >  drivers/staging/iio/addac/adt7316.c | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > index e5e1f9d6357f..a9990e7f2a4d 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -651,17 +651,10 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
> >  	u8 config3;
> >  	int ret;
> >  
> > -	chip->dac_bits = 8;
> > -
> > -	if (buf[0] == '1') {
> > +	if (buf[0] == '1')
> >  		config3 = chip->config3 | ADT7316_DA_HIGH_RESOLUTION;
> > -		if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> > -			chip->dac_bits = 12;
> > -		else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> > -			chip->dac_bits = 10;
> > -	} else {
> > +	else
> >  		config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> > -	}
> >  
> >  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> >  	if (ret)
> > @@ -2123,6 +2116,13 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
> >  	else
> >  		return -ENODEV;
> >  
> > +	if (chip->id == ID_ADT7316 || chip->id == ID_ADT7516)
> > +		chip->dac_bits = 12;
> > +	else if (chip->id == ID_ADT7317 || chip->id == ID_ADT7517)
> > +		chip->dac_bits = 10;
> > +	else
> > +		chip->dac_bits = 8;
> > +
> >  	chip->ldac_pin = devm_gpiod_get_optional(dev, "adi,ldac", GPIOD_OUT_LOW);
> >  	if (IS_ERR(chip->ldac_pin)) {
> >  		ret = PTR_ERR(chip->ldac_pin);
> 
