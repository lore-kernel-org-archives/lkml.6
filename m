Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF6DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411F9218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 21:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6lSTop8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfAXVcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 16:32:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44677 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXVcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 16:32:53 -0500
Received: by mail-ed1-f67.google.com with SMTP id y56so5776841edd.11;
        Thu, 24 Jan 2019 13:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AByTXu8Y77puBLcpMbd+UcPtK4yNuPmOU6k7pgt48+M=;
        b=o6lSTop88kjefC0eRcDBJrZDzAYFB2BsWUVnqv0C9LS1yqHwW8t8sGVS3pPCd4rXno
         tqzii2jv3kg30fVlI0gjSpY7VX+Ni0gfgDgOx3H8NdooJS1VG2UwOX59w55vv+7vRzcY
         hFESsZi/NKK5pqJSmyvtpQKEyEj+KTOTOs7XHgYJtKzaNeHyfSh8rLFqkB7TUOkci82z
         VaDXqLsYbYUw9yqGESp3trzWoQ5F0gs5RImkOyzXRQ+YxMzn2iOxinsPuAS6FZfMo6aq
         0BD+o2l3KZos2A54PfwST8Pq6w/qfHMyGsax9lh3ywzqmrzANWa6tL9BNzAjY5jvdkA0
         9WKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=AByTXu8Y77puBLcpMbd+UcPtK4yNuPmOU6k7pgt48+M=;
        b=gTI3aVA3ZNBp1n567b2GkVCclClMVSYLflZ4UbMz+84v16lS9Fzx+cLKtYbLN3vSkz
         7aGx/rffx3l1lc66BEbOcJoKytbV8aTxYaF447B+cm5Px5LtYibxPPBiUF9cACewVmTx
         poAc3hwcG/7aliZITgAZFzkdXNcMlWOgsSWggG7tjRhTycdHkmuNQlroSIdESOKdwBa/
         EaEMAI0DANQBEQurUOYeQ++U7rYRRQyMSu+5qFBgKgXrHSZKlPGZS+nmxrHzfojotCYk
         DB0bJ06slAmIQNALTlal9SEBIAhzd/T3BnDj7wxigSNia40CG9tRLrU60t5hwC4LIvVg
         q9rg==
X-Gm-Message-State: AJcUukewlrucHqiBGSIpTDSRW2KggIUoRPRs0K8+nmhb4qXwtNwFaB8o
        aj/dOOT7fnyuK7ubHBzQS1c=
X-Google-Smtp-Source: ALg8bN5NXtBH7wfT44OdVrVELqWYCDEPdd9OqS7vUMWYaSiu4uoA8/VvmjKvOslCJwodYKurXcBAxA==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25-v6mr3175207eji.186.1548365570497;
        Thu, 24 Jan 2019 13:32:50 -0800 (PST)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id g16sm985656ejb.65.2019.01.24.13.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:32:49 -0800 (PST)
From:   Ricardo Ribalda Delgado <ricardo@ribalda.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo@ribalda.com>
Subject: [PATCH] iio:dac:ti-dac7612: Add driver for Texas Instruments DAC7612
Date:   Thu, 24 Jan 2019 22:32:48 +0100
Message-Id: <20190124213248.11900-1-ricardo@ribalda.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a driver for Texas Instruments Dual, 12-Bit Serial Input
Digital-to-Analog Converter.

Datasheet of this chip:
http://www.ti.com/lit/ds/sbas106/sbas106.pdf

Signed-off-by: Ricardo Ribalda Delgado <ricardo@ribalda.com>
---
 MAINTAINERS                  |   6 ++
 drivers/iio/dac/Kconfig      |  10 +++
 drivers/iio/dac/Makefile     |   1 +
 drivers/iio/dac/ti-dac7612.c | 170 +++++++++++++++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 drivers/iio/dac/ti-dac7612.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d039f66a5cef..30ba5435906b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14877,6 +14877,12 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 
+Texas Instruments' DAC7612 DAC Driver
+M:	Ricardo Ribalda <ricardo@ribalda.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/dac/ti-dac7612.c
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index f28daf67db6a..fbef9107acad 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -375,6 +375,16 @@ config TI_DAC7311
 
 	  If compiled as a module, it will be called ti-dac7311.
 
+config TI_DAC7612
+	tristate "Texas Instruments 12-bit 2-channel DAC driver"
+	depends on SPI_MASTER && GPIOLIB
+	help
+	  Driver for the Texas Instruments DAC7612, DAC7612U, DAC7612UB
+	  The driver hand drive the load pin automatically, otherwise
+	  it needs to be toggled manually.
+
+	  If compiled as a module, it will be called ti-dac7612.
+
 config VF610_DAC
 	tristate "Vybrid vf610 DAC driver"
 	depends on OF
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index f0a37c93de8e..1369fa1d2f0e 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -41,4 +41,5 @@ obj-$(CONFIG_STM32_DAC) += stm32-dac.o
 obj-$(CONFIG_TI_DAC082S085) += ti-dac082s085.o
 obj-$(CONFIG_TI_DAC5571) += ti-dac5571.o
 obj-$(CONFIG_TI_DAC7311) += ti-dac7311.o
