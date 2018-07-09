Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DDC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A451120873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qlw4jkeS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A451120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbeGIPWX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:22:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38183 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeGIPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:21:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id j33-v6so11405865wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EWfxrPdd+C5li3naLl3f26mTKB35dBYuKv9bLkDfN8A=;
        b=Qlw4jkeSkV3xwX2WAA1pstjG8Oc/m147gMLz62RRQ5eUIUf9tFzbg0zXx19brTgrlK
         NBDsko0GT+yL3YkNTb7xnI4aUoHwY8KzsMWifKNiT0m1z6tSOgwFHm0eOAvjX3YzBL6Y
         8iHhfL7JaoYnyCXqbV946qFLa6aR9r2CtX2rmWfihiJ2PrnxWoa1WhVKg/5AOjnpS1q5
         ul4xp8RMgzEmL3LrukbMi1L4Zlul20ihM+76WWgvozlO0i8hkAHjO5cIZKOeadq4wAG6
         erG3eYNJfqiagvkzVuwgROtkGEfKdptzzkGAQi7QnpCzCP6VydpjLBsA1ARaSsaGIVyV
         4Bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EWfxrPdd+C5li3naLl3f26mTKB35dBYuKv9bLkDfN8A=;
        b=G72Q3SzwImfJ7G7SyZWyXnZ7zxXpzqXsBTjVvP9mQa2ggqoKW3a05MsxAKvdFiAIWf
         kHgtBpvzVu1d2c5f88c0RFAYw1nXsFXA1Go+u/Ew/UMxO5oTtKz3Uf8n/QHvlpdJyEk+
         0rtxd5jDB943UR3SPf1tpa0/LrLaXMreNcZZiIYy2fGhVOEq503DmozkqT9ktxHtP7Wl
         vdUqSYu+4kAzNCpUVikUmh5C9IW8ptD8w+5qGU+Xb1oh5Owd1GzSWVMMJwcxXJwnO5WX
         z3hCTaewWJHImclHoJ39WJULnoFsTNESBDhPJdMAmYp27dsFKbuPHE+cn5RVcDU/XgOg
         Pb0Q==
X-Gm-Message-State: AOUpUlHuxr6vbIliK5M3qmtYT6VrlKpU8hkHf/V+MDtU9zrtXB8vcJKw
        K6dYwsvvu4D39NbViCN2gq/frw==
X-Google-Smtp-Source: AAOMgpdq23w71SRqhHweCnlY1mljpFY3PTwv0HM0aUtjrw3hvLsqQgqd3yayS68yULKGb/fmbtABNQ==
X-Received: by 2002:a5d:5088:: with SMTP id a8-v6mr9349912wrt.37.1531149674528;
        Mon, 09 Jul 2018 08:21:14 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm14468474wrj.71.2018.07.09.08.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:21:14 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linux@armlinux.org.uk, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org,
        tj@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, icenowy@aosc.io,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 2/4] ata: ahci_sunxi: add support for R40 SATA controller
Date:   Mon,  9 Jul 2018 15:20:56 +0000
Message-Id: <1531149658-27030-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
References: <1531149658-27030-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 SoC has an AHCI SATA controller like the one in A10/A20,
but with a reset control and two dedicated VDD pins for this controller
(one 1.2v and one 2.5v).

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/ata/ahci_sunxi.c | 124 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 121 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index b26437430163..8b1bc04c0435 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -25,6 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include "ahci.h"
 
 #define DRV_NAME "ahci-sunxi"
