Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-336646-1525448786-2-13227594653265429514
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525448785; b=Ojc4+/n+rkslK4Q2/QkfEF05+GBUM1datEnKdWBXpLThgRAZ4V
    QBTM+qkgZgRH8byQmZ02d8r9tuRUlzlAxhFiwlfHWgAAEXSPofDU5qAkjl3gdtzd
    VhddJEM9oBfGN3R+1347OyV6B1nJ8Y30vum2kM5sexyVpIkHtgT1rjkN+xzvWAL4
    JsDVZF249YZDo5HEl+vUb5rm9EA+7/uIsufmGE087Xj2Z3OtT6XvS/SP8fum+t0g
    z6r/mVcWzhqetC6Tjud/3p6wl94CR7qYyfnBkLnScgJjg7wDaWn+JysLfwxHDFCC
    8os5X+2S/TWkXjCZaCu9tz0fY7/eqDGVQ5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525448785; bh=0ixiStglR1eFNY4kuD020bk98i/EZ7
    9Q/FleJjYRkmc=; b=gjp7deVhINcTnNNv93Vbe7am697+JTnd/jRPwpi0DcCV+J
    O2Tf+1EbfgvD2+i1lIKnIqx1aJGE54inALWJ5UlSDvC/hTbEubH2kOHjeBsL1gGV
    qeBqwgPXBb92dhiuIY9E60saL/KdHSuKh5Cr4XHHe6C3qB8yZpu6eNmVDhckfwc5
    m22kqPWI++1N+bU16BU21wLfbyf+ZMgo192yFyhXnCzrGtJoF0lik3oorOGUtqmo
    cFafPZJVn7viwofDmfmltA+Pa91cSuvU+anygZQwNe4bwj6nxPwU8A3uLiTmzInG
    Z9lxr2z33JERJn4zRFYsa1r0vOGliz4X9p/hJbtw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfG03kjqv/HvLjnSPJ5qbC8PJtzypdPVIx4owxGZjwuLn+W1kgEYT4QySX/kDzsC1XcO4vWFdiN9a3TKn0kYzd2Jp5xs2Krzp4CvvhZs3mQd26nz9k9t1
    L/Z9G5ZqBnEI1wsELXt4eOXVGt9l2N6WjY6qKDnWE/opM12TJXDoR1AMM7pJ+gXXUQF8fw+/3krUKB0PxGrnrlgQL9weHfA7+2A+KoCM4mPmZDHOs717OO21
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8
    a=VwQbUJbxAAAA:8 a=OnUtjZ6cSmIPTM4q2h0A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEDPqV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 11:46:21 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51559 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeEDPqU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 11:46:20 -0400
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="13799020"
From: Radu Pirea <radu.pirea@microchip.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
CC: <lee.jones@linaro.org>, <broonie@kernel.org>,
        <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <jslaby@suse.com>, <gregkh@linuxfoundation.org>,
        <richard.genoud@gmail.com>, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 2/6] mfd: at91-usart: added mfd driver for usart
Date: Fri, 4 May 2018 18:47:10 +0300
Message-ID: <20180504154714.5109-3-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180504154714.5109-1-radu.pirea@microchip.com>
References: <20180504154714.5109-1-radu.pirea@microchip.com>
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
 drivers/mfd/at91-usart.c             | 81 ++++++++++++++++++++++++++++
 include/dt-bindings/mfd/at91-usart.h | 17 ++++++
 4 files changed, 109 insertions(+)
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
index 000000000000..cd8f020ca7c0
--- /dev/null
+++ b/drivers/mfd/at91-usart.c
@@ -0,0 +1,81 @@
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
+	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, &cell, 1,
+			      NULL, 0, NULL);
+	if (err) {
+		dev_err(&pdev->dev, "failed to add subdevices\n");
+		return err;
+	}
+
+	return devm_of_platform_populate(&pdev->dev);
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

