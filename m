Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2C20883
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRnHYQ5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC2C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbeIJTiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:38:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40275 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbeIJTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:38:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so9840214plp.7;
        Mon, 10 Sep 2018 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YnG/NzNUioVqt6ZkuP3zYpBQrheHgNvGedtqhfphfzM=;
        b=dRnHYQ5B+yBTirwNpQIuyjUAYCiGAjsFhMuU9bRKP6LXLhQVbyS239ThIDdI3glwy3
         A3hPA4LjIrOP+EqApnDRnmw4eIGtIgJJ37hGndPqzV4gnspdlI42XszCa4VZMhNm9F+0
         vJaRxeDFD19eyEjL8cmDbOOefbtyCQh7db2KmS7TTG8L8xtKbOa3mT6BeEemAZH6X8cr
         m8Qj7Qx53ccQmB4v5JzCpEJ81pdoDOygXx5PQpzNTVBpvoLDNGVLRdDRNNt3gTfYCo1t
         0RP9NjZG/KDG25Bk2a+KsXCMYJ4ZgN5D4jgNsbEr9r4T9AelK2XElMNdssdEXw/poQ7D
         dF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YnG/NzNUioVqt6ZkuP3zYpBQrheHgNvGedtqhfphfzM=;
        b=FNwKjWnH2p+ZtYYYVNdmlvsJq8CnZC5W4fzzgSF19w0bXwBjWUtSQsH2NzzYn2vdNw
         68XgenQcQDjOSeab43znW0VokAOqzLl0GHtA17QwxaettADjRetmRbCyUpu55PXUHdhx
         Sr98AHnQdxI4dfmftMhlVBUwwxW7LByuk3XZKa+bcqdcSirlL6OBiZqt7Y+hQrmHNcJ1
         Led7SGqau5/IFNYJz0p0UMjcO5ntY+JWG84RrVh3MDLz7dKGQCFjhjBt5kpqQdgDqAXm
         GUPTFTqH09dIWUfSmbEPz8/xi6xlej3ZtSAYb5BjoFR/1V3emhXZcMW8bPfbE1trqGT8
         rdfA==
X-Gm-Message-State: APzg51CZvoi1XUbK7x4M5WctxwHRIGUnzLs2jyas/yi88thAG353vmEf
        ieDGL0j1yGahPsaMeA0cT/Q=
X-Google-Smtp-Source: ANB0VdanE0JR6EsX++M8t7n1TzU22MKJ+7Vxju7AQbYrC90D2gd10pbTkAa6utwStfwHHk4rdQwT9Q==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4-v6mr5512365plt.50.1536590628969;
        Mon, 10 Sep 2018 07:43:48 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u83-v6sm49740134pfj.37.2018.09.10.07.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 07:43:48 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        robh@kernel.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] iio: proximity: Add driver support for ST's VL53L0X ToF ranging sensor.
Date:   Mon, 10 Sep 2018 22:42:59 +0800
Message-Id: <20180910144259.1339-1-songqiang.1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver was originally written by ST in 2016 as a misc input device,
and hasn't been maintained for a long time. I grabbed some code from
it's API and reformed it to a iio proximity device driver.
This version of driver uses i2c bus to talk to the sensor and
polling for measuring completes, so no irq line is needed.
This version of driver supports only one-shot mode, and it can be
tested with reading from
/sys/bus/iio/devices/iio:deviceX/in_distance_raw

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 .../bindings/iio/proximity/vl53l0x.txt        |  12 +
 drivers/iio/proximity/Kconfig                 |  13 +
 drivers/iio/proximity/Makefile                |   2 +
 drivers/iio/proximity/vl53l0x-i2c.c           | 295 ++++++++++++++++++
 4 files changed, 322 insertions(+)
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
index f726f9427602..1563a5f9144d 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -79,4 +79,17 @@ config SRF08
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf08.
 
