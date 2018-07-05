Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60902C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA0C2413F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 10:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA0C2413F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753731AbeGEKez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 06:34:55 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38091 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbeGEKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 06:34:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so6290548ljc.5;
        Thu, 05 Jul 2018 03:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=RuSKpVzuhc9ZEfN/Ac1frtUJAW4cfZxesB3ieg2/ucQ=;
        b=Y91MjkoE5hVyTGTdKJV4o1Py8Dy27RxdNt+GYAwEVLdH57KXknZzBBROtDKJPBODcg
         0ub6cYCxsc+rYqkn4GZ/2m+CDYcSG/ANmTfaqCCP46rHNBFb3bhQba7VFV8lnPFN3W0q
         gaA+WQNekuSwPv/geai83bHR8nMBfIN7OL7AjRlAC3hGUuA0MI6MZcSX0hwQnY6M9rd7
         Ezl45tJHbnlUv/U4yWuJdK0IA05Q7sTqfneSRCEqRMVaPyNBMUsl9YRYu4u2Ftvq452M
         LzBDm4LH6f6dSt86vMtJTeEm/NRJcvoIrxamHT8AYJCxOQn9SdrJH0wt/+ymn0lcxfjm
         xeuw==
X-Gm-Message-State: APt69E1PdR6hsPhyCVXBJnFX416WiZdcTw/ys7bkUZdXt8ojXifSGDLa
        Lro1EXY/C9wIyyS4OrRKG4Y=
X-Google-Smtp-Source: AAOMgpfCx8FJe9wQATlZfjUFP5xCYQVJczY+S8MEejhiZxloVKFTL3xSRyUmQFb24HnU+7vVAckszA==
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr3538454ljf.36.1530786890885;
        Thu, 05 Jul 2018 03:34:50 -0700 (PDT)
Received: from localhost.localdomain (82-203-190-162.bb.dnainternet.fi. [82.203.190.162])
        by smtp.gmail.com with ESMTPSA id 1-v6sm897974ljd.11.2018.07.05.03.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 03:34:50 -0700 (PDT)
Date:   Thu, 5 Jul 2018 13:34:42 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        arnd@arndb.de, dmitry.torokhov@gmail.com, sre@kernel.org,
        chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org, eballetbo@gmail.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v9 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180705103442.GA8426@localhost.localdomain>
References: <cover.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <a304164cc3c1b31c7c6b62f8e233ce321a82cdd6.1530776326.git.matti.vaittinen@fi.rohmeurope.com>
 <20180705091813.GK496@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180705091813.GK496@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking the time to check this =)

On Thu, Jul 05, 2018 at 10:18:13AM +0100, Lee Jones wrote:
> On Thu, 05 Jul 2018, Matti Vaittinen wrote:
> 
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1787,6 +1787,19 @@ config MFD_STW481X
> >  	  in various ST Microelectronics and ST-Ericsson embedded
> >  	  Nomadik series.
> >  
> > +config MFD_BD71837
> 
> It's be nice if you prefix this with the manufacturer.  Rohm?

Like MFD_ROHM_BD71837, right? How important this is? The already applied
regulator part has depends_on for MFD_BD71837 in Kconfig so changing
this will require change in regulator tree too. I guess it's doable if
this is important though =)
> 
> > +	tristate "BD71837 Power Management chip"
> 
> Again, missing manufacturer.
> 
> This should also be "Power Management IC"

I'll fix this

> > +	select MFD_CORE
> > +	help
> > +	  Select this option to get support for the ROHM BD71837
> > +	  Power Management chips. BD71837 is designed to power processors like
> 
> "chips" is slang.  Should be "ICs".

I'll fix this
 
> > +obj-$(CONFIG_MFD_BD71837)	+= bd71837.o
> >  
> > diff --git a/drivers/mfd/bd71837.c b/drivers/mfd/bd71837.c
> 
> rohm-bd71837.c would be nicer.

I'll fix this

