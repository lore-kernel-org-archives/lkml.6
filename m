Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD17C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6392721904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzYNYT4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfBGM6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:58:12 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39402 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbfBGM6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:58:11 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so4456634pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kkLcm6nQiT55SYHuLrjQGCCVOD+ep+qOEKkTyL6nYV8=;
        b=UzYNYT4aoaOs0rbb9A6iQO1WRNEqQJSlBR6gVuCjNcxyybr5G5K6WEeC5JJ/jmdVuZ
         +X6SD1zX7jbY1/w0VzdruhFS5d3xXUU3RLTaGBZUayga4sQfVe2YX1lGGxmNGF0oUPbQ
         HwvPtCxJaexViuKGbiZUYcpvrIf6xP3tUiIA4Ah1bbY8JJQ6u9C40CLMwCjMlCS5RjSq
         bMnbWKvs9umdC49A7Ff7oug2QUdjIc3EsfytYiuLsBplyeQrVtD/8AbYtyGW7PLG9f4t
         hEgGb4UCd9X776GXzfjYs/CeuHzUCQw49UFXeiGkJ8D8FRHxo4Yi96MeuD4HLopu+K1I
         vMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kkLcm6nQiT55SYHuLrjQGCCVOD+ep+qOEKkTyL6nYV8=;
        b=bTrEQSxsetgobzlVATB8gtHBNAn3MfR4Zbw2eHgtlnvaAI2O/96Qjru1KT/LybX1+g
         zfd4jQQKK3Gegf+7RQkPc8T0iYjDXtSG0Dn56SH8lbqeqIjFy0s902JDZ7zaxaGGNws5
         VrHVDAqZIjhMsugC9AlXXggLJJZ4YbYyfNvvUaFi8urHHoseIPVt7waCxLU3PDyo2Ie/
         7/mkmP86srF0NEYIOIjYtoZ8CKJjTxfkh1jLlo3CQwayo1JrGMZ10HcqQr9XB741eQcS
         RrpoJf49atVPKQXPcCTDTJWzZ1qKYf6XkVfjiyDefnaX1iChZlSLzmc6aveLd+EP9FaO
         BsQw==
X-Gm-Message-State: AHQUAub31pUIB01cIMBgFYy3nPKpmnwbLSy5TIlB7KQIRdc15ptyfooB
        LtNDzwzwU1X+isAkaeg0mCctTc2xsm8=
X-Google-Smtp-Source: AHgI3Iav2f0cDQGmeu7VEldebZDYtV2XTSgjydy51JxJIK+p9xK9M8OuEluZp0cmFWp4MiMjrN3u1g==
X-Received: by 2002:a62:1709:: with SMTP id 9mr15817152pfx.249.1549544289913;
        Thu, 07 Feb 2019 04:58:09 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id g185sm12052449pfc.174.2019.02.07.04.58.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:58:08 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 10/24] drivers: thermal: tsens: Introduce reg_fields to deal with register description
Date:   Thu,  7 Feb 2019 16:19:28 +0530
Message-Id: <700047837730a4b0c1b8c0e70605158cd4b16bb9.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we add support for newer versions of the TSENS IP, the current
approach isn't scaling because registers and bitfields get moved around,
requiring platform-specific hacks in the code. By moving to regmap, we
can hide the register level differences away from the code.

Define a common set of registers and bit-fields that we care about
across the various tsens IP versions.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c |  59 ++++++-----
 drivers/thermal/qcom/tsens-v0_1.c   |  51 +++++++++-
 drivers/thermal/qcom/tsens-v2.c     | 140 ++++++++++++++++++++-----
 drivers/thermal/qcom/tsens.c        |   5 +-
 drivers/thermal/qcom/tsens.h        | 153 ++++++++++++++++++++++++++--
 5 files changed, 348 insertions(+), 60 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index af87216ee407..a82e4c928a78 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -12,13 +12,6 @@
 #include <linux/regmap.h>
 #include "tsens.h"
 
