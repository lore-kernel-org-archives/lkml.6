Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48ECC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E30B20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCfCKCbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfBIRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:36:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43954 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbfBIRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:36:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id q2-v6so5562187lji.10;
        Sat, 09 Feb 2019 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VnI54u+EhdK/GX5e9WgXGHoIutOBqDm3JI68hHuak5s=;
        b=NCfCKCbEYVVDFIRCH1YlCXsectqkSOhsZ/AyMN1hb/XwIReXdFvyfgcugnvJckSfqH
         0iD5RN0hxzRvx909oHTKJsyvi1QbZ7BK+5kxQ1PWaLhwXWI+WHaT2UDdGlekLlXD8Z87
         rLwACUbZ7fsaQvaIBxhX3ZJDGjRmHSgEi+5nNFZGgQov8ee11vePFyVBs5Sc6E6XznXg
         pXyYPkSAWk1/tDgoxCW+CNtc2+fJj/J9QDdsHaHswOyoG9ChwkPFCgD4LNRDnwXiY0ju
         t/+4QyM+pAqMOeWe01k70noqngWnyoUX/wviQVNhUSH/PCFccU8/K/dGXMbDDLaptTgh
         gMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VnI54u+EhdK/GX5e9WgXGHoIutOBqDm3JI68hHuak5s=;
        b=iEzFX0gHASUIZgpOTpFeFFO7FNIvMGNLLzaO77oHJQUC+CBfyMKC3P69OQS6et2/py
         RtXwkmB+P/gXWyc2/hkz9R+1+NehZrlpnE2C4YumFbJN4lzzF98VOZi1ILnGh41EZ965
         UZAIwR3XcmWHj4VoBaEYvFyWPErUllii0YkdRWF/+D4235fghMeHdXT9qnWzsbnrywOz
         bnsi7L6XuRSnowkiaMQIyaDQT5biPXhQwCPGROD+FYRhtNkn4Gr5Z3OdqjDJb1KqGHwQ
         uuXW2fqxPsh4c0X1UvTZo9wnmdLs7E1WnF4svjyUpq0rBFJ0N0vhEWf5325Qj1HCGSmO
         +JPQ==
X-Gm-Message-State: AHQUAubltyOW+jAw+d11xemYMLvVXHPlZox3rEv3um8KUGeDyqPSy7qb
        Vdihcyr32QVJ1nlWZOxMedr4QXyI/3s=
X-Google-Smtp-Source: AHgI3Ib+vlZPxJs1ycGmQhJVcQJgFGm5arEVcB4BoWXb3oAVChpFJ7Zg3nM25dMjPNWSB/m42JzQPw==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr15183971lja.148.1549733799853;
        Sat, 09 Feb 2019 09:36:39 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id n12-v6sm1080508ljj.32.2019.02.09.09.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 09:36:39 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v4 1/3] iio: chemical: add support for Plantower PMS7003 sensor
Date:   Sat,  9 Feb 2019 18:36:07 +0100
Message-Id: <20190209173609.13220-2-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190209173609.13220-1-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Plantower PMS7003 particulate matter sensor.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/chemical/Kconfig   |  10 +
 drivers/iio/chemical/Makefile  |   1 +
 drivers/iio/chemical/pms7003.c | 340 +++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)
 create mode 100644 drivers/iio/chemical/pms7003.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 57832b4360e9..d5d146e9e372 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -61,6 +61,16 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors
 
+config PMS7003
+	tristate "Plantower PMS7003 particulate matter sensor"
+	depends on SERIAL_DEV_BUS
+	help
+	  Say Y here to build support for the Plantower PMS7003 particulate
+	  matter sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called pms7003.
+
 config SPS30
 	tristate "SPS30 particulate matter sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 65bf0f89c0e4..f5d1365acb49 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
 obj-$(CONFIG_BME680_SPI) += bme680_spi.o
 obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
+obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
new file mode 100644
index 000000000000..0c913c60adde
--- /dev/null
+++ b/drivers/iio/chemical/pms7003.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Plantower PMS7003 particulate matter sensor driver
+ *
+ * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
+ */
+
+#include <asm/unaligned.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/serdev.h>
+
+#define PMS7003_DRIVER_NAME "pms7003"
+
+#define PMS7003_MAGIC 0x424d
+/* last 2 data bytes hold frame checksum */
+#define PMS7003_MAX_DATA_LENGTH 28
+#define PMS7003_CHECKSUM_LENGTH 2
+#define PMS7003_PM10_OFFSET 10
+#define PMS7003_PM2P5_OFFSET 8
+#define PMS7003_PM1_OFFSET 6
+
+#define PMS7003_TIMEOUT msecs_to_jiffies(6000)
+#define PMS7003_CMD_LENGTH 7
+#define PMS7003_PM_MAX 1000
+#define PMS7003_PM_MIN 0
+
+enum {
+	PM1,
+	PM2P5,
+	PM10,
+};
+
+enum pms7003_cmd {
+	CMD_WAKEUP,
+	CMD_ENTER_PASSIVE_MODE,
+	CMD_READ_PASSIVE,
+	CMD_SLEEP,
+};
+
+/*
+ * commands have following format:
+ *
+ * +------+------+-----+------+-----+-----------+-----------+
+ * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
+ * +------+------+-----+------+-----+-----------+-----------+
+ */
+static const u8 pms7003_cmd_tbl[][PMS7003_CMD_LENGTH] = {
+	[CMD_WAKEUP] = { 0x42, 0x4d, 0xe4, 0x00, 0x01, 0x01, 0x74 },
+	[CMD_ENTER_PASSIVE_MODE] = { 0x42, 0x4d, 0xe1, 0x00, 0x00, 0x01, 0x70 },
+	[CMD_READ_PASSIVE] = { 0x42, 0x4d, 0xe2, 0x00, 0x00, 0x01, 0x71 },
+	[CMD_SLEEP] = { 0x42, 0x4d, 0xe4, 0x00, 0x00, 0x01, 0x73 },
+};
+
+struct pms7003_frame {
+	u8 data[PMS7003_MAX_DATA_LENGTH];
+	u16 expected_length;
+	u16 length;
+};
+
+struct pms7003_state {
+	struct serdev_device *serdev;
+	struct pms7003_frame frame;
+	struct completion frame_ready;
+	struct mutex lock; /* must be held whenever state gets touched */
+};
+
+static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
+{
+	int ret;
+
+	ret = serdev_device_write(state->serdev, pms7003_cmd_tbl[cmd],
+				  PMS7003_CMD_LENGTH, PMS7003_TIMEOUT);
+	if (ret < PMS7003_CMD_LENGTH)
+		return ret < 0 ? ret : -EIO;
+
+	ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
+							PMS7003_TIMEOUT);
+	if (!ret)
+		ret = -ETIMEDOUT;
+
+	return ret < 0 ? ret : 0;
+}
+
+static u16 pms7003_get_pm(const u8 *data)
+{
+	return clamp_val(get_unaligned_be16(data),
+			 PMS7003_PM_MIN, PMS7003_PM_MAX);
+}
+
+static irqreturn_t pms7003_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct pms7003_state *state = iio_priv(indio_dev);
+	struct pms7003_frame *frame = &state->frame;
+	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
+	int ret;
+
+	mutex_lock(&state->lock);
+	ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
+	if (ret) {
+		mutex_unlock(&state->lock);
+		goto err;
+	}
+
+	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
+	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
+	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
+	mutex_unlock(&state->lock);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data,
+					   iio_get_time_ns(indio_dev));
+err:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int pms7003_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pms7003_state *state = iio_priv(indio_dev);
+	struct pms7003_frame *frame = &state->frame;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_MASSCONCENTRATION:
+			mutex_lock(&state->lock);
+			ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
+			if (ret) {
+				mutex_unlock(&state->lock);
+				return ret;
+			}
+
+			*val = pms7003_get_pm(frame->data + chan->address);
+			mutex_unlock(&state->lock);
+
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info pms7003_info = {
+	.read_raw = pms7003_read_raw,
+};
+
+#define PMS7003_CHAN(_index, _mod, _addr) { \
+	.type = IIO_MASSCONCENTRATION, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _mod, \
+	.address = _addr, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
+	.scan_index = _index, \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = 10, \
+		.storagebits = 16, \
+		.endianness = IIO_CPU, \
+	}, \
+}
+
+static const struct iio_chan_spec pms7003_channels[] = {
+	PMS7003_CHAN(0, PM1, PMS7003_PM1_OFFSET),
+	PMS7003_CHAN(1, PM2P5, PMS7003_PM2P5_OFFSET),
+	PMS7003_CHAN(2, PM10, PMS7003_PM10_OFFSET),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
+{
+	u16 checksum = (PMS7003_MAGIC >> 8) + (u8)PMS7003_MAGIC +
+		       (frame->length >> 8) + (u8)frame->length;
+	int i;
+
+	for (i = 0; i < frame->length - PMS7003_CHECKSUM_LENGTH; i++)
+		checksum += frame->data[i];
+
+	return checksum;
+}
+
+static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
+{
+	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
+	u16 checksum = get_unaligned_be16(frame->data + offset);
+
+	return checksum == pms7003_calc_checksum(frame);
+}
+
+static int pms7003_receive_buf(struct serdev_device *serdev,
+			       const unsigned char *buf, size_t size)
+{
+	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
+	struct pms7003_state *state = iio_priv(indio_dev);
+	struct pms7003_frame *frame = &state->frame;
+	int num;
+
+	if (!frame->expected_length) {
+		u16 magic;
+
+		/* wait for SOF and data length */
+		if (size < 4)
+			return 0;
+
+		magic = get_unaligned_be16(buf);
+		if (magic != PMS7003_MAGIC)
+			return 2;
+
+		num = get_unaligned_be16(buf + 2);
+		if (num <= PMS7003_MAX_DATA_LENGTH) {
+			frame->expected_length = num;
+			frame->length = 0;
+		}
+
+		return 4;
+	}
+
+	num = min(size, (size_t)(frame->expected_length - frame->length));
+	memcpy(frame->data + frame->length, buf, num);
+	frame->length += num;
+
+	if (frame->length == frame->expected_length) {
+		if (pms7003_frame_is_okay(frame))
+			complete(&state->frame_ready);
+
+		frame->expected_length = 0;
+	}
+
+	return num;
+}
+
+static const struct serdev_device_ops pms7003_serdev_ops = {
+	.receive_buf = pms7003_receive_buf,
+	.write_wakeup = serdev_device_write_wakeup,
+};
+
+static void pms7003_stop(void *data)
+{
+	struct pms7003_state *state = data;
+
+	pms7003_do_cmd(state, CMD_SLEEP);
+}
+
+static const unsigned long pms7003_scan_masks[] = { 0x07, 0x00 };
+
+static int pms7003_probe(struct serdev_device *serdev)
+{
+	struct pms7003_state *state;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&serdev->dev, sizeof(*state));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	state = iio_priv(indio_dev);
+	serdev_device_set_drvdata(serdev, indio_dev);
+	state->serdev = serdev;
+	indio_dev->dev.parent = &serdev->dev;
+	indio_dev->info = &pms7003_info;
+	indio_dev->name = PMS7003_DRIVER_NAME;
+	indio_dev->channels = pms7003_channels,
+	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = pms7003_scan_masks;
+
+	mutex_init(&state->lock);
+	init_completion(&state->frame_ready);
+
+	serdev_device_set_client_ops(serdev, &pms7003_serdev_ops);
+	ret = devm_serdev_device_open(&serdev->dev, serdev);
+	if (ret)
+		return ret;
+
+	serdev_device_set_baudrate(serdev, 9600);
+	serdev_device_set_flow_control(serdev, false);
+
+	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
+	if (ret)
+		return ret;
+
+	ret = pms7003_do_cmd(state, CMD_WAKEUP);
+	if (ret) {
+		dev_err(&serdev->dev, "failed to wakeup sensor\n");
+		return ret;
+	}
+
+	ret = pms7003_do_cmd(state, CMD_ENTER_PASSIVE_MODE);
+	if (ret) {
+		dev_err(&serdev->dev, "failed to enter passive mode\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&serdev->dev, pms7003_stop, state);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&serdev->dev, indio_dev, NULL,
+					      pms7003_trigger_handler, NULL);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&serdev->dev, indio_dev);
+}
+
+static const struct of_device_id pms7003_of_match[] = {
+	{ .compatible = "plantower,pms7003" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pms7003_of_match);
+
+static struct serdev_device_driver pms7003_driver = {
+	.driver = {
+		.name = PMS7003_DRIVER_NAME,
+		.of_match_table = pms7003_of_match,
+	},
+	.probe = pms7003_probe,
+};
+module_serdev_device_driver(pms7003_driver);
+
+MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
+MODULE_DESCRIPTION("Plantower PMS7003 particulate matter sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

