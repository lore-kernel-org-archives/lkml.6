Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C70C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9268B21924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfBHHb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:31:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35489 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBHHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:31:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id l142so1834702lfe.2;
        Thu, 07 Feb 2019 23:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dCI+cWk2Vz+eKiqVnf1uxFpRbcciilTSy0eGn3j0LVE=;
        b=gg3EyyzULMrMyymGYcH5nTh1nsWN+b9xeKAr0iN+z7MFVo0lTV2KWwshB13i6u/Ehf
         O3ElezGf0K9F3GBtByj0yM8tx1O1br49lQ6fTnLxN26b/SLopKbI//uLDPDtmJdKtPrl
         5qTStOsvVDOtE153/oTH6+VX4mfB5Kl1nrM2lZUxLqhH22qjM8ij3WMqd0f01mLWrwoe
         cDeyKazHiw4UoqrAcPlRPrRj6tcljVrEnXIeYehlQ6oXGBoqj16YvqdTKtnUXU0b8Vxy
         CTj85d+P+DovtSXQenOAUrgGZt9VMaV99t1jLFCGDSaRg8yLUKkhy2WU5keqGjMPybag
         ggZw==
X-Gm-Message-State: AHQUAub7ovGJl6ssyQ6CwdEMlW6KCKmVNaviE0dn5mCdbo2cSPh1hYmZ
        3SOHWLdcUtFIlRomxxR88jo=
X-Google-Smtp-Source: AHgI3Ib9Xrp/fUdBHZ5qP9ajB9IMkRByAEkGIBxWOWe8f2n5EczcvNWlKUe67m88xOoWjNTBtHjEKQ==
X-Received: by 2002:a19:59c2:: with SMTP id n185mr12345194lfb.118.1549611083044;
        Thu, 07 Feb 2019 23:31:23 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id d5sm210200lfi.65.2019.02.07.23.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 23:31:22 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:30:42 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v8 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Message-ID: <20190208073042.GA3012@localhost.localdomain>
References: <cover.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <50d1debf03bbd07f49b2c5a85cf9672439cbd0ac.1549523718.git.matti.vaittinen@fi.rohmeurope.com>
 <20190207140053.GG20638@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207140053.GG20638@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again Lee,

After a good night sleep few things came to my mind =)

