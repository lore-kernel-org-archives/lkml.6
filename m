Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290C32084D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="fG6Kkh4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBTQu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 11:50:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfBTQu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 11:50:29 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so12144072pgr.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1HW6k0x9TyR/mV9kBkOobWxOfgMEXiicy958OX7+Fos=;
        b=fG6Kkh4V/W5scM69AdH2RCgK7pJrQ6O/lnuglDK5GnmlGDGz5Q4I4VZs5J9jiKkEoW
         Jo7IWh7fuhhGoGJzVO1C7NFIuxsqKFTuP0dpzBVWDn5ifY+xgBPnHDxLwFCDNUSc7USP
         SQtRav/qJn/uIXIFX9TADif79SRSuBcCwqAm8RISycmiW8W9CsY424bqRbBcPxgGtFhQ
         q/x8Rx9hJuRJ+YjSZLClGO1pi8P5Xx0BmXy1cwz1Moah3xcaHeR11yMrCt/UQNjo1oP9
         /WJ2AlQ9ZPjXu9JClELLIttuJe1LnFhNq/Q+1w4iNzW3j1JNHN8RibepF82AU7RXypWF
         1egA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1HW6k0x9TyR/mV9kBkOobWxOfgMEXiicy958OX7+Fos=;
        b=bi5i+IYmn5Z2A4J0rSZJsk182Q0Iokydr+/GNwmRQxqaihRDFh0DHdmT/PGwIjRpRg
         hGrr9MpMn48MDFfz2dteeHI9WRx0vsIu/sWQZDBh7Ge6lKrVm4SxNNWQivumyY2fqEwy
         ja9Dd8VP02brSGC4DjY7UPpJ943NPyFWJtQnQ1j+KS5AiRc7lIC+wLT0cpdK5/rGxKbm
         /Z9P7lIHUnIDco1ULcmOz5i8O/0YbenFnfjvsa8PkkdBS0+RE6/zG9Ddr4ilo5Yzxyba
         MDFtmRA8WyY6X6kMNgRI9U2vHx6TdtRcZKZmhlErGdTNzpA3KaFZOc6TQsQ6Q7z+vckH
         KN5g==
X-Gm-Message-State: AHQUAuaUNVtIKqJ0CNkL66xPLSaS2HaRjQOnyiVX2rRRFnmy/q9HXRl+
        adHwZP50SofcFHtBB79SmOiFMY8tqoi5OA==
X-Google-Smtp-Source: AHgI3IbstyUrIjzWsuyoh6u6BTa5+f92TnVsanYdclbbGLW46DCk+scWxCDljdpFW2q60IKQnrWvxQ==
X-Received: by 2002:a63:fc59:: with SMTP id r25mr5436285pgk.302.1550681428123;
        Wed, 20 Feb 2019 08:50:28 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id t12sm51972590pgq.68.2019.02.20.08.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 08:50:27 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Olliver Schinagl <oliver@schinagl.nl>,
        Priit Laes <plaes@plaes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: axp20x: Get rid of AXP20X_xxx_START/END/STEPS defines
Date:   Thu, 21 Feb 2019 00:50:13 +0800
Message-Id: <20190220165013.12774-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AXP20X_xxx_START/END/STEPS defines make the code hard to read and
very hard to check the linear range settings because it needs to check
the defines one-by-one.
The original code without the defines is very good in readability
as the meaning of each field of REGULATOR_LINEAR_RANGE is clear.
So I suggest to get rid of AXP20X_xxx_START/END/STEPS defines.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/axp20x-regulator.c | 176 +++------------------------
 1 file changed, 19 insertions(+), 157 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index fba8f58ab769..46b5de53d1a3 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -64,26 +64,6 @@
 #define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN_MASK		BIT_MASK(3)
 #define AXP20X_DCDC2_LDO3_V_RAMP_LDO3_EN		BIT(3)
 
