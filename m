Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437A6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA68521D6A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Nyr7ldUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA68521D6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeHIPU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:20:28 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40336 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbeHIPU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:20:28 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so3905040qkd.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pwKuGIKGoGlrszJZ6X3MOmT3lWrhJ59QQQ9Z1zp1XAU=;
        b=Nyr7ldUC0mwIknUi0rHCW7A6jz1NUSvELaM9ag+BZjV3PW4ZEq9JAkNqGjj1kJ8FYJ
         Mm+dsY34w5F1mQ/wUUZFXM06nOIvoFgkaJ2FIiz+eSoQ+BNv6Kl0B/TntCTqDruYszkh
         KRiJPz+4w9ivmv91oucTUYt7idq0au0To8DzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pwKuGIKGoGlrszJZ6X3MOmT3lWrhJ59QQQ9Z1zp1XAU=;
        b=Lp9bASY8akitZArAtL7h28neGkxhN8hc7LUvHvjoUVxI2Yh3+DPlh3bF+TvYW84Kek
         7627U7LnIVOTYoU6oLaeUZUYcDw6umTV98KA6iTVNBd9gRmrr1Leq7y8gDdWt1+ozSU0
         Qx/R+ZFO4e/lHp/ZBXUeAjoxGojiK8jQND48YWbgtjax4K9O2ijK29Y8zPNJo1HG5ikK
         h3ZtT5apd6Iaa9TUVkxHEIDfAJCFFmduivy9BGYPGF+K0zzZK0sVYwblR++7cXc9evPC
         1KeyefPtLGvieU8XKWMlFFAms3rMrhswJHCuy47urzMYCCZvpkvbGRLIOMu4cdh3R6ZV
         +igQ==
X-Gm-Message-State: AOUpUlHAdaaUUUa6X5/Hww0RKx7Qj+rFoPpUAtX+2j4vEZwbC/TsqlmS
        NgH2IhmF+SzVbX6tEwK9bevukw==
X-Google-Smtp-Source: AA+uWPwhUUCNbvGlFsYLtPYlDzHqjHQLqsvQYlTk3UUjHQxV87RG6rvS2D87LXKoKMHxP5fgKTVUcw==
X-Received: by 2002:a37:1649:: with SMTP id g70-v6mr1617149qkh.137.1533819339998;
        Thu, 09 Aug 2018 05:55:39 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id q51-v6sm4933654qta.92.2018.08.09.05.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Aug 2018 05:55:39 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 3/3] thermal: broadcom: Add Stingray thermal driver
