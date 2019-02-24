Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4699C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44EE206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 16:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfBXQXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 11:23:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:33061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfBXQXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 11:23:38 -0500
Received: from localhost ([2.174.161.193]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MplTn-1hNR4Q2Uov-00q9Hm; Sun, 24 Feb 2019 17:23:07 +0100
Date:   Sun, 24 Feb 2019 17:23:04 +0100
From:   Andreas Klinger <ak@it-klinger.de>
To:     afaerber@suse.de, arnd@arndb.de, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        jic23@kernel.org, johan@kernel.org, khilman@baylibre.com,
        knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        martin.blumenstingl@googlemail.com, mchehab+samsung@kernel.org,
        m.othacehe@gmail.com, nicolas.ferre@microchip.com,
        pmeerw@pmeerw.net, robh+dt@kernel.org, robh@kernel.org,
        songqiang1304521@gmail.com, treding@nvidia.com
Subject: [PATCH 3/4] mb12x2.c: add mb12x2 ultrasonic distance iio sensor
Message-ID: <20190224162302.hnxmnaburoo4llk7@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:WYgk4a/Q8BkIXKa19Yo5JuN25K2Sq4zL29pCm8D0D0Pz6fdH7jE
 pozT6fQFqjxQ2H2zYiQ1TEG+KRNV2Rt52u5n/0cMM0LUfArADZMd6SGTErvvnzpTxXD/1VG
 0vcpOLaWkL4KKc0ygumBkwdGexHRKxSqjpilBzc79BMgNpuvly/FB+DzT7a9ggKcM4fIXad
 +ZJUAJH9xWG0vfvm6fN+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LrmrWHxnC0M=:0EV8cMqtwxk/PF0IRbVZfz
 HWPa3fW/vj3xjghBZGv4SuPsfGRDil8aUzT0p7DWhXQktHK2Yx6it3Y/3wIQ0LyLn+NryHNpa
 LXmS15dAKdlEcrS8LjkSE/XGAHU5tM4bbt8O/A1lMxHx7pE8bfxdCvGMjxp7CH5KT1i7Y5jP2
 QikKc266o9m/gdYD+uO4QrfQF1n5vC/XLXiucBw87lELlXe6G3y+fRK+Bctcod3FZpNt0nnvT
 SQrBsxAVcuU5tSjtff9GQdYyf9e5KkQhZXHf2Nm6QWreT4WaDmRirhZJ/hBMAcJQ2Oz3FEkYZ
 sg38CmTAc9sd4WfNo35tsykUi7oTuzqPp6v1XnsRiSz1MDv8ohCADedCqCaGSfrqAj8iifWU8
 efJZoFZu0UDH56KQ75H0ZP15XIVQB7YI7f/XaYLBJTUxCYlwScSOOUymDEdEJzQuPJPa2htT/
 gY+0m9WUWGExqYGJVzOQXk2NJw0r6FlzzMeOfI9GqWCtRKuk2Ia9dsdvuV+0R+J2ukISNGCcJ
 wFtz/RImly+jQ/tlVhJcGHb0oaxeL9VdOXdl4H4qJ0CO+naTDkG+A/IXNGgPmEclj/z1rZzXp
 j0vcduyshFI7apOgPvx3AAg3HQLFQLowjt/0b10xUdZjzfDjHpFjL2NYdjXTlJrz8rItj9yZl
 6KHP9JjcMAG10NCGsAk2PIpi7uM0kCMTF38D0FnLu8qS14gAZVhtiibnoVwAGC3bwP/PhYTBI
 lJZT1JFNtX2bM9zK8bkFF9/rc/LeOuu/ftRt6g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MaxSonar-I2CXL ultrasonic distance sensors of type family mb12x2
using the i2c interface

Implemented functionality:
- reading the distance via in_distance_raw
- buffered mode with trigger
- make use of status gpio to announce completion of ranging

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/mb12x2.c | 283 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)
 create mode 100644 drivers/iio/proximity/mb12x2.c