+config VL53L0X_I2C
+	tristate "STMicroelectronics VL53L0X ToF ranger sensor (I2C)"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
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
index 4f4ed45e87ef..7cb771665c8b 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
+obj-$(CONFIG_VL53L0X_I2C)		+= vl53l0x-i2c.o
+
diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
new file mode 100644
index 000000000000..c00713041d30
--- /dev/null
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  vl53l0x-i2c.c - Support for STM VL53L0X FlightSense TOF
+ *					Ranger Sensor on a i2c bus.
+ *
+ *  Copyright (C) 2016 STMicroelectronics Imaging Division.
+ *  Copyright (C) 2018 Song Qiang <songqiang.1304521@gmail.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/iio/iio.h>
+
+#define VL53L0X_DRV_NAME			"vl53l0x"
+
+/* Device register map */
+#define VL_REG_SYSRANGE_START					0x000
+#define VL_REG_SYSRANGE_MODE_MASK				0x0F
+#define VL_REG_SYSRANGE_MODE_START_STOP			0x01
+#define VL_REG_SYSRANGE_MODE_SINGLESHOT			0x00
+#define VL_REG_SYSRANGE_MODE_BACKTOBACK			0x02
+#define VL_REG_SYSRANGE_MODE_TIMED				0x04
+#define VL_REG_SYSRANGE_MODE_HISTOGRAM			0x08
+
+#define VL_REG_SYS_THRESH_HIGH					0x000C
+#define VL_REG_SYS_THRESH_LOW					0x000E
+
+#define VL_REG_SYS_SEQUENCE_CFG					0x0001
+#define VL_REG_SYS_RANGE_CFG					0x0009
+#define VL_REG_SYS_INTERMEASUREMENT_PERIOD		0x0004
+
+#define VL_REG_SYS_INT_CFG_GPIO					0x000A
+#define VL_REG_SYS_INT_GPIO_DISABLED			0x00
+#define VL_REG_SYS_INT_GPIO_LEVEL_LOW			0x01
+#define VL_REG_SYS_INT_GPIO_LEVEL_HIGH			0x02
+#define VL_REG_SYS_INT_GPIO_OUT_OF_WINDOW		0x03
+#define VL_REG_SYS_INT_GPIO_NEW_SAMPLE_READY	0x04
+#define VL_REG_GPIO_HV_MUX_ACTIVE_HIGH			0x0084
+#define VL_REG_SYS_INT_CLEAR					0x000B
+
+/* Result registers */
+#define VL_REG_RESULT_INT_STATUS				0x0013
+#define VL_REG_RESULT_RANGE_STATUS				0x0014
+
+#define VL_REG_RESULT_CORE_PAGE  1
+#define VL_REG_RESULT_CORE_AMBIENT_WINDOW_EVENTS_RTN	0x00BC
+#define VL_REG_RESULT_CORE_RANGING_TOTAL_EVENTS_RTN		0x00C0
+#define VL_REG_RESULT_CORE_AMBIENT_WINDOW_EVENTS_REF	0x00D0
+#define VL_REG_RESULT_CORE_RANGING_TOTAL_EVENTS_REF		0x00D4
+#define VL_REG_RESULT_PEAK_SIGNAL_RATE_REF				0x00B6
+
+/* Algo register */
+#define VL_REG_ALGO_PART_TO_PART_RANGE_OFFSET_MM		0x0028
+
+#define VL_REG_I2C_SLAVE_DEVICE_ADDRESS					0x008a
+
+/* Check Limit registers */
+#define VL_REG_MSRC_CFG_CONTROL						0x0060
+
+#define VL_REG_PRE_RANGE_CFG_MIN_SNR					0X0027
+#define VL_REG_PRE_RANGE_CFG_VALID_PHASE_LOW			0x0056
+#define VL_REG_PRE_RANGE_CFG_VALID_PHASE_HIGH			0x0057
+#define VL_REG_PRE_RANGE_MIN_COUNT_RATE_RTN_LIMIT		0x0064
+
+#define VL_REG_FINAL_RANGE_CFG_MIN_SNR					0X0067
+#define VL_REG_FINAL_RANGE_CFG_VALID_PHASE_LOW			0x0047
+#define VL_REG_FINAL_RANGE_CFG_VALID_PHASE_HIGH			0x0048
+#define VL_REG_FINAL_RANGE_CFG_MIN_COUNT_RATE_RTN_LIMIT	0x0044
+
+#define VL_REG_PRE_RANGE_CFG_SIGMA_THRESH_HI			0X0061
+#define VL_REG_PRE_RANGE_CFG_SIGMA_THRESH_LO			0X0062
+
+/* PRE RANGE registers */
+#define VL_REG_PRE_RANGE_CFG_VCSEL_PERIOD				0x0050
+#define VL_REG_PRE_RANGE_CFG_TIMEOUT_MACROP_HI			0x0051
+#define VL_REG_PRE_RANGE_CFG_TIMEOUT_MACROP_LO			0x0052
+
+#define VL_REG_SYS_HISTOGRAM_BIN					0x0081
+#define VL_REG_HISTOGRAM_CFG_INITIAL_PHASE_SELECT		0x0033
+#define VL_REG_HISTOGRAM_CFG_READOUT_CTRL				0x0055
+
+#define VL_REG_FINAL_RANGE_CFG_VCSEL_PERIOD				0x0070
+#define VL_REG_FINAL_RANGE_CFG_TIMEOUT_MACROP_HI		0x0071
+#define VL_REG_FINAL_RANGE_CFG_TIMEOUT_MACROP_LO		0x0072
+#define VL_REG_CROSSTALK_COMPENSATION_PEAK_RATE_MCPS	0x0020
+
+#define VL_REG_MSRC_CFG_TIMEOUT_MACROP					0x0046
+
+#define VL_REG_SOFT_RESET_GO2_SOFT_RESET_N				0x00bf
+#define VL_REG_IDENTIFICATION_MODEL_ID					0x00c0
+#define VL_REG_IDENTIFICATION_REVISION_ID				0x00c2
+
+#define VL_REG_OSC_CALIBRATE_VAL					0x00f8
+
+#define VL_SIGMA_ESTIMATE_MAX_VALUE					65535
+/* equivalent to a range sigma of 655.35mm */
+
+#define VL_REG_GLOBAL_CFG_VCSEL_WIDTH					0x032
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_0			0x0B0
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_1			0x0B1
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_2			0x0B2
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_3			0x0B3
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_4			0x0B4
+#define VL_REG_GLOBAL_CFG_SPAD_ENABLES_REF_5			0x0B5
+#define VL_REG_GLOBAL_CFG_REF_EN_START_SELECT			0xB6
+#define VL_REG_DYNAMIC_SPAD_NUM_REQUESTED_REF_SPAD		0x4E /* 0x14E */
+#define VL_REG_DYNAMIC_SPAD_REF_EN_START_OFFSET			0x4F /* 0x14F */
+#define VL_REG_POWER_MANAGEMENT_GO1_POWER_FORCE			0x80
+
+/*
+ * Speed of light in um per 1E-10 Seconds
+ */
+#define VL_SPEED_OF_LIGHT_IN_AIR					2997
+#define VL_REG_VHV_CFG_PAD_SCL_SDA__EXTSUP_HV			0x0089
+#define VL_REG_ALGO_PHASECAL_LIM			0x0030 /* 0x130 */
+#define VL_REG_ALGO_PHASECAL_CFG_TIMEOUT				0x0030
+
+struct vl53l0x_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	int	useLongRange;
+};
+
+static int vl53l0x_read_proximity(struct vl53l0x_data *data,
+				const struct iio_chan_spec *chan,
+				int *val)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	int tries = 20;
+	u8 buffer[12];
+	struct i2c_msg msg[2];
+	u8 write_command = VL_REG_RESULT_RANGE_STATUS;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+					VL_REG_SYSRANGE_START, 1);
+	if (ret < 0)
+		return ret;
+
+	while (tries-- > 0) {
+		ret = i2c_smbus_read_byte_data(data->client,
+						VL_REG_RESULT_RANGE_STATUS);
+		if (ret < 0)
+			return ret;
+
+		if (ret & 0x01)
+			break;
+		usleep_range(1000, 5000);
+	}
+
+	if (tries < 0)
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
+
+	if (ret != 2) {
+		pr_err("vl53l0x: consecutively read error. ");
+		return ret;
+	}
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
+				const struct iio_chan_spec *chan,
+				int *val, int *val2, long mask)
+{
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_DISTANCE) {
+		pr_err("vl53l0x: iio type error");
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
+			pr_err("vl53l0x: raw value read error with %d", ret);
+
+		ret = IIO_VAL_INT;
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		pr_err("vl53l0x: IIO_CHAN_* not recognzed.");
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info vl53l0x_info = {
+	.read_raw = vl53l0x_read_raw,
+};
+
+static int vl53l0x_probe(struct i2c_client *client,
+				   const struct i2c_device_id *id)
+{
+	int ret;
+	struct vl53l0x_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&data->lock);
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE))
+		return -EOPNOTSUPP;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = VL53L0X_DRV_NAME;
+	indio_dev->info = &vl53l0x_info;
+	indio_dev->channels = vl53l0x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(vl53l0x_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	//probe 0xc0 if the value is 0xEE.
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&client->dev, data);
+
+	return 0;
+}
+
+static int vl53l0x_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct vl53l0x_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id vl53l0x_id[] = {
+	{ VL53L0X_DRV_NAME, 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
+
+static const struct of_device_id st_vl53l0x_dt_match[] = {
+	{ .compatible = "st,vl53l0x-i2c", },
+	{ },
+};
+
+static struct i2c_driver vl53l0x_driver = {
+	.driver = {
+		.name	= VL53L0X_DRV_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = st_vl53l0x_dt_match,
+	},
+	.probe	= vl53l0x_probe,
+	.remove	= vl53l0x_remove,
+	.id_table = vl53l0x_id,
+};
+module_i2c_driver(vl53l0x_driver);
+
+MODULE_AUTHOR("Song Qiang <songqiang.1304521@gmail.com>");
+MODULE_DESCRIPTION("ST vl53l0x ToF ranging sensor");
+MODULE_LICENSE("GPL");
-- 
2.17.1

