Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 838A7C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229F4208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 10:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229F4208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jmondi.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965716AbeFOK7g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 06:59:36 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35573 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965590AbeFOK7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 06:59:34 -0400
X-Greylist: delayed 82474 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jun 2018 06:59:33 EDT
X-Originating-IP: 2.224.242.101
Received: from w540 (2-224-242-101.ip172.fastwebnet.it [2.224.242.101])
        (Authenticated sender: jacopo@jmondi.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 462F0C0012;
        Fri, 15 Jun 2018 10:59:31 +0000 (UTC)
Date:   Fri, 15 Jun 2018 12:59:26 +0200
From:   jacopo mondi <jacopo@jmondi.org>
To:     Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/5] pinctrl: renesas: Renesas R9A06G032 pinctrl driver
Message-ID: <20180615105926.GC12638@w540>
References: <1528974029-29617-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528974029-29617-4-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <1528974029-29617-4-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Michel,

On Thu, Jun 14, 2018 at 12:00:19PM +0100, Michel Pollet wrote:
> This provides a pinctrl driver for the Renesas R09A06G032.
>

As I wait for the comments on the proposed bindings to be discussed,
before reviewing the details of this driver, for now I'm just pointing out the
minor stuff that is easy fixable. This is mostly style related stuff
you would have found out by yourself using checkpatch probably.

> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> ---
>  drivers/pinctrl/Kconfig             |  10 +
>  drivers/pinctrl/Makefile            |   1 +
>  drivers/pinctrl/pinctrl-r9a06g032.c | 890 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 901 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-r9a06g032.c
>
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index dd50371..22d7546 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -177,6 +177,16 @@ config PINCTRL_OXNAS
>  	select GPIOLIB_IRQCHIP
>  	select MFD_SYSCON
>
> +config PINCTRL_R9A06G032
> +	bool "Renesas R9A06G032 pinctrl driver"
> +	depends on OF
> +	depends on ARCH_R9A06G032 || COMPILE_TEST
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select GENERIC_PINCONF
> +	help
> +	  This selects pinctrl driver for Renesas R9A06G032.
> +
>  config PINCTRL_ROCKCHIP
>  	bool
>  	select PINMUX
> diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
> index de40863..5912861 100644
> --- a/drivers/pinctrl/Makefile
> +++ b/drivers/pinctrl/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
>  obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
>  obj-$(CONFIG_PINCTRL_PIC32)	+= pinctrl-pic32.o
>  obj-$(CONFIG_PINCTRL_PISTACHIO)	+= pinctrl-pistachio.o
> +obj-$(CONFIG_PINCTRL_R9A06G032)	+= pinctrl-r9a06g032.o
>  obj-$(CONFIG_PINCTRL_ROCKCHIP)	+= pinctrl-rockchip.o
>  obj-$(CONFIG_PINCTRL_RZA1)	+= pinctrl-rza1.o
>  obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
> diff --git a/drivers/pinctrl/pinctrl-r9a06g032.c b/drivers/pinctrl/pinctrl-r9a06g032.c
> new file mode 100644
> index 0000000..a71dd24
> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-r9a06g032.c
> @@ -0,0 +1,890 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2014-2018 Renesas Electronics Europe Limited
> + *
> + * Michel Pollet <michel.pollet@bp.renesas.com>, <buserror@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

The purpose of SPDX header is to replace the boilerplate license text.
Please drop it.

> + */
> +
> +#include <dt-bindings/pinctrl/r9a06g032-pinctrl.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/module.h>

Please sort alphabetically.

> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include "core.h"
> +
> +/*
> + * The pinmux hardware has two levels. The first level functions goes from
> + * 0 to 9, and the level 1 mode '15' (0xf) specifies that the second level
> + * of pinmux should be used instead, that level has a lot more options,
> + * and goes from 0 to ~60.
> + *
> + * For linux, we've compounded both numbers together, so 0 to 9 is level 1,
> + * and anything higher is in fact 10 + level 2 number, so we end up with one
> + * value from 0 to 70 or so.
> + *
> + * There are 170 configurable pins (called PL_GPIO in the datasheet).
> + *
> + * Furthermore, the two MDIO outputs also have a mux each, that can be set
> + * to 8 different values (including highz as well).
> + *
> + * So, for Linux, we also made up to extra "GPIOs" 170 and 171, and also added
> + * extra functions to match their mux. This allow the device tree to be
> + * completely transparent to these subtleties.
> + */
> +
> +struct rzn1_pinctrl_regs {
> +	union {
> +		u32	conf[170];
> +		u8	pad0[0x400];
> +	};
> +	union {
> +		struct {
> +			u32	status_protect;	/* 0x400 */
> +			/* MDIO mux registers, l2 only */
> +			u32	l2_mdio[2];
> +		};
> +		u8	pad1[0x80];
> +	};
> +	u32	l2_gpio_int_mux[8];	/* 0x480 + (k*4) */
> +};
> +
> +
> +/**

If you want to use kernel-doc, which imho is not strictly necessary as
this is driver internal stuff, please make sure you have all the
necessary fields to have it compile nicely. In some places the structure or
function names are missing, or some parameters are not documented.

> + * struct rzn1_pmx_func - describes rzn1 pinmux functions
> + * @name: the name of this specific function
> + * @groups: corresponding pin groups
> + * @num_groups: the number of groups
> + */
> +struct rzn1_pmx_func {
> +	const char *name;
> +	const char **groups;
> +	unsigned int num_groups;
> +};
> +
> +/**
> + * struct rzn1_pin_group - describes an rzn1 pin group
> + * @name: the name of this specific pin group
> + * @npins: the number of pins in this group array, i.e. the number of
> + *	elements in .pins so we can iterate over that array
> + * @pin_ids: array of pin_ids. pinctrl forces us to maintain such an array
> + * @pins: array of pins
> + */
> +struct rzn1_pin_group {
> +	const char *name;
> +	const char *func;
> +	unsigned int npins;
> +	u32 *pin_ids;
> +	u32 *pins;
> +};
> +
> +/**

like here

> + * @dev: a pointer back to containing device
> + * @base: the offset to the controller in virtual memory
> + */
> +struct rzn1_pinctrl {
> +	struct device *dev;
> +	struct pinctrl_dev *pctl;
> +	struct rzn1_pinctrl_regs __iomem *lev1;
> +	struct rzn1_pinctrl_regs __iomem *lev2;
> +	u32 lev1_phys;
> +	u32 lev2_phys;
> +
> +	struct rzn1_pin_group *groups;
> +	unsigned int ngroups, maxgroups;
> +
> +	struct rzn1_pmx_func *functions;
> +	unsigned int nfunctions;
> +};
> +
> +#define RZN1_PINS_PROP "renesas,rzn1-pinmux-ids"
> +
> +#define RZN1_PIN(pin) PINCTRL_PIN(pin, "pl_gpio"#pin)
> +
> +static const struct pinctrl_pin_desc rzn1_pins[] = {
> +	RZN1_PIN(0), RZN1_PIN(1), RZN1_PIN(2), RZN1_PIN(3), RZN1_PIN(4),
> +	RZN1_PIN(5), RZN1_PIN(6), RZN1_PIN(7), RZN1_PIN(8), RZN1_PIN(9),
> +	RZN1_PIN(10), RZN1_PIN(11), RZN1_PIN(12), RZN1_PIN(13), RZN1_PIN(14),
> +	RZN1_PIN(15), RZN1_PIN(16), RZN1_PIN(17), RZN1_PIN(18), RZN1_PIN(19),
> +	RZN1_PIN(20), RZN1_PIN(21), RZN1_PIN(22), RZN1_PIN(23), RZN1_PIN(24),
> +	RZN1_PIN(25), RZN1_PIN(26), RZN1_PIN(27), RZN1_PIN(28), RZN1_PIN(29),
> +	RZN1_PIN(30), RZN1_PIN(31), RZN1_PIN(32), RZN1_PIN(33), RZN1_PIN(34),
> +	RZN1_PIN(35), RZN1_PIN(36), RZN1_PIN(37), RZN1_PIN(38), RZN1_PIN(39),
> +	RZN1_PIN(40), RZN1_PIN(41), RZN1_PIN(42), RZN1_PIN(43), RZN1_PIN(44),
> +	RZN1_PIN(45), RZN1_PIN(46), RZN1_PIN(47), RZN1_PIN(48), RZN1_PIN(49),
> +	RZN1_PIN(50), RZN1_PIN(51), RZN1_PIN(52), RZN1_PIN(53), RZN1_PIN(54),
> +	RZN1_PIN(55), RZN1_PIN(56), RZN1_PIN(57), RZN1_PIN(58), RZN1_PIN(59),
> +	RZN1_PIN(60), RZN1_PIN(61), RZN1_PIN(62), RZN1_PIN(63), RZN1_PIN(64),
> +	RZN1_PIN(65), RZN1_PIN(66), RZN1_PIN(67), RZN1_PIN(68), RZN1_PIN(69),
> +	RZN1_PIN(70), RZN1_PIN(71), RZN1_PIN(72), RZN1_PIN(73), RZN1_PIN(74),
> +	RZN1_PIN(75), RZN1_PIN(76), RZN1_PIN(77), RZN1_PIN(78), RZN1_PIN(79),
> +	RZN1_PIN(80), RZN1_PIN(81), RZN1_PIN(82), RZN1_PIN(83), RZN1_PIN(84),
> +	RZN1_PIN(85), RZN1_PIN(86), RZN1_PIN(87), RZN1_PIN(88), RZN1_PIN(89),
> +	RZN1_PIN(90), RZN1_PIN(91), RZN1_PIN(92), RZN1_PIN(93), RZN1_PIN(94),
> +	RZN1_PIN(95), RZN1_PIN(96), RZN1_PIN(97), RZN1_PIN(98), RZN1_PIN(99),
> +	RZN1_PIN(100), RZN1_PIN(101), RZN1_PIN(102), RZN1_PIN(103),
> +	RZN1_PIN(104), RZN1_PIN(105), RZN1_PIN(106), RZN1_PIN(107),
> +	RZN1_PIN(108), RZN1_PIN(109), RZN1_PIN(110), RZN1_PIN(111),
> +	RZN1_PIN(112), RZN1_PIN(113), RZN1_PIN(114), RZN1_PIN(115),
> +	RZN1_PIN(116), RZN1_PIN(117), RZN1_PIN(118), RZN1_PIN(119),
> +	RZN1_PIN(120), RZN1_PIN(121), RZN1_PIN(122), RZN1_PIN(123),
> +	RZN1_PIN(124), RZN1_PIN(125), RZN1_PIN(126), RZN1_PIN(127),
> +	RZN1_PIN(128), RZN1_PIN(129), RZN1_PIN(130), RZN1_PIN(131),
> +	RZN1_PIN(132), RZN1_PIN(133), RZN1_PIN(134), RZN1_PIN(135),
> +	RZN1_PIN(136), RZN1_PIN(137), RZN1_PIN(138), RZN1_PIN(139),
> +	RZN1_PIN(140), RZN1_PIN(141), RZN1_PIN(142), RZN1_PIN(143),
> +	RZN1_PIN(144), RZN1_PIN(145), RZN1_PIN(146), RZN1_PIN(147),
> +	RZN1_PIN(148), RZN1_PIN(149), RZN1_PIN(150), RZN1_PIN(151),
> +	RZN1_PIN(152), RZN1_PIN(153), RZN1_PIN(154), RZN1_PIN(155),
> +	RZN1_PIN(156), RZN1_PIN(157), RZN1_PIN(158), RZN1_PIN(159),
> +	RZN1_PIN(160), RZN1_PIN(161), RZN1_PIN(162), RZN1_PIN(163),
> +	RZN1_PIN(164), RZN1_PIN(165), RZN1_PIN(166), RZN1_PIN(167),
> +	RZN1_PIN(168), RZN1_PIN(169),
> +	PINCTRL_PIN(170, "mdio0"), PINCTRL_PIN(171, "mdio1")
> +};
> +
> +/* Bit number and bit values in the pinmux registers */
> +enum {
> +	RZN1_LEV_DRIVE_STRENGTH		= 10,
> +		RZN1_LEV_DRIVE_4MA		= 0,
> +		RZN1_LEV_DRIVE_6MA		= 1,
> +		RZN1_LEV_DRIVE_8MA		= 2,
> +		RZN1_LEV_DRIVE_12MA		= 3,
> +	RZN1_LEV_DRIVE_PULL		= 8,
> +		RZN1_LEV_DRIVE_PULL_NONE	= 0,
> +		RZN1_LEV_DRIVE_PULL_UP		= 1,
> +		RZN1_LEV_DRIVE_PULL_NONE2	= 2,
> +		RZN1_LEV_DRIVE_PULL_DOWN	= 3,
> +	RZN1_FUNCTION			= 0,
> +		RZN1_LEV_FUNCTION_MASK		= 0xf,
> +		RZN1_LEV_FUNCTION_LEV2		= 0xf,
> +		RZN1_LEV2_FUNCTION_MASK		= 0x3f,
> +	RZN1_WP_STATE			= 0,
> +};