-#define AXP20X_LDO4_V_OUT_1250mV_START	0x0
-#define AXP20X_LDO4_V_OUT_1250mV_STEPS	0
-#define AXP20X_LDO4_V_OUT_1250mV_END	\
-	(AXP20X_LDO4_V_OUT_1250mV_START + AXP20X_LDO4_V_OUT_1250mV_STEPS)
-#define AXP20X_LDO4_V_OUT_1300mV_START	0x1
-#define AXP20X_LDO4_V_OUT_1300mV_STEPS	7
-#define AXP20X_LDO4_V_OUT_1300mV_END	\
-	(AXP20X_LDO4_V_OUT_1300mV_START + AXP20X_LDO4_V_OUT_1300mV_STEPS)
-#define AXP20X_LDO4_V_OUT_2500mV_START	0x9
-#define AXP20X_LDO4_V_OUT_2500mV_STEPS	0
-#define AXP20X_LDO4_V_OUT_2500mV_END	\
-	(AXP20X_LDO4_V_OUT_2500mV_START + AXP20X_LDO4_V_OUT_2500mV_STEPS)
-#define AXP20X_LDO4_V_OUT_2700mV_START	0xa
-#define AXP20X_LDO4_V_OUT_2700mV_STEPS	1
-#define AXP20X_LDO4_V_OUT_2700mV_END	\
-	(AXP20X_LDO4_V_OUT_2700mV_START + AXP20X_LDO4_V_OUT_2700mV_STEPS)
-#define AXP20X_LDO4_V_OUT_3000mV_START	0xc
-#define AXP20X_LDO4_V_OUT_3000mV_STEPS	3
-#define AXP20X_LDO4_V_OUT_3000mV_END	\
-	(AXP20X_LDO4_V_OUT_3000mV_START + AXP20X_LDO4_V_OUT_3000mV_STEPS)
 #define AXP20X_LDO4_V_OUT_NUM_VOLTAGES	16
 
 #define AXP22X_IO_ENABLED		0x03
@@ -156,44 +136,9 @@
 #define AXP803_DCDC23_POLYPHASE_DUAL	BIT(6)
 #define AXP803_DCDC56_POLYPHASE_DUAL	BIT(5)
 
-#define AXP803_DCDC234_500mV_START	0x00
-#define AXP803_DCDC234_500mV_STEPS	70
-#define AXP803_DCDC234_500mV_END	\
-	(AXP803_DCDC234_500mV_START + AXP803_DCDC234_500mV_STEPS)
-#define AXP803_DCDC234_1220mV_START	0x47
-#define AXP803_DCDC234_1220mV_STEPS	4
-#define AXP803_DCDC234_1220mV_END	\
-	(AXP803_DCDC234_1220mV_START + AXP803_DCDC234_1220mV_STEPS)
 #define AXP803_DCDC234_NUM_VOLTAGES	76
-
-#define AXP803_DCDC5_800mV_START	0x00
-#define AXP803_DCDC5_800mV_STEPS	32
-#define AXP803_DCDC5_800mV_END		\
-	(AXP803_DCDC5_800mV_START + AXP803_DCDC5_800mV_STEPS)
-#define AXP803_DCDC5_1140mV_START	0x21
-#define AXP803_DCDC5_1140mV_STEPS	35
-#define AXP803_DCDC5_1140mV_END		\
-	(AXP803_DCDC5_1140mV_START + AXP803_DCDC5_1140mV_STEPS)
 #define AXP803_DCDC5_NUM_VOLTAGES	68
-
-#define AXP803_DCDC6_600mV_START	0x00
-#define AXP803_DCDC6_600mV_STEPS	50
-#define AXP803_DCDC6_600mV_END		\
-	(AXP803_DCDC6_600mV_START + AXP803_DCDC6_600mV_STEPS)
-#define AXP803_DCDC6_1120mV_START	0x33
-#define AXP803_DCDC6_1120mV_STEPS	14
-#define AXP803_DCDC6_1120mV_END		\
-	(AXP803_DCDC6_1120mV_START + AXP803_DCDC6_1120mV_STEPS)
 #define AXP803_DCDC6_NUM_VOLTAGES	72
-
-#define AXP803_DLDO2_700mV_START	0x00
-#define AXP803_DLDO2_700mV_STEPS	26
-#define AXP803_DLDO2_700mV_END		\
-	(AXP803_DLDO2_700mV_START + AXP803_DLDO2_700mV_STEPS)
-#define AXP803_DLDO2_3400mV_START	0x1b
-#define AXP803_DLDO2_3400mV_STEPS	4
-#define AXP803_DLDO2_3400mV_END		\
-	(AXP803_DLDO2_3400mV_START + AXP803_DLDO2_3400mV_STEPS)
 #define AXP803_DLDO2_NUM_VOLTAGES	32
 
 #define AXP806_DCDCA_V_CTRL_MASK	GENMASK(6, 0)
