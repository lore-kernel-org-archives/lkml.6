Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B93AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E2F20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJnGgK0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfBAPGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:06:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40276 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbfBAPGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:06:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so7429084wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Uck1CEnzK4yAX/eBZ/UfjzE1zapwdwFDE1PzGvoHrro=;
        b=fJnGgK0MUA4uJGwX9rzrPzFw89eDlk+noU08PAWZOanadYTDpUwnHkZJIqb6C/xuPq
         +XQ2OKVK8UAsEHE2+uJC5LrEYg4ZkNqFuHJNkorF0nt1XoaKbmzthCUoTSMtLZE7OhNv
         Dvx8eEFWsdMRmZj7UDlrp76+bAViKWAkQNOxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Uck1CEnzK4yAX/eBZ/UfjzE1zapwdwFDE1PzGvoHrro=;
        b=ni+aHYj9vMGepPc8zwrNK7UpVmDjcB1Wiy+EOny33Jjp+4GaivAmsz/S2bBawSDjlr
         eoFRwq1kvvdW+1ZUI2OduMVawDlE1JKMSqIf35qoTB87tXpQuT7MmbWiZBOPF168lfCl
         FO9dpKcmZiNv4c376jUXwZzV6AhLpcG4wafHa+fGqObFbRpsyK/nXP4uwlU+zRF4yKA7
         nSSt96t9wXKVe4k1fPCLw+EEfd1TfyvyRtu3JTYbR28AMLY64VbP3yUFrufHLBLhb3sV
         QpkTHSYlN3z6Ta9qmn2AyKaVd5E0B8xI4XLrJhAxrMSVrXrr/xGzwnxzQpmMS13SxgzB
         n/cg==
X-Gm-Message-State: AHQUAublBeRnMbX6JLKpf2AwfJidcdMqybpDnxYRfdXgiFDz3n7ATqIV
        9rTskKeR+IIUXCaVLT0Z5ESZyoOdDAU=
X-Google-Smtp-Source: AHgI3IZ62+t6+9JLdcP38RE+zKAMrUkX0I1hGZHSmcBNWLxchhnJoHhf6FE4Po+nX71Y9WX/4N51cQ==
X-Received: by 2002:a5d:46d2:: with SMTP id g18mr1784731wrs.6.1549033559337;
        Fri, 01 Feb 2019 07:05:59 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id h2sm8378972wrv.87.2019.02.01.07.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 07:05:58 -0800 (PST)
Date:   Fri, 1 Feb 2019 15:05:49 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v4] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190201150549.GA4973@dell>
References: <20190129204224.17951-1-andrew@lunn.ch>
 <20190201141540.GI783@dell>
 <20190201144410.GG30908@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201144410.GG30908@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Feb 2019, Andrew Lunn wrote:

> > > +config MFD_TQMX86
> > > +       tristate "TQ-Systems IO controller TQMX86"
> > > +       select MFD_CORE
> > > +       help
> > > +	  Say yes here to enable support for various functions of the
> > > +	  TQ-Systems IO controller and watchdog device, found on their
> > > +	  ComExpress CPU modules.
> 
> Hi Lee
>  
> > The help should be indented by two spaces.
> 
> It is. If you look carefully, there is "<TAB>  ".  Maybe what you
> actually want is the <TAB> replaced by spaces?

As I see what you've done.

You have used 8 spaces instead of tabs for the text above.

The help is correct, the bit above it is not.

> > > +/**
> > > + * struct tqmx86_device_data - Internal representation of the PLD device
> > 
> > This is wrong.
> 
> Could you be a bit more specific please. 

tqmx86_device_data != tqmx86_device_ddata

> > > + * @io_base:		Pointer to the IO memory
> > > + * @pld_clock_rate:	PLD clock frequency
> > > + * @dev:		Pointer to kernel device structure
> > 
> > > + * @i2c_type:		Hard of soft I2C hardware macro
> > > + */
> > > +struct tqmx86_device_ddata {
> > 
> > > +	void __iomem	*io_base;
> > > +	u32		pld_clock_rate;
> > > +	u32		i2c_type;
> > > +};
> > > +
> > > +/**
> > > + * struct tqmx86_platform_data - PLD hardware configuration structure
> > > + * @ioresource:		IO addresses of the PLD
> > > + */
> > > +struct tqmx86_platform_ddata {
> > 
> > ddata (device data) and pdata (platform data) are different.
> > 
> > For platform data, it should be "*_platform_data" or "*_pdata".
> 
> It would of been useful if you had said this in the first review,
> rather than s/data/ddata/, which is rather ambiguous.

How is that ambiguous?  I guess it would be confusing if you didn't
know the syntax, in which case you should have asked.

s/this/that/ simply means, replace 'this' with 'that'.

> > 
> > > +	struct resource	*ioresource;
> > > +};
> > > +
> > > +static uint gpio_irq;
> > > +module_param(gpio_irq, uint, 0);
> > > +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");
> > 
> > What is the purpose of providing the IRQ number via a module param?
> > 
> > These seems like a very bad idea.
> 
> I explained this in my reply to your review comments for version 2.
> 
> > Can this driver be built-in?
> 
> Yes it can. But you can pass module parameters on the command line, so
> that is not an issue. This is something i actually use.

What is connected to these IRQs?

> > > +static const u8 i2c_irq_ctl[] = {
> > > +	[7] = 1,
> > > +	[9] = 2,
> > > +	[12] = 3
> > > +};
> > 
> > Rather than wasting memory, you could do:
> > 
> > static const u8 i2c_irq_ctl[] = { 7, 9, 12 };
> > 
> > You'll then have to loop over it once to get the index.
> > 
> > It also does not need to be global.
> 
> It is not global. It has the static keyword. Or are you meaning
> something else?

It's a globally available struct.  You can put it into .probe().

> > > +static const struct tq_board_info {
> > > +	u8 board_id;
> > > +	char *name;
> > > +	u32 pld_clock_rate;
> > > +} tq_board_info[] = {
> > > +	{ 0, "", 0 },
> > > +	{ 1, "TQMxE38M", 33000 },
> > > +	{ 2, "TQMx50UC", 24000 },
> > > +	{ 3, "TQMxE38C", 33000 },
> > > +	{ 4, "TQMx60EB", 24000 },
> > > +	{ 5, "TQMxE39M", 25000 },
> > > +	{ 6, "TQMxE39C", 25000 },
> > > +	{ 7, "TQMxE39x", 25000 },
> > > +	{ 8, "TQMx70EB", 24000 },
> > > +	{ 9, "TQMx80UC", 24000 },
> > > +	{10, "TQMx90UC", 24000 }
> > > +};
> 
> > There is not much point having a numbered struct attribute which
> > directly matches the index.  See below for a better use of this -
> > saves some CPU cycles too.
> 
> You comment for v2 was, what happens if the next board_id is 0xFC.  So

That was very forward thinking of me. :)

> i changed the code to allow for this. Are you now saying you have
> changed your mind, 0xFC cannot be the next board ID, there is no need
> to have the numbers?

Okay, I just took a peek.  Looks like you misunderstood what I said.

Create a look-up function containing a switch() statement instead.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
