Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5D1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4B21854
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 19:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqMDl/5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA4B21854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeHUXRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 19:17:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37259 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeHUXRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 19:17:04 -0400
Received: by mail-lf1-f68.google.com with SMTP id j8-v6so14508877lfb.4;
        Tue, 21 Aug 2018 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BX6PJuVzM2m4l/CyH1Gv9PMcmEF3U7/AEVuq4Oeh2S8=;
        b=cqMDl/5iNMscjj3WP1hZNkb4WUjVuzXlW1R3LOxBevu0HJu2vDqKsp8AWkIrwz10Tn
         hdFFc0mfBdNZ8NIoIhu4fp+PqQh9eRXznBAQV+mq8ddXdYlcnzFm9sXTys7jSPSZWrYB
         0Qe87J73nbmIULHNQ9cKWWPJcYxGfxBCgU+MSN9xuKP8YSUmE+yGHJa7+Ju9fhDqfAZM
         qwRL5wC2/EfjKqQ8DZSIqGomgWZHomGZqiWEJe2oyLIIwn5qJvGu10AYGBN8oN840gDK
         xP2sAMPZA+ck6DZRoTkIn/0ihH+64A3Sw23FNnmHrXzJd0kO6gacdME/iSfc0Vl9DFNu
         UdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BX6PJuVzM2m4l/CyH1Gv9PMcmEF3U7/AEVuq4Oeh2S8=;
        b=QMjBrSHnT+cYKp0E2KfIJrdzsSUmldm393YajjRFjWaf+pPhIEjdW1eja44MUuobOL
         K8ri56WPEqRvca83AKvxPivUgMjyW8RCLGzdgG5y8eB03Fl7xa1ruNxq1CZec7v89KtA
         1ZkTvKKDEtBHsl0FkQYnZRC3mAQCIgL8eDVQeQfZwCaRBoRWgyg3wqBScFsgkMHvM3kB
         SVQS2Lic1QBu2wbYcpMwIZFF5g37ycy08drdyf7Qd3ZqkSjS0i398ZvbK8LfZfrt3u9J
         1N4yCNlnV8O3cwGATgT9wYzjwYbAl773kTFm3H/nOW0ottfE+NwSIn9tl5roDLOIWRPA
         rzzQ==
X-Gm-Message-State: AOUpUlFh68B/lyAR1Wj1EH4SsRjinyr/72v+pIK5R3Vvdidu8273DHW2
        mxTmXwJ70Yv7M9HCflwIppQ=
X-Google-Smtp-Source: AA+uWPxolu5B/xbXXOaalWPnvBUaEsW6iDL8+RRSsx1nljTEjZpQEqVhQVAfsO8eJU7N/P2zYTVgtw==
X-Received: by 2002:a19:4b15:: with SMTP id y21-v6mr9156281lfa.118.1534881329542;
        Tue, 21 Aug 2018 12:55:29 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26f18-74736162.cust.telenor.se. [46.194.111.24])
        by smtp.gmail.com with ESMTPSA id l141-v6sm2449374lfg.55.2018.08.21.12.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 12:55:28 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] iio: dac: add support for ltc1660
Date:   Tue, 21 Aug 2018 21:31:24 +0200
Message-Id: <20180821193126.15733-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter
(DAC) with eight individual channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
    	- rename all instances of ltc166x to ltc1660
    	- read regulator value "in-place" instead of cache voltage
    	- fix error handling in ltc1660_write_raw

 drivers/iio/dac/Kconfig   |  10 ++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ltc1660.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 261 insertions(+)
 create mode 100644 drivers/iio/dac/ltc1660.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 76db0768e454..cbee80bd111e 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -120,6 +120,16 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config LTC1660
+	tristate "Linear Technology LTC1660/LTC1665 DAC SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Linear Technology
+	  LTC1660 and LTC1665 Digital to Analog Converters.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ltc1660.
+
 config LTC2632
 	tristate "Linear Technology LTC2632-12/10/8 DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 81e710ed7491..e446eeb09c85 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_CIO_DAC) += cio-dac.o
 obj-$(CONFIG_DPOT_DAC) += dpot-dac.o
 obj-$(CONFIG_DS4424) += ds4424.o
 obj-$(CONFIG_LPC18XX_DAC) += lpc18xx_dac.o
+obj-$(CONFIG_LTC1660) += ltc1660.o
 obj-$(CONFIG_LTC2632) += ltc2632.o
 obj-$(CONFIG_M62332) += m62332.o
 obj-$(CONFIG_MAX517) += max517.o
