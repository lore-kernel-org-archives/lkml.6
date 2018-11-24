Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9ABC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B34C20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 00:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="CBrtsAvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B34C20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeKXLKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 06:10:17 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43733 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbeKXLKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 06:10:16 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so9290158qkr.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 16:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pJBvj02i0VkD5L/mBVayKNNmL/HqK+c9PCM06oI2TpY=;
        b=CBrtsAvt7jHP6wt0XsxXb/FQ5D4ki+ESm9HTjXFrZ3C31IhUNTlOKkIlUQd0gZ3uXu
         8Y+AtzfzIVVvtUxJg7NofBfa3pe7oDDjEl4TmGDFeTUJ0scdWc6UAFGdqdtoLAG7MWFb
         HH45f7A1207aC942bLn7esmDvIKVuBAk0Ht8hfcuCcUdOHlhbJCbIjmIRdG9YE5BqIo4
         +OlMxcVtnyXygff4vU6kqrQTJyaE2MAVUNQKgSXhvFKwevXRVfER4t2Oipk9CgSI45jr
         yHz9iBDZbVAYF631iW2vUS71NtfVoH19HMzj7FQxQ+gU6FUNfOB/fQJ4OfPJQqlolZN1
         Mkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pJBvj02i0VkD5L/mBVayKNNmL/HqK+c9PCM06oI2TpY=;
        b=JMHRK7HUjGbNXjqkz40Xfe4MY1qS4FatMEuBnn5xG/xNu3CX+NIXJBj8kneOqRqerT
         vagKNdskySEKDT6FGYSERwrkQu+723Olpj+HwZYdM3S8lNzn/rIwNWsC/AdibKmir8v0
         vfCBfG3BNP67PU2kYvvKfuldUxwQXaoq9Advj7GKEinCos+7M0ehmH0ES1tq8VTOI0TY
         zRVZiCAHmmN9gFyk5LOp0GklrM26kPkqHaU6j4Z3av9bfeGII0tXeOlwGEEA4NqcjXci
         /vToGgBmJaaWyHkwzA328xuM93TPhjUNQdTwKTlKJ3SMzQe77ngz7cf9xAc5ESQGX8bq
         28Zg==
X-Gm-Message-State: AA+aEWa71ot70xplGGwtNgxycFcZx9cMKCYkZBRsyfQTc0z6yA7XRAet
        MZARtNRKkOBEq876zKVF9JptCQ==
X-Google-Smtp-Source: AFSGD/UrS8DXs2EABppyYrTiOcVbK+OYsKt7TGgFJXk4QGwU5neqnQ1QU1D3I/qOZp62dnZZoFh7RA==
X-Received: by 2002:a37:4a47:: with SMTP id x68mr16519349qka.112.1543019034555;
        Fri, 23 Nov 2018 16:23:54 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id o34sm26707515qte.4.2018.11.23.16.23.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 16:23:54 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com
Subject: [PATCH v3 7/7] staging:iio:ad2s90: Move out of staging
Date:   Fri, 23 Nov 2018 22:23:12 -0200
Message-Id: <20181124002312.6923-8-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad2s90 resolver driver out of staging to the main tree.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
Changes in v3:
 - none

Changes in v2:
 - Disabled git move detection, to see the whole code, as Jonathan
 suggested

 drivers/iio/resolver/Kconfig          |  10 ++
 drivers/iio/resolver/Makefile         |   1 +
 drivers/iio/resolver/ad2s90.c         | 131 ++++++++++++++++++++++++++
 drivers/staging/iio/resolver/Kconfig  |  10 --
 drivers/staging/iio/resolver/Makefile |   1 -
 drivers/staging/iio/resolver/ad2s90.c | 131 --------------------------
 6 files changed, 142 insertions(+), 142 deletions(-)
 create mode 100644 drivers/iio/resolver/ad2s90.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s90.c

diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
index 2ced9f22aa70..786801be54f6 100644
--- a/drivers/iio/resolver/Kconfig
+++ b/drivers/iio/resolver/Kconfig
@@ -3,6 +3,16 @@
 #
 menu "Resolver to digital converters"
 
