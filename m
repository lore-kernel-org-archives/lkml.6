Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FF4C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660202175F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 16:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+nhcVJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660202175F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbeHRUFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 16:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeHRUFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 16:05:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669CA21570;
        Sat, 18 Aug 2018 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534611422;
        bh=aWjC4YDYDrpEOOEvR4Hx14xL52IP2epJl4bC3y/KIpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G+nhcVJgeB6g6sK2fVlr8K5NWoXo1dDgrq8CCyMo46gUon0kC4D+cZj5Aqk0vUZYV
         7gqezw4qG68Vi7Df7+fFvee4c7T0IcuYKtSUsoKqEGmiF+vUimx74eGVgypIoGoJTf
         PoECsLYxWcL6hBUM+EY9dYbwUZHfxjcYiE16z8Rk=
Date:   Sat, 18 Aug 2018 17:56:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
Message-ID: <20180818175657.2c09d987@archlinux>
In-Reply-To: <20180804065506.GB1727@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
        <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
        <20180803230922.22d628fc@archlinux>
        <20180804065506.GB1727@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Aug 2018 08:55:06 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Andy and Jonathan,
> 
> 
> On Fri, Aug 03, 2018 at 11:09:22PM +0100, Jonathan Cameron wrote:
> > On Thu, 2 Aug 2018 22:52:00 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >   
> > > On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
> > > <marcus.folkesson@gmail.com> wrote:  
> > > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > > >
> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>    
> > >   
> > > > Signed-off-by: Kent Gustavsson <kent@minoris.se>    
> > > 
> > > What is this? Why it's here (presense and location in the message)?  
> > To clarify... If Kent wrote the patch and you are simply acting
> > as gatekeeper / upstreamer you should set the mail to be from Kent
> > and put your own Signed-off after his to basically act as a submaintainer
> > certifying you believe his sign off and all that entails.
> > 
> > If it is a bit of a joint effort then that's fine but for copyright
> > purposes there should be some indication of the split.  
> 
> First, thank you Andy for noticing.
> 
> I actually intended to use Co-Developed-by (a pretty new tag)
> in combination with Signed-off-by.
> But the tag must have disappeared in some preparation stage..
> 
> From Documentation/process/submitting-patches.rst ::
> 
> 	A Co-Developed-by: states that the patch was also created by another developer
> 	along with the original author.  This is useful at times when multiple people
> 	work on a single patch.  Note, this person also needs to have a Signed-off-by:
> 	line in the patch as well.
> 
> I will switch order and add the Co-Developed-by-tag.
> Is this correct?
> 
> Co-Developed-by: Kent Gustavsson <kent@minoris.se>   
> Signed-off-by: Kent Gustavsson <kent@minoris.se>  
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>  
> 
> > 
> >   
> > >   
> > > > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>    
> > >   
> > > > + *    
> > > 
> > > Redundant.
> > >   
> > > > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 len)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       reg = MCP3911_REG_READ(reg, adc->dev_addr);
> > > > +       ret = spi_write_then_read(adc->spi, &reg, 1, val, len);
> > > > +       if (ret < 0)
> > > > +               return ret;
> > > > +
> > > > +       be32_to_cpus(val);
> > > > +       *val >>= ((4 - len) * 8);
> > > > +       dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", *val,
> > > > +                       reg>>1);
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > > > +{
> > > > +       dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", val, reg);
> > > > +
> > > > +       val <<= (3 - len) * 8;
> > > > +       cpu_to_be32s(&val);
> > > > +       val |= MCP3911_REG_WRITE(reg, adc->dev_addr);
> > > > +
> > > > +       return spi_write(adc->spi, &val, len + 1);
> > > > +}    
> > > 
> > > Can't you use REGMAP_SPI ?  
> > My instinct is not really. The magic device-addr doesn't help.
> > You could work around it but it's not that nice and you'd have
> > to create the regmap mapping on the fly or carry static ones
> > for each value of htat.
> > 
> > 
> >   
> > >   
> > > > +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> > > > +       if (adc->dev_addr > 3) {
> > > > +               dev_err(&adc->spi->dev,
> > > > +                               "invalid device address (%i). Must be in range 0-3.\n",
> > > > +                               adc->dev_addr);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +       dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_addr);    
> > > 
> > > Isn't what we called CS (chip select)?  
> > Nope. We went around this in an earlier revision. It's an address transmitted
> > in the control byte to allow you to 'share' a chip select line between multiple
> > chips (crazy but true).
> >   
> > >   
> > > > +       if (IS_ERR(adc->vref)) {    
> > >   
> > > > +    
> > > 
> > > Redundant.
> > >   
> > > > +       if (adc->clki)    
> > > 
> > > Seems to be redundant if clock is optional (it should be NULL and API
> > > is NULL-aware).
> > >   
> > > > +               clk_disable_unprepare(adc->clki);    
> > >   
> > > > +       if (adc->clki)
> > > > +               clk_disable_unprepare(adc->clki);    
> > > 
> > > Ditto.
> > >   
> > > > +#if defined(CONFIG_OF)    
> > > 
> > > This prevents playing with the device on ACPI enabled platforms.  
> 
> I will remove the defined(CONFIG_OF) and not use the of_match_ptr()
> macro. 
> 
> > Yeah, that trickery is still little known (and I forget about it from
> > time to time).
> > 
> > The upshot for those who have missed this is you can use a magic
> > acpi device to instantiate based on device tree bindings :)
> > 
> > So we need to strip all this 'obvious' protection stuff out of drivers.  
> 
> Jonathan,
> Do you want me to do the same changes for drivers in iio/ ?
> I'm probably not the only one looking at other drivers when writing my
> own, so I guess this is a rather frequent issue for new drivers?

A good question.   Hmm. I'm a bit in two minds.  It creates a lot
of churn for something that I don't think is actually very heavily
used.  As you say, the biggest reason to change it will be to stop
others from copying the existing drivers and getting it 'wrong' going
forward.

I don't have strong feelings either way, but don't really want to
see a huge number of patches around this (I haven't checked how
many drivers are effected).  If you want to look at this, then perhaps
do a small set at a time rather than a mass fixup to keep things
manageable?

Thanks,

Jonathan

> 
> 
> >   
> > >   
> > > > +               .of_match_table = of_match_ptr(mcp3911_dt_ids),    
> > > 
> > > Ditto for macro.
> > >   
> >   
> 
> Best regards,
> Marcus Folkesson

