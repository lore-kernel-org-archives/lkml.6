Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752413-1526035053-2-9234287920095051917
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526035053; b=H5BnlFrL4d9o8P6FiipE4cygTI+Y7XoYm9WHM4TMc230qppbel
    B8zKKCOvS3dqimCHR7b2k36up8SB0kg1itpP8EOY+wMKjOPM8eW++fmpVjtzsey3
    RivIwonvCjWHJuBQydEWbHBp8UvSuWup6034klixa15EVLPzYdxW2bDOKKz4mHnk
    gf45E2S99UX8XiCHYuHGHDM8QQiEC9X0l/B+buLM22QbJV4JlmhJKIRDmQiF7cYu
    wsol+ZzIeebaO0TF6MEYXqWkPcsxI8sG2hoHT9fV2mqjjLDJdUquhmJ7OSK0X0Jd
    T58s7LkgP9/us+E5S3JEGzcJC6qSqU4ZvtWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526035053; bh=qOzf1xxS1Y5D98xcvOmNCNA6NOSXX6
    HojvSTSTxgfa8=; b=JLQuzco4zDBZ/zu4KTysX7Cxa95QkuS5sgaRhd9XZQSUba
    42FR3gdAhgX984ujgh60JHRtjs4vljPjNeQZNrrTixCU2RZPk118oiOccJlD7ELp
    r93f+q1eoB0WILlzoiSM8XF6tFDjGbr/O40dqAT6Qs2SCAUl+A2lK/iNzvBEVmVL
    mGv3i+QqHheXEZvyNNpGDcd/HOkr/xgKHn2H+e7XdnDnsb6ch0aYmAVb9dSn5lID
    MvJTaSCDmfDYRhfbqCvfGdL6SsO8IRIdHcZNLP8yymXe2nFxh/blK0TMCqxuM/gS
    fAEBFxZrlcEfhrlMssSSGLZHguFQVDqXMmH9dmrA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExYR+DdMZNZg92bs2AfytEYViPByXrfqOBEyaRZfmR/iuhpxDQiB34KftIqQk2HTzy/SO8Jj+I5c+D8Nbeljhiq0J6FsuuVL2T7ZJxrPEolACN4/vfI
    X+x4RQJQ45i28+HAM0mFFCWYIHzooNS0KkSQ5HdueACCFMcKT2yeE30KO2RAR4c8El0obY72ZYfEHdmKcYyiA8CKMRbkGgTPpFOBPWjPWBqwLOTwjYW3WRt0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=LrSvkQvHSLCXFAm1RHcA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753019AbeEKKh3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:37:29 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:3481 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeEKKhY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 May 2018 06:37:24 -0400
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="11960899"
From: Radu Pirea <radu.pirea@microchip.com>
To: <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC: <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <lee.jones@linaro.org>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <broonie@kernel.org>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v3 2/6] mfd: at91-usart: added mfd driver for usart
Date: Fri, 11 May 2018 13:38:18 +0300
Message-ID: <20180511103822.31698-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511103822.31698-1-radu.pirea@microchip.com>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This mfd driver is just a wrapper over atmel_serial driver and
spi-at91-usart driver. Selection of one of the drivers is based on a
property from device tree. If the property is not specified, the default
driver is atmel_serial.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 drivers/mfd/Kconfig                  | 10 ++++
 drivers/mfd/Makefile                 |  1 +
 drivers/mfd/at91-usart.c             | 75 ++++++++++++++++++++++++++++
 include/dt-bindings/mfd/at91-usart.h | 17 +++++++
 4 files changed, 103 insertions(+)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..de99b79061b7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -99,6 +99,16 @@ config MFD_AAT2870_CORE
 	  additional drivers must be enabled in order to use the
 	  functionality of the device.
 
+config MFD_AT91_USART
+	tristate "AT91 USART Driver"
+	select MFD_CORE
+	depends on OF
+	help
+	  Select this to get support for AT91 USART IP. This is a wrapper
+	  over at91-usart-serial driver and usart-spi-driver. Only one function
+	  can be used at a time. The choice is done at boot time by the probe
+	  function of this MFD driver according to a device tree property.
+
 config MFD_ATMEL_FLEXCOM
 	tristate "Atmel Flexcom (Flexible Serial Communication Unit)"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..db1332aa96db 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_MFD_SPMI_PMIC)	+= qcom-spmi-pmic.o
 obj-$(CONFIG_TPS65911_COMPARATOR)	+= tps65911-comparator.o
 obj-$(CONFIG_MFD_TPS65090)	+= tps65090.o
 obj-$(CONFIG_MFD_AAT2870_CORE)	+= aat2870-core.o
+obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
new file mode 100644
index 000000000000..87094463f8f4
--- /dev/null
+++ b/drivers/mfd/at91-usart.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Driver for AT91 USART
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#include <dt-bindings/mfd/at91-usart.h>
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+static struct mfd_cell at91_usart_spi_subdev = {
+		.name = "at91_usart_spi",
+		.of_compatible = "microchip,at91sam9g45-usart-spi",
+	};
+
+static struct mfd_cell at91_usart_serial_subdev = {
+		.name = "atmel_usart_serial",
+		.of_compatible = "atmel,at91rm9200-usart-serial",
+	};
+
+static int at91_usart_mode_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct mfd_cell cell;
+	u32 opmode;
+	int err;
+
+	err = of_property_read_u32(np, "at91,usart-mode", &opmode);
+
+	switch (opmode) {
+	case AT91_USART_MODE_SPI:
+		cell = at91_usart_spi_subdev;
+		break;
+	case AT91_USART_MODE_SERIAL:
+	default:
+		cell = at91_usart_serial_subdev;
+	}
+
+	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
+			      NULL, 0, NULL);
+}
+
+static const struct of_device_id at91_usart_mode_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-usart" },
+	{ .compatible = "atmel,at91sam9260-usart" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, at91_flexcom_of_match);
+
+static struct platform_driver at91_usart_mfd = {
+	.probe	= at91_usart_mode_probe,
+	.driver	= {
+		.name		= "at91_usart_mode",
+		.of_match_table	= at91_usart_mode_of_match,
+	},
+};
+
+module_platform_driver(at91_usart_mfd);
+
+MODULE_AUTHOR("Radu Pirea <radu.pirea@microchip.com>");
+MODULE_DESCRIPTION("AT91 USART MFD driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/mfd/at91-usart.h b/include/dt-bindings/mfd/at91-usart.h
new file mode 100644
index 000000000000..ac811628a42d
--- /dev/null
+++ b/include/dt-bindings/mfd/at91-usart.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides macros for AT91 USART DT bindings.
+ *
+ * Copyright (C) 2018 Microchip Technology
+ *
+ * Author: Radu Pirea <radu.pirea@microchip.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_AT91_USART_H__
+#define __DT_BINDINGS_AT91_USART_H__
+
+#define AT91_USART_MODE_SERIAL	1
+#define AT91_USART_MODE_SPI	2
+
+#endif /* __DT_BINDINGS_AT91_USART_H__ */
-- 
2.17.0