+config AD2S90
+	tristate "Analog Devices ad2s90 driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices spi resolver
+	  to digital converters, ad2s90, provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad2s90.
+
 config AD2S1200
 	tristate "Analog Devices ad2s1200/ad2s1205 driver"
 	depends on SPI
diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
index 4e1dccae07e7..398d82d50028 100644
--- a/drivers/iio/resolver/Makefile
+++ b/drivers/iio/resolver/Makefile
@@ -2,4 +2,5 @@
 # Makefile for Resolver/Synchro drivers
 #
 
+obj-$(CONFIG_AD2S90) += ad2s90.o
 obj-$(CONFIG_AD2S1200) += ad2s1200.o
diff --git a/drivers/iio/resolver/ad2s90.c b/drivers/iio/resolver/ad2s90.c
new file mode 100644
index 000000000000..a41f5cb10da5
--- /dev/null
+++ b/drivers/iio/resolver/ad2s90.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
+ *
+ * Copyright (c) 2010-2010 Analog Devices Inc.
+ */
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+/*
+ * Although chip's max frequency is 2Mhz, it needs 600ns between CS and the
+ * first falling edge of SCLK, so frequency should be at most 1 / (2 * 6e-7)
+ */
+#define AD2S90_MAX_SPI_FREQ_HZ  830000
+
+struct ad2s90_state {
+	struct mutex lock; /* lock to protect rx buffer */
+	struct spi_device *sdev;
+	u8 rx[2] ____cacheline_aligned;
+};
+
+static int ad2s90_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	int ret;
+	struct ad2s90_state *st = iio_priv(indio_dev);
+
+	if (chan->type != IIO_ANGL)
+		return -EINVAL;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		/* 2 * Pi / 2^12 */
+		*val = 6283; /* mV */
+		*val2 = 12;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = spi_read(st->sdev, st->rx, 2);
+		if (ret < 0) {
+			mutex_unlock(&st->lock);
+			return ret;
+		}
+		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+
+		mutex_unlock(&st->lock);
+
+		return IIO_VAL_INT;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info ad2s90_info = {
+	.read_raw = ad2s90_read_raw,
+};
+
+static const struct iio_chan_spec ad2s90_chan = {
+	.type = IIO_ANGL,
+	.indexed = 1,
+	.channel = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+};
+
+static int ad2s90_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad2s90_state *st;
+
+	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
+		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
+			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
+		return -EINVAL;
+	}
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	mutex_init(&st->lock);
+	st->sdev = spi;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ad2s90_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &ad2s90_chan;
+	indio_dev->num_channels = 1;
+	indio_dev->name = spi_get_device_id(spi)->name;
+
+	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+}
+
+static const struct of_device_id ad2s90_of_match[] = {
+	{ .compatible = "adi,ad2s90", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad2s90_of_match);
+
+static const struct spi_device_id ad2s90_id[] = {
+	{ "ad2s90" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad2s90_id);
+
+static struct spi_driver ad2s90_driver = {
+	.driver = {
+		.name = "ad2s90",
+		.of_match_table = ad2s90_of_match,
+	},
+	.probe = ad2s90_probe,
+	.id_table = ad2s90_id,
+};
+module_spi_driver(ad2s90_driver);
+
+MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD2S90 Resolver to Digital SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6a469ee6101f..4a727c17bb8f 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -3,16 +3,6 @@
 #
 menu "Resolver to digital converters"
 
-config AD2S90
-	tristate "Analog Devices ad2s90 driver"
-	depends on SPI
-	help
-	  Say yes here to build support for Analog Devices spi resolver
-	  to digital converters, ad2s90, provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad2s90.
-
 config AD2S1210
 	tristate "Analog Devices ad2s1210 driver"
 	depends on SPI
diff --git a/drivers/staging/iio/resolver/Makefile b/drivers/staging/iio/resolver/Makefile
index 8d901dc7500b..b2049f2ce36e 100644
--- a/drivers/staging/iio/resolver/Makefile
+++ b/drivers/staging/iio/resolver/Makefile
@@ -2,5 +2,4 @@
 # Makefile for Resolver/Synchro drivers
 #
 
-obj-$(CONFIG_AD2S90) += ad2s90.o
 obj-$(CONFIG_AD2S1210) += ad2s1210.o
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
deleted file mode 100644
index a41f5cb10da5..000000000000
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ /dev/null
@@ -1,131 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * ad2s90.c simple support for the ADI Resolver to Digital Converters: AD2S90
- *
- * Copyright (c) 2010-2010 Analog Devices Inc.
- */
-#include <linux/types.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/module.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-
-/*
- * Although chip's max frequency is 2Mhz, it needs 600ns between CS and the
- * first falling edge of SCLK, so frequency should be at most 1 / (2 * 6e-7)
- */
-#define AD2S90_MAX_SPI_FREQ_HZ  830000
-
-struct ad2s90_state {
-	struct mutex lock; /* lock to protect rx buffer */
-	struct spi_device *sdev;
-	u8 rx[2] ____cacheline_aligned;
-};
-
-static int ad2s90_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long m)
-{
-	int ret;
-	struct ad2s90_state *st = iio_priv(indio_dev);
-
-	if (chan->type != IIO_ANGL)
-		return -EINVAL;
-
-	switch (m) {
-	case IIO_CHAN_INFO_SCALE:
-		/* 2 * Pi / 2^12 */
-		*val = 6283; /* mV */
-		*val2 = 12;
-		return IIO_VAL_FRACTIONAL_LOG2;
-	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&st->lock);
-		ret = spi_read(st->sdev, st->rx, 2);
-		if (ret < 0) {
-			mutex_unlock(&st->lock);
-			return ret;
-		}
-		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-
-		mutex_unlock(&st->lock);
-
-		return IIO_VAL_INT;
-	default:
-		break;
-	}
-
-	return -EINVAL;
-}
-
-static const struct iio_info ad2s90_info = {
-	.read_raw = ad2s90_read_raw,
-};
-
-static const struct iio_chan_spec ad2s90_chan = {
-	.type = IIO_ANGL,
-	.indexed = 1,
-	.channel = 0,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-};
-
-static int ad2s90_probe(struct spi_device *spi)
-{
-	struct iio_dev *indio_dev;
-	struct ad2s90_state *st;
-
-	if (spi->max_speed_hz > AD2S90_MAX_SPI_FREQ_HZ) {
-		dev_err(&spi->dev, "SPI CLK, %d Hz exceeds %d Hz\n",
-			spi->max_speed_hz, AD2S90_MAX_SPI_FREQ_HZ);
-		return -EINVAL;
-	}
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev)
-		return -ENOMEM;
-	st = iio_priv(indio_dev);
-	spi_set_drvdata(spi, indio_dev);
-
-	mutex_init(&st->lock);
-	st->sdev = spi;
-	indio_dev->dev.parent = &spi->dev;
-	indio_dev->info = &ad2s90_info;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = &ad2s90_chan;
-	indio_dev->num_channels = 1;
-	indio_dev->name = spi_get_device_id(spi)->name;
-
-	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
-}
-
-static const struct of_device_id ad2s90_of_match[] = {
-	{ .compatible = "adi,ad2s90", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, ad2s90_of_match);
-
-static const struct spi_device_id ad2s90_id[] = {
-	{ "ad2s90" },
-	{}
-};
-MODULE_DEVICE_TABLE(spi, ad2s90_id);
-
-static struct spi_driver ad2s90_driver = {
-	.driver = {
-		.name = "ad2s90",
-		.of_match_table = ad2s90_of_match,
-	},
-	.probe = ad2s90_probe,
-	.id_table = ad2s90_id,
-};
-module_spi_driver(ad2s90_driver);
-
-MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD2S90 Resolver to Digital SPI driver");
-MODULE_LICENSE("GPL v2");
-- 
2.18.0