Not sure an enum if the best choice for overlapping values. What about
using plain #define for them?

> +
> +enum {
> +	MDIO_MUX_HIGHZ = 0,
> +	MDIO_MUX_MAC0,
> +	MDIO_MUX_MAC1,
> +	MDIO_MUX_ECAT,
> +	MDIO_MUX_S3_MDIO0,
> +	MDIO_MUX_S3_MDIO1,
> +	MDIO_MUX_HWRTOS,
> +	MDIO_MUX_SWITCH,
> +};
> +
> +struct rzn1_pin_desc {
> +	u32	pin: 8, func: 7, has_func : 1, has_drive: 1,
> +		drive : 2, has_pull : 1, pull : 2;
> +};
> +
> +static struct rzn1_pinctrl *pinctrl;

Ouch a global pointer. I know it's hard to have two instances of this
driver registered on the same system, but you should retrieve the
driver private data from the pinctrl_dev driver_data. Ah, wait, you're
doing that, and you're using this global pointer in a single location,
is there any reason you need to do that?

> +
> +/*
> + * Breaks down the configuration word (as present in the DT) into
> + * a manageable structural description
> + */
> +static void rzn1_get_pin_desc_from_config(

I count three different styles you use to define functions in this
driver. Please be consistent and align below the first open brace, as
in

static struct verylongname *verylongfunctionname(struct param1,
                                                 struct param2,
                                                 struct param3)

When the function name does not span to the whole 80 cols.

For shorter function names, please span to the end of the line,

static void rzna1_get_pin_desc_from_config(struct rzn1_pinctrl *ipctl,
                                           u32 pin_config,
                                           struct rzn1_pin_desc *o)
{

}

also, ./scritps/checkpatch (--strict -f) is your friend.

> +	struct rzn1_pinctrl *ipctl,
> +	u32 pin_config,
> +	struct rzn1_pin_desc *o)
> +{
> +	struct rzn1_pin_desc p = {
> +		.pin = pin_config,
> +		.func = pin_config >> RZN1_MUX_FUNC_BIT,
> +		.has_func = pin_config >> RZN1_MUX_HAS_FUNC_BIT,
> +		.has_drive = pin_config >> RZN1_MUX_HAS_DRIVE_BIT,
> +		.drive = pin_config >> RZN1_MUX_DRIVE_BIT,
> +		.has_pull = pin_config >> RZN1_MUX_HAS_PULL_BIT,
> +		.pull = pin_config >> RZN1_MUX_PULL_BIT,
> +	};
> +
> +	if (o)
> +		*o = p;
> +}
> +
> +enum {
> +	LOCK_LEVEL1 = 0x1,
> +	LOCK_LEVEL2 = 0x2,
> +	LOCK_ALL = LOCK_LEVEL1 | LOCK_LEVEL2,
> +};
> +
> +static void rzn1_hw_set_lock(
> +	struct rzn1_pinctrl *ipctl,
> +	u8 lock,
> +	u8 value)
> +{
> +	if (lock & LOCK_LEVEL1) {
> +		u32 val = (ipctl->lev1_phys + 0x400) | !(value & LOCK_LEVEL1);
> +
> +		writel(val, &ipctl->lev1->status_protect);
> +	}
> +	if (lock & LOCK_LEVEL2) {
> +		u32 val = (ipctl->lev2_phys + 0x400) | !(value & LOCK_LEVEL2);
> +
> +		writel(val, &ipctl->lev2->status_protect);
> +	}
> +}
> +
> +static void rzn1_pinctrl_mdio_select(u8 mdio, u32 func)
> +{
> +	BUG_ON(!pinctrl || mdio > 1 || func > MDIO_MUX_SWITCH);
> +	dev_info(pinctrl->dev, "setting mdio %d to 0x%x\n", mdio, func);
> +
> +	rzn1_hw_set_lock(pinctrl, LOCK_LEVEL2, LOCK_LEVEL2);
> +	writel(func, &pinctrl->lev2->l2_mdio[mdio]);
> +	rzn1_hw_set_lock(pinctrl, LOCK_LEVEL2, 0);
> +}
> +
> +/*
> + * Using a composite pin description, set the hardware pinmux registers
> + * with the corresponding values.
> + * Make sure to unlock write protection and reset it afterward.
> + *
> + * NOTE: There is no protection for potential concurrency, it is assumed these
> + * calls are serialized already.
> + */
> +static int rzn1_set_hw_pin_parameters(
> +	struct rzn1_pinctrl *ipctl,
> +	u32 pin_config,
> +	u8 use_locks)
> +{
> +	struct rzn1_pin_desc p;
> +	u32 l1, l2, l1_cache, l2_cache;

Someone prefers one variable declaration per line. Also, try to order
variable declaration to respect the reverse xmas tree order.

> +
> +	rzn1_get_pin_desc_from_config(ipctl, pin_config, &p);
> +#if 0 /* bit noisy, even in debug mode */
> +	dev_dbg(ipctl->dev,
> +		"SET pin %3d:%08x func:%d/%d(0x%2x) drive:%d/%x pull:%d/%x\n",
> +		p.pin, pin_config,
> +		p.has_func, p.func, p.func - RZN1_FUNC_LEVEL2_OFFSET,
> +		p.has_drive, p.drive,
> +		p.has_pull, p.pull);
> +#endif

So use dev_info or remove it altogether, but no #if 0 if not strictly
necessary, and here it is not.

> +	if (p.pin >= RZN1_MDIO_BUS0 && p.pin <= RZN1_MDIO_BUS1) {
> +		if (p.has_func && p.func >= RZN1_FUNC_MDIO_MUX_HIGHZ &&
> +				p.func <= RZN1_FUNC_MDIO_MUX_SWITCH) {
> +			p.pin -= RZN1_MDIO_BUS0;
> +			p.func -= RZN1_FUNC_MDIO_MUX_HIGHZ;
> +			dev_dbg(ipctl->dev, "MDIO MUX[%d] set to %d\n",
> +				p.pin, p.func);
> +			rzn1_pinctrl_mdio_select(p.pin, p.func);
> +		} else {
> +			dev_warn(ipctl->dev, "MDIO[%d] Invalid configuration: %d\n",
> +				p.pin - RZN1_MDIO_BUS0, p.func);
> +			return -EINVAL;
> +		}
> +		return 0;
> +	}

Man, this code is -dense-. I know there is no strict coding style rule
for that, but I think a line break, eg here, would benefit
readability. That's up to you though.

> +	/* Note here, we do not allow anything past the MDIO Mux values */
> +	if (p.pin >= ARRAY_SIZE(ipctl->lev1->conf) ||
> +			p.func >= RZN1_FUNC_MDIO_MUX_HIGHZ)

Align to open brace please

> +		return -EINVAL;

Empty line here after return?

> +	l1 = readl(&ipctl->lev1->conf[p.pin]);
> +	l1_cache = l1;
> +	l2 = readl(&ipctl->lev2->conf[p.pin]);
> +	l2_cache = l2;
> +
> +	if (p.has_drive) {
> +		l1 &= ~(0x3 << RZN1_LEV_DRIVE_STRENGTH);
> +		l1 |= (p.drive << RZN1_LEV_DRIVE_STRENGTH);
> +	}
> +	if (p.has_pull) {
> +		l1 &= ~(0x3 << RZN1_LEV_DRIVE_PULL);
> +		l1 |= (p.pull << RZN1_LEV_DRIVE_PULL);
> +	}
> +	if (p.has_func) {
> +		if (p.func < RZN1_FUNC_LEVEL2_OFFSET) {
> +			l1 &= ~(RZN1_LEV_FUNCTION_MASK << RZN1_FUNCTION);
> +			l1 |= (p.func << RZN1_FUNCTION);
> +		} else {
> +			l1 &= ~(RZN1_LEV_FUNCTION_MASK << RZN1_FUNCTION);
> +			l1 |= (RZN1_LEV_FUNCTION_LEV2 << RZN1_FUNCTION);
> +
> +			l2 = p.func - RZN1_FUNC_LEVEL2_OFFSET;
> +		}
> +	}
> +	/* If either of the configuration change, we update both
> +	 * anyway.
> +	 */
> +	if (l1 != l1_cache || l2 != l2_cache) {
> +		rzn1_hw_set_lock(ipctl, use_locks, LOCK_ALL);
> +		writel(l1, &ipctl->lev1->conf[p.pin]);
> +		writel(l2, &ipctl->lev2->conf[p.pin]);
> +		rzn1_hw_set_lock(ipctl, use_locks, 0);
> +	}

Be consistent please. I suggest empty line before returning, as you're
doing in other functions.

> +	return 0;
> +}
> +
> +static const struct rzn1_pin_group *
> +rzn1_pinctrl_find_group_by_name(
> +	const struct rzn1_pinctrl *ipctl,
> +	const char *name)
> +{
> +	const struct rzn1_pin_group *grp = NULL;
> +	int i;
> +
> +	for (i = 0; i < ipctl->ngroups; i++) {
> +		if (!strcmp(ipctl->groups[i].name, name)) {
> +			grp = &ipctl->groups[i];
> +			break;
> +		}
> +	}
> +
> +	return grp;
> +}
> +
> +static int rzn1_get_groups_count(struct pinctrl_dev *pctldev)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return ipctl->ngroups;
> +}
> +
> +static const char *rzn1_get_group_name(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return ipctl->groups[selector].name;
> +}
> +
> +static int rzn1_get_group_pins(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector,
> +	const unsigned int **pins,
> +	unsigned int *npins)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	if (selector >= ipctl->ngroups)
> +		return -EINVAL;
> +
> +	*pins = ipctl->groups[selector].pins;
> +	*npins = ipctl->groups[selector].npins;
> +
> +	return 0;
> +}
> +
> +static void rzn1_pin_dbg_show(
> +	struct pinctrl_dev *pctldev,
> +	struct seq_file *s,
> +	unsigned int offset)
> +{
> +	seq_printf(s, "%s", dev_name(pctldev->dev));
> +}
> +
> +static int rzn1_dt_node_to_map(
> +	struct pinctrl_dev *pctldev,
> +	struct device_node *np,
> +	struct pinctrl_map **map,
> +	unsigned int *num_maps)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	const struct rzn1_pin_group *grp;
> +	struct pinctrl_map *new_map;
> +	struct device_node *parent;
> +	int map_num = 2;
> +
> +	/*
> +	 * first find the group of this node and check if we need create
> +	 * config maps for pins
> +	 */

