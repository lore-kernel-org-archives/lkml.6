Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3E2C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B0420837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 04:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT9Y3q7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B0420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLIEn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 23:43:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36559 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbeLIEn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 23:43:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so3798395pfc.3;
        Sat, 08 Dec 2018 20:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4l81ngqXSsjUYp1RLzoGA1db5r9aTVc0Yb/XDJyvLes=;
        b=UT9Y3q7YiL6s7da7TbO9aM3hVTL88UCS3A6JmD5Zk4Tj3Z/wKpT9nWJqc4kACSgPsM
         I7f1C81CXzcAHewSmkNb6acMzmddOXoHmrKCf4DjRZvPtSbd7rfhavBEz2+LhNTz0/pQ
         gMAA65Biz1H4+0EKHPk9AD4cI4OIAoljlGfbyWgU+YM65uLL5gMHImXgRiO41yYVhu2V
         sYQxF3bx5bEjqOZb7+g47rjVJNR1reciqgP9AB8h6TTM0lDBs3Hw8buPpwxCKVlcIPOp
         H40j1BdDIsbxFnW6zeNJhH2z37e0x8u67ncOoGEwkyARIk9bakBPu/Np2xK5xBxztAMt
         jBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4l81ngqXSsjUYp1RLzoGA1db5r9aTVc0Yb/XDJyvLes=;
        b=LtM3yyiKnp0pDdAZgVzcNQl8yZZVtTy9wmy0SasPN/SXWM3xXwi3dz9Fgd1VKHaioM
         lWwSdKdvxHxPMCgE1HjgF0l2VdasPi5FFY8gommqLV888g6IlTg0VdAn8j/RxmRj7qzb
         DQTl78Ktex/YCWOek0xLh3UWZGTVdJbdHuOdcIseL46mAk/DroCqqdRMLOQPATjW2te2
         kCXym+gdwezczUje2zSNyn9xSKB5D48ivpBly9gZH77jbEUmYkYs+e6PE4Ah08zMGF0h
         2MFbwbFUZkk4P/p1/GoEcLb1bC5yokvAvk+x7x3mN3/yB2DVWntg0Uai/L3Pk+fW6vqB
         SQ1w==
X-Gm-Message-State: AA+aEWa/TKO631N+8BAZ/9wQ8tzDOPwdTTghi04CkBvkg1XoWdewVBhf
        ZwCxy2oB3gmaC++ZPwP6MQI=
X-Google-Smtp-Source: AFSGD/VRry4um3ggt9RSwnXmdsv6AlU3HIdSODeHQqKnZYt7ZaDdthpaKnovoZhsDKHq8VMTziO/uQ==
X-Received: by 2002:aa7:87ce:: with SMTP id i14mr7862279pfo.20.1544330635678;
        Sat, 08 Dec 2018 20:43:55 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w5sm9806371pfn.89.2018.12.08.20.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 20:43:54 -0800 (PST)
Date:   Sat, 8 Dec 2018 20:43:52 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com,
        eric@anholt.net, agraf@suse.de,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Masanari Iida <standby24x7@gmail.com>,
        Zhu Yi <yi.zhu5@cn.bosch.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Heiko Schocher <hs@denx.de>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 1/2] input: add official Raspberry Pi's 7"
 touchscreen driver
Message-ID: <20181209044352.GE211094@dtor-ws>
References: <20181205220902.27682-1-nsaenzjulienne@suse.de>
 <20181205220902.27682-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205220902.27682-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Wed, Dec 05, 2018 at 11:09:03PM +0100, Nicolas Saenz Julienne wrote:
> Adds support to Raspberry Pi's 7" touchscreen device. Instead of using
> a conventional bus all information is copied into a memory mapped area
> by RPi's VC4 firmware.
> 
> Based on the driver found in RPi's downstream kernel repository.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/input/touchscreen/Kconfig          |  12 +
>  drivers/input/touchscreen/Makefile         |   1 +
>  drivers/input/touchscreen/raspberrypi-ts.c | 252 +++++++++++++++++++++
>  3 files changed, 265 insertions(+)
>  create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 2a80675cfd94..8d0fcb3dc8a8 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -696,6 +696,18 @@ config TOUCHSCREEN_EDT_FT5X06
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called edt-ft5x06.
>  
> +config TOUCHSCREEN_RASPBERRYPI_TS
> +	tristate "Raspberry Pi's firmware base touch screen support"
> +	depends on OF

I think "depends on ASPBERRYPI_FIRMWARE || COMPILE_TEST" is more
precise dependency.

