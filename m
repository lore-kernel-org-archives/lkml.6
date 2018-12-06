Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6159EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDD92082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD0uTDTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDD92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbeLFVFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:05:18 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44622 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFVFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:05:15 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so1652551lji.11;
        Thu, 06 Dec 2018 13:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50HldlAcAm8CAnkcyzgwhLA7c2/WCWBnBevIptqyuwY=;
        b=lD0uTDTOSeFk44ICtxk/R/p+JucLH0VsQSwXQ2btLe2D/NNW5Db520w7/lRTUKusGM
         vvBpuWQUfWG9cRyYWjYr17iPbw1V+isJRIzHtXvi2FrovBSmR17cTsxgT3dvh5+EQnVY
         QZHHhofAsRR2SWrZRJIt+VDVMbsnrV4Zz1euABtUPtPBddxqApzdR/csAaq0stjvfqzA
         SWAe1TMV6t8E4OtNHY0yJ9Up5mplPJQZoMk6Sq0TBoHeZKbAuxos2aDk7ocadLHTr5sa
         dRvsvi7dsWV9ltmv8zDl3oA8x4CySJ30XmYH9Hs/dFs9jFVXKDauEVsW6T64zMzVTPq5
         WiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50HldlAcAm8CAnkcyzgwhLA7c2/WCWBnBevIptqyuwY=;
        b=OLKTgf5aC6W0gvIL0T2YZ1CNazmXcK4UL7n0VOaolKbFtAqFo/OQ/0+GNLiGvCH1Av
         3jQj2UsJbX+8cYJDHnYhLJP4OUNqtbIPZsfQzrzw9UFYSACCis0EXP1lGhGXNMMeVQQy
         8IhzoEmGYEQDR+/4lUDrJFbLGCA97nPN4f/lYKztKltCvyKEdyZqYBfZpeiDFY3kw8wl
         SSkLfRi0CKmINI0hK5YalBD31CSEm1279z+HFVNRdHuAXWs1DQcxLXO5+vCibB6DIZp5
         01G74rq2GkvxbokL4L5zW35BFwnb2w/NZi5Iie8b9sMvAGL6l39oUpKPyyV2SN8nPgZJ
         kypA==
X-Gm-Message-State: AA+aEWYE85vLhYFfSxsRiCtWcZ9iFwxtXye6iTT4Td2GUD0SyEQQieCW
        Vkve6WtZ+s+uZ0zGUb2krwnAiX98un8=
X-Google-Smtp-Source: AFSGD/UMp98KbjINBGWBRHdue6jdK5fqonBm/c4CQqhhloYQT2ErR8Q5MqOByCIl3H+BX9kgbKrOCQ==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr21140605lji.101.1544130311659;
        Thu, 06 Dec 2018 13:05:11 -0800 (PST)
Received: from arch.domain.name (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id e94sm267366lfi.23.2018.12.06.13.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:05:11 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk,
        a.brauchli@elementarea.net, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v2 2/3] iio: chemical: add support for Sensirion SPS30 sensor
Date:   Thu,  6 Dec 2018 22:04:42 +0100
Message-Id: <20181206210443.21052-3-tduszyns@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206210443.21052-1-tduszyns@gmail.com>
References: <20181206210443.21052-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Sensirion SPS30 particulate matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/Kconfig  |  11 +
 drivers/iio/chemical/Makefile |   1 +
 drivers/iio/chemical/sps30.c  | 406 ++++++++++++++++++++++++++++++++++
 3 files changed, 418 insertions(+)
 create mode 100644 drivers/iio/chemical/sps30.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index b8e005be4f87..57832b4360e9 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -61,6 +61,17 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors
 
+config SPS30
+	tristate "SPS30 particulate matter sensor"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build support for the Sensirion SPS30 particulate
+	  matter sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called sps30.
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2f4c4ba4d781..9f42f4252151 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
 obj-$(CONFIG_BME680_SPI) += bme680_spi.o
 obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
+obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps30.c
new file mode 100644
index 000000000000..4857b6164dd2
--- /dev/null
+++ b/drivers/iio/chemical/sps30.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Sensirion SPS30 Particulate Matter sensor driver
+ *
+ * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
+ *
+ * I2C slave address: 0x69
+ *
+ * TODO:
+ *  - support for turning on fan cleaning
+ *  - support for reading/setting auto cleaning interval
+ */
+
+#define pr_fmt(fmt) "sps30: " fmt
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/module.h>
+
+#define SPS30_CRC8_POLYNOMIAL 0x31
+/* max number of bytes needed to store PM measurements or serial string */
+#define SPS30_MAX_READ_SIZE 48
+/* sensor measures reliably up to 3000 ug / m3 */
+#define SPS30_MAX_PM 3000
+
+/* SPS30 commands */
+#define SPS30_START_MEAS 0x0010
+#define SPS30_STOP_MEAS 0x0104
+#define SPS30_RESET 0xd304
+#define SPS30_READ_DATA_READY_FLAG 0x0202
+#define SPS30_READ_DATA 0x0300
+#define SPS30_READ_SERIAL 0xd033
+
+enum {
+	PM1,
+	PM2P5,
+	PM4,
+	PM10,
+};
+
+struct sps30_state {
+	struct i2c_client *client;
+	/*
+	 * Guards against concurrent access to sensor registers.
+	 * Must be held whenever sequence of commands is to be executed.
+	 */
+	struct mutex lock;
+};
+
+DECLARE_CRC8_TABLE(sps30_crc8_table);
+
+static int sps30_write_then_read(struct sps30_state *state, u8 *txbuf,
+				 int txsize, u8 *rxbuf, int rxsize)
+{
+	int ret;
+
+	/*
+	 * Sensor does not support repeated start so instead of
+	 * sending two i2c messages in a row we just send one by one.
+	 */
+	ret = i2c_master_send(state->client, txbuf, txsize);
+	if (ret != txsize)
+		return ret < 0 ? ret : -EIO;
+
+	if (!rxbuf)
+		return 0;
+
+	ret = i2c_master_recv(state->client, rxbuf, rxsize);
+	if (ret != rxsize)
+		return ret < 0 ? ret : -EIO;
+
+	return 0;
+}
+
+static int sps30_do_cmd(struct sps30_state *state, u16 cmd, u8 *data, int size)
+{
+	/*
+	 * Internally sensor stores measurements in a following manner:
+	 *
+	 * PM1: upper two bytes, crc8, lower two bytes, crc8
+	 * PM2P5: upper two bytes, crc8, lower two bytes, crc8
+	 * PM4: upper two bytes, crc8, lower two bytes, crc8
+	 * PM10: upper two bytes, crc8, lower two bytes, crc8
+	 *
+	 * What follows next are number concentration measurements and
+	 * typical particle size measurement which we omit.
+	 */
+	u8 buf[SPS30_MAX_READ_SIZE] = { cmd >> 8, cmd };
+	int i, ret = 0;
+
+	switch (cmd) {
+	case SPS30_START_MEAS:
+		buf[2] = 0x03;
+		buf[3] = 0x00;
+		buf[4] = crc8(sps30_crc8_table, &buf[2], 2, CRC8_INIT_VALUE);
+		ret = sps30_write_then_read(state, buf, 5, NULL, 0);
+		break;
+	case SPS30_STOP_MEAS:
+	case SPS30_RESET:
+		ret = sps30_write_then_read(state, buf, 2, NULL, 0);
+		break;
+	case SPS30_READ_DATA_READY_FLAG:
+	case SPS30_READ_DATA:
+	case SPS30_READ_SERIAL:
+		/* every two data bytes are checksummed */
+		size += size / 2;
+		ret = sps30_write_then_read(state, buf, 2, buf, size);
+		break;
+	};
+
+	if (ret)
+		return ret;
+
+	/* validate received data and strip off crc bytes */
+	for (i = 0; i < size; i += 3) {
+		u8 crc = crc8(sps30_crc8_table, &buf[i], 2, CRC8_INIT_VALUE);
+
+		if (crc != buf[i + 2]) {
+			dev_err(&state->client->dev,
+				"data integrity check failed\n");
+			return -EIO;
+		}
+
+		*data++ = buf[i];
+		*data++ = buf[i + 1];
+	}
+
+	return 0;
+}
+
+static int sps30_float_to_int_clamped(const u8 *fp)
+{
+	int val = ((int)fp[0] << 24) | ((int)fp[1] << 16) | ((int)fp[2] << 8) |
+		  (int)fp[3];
+	int mantissa = val & GENMASK(22, 0);
+	/* this is fine since passed float is always non-negative */
+	int exp = val >> 23;
+	int fraction, shift;
+
+	/* special case 0 */
+	if (!exp && !mantissa)
+		return 0;
+
+	exp -= 127;
+	if (exp < 0) {
+		/* return values ranging from 1 to 99 */
+		return ((((1 << 23) + mantissa) * 100) >> 23) >> (-exp);
+	}
+
+	/* return values ranging from 100 to 300000 */
+	shift = 23 - exp;
+	val = (1 << exp) + (mantissa >> shift);
+	if (val >= SPS30_MAX_PM)
+		return SPS30_MAX_PM * 100;
+
+	fraction = mantissa & GENMASK(shift - 1, 0);
+
+	return val * 100 + ((fraction * 100) >> shift);
+}
+
+static int sps30_do_meas(struct sps30_state *state, int *data, int size)
+{
+	int i, ret, tries = 5;
+	u8 tmp[16];
+
+	while (tries--) {
+		ret = sps30_do_cmd(state, SPS30_READ_DATA_READY_FLAG, tmp, 2);
+		if (ret)
+			return -EIO;
+
+		/* new measurements ready to be read */
+		if (tmp[1] == 1)
+			break;
+
+		msleep_interruptible(300);
+	}
+
+	if (!tries)
+		return -ETIMEDOUT;
+
+	ret = sps30_do_cmd(state, SPS30_READ_DATA, tmp, sizeof(int) * size);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < size; i++)
+		data[i] = sps30_float_to_int_clamped(&tmp[4 * i]);
+
+	return 0;
+}
+
+static irqreturn_t sps30_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct sps30_state *state = iio_priv(indio_dev);
+	int ret, data[4 + 2]; /* PM1, PM2P5, PM4, PM10, timestamp */
+
+	mutex_lock(&state->lock);
+	ret = sps30_do_meas(state, data, 4);
+	mutex_unlock(&state->lock);
+	if (ret)
+		goto err;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data,
+					   iio_get_time_ns(indio_dev));
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int sps30_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	struct sps30_state *state = iio_priv(indio_dev);
+	int data[4], ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_MASSCONCENTRATION:
+			mutex_lock(&state->lock);
+			/* read up to the number of bytes actually needed */
+			switch (chan->channel2) {
+			case IIO_MOD_PM1:
+				ret = sps30_do_meas(state, data, 1);
+				break;
+			case IIO_MOD_PM2P5:
+				ret = sps30_do_meas(state, data, 2);
+				break;
+			case IIO_MOD_PM4:
+				ret = sps30_do_meas(state, data, 3);
+				break;
+			case IIO_MOD_PM10:
+				ret = sps30_do_meas(state, data, 4);
+				break;
+			}
+			mutex_unlock(&state->lock);
+			if (ret)
+				return ret;
+
+			*val = data[chan->address] / 100;
+			*val2 = (data[chan->address] % 100) * 10000;
+
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_MASSCONCENTRATION:
+			switch (chan->channel2) {
+			case IIO_MOD_PM1:
+			case IIO_MOD_PM2P5:
+			case IIO_MOD_PM4:
+			case IIO_MOD_PM10:
+				*val = 0;
+				*val2 = 10000;
+
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info sps30_info = {
+	.read_raw = sps30_read_raw,
+};
+
+#define SPS30_CHAN(_index, _mod) { \
+	.type = IIO_MASSCONCENTRATION, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _mod, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.address = _mod, \
+	.scan_index = _index, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 19, \
+		.storagebits = 32, \
+		.endianness = IIO_CPU, \
+	}, \
+}
+
+static const struct iio_chan_spec sps30_channels[] = {
+	SPS30_CHAN(0, PM1),
+	SPS30_CHAN(1, PM2P5),
+	SPS30_CHAN(2, PM4),
+	SPS30_CHAN(3, PM10),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static void sps30_stop_meas(void *data)
+{
+	struct sps30_state *state = data;
+
+	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
+}
+
+static const unsigned long sps30_scan_masks[] = { 0x0f, 0x00 };
+
+static int sps30_probe(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev;
+	struct sps30_state *state;
+	u8 buf[32];
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	state->client = client;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &sps30_info;
+	indio_dev->name = client->name;
+	indio_dev->channels = sps30_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sps30_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = sps30_scan_masks;
+
+	mutex_init(&state->lock);
+	crc8_populate_msb(sps30_crc8_table, SPS30_CRC8_POLYNOMIAL);
+
+	ret = sps30_do_cmd(state, SPS30_RESET, NULL, 0);
+	if (ret) {
+		dev_err(&client->dev, "failed to reset device\n");
+		return ret;
+	}
+	msleep(300);
+	/*
+	 * Power-on-reset causes sensor to produce some glitch on i2c bus and
+	 * some controllers end up in error state. Recover simply by placing
+	 * some data on the bus, for example STOP_MEAS command, which
+	 * is NOP in this case.
+	 */
+	sps30_do_cmd(state, SPS30_STOP_MEAS, NULL, 0);
+
+	ret = sps30_do_cmd(state, SPS30_READ_SERIAL, buf, sizeof(buf));
+	if (ret) {
+		dev_err(&client->dev, "failed to read serial number\n");
+		return ret;
+	}
+	/* returned serial number is already NUL terminated */
+	dev_info(&client->dev, "serial number: %s\n", buf);
+
+	ret = sps30_do_cmd(state, SPS30_START_MEAS, NULL, 0);
+	if (ret) {
+		dev_err(&client->dev, "failed to start measurement\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&client->dev, sps30_stop_meas, state);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+					      sps30_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id sps30_id[] = {
+	{ "sps30" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sps30_id);
+
+static const struct of_device_id sps30_of_match[] = {
+	{ .compatible = "sensirion,sps30" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sps30_of_match);
+
+static struct i2c_driver sps30_driver = {
+	.driver = {
+		.name = "sps30",
+		.of_match_table = sps30_of_match,
+	},
+	.id_table = sps30_id,
+	.probe_new = sps30_probe,
+};
+module_i2c_driver(sps30_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
+MODULE_DESCRIPTION("Sensirion SPS30 particulate matter sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

