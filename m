Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F06C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B15218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJYyD343"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfBAOPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:15:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbfBAOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:15:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so6270095wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7JSgoZeUBAmD8utILCTUYOUnTOCAoM4Iu3l78AIa6cY=;
        b=WJYyD3439EFLy58Q/X0QSzeLO9iR3eyp9GIw2Gk8M8TfU6LZ6Zgb5lHlOKQQVBxo2w
         o62bqoqgPDAhrIarOzqw5Zk75Qt90AJRjmjRs5iV6ERvrqrvevuQLvbNZI+TZ6WUtQqL
         WcKJFW2N77bqYbAmrBFWySROBaxHfuX4GK7ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7JSgoZeUBAmD8utILCTUYOUnTOCAoM4Iu3l78AIa6cY=;
        b=uF4PYaC2wd5nITTKclQiIOaIugcSmqPCxgUahMseNyHy/HZZpV+xy0COP4URJOCSza
         orOzlcjEBTt/MoVsySn+WZflmAORODw2J5SLhGtNqkC9jOj8EnKva9Jpwz8HKnz/27qe
         DzEkF8dmhHqH4O346JtDef87fe+bwA4x7OShpBM/XNzQD3KNzmQuYUygjLKY1aHP2aNr
         u9C7PAaw6WsMdz4E7+IkCthbOqdsEENltYkynTfgTCmlI3+4mfWwO7j316ITSw7X7hI3
         c1lB5imEfUEL37VolFvuP/Jw42CW6Ayw10hMU+g8Zfqj8KUIEPRG7aHDQd6tsXK4pJs1
         FydA==
X-Gm-Message-State: AHQUAuZxORcLBRvtt7bjxfEDwiXH7z2JJt/xW5fHnA8TXTEf/pjV5y3T
        8Y04XKFSpD6ASN2UhiffqF5Jtg==
X-Google-Smtp-Source: AHgI3IYNO//y4wjS3rLddHCnD212lAP/VoN6o9Ad6XJtV26kxdpO6SEiaILUu+v0W8rwbhUBm9mZFg==
X-Received: by 2002:a1c:bd86:: with SMTP id n128mr2636531wmf.22.1549030543166;
        Fri, 01 Feb 2019 06:15:43 -0800 (PST)
Received: from dell ([2.27.35.198])
        by smtp.gmail.com with ESMTPSA id k7sm7765935wrl.51.2019.02.01.06.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 06:15:42 -0800 (PST)
Date:   Fri, 1 Feb 2019 14:15:40 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v4] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190201141540.GI783@dell>
References: <20190129204224.17951-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129204224.17951-1-andrew@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019, Andrew Lunn wrote:

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
> 
> v3:
> 
> Fix indentation of help
> Fix SPDX to match MODULE_LICENSE
> Remove warranty text
> Add my Copyright
> Sort include files
> Add _REG_ to register defines
> Add #defines for all resources
> Replace magic numbers with #defines
> Rename pld_clock to pld_clock_rate
> Remove wrapper around ioread8()/iowrite8()
> Scatter const keyword in a few places
> Remove enum for calls
> Implement lookup for board in tq_board_if
> Rename ioeic to io_ext_int_val to make is more readable
> Handle optional calls in a different way
> Better group code and structures
> Kill all the sysfs attributes
> Use devm_mfd_add_devices()
> Don't exist silently for unknown board ID
> 
> Not addressed, waiting for answers:
> MODULE_PARM for GPIO interrupts
> Not using regmap, intel IO not supported by regmap
> Setting GPIO irq on resource structure
> Global tqmx86_pdev
> Jumping through hoops
> 
> v4
> 
> RFC 3676 specifies that an signature should be separated from the body
> of the using "-- \n". Version 3 of this patch used "--\n" in the body
> of the text, but apparently some email clients are broken and consider
> this as an signature separator. Remove all instances of -- as a
> workaround.
> 
> No Changes to the action code.
> ---
>  drivers/mfd/Kconfig  |   8 ++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/tqmx86.c | 303 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 drivers/mfd/tqmx86.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..2694552cf4be 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1677,6 +1677,14 @@ config MFD_TC6393XB
>  	help
>  	  Support for Toshiba Mobile IO Controller TC6393XB
>  
> +config MFD_TQMX86
> +       tristate "TQ-Systems IO controller TQMX86"
> +       select MFD_CORE
> +       help
> +	  Say yes here to enable support for various functions of the
> +	  TQ-Systems IO controller and watchdog device, found on their
> +	  ComExpress CPU modules.

