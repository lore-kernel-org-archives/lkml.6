Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3642CECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DCA2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ23DU+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5DCA2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbeGQQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:38:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37325 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729657AbeGQQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:38:46 -0400
Received: by mail-lf0-f65.google.com with SMTP id j8-v6so1244586lfb.4;
        Tue, 17 Jul 2018 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6J2uGqYjLoQNy5LbLIvu6JvMlLX8680myMA2nRWWN3c=;
        b=oQ23DU+IEQnQNCCMJoBXr6FjWYDgp4c7iLQ2gvTW4JU1KKRSwu5ClKFly7hPFsfet+
         wYuA4LnKZb1ZwVrMGW2MIxOWpJmNjxFz3PWj1nQmAlXyYOV/1MaQw3VeIzsm65Rg3yAK
         eT+C73z0tuMi/onIWLjoRkl3BnA5XfGzheN1wMBd3MDnZ46TSlY5+fQoYtDfGfd8vfoM
         pE6q1MpupGukR5PDm9ycoPeqvIivr08LqPfgbF+M5zsjFj+Hx5L93EhNZBpmpV54PTBe
         KagQmgvi8EwEnGrvgVGKM8EXlvtfWPbrlWxyEwPtXoNC68VY6XhMeIz4+jkwHzw0Qn1j
         EJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6J2uGqYjLoQNy5LbLIvu6JvMlLX8680myMA2nRWWN3c=;
        b=f4IYKucjUccQLzuBxVDqBwn5S+sSRmIKTDTu2cMjlRkoq4jMwb2p8C5+MuOdL7Chlc
         XH+CtyrlNsFBhh7Ugf8+r7LwuOxHRc52pjUym13UqVJ0Dl5gzcPesZ29TdkbC5k1Z19o
         ARtiOXW3LMD1tmS8PcKBWHvhcFhQojSUtiWqqCJw4aGUSNJlJjhM/+c4iza92h6Zf0uV
         SB9TXARGkw40cAva5j34LUKOFuNF4xu1NQ0Hg5y4VUmEfzCTS05R+Q6dZOYSzaXXH+ZN
         FBGlA2jsOCPzprPk+sFSOhVMN5of6rlplGKbqmIl8/D92+edj/uxt3z3sqzVu/yF1fxD
         I9BQ==
X-Gm-Message-State: AOUpUlGw48U5a41DGzydRce3RuHResFaHsfhgmVxTSeRC7tZ4MVIx9Zh
        yXrvhqFLljycyfvEw9q8ccs=
X-Google-Smtp-Source: AAOMgpdGuLiurjCg2mgcFeijUU2HN/+86A3M5j6nKWmLLEBHfP1EIiufXdgq9uWSt3saUaceTjkkoQ==
X-Received: by 2002:a19:63dc:: with SMTP id v89-v6mr1738877lfi.23.1531843522112;
        Tue, 17 Jul 2018 09:05:22 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-174-73.play-internet.pl. [94.254.174.73])
        by smtp.googlemail.com with ESMTPSA id d23-v6sm229861ljg.17.2018.07.17.09.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 09:05:21 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 2/3] power: supply: max8998-charger: Parse device tree for required data.
Date:   Tue, 17 Jul 2018 18:05:08 +0200
Message-Id: <1531843509-3533-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1531843509-3533-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v2:
  - Make restart level and charge timeout properties optional.
    If they're not present in devicetree, assume they're disabled.

Changes from v1:
  - Removed unneeded Fixes tag
  - Use new property names
---
 drivers/power/supply/max8998_charger.c | 60 ++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index 66438029bdd0..2faba2b99639 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -21,6 +21,7 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
@@ -82,6 +83,59 @@ static const struct power_supply_desc max8998_battery_desc = {
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
+		if (ret != -EINVAL) {
+			dev_err(iodev->dev,
+				"Failed to read max8998,charge-restart-level-microvolt\n");
+			return ret;
+		}
+
+		pdata->restart = -1;
+		dev_dbg(iodev->dev, "Charge Restart Level disabled\n");
+	}
+
+	ret = of_property_read_u32(charger_np,
+					"max8998,charge-timeout-hours",
+					&pdata->timeout);
+	if (ret < 0) {
+		if (ret != -EINVAL) {
+			dev_err(iodev->dev,
+				"Failed to read max8998,charge-timeout-hours\n");
+			return ret;
+		}
+
+		pdata->timeout = -1;
+		dev_dbg(iodev->dev, "Charge Full Timeout disabled\n");
+	}
+
+	return 0;
+}
+
 static int max8998_battery_probe(struct platform_device *pdev)
 {
 	struct max8998_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -96,6 +150,12 @@ static int max8998_battery_probe(struct platform_device *pdev)
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

