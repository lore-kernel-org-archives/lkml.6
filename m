Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9715EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDEE2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ldtxWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDEE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIKMwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 08:52:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbeIKMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 08:52:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so11842116pgv.1;
        Tue, 11 Sep 2018 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=daecxY1YM1tr4S+ALNgPViSDYb4Mv3yN/61GYTSlGKQ=;
        b=N6ldtxWh/gfYwgFMU65drOMmppIZh13hyNq2VgdEV02NNwq/f0DSUgu2G0XEjhp0IZ
         JpU6PA/mvennzMFIy5Aw5b3o0Hp9UzDwbTr8FPcUa4WvciTY+o3DJWxSRbHCaQQfZ+Gr
         zb1XhFI3tXVm6qgEp9IU9YEPcNdTHV1/+j+GHGxpSlfIWVfmhgwcrkc9NB/GamgNFDdd
         SWKYM1uLQ3kBWoQT2p4nnQ4egt8kt8PY2O47SQzMa0F0UNi/qD14m1ABCkDSnyfSm8t1
         xVg8D4bLleWySu0+89fkqWteEie1V4feHJGKbngmb72Os3cmZtjQZjXk28KX1B8HIxmb
         ow/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=daecxY1YM1tr4S+ALNgPViSDYb4Mv3yN/61GYTSlGKQ=;
        b=FShId+ZijByaR49Hs/ozzRcv2HbxM8i1CocQgJZc7BErI+qeBzsNoxzXCM5egycRRM
         hh7jubm06pe8OgluZiG5ah/Tce6Fv5aekKGAh7kNoDRWKDv0tWBhZlutb1aRUfvTsKX7
         zzbj+jJTY2KgxkZB6fPOnM/XiAt7qDGm5/XGxWk6tpNBCs8RZhc1vSY6nB+kXewUrXGP
         tHxf1k5thtWbyf435LvJx/XJNGCGSSc96BTUNg48gdEgFhgwNBPqw1sc/fXpqlPuE72Z
         n6tM4OUBg4/d0rDpL4ChEP8Q6iTU6zOC97hkLg8ulOKLW6krbLshlj1em6IpTgH3F4Mb
         X63g==
X-Gm-Message-State: APzg51B8aGkMEP1+G/AfWXAavdtT6e2hb8IoYLzHbu2eM/1aetIDm/9z
        w/0+gUW91YCa1UxtC1A4WQI=
X-Google-Smtp-Source: ANB0VdaBX1Zve09Jb+71oMITwW7KUxZbVEQT1akQTco4+k+FySQmSyZoDZks6bJucSI9cLInwyWbFA==
X-Received: by 2002:a62:848e:: with SMTP id k136-v6mr27885621pfd.231.1536652443408;
        Tue, 11 Sep 2018 00:54:03 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u11-v6sm29825008pfd.117.2018.09.11.00.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 00:54:02 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        ak@it-klinger.de, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH v2] iio: proximity: Add driver support for ST's VL53L0X ToF ranging sensor.
Date:   Tue, 11 Sep 2018 15:53:57 +0800
Message-Id: <20180911075357.8187-1-songqiang.1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was originally written by ST in 2016 as a misc input device
driver, and hasn't been maintained for a long time. I grabbed some code
from it's API and reformed it into a iio proximity device driver.
This version of driver uses i2c bus to talk to the sensor and
polling for measuring completes, so no irq line is needed.
This version of driver supports only one-shot mode, and it can be
tested with reading from
/sys/bus/iio/devices/iio:deviceX/in_distance_raw

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
 drivers/iio/proximity/Kconfig                 |  11 +
 drivers/iio/proximity/Makefile                |   2 +
 drivers/iio/proximity/vl53l0x-i2c.c           | 196 ++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
 create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c

diff --git a/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
new file mode 100644
index 000000000000..64b69442f08e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
@@ -0,0 +1,12 @@
+ST's VL53L0X ToF ranging sensor
+
+Required properties:
+	- compatible: must be "st,vl53l0x-i2c"
+	- reg: i2c address where to find the device
+
+Example:
+
+vl53l0x@29 {
+	compatible = "st,vl53l0x-i2c";
+	reg = <0x29>;
+};
diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index f726f9427602..5f421cbd37f3 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -79,4 +79,15 @@ config SRF08
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
 