I see different multi-line comment styles mixed in this driver. It's
either

/*
 * line1...
 * line2..
 */

Or

/* line1..
 * line2..
 */

Also, comments usually start with a capital letter and ends with full
stop...

> +	grp = rzn1_pinctrl_find_group_by_name(ipctl, np->name);
> +	if (!grp) {
> +		dev_err(ipctl->dev, "unable to find group for node %s\n",

use %pOF to printout device node names

> +			np->name);
> +		return -EINVAL;
> +	}
> +
> +	new_map = devm_kmalloc_array(ipctl->dev, map_num,
> +			sizeof(struct pinctrl_map), GFP_KERNEL);
> +	if (!new_map)
> +		return -ENOMEM;
> +
> +	*map = new_map;
> +	*num_maps = map_num;
> +
> +	/* create mux map */
> +	parent = of_get_parent(np);
> +	if (!parent)
> +		return -EINVAL;
> +
> +	new_map[0].type = PIN_MAP_TYPE_MUX_GROUP;
> +	new_map[0].data.mux.function = grp->func;
> +	new_map[0].data.mux.group = grp->name;
> +	of_node_put(parent);

What are you using parent for?

> +
> +	new_map[1].type = PIN_MAP_TYPE_CONFIGS_GROUP;
> +	new_map[1].data.configs.group_or_pin = grp->name;
> +	new_map[1].data.configs.configs = (unsigned long *)grp->pin_ids;
> +	new_map[1].data.configs.num_configs = grp->npins;
> +
> +	dev_dbg(pctldev->dev, "maps: function %s group %s (%d pins)\n",
> +		(*map)->data.mux.function, (*map)->data.mux.group,
> +		grp->npins);
> +
> +	return 0;
> +}
> +
> +static void rzn1_dt_free_map(struct pinctrl_dev *pctldev,
> +				struct pinctrl_map *map, unsigned int num_maps)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	devm_kfree(ipctl->dev, map);
> +}
> +
> +static const struct pinctrl_ops rzn1_pctrl_ops = {
> +	.get_groups_count = rzn1_get_groups_count,
> +	.get_group_name = rzn1_get_group_name,
> +	.get_group_pins = rzn1_get_group_pins,
> +	.pin_dbg_show = rzn1_pin_dbg_show,
> +	.dt_node_to_map = rzn1_dt_node_to_map,
> +	.dt_free_map = rzn1_dt_free_map,
> +};
> +
> +static int rzn1_pmx_set_mux(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector,
> +	unsigned int group)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct rzn1_pin_group *grp;
> +
> +	/*
> +	 * Configure the mux mode for each pin in the group for a specific
> +	 * function.
> +	 */
> +	grp = &ipctl->groups[group];
> +
> +	dev_dbg(ipctl->dev, "enable function %s(%d) group %s(%d)\n",
> +		ipctl->functions[selector].name, selector, grp->name, group);
> +	/*
> +	 * Well, theres not much to do here anyway, as the individual pin
> +	 * callback is going to be called anyway
> +	 */
> +	return 0;
> +}
> +
> +static int rzn1_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return ipctl->nfunctions;
> +}
> +
> +static const char *rzn1_pmx_get_func_name(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	return ipctl->functions[selector].name;
> +}
> +
> +static int rzn1_pmx_get_groups(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector,
> +	const char * const **groups,
> +	unsigned * const num_groups)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	*groups = ipctl->functions[selector].groups;
> +	*num_groups = ipctl->functions[selector].num_groups;
> +
> +	return 0;
> +}
> +
> +static const struct pinmux_ops rzn1_pmx_ops = {
> +	.get_functions_count = rzn1_pmx_get_funcs_count,
> +	.get_function_name = rzn1_pmx_get_func_name,
> +	.get_function_groups = rzn1_pmx_get_groups,
> +	.set_mux = rzn1_pmx_set_mux,
> +};
> +
> +static int rzn1_pinconf_get(struct pinctrl_dev *pctldev,
> +			     unsigned int pin_id, unsigned long *config)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +
> +	pin_id &= 0xff;
> +	if (pin_id >= ARRAY_SIZE(ipctl->lev1->conf))
> +		return -EINVAL;
> +	*config = readl(&ipctl->lev1->conf[pin_id]) & 0xf;
> +	if (*config == 0xf)
> +		*config = (readl(&ipctl->lev2->conf[pin_id]) & 0x3f) +
> +				RZN1_FUNC_LEVEL2_OFFSET;
> +	*config = (*config << RZN1_MUX_FUNC_BIT) | pin_id;
> +	return 0;
> +}
> +
> +static int rzn1_pinconf_set(struct pinctrl_dev *pctldev,
> +			     unsigned int pin_id, unsigned long *configs,
> +			     unsigned int num_configs)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	int i;
> +
> +	dev_dbg(ipctl->dev, "pinconf set pin %s (%d configs)\n",
> +		rzn1_pins[pin_id].name, num_configs);
> +
> +	for (i = 0; i < num_configs; i++)
> +		rzn1_set_hw_pin_parameters(ipctl, configs[i], LOCK_ALL);
> +
> +	return 0;
> +}
> +
> +