@@ -58,6 +59,19 @@ MODULE_PARM_DESC(enable_pmp,
 #define AHCI_P0PHYCR	0x0178
 #define AHCI_P0PHYSR	0x017c
 
+struct ahci_sunxi_variant {
+	bool has_reset;
+	bool has_vdd1v2;
+	bool has_vdd2v5;
+};
+
+struct ahci_sunxi_data {
+	const struct ahci_sunxi_variant *variant;
+	struct reset_control *reset;
+	struct regulator *vdd1v2;
+	struct regulator *vdd2v5;
+};
+
 static void sunxi_clrbits(void __iomem *reg, u32 clr_val)
 {
 	u32 reg_val;
@@ -179,17 +193,75 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
+	struct ahci_sunxi_data *data;
 	int rc;
 
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->variant = of_device_get_match_data(dev);
+	if (!data->variant)
+		return -EINVAL;
+
+	if (data->variant->has_reset) {
+		data->reset = devm_reset_control_get(dev, NULL);
+		if (IS_ERR(data->reset)) {
+			dev_err(dev, "Failed to get reset\n");
+			return PTR_ERR(data->reset);
+		}
+	}
+
+	if (data->variant->has_vdd1v2) {
+		data->vdd1v2 = devm_regulator_get(dev, "vdd1v2");
+		if (IS_ERR(data->vdd1v2)) {
+			rc = PTR_ERR(data->vdd1v2);
+			if (rc == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(dev, "Failed to get 1.2v VDD regulator\n");
+			return rc;
+		}
+	}
+
+	if (data->variant->has_vdd2v5) {
+		data->vdd2v5 = devm_regulator_get(dev, "vdd2v5");
+		if (IS_ERR(data->vdd2v5)) {
+			rc = PTR_ERR(data->vdd2v5);
+			if (rc == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+			dev_err(dev, "Failed to get 2.5v VDD regulator\n");
+			return rc;
+		}
+	}
+
 	hpriv = ahci_platform_get_resources(pdev);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
+	hpriv->plat_data = data;
 	hpriv->start_engine = ahci_sunxi_start_engine;
 
+	if (data->variant->has_vdd1v2) {
+		rc = regulator_enable(data->vdd1v2);
+		if (rc)
+			return rc;
+	}
+
+	if (data->variant->has_vdd2v5) {
+		rc = regulator_enable(data->vdd2v5);
+		if (rc)
+			goto disable_vdd1v2;
+	}
+
+	if (data->variant->has_reset) {
+		rc = reset_control_deassert(data->reset);
+		if (rc)
+			goto disable_vdd2v5;
+	}
+
 	rc = ahci_platform_enable_resources(hpriv);
 	if (rc)
-		return rc;
+		goto assert_reset;
 
 	rc = ahci_sunxi_phy_init(dev, hpriv->mmio);
 	if (rc)
@@ -215,6 +287,35 @@ static int ahci_sunxi_probe(struct platform_device *pdev)
 
 disable_resources:
 	ahci_platform_disable_resources(hpriv);
+assert_reset:
+	if (data->variant->has_reset)
+		reset_control_assert(data->reset);
+disable_vdd2v5:
+	if (data->variant->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+disable_vdd1v2:
+	if (data->variant->has_vdd1v2)
+		regulator_disable(data->vdd1v2);
+	return rc;
+}
+
+static int ahci_sunxi_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ata_host *host = dev_get_drvdata(dev);
+	struct ahci_host_priv *hpriv = host->private_data;
+	struct ahci_sunxi_data *data = hpriv->plat_data;
+	int rc;
+
+	rc = ata_platform_remove_one(pdev);
+
+	if (data->variant->has_reset)
+		reset_control_assert(data->reset);
+	if (data->variant->has_vdd2v5)
+		regulator_disable(data->vdd2v5);
+	if (data->variant->has_vdd1v2)
+		regulator_disable(data->vdd1v2);
+
 	return rc;
 }
 
@@ -248,15 +349,32 @@ static int ahci_sunxi_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ahci_sunxi_pm_ops, ahci_platform_suspend,
 			 ahci_sunxi_resume);
 
+static const struct ahci_sunxi_variant sun4i_a10_ahci_variant = {
+	/* Nothing special */
+};
+
+static const struct ahci_sunxi_variant sun8i_r40_ahci_variant = {
+	.has_reset = true,
+	.has_vdd1v2 = true,
+	.has_vdd2v5 = true,
+};
+
 static const struct of_device_id ahci_sunxi_of_match[] = {
-	{ .compatible = "allwinner,sun4i-a10-ahci", },
+	{
+		.compatible = "allwinner,sun4i-a10-ahci",
+		.data = &sun4i_a10_ahci_variant,
+	},
+	{
+		.compatible = "allwinner,sun8i-r40-ahci",
+		.data = &sun8i_r40_ahci_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
 
 static struct platform_driver ahci_sunxi_driver = {
 	.probe = ahci_sunxi_probe,
-	.remove = ata_platform_remove_one,
+	.remove = ahci_sunxi_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_sunxi_of_match,
-- 
2.16.4