diff --git a/drivers/iio/proximity/mb12x2.c b/drivers/iio/proximity/mb12x2.c
new file mode 100644
index 000000000000..0c052fde94b4
--- /dev/null
+++ b/drivers/iio/proximity/mb12x2.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * mb12x2.c - Support for I2CXL-MaxSonar-EZ series ultrasonic ranger with
+ *	i2c interface
+ * actually supported are mb12x2 types
+ *
+ * Copyright (c) 2019 Andreas Klinger <ak@it-klinger.de>
+ *
+ * For details about the device see:
+ * https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* registers of MaxSonar device */
+#define MB12X2_RANGE_COMMAND	0x51	/* Command for reading range */
+#define MB12X2_ADDR_UNLOCK_1	0xAA	/* Command 1 for changing address */
+#define MB12X2_ADDR_UNLOCK_2	0xA5	/* Command 2 for changing address */
+
+struct mb12x2_data {
+	struct i2c_client	*client;
+
+	struct mutex		lock;
+
+	/*
+	 * optionally a gpio can be used to announce when ranging has
+	 * finished
+	 */
+	struct completion	ranging;
+	struct gpio_desc	*gpiod_status;
+	int			irqnr;
+
+	/*
+	 * triggered buffer
+	 * 1x16-bit channel + 3x16 padding + 4x16 timestamp
+	 */
+	s16			buffer[8];
+};
+
+static irqreturn_t mb12x2_handle_irq(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct mb12x2_data *data = iio_priv(indio_dev);
+
+	/* double check to make sure data is now available */
+	if (!gpiod_get_value(data->gpiod_status))
+		complete(&data->ranging);
+
+	return IRQ_HANDLED;
+}
+
+static int mb12x2_read_distance(struct mb12x2_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+	int distance;
+	unsigned char buf[2];
+
+	mutex_lock(&data->lock);
+
+	reinit_completion(&data->ranging);
+
+	ret = i2c_smbus_write_byte(client, MB12X2_RANGE_COMMAND);
+	if (ret < 0) {
+		dev_err(&client->dev, "write command - err: %d\n", ret);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	if (data->gpiod_status) {
+		/* it cannot take more than 100 ms */
+		ret = wait_for_completion_killable_timeout(&data->ranging,
+								HZ/10);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		} else if (ret == 0) {
+			mutex_unlock(&data->lock);
+			return -ETIMEDOUT;
+		}
+	} else {
+		/*
+		 * use simple sleep if gpio announce pin is not connected
+		 */
+		msleep(15);
+	}
+
+
+	ret = i2c_master_recv(client, buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(&client->dev, "i2c_master_recv: ret=%d\n", ret);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	distance = buf[0]<<8 | buf[1];
+
+	mutex_unlock(&data->lock);
+
+	return distance;
+}
+
+static irqreturn_t mb12x2_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct mb12x2_data *data = iio_priv(indio_dev);
+	s16 sensor_data;
+
+	sensor_data = mb12x2_read_distance(data);
+	if (sensor_data < 0)
+		goto err;
+
+	mutex_lock(&data->lock);
+
+	data->buffer[0] = sensor_data;
+	iio_push_to_buffers_with_timestamp(indio_dev,
+						data->buffer, pf->timestamp);
+
+	mutex_unlock(&data->lock);
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int mb12x2_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *channel, int *val,
+			    int *val2, long mask)
+{
+	struct mb12x2_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (channel->type != IIO_DISTANCE)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = mb12x2_read_distance(data);
+		if (ret < 0)
+			return ret;
+		*val = ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* 1 LSB is 1 cm */
+		*val = 0;
+		*val2 = 10000;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec mb12x2_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.info_mask_separate =
+				BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(1),
+};
+
+static const struct iio_info mb12x2_info = {
+	.read_raw = mb12x2_read_raw,
+};
+
+static int mb12x2_probe(struct i2c_client *client,
+					 const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct mb12x2_data *data;
+	int ret;
+	struct device *dev = &client->dev;
+
+	if (!i2c_check_functionality(client->adapter,
+					I2C_FUNC_SMBUS_READ_BYTE |
+					I2C_FUNC_SMBUS_WRITE_BYTE))
+		return -ENODEV;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+
+	indio_dev->info = &mb12x2_info;
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = mb12x2_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mb12x2_channels);
+
+	mutex_init(&data->lock);
+
+	init_completion(&data->ranging);
+
+	data->gpiod_status = devm_gpiod_get(dev, "status", GPIOD_IN);
+	if (IS_ERR(data->gpiod_status)) {
+
+		if (PTR_ERR(data->gpiod_status) == -ENOENT) {
+
+			dev_warn(dev, "no status gpio --> use sleep instead\n");
+			data->gpiod_status = NULL;
+		} else {
+
+			dev_err(dev, "cannot setup gpio; err=%ld\n",
+					PTR_ERR(data->gpiod_status));
+			return PTR_ERR(data->gpiod_status);
+		}
+	}
+
+	if (data->gpiod_status) {
+
+		data->irqnr = gpiod_to_irq(data->gpiod_status);
+		if (data->irqnr < 0) {
+			dev_err(dev, "gpiod_to_irq: %d\n", data->irqnr);
+			return data->irqnr;
+		}
+
+		ret = devm_request_irq(dev, data->irqnr, mb12x2_handle_irq,
+				IRQF_TRIGGER_FALLING, id->name, indio_dev);
+		if (ret < 0) {
+			dev_err(dev, "request_irq: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+			iio_pollfunc_store_time, mb12x2_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(dev, "setup of iio triggered buffer failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id of_mb12x2_match[] = {
+	{ .compatible = "maxbotix,mb12x2", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_mb12x2_match);
+
+static const struct i2c_device_id mb12x2_id[] = {
+	{ "maxbotix-mb12x2", },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mb12x2_id);
+
+static struct i2c_driver mb12x2_driver = {
+	.driver = {
+		.name	= "maxbotix-mb12x2",
+		.of_match_table	= of_mb12x2_match,
+	},
+	.probe = mb12x2_probe,
+	.id_table = mb12x2_id,
+};
+module_i2c_driver(mb12x2_driver);
+
+MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
+MODULE_DESCRIPTION("Maxbotix I2CXL-MB12X2-EZ i2c ultrasonic ranger driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0