The help should be indented by two spaces.

See the other entries (like the one a few lines up --^

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
> index 000000000000..144c176cf2bc
> --- /dev/null
> +++ b/drivers/mfd/tqmx86.c
> @@ -0,0 +1,303 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * TQ-Systems PLD MFD core driver, based on vendor driver by
> + * Vadim V.Vlasov <vvlasov@dev.rtsoft.ru>
> + *
> + * Copyright (c) 2015 TQ-Systems GmbH
> + * Copyright (c) 2019 Andrew Lunn <andrew@lunn.ch>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/i2c.h>
> +#include <linux/io.h>
> +#include <linux/mfd/core.h>
> +#include <linux/module.h>
> +#include <linux/platform_data/i2c-ocores.h>
> +#include <linux/platform_device.h>
> +
> +#define TQMX86_IOBASE	0x160
> +#define TQMX86_IOSIZE	0x3f
> +#define TQMX86_IOBASE_I2C	0x1a0
> +#define TQMX86_IOSIZE_I2C	0xa
> +#define TQMX86_IOBASE_WATCHDOG	0x18b
> +#define TQMX86_IOSIZE_WATCHDOG	0x2
> +#define TQMX86_IOBASE_GPIO	0x18d
> +#define TQMX86_IOSIZE_GPIO	0x4
> +
> +#define TQMX86_REG_BOARD_ID	0x20
> +#define TQMX86_REG_BOARD_REV	0x21
> +#define TQMX86_REG_IO_EXT_INT	0x26
> +#define TQMX86_REG_IO_EXT_INT_MASK		0x3
> +#define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
> +#define TQMX86_REG_I2C_DETECT	0x47
> +#define TQMX86_REG_I2C_DETECT_SOFT		0xa5
> +#define TQMX86_REG_I2C_INT_EN	0x49
> +
> +#define I2C_KIND_SOFT	1	/* Ocores I2C soft controller */
> +#define I2C_KIND_HARD	2	/* Machxo2 I2C hard controller */
> +
> +/**
> + * struct tqmx86_device_data - Internal representation of the PLD device

This is wrong.
> + * @io_base:		Pointer to the IO memory
> + * @pld_clock_rate:	PLD clock frequency
> + * @dev:		Pointer to kernel device structure

This is missing from the struct.

> + * @i2c_type:		Hard of soft I2C hardware macro
> + */
> +struct tqmx86_device_ddata {

> +	void __iomem	*io_base;
> +	u32		pld_clock_rate;
> +	u32		i2c_type;
> +};
> +
> +/**
> + * struct tqmx86_platform_data - PLD hardware configuration structure
> + * @ioresource:		IO addresses of the PLD
> + */
> +struct tqmx86_platform_ddata {

ddata (device data) and pdata (platform data) are different.

For platform data, it should be "*_platform_data" or "*_pdata".

> +	struct resource	*ioresource;
> +};
> +
> +static uint gpio_irq;
> +module_param(gpio_irq, uint, 0);
> +MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (7, 9, 12)");

What is the purpose of providing the IRQ number via a module param?

These seems like a very bad idea.

Can this driver be built-in?

> +static const u8 i2c_irq_ctl[] = {
> +	[7] = 1,
> +	[9] = 2,
> +	[12] = 3
> +};

Rather than wasting memory, you could do:

static const u8 i2c_irq_ctl[] = { 7, 9, 12 };

You'll then have to loop over it once to get the index.

It also does not need to be global.

> +static const struct resource tqmx_i2c_soft_resources[] = {
> +	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
> +};
> +
> +static const struct resource tqmx_watchdog_resources[] = {
> +	DEFINE_RES_IO(TQMX86_IOBASE_WATCHDOG, TQMX86_IOSIZE_WATCHDOG),
> +};
> +
> +static struct resource tqmx_gpio_resources[] = {
> +	DEFINE_RES_IO(TQMX86_IOBASE_GPIO, TQMX86_IOSIZE_GPIO),
> +	DEFINE_RES_IRQ(0)
> +};
> +
> +static struct i2c_board_info tqmx86_i2c_devices[] = {
> +	{
> +		/* 4K EEPROM at 0x50 */
> +		I2C_BOARD_INFO("24c32", 0x50),
> +	},
> +};
> +
> +static struct ocores_i2c_platform_data ocores_platfom_ddata = {
> +	.num_devices = ARRAY_SIZE(tqmx86_i2c_devices),
> +	.devices = tqmx86_i2c_devices,
> +};
> +
> +static const struct mfd_cell tqmx86_devs[] = {
> +	{
> +		.name = "ocores-i2c",
> +		.platform_data = &ocores_platfom_ddata,
> +		.pdata_size = sizeof(ocores_platfom_ddata),
> +		.resources = tqmx_i2c_soft_resources,
> +		.num_resources = ARRAY_SIZE(tqmx_i2c_soft_resources),
> +	},
> +	{
> +		.name = "tqmx86-wdt",
> +		.resources = tqmx_watchdog_resources,
> +		.num_resources = 1,

This is fragile.  Use ARRAY_SIZE instead.

> +		.ignore_resource_conflicts = 1,

This is a bool.  It should be 'true'.

> +	},
> +	{
> +		.name = "tqmx86-gpio",
> +		.resources = tqmx_gpio_resources,
> +		.num_resources = ARRAY_SIZE(tqmx_gpio_resources),
> +		.ignore_resource_conflicts = 1,

As above.

> +	},
> +};
> +
> +static const struct tq_board_info {
> +	u8 board_id;
> +	char *name;
> +	u32 pld_clock_rate;
> +} tq_board_info[] = {
> +	{ 0, "", 0 },
> +	{ 1, "TQMxE38M", 33000 },
> +	{ 2, "TQMx50UC", 24000 },
> +	{ 3, "TQMxE38C", 33000 },
> +	{ 4, "TQMx60EB", 24000 },
> +	{ 5, "TQMxE39M", 25000 },
> +	{ 6, "TQMxE39C", 25000 },
> +	{ 7, "TQMxE39x", 25000 },
> +	{ 8, "TQMx70EB", 24000 },
> +	{ 9, "TQMx80UC", 24000 },
> +	{10, "TQMx90UC", 24000 }
> +};

Never been a fan of this syntax, and although it can be seen in the
kernel, it's use is very infrequent.  Better to separate the
struct declaration and its use.

There is not much point having a numbered struct attribute which
directly matches the index.  See below for a better use of this -
saves some CPU cycles too.

> +static int tqmx86_probe(struct platform_device *pdev)
> +{
> +	u8 board_id, rev, i2c_det, i2c_ien, io_ext_int_val;
> +	struct device *dev = &pdev->dev;
> +	struct tqmx86_device_ddata *pld;

The 'd' in 'ddata' means device.

So you have a struct called 'tqmx86_device_device_data'.

Consider renaming it to 'tqmx86_ddata'.

> +	struct resource *ioport;
> +	int i;
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
> +	if (!pld->io_base)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, pld);

Where is this unpacked and used again?

> +	board_id = ioread8(pld->io_base + TQMX86_REG_BOARD_ID);
> +	for (i = 0; i < ARRAY_SIZE(tq_board_info); i++)
> +		if (tq_board_info[i].board_id == board_id)
> +			break;
> +
> +	if (i == ARRAY_SIZE(tq_board_info)) {
> +		dev_info(&pdev->dev,
> +			 "Board ID %d not supported by this driver\n",

Users don't care about "drivers".

Just say "Device with board ID %d not currently supported\n"

> +			 board_id);
> +		return -ENODEV;
> +	}

Better to do:

	board_id = ioread8(pld->io_base + TQMX86_REG_BOARD_ID);
	if (board_id > MAX_BOARD_IDS) {
		dev_info(&pdev->dev,
			 "Board ID %d not supported by this driver\n",
			 board_id);
		return -ENODEV;
	}
	
> +	rev = ioread8(pld->io_base + TQMX86_REG_BOARD_REV);
> +
> +	dev_info(&pdev->dev,
> +		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
> +		 tq_board_info[i].name, board_id, rev >> 4, rev & 0xf);

Then here s/i/board_id/

> +	pld->pld_clock_rate = tq_board_info[i].pld_clock_rate;
> +
> +	i2c_det = ioread8(pld->io_base + TQMX86_REG_I2C_DETECT);
> +	i2c_ien = ioread8(pld->io_base + TQMX86_REG_I2C_INT_EN);
> +
> +	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT)
> +		pld->i2c_type = I2C_KIND_SOFT;
> +	else
> +		pld->i2c_type = I2C_KIND_HARD;
> +
> +	io_ext_int_val =
> +		(i2c_irq_ctl[gpio_irq] & TQMX86_REG_IO_EXT_INT_MASK) <<
> +		TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;
> +
> +	if (io_ext_int_val) {

Better to do "if (gpio_irq)" a few lines above.

> +		iowrite8(io_ext_int_val, pld->io_base + TQMX86_REG_IO_EXT_INT);
> +		if (ioread8(pld->io_base + TQMX86_REG_IO_EXT_INT) !=
> +		    io_ext_int_val) {
> +			dev_warn(&pdev->dev,
> +				 "gpio interrupts not supported.\n");

s/gpio/GPIO/

> +			gpio_irq = 0;
> +		}
> +	}
> +
> +	ocores_platfom_ddata.clock_khz = pld->pld_clock_rate;
> +	tqmx_gpio_resources[1].start = gpio_irq;

