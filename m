Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A433F21917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 14:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWHfiAnx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbeLUOfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 09:35:11 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37390 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403832AbeLUOfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 09:35:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so5929987wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 06:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xaTbw7b+ugNib31h+/N6OXhHoPJ9WE4SsmV0xt3qJFE=;
        b=JWHfiAnxQpMlPQeU9xqC9lT/yacnxwmZjfSWJj734Deyl7b2AcdG6hKVFshgFdXTTF
         eIg2mUXi/vk8mbJ6EWTOAe6Zt0PKGJEToKipHFPrCh3nNiVBvJMxDE0CYuWLuHs2j1p7
         JBlmACrXCpIaNHMMJCrTqzXRu5Nhsxv3uiLko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xaTbw7b+ugNib31h+/N6OXhHoPJ9WE4SsmV0xt3qJFE=;
        b=YzsGQWCfadENNdPhaLtAomNE3VHBzh6gcALi7ak9Xs3arTqDEmFlbZtlvDWtRKZHRi
         wW0p/VQ3D9eK2FJLTnQXCFxQcmxby1b0nrSiDJfkvZTY5mHc6kgkqVVXgyXJUU8tjA87
         4SiZgblzNc8/h8IPOoOiXrMfq269ipAHtpE4AF00t3FuoqEOqhksf/ae7HMsrgWXhEE4
         Bkh9D+p4iAUPAzHNvbbGs9gLeFCRwFMysNAJdkRWqbi8Xai4NjY8j5vUQKrDb3TikGdC
         xF7aJvztgwO9T6YyeOFDNIkDc0AAIQZFI1QY8uA+wxzCMJUQ+XLde1lf5eKPqGhTRoWr
         X4JQ==
X-Gm-Message-State: AA+aEWZKPEuSfvzbOexZNMrpJctf/05MQKgkfGeKTjtUGrqJPMErIwwI
        w31bCVYTOrlRX+FuX6DtZX6kcQ==
X-Google-Smtp-Source: AFSGD/XBqo55uSajGKrOBJDvXKBNbv4n2quANZPeCu4sCzdp7Zv61x6Ln7F+uEt7kSFTvbRbDGvjMQ==
X-Received: by 2002:a1c:27c6:: with SMTP id n189mr3074084wmn.108.1545402907685;
        Fri, 21 Dec 2018 06:35:07 -0800 (PST)
Received: from dell ([95.149.164.119])
        by smtp.gmail.com with ESMTPSA id o15sm11794769wrp.12.2018.12.21.06.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 06:35:07 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:35:05 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20181221143505.GQ13248@dell>
References: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545152036-23239-1-git-send-email-andrew@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018, Andrew Lunn wrote:

> The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> MFD which will instantiate the individual drivers.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
> 
> Drop setting i2c bus speed, which removes the build dependencies on
> the i2c ocores patches. This can be added back later.
> ---
>  drivers/mfd/Kconfig  |   8 +
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/tqmx86.c | 404 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 413 insertions(+)
>  create mode 100644 drivers/mfd/tqmx86.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326..8c86a2a215e8 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1676,6 +1676,14 @@ config MFD_TC6393XB
>  	help
>  	  Support for Toshiba Mobile IO Controller TC6393XB
>  
> +config MFD_TQMX86
> +       tristate "TQ-Systems IO controller TQMX86"
> +       select MFD_CORE
> +       help
> +	  Say yes here to enable support for various functions of the
> +	  TQ-Systems IO controller and watchdog device, found on their
> +	  ComExpress CPU modules

The help should be indented.

Nit: You're missing a full stop.

