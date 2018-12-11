Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB54C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F102081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F102081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeLKIog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:44:36 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37377 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeLKIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:44:36 -0500
Received: by mail-lf1-f67.google.com with SMTP id p17so10156796lfh.4;
        Tue, 11 Dec 2018 00:44:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9aoHIlzJBAsRGcXdrMzix/A415O73g+h6bWF0KyZVw=;
        b=V9dlf1khf5bMh2y2ETBPwaNYj4dHlPDUpxyj+y5Ky1ZDdtFPIJ/j3B7Y4loNlWqnU4
         C1i/qLgeh1Zo1o6WMLMXwCYz43wfUWqvF2q6A2TOehTo6lHOce5BihnRBzVlQhQYXx3B
         zLqinXbC7du/2ufuNAYP1a21OODGYmLuYWR80IikKX2HaLT8gjBvqbOj3ARzNhotWtgv
         Wda9VOEfg5eOWqyQok3tMN5FZlzsJpPvzB6A8jU6Frc5EAEPREno8UaWILiIy+suPJI9
         Zf2vPUczx0RIP6hpVcRDkAVTvskZSN/1JYuBSvBpLK38YcJ9NG40JAdzdjcka+H1SX8q
         Lgug==
X-Gm-Message-State: AA+aEWbFmA1l7NAUrGgZdqn0AD1SyczhwiuOQjxfjY4Md254+g1SC8/+
        M2y6o/f9whGr+7grLQ0JoEY=
X-Google-Smtp-Source: AFSGD/VSyK2S6YvXxvBlBORS3MYIFrk+FC8BJdVh0pNSdFtReJBnZToSZK9e2EGQslIEyZb807FtMQ==
X-Received: by 2002:a19:3b9c:: with SMTP id d28mr9311050lfl.30.1544517873477;
        Tue, 11 Dec 2018 00:44:33 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o72sm2551004lfg.33.2018.12.11.00.44.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:44:32 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:44:30 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc:     mazziesaccount@gmail.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH] regmap: regmap-irq/gpio-max77620: add level-irq support
Message-ID: <20181211084430.GC32557@localhost.localdomain>
References: <20181210081437.GA32228@localhost.localdomain>
 <e378d050-01b4-9a6c-1c17-1f1ca04dd16e@mentor.com>
 <20181211063825.GA32557@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211063825.GA32557@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again All,

Sorry for multiple posts but I had second look at this and...