> > new file mode 100644
> > index 000000000000..677097bcea17
> > --- /dev/null
> > +++ b/drivers/mfd/bd71837.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> '\n' here please.
> > +// Copyright (C) 2018 ROHM Semiconductors
> 
> '\n' here please.

As an empty line after licence line? Ok.

> > +// bd71837.c -- ROHM BD71837MWV mfd driver
> 
> Remove the filename -- they have a habit of becoming incorrect.
> 
> Also, and 'MFD driver' isn't a thing -- this is a PMIC driver. 

I'll fix this

> > +// Datasheet available from
> > +// https://www.rohm.com/datasheet/BD71837MWV/bd71837mwv-e
> > +
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/bd71837.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +#include <linux/gpio_keys.h>
> 
> Alphabetical please.
> 

There is a problem with gpio_key.h - it uses bool but does not include
the header defining this type. So I get comple error when compiling this
using my GCC arm cross-compiler. I've submitted a patch to fix this but
as it is not yet accepted.
https://lore.kernel.org/lkml/20180627073458.GA27800@localhost.localdomain/
 Hence the gpio_keys.h is last one.

> > +static struct gpio_keys_button btns[] = {
> > +	{
> > +		.code = KEY_POWER,
> > +		.gpio = -1,
> > +		.type = EV_KEY,
> > +	},
> > +};
> 
> Does this need to be an array?

https://elixir.bootlin.com/linux/v4.17-rc1/source/include/linux/gpio_keys.h#L39
gpio_keys_platform_data documentation states the buttons to be a pointer
to an array. Thus I did an array. Do you think I should change this to
single struct?

> > +static struct gpio_keys_platform_data bd718xx_powerkey_data = {
> > +	.buttons = &btns[0],
> 
> Why not just "btns"?
> 
> Also, I don't see any reason not to just call this 'buttons'.
> 
> Or even, 'button' if there will only ever be one of them.
> 

I can rename this - and if I make the array to not be an array - well,
then the &foo[0] gets cleared too =)

> > +static struct mfd_cell bd71837_mfd_cells[] = {
> > +	{
> > +		.name = "bd71837-clk",
> > +	}, {
> > +		.name = "gpio-keys",
> > +		.platform_data = &bd718xx_powerkey_data,
> > +		.pdata_size = sizeof(bd718xx_powerkey_data),
> > +	}, {
> > +		.name = "bd71837-pmic",
> > +	},
> > +};
> 
> Place the one line entries on one line, like this:
> 
> 	{ .name = "bd71837-pmic", },
> 
> ... and if ordering is not important, place them at the bottom.

I'll fix this