diff --git a/drivers/iio/dac/ltc1660.c b/drivers/iio/dac/ltc1660.c
new file mode 100644
index 000000000000..10866838c72a
--- /dev/null
+++ b/drivers/iio/dac/ltc1660.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Linear Technology LTC1665/LTC1660, 8 channels DAC
+ *
+ * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
+ */
+#include <linux/bitops.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#define LTC1660_REG_WAKE	0x0
+#define LTC1660_REG_DAC_A	0x1
+#define LTC1660_REG_DAC_B	0x2
+#define LTC1660_REG_DAC_C	0x3
+#define LTC1660_REG_DAC_D	0x4
+#define LTC1660_REG_DAC_E	0x5
+#define LTC1660_REG_DAC_F	0x6
+#define LTC1660_REG_DAC_G	0x7
+#define LTC1660_REG_DAC_H	0x8
+#define LTC1660_REG_SLEEP	0xe
+
+#define LTC1660_NUM_CHANNELS	8
+
+static const struct regmap_config ltc1660_regmap_config = {
+	.reg_bits = 4,
+	.val_bits = 12,
+};
+
+enum ltc1660_supported_device_ids {
+	ID_LTC1660,
+	ID_LTC1665,
+};
+
+struct ltc1660_priv {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct regulator *vref_reg;
+	unsigned int value[LTC1660_NUM_CHANNELS];
+	unsigned int vref_mv;
+};
+
+static int ltc1660_read_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan,
+		int *val,
+		int *val2,
+		long mask)
+{
+	struct ltc1660_priv *priv = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val = priv->value[chan->channel];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = regulator_get_voltage(priv->vref_reg);
+		if (*val < 0) {
+			dev_err(&priv->spi->dev, "failed to read vref regulator: %d\n",
+					*val);
+			return *val;
+		}
+
+		/* Convert to mV */
+		*val /= 1000;
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc1660_write_raw(struct iio_dev *indio_dev,
+		struct iio_chan_spec const *chan,
+		int val,
+		int val2,
+		long mask)
+{
+	struct ltc1660_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val2 != 0)
+			return -EINVAL;
+
+		if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
+			return -EINVAL;
+
+		ret = regmap_write(priv->regmap, chan->channel,
+					(val << chan->scan_type.shift));
+		if (!ret)
+			priv->value[chan->channel] = val;
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define LTC1660_CHAN(chan, bits) {			\
+	.type = IIO_VOLTAGE,				\
+	.indexed = 1,					\
+	.output = 1,					\
+	.channel = chan,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.scan_type = {					\
+		.sign = 'u',				\
+		.realbits = (bits),			\
+		.storagebits = 16,			\
+		.shift = 12 - (bits),			\
+	},						\
+}
+
+#define  LTC1660_OCTAL_CHANNELS(bits) {			\
+		LTC1660_CHAN(LTC1660_REG_DAC_A, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_B, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_C, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_D, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_E, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_F, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_G, bits),	\
+		LTC1660_CHAN(LTC1660_REG_DAC_H, bits),	\
+}
+
+static const struct iio_chan_spec ltc1660_channels[][LTC1660_NUM_CHANNELS] = {
+	[ID_LTC1660] = LTC1660_OCTAL_CHANNELS(10),
+	[ID_LTC1665] = LTC1660_OCTAL_CHANNELS(8),
+};
+
+static const struct iio_info ltc1660_info = {
+	.read_raw = &ltc1660_read_raw,
+	.write_raw = &ltc1660_write_raw,
+};
+
+static int __maybe_unused ltc1660_suspend(struct device *dev)
+{
+	struct ltc1660_priv *priv = iio_priv(spi_get_drvdata(
+						to_spi_device(dev)));
+	return regmap_write(priv->regmap, LTC1660_REG_SLEEP, 0x00);
+}
+
+static int __maybe_unused ltc1660_resume(struct device *dev)
+{
+	struct ltc1660_priv *priv = iio_priv(spi_get_drvdata(
+						to_spi_device(dev)));
+	return regmap_write(priv->regmap, LTC1660_REG_WAKE, 0x00);
+}
+static SIMPLE_DEV_PM_OPS(ltc1660_pm_ops, ltc1660_suspend, ltc1660_resume);
+
+static int ltc1660_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ltc1660_priv *priv;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->regmap = devm_regmap_init_spi(spi, &ltc1660_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&spi->dev, "failed to register spi regmap %ld\n",
+			PTR_ERR(priv->regmap));
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->vref_reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(priv->vref_reg)) {
+		dev_err(&spi->dev, "vref regulator not specified\n");
+		return PTR_ERR(priv->vref_reg);
+	}
+
+	ret = regulator_enable(priv->vref_reg);
+	if (ret) {
+		dev_err(&spi->dev, "failed to enable vref regulator: %d\n",
+				ret);
+		return ret;
+	}
+
+	priv->spi = spi;
+	spi_set_drvdata(spi, indio_dev);
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ltc1660_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc1660_channels[id->driver_data];
+	indio_dev->num_channels = LTC1660_NUM_CHANNELS;
+	indio_dev->name = id->name;
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "failed to register iio device: %d\n",
+				ret);
+		goto error_disable_reg;
+	}
+
+	return 0;
+
+error_disable_reg:
+	regulator_disable(priv->vref_reg);
+
+	return ret;
+}
+
+static int ltc1660_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ltc1660_priv *priv = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(priv->vref_reg);
+
+	return 0;
+}
+
+static const struct of_device_id ltc1660_dt_ids[] = {
+	{ .compatible = "lltc,ltc1660", .data = (void *)ID_LTC1660 },
+	{ .compatible = "lltc,ltc1665", .data = (void *)ID_LTC1665 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ltc1660_dt_ids);
+
+static const struct spi_device_id ltc1660_id[] = {
+	{"ltc1660", ID_LTC1660},
+	{"ltc1665", ID_LTC1665},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(spi, ltc1660_id);
+
+static struct spi_driver ltc1660_driver = {
+	.driver = {
+		.name = "ltc1660",
+		.of_match_table = ltc1660_dt_ids,
+		.pm = &ltc1660_pm_ops,
+	},
+	.probe	= ltc1660_probe,
+	.remove = ltc1660_remove,
+	.id_table = ltc1660_id,
+};
+module_spi_driver(ltc1660_driver);
+
+MODULE_AUTHOR("Marcus Folkesson <marcus.folkesson@gmail.com>");
+MODULE_DESCRIPTION("Linear Technology LTC1660/LTC1665 DAC");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0.rc2