On Tue, Dec 11, 2018 at 08:38:25AM +0200, Matti Vaittinen wrote:
> Hello Vladimir,
> 
> Thanks for the review.
> 
> On Mon, Dec 10, 2018 at 05:16:28PM +0200, Vladimir Zapolskiy wrote:
> > On 12/10/2018 10:14 AM, Matti Vaittinen wrote:
> > > Add level active IRQ support to regmap-irq irqchip. Change breaks
> > > existing regmap-irq type setting. Convert the existing drivers which
> > > use regmap-irq with trigger type setting (gpio-max77620) to work
> > > with this new approach. So we do not magically support level-active
> > > IRQs on gpio-max77620 - but add support to the regmap-irq for chips
> > > which support them =)
> > > 
> > > We do not support distinguishing situation where HW supports rising
> > > and falling edge detection but not both. Separating this would require
> > > inventing yet another flags for IRQ types.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > > I did both the regmap-irq and max77620 changes in same commit because
> > > I'd rather not cause spot where max77620 breaks. Besides the changes in
> > > max77620 driver are trivial. Please let me know if this is not Ok.
> > > 
> > > Reason why I submit this patch now - even though my driver which would
> > > use level active type setting with regmap-irq is not yet ready for
> > > being submited - is that I'd like to minimize amount of existing drivers
> > > we need to patch. And if we add level active irq support like this then
> > > we must patch all existing drivers using type setting with regmap-irq.
> > > So doing this now when only max77620 uses type setting may be easier
> > > than postponing this to the future.
> > > 
> > > And finally - I don't have max77620 so I have only done _wery_ limited
> > > testing. So I would really appreciate if someone had time to review this
> > > thoroughly - and even happier if someone had possibility to try this out
> > > with the max77620.
> > > 
> > 
> > [snip]
> > 
> > > diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> > > index a367d59c301d..91c431ad98c3 100644
> > > --- a/include/linux/regmap.h
> > > +++ b/include/linux/regmap.h
> > > @@ -1098,6 +1098,9 @@ int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
> > >   * @type_reg_offset: Offset register for the irq type setting.
> > >   * @type_rising_mask: Mask bit to configure RISING type irq.
> > >   * @type_falling_mask: Mask bit to configure FALLING type irq.
> > > + * @type_level_low_mask: Mask bit to configure LEVEL_LOW type irq.
> > > + * @type_level_high_mask: Mask bit to configure LEVEL_HIGH type irq.
> > > + * @types_supported: logical OR of IRQ_TYPE_* flags indicating supported types.
> > 
> > While the existing interface is awful, you don't make it better.
> > 
> > .types_supported value is always derived from non-zero .type_*_mask values, so
> > it is simply not needed, as well as the whole change to gpio-max77620.c driver.
> 
> Right. I didn't consider the "type_inverted" flag in the struct
> regmap_irq_chip. I thought that "mask" is actually a register value -
> which could be zero for some HWs. Thanks for pointing that out. It will
> really make "types_supported" useless.

After second check - type_inverted won't help if we have case where
both the 'all bits set' and 'all bits zeroed' are valid type specifiers.
We *could* have HW register specified as:

IRQ Trigger control reg:

bits [7:2] reserved - don't touch, undocumented magic debug stuff
bits [1:0] IRQ trigger type:
  00 => Rising Edge
  01 => Falling Edge
  10 => Level Low
  11 => Level High.

For such setup we would have:

type_rising_mask = 0x0,
type_falling_mask = 0x1,
type_level_low_mask = 0x2,
type_level_high_mask = 0x3,

- and I see no way of tellng the type_rising_mask is valid.

I admit this is actually not pretty. We don't really give *mask* here
but we give the actual configuration value - and actually, for example
transitioning from falling to low would make HW to wrongly go to
type_level_high - if the values here were really regarded as *masks*.

But when we look at the implementation, we are treating these masks as
actual values - so code does the correct thing and zeroes the whole
'type area':

        d->type_buf[reg] &= ~(irq_data->type_falling_mask |
                              irq_data->type_rising_mask |
                              irq_data->type_level_low_mask |
                              irq_data->type_level_high_mask);

before applying the desired mask (value):

        switch (type) {
        case IRQ_TYPE_EDGE_FALLING:
                d->type_buf[reg] |= irq_data->type_falling_mask;
                break;
	...

So I would still go by adding the types_supported field to advertice
also those types which are set using value '0'. I would additionally
consider renaming the type_*_mask to type_*_val. What's your take on
this?

> 
> So please just drop this patch for now. There seems to be no need to
> touch the existing regmap-irq users after all so I can submit this patch
> together with the driver which needs to support the level active IRQs.
> 

So, it seems we still need to patch the gpio-max77620.c, right? So I
guess I could try submitting the next version prior the rest of the
driver.

> > 
> > >   */
> > >  struct regmap_irq {
> > >  	unsigned int reg_offset;
> > > @@ -1105,6 +1108,9 @@ struct regmap_irq {
> > >  	unsigned int type_reg_offset;
> > >  	unsigned int type_rising_mask;
> > >  	unsigned int type_falling_mask;
> > > +	unsigned int type_level_low_mask;
> > > +	unsigned int type_level_high_mask;
> > > +	unsigned int types_supported;
> > >  };
> > >  
> > >  #define REGMAP_IRQ_REG(_irq, _off, _mask)		\

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