-/* SROT */
-#define TSENS_EN		BIT(0)
-
-/* TM */
-#define STATUS_OFFSET		0x30
-#define SN_ADDR_OFFSET		0x4
-#define SN_ST_TEMP_MASK		0x3ff
 #define CAL_DEGC_PT1		30
 #define CAL_DEGC_PT2		120
 #define SLOPE_FACTOR		1000
@@ -95,18 +88,14 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
-int get_temp_common(struct tsens_priv *priv, int id, int *temp)
+int get_temp_common(struct tsens_priv *priv, int i, int *temp)
 {
-	struct tsens_sensor *s = &priv->sensor[id];
-	u32 code;
-	unsigned int status_reg;
+	struct tsens_sensor *s = &priv->sensor[i];
 	int last_temp = 0, ret;
 
-	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[LAST_TEMP_0 + s->hw_id], &last_temp);
 	if (ret)
 		return ret;
-	last_temp = code & SN_ST_TEMP_MASK;
 
 	*temp = code_to_degc(last_temp, s) * 1000;
 
@@ -131,10 +120,9 @@ int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
-	u32 code;
-	int ret;
+	u32 enabled;
+	int ret, i, j;
 	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
-	u16 ctrl_offset = priv->reg_offsets[SROT_CTRL_OFFSET];
 
 	if (!op)
 		return -EINVAL;
@@ -166,14 +154,35 @@ int __init init_common(struct tsens_priv *priv)
 	if (IS_ERR(priv->tm_map))
 		return PTR_ERR(priv->tm_map);
 
-	if (priv->srot_map) {
-		ret = regmap_read(priv->srot_map, ctrl_offset, &code);
-		if (ret)
-			return ret;
-		if (!(code & TSENS_EN)) {
-			dev_err(priv->dev, "tsens device is not enabled\n");
-			return -ENODEV;
-		}
+	priv->rf[TSENS_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+						     priv->fields[TSENS_EN]);
+	if (IS_ERR(priv->rf[TSENS_EN]))
+		return PTR_ERR(priv->rf[TSENS_EN]);
+	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
+	if (ret)
+		return ret;
+	if (!enabled) {
+		dev_err(priv->dev, "tsens device is not enabled\n");
+		return -ENODEV;
+	}
+
+	priv->rf[SENSOR_EN] = devm_regmap_field_alloc(priv->dev, priv->srot_map,
+						      priv->fields[SENSOR_EN]);
+	if (IS_ERR(priv->rf[SENSOR_EN]))
+		return PTR_ERR(priv->rf[SENSOR_EN]);
+
+	/* now alloc regmap_fields in tm_map */
+	for (i = 0, j = LAST_TEMP_0; i < priv->num_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j]))
+			return PTR_ERR(priv->rf[j]);
+	}
+	for (i = 0, j = VALID_0; i < priv->num_sensors; i++, j++) {
+		priv->rf[j] = devm_regmap_field_alloc(priv->dev, priv->tm_map,
+						      priv->fields[j]);
+		if (IS_ERR(priv->rf[j]))
+			return PTR_ERR(priv->rf[j]);
 	}
 
 	return 0;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index a6e26be1234f..02907751c201 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -6,6 +6,15 @@
 #include <linux/platform_device.h>
 #include "tsens.h"
 
+/* ----- SROT ------ */
+#define SROT_CTRL_OFF 0x0000
+
+/* ----- TM ------ */
+#define TM_INT_EN_OFF				0x0000
+#define TM_Sn_UPPER_LOWER_STATUS_CTRL_OFF	0x0004
+#define TM_Sn_STATUS_OFF			0x0030
+#define TM_TRDY_OFF				0x005c
+
 /* eeprom layout data for 8916 */
 #define MSM8916_BASE0_MASK	0x0000007f
 #define MSM8916_BASE1_MASK	0xfe000000
@@ -308,6 +317,41 @@ static int calibrate_8974(struct tsens_priv *priv)
 	return 0;
 }
 