2 empty lines. Again, checkpatch helps with trivial mistakes..

> +static int rzn1_pin_config_group_set(
> +	struct pinctrl_dev *pctldev,
> +	unsigned int selector,
> +	unsigned long *configs,
> +	unsigned int num_configs)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct rzn1_pin_group *grp = &ipctl->groups[selector];
> +	int i;

Empty line after variable declaration.

> +	/*
> +	 * Configure the mux mode for each pin in the group for a specific
> +	 * function.
> +	 */
> +	dev_dbg(ipctl->dev, "group set %s selector:%d configs:%p/%d\n",
> +		grp->name, selector, configs, num_configs);
> +
> +	rzn1_hw_set_lock(ipctl, LOCK_ALL, LOCK_ALL);
> +	for (i = 0; i < num_configs; i++)
> +		rzn1_set_hw_pin_parameters(ipctl, configs[i], 0);
> +	rzn1_hw_set_lock(ipctl, LOCK_ALL, 0);
> +
> +	return 0;
> +}
> +
> +static void rzn1_pinconf_dbg_show(struct pinctrl_dev *pctldev,
> +				   struct seq_file *s, unsigned int pin_id)
> +{
> +	unsigned long config = pin_id;
> +
> +	seq_printf(s, "0x%lx", config);
> +}
> +
> +static void rzn1_pinconf_group_dbg_show(struct pinctrl_dev *pctldev,
> +					 struct seq_file *s, unsigned int group)
> +{
> +	struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +	struct rzn1_pin_group *grp;
> +	unsigned long config;
> +	const char *name;
> +	int i, ret;
> +
> +	if (group > ipctl->ngroups)
> +		return;
> +
> +	seq_puts(s, "\n");
> +	grp = &ipctl->groups[group];
> +	for (i = 0; i < grp->npins; i++) {
> +		name = pin_get_name(pctldev, grp->pin_ids[i] & 0xff);
> +		ret = rzn1_pinconf_get(pctldev, grp->pin_ids[i], &config);
> +		if (ret)
> +			return;
> +		seq_printf(s, "%s: 0x%lx", name, config);
> +	}
> +}
> +
> +static const struct pinconf_ops rzn1_pinconf_ops = {
> +	.pin_config_get = rzn1_pinconf_get,
> +	.pin_config_set = rzn1_pinconf_set,
> +	.pin_config_group_set = rzn1_pin_config_group_set,
> +	.pin_config_dbg_show = rzn1_pinconf_dbg_show,
> +	.pin_config_group_dbg_show = rzn1_pinconf_group_dbg_show,
> +};
> +
> +static struct pinctrl_desc rzn1_pinctrl_desc = {
> +	.pctlops = &rzn1_pctrl_ops,
> +	.pmxops = &rzn1_pmx_ops,
> +	.confops = &rzn1_pinconf_ops,
> +	.owner = THIS_MODULE,
> +};
> +
> +
> +static int
> +rzn1_pinctrl_parse_groups(
> +	struct device_node *np,
> +	struct rzn1_pin_group *grp,
> +	struct rzn1_pinctrl *ipctl)
> +{
> +	int size;
> +	const __be32 *list;
> +	int i;
> +
> +	dev_dbg(ipctl->dev, "%s: %s\n", __func__, np->name);
> +
> +	/* Initialise group */
> +	grp->name = np->name;
> +
> +	/*
> +	 * the binding format is
> +	 *	renesas,rzn1-pinmux-ids = <PIN_FUNC_ID CONFIG ...>,
> +	 * do sanity check and calculate pins number
> +	 */
> +	list = of_get_property(np, RZN1_PINS_PROP, &size);
> +	if (!list) {
> +		dev_err(ipctl->dev,
> +			"no " RZN1_PINS_PROP " property in node %s\n",
> +			np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	/* we do not check return since it's safe node passed down */
> +	if (!size) {
> +		dev_err(ipctl->dev, "Invalid " RZN1_PINS_PROP " in node %s\n",
> +			np->full_name);
> +		return -EINVAL;
> +	}
> +
> +	grp->npins = size / sizeof(list[0]);
> +	if (!grp->npins)
> +		return 0;
> +	grp->pin_ids = devm_kmalloc_array(ipctl->dev,
> +				grp->npins, sizeof(grp->pin_ids[0]),
> +				GFP_KERNEL);
> +	grp->pins = devm_kmalloc_array(ipctl->dev,
> +				grp->npins, sizeof(grp->pins[0]),
> +				GFP_KERNEL);
> +	if (!grp->pin_ids || !grp->pins)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < grp->npins; i++) {
> +		u32 pin_id = be32_to_cpu(*list++);
> +
> +		grp->pins[i] = pin_id & 0xff;
> +		grp->pin_ids[i] = pin_id;
> +	}
> +
> +	return grp->npins;
> +}
> +
> +
> +static int rzn1_pinctrl_count_function_groups(
> +	struct device_node *np)
> +{
> +	struct device_node *child;
> +	int count = 0;
> +
> +	if (of_property_count_u32_elems(np, RZN1_PINS_PROP) > 0)
> +		count++;
> +	for_each_child_of_node(np, child) {
> +		if (of_property_count_u32_elems(child, RZN1_PINS_PROP) > 0)
> +			count++;
> +	}
> +	return count;
> +}
> +
> +static int rzn1_pinctrl_parse_functions(
> +	struct device_node *np,
> +	struct rzn1_pinctrl *ipctl,
> +	u32 index)
> +{
> +	struct device_node *child;
> +	struct rzn1_pmx_func *func;
> +	struct rzn1_pin_group *grp;
> +	u32 i = 0;
> +
> +	dev_dbg(ipctl->dev, "parse function(%d): %s\n", index, np->name);
> +
> +	func = &ipctl->functions[index];
> +
> +	/* Initialise function */
> +	func->name = np->name;
> +	func->num_groups = rzn1_pinctrl_count_function_groups(np);
> +	dev_dbg(ipctl->dev, "function %s has %d groups\n",
> +		np->name, func->num_groups);
> +	if (func->num_groups == 0) {
> +		dev_err(ipctl->dev, "no groups defined in %s\n", np->full_name);
> +		return -EINVAL;
> +	}
> +	func->groups = devm_kmalloc_array(ipctl->dev,
> +			func->num_groups, sizeof(char *), GFP_KERNEL);
> +
> +	if (of_property_count_u32_elems(np, RZN1_PINS_PROP) > 0) {
> +		func->groups[i] = np->name;
> +		grp = &ipctl->groups[ipctl->ngroups];
> +		grp->func = func->name;
> +		if (rzn1_pinctrl_parse_groups(np, grp, ipctl) > 0) {
> +			i++;
> +			ipctl->ngroups++;
> +		}
> +	}
> +	for_each_child_of_node(np, child) {
> +		func->groups[i] = child->name;
> +		grp = &ipctl->groups[ipctl->ngroups];
> +		grp->func = func->name;
> +		if (rzn1_pinctrl_parse_groups(child, grp, ipctl) > 0) {
> +			i++;
> +			ipctl->ngroups++;
> +		}
> +	}
> +	dev_dbg(ipctl->dev, "function %s parsed %d/%d groups\n",
> +		np->name, i, func->num_groups);
> +
> +	return 0;
> +}
> +
> +static ssize_t _rzn1_pinctrl_sysfs_force_mux(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t len)
> +{
> +	struct rzn1_pinctrl *ipctl = dev_get_drvdata(dev);
> +	unsigned long int val;
> +
> +	if (kstrtoul(buf, 16, &val)) {
> +		dev_err(ipctl->dev, "Invalid hex value %08x", (u32)val);
> +		return len;
> +	}
> +
> +	dev_info(ipctl->dev, "setting pin to %08x\n", (u32)val);
> +
> +	rzn1_set_hw_pin_parameters(ipctl, val, LOCK_ALL);
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR(force_mux, 0200, NULL, _rzn1_pinctrl_sysfs_force_mux);
> +
> +static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
> +				struct rzn1_pinctrl *ipctl)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	u32 nfuncs = 0;
> +	u32 i = 0;
> +
> +	if (!np)
> +		return -ENODEV;

Driver depends on OF and is probing, can this happen?

> +
> +	nfuncs = of_get_child_count(np);
> +	if (nfuncs <= 0) {
> +		dev_err(&pdev->dev, "no functions defined\n");
> +		return -EINVAL;
> +	}
> +
> +	ipctl->nfunctions = nfuncs;
> +	ipctl->functions = devm_kmalloc_array(

Please do not break lines for no reason.

> +				&pdev->dev,
> +				nfuncs, sizeof(struct rzn1_pmx_func),
> +				GFP_KERNEL);
> +	if (!ipctl->functions)
> +		return -ENOMEM;
> +
> +	ipctl->ngroups = 0;
> +	ipctl->maxgroups = 0;
> +	for_each_child_of_node(np, child)
> +		ipctl->maxgroups += rzn1_pinctrl_count_function_groups(child);
> +	ipctl->groups = devm_kmalloc_array(
> +				&pdev->dev,
> +				ipctl->maxgroups, sizeof(*ipctl->groups),
> +				GFP_KERNEL);
> +	if (!ipctl->groups)
> +		return -ENOMEM;
> +
> +	for_each_child_of_node(np, child)
> +		rzn1_pinctrl_parse_functions(child, ipctl, i++);
> +
> +	if (device_create_file(&pdev->dev, &dev_attr_force_mux))
> +		dev_warn(&pdev->dev, "cannot create status attribute\n");
> +
> +	return 0;
> +}
> +
> +static int rzn1_pinctrl_probe(struct platform_device *pdev)
> +{
> +	struct rzn1_pinctrl *ipctl;
> +	struct resource *res;
> +	struct clk *clk;
> +	int ret;
> +
> +	/* Create state holders etc for this driver */
> +	ipctl = devm_kzalloc(&pdev->dev, sizeof(*ipctl), GFP_KERNEL);
> +	if (!ipctl)
> +		return -ENOMEM;
> +
> +	clk = devm_clk_get(&pdev->dev, "bus");
> +	if (IS_ERR(clk) || clk_prepare_enable(clk))
> +		dev_info(&pdev->dev, "no clock source\n");
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ipctl->lev1_phys = (u32) res->start;
> +	ipctl->lev1 = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ipctl->lev1))
> +		return PTR_ERR(ipctl->lev1);
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	ipctl->lev2_phys = (u32) res->start;
> +	ipctl->lev2 = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(ipctl->lev2))
> +		return PTR_ERR(ipctl->lev2);
> +
> +	ipctl->dev = &pdev->dev;
> +	rzn1_pinctrl_desc.name = dev_name(&pdev->dev);
> +	rzn1_pinctrl_desc.pins = rzn1_pins;
> +	rzn1_pinctrl_desc.npins = ARRAY_SIZE(rzn1_pins);
> +
> +	ret = rzn1_pinctrl_probe_dt(pdev, ipctl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "fail to probe dt properties\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, ipctl);
> +	ipctl->pctl = pinctrl_register(&rzn1_pinctrl_desc, &pdev->dev, ipctl);
> +	if (!ipctl->pctl) {
> +		dev_err(&pdev->dev, "could not register rzn1 pinctrl driver\n");
> +		return -EINVAL;
> +	}
> +	pinctrl = ipctl;
> +	dev_info(&pdev->dev, "initialized rzn1 pinctrl driver\n");
> +	return 0;
> +}
> +
> +static int rzn1_pinctrl_remove(struct platform_device *pdev)
> +{
> +	device_remove_file(&pdev->dev, &dev_attr_force_mux);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id rzn1_pinctrl_match[] = {
> +	{ .compatible = "renesas,r9a06g032-pinctrl", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_pinctrl_match);
> +
> +static struct platform_driver rzn1_pinctrl_driver = {
> +	.probe	= rzn1_pinctrl_probe,
> +	.remove = rzn1_pinctrl_remove,
> +	.driver	= {
> +		.name		= "r9a06g032-pinctrl",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= rzn1_pinctrl_match,
> +	},
> +};
> +
> +static int __init _pinctrl_drv_register(void)
> +{
> +	return platform_driver_register(&rzn1_pinctrl_driver);
> +}
> +postcore_initcall(_pinctrl_drv_register);
> +
> +
> +MODULE_AUTHOR("Michel Pollet <Michel.Pollet@bp.renesas.com>");
> +MODULE_DESCRIPTION("Renesas R9A06G032 pinctrl driver");
> +MODULE_LICENSE("GPL");

The SPDX header says GPL-v2 and this one GPL only.

As said, this is all minor stuff. Let's get back to the meat of this
driver once bindings are finalized.

Thanks
   j

> --
> 2.7.4
>

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJbI5wOAAoJEHI0Bo8WoVY8jBsP/2VRcHZx4OQE+0AY1boEIhZ0
nT+64ObKXkZAeUt4m5IWKSOZmxQ0xnwTdAapGO3vEAfo2/nO9FNl2vs2eot4EEsX
QzUd6Ulzy50TUMD3+NexEM6Yj74tRW46lCC0AMInrcGRHI7C+Za5X4VNwP5GlQAN
T91+OOisBWedPXy7OUm0t0ChMCXbBM9LjhhT2mKvZCIoOIjgB2ah9R6N2CBDA10K
SAZaY3DSoT8dlSeKpflJWsSA+1ZI/AU3UHsbL9OAe30I+rMMA3Hhi80s1pizC+mk
ITKKuGCWXrDcAHZBTFh82az1Lsyj7JRHUsqEhhO4xGnBPFPKDGy7xEYMgWYRx4Dw
3eOPoEmq/bE1/gjITPlT8U0D3PeaqXtDhHvFHRHGngMJsCyK6zTQpl0VcHKLqoo4
SnPNR2/b3i903cApozoZjoJuX4BJA7Vbhhl7VE37o7hzDSNb2wy1aHWWL3Ir/n5j
UkAOg0SFEoQjV46y+8huPnGOw+d+O+9QTxW73ooz9aBLlpT3CBzt1poDaSJL3kwS
Xd4CSfQlcs8odU/CdYmsp+VaEiaPX0qssjMpVjqFmmzJvEkq094MRJPQevLqfCtD
GXHzIXmfhZtm+df+k0zrPg5BUMpVXyjwh8uA194FpCLKpystW+3Nu5i4FbylbMr0
/uO1sjctkvPKpedKHBl8
=piXQ
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
