Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D419C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18120868
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 04:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="A22vnV6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F18120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeKROpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 09:45:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38384 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeKROpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 09:45:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id d19so43832178qkg.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 20:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E9xzUlEU1rhbmXS78V2VGOyRyzRSLYVFQFMiE3KfmVA=;
        b=A22vnV6+zm4MG5H7Xhha42mnFZSqHJqdiTTa+2CV5Kp6lpmBjfPNxisFnihidxn7fT
         bw7JhiB8Luau8F1cskgCtzCxSJEUORj5EK31ES9iBfwNTqrWengry8G2eLaavBMMMu9B
         PUo/NlJkEhUpQ4Ro2BLS+DEzBnFQLXzS6NNAH9/ZuHSx6CnW9rq8MN3O5RTXOKDlvBxY
         X/r0Y65WIKbNLtt55tirUuI19yNUZ+8zYfLCd8/eqw196NJHZ6LiDj7I+9AyMN1PFK90
         +D5s2AlqayCHFYM/TuYLg3JT6vY4wXUuXw9KmSgeX24R1jRCVNFGjLcgDodlpjAEETB8
         sE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E9xzUlEU1rhbmXS78V2VGOyRyzRSLYVFQFMiE3KfmVA=;
        b=FtcumNG310taEF9VEN7DhOXIke8jUFv3AkgdQ9bHs2USnBU9m+/lx3EExWmtyQGTTD
         Cm66j+lGYNQ+uinD2Hpv115Tc2Kn+FKk/ebK/FU2Tv2JozjqWHiUA+JOmUNawSkYfill
         3jdJ3iM01Kf7CQlr2hsYl2+9SXSoez3N0t+JmhqOee3EfoCQ1JEODPuRbJ7Dt2uPY48Z
         xgxkvNYNIlS8whvuqv+WND52t1IjNKzZ/xQoit+DKxjb19lljjxYF8IvFL8NYkSLJB9f
         cJ1rSu3JbUaJo12dj0eOtTUyLMBzaIm4a2uG+VKUM0vyNtEZmZyO2PVfPqa1v1mxXAZg
         LA9g==
X-Gm-Message-State: AGRZ1gL670CFE9vV2fTOV/zNCnJhFpgazjkwbVaMdRQGzEsQIPc96SEr
        YzhKt4YfKRd+aVs0x8BiPnvplg==
X-Google-Smtp-Source: AJdET5cpQoH6xSGsxGX2zoCPBdxygmgVHwhLzaZ2eSBFI31zevyFyAKK8QgGkk3Yd7+4A5WfybIkmQ==
X-Received: by 2002:a37:6d44:: with SMTP id i65mr15844794qkc.73.1542515199710;
        Sat, 17 Nov 2018 20:26:39 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id b6sm16112350qtq.29.2018.11.17.20.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 20:26:39 -0800 (PST)
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
Subject: [PATCH v2 7/7] staging:iio:ad2s90: Move out of staging
Date:   Sun, 18 Nov 2018 02:25:40 -0200
Message-Id: <20181118042540.12697-8-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181118042540.12697-1-matheus.bernardino@usp.br>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move ad2s90 resolver driver out of staging to the main tree.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
Signed-off-by: Victor Colombo <victorcolombo@gmail.com>
---
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
index 000000000000..f04dc5dede00
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
+		.of_match_table = of_match_ptr(ad2s90_of_match),
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
index f04dc5dede00..000000000000
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
-		.of_match_table = of_match_ptr(ad2s90_of_match),
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