@@ -235,34 +180,8 @@
 
 #define AXP806_DCDCDE_POLYPHASE_DUAL	BIT(5)
 
-#define AXP806_DCDCA_600mV_START	0x00
-#define AXP806_DCDCA_600mV_STEPS	50
-#define AXP806_DCDCA_600mV_END		\
-	(AXP806_DCDCA_600mV_START + AXP806_DCDCA_600mV_STEPS)
-#define AXP806_DCDCA_1120mV_START	0x33
-#define AXP806_DCDCA_1120mV_STEPS	14
-#define AXP806_DCDCA_1120mV_END		\
-	(AXP806_DCDCA_1120mV_START + AXP806_DCDCA_1120mV_STEPS)
 #define AXP806_DCDCA_NUM_VOLTAGES	72
-
-#define AXP806_DCDCD_600mV_START	0x00
-#define AXP806_DCDCD_600mV_STEPS	45
-#define AXP806_DCDCD_600mV_END		\
-	(AXP806_DCDCD_600mV_START + AXP806_DCDCD_600mV_STEPS)
-#define AXP806_DCDCD_1600mV_START	0x2e
-#define AXP806_DCDCD_1600mV_STEPS	17
-#define AXP806_DCDCD_1600mV_END		\
-	(AXP806_DCDCD_1600mV_START + AXP806_DCDCD_1600mV_STEPS)
 #define AXP806_DCDCD_NUM_VOLTAGES	64
-
-#define AXP809_DCDC4_600mV_START	0x00
-#define AXP809_DCDC4_600mV_STEPS	47
-#define AXP809_DCDC4_600mV_END		\
-	(AXP809_DCDC4_600mV_START + AXP809_DCDC4_600mV_STEPS)
-#define AXP809_DCDC4_1800mV_START	0x30
-#define AXP809_DCDC4_1800mV_STEPS	8
-#define AXP809_DCDC4_1800mV_END		\
-	(AXP809_DCDC4_1800mV_START + AXP809_DCDC4_1800mV_STEPS)
 #define AXP809_DCDC4_NUM_VOLTAGES	57
 
 #define AXP813_DCDC7_V_OUT_MASK		GENMASK(6, 0)
