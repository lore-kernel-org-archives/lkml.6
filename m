Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BCAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2A120874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2A120874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeGVQZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:25:49 -0400
Received: from smtprz14.163.net ([106.3.154.247]:2863 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728566AbeGVQZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:25:49 -0400
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 93FF2B00D4E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:34:16 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 3E87B81220
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:34:16 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6exARlmtqmmV for <linux-kernel@vger.kernel.org>;
        Sun, 22 Jul 2018 21:34:14 +0800 (CST)
Received: from localhost (unknown [222.209.18.46])
        by antispam2.tom.com (Postfix) with ESMTPA id 1777E8053C;
        Sun, 22 Jul 2018 21:34:14 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     sre@kernel.org
Cc:     pali.rohar@gmail.com, afd@ti.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] power: supply: bq27xxx: Add support for BQ27411
Date:   Sun, 22 Jul 2018 21:33:56 +0800
Message-Id: <1532266436-20182-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet, bq27411 is similar to bq27421.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.txt | 1 +
 drivers/power/supply/bq27xxx_battery.c                     | 9 +++++++++
 drivers/power/supply/bq27xxx_battery_i2c.c                 | 2 ++
 include/linux/power/bq27xxx_battery.h                      | 1 +
 4 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
index 37994fd..4fa8e08 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.txt
@@ -23,6 +23,7 @@ Required properties:
  * "ti,bq27546" - BQ27546
  * "ti,bq27742" - BQ27742
  * "ti,bq27545" - BQ27545
+ * "ti,bq27411" - BQ27411
  * "ti,bq27421" - BQ27421
  * "ti,bq27425" - BQ27425
  * "ti,bq27426" - BQ27426
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index f022e1b..6dbbe95 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -432,6 +432,7 @@ enum bq27xxx_reg_index {
 		[BQ27XXX_REG_AP] = 0x18,
 		BQ27XXX_DM_REG_ROWS,
 	};
+#define bq27411_regs bq27421_regs
 #define bq27425_regs bq27421_regs
 #define bq27426_regs bq27421_regs
 #define bq27441_regs bq27421_regs
@@ -665,6 +666,7 @@ enum bq27xxx_reg_index {
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
+#define bq27411_props bq27421_props
 #define bq27425_props bq27421_props
 #define bq27426_props bq27421_props
 #define bq27441_props bq27421_props
@@ -725,6 +727,12 @@ enum bq27xxx_dm_reg_id {
 #define bq27545_dm_regs 0
 #endif
 
+static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
+	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0, 32767 },
+	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
+	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2800,  3700 },
+};
+
 static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
 	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
@@ -802,6 +810,7 @@ enum bq27xxx_dm_reg_id {
 	[BQ27546]   = BQ27XXX_DATA(bq27546,   0         , BQ27XXX_O_OTDC),
 	[BQ27742]   = BQ27XXX_DATA(bq27742,   0         , BQ27XXX_O_OTDC),
 	[BQ27545]   = BQ27XXX_DATA(bq27545,   0x04143672, BQ27XXX_O_OTDC),
+	[BQ27411]   = BQ27XXX_DATA(bq27411,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27421]   = BQ27XXX_DATA(bq27421,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
 	[BQ27425]   = BQ27XXX_DATA(bq27425,   0x04143672, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP),
 	[BQ27426]   = BQ27XXX_DATA(bq27426,   0x80008000, BQ27XXX_O_UTOT | BQ27XXX_O_CFGUP | BQ27XXX_O_RAM),
diff --git a/drivers/power/supply/bq27xxx_battery_i2c.c b/drivers/power/supply/bq27xxx_battery_i2c.c
index 4006912..2677c38 100644
--- a/drivers/power/supply/bq27xxx_battery_i2c.c
+++ b/drivers/power/supply/bq27xxx_battery_i2c.c
@@ -247,6 +247,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 	{ "bq27546", BQ27546 },
 	{ "bq27742", BQ27742 },
 	{ "bq27545", BQ27545 },
+	{ "bq27411", BQ27411 },
 	{ "bq27421", BQ27421 },
 	{ "bq27425", BQ27425 },
 	{ "bq27426", BQ27426 },
@@ -279,6 +280,7 @@ static int bq27xxx_battery_i2c_remove(struct i2c_client *client)
 	{ .compatible = "ti,bq27546" },
 	{ .compatible = "ti,bq27742" },
 	{ .compatible = "ti,bq27545" },
+	{ .compatible = "ti,bq27411" },
 	{ .compatible = "ti,bq27421" },
 	{ .compatible = "ti,bq27425" },
 	{ .compatible = "ti,bq27426" },
diff --git a/include/linux/power/bq27xxx_battery.h b/include/linux/power/bq27xxx_battery.h
index d6355f4..507c5e2 100644
--- a/include/linux/power/bq27xxx_battery.h
+++ b/include/linux/power/bq27xxx_battery.h
@@ -24,6 +24,7 @@ enum bq27xxx_chip {
 	BQ27546,
 	BQ27742,
 	BQ27545, /* bq27545 */
+	BQ27411,
 	BQ27421, /* bq27421, bq27441, bq27621 */
 	BQ27425,
 	BQ27426,
-- 
1.9.1