> > +static int bd71837_i2c_probe(struct i2c_client *i2c,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct bd71837 *bd71837;
> > +	struct bd71837_board *board_info;
> > +	int ret = -EINVAL;
> 
> I'd prefer it if you set the error at the location it happened for
> readability.

I'll fix this

> > +	bd71837 = devm_kzalloc(&i2c->dev, sizeof(struct bd71837), GFP_KERNEL);
> > +
> 
> Drop this line.

I'll fix this

> > +	ret = bd71837_reg_read(bd71837, BD71837_REG_REV);
> > +	if (ret < 0) {
> 
> Is 0 return a successful read?  I suggest that it isn't.
> 
> > +	ret = devm_regmap_add_irq_chip(&i2c->dev, bd71837->regmap,
> > +				       bd71837->chip_irq, IRQF_ONESHOT, 0,
> > +				       &bd71837_irq_chip, &bd71837->irq_data);
> > +	if (ret < 0) {
> 
> Is a >0 return valid?  If not, perhaps "if (ret)" would be better.
> 
> > +	ret = regmap_update_bits(bd71837->regmap,
> > +				 BD71837_REG_PWRONCONFIG0,
> > +				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
> > +				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
> > +	if (ret < 0) {
> 
> As above.
> 

I will check these. Thanks.

> > +
> > +	/*
> > +	 * According to BD71847 datasheet the HW default for long press
> > +	 * detection is 10ms. So lets change it to 10 sec so we can actually
> > +	 * get the short push and allow gracefull shut down
> > +	 */
> 
> I don't think this comment is necessary.
> 
> If anything it only needs to say "Configure long press to 10 seconds".
> 
> And if you do that, please add one for short press too.
Difference between short and long push is that if PMIC detects log push
it will kill the power without any gracefull handling. And the chip I am
supporting right now is BD71837 - which has more sane default value (10
seconds). But I am going to add support for BD71847 - which was shipped
to me yesterday - and according the draft data-sheet the default on it
is 10ms - which makes short push unusable. So comment is intended to
point out _why_ I configure the long push here. Also someone might want
to use the HW default (I guess such default was selected for some
specific reason) so comment helps on removing this configuration for
specific use-cases. But I guess I can reduce the comment to "Configure
long press to 10 seconds" as you suggested - or do you think I should
make difference between ICs BD71837 and BD71847 more visible here?
> 
> > +	ret = regmap_update_bits(bd71837->regmap,
> > +				 BD71837_REG_PWRONCONFIG1,
> > +				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
> > +				 BD718XX_PWRBTN_LONG_PRESS_10S);
> > +
> > +	if (ret < 0) {
> > +		dev_err(&i2c->dev, "Failed to configure button long press timeout\n");
> > +		goto err_out;
> > +	}
> > +
> > +	btns[0].irq = regmap_irq_get_virq(bd71837->irq_data,
> > +					  BD71837_INT_PWRBTN_S);
> > +
> > +	if (btns[0].irq < 0) {
> > +		ret = btns[0].irq;
> > +		dev_err(&i2c->dev, "Failed to get the IRQ\n");
> > +		goto err_out;
> 
> No unwinding to be done, just return directly and save yourself an
> superflouous goto.

So should I replace _all_ the gotos by in-place returns as Enric suggested
yesterday? As I explained yesterday, my preference is to have only one
point of exit but I can change gotos to returns if needed.

> > +static const struct i2c_device_id bd71837_i2c_id[] = {
> > +	{ .name = "bd71837", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, bd71837_i2c_id);
> 
> You shouldn't need this table anymore.
> 
> See da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed devices")

So if I read this correctly the 
> > +		.of_match_table = bd71837_of_match,
is now sufficient. Thanks.

> > +static struct i2c_driver bd71837_i2c_driver = {
> > +	.driver = {
> > +		.name = "bd71837-mfd",
> 
> And "MFD" isn't really a thing.  It's more common to just mention the
> board name, or something like 'rohm-bd7183'.

I'll fix this

> > +/*
> > + * init early so consumer devices can complete system boot
> > + */
> 
> This is a single line commit.  Please use the correct format.
> 
>   /* Single line comment */

I'll fix this. I misinterpreted your comment yesterday.

> > +MODULE_DESCRIPTION("BD71837 chip multi-function driver");
> 
> 'PMIC' or 'Power Management IC' rather than MFD.

I'll fix this

> > +MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/bd71837.h b/include/linux/mfd/bd71837.h
> > new file mode 100644
> > index 000000000000..10b0dfe90f27
> > --- /dev/null
> > +++ b/include/linux/mfd/bd71837.h
> > @@ -0,0 +1,391 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> 
> I thought these were meant to use C++ (//) comments?

The checkpatch.pl did complain if I used // comment on SPDX line for
header file. OTOH for c-file it required // comments and complained
about /* */ - version. So I did as it suggested and used 

> > +/* Copyright (C) 2018 ROHM Semiconductors */
> > +
> > +/*
> > + * ROHM BD71837MWV header file
> > + */
> 
> If you prefix the mentions of (BD,bd)71837 with (ROHM,rohm) then this
> comment becomes redundant and you can remove it.

I am sorry but I am not sure what you suggest here. Do you mean I should
add ROHM or rohm to all definitions here? I think that would make
definitions pretty long so I would certinly need to split more lines.
Such cange would also impact already applied patches. So maybe I
misinterpreted your comment? And in case I did not - can this prefixing of
types - be done as a separate patch set as it impacts to regulators and
clk too? (clk is not yet applied so that is easy to change though).

> > +/* Even though the bit zero is not SWRESET type we still want to write zero
> > + * to it when changing type. Bit zero is 'SWRESET' trigger bit and if we
> > + * write 1 to it we will trigger the action. So always write 0 to it when
> > + * changning SWRESET action - no matter what we read from it.
> > + */
> 
> Please use the correct format for multi-line comments.
> 
> Hint: The first line should be empty.

I'll fix this

> > +#define BD71837_SWRESET_TYPE_MASK 7
> > +#define BD71837_SWRESET_TYPE_DISABLED 0
> > +#define BD71837_SWRESET_TYPE_COLD 4
> > +#define BD71837_SWRESET_TYPE_WARM 6
> > +
> > +#define BD71837_SWRESET_RESET_MASK 1
> > +#define BD71837_SWRESET_RESET 1
> > +
> > +/* Poweroff state transition conditions */
> > +
> > +#define BD718XX_ON_REQ_POWEROFF_MASK 1
> > +#define BD718XX_SWRESET_POWEROFF_MASK 2
> > +#define BD718XX_WDOG_POWEROFF_MASK 4
> > +#define BD718XX_KEY_L_POWEROFF_MASK 8
> > +
> > +#define BD718XX_POWOFF_TO_SNVS 0
> > +#define BD718XX_POWOFF_TO_RDY 0xF
> 
> Please align each of the values with tabs.

I'll fix this

> > +#define BD718XX_PWR_TRIG_KEY_L 1
> > +#define BD718XX_PWR_TRIG_KEY_S 2
> > +#define BD718XX_PWR_TRIG_PMIC_ON 4
> > +#define BD718XX_PWR_TRIG_VSYS_UVLO 8
> > +#define BD718XX_RDY_TO_SNVS_SIFT 0
> > +#define BD718XX_SNVS_TO_RUN_SIFT 4
> 
> As above.

I'll fix this

> > +
> > +
> 
> No need for 2 '\n'.

I'll fix this

> > +	BD718XX_PWRBTN_LONG_PRESS_15S
> > +};
> > +
> > +
> > +
> 
> Certainly no need for 3 '\n'.

I'll fix this

> > +struct bd71837;
> 
> Why is this necessary?
> 

I think it's not. I'll remove it.

> > +struct bd71837_pmic;
> > +struct bd71837_clk;
> > +struct bd718xx_pwrkey;
> 
> Where are these forward declared from?

bd71837_pmic is in drivers/regulator/bd71837-regulator.c
clk will be in clk subdevice patch that is not yet applied.
It is pending some fixes. Pwrkey must be dropped as the power-key driver
I originally wrote was replaced using gpio_keys instead. Should there be
some comment explaining this? Suggestions on how to do this without
referring to file names which are subject to change... Should I just say
they are defined in subdevice drivers? 

> > +/*
> > + * Board platform data may be used to initialize regulators.
> > + */
> > +
> > +struct bd71837_board {
> > +	struct regulator_init_data *init_data[BD71837_REGULATOR_CNT];
> > +	int	gpio_intr;
> > +};
> 
> Where is this populated?
> 
Currently nowhere as I use device-tree for getting the regulator/irq
config. This is for architectures which do not use DT - but as I don't
have one for testing I did leave the depends_on OF. If it was populated
I would expect it to be done in some setup code.

> > +/*
> > + * bd71837 sub-driver chip access routines
> > + */
> > +
> 
> Please don't abstract APIs for no reason.
> 
> Use the regmap_* API directly instead.
> 

Yes. This was already pointed out by Stephen Boyd. But again, as part of
the patches (reguators) were already applied using the wrappers - I asked
if I can remove these in separate patch set after getting this initial
version out.

> > +#endif /* __LINUX_MFD_BD71837_H__ */
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
