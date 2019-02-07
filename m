Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71A7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9980C2173B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBGQ3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:29:15 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45175 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:29:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so306962lfa.12;
        Thu, 07 Feb 2019 08:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qx3AGTnnj4AbPki+3njx7zxT24fwmWJP9xeEJmKJnNQ=;
        b=uIlhO/cR4sNmzGIxDIRvKgfs/Zl/Jmcbr7zO0qfiWjXUdbm6RDdP2J6rkY66IxWX8B
         ohcScbu9uielCHunvQD2KjFyk2Q5bHaPAV54qKh/hMGGkPhuctKys5bT5iurG33Jkoge
         pePtSiD1hO7itc9XV0JW89UAtod8BgLEaYt2v2/lmiHcbfgcp9xkynf1psmhMtNEh1AF
         L7mAcpApbnm+XJ2UFy/cicDNw5836dy626P2MgjDe2Fih6h07DoYn3FOjdieWDZ+jnGl
         uLl2YEDNkvHerUFtLDsIwDwFDVhkJ9U8lgn1IBwwaSMaVib97ErH/Zw+sHkVlRkVFHHW
         t4JQ==
X-Gm-Message-State: AHQUAuYouFbv479AiI65YdfQfIf8RnV3alaI0+WsBEGOHFU/N6XWnXrP
        t6R3V1DPzg4j2iWLnI3Uzzw=
X-Google-Smtp-Source: AHgI3IajozZRdB6WPJUEj+Oxsht+susGHDTZhQqwNWHmMhxnZNElY25ndvEEostWHIfmYFdTCod6vw==
X-Received: by 2002:ac2:5382:: with SMTP id g2mr10307425lfh.159.1549556949990;
        Thu, 07 Feb 2019 08:29:09 -0800 (PST)
Received: from localhost.localdomain (82-203-157-3.bb.dnainternet.fi. [82.203.157.3])
        by smtp.gmail.com with ESMTPSA id s27-v6sm421344ljd.64.2019.02.07.08.29.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:29:09 -0800 (PST)
Date:   Thu, 7 Feb 2019 18:28:35 +0200
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
Message-ID: <20190207162807.GB1920@localhost.localdomain>
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

Hello Lee,

Thanks for taking a look at this.

On Thu, Feb 07, 2019 at 02:00:53PM +0000, Lee Jones wrote:
> On Thu, 07 Feb 2019, Matti Vaittinen wrote:
> > +// Copyright (C) 2018 ROHM Semiconductors
> 
> This needs updating.

Ok

> > +#define BD70528_INT_RES(_reg, _name)		\
> > +	{					\
> > +		.start = (_reg),		\
> > +		.end = (_reg),			\
> > +		.name = (_name),		\
> > +		.flags = IORESOURCE_IRQ,	\
> > +	}
> 
> I think you're looking for DEFINE_RES_IRQ_NAMED()

Thanks! I didn't know of that macro. I'd switch to it.

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
> 
> Why not just, 'charger_irqs'?

Old "bad" habit :) I'll change this.

