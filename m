Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E02EECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A62087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNB0wlmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8A62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeGNMqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 08:46:00 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46789 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbeGNMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 08:46:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so15335922ljj.13;
        Sat, 14 Jul 2018 05:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExUOh3qKcQ2/enZFtHv/uZk6QiNXGVDkKJxI7sOi3TI=;
        b=ZNB0wlmBmtvwQ8tWMbVqHotDFMwVyArDyzgGEcImqzqdLitKHp02gjCtKzUjvy57NG
         bO8A8+Pn9xoGYzZ7P5QtVsfsoBJ5YRL9GIcmiGvyrNNy5ymnthlvzxhq7vYwkAHOIGlz
         KCHlMaS6gf7Oc71OGyoytU4xXcIPrq32TbStLC8qx80ma3vB3LX7l/YgoCA4TsNHTzll
         0uUXdzNKoids1sEgxOPEUBFAhks+UK+GN7rETsdpGuaMguVTa83qOiSzP2mEyhK3gWzQ
         XWwsibMaVtUdrYQ2QL+Nioo62OldSllVZ4kuMocQlwkAP/EI0spim0U8fGV5hMRexaNG
         kZ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExUOh3qKcQ2/enZFtHv/uZk6QiNXGVDkKJxI7sOi3TI=;
        b=eKgSRycUVbMY9d+yUjlEXwWBodut+Xajj9s7zjwQ6EjMXsEo0k8sEOV+XOuN+UtoxI
         YFv2tp/PvyWbppUaq0CtHeeV8UkDmeE6AeQDzClRo0cibr/PYzO+RP+yh8+htzMYVHnn
         yDB0tSHSwLuKN1ifjbqMBVylRWjjEO6YJI4PA1ebbLnc54CgrBvRwd/3/ZrmvuYumRj8
         2QxmAq+QzKbhDBmDUBq/qR9rCHBjpUgO3sV1ywdnR2jbpA9rWmoZiZi2EDlzyNPORnKo
         FYjKpExwnOG9pdp/N8mNF7zR/0jLZGRWu1ywGn6xBhC0XUzzidrXK4S4lObDaRgshREJ
         Ae6w==
X-Gm-Message-State: AOUpUlG4EM13+SX9or0QrHS+5H9ifHjTR+w1X6qbG+x4HVwksY8pThT/
        QVtdtb0I+K2rkwfJuE59Lfs=
X-Google-Smtp-Source: AAOMgpd4RF2PptNUX6a8yJPaOltsQPKuCMCSVe+Q7laZPsl/knzPpJNO86yFXHEX51ZDzSWqtt5bgA==
X-Received: by 2002:a2e:380d:: with SMTP id f13-v6mr5487652lja.74.1531571222121;
        Sat, 14 Jul 2018 05:27:02 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id l3-v6sm5860732lfi.36.2018.07.14.05.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 14 Jul 2018 05:27:01 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 2/3] power: supply: max8998-charger: Parse device tree for required data.
Date:   Sat, 14 Jul 2018 14:26:52 +0200
Message-Id: <1531571213-30593-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531571213-30593-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds missing code for reading charger configuration
from devicetree.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Removed unneeded Fixes tag
  - Use new property names
---
 drivers/power/supply/max8998_charger.c | 50 ++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 66438029bdd0..0a03d3e05c3b 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -21,6 +21,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -82,6 +83,49 @@ static const struct power_supply_desc max8998_battery_desc = {
 	.num_properties	= ARRAY_SIZE(max8998_battery_props),
 };
 
+static int max8998_pmic_dt_parse_pdata(struct max8998_dev *iodev,
+					struct max8998_platform_data *pdata)
+{
+	struct device_node *pmic_np = iodev->dev->of_node;
+	struct device_node *charger_np;
+	int ret;
+
+	charger_np = of_get_child_by_name(pmic_np, "charger");
+	if (!charger_np) {
+		dev_err(iodev->dev, "could not find charger sub-node\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-eoc-percent",
+					&pdata->eoc);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-eoc-percent in devicetree\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-restart-level-microvolt",
+					&pdata->restart);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-restart-level-microvolt in devicetree\n");
+		return ret;
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-timeout-hours",
+					&pdata->timeout);
+	if (ret < 0) {
+		dev_err(iodev->dev,
+			"Could not find max8998,charge-timeout-hours in devicetree\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -96,6 +140,12 @@ static int max8998_battery_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (IS_ENABLED(CONFIG_OF) && iodev->dev->of_node) {
+		ret = max8998_pmic_dt_parse_pdata(iodev, pdata);
+		if (ret)
+			return ret;
+	}
+
 	max8998 = devm_kzalloc(&pdev->dev, sizeof(struct max8998_battery_data),
 				GFP_KERNEL);
 	if (!max8998)
-- 
2.7.4