> +	help
> +	  Say Y here if you have the official Raspberry Pi 7' touchscren
> +	  connected on your system.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called raspberrypi-ts.
> +
>  config TOUCHSCREEN_MIGOR
>  	tristate "Renesas MIGO-R touchscreen"
>  	depends on (SH_MIGOR || COMPILE_TEST) && I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 5911a4190cd2..3eccb1925e89 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -109,3 +109,4 @@ obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
>  obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
>  obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
> +obj-$(CONFIG_TOUCHSCREEN_RASPBERRYPI_TS)	+= raspberrypi-ts.o
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> new file mode 100644
> index 000000000000..9d29411a5674
> --- /dev/null
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -0,0 +1,252 @@
> +/*
> + * Raspberry Pi 3 firmware based touchscreen driver
> + *
> + * Copyright (C) 2015, 2017 Raspberry Pi
> + * Copyright (C) 2018 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Please use SPDX tag for the license.

> + */
> +
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define RPI_TS_DEFAULT_WIDTH	800
> +#define RPI_TS_DEFAULT_HEIGHT	480
> +
> +#define RPI_TS_MAX_SUPPORTED_POINTS	10
> +
> +#define RPI_TS_FTS_TOUCH_DOWN		0
> +#define RPI_TS_FTS_TOUCH_CONTACT	2
> +
> +struct rpi_ts {
> +	struct input_dev *input;

Since the only way is to poll, please use polled input device instead of
standard one. It will take care of scheduling polling, stopping it when
needed, etc.

> +	struct touchscreen_properties prop;
> +
> +	void __iomem *ts_base;
> +	dma_addr_t bus_addr;
> +
> +	struct delayed_work work;
> +	int known_ids;
> +};
> +
> +struct rpi_ts_regs {
> +	uint8_t device_mode;
> +	uint8_t gesture_id;
> +	uint8_t num_points;

Simply u8 in kernel.

> +	struct rpi_ts_touch {
> +		uint8_t xh;
> +		uint8_t xl;
> +		uint8_t yh;
> +		uint8_t yl;
> +		uint8_t pressure; /* Not supported */
> +		uint8_t area;     /* Not supported */
> +	} point[RPI_TS_MAX_SUPPORTED_POINTS];
> +};
> +
> +/*
> + * This process polls the memory based register copy of the touch screen chip
> + * registers using the number of points register to know whether the copy has
> + * been updated (we write 99 to the memory copy, the GPU will write between 0 -
> + * 10 points)
> + */
> +static void rpi_ts_work(struct work_struct *work)
> +{
> +	struct rpi_ts *ts = container_of(work, struct rpi_ts, work.work);
> +	struct input_dev *input = ts->input;
> +	struct rpi_ts_regs regs;
> +	int modified_ids = 0;
> +	int released_ids;
> +	int event_type;
> +	int touchid;
> +	int x, y;
> +	int i;
> +
> +	memcpy_fromio(&regs, ts->ts_base, sizeof(struct rpi_ts_regs));
> +	iowrite8(99, ts->ts_base + offsetof(struct rpi_ts_regs, num_points));
> +
> +	if (regs.num_points == 99 ||
> +	    (regs.num_points == 0 && ts->known_ids == 0))
> +	    goto out;
> +
> +	for (i = 0; i < regs.num_points; i++) {
> +		x = (((int)regs.point[i].xh & 0xf) << 8) + regs.point[i].xl;
> +		y = (((int)regs.point[i].yh & 0xf) << 8) + regs.point[i].yl;
> +		touchid = (regs.point[i].yh >> 4) & 0xf;
> +		event_type = (regs.point[i].xh >> 6) & 0x03;
> +
> +		modified_ids |= BIT(touchid);
> +
> +		if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
> +		    event_type == RPI_TS_FTS_TOUCH_CONTACT) {
> +			input_mt_slot(input, touchid);
> +			input_mt_report_slot_state(input, MT_TOOL_FINGER, 1);
> +			touchscreen_report_pos(input, &ts->prop, x, y, true);
> +		}
> +	}
> +
> +	released_ids = ts->known_ids & ~modified_ids;
> +	for (i = 0; released_ids && i < RPI_TS_MAX_SUPPORTED_POINTS; i++) {

If you make released_ids long instead of int you can use
for_each_set_bit() here.

> +		if (released_ids & BIT(i)) {
> +			input_mt_slot(input, i);
> +			input_mt_report_slot_state(input, MT_TOOL_FINGER, 0);
> +			modified_ids &= ~(BIT(i));
> +		}
> +	}
> +	ts->known_ids = modified_ids;
> +
> +	input_mt_report_pointer_emulation(ts->input, true);

input_mt_sync_frame() and then you would not need to call
input_mt_report_pointer_emulation() if you passed right flags to
input_mt_init_slots().

> +	input_sync(ts->input);
> +
> +out:
> +	schedule_delayed_work(&ts->work, msecs_to_jiffies(17)); /* 60 fps */
> +}
> +
> +static int rpi_ts_open(struct input_dev *dev)
> +{
> +	struct rpi_ts *ts = input_get_drvdata(dev);
> +
> +	schedule_delayed_work(&ts->work, 0);
> +
> +	return 0;
> +}
> +
> +static void rpi_ts_close(struct input_dev *dev)
> +{
> +	struct rpi_ts *ts = input_get_drvdata(dev);
> +
> +	cancel_delayed_work_sync(&ts->work);
> +}