Date:   Thu,  9 Aug 2018 18:24:59 +0530
Message-Id: <1533819299-3401-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
References: <1533819299-3401-1-git-send-email-srinath.mannam@broadcom.com>
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
 drivers/thermal/broadcom/sr-thermal.c | 216 ++++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)
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
index 0000000..909f80c
--- /dev/null
+++ b/drivers/thermal/broadcom/sr-thermal.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Broadcom
+ */
+
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define TMON_CRIT_TEMP          105000 /* temp in millidegree C */
+#define SR_TMON_MAX_LIST        6
+
+/*
+ * In stingray thermal IO memory,
+ * Total Number of available TMONs MASK is at offset 0
+ * temperature registers BASE is at 4 byte offset.
+ * Each TMON temperature register size is 4.
+ */
+#define SR_TMON_TEMP_BASE(id)   ((id) * 0x4)
+
+static const char * const sr_tmon_names[SR_TMON_MAX_LIST] = {
+	"sr_tmon_ihost0",
+	"sr_tmon_ihost1",
+	"sr_tmon_ihost2",
+	"sr_tmon_ihost3",
+	"sr_tmon_crmu",
+	"sr_tmon_nitro",
+};
+
+struct sr_tmon {
+	struct thermal_zone_device *tz;
+	unsigned int crit_temp;
+	unsigned int tmon_id;
+	struct sr_thermal *priv;
+};
+
+struct sr_thermal {
+	struct device *dev;
+	void __iomem *regs;
+	struct sr_tmon tmon[SR_TMON_MAX_LIST];
+};
+
+static int sr_get_temp(struct thermal_zone_device *tz, int *temp)
+{
+	struct sr_tmon *tmon = tz->devdata;
+	struct sr_thermal *sr_thermal = tmon->priv;
+
+	*temp = readl(sr_thermal->regs + SR_TMON_TEMP_BASE(tmon->tmon_id));
+
+	return 0;
+}
+
+static int sr_get_trip_type(struct thermal_zone_device *tz, int trip,
+					enum thermal_trip_type *type)
+{
+	struct sr_tmon *tmon = tz->devdata;
+	struct sr_thermal *sr_thermal = tmon->priv;
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
+	struct sr_tmon *tmon = tz->devdata;
+	struct sr_thermal *sr_thermal = tmon->priv;
+
+	switch (trip) {
+	case 0:
+		*temp = tmon->crit_temp;
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
+	struct sr_tmon *tmon = tz->devdata;
+
+	switch (trip) {
+	case 0:
+		/*
+		 * Allow the user to change critical temperature
+		 * as per their requirement, could be for debug
+		 * purpose, even if it's more than the recommended
+		 * critical temperature.
+		 */
+		tmon->crit_temp = temp;
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
+	struct sr_tmon *tmon;
+	struct resource *res;
+	uint32_t sr_tmon_list = 0;
+	unsigned int i;
+	int ret;
+
+	sr_thermal = devm_kzalloc(dev, sizeof(*sr_thermal), GFP_KERNEL);
+	if (!sr_thermal)
+		return -ENOMEM;
+
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
+	ret = device_property_read_u32(dev, "brcm,tmon-mask", &sr_tmon_list);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < SR_TMON_MAX_LIST; i++) {
+
+		if (!(sr_tmon_list & BIT(i)))
+			continue;
+
+		/* Flush temperature registers */
+		writel(0, sr_thermal->regs + SR_TMON_TEMP_BASE(i));
+		tmon = &sr_thermal->tmon[i];
+		tmon->crit_temp = TMON_CRIT_TEMP;
+		tmon->tmon_id = i;
+		tmon->priv = sr_thermal;
+		tmon->tz = thermal_zone_device_register(sr_tmon_names[i],
+				1, 1,
+				tmon,
+				&sr_thermal_ops,
+				NULL, 1000, 1000);
+		if (IS_ERR(tmon->tz))
+			goto err_exit;
+
+		dev_info(dev, "%s: registered\n", sr_tmon_names[i]);
+	}
+	platform_set_drvdata(pdev, sr_thermal);
+
+	return 0;
+
+err_exit:
+	while (--i >= 0) {
+		if (sr_thermal->tmon[i].tz)
+			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
+	}
+
+	return PTR_ERR(tmon->tz);
+}
+
+static int sr_thermal_remove(struct platform_device *pdev)
+{
+	struct sr_thermal *sr_thermal = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < SR_TMON_MAX_LIST; i++)
+		if (sr_thermal->tmon[i].tz)
+			thermal_zone_device_unregister(sr_thermal->tmon[i].tz);
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
+static const struct acpi_device_id sr_thermal_acpi_ids[] = {
+	{ .id = "BRCM0500" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(acpi, sr_thermal_acpi_ids);
+
+static struct platform_driver sr_thermal_driver = {
+	.probe		= sr_thermal_probe,
+	.remove		= sr_thermal_remove,
+	.driver = {
+		.name = "sr-thermal",
+		.of_match_table = sr_thermal_of_match,
+		.acpi_match_table = ACPI_PTR(sr_thermal_acpi_ids),
+	},
+};
+module_platform_driver(sr_thermal_driver);
+
+MODULE_AUTHOR("Pramod Kumar <pramod.kumar@broadcom.com>");
+MODULE_DESCRIPTION("Stingray thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

