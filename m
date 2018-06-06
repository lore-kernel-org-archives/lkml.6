Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPHy4DgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7729601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeFFKA1 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 06:00:27 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34032 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752260AbeFFKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 06:00:24 -0400
X-Google-Smtp-Source: ADUXVKI2KDTdqFN07dBlgNpzNRJxQ9+xaEiw9yEhtmok4gIfnfem4+skN79XAy05O+E/cxsjIW0EoA==
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 03/14] mfd: da9063: Use regmap_reg_range
Date: Wed,  6 Jun 2018 11:59:52 +0200
Message-Id: <20180606100003.17067-3-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
References: <20180606100003.17067-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the regmap_range tables to use regmap_reg_range() macro.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
---
V5: New patch
---
 drivers/mfd/da9063-i2c.c | 174 ++++++++++++-----------------------------------
 1 file changed, 42 insertions(+), 132 deletions(-)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 29456e807ed4..e9797153bc19 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -29,78 +29,33 @@
 #include <linux/regulator/of_regulator.h>
 
 static const struct regmap_range da9063_ad_readable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_AD_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_T_OFFSET,
-		.range_max = DA9063_AD_REG_GP_ID_19,
-	}, {
-		.range_min = DA9063_REG_CHIP_ID,
-		.range_max = DA9063_REG_CHIP_VARIANT,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_AD_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_AD_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
 };
 
 static const struct regmap_range da9063_ad_writeable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_PAGE_CON,
-	}, {
-		.range_min = DA9063_REG_FAULT_LOG,
-		.range_max = DA9063_REG_VSYS_MON,
-	}, {
-		.range_min = DA9063_REG_COUNT_S,
-		.range_max = DA9063_AD_REG_ALARM_Y,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_CONFIG_I,
-		.range_max = DA9063_AD_REG_MON_REG_4,
-	}, {
-		.range_min = DA9063_AD_REG_GP_ID_0,
-		.range_max = DA9063_AD_REG_GP_ID_19,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_COUNT_S, DA9063_AD_REG_ALARM_Y),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_AD_REG_MON_REG_4),
+	regmap_reg_range(DA9063_AD_REG_GP_ID_0, DA9063_AD_REG_GP_ID_19),
 };
 
 static const struct regmap_range da9063_ad_volatile_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_EVENT_D,
-	}, {
-		.range_min = DA9063_REG_CONTROL_A,
-		.range_max = DA9063_REG_CONTROL_B,
-	}, {
-		.range_min = DA9063_REG_CONTROL_E,
-		.range_max = DA9063_REG_CONTROL_F,
-	}, {
-		.range_min = DA9063_REG_BCORE2_CONT,
-		.range_max = DA9063_REG_LDO11_CONT,
-	}, {
-		.range_min = DA9063_REG_DVC_1,
-		.range_max = DA9063_REG_ADC_MAN,
-	}, {
-		.range_min = DA9063_REG_ADC_RES_L,
-		.range_max = DA9063_AD_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_SEQ,
-	}, {
-		.range_min = DA9063_REG_EN_32K,
-		.range_max = DA9063_REG_EN_32K,
-	}, {
-		.range_min = DA9063_AD_REG_MON_REG_5,
-		.range_max = DA9063_AD_REG_MON_REG_6,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_AD_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_AD_REG_MON_REG_5, DA9063_AD_REG_MON_REG_6),
 };
 
 static const struct regmap_access_table da9063_ad_readable_table = {
@@ -119,78 +74,33 @@ static const struct regmap_access_table da9063_ad_volatile_table = {
 };
 
 static const struct regmap_range da9063_bb_readable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_BB_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_T_OFFSET,
-		.range_max = DA9063_BB_REG_GP_ID_19,
-	}, {
-		.range_min = DA9063_REG_CHIP_ID,
-		.range_max = DA9063_REG_CHIP_VARIANT,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_BB_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_T_OFFSET, DA9063_BB_REG_GP_ID_19),
+	regmap_reg_range(DA9063_REG_CHIP_ID, DA9063_REG_CHIP_VARIANT),
 };
 
 static const struct regmap_range da9063_bb_writeable_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_PAGE_CON,