Not needed if using polled input device.

> +
> +static int rpi_ts_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *fw_node;
> +	struct input_dev *input;
> +	struct rpi_firmware *fw;
> +	struct rpi_ts *ts;
> +	u32 touchbuf;
> +	int err = 0;
> +
> +	fw_node = of_get_parent(np);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	fw = rpi_firmware_get(fw_node);

You are leaking node here I believe. Stick of_node_put() after
rpi_firmware_get() and before "if".

> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	ts = devm_kzalloc(dev, sizeof(struct rpi_ts), GFP_KERNEL);

sizeof(*ts)

> +	if (!ts) {
> +		dev_err(dev, "Failed to allocate memory\n");
> +		return -ENOMEM;
> +	}
> +
> +	input = input_allocate_device();

devm.

> +	if (!input) {
> +		dev_err(dev, "Failed to allocate input device\n");
> +		return -ENOMEM;
> +	}
> +	ts->input = input;
> +
> +	ts->ts_base = dma_zalloc_coherent(dev, PAGE_SIZE, &ts->bus_addr,
> +					  GFP_KERNEL);
> +	if (!ts->ts_base) {
> +		dev_err(dev, "failed to dma_alloc_coherent\n");
> +		err = -ENOMEM;
> +		goto undegister_input_device;
> +	}
> +
> +	touchbuf = (u32)ts->bus_addr;
> +	err = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
> +				    &touchbuf, sizeof(touchbuf));
> +
> +	if (err || touchbuf != 0) {
> +		dev_warn(dev, "Failed to set touchbuf, trying to get err:%x\n",
> +			 err);
> +		goto clean_dma_buf;
> +	}
> +
> +	INIT_DELAYED_WORK(&ts->work, rpi_ts_work);
> +	platform_set_drvdata(pdev, ts);
> +
> +	input->name = "raspberrypi-ts";
> +	input->id.bustype = BUS_HOST;
> +	input->open = rpi_ts_open;
> +	input->close = rpi_ts_close;
> +	input->dev.parent = &pdev->dev;
> +
> +	__set_bit(EV_KEY, input->evbit);
> +	__set_bit(EV_SYN, input->evbit);
> +	__set_bit(EV_ABS, input->evbit);
> +
> +	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> +			     RPI_TS_DEFAULT_WIDTH, 0, 0);
> +	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
> +			     RPI_TS_DEFAULT_HEIGHT, 0, 0);
> +	touchscreen_parse_properties(input, true, &ts->prop);
> +
> +	input_mt_init_slots(input, RPI_TS_MAX_SUPPORTED_POINTS,
> +			    INPUT_MT_DIRECT);
> +
> +	input_set_drvdata(input, ts);
> +
> +	err = input_register_device(input);
> +	if (err) {
> +		dev_err(dev, "could not register input device, %d\n",
> +			err);
> +		goto clean_dma_buf;
> +	}
> +	return 0;
> +
> +clean_dma_buf:
> +	dma_free_coherent(dev, PAGE_SIZE, ts->ts_base, ts->bus_addr);

I wild make freeing this area a devm custom action
(devm_add_action_or_reset). Then you can get rid of rpi_ts_remove().

> +undegister_input_device:
> +	input_unregister_device(ts->input);
> +
> +	return err;
> +}
> +
> +static int rpi_ts_remove(struct platform_device *pdev)
> +{
> +	struct rpi_ts *ts = (struct rpi_ts *)platform_get_drvdata(pdev);
> +
> +	input_unregister_device(ts->input);
> +	dma_free_coherent(&pdev->dev, PAGE_SIZE, ts->ts_base, ts->bus_addr);
> +	return 0;
> +}
> +
> +static const struct of_device_id rpi_ts_match[] = {
> +	{ .compatible = "raspberrypi,firmware-ts", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rpi_ts_match);
> +
> +static struct platform_driver rpi_ts_driver = {
> +	.driver = {
> +		.name   = "raspberrypi-ts",
> +		.owner  = THIS_MODULE,

I am pretty sure we no longer need to set owner explicitly.

> +		.of_match_table = rpi_ts_match,
> +	},
> +	.probe          = rpi_ts_probe,
> +	.remove         = rpi_ts_remove,
> +};
> +
> +module_platform_driver(rpi_ts_driver);
> +
> +MODULE_AUTHOR("Gordon Hollingworth");
> +MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
> +MODULE_DESCRIPTION("Raspberry Pi 3 firmware based touchscreen driver");
> +MODULE_LICENSE("GPL");

This should be "GPL v2" to math the license notice at the top of the
file.

Thanks.

-- 
Dmitry