+config VL53L0X_I2C
+	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
+	depends on I2C
+	help
+	  Say Y here to build a driver for STMicroelectronics VL53L0X
+	  ToF ranger sensors with i2c interface.
+	  This driver can be used to measure the distance of objects.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vl53l0x-i2c.
+
 endmenu
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index 4f4ed45e87ef..dedfb5bf3475 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
+obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
+
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
new file mode 100644
index 000000000000..4eac40353494
--- /dev/null
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  Support for ST's VL53L0X FlightSense ToF Ranger Sensor on a i2c bus.
+ *
+ *  Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#define VL53L0X_DRV_NAME				"vl53l0x-i2c"
+
+#define VL_REG_SYSRANGE_START				0x00
+#define VL_REG_SYSRANGE_MODE_MASK			GENMASK(3, 0)
+#define VL_REG_SYSRANGE_MODE_START_STOP			BIT(0)
+#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
+#define VL_REG_SYSRANGE_MODE_BACKTOBACK			BIT(1)
+#define VL_REG_SYSRANGE_MODE_TIMED			BIT(2)
+#define VL_REG_SYSRANGE_MODE_HISTOGRAM			BIT(3)
+
+#define VL_REG_SYS_SEQUENCE_CFG				BIT(0)
+#define VL_REG_SYS_RANGE_CFG				0x09
+#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		BIT(2)
+
+#define VL_REG_SYS_INT_CFG_GPIO				0x0A
+#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
+#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			BIT(0)
+#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			BIT(1)
+#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY		BIT(2)
+#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
+#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x84
+#define VL_REG_SYS_INT_CLEAR				0x0B
+
+#define VL_REG_RESULT_INT_STATUS			0x13
+#define VL_REG_RESULT_RANGE_STATUS			0x14
+#define VL_REG_RESULT_RANGE_SATTUS_COMPLETE		BIT(0)
+
+#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS			0x8a
+
+#define VL_REG_IDENTIFICATION_MODEL_ID			0xc0
+#define VL_REG_IDENTIFICATION_REVISION_ID		0xc2
+
+struct vl53l0x_data {
+	struct i2c_client *client;
+	struct iio_dev *indio_dev;
+};
+
+static int vl53l0x_read_proximity(struct vl53l0x_data *data,
+				  const struct iio_chan_spec *chan,
+				  int *val)
+{
+	u8 write_command = VL_REG_RESULT_RANGE_STATUS;
+	struct i2c_client *client = data->client;
+	unsigned int tries = 20;
+	struct i2c_msg msg[2];
+	u8 buffer[12];
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSRANGE_START, 1);
+	if (ret < 0)
+		return ret;
+
+	do {
+		ret = i2c_smbus_read_byte_data(data->client,
+					       VL_REG_RESULT_RANGE_STATUS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & VL_REG_RESULT_RANGE_SATTUS_COMPLETE)
+			break;
+
+		usleep_range(1000, 5000);
+	} while (tries--);
+	if (!tries)
+		return -ETIMEDOUT;
+
+	msg[0].addr = client->addr;
+	msg[0].buf = &write_command;
+	msg[0].len = 1;
+	msg[0].flags = client->flags | I2C_M_STOP;
+
+	msg[1].addr = client->addr;
+	msg[1].buf = buffer;
+	msg[1].len = 12;
+	msg[1].flags = client->flags | I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+	else if (ret != 2)
+		dev_err(&data->client->dev, "vl53l0x: consecutively read error. ");
+
+	*val = __le16_to_cpu((buffer[10] << 8) + buffer[11]);
+
+	return 0;
+}
+
+static const struct iio_chan_spec vl53l0x_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static int vl53l0x_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_DISTANCE) {
+		dev_err(&data->client->dev, "vl53l0x: iio type error");
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = vl53l0x_read_proximity(data, chan, val);
+		if (ret < 0)
+			dev_err(&data->client->dev,
+				"vl53l0x: raw value read error with %d", ret);
+
+		ret = IIO_VAL_INT;
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		dev_err(&data->client->dev, "vl53l0x: IIO_CHAN_* not recognzed.");
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vl53l0x_info = {
+	.read_raw = vl53l0x_read_raw,
+};
+
+static int vl53l0x_probe(struct i2c_client *client)
+{
+	struct vl53l0x_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->indio_dev = indio_dev;
+	i2c_set_clientdata(client, indio_dev);
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = VL53L0X_DRV_NAME;
+	indio_dev->info = &vl53l0x_info;
+	indio_dev->channels = vl53l0x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id st_vl53l0x_dt_match[] = {
+	{ .compatible = "st,vl53l0x-i2c", },
+	{ }
+};
+
+static struct i2c_driver vl53l0x_driver = {
+	.driver = {
+		.name = VL53L0X_DRV_NAME,
+		.of_match_table = st_vl53l0x_dt_match,
+	},
+	.probe_new = vl53l0x_probe,
+};
+module_i2c_driver(vl53l0x_driver);
+
+MODULE_AUTHOR("Song Qiang <songqiang.1304521@gmail.com>");
+MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor");
+MODULE_LICENSE("GPL");
-- 
2.17.1

