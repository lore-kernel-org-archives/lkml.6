Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8632C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D5C206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNrapRXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D5C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbeK2FTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:19:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34113 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:19:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id r14so26967602qtp.1;
        Wed, 28 Nov 2018 10:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwndsqDcv8miPp6UOeRxWVTn4yrMBldRak8bXVwiV9I=;
        b=MNrapRXPnXz45E/3BliateQNB82q79N2zq8qg0vAef1NycCS8ke7E/qxo3AWVGvFgm
         A/WYZBMYicAw8EIm5fq/L612vb7lqEKocfgow22EzQsFexcdat/M78ZGzqQFC14JNk2I
         b0NwGQLEp4j4MnFtpOdV8IyaAWKOR3s7NFPD1ye+uLmlO/lnaiBaYHb6mA4L5E/dA4r0
         QSr+PK0JeOsLhNmKJK05LHkemNvSZv9PAU4dxH39+4hRU9/Yaz5/oaDlLBDBwWiRXanJ
         RAA3yU7ZsTbXMO2XTA/RvIU+atu0d5JPRRZeDnjvFXaUlJCCX5BP2AfFiE/LCmBiNhKy
         V0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwndsqDcv8miPp6UOeRxWVTn4yrMBldRak8bXVwiV9I=;
        b=kqt9X/0y0ME3qzNXFuQB9Gqlkoq3nWf4yP6ARdBWF2P85qHEluES+MENXaAFbZdiUF
         PTEx73nIa2cHsEPnMrTuer0QuqH3KFH6G1KYTrYcwG7SEXvugZyJ8+RokuKVbaAYA6GZ
         uR+FIsAGm0XV4bU6ds1p+QhQjoE9GK5L+OEuuHvESFm3cHJkvB6wrTb0R3CzS8HO88A7
         ky+sFERkOEhnX35PS+Ub6yz7AL7/c9i37podjE8pIYGM+7llOl2T2afHrATCECE+Rur5
         j2jFM7jqtSmeSNEI656L2uO/C43b8TcPyWaJf2w+zs5XMfJcLabpkjJhtgoAGin8WwQT
         fA7w==
X-Gm-Message-State: AA+aEWaRkzN2OK4Slde9UGxJQOJe6pk2NKgS0R/ajmjycf5oGwnbGCA7
        07lGPZXzEoit1u7e3MEjvA8=
X-Google-Smtp-Source: AFSGD/WX3Ly6FF3Bh9fK16xOExS8tyW74pCvqqk1usx3Kg3jvvq0zyuo+jFluW9U/DwTye5s8h6NGA==
X-Received: by 2002:ad4:40c9:: with SMTP id x9mr11499597qvp.165.1543429000285;
        Wed, 28 Nov 2018 10:16:40 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o25sm4826040qtj.10.2018.11.28.10.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 10:16:39 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 28 Nov 2018 16:16:34 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 2/2] staging: iio: ad7780: Moving ad7780 out of staging
Message-ID: <7756c163cf97c02fac3349dc5e1fa943ed6cc5d1.1543428366.git.giuliano.belinassi@usp.br>
References: <cover.1543428366.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543428366.git.giuliano.belinassi@usp.br>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad7780 sigma-delta adc out of staging to the main tree

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
---
 drivers/iio/adc/Kconfig          |  13 ++
 drivers/iio/adc/Makefile         |   1 +
 drivers/iio/adc/ad7780.c         | 347 +++++++++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig  |  13 --
 drivers/staging/iio/adc/Makefile |   1 -
 drivers/staging/iio/adc/ad7780.c | 347 -------------------------------
 6 files changed, 361 insertions(+), 361 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 575bf69fea57..e517425e364d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -92,6 +92,19 @@ config AD7793
 	  To compile this driver as a module, choose M here: the
 	  module will be called AD7793.
 
+config AD7780
+	tristate "Analog Devices AD7780 and similar ADCs driver"
+	depends on SPI
+	depends on GPIOLIB || COMPILE_TEST
+	select AD_SIGMA_DELTA
+	help
+	  Say yes here to build support for Analog Devices AD7170, AD7171,
+	  AD7780 and AD7781 SPI analog to digital converters (ADC).
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7780.
+
 config AD7887
 	tristate "Analog Devices AD7887 ADC driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 91ba28aeb150..3301ca10b385 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AD7298) += ad7298.o
 obj-$(CONFIG_AD7923) += ad7923.o
 obj-$(CONFIG_AD7476) += ad7476.o
 obj-$(CONFIG_AD7766) += ad7766.o
+obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
new file mode 100644
index 000000000000..05979a79fda3
--- /dev/null
+++ b/drivers/iio/adc/ad7780.c
@@ -0,0 +1,347 @@
+/*
+ * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/err.h>
+#include <linux/sched.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/adc/ad_sigma_delta.h>
+
+#define AD7780_RDY		BIT(7)
+#define AD7780_FILTER		BIT(6)
+#define AD7780_ERR		BIT(5)
+#define AD7780_ID1		BIT(4)
+#define AD7780_ID0		BIT(3)
+#define AD7780_GAIN		BIT(2)
+#define AD7780_PAT1		BIT(1)
+#define AD7780_PAT0		BIT(0)
+
+#define AD7780_PATTERN		(AD7780_PAT0)
+#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
+
+#define AD7170_PAT2		BIT(2)
+
+#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
+#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
+
+#define AD7780_GAIN_GPIO	0
+#define AD7780_FILTER_GPIO	1
+
+#define AD7780_GAIN_MIDPOINT	64
+#define AD7780_FILTER_MIDPOINT	13350
+
+struct ad7780_chip_info {
+	struct iio_chan_spec	channel;
+	unsigned int		pattern_mask;
+	unsigned int		pattern;
+	bool			is_ad778x;
+};
+
+struct ad7780_state {
+	const struct ad7780_chip_info	*chip_info;
+	struct regulator		*reg;
+	struct gpio_desc		*powerdown_gpio;
+	struct gpio_desc		*gain_gpio;
+	struct gpio_desc		*filter_gpio;
+	unsigned int	gain;
+
+	struct ad_sigma_delta sd;
+};
+
+enum ad7780_supported_device_ids {
+	ID_AD7170,
+	ID_AD7171,
+	ID_AD7780,
+	ID_AD7781,
+};
+
+static struct ad7780_state *ad_sigma_delta_to_ad7780(struct ad_sigma_delta *sd)
+{
+	return container_of(sd, struct ad7780_state, sd);
+}
+
+static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
+			   enum ad_sigma_delta_mode mode)
+{
+	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
+	unsigned int val;
+
+	switch (mode) {
+	case AD_SD_MODE_SINGLE:
+	case AD_SD_MODE_CONTINUOUS:
+		val = 1;
+		break;
+	default:
+		val = 0;
+		break;
+	}
+
+	gpiod_set_value(st->powerdown_gpio, val);
+
+	return 0;
+}
+
+static int ad7780_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+	int voltage_uv;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		voltage_uv = regulator_get_voltage(st->reg);
+		if (voltage_uv < 0)
+			return voltage_uv;
+		*val = (voltage_uv / 1000) * st->gain;
+		*val2 = chan->scan_type.realbits - 1;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = -(1 << (chan->scan_type.realbits - 1));
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7780_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long m)
+{
+	struct ad7780_state *st = iio_priv(indio_dev);
+	const struct ad7780_chip_info *chip_info = st->chip_info;
+	int uvref, gain;
+	unsigned int full_scale;
+
+	if (!chip_info->is_ad778x)
+		return 0;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val != 0)
+			return -EINVAL;
+
+		uvref = regulator_get_voltage(st->reg);
+
+		if (uvref < 0)
+			return uvref;
+
+		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
+		gain = DIV_ROUND_CLOSEST(uvref, full_scale);
+		gain = DIV_ROUND_CLOSEST(gain, val2);
+
+		gpiod_set_value(st->gain_gpio, gain < AD7780_GAIN_MIDPOINT ? 0 : 1);
+	break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+
+		gpiod_set_value(st->filter_gpio, val < AD7780_FILTER_MIDPOINT ? 0 : 1);
+	break;
+	}
+
+	return 0;
+}
+
+static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
+				     unsigned int raw_sample)
+{
+	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
+	const struct ad7780_chip_info *chip_info = st->chip_info;
+	int val;
+
+	if ((raw_sample & AD7780_ERR) ||
+	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
+		return -EIO;
+
+	if (chip_info->is_ad778x) {
+		val = raw_sample & AD7780_GAIN;
+
+		if (val != gpiod_get_value(st->gain_gpio))
+			return -EIO;
+
+		if (val)
+			st->gain = 1;
+		else
+			st->gain = 128;
+	}
+
+	return 0;
+}
+
+static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
+	.set_mode = ad7780_set_mode,
+	.postprocess_sample = ad7780_postprocess_sample,
+	.has_registers = false,
+};
+
+#define AD7170_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+#define AD7780_CHANNEL(bits, wordsize) \
+	AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
+
+static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
+	[ID_AD7170] = {
+		.channel = AD7170_CHANNEL(12, 24),
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
+		.is_ad778x = false,
+	},
+	[ID_AD7171] = {
+		.channel = AD7170_CHANNEL(16, 24),
+		.pattern = AD7170_PATTERN,
+		.pattern_mask = AD7170_PATTERN_MASK,
+		.is_ad778x = false,
+	},
+	[ID_AD7780] = {
+		.channel = AD7780_CHANNEL(24, 32),
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
+		.is_ad778x = true,
+	},
+	[ID_AD7781] = {
+		.channel = AD7780_CHANNEL(20, 32),
+		.pattern = AD7780_PATTERN,
+		.pattern_mask = AD7780_PATTERN_MASK,
+		.is_ad778x = true,
+	},
+};
+
+static const struct iio_info ad7780_info = {
+	.read_raw = ad7780_read_raw,
+	.write_raw = ad7780_write_raw,
+};
+
+static int ad7780_probe(struct spi_device *spi)
+{
+	struct ad7780_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->gain = 1;
+
+	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
+
+	st->reg = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->reg))
+		return PTR_ERR(st->reg);
+
+	ret = regulator_enable(st->reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
+		return ret;
+	}
+
+	st->chip_info =
+		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
+
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &st->chip_info->channel;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad7780_info;
+
+	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
+						     "powerdown",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(st->powerdown_gpio)) {
+		ret = PTR_ERR(st->powerdown_gpio);
+		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
+			ret);
+		goto error_disable_reg;
+	}
+
+	if (st->chip_info->is_ad778x) {
+		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
+							"gain",
+							GPIOD_OUT_HIGH);
+		if (IS_ERR(st->gain_gpio)) {
+			ret = PTR_ERR(st->gain_gpio);
+			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
+				ret);
+			goto error_disable_reg;
+		}
+	}
+
+	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
+	if (ret)
+		goto error_disable_reg;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_cleanup_buffer_and_trigger;
+
+	return 0;
+
+error_cleanup_buffer_and_trigger:
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+error_disable_reg:
+	regulator_disable(st->reg);
+
+	return ret;
+}
+
+static int ad7780_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad7780_state *st = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	ad_sd_cleanup_buffer_and_trigger(indio_dev);
+
+	regulator_disable(st->reg);
+
+	return 0;
+}
+
+static const struct spi_device_id ad7780_id[] = {
+	{"ad7170", ID_AD7170},
+	{"ad7171", ID_AD7171},
+	{"ad7780", ID_AD7780},
+	{"ad7781", ID_AD7781},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad7780_id);
+
+static struct spi_driver ad7780_driver = {
+	.driver = {
+		.name	= "ad7780",
+	},
+	.probe		= ad7780_probe,
+	.remove		= ad7780_remove,
+	.id_table	= ad7780_id,
+};
+module_spi_driver(ad7780_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index fc23059f1673..4cd0a13a588c 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -37,19 +37,6 @@ config AD7606_IFACE_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7606_spi.
 
-config AD7780
-	tristate "Analog Devices AD7780 and similar ADCs driver"
-	depends on SPI
-	depends on GPIOLIB || COMPILE_TEST
-	select AD_SIGMA_DELTA
-	help
-	  Say yes here to build support for Analog Devices AD7170, AD7171,
-	  AD7780 and AD7781 SPI analog to digital converters (ADC).
-	  If unsure, say N (but it's safe to say "Y").
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7780.
-
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ebe83c1ad362..344002d87c78 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
 obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 
-obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7280) += ad7280a.o
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
deleted file mode 100644
index 05979a79fda3..000000000000
--- a/drivers/staging/iio/adc/ad7780.c
+++ /dev/null
@@ -1,347 +0,0 @@
-/*
- * AD7170/AD7171 and AD7780/AD7781 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/err.h>
-#include <linux/sched.h>
-#include <linux/gpio/consumer.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/adc/ad_sigma_delta.h>
-
-#define AD7780_RDY		BIT(7)
-#define AD7780_FILTER		BIT(6)
-#define AD7780_ERR		BIT(5)
-#define AD7780_ID1		BIT(4)
-#define AD7780_ID0		BIT(3)
-#define AD7780_GAIN		BIT(2)
-#define AD7780_PAT1		BIT(1)
-#define AD7780_PAT0		BIT(0)
-
-#define AD7780_PATTERN		(AD7780_PAT0)
-#define AD7780_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1)
-
-#define AD7170_PAT2		BIT(2)
-
-#define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
-#define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
-
-#define AD7780_GAIN_GPIO	0
-#define AD7780_FILTER_GPIO	1
-
-#define AD7780_GAIN_MIDPOINT	64
-#define AD7780_FILTER_MIDPOINT	13350
-
-struct ad7780_chip_info {
-	struct iio_chan_spec	channel;
-	unsigned int		pattern_mask;
-	unsigned int		pattern;
-	bool			is_ad778x;
-};
-
-struct ad7780_state {
-	const struct ad7780_chip_info	*chip_info;
-	struct regulator		*reg;
-	struct gpio_desc		*powerdown_gpio;
-	struct gpio_desc		*gain_gpio;
-	struct gpio_desc		*filter_gpio;
-	unsigned int	gain;
-
-	struct ad_sigma_delta sd;
-};
-
-enum ad7780_supported_device_ids {
-	ID_AD7170,
-	ID_AD7171,
-	ID_AD7780,
-	ID_AD7781,
-};
-
-static struct ad7780_state *ad_sigma_delta_to_ad7780(struct ad_sigma_delta *sd)
-{
-	return container_of(sd, struct ad7780_state, sd);
-}
-
-static int ad7780_set_mode(struct ad_sigma_delta *sigma_delta,
-			   enum ad_sigma_delta_mode mode)
-{
-	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
-	unsigned int val;
-
-	switch (mode) {
-	case AD_SD_MODE_SINGLE:
-	case AD_SD_MODE_CONTINUOUS:
-		val = 1;
-		break;
-	default:
-		val = 0;
-		break;
-	}
-
-	gpiod_set_value(st->powerdown_gpio, val);
-
-	return 0;
-}
-
-static int ad7780_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long m)
-{
-	struct ad7780_state *st = iio_priv(indio_dev);
-	int voltage_uv;
-
-	switch (m) {
-	case IIO_CHAN_INFO_RAW:
-		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
-	case IIO_CHAN_INFO_SCALE:
-		voltage_uv = regulator_get_voltage(st->reg);
-		if (voltage_uv < 0)
-			return voltage_uv;
-		*val = (voltage_uv / 1000) * st->gain;
-		*val2 = chan->scan_type.realbits - 1;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	case IIO_CHAN_INFO_OFFSET:
-		*val = -(1 << (chan->scan_type.realbits - 1));
-		return IIO_VAL_INT;
-	}
-
-	return -EINVAL;
-}
-
-static int ad7780_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long m)
-{
-	struct ad7780_state *st = iio_priv(indio_dev);
-	const struct ad7780_chip_info *chip_info = st->chip_info;
-	int uvref, gain;
-	unsigned int full_scale;
-
-	if (!chip_info->is_ad778x)
-		return 0;
-
-	switch (m) {
-	case IIO_CHAN_INFO_SCALE:
-		if (val != 0)
-			return -EINVAL;
-
-		uvref = regulator_get_voltage(st->reg);
-
-		if (uvref < 0)
-			return uvref;
-
-		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
-		gain = DIV_ROUND_CLOSEST(uvref, full_scale);
-		gain = DIV_ROUND_CLOSEST(gain, val2);
-
-		gpiod_set_value(st->gain_gpio, gain < AD7780_GAIN_MIDPOINT ? 0 : 1);
-	break;
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val2 != 0)
-			return -EINVAL;
-
-		gpiod_set_value(st->filter_gpio, val < AD7780_FILTER_MIDPOINT ? 0 : 1);
-	break;
-	}
-
-	return 0;
-}
-
-static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
-				     unsigned int raw_sample)
-{
-	struct ad7780_state *st = ad_sigma_delta_to_ad7780(sigma_delta);
-	const struct ad7780_chip_info *chip_info = st->chip_info;
-	int val;
-
-	if ((raw_sample & AD7780_ERR) ||
-	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
-		return -EIO;
-
-	if (chip_info->is_ad778x) {
-		val = raw_sample & AD7780_GAIN;
-
-		if (val != gpiod_get_value(st->gain_gpio))
-			return -EIO;
-
-		if (val)
-			st->gain = 1;
-		else
-			st->gain = 128;
-	}
-
-	return 0;
-}
-
-static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
-	.set_mode = ad7780_set_mode,
-	.postprocess_sample = ad7780_postprocess_sample,
-	.has_registers = false,
-};
-
-#define AD7170_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
-#define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_GAIN_FILTER(1, 0, 0, bits, 32, wordsize - bits)
-
-static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
-	[ID_AD7170] = {
-		.channel = AD7170_CHANNEL(12, 24),
-		.pattern = AD7170_PATTERN,
-		.pattern_mask = AD7170_PATTERN_MASK,
-		.is_ad778x = false,
-	},
-	[ID_AD7171] = {
-		.channel = AD7170_CHANNEL(16, 24),
-		.pattern = AD7170_PATTERN,
-		.pattern_mask = AD7170_PATTERN_MASK,
-		.is_ad778x = false,
-	},
-	[ID_AD7780] = {
-		.channel = AD7780_CHANNEL(24, 32),
-		.pattern = AD7780_PATTERN,
-		.pattern_mask = AD7780_PATTERN_MASK,
-		.is_ad778x = true,
-	},
-	[ID_AD7781] = {
-		.channel = AD7780_CHANNEL(20, 32),
-		.pattern = AD7780_PATTERN,
-		.pattern_mask = AD7780_PATTERN_MASK,
-		.is_ad778x = true,
-	},
-};
-
-static const struct iio_info ad7780_info = {
-	.read_raw = ad7780_read_raw,
-	.write_raw = ad7780_write_raw,
-};
-
-static int ad7780_probe(struct spi_device *spi)
-{
-	struct ad7780_state *st;
-	struct iio_dev *indio_dev;
-	int ret;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	st = iio_priv(indio_dev);
-	st->gain = 1;
-
-	ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
-
-	st->reg = devm_regulator_get(&spi->dev, "avdd");
-	if (IS_ERR(st->reg))
-		return PTR_ERR(st->reg);
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable specified AVdd supply\n");
-		return ret;
-	}
-
-	st->chip_info =
-		&ad7780_chip_info_tbl[spi_get_device_id(spi)->driver_data];
-
-	spi_set_drvdata(spi, indio_dev);
-
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = &st->chip_info->channel;
-	indio_dev->num_channels = 1;
-	indio_dev->info = &ad7780_info;
-
-	st->powerdown_gpio = devm_gpiod_get_optional(&spi->dev,
-						     "powerdown",
-						     GPIOD_OUT_LOW);
-	if (IS_ERR(st->powerdown_gpio)) {
-		ret = PTR_ERR(st->powerdown_gpio);
-		dev_err(&spi->dev, "Failed to request powerdown GPIO: %d\n",
-			ret);
-		goto error_disable_reg;
-	}
-
-	if (st->chip_info->is_ad778x) {
-		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
-							"gain",
-							GPIOD_OUT_HIGH);
-		if (IS_ERR(st->gain_gpio)) {
-			ret = PTR_ERR(st->gain_gpio);
-			dev_err(&spi->dev, "Failed to request gain GPIO: %d\n",
-				ret);
-			goto error_disable_reg;
-		}
-	}
-
-	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_cleanup_buffer_and_trigger;
-
-	return 0;
-
-error_cleanup_buffer_and_trigger:
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static int ad7780_remove(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad7780_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-	ad_sd_cleanup_buffer_and_trigger(indio_dev);
-
-	regulator_disable(st->reg);
-
-	return 0;
-}
-
-static const struct spi_device_id ad7780_id[] = {
-	{"ad7170", ID_AD7170},
-	{"ad7171", ID_AD7171},
-	{"ad7780", ID_AD7780},
-	{"ad7781", ID_AD7781},
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad7780_id);
-
-static struct spi_driver ad7780_driver = {
-	.driver = {
-		.name	= "ad7780",
-	},
-	.probe		= ad7780_probe,
-	.remove		= ad7780_remove,
-	.id_table	= ad7780_id,
-};
-module_spi_driver(ad7780_driver);
-
-MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD7780 and similar ADCs");
-MODULE_LICENSE("GPL v2");
-- 
2.19.1