>  config MFD_VX855
>  	tristate "VIA VX855/VX875 integrated south bridge"
>  	depends on PCI
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..7f4790662988 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -36,6 +36,7 @@ obj-$(CONFIG_MFD_TC3589X)	+= tc3589x.o
>  obj-$(CONFIG_MFD_T7L66XB)	+= t7l66xb.o tmio_core.o
>  obj-$(CONFIG_MFD_TC6387XB)	+= tc6387xb.o tmio_core.o
>  obj-$(CONFIG_MFD_TC6393XB)	+= tc6393xb.o tmio_core.o
> +obj-$(CONFIG_MFD_TQMX86)	+= tqmx86.o
>  
>  obj-$(CONFIG_MFD_ARIZONA)	+= arizona-core.o
>  obj-$(CONFIG_MFD_ARIZONA)	+= arizona-irq.o
> diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> new file mode 100644
> index 000000000000..4eca166db000
> --- /dev/null
> +++ b/drivers/mfd/tqmx86.c
> @@ -0,0 +1,404 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TQ-Systems PLD MFD core driver
> + *
> + * Copyright (c) 2015 TQ-Systems GmbH

Copyright is out of date.

> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.

You shouldn't need this now that you have the SPDX above.

> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/dmi.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/platform_data/i2c-ocores.h>

Alphabetical.

> +#define TQMX86_IOBASE	0x160
> +#define TQMX86_IOSIZE	0x3f
> +#define TQMX86_CLK	33000	/* default */

Why don't you call this TQMX86_DEFAULT_CLK_RATE ?

Then drop the comment.

> +/* Registers offsets */

Register

> +#define TQMX86_BID	0x20	/* Board ID */
> +#define TQMX86_BREV	0x21	/* Board and PLD Revisions */
> +#define TQMX86_IOEIC	0x26	/* I/O Extension Interrupt Configuration */
> +#define TQMX86_I2C_DET	0x47	/* I2C controller detection register */
> +#define TQMX86_I2C_IEN	0x49	/* machxo2 I2C nterrupt enable register */

All them, TQMX86_REG_*, then drop the header comment.

If your #defines were named well, they should not need comments.

> +struct tqmx86_info {
> +	u32	board_id;
> +	u32	board_rev;
> +	u32	pld_rev;
> +	u32	i2c_type;
> +};

Why not just add these to ddata?

> +#define I2C_KIND_SOFT	1	/* Ocores soft controller */
> +#define I2C_KIND_HARD	2	/* Machxo2 hard controller */

What is a soft/hard controller?

These should be grouped with your other defines.

> +/**
> + * struct tqmx86_device_data - Internal representation of the PLD device
> + * @io_base:		Pointer to the IO memory
> + * @pld_clock:		PLD clock frequency

pid_clk_rate

> + * @dev:		Pointer to kernel device structure
> + */
> +struct tqmx86_device_data {

s/data/ddata/

> +	void __iomem		*io_base;
> +	u32			pld_clock;
> +	struct device		*dev;

You don't need this.

Just pass pdev as the first argument to tqmx86_detect_device().

> +	struct tqmx86_info	info;
> +};
> +
> +/**
> + * struct tqmx86_platform_data - PLD hardware configuration structure
> + * @pld_clock:			PLD clock frequency
> + * @ioresource:			IO addresses of the PLD
> + */
> +struct tqmx86_platform_data {
> +	u32				pld_clock;
> +	struct resource			*ioresource;

Too many tabs.

> +};
> +
> +static uint gpio_irq;
> +module_param(gpio_irq, uint, 0);
> +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");

I have never seen anything like this.

This should be set by platform data, not a module parameter.

> +static u8 i2c_irq_ctl[16] = {
> +	[7] = 1,
> +	[9] = 2,
> +	[12] = 3
> +};
> +
> +static u8 tqmx86_readb(struct tqmx86_device_data *pld, u32 off)
> +{
> +	return ioread8(pld->io_base + off);
> +}
> +
> +static void tqmx86_writeb(struct tqmx86_device_data *pld, u8 val, u32 off)
> +{
> +	iowrite8(val, pld->io_base + off);
> +}

Don't write needless abstraction layers.

Use the calls themselves.

Any reason for not using Regmap?

> +enum tqmx86_cells {
> +	TQMX86_I2C_SOFT = 0,
> +	TQMX86_WDT,
> +	TQMX86_GPIO,
> +	TQMX86_UART,
> +};

Why do you need to number the cells?