This is fragile.  What if someone else adds another resource entry?

> +	if (pld->i2c_type == I2C_KIND_SOFT)
> +		return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +					    tqmx86_devs,
> +					    ARRAY_SIZE(tqmx86_devs),
> +					    NULL, 0, NULL);
> +
> +	/* Skip the soft I2C cell */

This is not nice.

Better to place the soft entry into a separate cell and call
*mfd_add_devices() either once or twice.

> +	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
> +				    &tqmx86_devs[1],
> +				    ARRAY_SIZE(tqmx86_devs) - 1,
> +				    NULL, 0, NULL);
> +}
> +
> +static struct resource tqmx86_ioresource[] = {
> +	DEFINE_RES_IO(TQMX86_IOBASE, TQMX86_IOSIZE),
> +};
> +
> +static const struct tqmx86_platform_ddata tqmx86_platform_ddata_generic = {
> +	.ioresource	= &tqmx86_ioresource[0],
> +};
> +
> +static struct platform_device *tqmx86_pdev;
> +
> +static int tqmx86_create_platform_device(const struct dmi_system_id *id)
> +{
> +	struct tqmx86_platform_ddata *pdata = id->driver_data;
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
> +static const struct dmi_system_id tqmx86_dmi_table[] __initconst = {
> +	{
> +		.ident = "TQMX86",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TQ-Group"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TQMx"),
> +		},
> +		.driver_data = (void *)&tqmx86_platform_ddata_generic,
> +		.callback = tqmx86_create_platform_device,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, tqmx86_dmi_table);

This is still some nasty stuff!

But as you say, I'm not sure how to do it otherwise.

Perhaps this should be a subsystem or platform function it its own
right?

> +static struct platform_driver tqmx86_driver = {
> +	.driver		= {
> +		.name	= "tqmx86",
> +	},
> +	.probe		= tqmx86_probe,
> +};
> +
> +static int __init tqmx86_init(void)
> +{
> +	if (gpio_irq != 0 && gpio_irq != 7 &&
> +	    gpio_irq != 9 && gpio_irq != 12) {
> +		pr_warn("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);

You should error out at this point.

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

Since checks already exist in the code path, you can:

Remove this global variable.

> +		platform_device_unregister(tqmx86_pdev);

... and call this irrespectively.

> +	platform_driver_unregister(&tqmx86_driver);
> +}
> +
> +module_init(tqmx86_init);
> +module_exit(tqmx86_exit);
> +
> +MODULE_DESCRIPTION("TQx86 PLD Core Driver");
> +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tqmx86");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
