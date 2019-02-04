Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B07EC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3882177E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="NCazFTQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBDHMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:12:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfBDHMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:12:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id r136so6345275pfc.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Feb 2019 23:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=q6sT0RLKi+Ho6vz26K1gu1rya8Y/M3lQngzNNuei96U=;
        b=NCazFTQMQHGDmNb+gQX2FnNSltzXvQhG3eqHKHBvbNwVYSLbdocG/f3eIQoSjU/5SW
         6eIf2s4ClGSsQmiuuzG/iORRRoydW67gGGdXjdQ6aqddHE+bc7Q1zAMNEXvfAfiP75VA
         98DOWvZwONeYdL3yQMsBKUfGRji0TsXPzFga9pHM2f5kWX/UwxogHgIzNDWms17YNkq/
         nXa+52t1ahtwmFzlXT/DYMD/wuI6g0Eh7Uy2TAWDwGu/+jpndhi5kt+ec4tHxstwpyKH
         v3u6W5pt7+T71RN1wXYX9FD5rWdk8DN7mUCgAB0ZCYfHbQnjTPMYSTn7Ko/8BCHxzmV+
         y4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q6sT0RLKi+Ho6vz26K1gu1rya8Y/M3lQngzNNuei96U=;
        b=HCrQulfuuqdPPyFPijFMcSDszugp9NGfe1w4cYBz1vMQvCHOl7cg/aOUaCqK3cnsld
         gNlYpKrojgpmHBEE9UxEKe6Xko5fdOT0X0al+XjdRScwFX86M6XWIwhWi5cNo1AC3DKB
         FxaQonbG9gpS/OR+UUgi2+Ev+xzxLpjpCwHmPH+uvIxiZnJHTsVLC3IxTVss6e7By+61
         ozsFqG3bILv2P1+ueeOy4y8bHhIp9LhpIG+a5Afubh/zO0oIs2+4KwlJDO/xwqJjQeMT
         wdc4YsdwiNFqCGB8B/wKa99WI0kHRVwGIM7tnHyezlBJaWK5tnTHjfvG8lnhL/qijWi/
         byrQ==
X-Gm-Message-State: AHQUAuawJPX5CVyFj/b5gn82yCq2qssPPMBJmIkSujseqApAsoEwzn+K
        ADigBHkkv9fUqLipc0r8V1ifBw==
X-Google-Smtp-Source: AHgI3IYuvyv4PzrnD3F3mkEGJp4Ye0vsOk3RS4rdaStZkATEHhiKq3blMYlyyqaBJx4YaIVEJxJLFA==
X-Received: by 2002:a65:6110:: with SMTP id z16mr1068561pgu.330.1549264341809;
        Sun, 03 Feb 2019 23:12:21 -0800 (PST)
Received: from localhost.localdomain (2001-b400-e2d5-1f7e-ad44-3f2c-af98-3b63.emome-ip6.hinet.net. [2001:b400:e2d5:1f7e:ad44:3f2c:af98:3b63])
        by smtp.gmail.com with ESMTPSA id n22sm32507216pfh.166.2019.02.03.23.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Feb 2019 23:12:20 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Otavio Salvador <otavio@ossystems.com.br>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rk808: Convert rk805 buck1/2 to use linear range
Date:   Mon,  4 Feb 2019 15:10:51 +0800
Message-Id: <20190204071051.16982-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like linear range is suitable to describe the voltage table
for rk805 buck1/2:

selector 0 ~ 59: 0.7125V with uV_step = 12500
selector 60 ~ 62: 1.8V with uV_step = 200000
selector 63: 2.3V

With this change, then rk805 buck1/2 can reuse rk808_reg_ops_ranges.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Otavio,
I don't have this h/w.
Please help review and test if this patch works.
Thanks,
Axel
 drivers/regulator/rk808-regulator.c | 55 +++++++----------------------
 1 file changed, 12 insertions(+), 43 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 79e79cdd503b..23713e16c286 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -289,21 +289,6 @@ static int rk808_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
 				  RK808_RAMP_RATE_MASK, ramp_value);
 }
 
-static int rk805_set_suspend_voltage(struct regulator_dev *rdev, int uv)
-{
-	unsigned int reg;
-	int sel = regulator_map_voltage_ascend(rdev, uv, uv);
-
-	if (sel < 0)
-		return -EINVAL;
-
-	reg = rdev->desc->vsel_reg + RK808_SLP_REG_OFFSET;
-
-	return regmap_update_bits(rdev->regmap, reg,
-				  rdev->desc->vsel_mask,
-				  sel);
-}
-
 static int rk808_set_suspend_voltage(struct regulator_dev *rdev, int uv)
 {
 	unsigned int reg;
@@ -399,19 +384,6 @@ static const struct regulator_ops rk805_switch_ops = {
 	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk805_buck1_2_ops = {
-		.list_voltage		= regulator_list_voltage_table,
-		.map_voltage		= regulator_map_voltage_ascend,
-		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
-		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_voltage    = rk805_set_suspend_voltage,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
-};
-
 static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
@@ -461,15 +433,10 @@ static const struct regulator_ops rk808_switch_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static const int rk805_buck_1_2_voltages[] = {
-	712500, 725000, 737500, 750000, 762500, 775000, 787500, 800000,
-	812500, 825000, 837500, 850000, 862500, 875000, 887500, 900000,
-	912500, 925000, 937500, 950000, 962500, 975000, 987500, 1000000,
-	1012500, 1025000, 1037500, 1050000, 1062500, 1075000, 1087500, 1100000,
-	1112500, 1125000, 1137500, 1150000, 1162500, 1175000, 1187500, 1200000,
-	1212500, 1225000, 1237500, 1250000, 1262500, 1275000, 1287500, 1300000,
-	1312500, 1325000, 1337500, 1350000, 1362500, 1375000, 1387500, 1400000,
-	1412500, 1425000, 1437500, 1450000, 1800000, 2000000, 2200000, 2300000,
+static const struct regulator_linear_range rk805_buck_1_2_voltage_ranges[] = {
+	REGULATOR_LINEAR_RANGE(712500, 0, 59, 12500),
+	REGULATOR_LINEAR_RANGE(1800000, 60, 62, 200000),
+	REGULATOR_LINEAR_RANGE(2300000, 63, 63, 0),
 };
 
 static const struct regulator_desc rk805_reg[] = {
@@ -479,10 +446,11 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG1"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC1,
-		.ops = &rk805_buck1_2_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
-		.volt_table = rk805_buck_1_2_voltages,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
 		.vsel_reg = RK805_BUCK1_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
@@ -494,10 +462,11 @@ static const struct regulator_desc rk805_reg[] = {
 		.of_match = of_match_ptr("DCDC_REG2"),
 		.regulators_node = of_match_ptr("regulators"),
 		.id = RK805_ID_DCDC2,
-		.ops = &rk805_buck1_2_ops,
+		.ops = &rk808_reg_ops_ranges,
 		.type = REGULATOR_VOLTAGE,
-		.n_voltages = ARRAY_SIZE(rk805_buck_1_2_voltages),
-		.volt_table = rk805_buck_1_2_voltages,
+		.n_voltages = 64,
+		.linear_ranges = rk805_buck_1_2_voltage_ranges,
+		.n_linear_ranges = ARRAY_SIZE(rk805_buck_1_2_voltage_ranges),
 		.vsel_reg = RK805_BUCK2_ON_VSEL_REG,
 		.vsel_mask = RK818_BUCK_VSEL_MASK,
 		.enable_reg = RK805_DCDC_EN_REG,
-- 
2.17.1