-	}, {
-		.range_min = DA9063_REG_FAULT_LOG,
-		.range_max = DA9063_REG_VSYS_MON,
-	}, {
-		.range_min = DA9063_REG_COUNT_S,
-		.range_max = DA9063_BB_REG_ALARM_Y,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_ID_32_31,
-	}, {
-		.range_min = DA9063_REG_SEQ_A,
-		.range_max = DA9063_REG_AUTO3_LOW,
-	}, {
-		.range_min = DA9063_REG_CONFIG_I,
-		.range_max = DA9063_BB_REG_MON_REG_4,
-	}, {
-		.range_min = DA9063_BB_REG_GP_ID_0,
-		.range_max = DA9063_BB_REG_GP_ID_19,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_PAGE_CON),
+	regmap_reg_range(DA9063_REG_FAULT_LOG, DA9063_REG_VSYS_MON),
+	regmap_reg_range(DA9063_REG_COUNT_S, DA9063_BB_REG_ALARM_Y),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_ID_32_31),
+	regmap_reg_range(DA9063_REG_SEQ_A, DA9063_REG_AUTO3_LOW),
+	regmap_reg_range(DA9063_REG_CONFIG_I, DA9063_BB_REG_MON_REG_4),
+	regmap_reg_range(DA9063_BB_REG_GP_ID_0, DA9063_BB_REG_GP_ID_19),
 };
 
 static const struct regmap_range da9063_bb_volatile_ranges[] = {
-	{
-		.range_min = DA9063_REG_PAGE_CON,
-		.range_max = DA9063_REG_EVENT_D,
-	}, {
-		.range_min = DA9063_REG_CONTROL_A,
-		.range_max = DA9063_REG_CONTROL_B,
-	}, {
-		.range_min = DA9063_REG_CONTROL_E,
-		.range_max = DA9063_REG_CONTROL_F,
-	}, {
-		.range_min = DA9063_REG_BCORE2_CONT,
-		.range_max = DA9063_REG_LDO11_CONT,
-	}, {
-		.range_min = DA9063_REG_DVC_1,
-		.range_max = DA9063_REG_ADC_MAN,
-	}, {
-		.range_min = DA9063_REG_ADC_RES_L,
-		.range_max = DA9063_BB_REG_SECOND_D,
-	}, {
-		.range_min = DA9063_REG_SEQ,
-		.range_max = DA9063_REG_SEQ,
-	}, {
-		.range_min = DA9063_REG_EN_32K,
-		.range_max = DA9063_REG_EN_32K,
-	}, {
-		.range_min = DA9063_BB_REG_MON_REG_5,
-		.range_max = DA9063_BB_REG_MON_REG_6,
-	},
+	regmap_reg_range(DA9063_REG_PAGE_CON, DA9063_REG_EVENT_D),
+	regmap_reg_range(DA9063_REG_CONTROL_A, DA9063_REG_CONTROL_B),
+	regmap_reg_range(DA9063_REG_CONTROL_E, DA9063_REG_CONTROL_F),
+	regmap_reg_range(DA9063_REG_BCORE2_CONT, DA9063_REG_LDO11_CONT),
+	regmap_reg_range(DA9063_REG_DVC_1, DA9063_REG_ADC_MAN),
+	regmap_reg_range(DA9063_REG_ADC_RES_L, DA9063_BB_REG_SECOND_D),
+	regmap_reg_range(DA9063_REG_SEQ, DA9063_REG_SEQ),
+	regmap_reg_range(DA9063_REG_EN_32K, DA9063_REG_EN_32K),
+	regmap_reg_range(DA9063_BB_REG_MON_REG_5, DA9063_BB_REG_MON_REG_6),
 };
 
 static const struct regmap_access_table da9063_bb_readable_table = {
-- 
2.16.2
