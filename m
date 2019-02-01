Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD385C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C91B218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qlgUDb24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfBAOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:44:13 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:35692 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfBAOoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6VyM516IVQrSVfCV9Qz9YyOIfA+qUD0/lqXLE9v6jlw=; b=qlgUDb24FSNuhHCgg7hQmVXlMx
        DBNvMNiVZIJ0so4gvdHj4T/bpYQqrXZitw19VpD6W5mQt+P4VNcMoZBANVk9KSadaIxXyr+6ajQ19
        uhtD/Bo+S82QAInJoKgOPxQBuKeX7OzOevDIoli9+VKmd4RBePjDRVP76tnW3nXmi+3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gpa38-0000Bw-KK; Fri, 01 Feb 2019 15:44:10 +0100
Date:   Fri, 1 Feb 2019 15:44:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v4] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190201144410.GG30908@lunn.ch>
References: <20190129204224.17951-1-andrew@lunn.ch>
 <20190201141540.GI783@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201141540.GI783@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +config MFD_TQMX86
> > +       tristate "TQ-Systems IO controller TQMX86"
> > +       select MFD_CORE
> > +       help
> > +	  Say yes here to enable support for various functions of the
> > +	  TQ-Systems IO controller and watchdog device, found on their
> > +	  ComExpress CPU modules.

Hi Lee
 
> The help should be indented by two spaces.

It is. If you look carefully, there is "<TAB>  ".  Maybe what you
actually want is the <TAB> replaced by spaces?

> > +/**
> > + * struct tqmx86_device_data - Internal representation of the PLD device
> 
> This is wrong.

Could you be a bit more specific please. 

> > + * @io_base:		Pointer to the IO memory
> > + * @pld_clock_rate:	PLD clock frequency
> > + * @dev:		Pointer to kernel device structure
> 
> > + * @i2c_type:		Hard of soft I2C hardware macro
> > + */
> > +struct tqmx86_device_ddata {
> 
> > +	void __iomem	*io_base;
> > +	u32		pld_clock_rate;
> > +	u32		i2c_type;
> > +};
> > +
> > +/**
> > + * struct tqmx86_platform_data - PLD hardware configuration structure
> > + * @ioresource:		IO addresses of the PLD
> > + */
> > +struct tqmx86_platform_ddata {
> 
> ddata (device data) and pdata (platform data) are different.
> 
> For platform data, it should be "*_platform_data" or "*_pdata".

It would of been useful if you had said this in the first review,
rather than s/data/ddata/, which is rather ambiguous.

> 
> > +	struct resource	*ioresource;
> > +};
> > +
> > +static uint gpio_irq;
> > +module_param(gpio_irq, uint, 0);
> > +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
> 
> What is the purpose of providing the IRQ number via a module param?
> 
> These seems like a very bad idea.

I explained this in my reply to your review comments for version 2.

> Can this driver be built-in?

Yes it can. But you can pass module parameters on the command line, so
that is not an issue. This is something i actually use.

> 
> > +static const u8 i2c_irq_ctl[] = {
> > +	[7] = 1,
> > +	[9] = 2,
> > +	[12] = 3
> > +};
> 
> Rather than wasting memory, you could do:
> 
> static const u8 i2c_irq_ctl[] = { 7, 9, 12 };
> 
> You'll then have to loop over it once to get the index.
> 
> It also does not need to be global.

It is not global. It has the static keyword. Or are you meaning
something else?

> > +static const struct tq_board_info {
> > +	u8 board_id;
> > +	char *name;
> > +	u32 pld_clock_rate;
> > +} tq_board_info[] = {
> > +	{ 0, "", 0 },
> > +	{ 1, "TQMxE38M", 33000 },
> > +	{ 2, "TQMx50UC", 24000 },
> > +	{ 3, "TQMxE38C", 33000 },
> > +	{ 4, "TQMx60EB", 24000 },
> > +	{ 5, "TQMxE39M", 25000 },
> > +	{ 6, "TQMxE39C", 25000 },
> > +	{ 7, "TQMxE39x", 25000 },
> > +	{ 8, "TQMx70EB", 24000 },
> > +	{ 9, "TQMx80UC", 24000 },
> > +	{10, "TQMx90UC", 24000 }
> > +};

> There is not much point having a numbered struct attribute which
> directly matches the index.  See below for a better use of this -
> saves some CPU cycles too.

You comment for v2 was, what happens if the next board_id is 0xFC.  So
i changed the code to allow for this. Are you now saying you have
changed your mind, 0xFC cannot be the next board ID, there is no need
to have the numbers?

   Andrew
