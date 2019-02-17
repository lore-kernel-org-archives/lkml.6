Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67803C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242E920700
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rNiIzR23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfBQNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:48:54 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39859 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfBQNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:48:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so7393545pld.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUbpU9BtV+r9t8UNPZwK2W6WMF3xapo+n0oYK6Xdrd4=;
        b=rNiIzR23Y1gIefvmNolS4h6E0k6803UL2PQmsoAxGLTbTV54kEsAoIXY1DnBXWZcgb
         jq4LkCDkGy2TOsx9GlsPKl18UINnznFbNGt8SEEd9724ESAEGf2+nRh3vM8G/ip8N9a3
         GmTsBqLLCytBNp4sgA19di+jsUaeFqV5luMSe0gvx4JfdjeXpxBd7rb+Dzkk226F5GPW
         oOkucXJdpu+1XX7D7hENfZZRG9BmzpJ8lgVKMGKN4ebV8iTuibc09tZXr07tKIuY5cQs
         xDGqCSRHjcTtJMY/Rxx7YJXrsSNOc23YFqWXmCCmMis4BbzSJpgzuK54u4mK3aWklIng
         lZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUbpU9BtV+r9t8UNPZwK2W6WMF3xapo+n0oYK6Xdrd4=;
        b=c6U0MQD9YAQA+cAB7b753ilfEiOJj2YUW8RNTdAxHU/6kEhBgtVI3EQGBjZZnql9zl
         ujbHCgW++RK68eZIQ4+LKSFBUInm4+qXkft15Ts+lL9U8Uhg812D4rdi10vzhzY4Wzp8
         G/x/ftEXq4j8Grq35+/rU/Xa57G1ntd3IeetjYnzoridiVC6fJI74QWPVNX3UaPJqehq
         BEUBBbui7tYSCQjhGPbOcjMNNOSXUe3V2ZlSOHSdZNRrkAAP7P28ksN0Psq/8vp2VZZa
         +pTmbLhnxEthsDAsWnl2kP9sUvGIpAANh9wYMXXtr59/0yviZxS+kRmGrYI1NfQR8SUZ
         B8Rg==
X-Gm-Message-State: AHQUAuZoQjhZU3qnxG3eS2UuskT7pTHQp96FuFxf6II4F3BQp+TBWPyo
        7Q5hNrang9WhzicRJCsIm6/lIg==
X-Google-Smtp-Source: AHgI3IZVnb8j6WzXvkFrOLUvmOJTuzN/mpYY9UBczEy5acQ85r+tOM0vPnbbbl0tcZIOmKTHt0Wwqg==
X-Received: by 2002:a17:902:2a0a:: with SMTP id i10mr19810966plb.323.1550411332875;
        Sun, 17 Feb 2019 05:48:52 -0800 (PST)
Received: from localhost.localdomain (36-239-208-250.dynamic-ip.hinet.net. [36.239.208.250])
        by smtp.gmail.com with ESMTPSA id y13sm10940780pfm.65.2019.02.17.05.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 05:48:51 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolae Rosia <Nicolae_Rosia@mentor.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: twl6030: Use regulator_list_voltage_linear_range for twl6030ldo_ops
Date:   Sun, 17 Feb 2019 21:48:08 +0800
Message-Id: <20190217134809.18108-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use linear range to replace the twl6030ldo_list_voltage implementation.
With this change, the min_mV is not used and can be removed from
struct twlreg_info.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/twl6030-regulator.c | 73 ++++++++++-----------------
 1 file changed, 27 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/twl6030-regulator.c b/drivers/regulator/twl6030-regulator.c
index 78b964539775..dcaa6512d760 100644
--- a/drivers/regulator/twl6030-regulator.c
+++ b/drivers/regulator/twl6030-regulator.c
@@ -31,9 +31,6 @@ struct twlreg_info {
 	/* twl resource ID, for resource control state machine */
 	u8			id;
 
-	/* chip constraints on regulator behavior */
-	u16			min_mV;
-
 	u8			flags;
 
 	/* used by regulator core */
@@ -252,27 +249,6 @@ static struct regulator_ops twl6030coresmps_ops = {
 	.get_voltage	= twl6030coresmps_get_voltage,
 };
 
-static int twl6030ldo_list_voltage(struct regulator_dev *rdev, unsigned sel)
-{
-	struct twlreg_info *info = rdev_get_drvdata(rdev);
-
-	switch (sel) {
-	case 0:
-		return 0;
-	case 1 ... 24:
-		/* Linear mapping from 00000001 to 00011000:
-		 * Absolute voltage value = 1.0 V + 0.1 V × (sel – 00000001)
-		 */
-		return (info->min_mV + 100 * (sel - 1)) * 1000;
-	case 25 ... 30:
-		return -EINVAL;
-	case 31:
-		return 2750000;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int
 twl6030ldo_set_voltage_sel(struct regulator_dev *rdev, unsigned selector)
 {
@@ -291,7 +267,7 @@ static int twl6030ldo_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 static struct regulator_ops twl6030ldo_ops = {
-	.list_voltage	= twl6030ldo_list_voltage,
+	.list_voltage	= regulator_list_voltage_linear_range,
 
 	.set_voltage_sel = twl6030ldo_set_voltage_sel,
 	.get_voltage_sel = twl6030ldo_get_voltage_sel,
@@ -513,6 +489,11 @@ static struct regulator_ops twlsmps_ops = {
 };
 
 /*----------------------------------------------------------------------*/
+static const struct regulator_linear_range twl6030ldo_linear_range[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 0, 0),
+	REGULATOR_LINEAR_RANGE(1000000, 1, 24, 100000),
+	REGULATOR_LINEAR_RANGE(2750000, 31, 31, 0),
+};
 
 #define TWL6030_ADJUSTABLE_SMPS(label) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
@@ -525,28 +506,30 @@ static const struct twlreg_info TWL6030_INFO_##label = { \
 		}, \
 	}
 
-#define TWL6030_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6030_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6030_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
 		}, \
 	}
 