@@ -517,26 +436,11 @@ static const struct regulator_ops axp20x_ops_sw = {
 };
 
 static const struct regulator_linear_range axp20x_ldo4_ranges[] = {
-	REGULATOR_LINEAR_RANGE(1250000,
-			       AXP20X_LDO4_V_OUT_1250mV_START,
-			       AXP20X_LDO4_V_OUT_1250mV_END,
-			       0),
-	REGULATOR_LINEAR_RANGE(1300000,
-			       AXP20X_LDO4_V_OUT_1300mV_START,
-			       AXP20X_LDO4_V_OUT_1300mV_END,
-			       100000),
-	REGULATOR_LINEAR_RANGE(2500000,
-			       AXP20X_LDO4_V_OUT_2500mV_START,
-			       AXP20X_LDO4_V_OUT_2500mV_END,
-			       0),
-	REGULATOR_LINEAR_RANGE(2700000,
-			       AXP20X_LDO4_V_OUT_2700mV_START,
-			       AXP20X_LDO4_V_OUT_2700mV_END,
-			       100000),
-	REGULATOR_LINEAR_RANGE(3000000,
-			       AXP20X_LDO4_V_OUT_3000mV_START,
-			       AXP20X_LDO4_V_OUT_3000mV_END,
-			       100000),
+	REGULATOR_LINEAR_RANGE(1250000, 0x0, 0x0, 0),
+	REGULATOR_LINEAR_RANGE(1300000, 0x1, 0x8, 100000),
+	REGULATOR_LINEAR_RANGE(2500000, 0x9, 0x9, 0),
+	REGULATOR_LINEAR_RANGE(2700000, 0xa, 0xb, 100000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xc, 0xf, 100000),
 };
 
 static const struct regulator_desc axp20x_regulators[] = {
@@ -645,48 +549,24 @@ static const struct regulator_desc axp22x_drivevbus_regulator = {
 
 /* DCDC ranges shared with AXP813 */
 static const struct regulator_linear_range axp803_dcdc234_ranges[] = {
-	REGULATOR_LINEAR_RANGE(500000,
-			       AXP803_DCDC234_500mV_START,
-			       AXP803_DCDC234_500mV_END,
-			       10000),
-	REGULATOR_LINEAR_RANGE(1220000,
-			       AXP803_DCDC234_1220mV_START,
-			       AXP803_DCDC234_1220mV_END,
-			       20000),
+	REGULATOR_LINEAR_RANGE(500000, 0x0, 0x46, 10000),
+	REGULATOR_LINEAR_RANGE(1220000, 0x47, 0x4b, 20000),
 };
 
 static const struct regulator_linear_range axp803_dcdc5_ranges[] = {
-	REGULATOR_LINEAR_RANGE(800000,
-			       AXP803_DCDC5_800mV_START,
-			       AXP803_DCDC5_800mV_END,
-			       10000),
-	REGULATOR_LINEAR_RANGE(1140000,
-			       AXP803_DCDC5_1140mV_START,
-			       AXP803_DCDC5_1140mV_END,
-			       20000),
+	REGULATOR_LINEAR_RANGE(800000, 0x0, 0x20, 10000),
+	REGULATOR_LINEAR_RANGE(1140000, 0x21, 0x44, 20000),
 };
 
 static const struct regulator_linear_range axp803_dcdc6_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000,
-			       AXP803_DCDC6_600mV_START,
-			       AXP803_DCDC6_600mV_END,
-			       10000),
-	REGULATOR_LINEAR_RANGE(1120000,
-			       AXP803_DCDC6_1120mV_START,
-			       AXP803_DCDC6_1120mV_END,
-			       20000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
 };
 
 /* AXP806's CLDO2 and AXP809's DLDO1 share the same range */
 static const struct regulator_linear_range axp803_dldo2_ranges[] = {
-	REGULATOR_LINEAR_RANGE(700000,
-			       AXP803_DLDO2_700mV_START,
-			       AXP803_DLDO2_700mV_END,
-			       100000),
-	REGULATOR_LINEAR_RANGE(3400000,
-			       AXP803_DLDO2_3400mV_START,
-			       AXP803_DLDO2_3400mV_END,
-			       200000),
+	REGULATOR_LINEAR_RANGE(700000, 0x0, 0x1a, 100000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x1b, 0x1f, 200000),
 };
 
 static const struct regulator_desc axp803_regulators[] = {
@@ -765,25 +645,13 @@ static const struct regulator_desc axp803_regulators[] = {
 };
 
 static const struct regulator_linear_range axp806_dcdca_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000,
-			       AXP806_DCDCA_600mV_START,
-			       AXP806_DCDCA_600mV_END,
-			       10000),
-	REGULATOR_LINEAR_RANGE(1120000,
-			       AXP806_DCDCA_1120mV_START,
-			       AXP806_DCDCA_1120mV_END,
-			       20000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x32, 10000),
+	REGULATOR_LINEAR_RANGE(1120000, 0x33, 0x47, 20000),
 };
 
 static const struct regulator_linear_range axp806_dcdcd_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000,
-			       AXP806_DCDCD_600mV_START,
-			       AXP806_DCDCD_600mV_END,
-			       20000),
-	REGULATOR_LINEAR_RANGE(1600000,
-			       AXP806_DCDCD_600mV_START,
-			       AXP806_DCDCD_600mV_END,
-			       100000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2d, 20000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x2e, 0x3f, 100000),
 };
 
 static const struct regulator_desc axp806_regulators[] = {
@@ -841,14 +709,8 @@ static const struct regulator_desc axp806_regulators[] = {
 };
 
 static const struct regulator_linear_range axp809_dcdc4_ranges[] = {
-	REGULATOR_LINEAR_RANGE(600000,
-			       AXP809_DCDC4_600mV_START,
-			       AXP809_DCDC4_600mV_END,
-			       20000),
-	REGULATOR_LINEAR_RANGE(1800000,
-			       AXP809_DCDC4_1800mV_START,
-			       AXP809_DCDC4_1800mV_END,
-			       100000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0, 0x2f, 20000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x30, 0x38, 100000),
 };
 
 static const struct regulator_desc axp809_regulators[] = {
-- 
2.17.1