+obj-$(CONFIG_TI_DAC7612) += ti-dac7612.o
 obj-$(CONFIG_VF610_DAC) += vf610_dac.o
diff --git a/drivers/iio/dac/ti-dac7612.c b/drivers/iio/dac/ti-dac7612.c
new file mode 100644
index 000000000000..5b374aa287c7
--- /dev/null
+++ b/drivers/iio/dac/ti-dac7612.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAC7612 Dual, 12-Bit Serial input Digital-to-Analog Converter
+ *
+ * Copyright 2019 Qtechnology A/S
+ * 2019 Ricardo Ribalda <ricardo@ribalda.com>
+ *
+ * Licensed under the GPL-2.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+
+#define NUM_CHANS 2
+#define RESOLUTION 12
+
+struct dac7612 {
+	struct spi_device *spi;
+	struct gpio_desc *nld;
+	uint16_t cache[NUM_CHANS];
+};
+
+static int dac7612_cmd_single(struct dac7612 *priv, int channel, u16 val)
+{
+	uint8_t buffer[2];
+	int ret;
+
+	if (channel >= NUM_CHANS)
+		return -EINVAL;
+
+	buffer[0] = BIT(5) | (channel << 4) | (val >> 8);
+	buffer[1] = val & 0xff;
+
+	priv->cache[channel] = val;
+
+	ret = spi_write(priv->spi, buffer, sizeof(buffer));
+	if (ret)
+		return ret;
+
+	gpiod_set_value(priv->nld, 0);
+	gpiod_set_value(priv->nld, 1);
+
+	return 0;
+}
+
+#define dac7612_CHANNEL(chan, name) {				\
+	.type = IIO_VOLTAGE,					\
+	.channel = (chan),					\
+	.address = (chan),					\
+	.indexed = true,					\
+	.output = true,						\
+	.datasheet_name = name,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_type = {						\
+			.sign = 'u',				\
+			.realbits = RESOLUTION,			\
+			.storagebits = RESOLUTION,		\
+	},							\
+}
+
+static const struct iio_chan_spec dac7612_channels[] = {
+	dac7612_CHANNEL(0, "OUTA"),
+	dac7612_CHANNEL(1, "OUTB"),
+};
+
+static int dac7612_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct dac7612 *priv;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		priv = iio_priv(iio_dev);
+		*val = priv->cache[chan->channel];
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 1;
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int dac7612_write_raw(struct iio_dev *iio_dev,
+			     const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct dac7612 *priv;
+	int ret;
+
+	if (mask != IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
+	if ((val >= BIT(RESOLUTION)) || val < 0)
+		return -EINVAL;
+
+	priv = iio_priv(iio_dev);
+	if (val == priv->cache[chan->channel])
+		return 0;
+
+	mutex_lock(&iio_dev->mlock);
+	ret = dac7612_cmd_single(priv, chan->channel, val);
+	mutex_unlock(&iio_dev->mlock);
+
+	return ret;
+}
+
+static const struct iio_info dac7612_info = {
+	.read_raw = dac7612_read_raw,
+	.write_raw = dac7612_write_raw,
+};
+
+static int dac7612_probe(struct spi_device *spi)
+{
+	struct iio_dev *iio_dev;
+	struct dac7612 *priv;
+	int i;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(iio_dev);
+	priv->nld = devm_gpiod_get_optional(&spi->dev, "nLD", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->nld))
+		return PTR_ERR(priv->nld);
+	priv->spi = spi;
+	spi_set_drvdata(spi, iio_dev);
+	iio_dev->dev.parent = &spi->dev;
+	iio_dev->info = &dac7612_info;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+	iio_dev->channels = dac7612_channels;
+	iio_dev->num_channels = NUM_CHANS;
+	iio_dev->name = spi_get_device_id(spi)->name;
+
+	for (i = 0; i < NUM_CHANS; i++) {
+		ret = dac7612_cmd_single(priv, i, 0);
+		if (ret)
+			return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, iio_dev);
+}
+
+static const struct spi_device_id dac7612_id[] = {
+	{"ti-dac7612"},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, dac7612_id);
+
+static struct spi_driver dac7612_driver = {
+	.driver = {
+		   .name = "ti-dac7612",
+		   },
+	.probe = dac7612_probe,
+	.id_table = dac7612_id,
+};
+module_spi_driver(dac7612_driver);
+
+MODULE_AUTHOR("Ricardo Ribalda <ricardo@ribalda.com>");
+MODULE_DESCRIPTION("Texas Instruments DAC7612 DAC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