> +static struct resource tqmx_i2c_soft_resources[] = {
> +	DEFINE_RES_IO(0x1a0, 10),

No magic numbers please.  You need to define these.

> +};
> +
> +static struct resource tqmx_watchdog_resources[] = {
> +	DEFINE_RES_IO(0x18b, 2),
> +};
> +
> +static struct resource tqmx_gpio_resources[] = {
> +	DEFINE_RES_IO(0x18d, 4),
> +	DEFINE_RES_IRQ(0)
> +};
> +
> +static struct i2c_board_info tqmx86_i2c_devices[] = {
> +	/* 4K EEPROM at 0x50 */
> +	{
> +		.type = "24c32",
> +		.addr = 0x50,
> +	},
> +};
> +
> +static struct ocores_i2c_platform_data ocores_platfom_data = {
> +	.clock_khz = TQMX86_CLK,
> +	.num_devices = ARRAY_SIZE(tqmx86_i2c_devices),
> +	.devices = tqmx86_i2c_devices,
> +};
> +
> +static const struct mfd_cell tqmx86_devs[] = {
> +	[TQMX86_I2C_SOFT] = {
> +		.name = "ocores-i2c",
> +		.platform_data = &ocores_platfom_data,
> +		.pdata_size = sizeof(ocores_platfom_data),
> +		.resources = tqmx_i2c_soft_resources,
> +		.num_resources = ARRAY_SIZE(tqmx_i2c_soft_resources),
> +	},
> +	[TQMX86_WDT] = {
> +		.name = "tqmx86-wdt",
> +		.resources = tqmx_watchdog_resources,
> +		.num_resources = 1,
> +		.ignore_resource_conflicts = 1,
> +	},
> +	[TQMX86_GPIO] = {
> +		.name = "tqmx86-gpio",
> +		.resources = tqmx_gpio_resources,
> +		.num_resources = ARRAY_SIZE(tqmx_gpio_resources),
> +		.ignore_resource_conflicts = 1,
> +	},
> +};
> +
> +#define TQMX86_MAX_DEVS	ARRAY_SIZE(tqmx86_devs)
> +
> +static int tqmx86_register_cells(struct tqmx86_device_data *pld)
> +{
> +	struct mfd_cell devs[TQMX86_MAX_DEVS];

Why is it being done like this?

Registering MFD cells is a well trodden path.

No need to invent new ways to do it

> +	int i = 0;
> +	u8 ioeic_val = 0;
> +
> +	ioeic_val |= (i2c_irq_ctl[gpio_irq] & 0x3) << 4;

What is IOEIC?

The magic numbers should be defined (*_SHIFT/*_MASK)

Side note: If I have to ask this many questions, it normally means the
code is not transparent enough.  There could be many reasons for this;
variable/function nomenclature, code trying to be too clever or do too
many things at once, coding style, data structure hacks, etc etc.

> +	dev_dbg(pld->dev, "ioeic %x\n", ioeic_val);

Are these really (still - after initial development) helpful to you?

Will they really be helpful to others?

> +	if (ioeic_val) {
> +		tqmx86_writeb(pld, ioeic_val, TQMX86_IOEIC);
> +		if (tqmx86_readb(pld, TQMX86_IOEIC) != ioeic_val) {
> +			dev_warn(pld->dev,
> +				 "i2c/gpio interrupts not supported.\n");
> +			gpio_irq = 0;
> +		}
> +	}
> +
> +	if (pld->info.i2c_type == I2C_KIND_SOFT) {
> +		ocores_platfom_data.clock_khz = pld->pld_clock;
> +		devs[i++] = tqmx86_devs[TQMX86_I2C_SOFT];
> +	}

See other drivers to see how they handle optional cells.

> +	tqmx_gpio_resources[1].start = gpio_irq;

What about end?  This is a hack anyway.

> +	devs[i++] = tqmx86_devs[TQMX86_WDT];
> +	devs[i++] = tqmx86_devs[TQMX86_GPIO];
> +
> +	return mfd_add_devices(pld->dev, -1, devs, i, NULL, 0, NULL);

Should not be -1.  Check other drivers.

Can you use devm_*?

> +}
> +
> +static struct resource tqmx86_ioresource = {
> +	.start	= TQMX86_IOBASE,
> +	.end	= TQMX86_IOBASE + TQMX86_IOSIZE,
> +	.flags	= IORESOURCE_IO,
> +};

DEFINE_RES_*?

> +static const struct tqmx86_platform_data tqmx86_platform_data_generic = {
> +	.pld_clock		= TQMX86_CLK,
> +	.ioresource		= &tqmx86_ioresource,
> +};

Who will receive this platform data?

> +static struct platform_device *tqmx86_pdev;

Global?

> +static int tqmx86_create_platform_device(const struct dmi_system_id *id)

This blows my mind.

 - The normal module_init() calls are initiated calling for a DMI scan
 - Then the DMI device init()s
 - You use the DMI init() to register this device as a platform device
 - Then this platform device then probes

That seems very incestuous.

What is the reason for all the hoop jumping?

> +{
> +	struct tqmx86_platform_data *pdata = id->driver_data;
> +	int ret;
> +
> +	tqmx86_pdev = platform_device_alloc("tqmx86", -1);
> +	if (!tqmx86_pdev)
> +		return -ENOMEM;
> +
> +	ret = platform_device_add_data(tqmx86_pdev, pdata, sizeof(*pdata));
> +	if (ret)
> +		goto err;
> +
> +	ret = platform_device_add_resources(tqmx86_pdev, pdata->ioresource, 1);
> +	if (ret)
> +		goto err;
> +
> +	ret = platform_device_add(tqmx86_pdev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	platform_device_put(tqmx86_pdev);
> +	return ret;
> +}
> +
> +static struct tq_board_info {
> +	char *name;
> +	u32 pld_clock;
> +} tq_board_info[] = {
> +	{"", 0},
> +	{"TQMxE38M", 33000},
> +	{"TQMx50UC", 24000},
> +	{"TQMxE38C", 33000},
> +	{"TQMx60EB", 24000},
> +	{"TQMxE39M", 25000},
> +	{"TQMxE39C", 25000},
> +	{"TQMxE39x", 25000},
> +	{"TQMx70EB", 24000},
> +	{"TQMx80UC", 24000},
> +	{"TQMx90UC", 24000}
> +};

Better to write a look-up function I think.

What happens if the next released board ID is 0xFC?

> +static ssize_t board_id_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%s\n",
> +			 tq_board_info[pld->info.board_id].name);
> +}
> +
> +static ssize_t board_rev_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", pld->info.board_rev);
> +}
> +
> +static ssize_t pld_rev_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct tqmx86_device_data *pld = dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "PLD Revision: %d",
> +			 pld->info.pld_rev);
> +}
> +
> +static DEVICE_ATTR_RO(board_id);
> +static DEVICE_ATTR_RO(board_rev);
> +static DEVICE_ATTR_RO(pld_rev);
> +
> +static struct attribute *pld_attributes[] = {
> +	&dev_attr_board_id.attr,
> +	&dev_attr_board_rev.attr,
> +	&dev_attr_pld_rev.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group pld_attr_group = {
> +	.attrs = pld_attributes,
> +};

What are you using sysfs for that requires this information?

> +static int tqmx86_detect_device(struct tqmx86_device_data *pld)
> +{
> +	u8 board_id, rev, i2c_det, i2c_ien;
> +	int ret;
> +
> +
> +	board_id = tqmx86_readb(pld, TQMX86_BID);
> +	if (board_id == 0 || board_id > ARRAY_SIZE(tq_board_info) - 1)
> +		return -ENODEV;

This seems fragile.  You should define the maximum board ID.

Also, you exit silently -- is that really what you want?

> +	pld->pld_clock = tq_board_info[board_id].pld_clock;
> +
> +	rev = tqmx86_readb(pld, TQMX86_BREV);

'\n' here.

> +	pld->info.board_id = board_id;
> +	pld->info.board_rev = rev >> 4;
> +	pld->info.pld_rev = rev & 0xf;
> +
> +	i2c_det = tqmx86_readb(pld, TQMX86_I2C_DET);
> +	i2c_ien = tqmx86_readb(pld, TQMX86_I2C_IEN);

What are these values?

> +	if (i2c_det == 0xa5 && (i2c_ien & 0xf0) == 0xf0)

More unreadable magic numbers.

> +		pld->info.i2c_type = I2C_KIND_SOFT;
> +	else
> +		pld->info.i2c_type = I2C_KIND_HARD;

What are these?

> +	dev_info(pld->dev,
> +		 "Found TQx86 PLD - Board ID %d, PCB Revision %d, PLD Revision %d\n",
> +		 board_id, rev >> 4, rev & 0xf);
> +
> +	ret = sysfs_create_group(&pld->dev->kobj, &pld_attr_group);
> +	if (ret)
> +		return ret;
> +
> +	ret = tqmx86_register_cells(pld);
> +	if (ret)
> +		sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
> +
> +	return ret;
> +}
> +
> +static int tqmx86_probe(struct platform_device *pdev)
> +{
> +	struct tqmx86_platform_data *pdata = dev_get_platdata(&pdev->dev);

Where was this previously set?

> +	struct device *dev = &pdev->dev;
> +	struct tqmx86_device_data *pld;
> +	struct resource *ioport;
> +
> +	pld = devm_kzalloc(dev, sizeof(*pld), GFP_KERNEL);
> +	if (!pld)
> +		return -ENOMEM;
> +
> +	ioport = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!ioport)
> +		return -EINVAL;
> +
> +	pld->io_base = devm_ioport_map(dev, ioport->start,
> +				       resource_size(ioport));

This is used very little in the kernel.

What is it you're trying to do here?

Is Regmap a better alternative?  Take a look at some other MFD drivers.

> +	if (!pld->io_base)
> +		return -ENOMEM;
> +
> +	pld->pld_clock = pdata->pld_clock;
> +	pld->dev = dev;
> +
> +	platform_set_drvdata(pdev, pld);
> +
> +	return tqmx86_detect_device(pld);
> +}
> +
> +static int tqmx86_remove(struct platform_device *pdev)
> +{
> +	struct tqmx86_device_data *pld = dev_get_drvdata(&pdev->dev);
> +
> +	sysfs_remove_group(&pld->dev->kobj, &pld_attr_group);
> +	mfd_remove_devices(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tqmx86_driver = {
> +	.driver		= {
> +		.name	= "tqmx86",
> +	},
> +	.probe		= tqmx86_probe,
> +	.remove		= tqmx86_remove,
> +};
> +
> +static struct dmi_system_id tqmx86_dmi_table[] __initdata = {
> +	{
> +		.ident = "TQMX86",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TQ-Group"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TQMx"),
> +		},
> +		.driver_data = (void *)&tqmx86_platform_data_generic,
> +		.callback = tqmx86_create_platform_device,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, tqmx86_dmi_table);
> +
> +static int __init tqmx86_init(void)
> +{
> +	if (gpio_irq > 15) {
> +		pr_warn("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
> +		gpio_irq = 0;
> +	} else if (i2c_irq_ctl[gpio_irq] == 0) {
> +		pr_warn("tqmx86: GPIO IRQ %d not supported\n", gpio_irq);
> +		gpio_irq = 0;
> +	}
> +
> +	if (!dmi_check_system(tqmx86_dmi_table))
> +		return -ENODEV;
> +
> +	return platform_driver_register(&tqmx86_driver);
> +}
> +
> +static void __exit tqmx86_exit(void)
> +{
> +	if (tqmx86_pdev)
> +		platform_device_unregister(tqmx86_pdev);
> +
> +	platform_driver_unregister(&tqmx86_driver);
> +}
> +
> +module_init(tqmx86_init);
> +module_exit(tqmx86_exit);
> +
> +MODULE_DESCRIPTION("TQx86 PLD Core Driver");
> +MODULE_AUTHOR("Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>");
> +MODULE_LICENSE("GPL");

This does not match the file header.

Should be "GPL v2"

> +MODULE_ALIAS("platform:tqmx86");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
