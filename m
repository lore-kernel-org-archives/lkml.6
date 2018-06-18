Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE8F208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Es2+e2vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE8F208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967464AbeFRJDh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:03:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35174 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966954AbeFRIcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:32:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so13903863wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 01:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xig+YgGUpoeKt6709Z5HEXuCGHUYfFQZJkHXzhcEUvY=;
        b=Es2+e2vqTZ0/YnhT+QFK5w/P9XzJDOukOuKqB0KOzW0tgLFB1i79spw6ryBPktunV3
         xwLeza5eK/vjuPGHLSNUT5NkEQp7BD4a+09z7wYsB8FSqpIADZyjsqmjVS5+O9O/qAl0
         jga0J2dlnXh2yNKPycLwYzP76r1/ypd3LO5hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xig+YgGUpoeKt6709Z5HEXuCGHUYfFQZJkHXzhcEUvY=;
        b=lIJo4jDBN7EJKOzVMxYm23/araxOqlayhxmB6RCBovOFi92dTeUEuX6FRTIyIkusrC
         pAnJXW0ZjpSQcMAwtu8GZZk67oEqBpRTauo2qx+ONKIXvU03EVEUa67E/1J//VH066DI
         4KByNHI2LIvsfOgGGEC9WJT9xXOba/BcvqYztqUIHb4D73Kn3Uw/Xv2saEUs3GiU6503
         8W3eOg++M0Qqm1p31qKn44RY/kLCABlWx3cq2r/4zo7+amOCNjMg+j/iX5do/2ol55pr
         1JiPeDQoprpb69GXzlSxtyFEdAcHsX30FjX7/4+pb2HbEfhSP0gaOLJxCTrrgz1dTr1U
         6Q3w==
X-Gm-Message-State: APt69E2TjwGFgGGO9uxGE6YxbiGzs7zSqLD60WFnZooI1pqAeaYCDMJp
        7BAwoONIcNcSyaE8M6JWuwbs0A==
X-Google-Smtp-Source: ADUXVKIKj7JCqld1R9+wWSct2l5Id7CqRB899c4KsS3HawplG2Lzi4tp9JoTNpeg2nUpII9TwAcdEQ==
X-Received: by 2002:a50:a624:: with SMTP id d33-v6mr10342895edc.8.1529310741693;
        Mon, 18 Jun 2018 01:32:21 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r10-v6sm6261992edo.77.2018.06.18.01.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jun 2018 01:32:21 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2 3/3] thermal: broadcom: Add Stingray thermal driver
Date:   Mon, 18 Jun 2018 14:01:19 +0530
Message-Id: <1529310679-13482-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
References: <1529310679-13482-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Adds stingray thermal driver to monitor six
thermal zones temperature and trips at critical temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/thermal/Kconfig               |   3 +-
 drivers/thermal/broadcom/Kconfig      |   9 ++
 drivers/thermal/broadcom/Makefile     |   1 +
 drivers/thermal/broadcom/sr-thermal.c | 151 ++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+), 1 deletion(-)
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 8297988..26d39d4 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -416,7 +416,8 @@ config MTK_THERMAL
 	  controller present in Mediatek SoCs
 
 menu "Broadcom thermal drivers"
-depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+depends on ARCH_BCM || ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM_IPROC || \
+		COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
 endmenu
 
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index c106a15..dc9a9bd 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -22,3 +22,12 @@ config BCM_NS_THERMAL
 	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
 	  Management Unit) block with a thermal sensor that allows checking CPU
 	  temperature.
+
+config BCM_SR_THERMAL
+	tristate "Stingray thermal driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default ARCH_BCM_IPROC
+	help
+	  Support for the Stingray family of SoCs. Its different blocks like
+	  iHost, CRMU and NITRO has thermal sensor that allows checking its
+	  temperature.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
index fae10ec..79df69e 100644
--- a/drivers/thermal/broadcom/Makefile
+++ b/drivers/thermal/broadcom/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_BCM2835_THERMAL)		+= bcm2835_thermal.o
 obj-$(CONFIG_BRCMSTB_THERMAL)		+= brcmstb_thermal.o
 obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
+obj-$(CONFIG_BCM_SR_THERMAL)		+= sr-thermal.o
diff --git a/drivers/thermal/broadcom/sr-thermal.c b/drivers/thermal/broadcom/sr-thermal.c
new file mode 100644
index 0000000..362dcda
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define TMON_CRIT_TEMP 105000 /* temp in millidegree C */
+
+struct sr_thermal {
+	struct thermal_zone_device *tz;
+	struct device *dev;
+	void __iomem *regs;
+	unsigned int crit_temp;
+};
+
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	*temp = readl(sr_thermal->regs);
+
+	return 0;
+}
+
+static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
+					enum thermal_trip_type *type)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		*type = THERMAL_TRIP_CRITICAL;
+		break;
+	default:
+		dev_dbg(sr_thermal->dev,
+			"Driver does not support more than 1 trip point\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sr_get_trip_temp(struct thermal_zone_device *tz, int trip, int *temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		*temp = sr_thermal->crit_temp;
+		break;
+	default:
+		dev_dbg(sr_thermal->dev,
+			"Driver does not support more than 1 trip point\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int sr_set_trip_temp(struct thermal_zone_device *tz, int trip, int temp)
+{
+	struct sr_thermal *sr_thermal = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		/*
+		 * Allow the user to change critical temperature
+		 * as per their requirement, could be for debug
+		 * purpose, even if it's more than the recommended
+		 * critical temperature.
+		 */
+		sr_thermal->crit_temp = temp;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct thermal_zone_device_ops sr_thermal_ops = {
+	.get_temp = sr_get_temp,
+	.get_trip_type = sr_get_trip_type,
+	.get_trip_temp = sr_get_trip_temp,
+	.set_trip_temp = sr_set_trip_temp,
+};
+
+static int sr_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct sr_thermal *sr_thermal;
+	struct resource *res;
+
+	sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
+	if (!sr_thermal)
+		return -ENOMEM;
+	sr_thermal->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	sr_thermal->regs = (void __iomem *)devm_memremap(&pdev->dev, res->start,
+					 resource_size(res), MEMREMAP_WB);
+	if (IS_ERR(sr_thermal->regs)) {
+		dev_err(dev, "failed to get io address\n");
+		return PTR_ERR(sr_thermal->regs);
+	}
+
+	/* initialize tmon value to 0 */
+	writel(0, sr_thermal->regs);
+	sr_thermal->crit_temp = TMON_CRIT_TEMP;
+
+	sr_thermal->tz = thermal_zone_device_register(dev_name(dev), 1, 1,
+							 sr_thermal,
+							 &sr_thermal_ops,
+							 NULL, 1000, 1000);
+	if (IS_ERR(sr_thermal->tz))
+		return PTR_ERR(sr_thermal->tz);
+
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+}
+
+static int sr_thermal_remove(struct platform_device *pdev)
+{
+	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
+
+	thermal_zone_device_unregister(sr_thermal->tz);
+
+	return 0;
+}
+
+static const struct of_device_id sr_thermal_of_match[] = {
+	{ .compatible = "brcm,sr-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sr_thermal_of_match);
+
+static struct platform_driver sr_thermal_driver = {
+	.probe		= sr_thermal_probe,
+	.remove		= sr_thermal_remove,
+	.driver = {
+		.name = "sr-thermal",
+		.of_match_table = sr_thermal_of_match,
+	},
+};
+module_platform_driver(sr_thermal_driver);
+
+MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
+MODULE_DESCRIPTION("Stingray thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