> > +		.num_resources = ARRAY_SIZE(charger_irqs),
> 
> > +	},
> > +	{
> 
> These should be on the same line.

Ok.

> > +		.name = "bd70528-rtc",
> > +		.resources = &rtc_irqs[0],
> 
> As above.

Right. Same bad habit. I'll fix this.

> > +	/*
> > +	 * bd70528 contains also few other registers which require
> 
> "BD70528"

Ok, I'll fix all these occurrances.
> 
> I don't think this means what you think it does.
> 
> I think you want to say "also contains a few".
> 
> > +	 * magic sequence to be written in order to update the value.
> 
> "sequences"

And thanks for grammar checks! I am not native english speaker so this
is really helpful. I'll fix these.

> > +static struct regmap_config bd70528_regmap = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.volatile_table = &volatile_regs,
> > +	.max_register = BD70528_MAX_REGISTER,
> > +	.cache_type = REGCACHE_RBTREE,
> > +};
> 
> '\n' here.

Ok.

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

That's the mapping from main IRQ register bits to sub IRQ registers. The
RFC version 1 had the patch which brough main irq register support. But
good that you asked as I missed the fact that this commit is now only at
the regmap tree - and this one depends on that.
 
> > +static struct regmap_irq_sub_irq_map bd70528_sub_irq_offsets[] = {
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit0_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit1_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit2_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit3_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit4_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit5_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit6_offsets),
> > +	REGMAP_IRQ_MAIN_REG_OFFSET(bit7_offsets),
> > +};
> 
> This looks totally hairy.  What is it mean to look like?

Yes. Sorry. As explained above - this requires commit from regmap tree:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/include/linux/regmap.h?h=for-next&id=66fb181d6f824f7695417e8c19560c5b57dc8c2d

> > +static int bd70528_wdt_set(struct bd70528 *bd70528, int enable, int *old_state)
> > +{

[snip]

> > +}
> 
> Shouldn't this be one in the WDT driver?

This is needed by both RTC and WDT drivers as RTC driver must stop the
WDT when it sets RTC. WDT HW is using RTC counter and might trigger
timeout/reset when RTC is set. Options are to dublicate the
enable/disable to both drivers or to export a function or share a
function pointer. I didn't want dublication or dependency between RTC
and WDT drivers. Thus I thought that MFD is best place for this code as
both RTC and WDT require it anyways. Perhaps this should be commented
here?
 
> > +	if (!i2c->irq) {
> > +		dev_err(&i2c->dev, "No IRQ configured\n");
> > +		return -EINVAL;
> > +	}
> 
> '\n' here.

Ok.
 
> > +	bd70528 = devm_kzalloc(&i2c->dev, sizeof(*bd70528), GFP_KERNEL);
> > +
> 
> Remove this line.

Ok.

> > +	if (!bd70528)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&bd70528->rtc_timer_lock);
> 
> Shouldn't this in the RTC driver?

As menioned abowe, the WDT is also using the lock. Thus it is
initialized here. Perhaps a comment would help?

> > +	dev_set_drvdata(&i2c->dev, bd70528);

Ok.

> > +	bd70528->chip.chip_type = ROHM_CHIP_TYPE_BD70528;
> > +	bd70528->wdt_set = bd70528_wdt_set;
> 
> Why?

Because WDT and RTC both need this function. Again a place for comment?

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

Regmap-irq gained support for type-setting. On bd70528 the type setting
makes sense only for GPIO interrupts - so we must not populate type
setting information for the rest of the IRQs. The macro REGMAP_IRQ_REG
is nice and makes the irq struct initialization cleaner. Thus it is used.
It does not allow populating the type information - hence we do it here.

I can change this if you think some other way would be cleaner?

> b) why you don't mass assign them
>     - seeing as most of the data is identical.

Maybe I am a bit slow today - but I don't know how the 'mass assignment'
should be done?

> > +	ret = devm_regmap_add_irq_chip(&i2c->dev, bd70528->chip.regmap,
> > +				       i2c->irq, IRQF_ONESHOT, 0,
> > +				       &bd70528_irq_chip, &irq_data);
> > +	if (ret) {
> > +		dev_err(&i2c->dev, "Failed to add irq_chip\n");
> > +		return ret;
> > +	}
> 
> '\n' here.

Ok

> > +	dev_dbg(&i2c->dev, "Registered %d irqs for chip\n",
> > +			bd70528_irq_chip.num_irqs);
> 
> Is this really required/useful?

Well, probably not anymore =) I'll remove this.

> > +	/*
> > +	 * BD70528 irq controller is not touching the main mask register.
> 
> "IRQ"
> 
> > +	 * So enable the GPIO block interrupts at main level. We can just
> > +	 * leave them enabled as irq-controller should disable irqs
> 
> "the IRQ controller"
> "IRQs"

Ok, thanks!

> > +static const struct of_device_id bd70528_of_match[] = {
> > +	{
> > +		.compatible = "rohm,bd70528",
> > +	},
> 
> This can be placed on a single line.

True.

> > +static int __init bd70528_init(void)
> > +{
> > +	return i2c_add_driver(&bd70528_drv);
> > +}
> > +subsys_initcall(bd70528_init);
> 
> Does it need to be initialised this early?

I think it may be required on some board(s). Is it a problem? I guess I
can change this for my purposes but guess it may become a problem later.

> > +struct bd70528 {
> > +	/*
> > +	 * Please keep this as the first member here as some
> > +	 * drivers (clk) supporting more than one chip may only know this
> > +	 * generic struct 'struct rohm_regmap_dev' and assume it is
> > +	 * the first chunk of parent device's private data.
> > +	 */
> > +	struct rohm_regmap_dev chip;
> > +	/* wdt_set must be called rtc_timer_lock held */
> 
> This doesn't make sense.

Umm.. The comment does not make sense? Maybe I can explain it further.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