On Thu, Feb 07, 2019 at 02:00:53PM +0000, Lee Jones wrote:
> On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> 
> > +
> > +static struct mfd_cell bd70528_mfd_cells[] = {
> > +	{ .name = "bd70528-pmic", },
> > +	{ .name = "bd70528-gpio", },
> > +	/*
> > +	 * We use BD71837 driver to drive the clk block. Only differences to
> > +	 * BD70528 clock gate are the register address and mask.
> > +	 */
> > +	{ .name = "bd718xx-clk", },
> > +	{ .name = "bd70528-wdt", },
> > +	{
> > +		.name = "bd70528-power",
> > +		.resources = &charger_irqs[0],
> > +		.num_resources = ARRAY_SIZE(charger_irqs),
> > +	},
> > +	{
> 
> These should be on the same line.

I know I said 'Ok' yesterday. And I can change the styling to what ever
suits you - but I am not entirely sure what you mean by this? Do you
mean that the brackets should be on same line? After a quick look to
few other MFD devices it seems to be common convention to have these on
separate lines - and such style is used also at other locations
throughout this file. 

> > +static const struct regmap_access_table volatile_regs = {
> > +	.yes_ranges = &volatile_ranges[0],
> > +	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
> > +};
> > +
> > +static struct regmap_config bd70528_regmap = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.volatile_table = &volatile_regs,
> > +	.max_register = BD70528_MAX_REGISTER,
> > +	.cache_type = REGCACHE_RBTREE,
> > +};
> 
> '\n' here.
> 
> > +/* bit [0] - Shutdown register */
> > +unsigned int bit0_offsets[] = {0};
> > +/* bit [1] - Power failure register */
> > +unsigned int bit1_offsets[] = {1};
> > +/* bit [2] - VR FAULT register */
> > +unsigned int bit2_offsets[] = {2};
> > +/* bit [3] - PMU register interrupts */
> > +unsigned int bit3_offsets[] = {3};
> > +/* bit [4] - Charger 1 and Charger 2 registers */
> > +unsigned int bit4_offsets[] = {4, 5};
> > +/* bit [5] - RTC register */
> > +unsigned int bit5_offsets[] = {6};
> > +/* bit [6] - GPIO register */
> > +unsigned int bit6_offsets[] = {7};
> > +/* bit [7] - Invalid operation register */
> > +unsigned int bit7_offsets[] = {8};
> 
> What on earth is this?

Would this comment help:
/*
 * Mapping of main IRQ register bits to sub irq register offsets so
 * that we can access corect sub IRQ registers based on bits that
 * are set in main IRQ register.
 */

/* bit [0] - Shutdown register */
unsigned int bit0_offsets[] = {0};
/* bit [1] - Power failure register */
unsigned int bit1_offsets[] = {1};
/* bit [2] - VR FAULT register */
unsigned int bit2_offsets[] = {2};
/* bit [3] - PMU register interrupts */
unsigned int bit3_offsets[] = {3};
/* bit [4] - Charger 1 and Charger 2 registers */
unsigned int bit4_offsets[] = {4, 5};
/* bit [5] - RTC register */
unsigned int bit5_offsets[] = {6};
/* bit [6] - GPIO register */
unsigned int bit6_offsets[] = {7};
/* bit [7] - Invalid operation register */
unsigned int bit7_offsets[] = {8};

> > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
> > +{
[..]
> > +}
> 
> Shouldn't this be one in the WDT driver?

Maybe I should explain it like this:

/*
 * Both the WDT and RTC drivers need to be able to control WDT. WDT uses
 * RTC for timeouts and setting the RTC may trigger watchdog. Thus the
 * RTC must disable the WDT when RTC time is set. We provide WDT disabling
 * code from the MFD parent as we don't want to make direct dependency
 * between RTC and WDT. Some may want to use only WDT or only RTC.
 */

#define WD_CTRL_MAGIC1 0x55
#define WD_CTRL_MAGIC2 0xAA

static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
{

> > +	/*
> > +	 * Disallow type setting for all IRQs by default as
> > +	 *  most of them do not support setting type.
> > +	 */
> > +	for (i = 0; i < ARRAY_SIZE(irqs); i++)
> > +		irqs[i].type.types_supported = 0;
> > +
> > +	irqs[BD70528_INT_GPIO0].type.type_reg_offset = 0;
> > +	irqs[BD70528_INT_GPIO0].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO0].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO0].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO0].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO0].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO1].type.type_reg_offset = 2;
> > +	irqs[BD70528_INT_GPIO1].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO1].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO1].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO1].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO1].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO2].type.type_reg_offset = 4;
> > +	irqs[BD70528_INT_GPIO2].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO2].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO2].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO2].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO2].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> > +	irqs[BD70528_INT_GPIO3].type.type_reg_offset = 6;
> > +	irqs[BD70528_INT_GPIO3].type.type_rising_val = 0x20;
> > +	irqs[BD70528_INT_GPIO3].type.type_falling_val = 0x10;
> > +	irqs[BD70528_INT_GPIO3].type.type_level_high_val = 0x40;
> > +	irqs[BD70528_INT_GPIO3].type.type_level_low_val = 0x50;
> > +	irqs[BD70528_INT_GPIO3].type.types_supported = (IRQ_TYPE_EDGE_BOTH |
> > +				IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
> 
> Could you please explain:
> 
> a) what you're doing here
> b) why you don't mass assign them
>     - seeing as most of the data is identical.

I am not sure this is what you meant by mass assignment? Something like
below?

I think this makes the code slightly more confusing yet much shorter.
What would you say? Is this what you had in mind?

        /*
         * Set IRQ typesetting information for GPIO pins 0 - 3
         */
        for (i = 0; i < 4; i++) {
                struct regmap_irq_type *type;

                type = &irqs[BD70528_INT_GPIO0 + i].type;
                type->type_reg_offset = 2 * i;
                type-<type_rising_val = 0x20;
                type->type_falling_val = 0x10;
                type->type_level_high_val = 0x40;
                type->type_level_low_val = 0x50;
                type->types_supported = (IRQ_TYPE_EDGE_BOTH |
                                IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW);
        }

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