-#define TWL6032_ADJUSTABLE_LDO(label, offset, min_mVolts) \
+#define TWL6032_ADJUSTABLE_LDO(label, offset) \
 static const struct twlreg_info TWL6032_INFO_##label = { \
 	.base = offset, \
-	.min_mV = min_mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
 		.n_voltages = 32, \
+		.linear_ranges = twl6030ldo_linear_range, \
+		.n_linear_ranges = ARRAY_SIZE(twl6030ldo_linear_range), \
 		.ops = &twl6030ldo_ops, \
 		.type = REGULATOR_VOLTAGE, \
 		.owner = THIS_MODULE, \
@@ -557,7 +540,6 @@ static const struct twlreg_info TWL6032_INFO_##label = { \
 static const struct twlreg_info TWLFIXED_INFO_##label = { \
 	.base = offset, \
 	.id = 0, \
-	.min_mV = mVolts, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6030##_REG_##label, \
@@ -574,7 +556,6 @@ static const struct twlreg_info TWLFIXED_INFO_##label = { \
 #define TWL6032_ADJUSTABLE_SMPS(label, offset) \
 static const struct twlreg_info TWLSMPS_INFO_##label = { \
 	.base = offset, \
-	.min_mV = 600, \
 	.desc = { \
 		.name = #label, \
 		.id = TWL6032_REG_##label, \
@@ -592,22 +573,22 @@ static const struct twlreg_info TWLSMPS_INFO_##label = { \
 TWL6030_ADJUSTABLE_SMPS(VDD1);
 TWL6030_ADJUSTABLE_SMPS(VDD2);
 TWL6030_ADJUSTABLE_SMPS(VDD3);
-TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58, 1000);
-TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c, 1000);
-TWL6030_ADJUSTABLE_LDO(VMMC, 0x68, 1000);
-TWL6030_ADJUSTABLE_LDO(VPP, 0x6c, 1000);
-TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74, 1000);
+TWL6030_ADJUSTABLE_LDO(VAUX1_6030, 0x54);
+TWL6030_ADJUSTABLE_LDO(VAUX2_6030, 0x58);
+TWL6030_ADJUSTABLE_LDO(VAUX3_6030, 0x5c);
+TWL6030_ADJUSTABLE_LDO(VMMC, 0x68);
+TWL6030_ADJUSTABLE_LDO(VPP, 0x6c);
+TWL6030_ADJUSTABLE_LDO(VUSIM, 0x74);
 /* 6025 are renamed compared to 6030 versions */
-TWL6032_ADJUSTABLE_LDO(LDO2, 0x54, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO4, 0x58, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO5, 0x68, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO7, 0x74, 1000);
-TWL6032_ADJUSTABLE_LDO(LDO6, 0x60, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64, 1000);
-TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70, 1000);
+TWL6032_ADJUSTABLE_LDO(LDO2, 0x54);
+TWL6032_ADJUSTABLE_LDO(LDO4, 0x58);
+TWL6032_ADJUSTABLE_LDO(LDO3, 0x5c);
+TWL6032_ADJUSTABLE_LDO(LDO5, 0x68);
+TWL6032_ADJUSTABLE_LDO(LDO1, 0x6c);
+TWL6032_ADJUSTABLE_LDO(LDO7, 0x74);
+TWL6032_ADJUSTABLE_LDO(LDO6, 0x60);
+TWL6032_ADJUSTABLE_LDO(LDOLN, 0x64);
+TWL6032_ADJUSTABLE_LDO(LDOUSB, 0x70);
 TWL6030_FIXED_LDO(VANA, 0x50, 2100, 0);
 TWL6030_FIXED_LDO(VCXIO, 0x60, 1800, 0);
 TWL6030_FIXED_LDO(VDAC, 0x64, 1800, 0);
-- 
2.17.1