+/* v0.1: 8916, 8974 */
+
+const struct tsens_features tsens_v0_1_feat = {
+	.ver_info	= 0,
+	.crit_int	= 0,
+	.adc		= 1,
+	.srot_split	= 1,
+};
+
+/* v0.1: 8916, 8974 */
+const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* CTRL_OFFSET */
+	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
+	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+
+	/* ----- TM ------ */
+	/* UPPER_LOWER_INTERRUPT_CTRL */
+	[INT_EN] = REG_FIELD(TM_INT_EN_OFF, 0, 0),
+	/* Sn_STATUS */
+	REG_BANK(LAST_TEMP,  0, TM_Sn_STATUS_OFF,      0, 9),
+	REG_BANK(LAST_TEMP,  1, TM_Sn_STATUS_OFF +  4, 0, 9),
+	REG_BANK(LAST_TEMP,  2, TM_Sn_STATUS_OFF +  8, 0, 9),
+	REG_BANK(LAST_TEMP,  3, TM_Sn_STATUS_OFF + 12, 0, 9),
+	REG_BANK(LAST_TEMP,  4, TM_Sn_STATUS_OFF + 16, 0, 9),
+	REG_BANK(LAST_TEMP,  5, TM_Sn_STATUS_OFF + 20, 0, 9),
+	REG_BANK(LAST_TEMP,  6, TM_Sn_STATUS_OFF + 24, 0, 9),
+	REG_BANK(LAST_TEMP,  7, TM_Sn_STATUS_OFF + 28, 0, 9),
+	REG_BANK(LAST_TEMP,  8, TM_Sn_STATUS_OFF + 32, 0, 9),
+	REG_BANK(LAST_TEMP,  9, TM_Sn_STATUS_OFF + 36, 0, 9),
+	REG_BANK(LAST_TEMP, 10, TM_Sn_STATUS_OFF + 40, 0, 9),
+	/* TRDY */
+	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+};
+
 static const struct tsens_ops ops_8916 = {
 	.init		= init_common,
 	.calibrate	= calibrate_8916,
@@ -317,8 +361,10 @@ static const struct tsens_ops ops_8916 = {
 const struct tsens_plat_data data_8916 = {
 	.num_sensors	= 5,
 	.ops		= &ops_8916,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
 	.hw_ids		= (unsigned int []){0, 1, 2, 4, 5 },
+
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
 };
 
 static const struct tsens_ops ops_8974 = {
@@ -330,5 +376,6 @@ static const struct tsens_ops ops_8974 = {
 const struct tsens_plat_data data_8974 = {
 	.num_sensors	= 11,
 	.ops		= &ops_8974,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x0 },
+	.feat		= &tsens_v0_1_feat,
+	.fields	= tsens_v0_1_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 8b700772d903..962e47c54dca 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -4,50 +4,70 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
-#include <linux/regmap.h>
 #include <linux/bitops.h>
+#include <linux/regmap.h>
 #include "tsens.h"
 
-#define STATUS_OFFSET		0xa0
+/* ----- SROT ------ */
+#define SROT_HW_VER_OFF	0x0000
+#define SROT_CTRL_OFF		0x0004
+
+/* ----- TM ------ */
+#define TM_INT_EN_OFF			0x0004
+#define TM_UPPER_LOWER_INT_STATUS_OFF	0x0008
+#define TM_UPPER_LOWER_INT_CLEAR_OFF	0x000c
+#define TM_UPPER_LOWER_INT_MASK_OFF	0x0010
+#define TM_CRITICAL_INT_STATUS_OFF	0x0014
+#define TM_CRITICAL_INT_CLEAR_OFF	0x0018
+#define TM_CRITICAL_INT_MASK_OFF	0x001c
+#define TM_Sn_UPPER_LOWER_THRESHOLD_OFF 0x0020
+#define TM_Sn_CRITICAL_THRESHOLD_OFF	0x0060
+#define TM_Sn_STATUS_OFF		0x00a0
+#define TM_TRDY_OFF			0x00e4
+
 #define LAST_TEMP_MASK		0xfff
-#define STATUS_VALID_BIT	BIT(21)
 
 static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 {
 	struct tsens_sensor *s = &priv->sensor[id];
-	u32 code;
-	unsigned int status_reg;
-	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
+	u32 temp_idx = LAST_TEMP_0 + s->hw_id;
+	u32 valid_idx = VALID_0 + s->hw_id;
+	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0, valid;
 	int ret;
 
-	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp);
 	if (ret)
 		return ret;
-	last_temp = code & LAST_TEMP_MASK;
-	if (code & STATUS_VALID_BIT)
+
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
+	if (ret)
+		return ret;
+
+	if (valid)
 		goto done;
 
 	/* Try a second time */
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp2);
+	if (ret)
+		return ret;
+	if (valid) {
+		last_temp = last_temp2;
 		goto done;
-	} else {
-		last_temp2 = code & LAST_TEMP_MASK;
 	}
 
 	/* Try a third/last time */
-	ret = regmap_read(priv->tm_map, status_reg, &code);
+	ret = regmap_field_read(priv->rf[valid_idx], &valid);
 	if (ret)
 		return ret;
-	if (code & STATUS_VALID_BIT) {
-		last_temp = code & LAST_TEMP_MASK;
+	ret = regmap_field_read(priv->rf[temp_idx], &last_temp3);
+	if (ret)
+		return ret;
+	if (valid) {
+		last_temp = last_temp3;
 		goto done;
-	} else {
-		last_temp3 = code & LAST_TEMP_MASK;
 	}
 
 	if (last_temp == last_temp2)
@@ -61,19 +81,93 @@ static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 	return 0;
 }
 
+/* v2.x: 8996, 8998, sdm845 */
+
+const struct tsens_features tsens_v2_feat = {
+	.ver_info	= 1,
+	.crit_int	= 1,
+	.adc		= 0,
+	.srot_split	= 1,
+};
+
+const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
+	/* ----- SROT ------ */
+	/* VERSION */
+	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
+	[VER_MINOR] = REG_FIELD(SROT_HW_VER_OFF, 16, 27),
+	[VER_STEP]  = REG_FIELD(SROT_HW_VER_OFF,  0, 15),
+	/* CTRL_OFF */
+	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
+	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+
+	/* ----- TM ------ */
+	/* INTERRUPT ENABLE */
+	[LOW_INT_EN]  = REG_FIELD(TM_INT_EN_OFF, 0, 0),
+	[UP_INT_EN]   = REG_FIELD(TM_INT_EN_OFF, 1, 1),
+	[CRIT_INT_EN] = REG_FIELD(TM_INT_EN_OFF, 2, 2),
+	/* UPPER_LOWER_INTERRUPTS */
+	[LOW_INT_STATUS]  = REG_FIELD(TM_UPPER_LOWER_INT_STATUS_OFF,  0, 15),
+	[UP_INT_STATUS]   = REG_FIELD(TM_UPPER_LOWER_INT_STATUS_OFF, 16, 31),
+	[LOW_INT_CLEAR]   = REG_FIELD(TM_UPPER_LOWER_INT_CLEAR_OFF,   0, 15),
+	[UP_INT_CLEAR]    = REG_FIELD(TM_UPPER_LOWER_INT_CLEAR_OFF,  16, 31),
+	[LOW_INT_MASK]    = REG_FIELD(TM_UPPER_LOWER_INT_MASK_OFF,    0, 15),
+	[UP_INT_MASK]     = REG_FIELD(TM_UPPER_LOWER_INT_MASK_OFF,   16, 31),
+	/* CRITICAL_INTERRUPT */
+	[CRIT_INT_STATUS] = REG_FIELD(TM_CRITICAL_INT_STATUS_OFF,     0, 15),
+	[CRIT_INT_CLEAR]  = REG_FIELD(TM_UPPER_LOWER_INT_STATUS_OFF,  0, 15),
+	[CRIT_INT_MASK]   = REG_FIELD(TM_UPPER_LOWER_INT_STATUS_OFF,  0, 15),
+	/* Sn_STATUS */
+	REG_BANK(LAST_TEMP,  0, TM_Sn_STATUS_OFF,       0, 11),
+	REG_BANK(LAST_TEMP,  1, TM_Sn_STATUS_OFF +  4,  0, 11),
+	REG_BANK(LAST_TEMP,  2, TM_Sn_STATUS_OFF +  8,  0, 11),
+	REG_BANK(LAST_TEMP,  3, TM_Sn_STATUS_OFF + 12,  0, 11),
+	REG_BANK(LAST_TEMP,  4, TM_Sn_STATUS_OFF + 16,  0, 11),
+	REG_BANK(LAST_TEMP,  5, TM_Sn_STATUS_OFF + 20,  0, 11),
+	REG_BANK(LAST_TEMP,  6, TM_Sn_STATUS_OFF + 24,  0, 11),
+	REG_BANK(LAST_TEMP,  7, TM_Sn_STATUS_OFF + 28,  0, 11),
+	REG_BANK(LAST_TEMP,  8, TM_Sn_STATUS_OFF + 32,  0, 11),
+	REG_BANK(LAST_TEMP,  9, TM_Sn_STATUS_OFF + 36,  0, 11),
+	REG_BANK(LAST_TEMP, 10, TM_Sn_STATUS_OFF + 40,  0, 11),
+	REG_BANK(LAST_TEMP, 11, TM_Sn_STATUS_OFF + 44,  0, 11),
+	REG_BANK(LAST_TEMP, 12, TM_Sn_STATUS_OFF + 48,  0, 11),
+	REG_BANK(LAST_TEMP, 13, TM_Sn_STATUS_OFF + 52,  0, 11),
+	REG_BANK(LAST_TEMP, 14, TM_Sn_STATUS_OFF + 56,  0, 11),
+	REG_BANK(LAST_TEMP, 15, TM_Sn_STATUS_OFF + 60,  0, 11),
+	REG_BANK(VALID,      0, TM_Sn_STATUS_OFF,      21, 21),
+	REG_BANK(VALID,      1, TM_Sn_STATUS_OFF +  4, 21, 21),
+	REG_BANK(VALID,      2, TM_Sn_STATUS_OFF +  8, 21, 21),
+	REG_BANK(VALID,      3, TM_Sn_STATUS_OFF + 12, 21, 21),
+	REG_BANK(VALID,      4, TM_Sn_STATUS_OFF + 16, 21, 21),
+	REG_BANK(VALID,      5, TM_Sn_STATUS_OFF + 20, 21, 21),
+	REG_BANK(VALID,      6, TM_Sn_STATUS_OFF + 24, 21, 21),
+	REG_BANK(VALID,      7, TM_Sn_STATUS_OFF + 28, 21, 21),
+	REG_BANK(VALID,      8, TM_Sn_STATUS_OFF + 32, 21, 21),
+	REG_BANK(VALID,      9, TM_Sn_STATUS_OFF + 36, 21, 21),
+	REG_BANK(VALID,     10, TM_Sn_STATUS_OFF + 40, 21, 21),
+	REG_BANK(VALID,     11, TM_Sn_STATUS_OFF + 44, 21, 21),
+	REG_BANK(VALID,     12, TM_Sn_STATUS_OFF + 48, 21, 21),
+	REG_BANK(VALID,     13, TM_Sn_STATUS_OFF + 52, 21, 21),
+	REG_BANK(VALID,     14, TM_Sn_STATUS_OFF + 56, 21, 21),
+	REG_BANK(VALID,     15, TM_Sn_STATUS_OFF + 60, 21, 21),
+	/* TRDY: 1=ready, 0=in progress */
+	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+};
+
 static const struct tsens_ops ops_generic_v2 = {
 	.init		= init_common,
 	.get_temp	= get_temp_tsens_v2,
 };
 
 const struct tsens_plat_data data_tsens_v2 = {
-	.ops            = &ops_generic_v2,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
+	.ops		= &ops_generic_v2,
+	.feat		= &tsens_v2_feat,
+	.fields	= tsens_v2_regfields,
 };
 
 /* Kept around for backward compatibility with old msm8996.dtsi */
 const struct tsens_plat_data data_8996 = {
 	.num_sensors	= 13,
 	.ops		= &ops_generic_v2,
-	.reg_offsets	= { [SROT_CTRL_OFFSET] = 0x4 },
+	.feat		= &tsens_v2_feat,
+	.fields	= tsens_v2_regfields,
 };
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 0b5be08d515f..b91a0b88d33c 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -144,9 +144,8 @@ static int tsens_probe(struct platform_device *pdev)
 		else
 			priv->sensor[i].hw_id = i;
 	}
-	for (i = 0; i < REG_ARRAY_SIZE; i++) {
-		priv->reg_offsets[i] = data->reg_offsets[i];
-	}
+	priv->feat = data->feat;
+	priv->fields = data->fields;
 
 	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 27b8f74829d9..20d89f8a6c3e 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -11,6 +11,7 @@
 #define TWO_PT_CALIB		0x3
 
 #include <linux/thermal.h>
+#include <linux/regmap.h>
 
 struct tsens_priv;
 
@@ -58,10 +59,142 @@ struct tsens_ops {
 	int (*get_trend)(struct tsens_priv *priv, int i, enum thermal_trend *trend);
 };
 
-enum reg_list {
-	SROT_CTRL_OFFSET,
+#define REG_BANK(_name, _index, _offset, _startbit, _stopbit)		\
+	[_name##_##_index] = REG_FIELD(_offset, _startbit, _stopbit)
 
-	REG_ARRAY_SIZE,
+/* reg_field IDs to use as an index into an array */
+enum regfield_ids {
+	/* ----- SROT ------ */
+	/* HW_VER */
+	VER_MAJOR = 0,
+	VER_MINOR,
+	VER_STEP,
+	/* CTRL_OFFSET */
+	TSENS_EN =  3,
+	TSENS_SW_RST,
+	SENSOR_EN,
+	CODE_OR_TEMP,
+
+	/* ----- TM ------ */
+	/* STATUS */
+	LAST_TEMP_0 = 7,
+	LAST_TEMP_1,
+	LAST_TEMP_2,
+	LAST_TEMP_3,
+	LAST_TEMP_4,
+	LAST_TEMP_5,
+	LAST_TEMP_6,
+	LAST_TEMP_7,
+	LAST_TEMP_8,
+	LAST_TEMP_9,
+	LAST_TEMP_10,
+	LAST_TEMP_11,
+	LAST_TEMP_12,
+	LAST_TEMP_13,
+	LAST_TEMP_14,
+	LAST_TEMP_15,
+	VALID_0 = 23,
+	VALID_1,
+	VALID_2,
+	VALID_3,
+	VALID_4,
+	VALID_5,
+	VALID_6,
+	VALID_7,
+	VALID_8,
+	VALID_9,
+	VALID_10,
+	VALID_11,
+	VALID_12,
+	VALID_13,
+	VALID_14,
+	VALID_15,
+	/* TRDY */
+	TRDY,
+	/* INTERRUPT ENABLE */
+	INT_EN,	/* PRE-V1, V1.x */
+	LOW_INT_EN,	/* V2.x */
+	UP_INT_EN,	/* V2.x */
+	CRIT_INT_EN,	/* V2.x */
+	/* INTERRUPT_STATUS */
+	LOW_INT_STATUS,
+	UP_INT_STATUS,
+	CRIT_INT_STATUS,
+	/* INTERRUPT_CLEAR */
+	LOW_INT_CLEAR,
+	UP_INT_CLEAR,
+	CRIT_INT_CLEAR,
+	/* INTERRUPT_MASK */
+	LOW_INT_MASK,
+	UP_INT_MASK,
+	CRIT_INT_MASK,
+	/* THRESHOLD */
+	LOW_THRESH_0,
+	LOW_THRESH_1,
+	LOW_THRESH_2,
+	LOW_THRESH_3,
+	LOW_THRESH_4,
+	LOW_THRESH_5,
+	LOW_THRESH_6,
+	LOW_THRESH_7,
+	LOW_THRESH_8,
+	LOW_THRESH_9,
+	LOW_THRESH_10,
+	LOW_THRESH_11,
+	LOW_THRESH_12,
+	LOW_THRESH_13,
+	LOW_THRESH_14,
+	LOW_THRESH_15,
+	UP_THRESH_0,
+	UP_THRESH_1,
+	UP_THRESH_2,
+	UP_THRESH_3,
+	UP_THRESH_4,
+	UP_THRESH_5,
+	UP_THRESH_6,
+	UP_THRESH_7,
+	UP_THRESH_8,
+	UP_THRESH_9,
+	UP_THRESH_10,
+	UP_THRESH_11,
+	UP_THRESH_12,
+	UP_THRESH_13,
+	UP_THRESH_14,
+	UP_THRESH_15,
+	CRIT_THRESH_0,
+	CRIT_THRESH_1,
+	CRIT_THRESH_2,
+	CRIT_THRESH_3,
+	CRIT_THRESH_4,
+	CRIT_THRESH_5,
+	CRIT_THRESH_6,
+	CRIT_THRESH_7,
+	CRIT_THRESH_8,
+	CRIT_THRESH_9,
+	CRIT_THRESH_10,
+	CRIT_THRESH_11,
+	CRIT_THRESH_12,
+	CRIT_THRESH_13,
+	CRIT_THRESH_14,
+	CRIT_THRESH_15,
+
+	/* Keep last */
+	MAX_REGFIELDS
+};
+
+/**
+ * struct tsens_features - Features supported by the IP
+ * @ver_info: does the IP export version information?
+ * @crit_int: does the IP support critical interrupts?
+ * @adc:      do the sensors only output adc code (instead of temperature)?
+ * @srot_split: does the IP neatly splits the register space into SROT and TM,
+ *              with SROT only being available to secure boot firmware?
+ */
+struct tsens_features {
+	unsigned int ver_info:1;
+	unsigned int crit_int:1;
+	unsigned int adc:1;
+	unsigned int srot_split:1;
 };
 
 /**
@@ -69,13 +202,15 @@ enum reg_list {
  * @num_sensors: Number of sensors supported by platform
  * @ops: operations the tsens instance supports
  * @hw_ids: Subset of sensors ids supported by platform, if not the first n
- * @reg_offsets: Register offsets for commonly used registers
+ * @feat: features of the IP
+ * @fields: bitfield locations
  */
 struct tsens_plat_data {
 	const u32		num_sensors;
 	const struct tsens_ops	*ops;
-	const u16		reg_offsets[REG_ARRAY_SIZE];
 	unsigned int		*hw_ids;
+	const struct tsens_features	*feat;
+	const struct reg_field		*fields;
 };
 
 /**
@@ -94,8 +229,10 @@ struct tsens_context {
  * @srot_map: pointer to SROT register address space
  * @tm_offset: deal with old device trees that don't address TM and SROT
  *             address space separately
- * @reg_offsets: array of offsets to important regs for this version of IP
+ * @rf: array of regmap_fields used to store value of the field
  * @ctx: registers to be saved and restored during suspend/resume
+ * @feat: features of the IP
+ * @fields: bitfield locations
  * @ops: pointer to list of callbacks supported by this device
  * @sensor: list of sensors attached to this device
  */
@@ -105,8 +242,10 @@ struct tsens_priv {
 	struct regmap			*tm_map;
 	struct regmap			*srot_map;
 	u32				tm_offset;
-	u16				reg_offsets[REG_ARRAY_SIZE];
+	struct regmap_field		*rf[MAX_REGFIELDS];
 	struct tsens_context		ctx;
+	const struct tsens_features	*feat;
+	const struct reg_field		*fields;
 	const struct tsens_ops		*ops;
 	struct tsens_sensor		sensor[0];
 };
-- 
2.17.1

