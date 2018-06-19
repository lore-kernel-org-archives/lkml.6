Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075F5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E28E2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 11:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y7pSAkyh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d+KtaZLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E28E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937722AbeFSLPP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 07:15:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57974 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936108AbeFSLPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 07:15:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 78E2B60B16; Tue, 19 Jun 2018 11:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406910;
        bh=SNM0ZHxpQCuwKr76le+gCCNfmdA57r/gnoUJGoVrXho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7pSAkyh7SQ3LxtuR1NpzVhP6I795+7h8K9mU1U8nUthkfZMGqXNAEetrKpjcTELk
         6K9xj84nw10486At9ShUDBq9Aibu5CTfTTH4KN2zxVuGIHkzu6FVPvaLejZkpVhA1I
         Pt/qmIQcRmSGGzOovWXSqmjH7P9OFA04moRaIv1E=
Received: from kgunda-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E2D3960AD9;
        Tue, 19 Jun 2018 11:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529406908;
        bh=SNM0ZHxpQCuwKr76le+gCCNfmdA57r/gnoUJGoVrXho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+KtaZLckf8HjrdWPD3t20cLmgj24BD+42rx17F2q36tFCFoacQ4CE1PN4UMgLRlP
         D2xbMd3yuT2oDi+4UUT1F1Sr9cN1oJXbo/BQTjfr2utKq998JmBJiigoomYxiO08B4
         jbV888cNDBYmwHXc55tn6omoUHfmCcjUPsJyIjRM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E2D3960AD9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 4/7] backlight: qcom-wled: Rename PM8941* to WLED3
Date:   Tue, 19 Jun 2018 16:43:39 +0530
Message-Id: <1529406822-15379-5-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the PM8941* references as WLED3 to make the
driver generic and have WLED support for other PMICs.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 drivers/video/backlight/qcom-wled.c | 248 ++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 123 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 0b6d219..812f3cb 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -18,77 +18,79 @@
 #include <linux/regmap.h>
 
 /* From DT binding */
-#define PM8941_WLED_DEFAULT_BRIGHTNESS		2048
+#define WLED_DEFAULT_BRIGHTNESS				2048
 
-#define PM8941_WLED_REG_VAL_BASE		0x40
-#define  PM8941_WLED_REG_VAL_MAX		0xFFF
+#define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
+#define WLED3_CTRL_REG_VAL_BASE				0x40
 
-#define PM8941_WLED_REG_MOD_EN			0x46
-#define  PM8941_WLED_REG_MOD_EN_BIT		BIT(7)
-#define  PM8941_WLED_REG_MOD_EN_MASK		BIT(7)
+/* WLED3 control registers */
+#define WLED3_CTRL_REG_MOD_EN				0x46
+#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
+#define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
 
-#define PM8941_WLED_REG_SYNC			0x47
-#define  PM8941_WLED_REG_SYNC_MASK		0x07
-#define  PM8941_WLED_REG_SYNC_LED1		BIT(0)
-#define  PM8941_WLED_REG_SYNC_LED2		BIT(1)
-#define  PM8941_WLED_REG_SYNC_LED3		BIT(2)
-#define  PM8941_WLED_REG_SYNC_ALL		0x07
-#define  PM8941_WLED_REG_SYNC_CLEAR		0x00
+#define WLED3_CTRL_REG_FREQ				0x4c
+#define  WLED3_CTRL_REG_FREQ_MASK			0x0f
 
-#define PM8941_WLED_REG_FREQ			0x4c
-#define  PM8941_WLED_REG_FREQ_MASK		0x0f
+#define WLED3_CTRL_REG_OVP				0x4d
+#define  WLED3_CTRL_REG_OVP_MASK			0x03
 
-#define PM8941_WLED_REG_OVP			0x4d
-#define  PM8941_WLED_REG_OVP_MASK		0x03
+#define WLED3_CTRL_REG_ILIMIT				0x4e
+#define  WLED3_CTRL_REG_ILIMIT_MASK			0x07
 
-#define PM8941_WLED_REG_BOOST			0x4e
-#define  PM8941_WLED_REG_BOOST_MASK		0x07
+/* WLED3 sink registers */
+#define WLED3_SINK_REG_SYNC				0x47
+#define  WLED3_SINK_REG_SYNC_MASK			0x07
+#define  WLED3_SINK_REG_SYNC_LED1			BIT(0)
+#define  WLED3_SINK_REG_SYNC_LED2			BIT(1)
+#define  WLED3_SINK_REG_SYNC_LED3			BIT(2)
+#define  WLED3_SINK_REG_SYNC_ALL			0x07
+#define  WLED3_SINK_REG_SYNC_CLEAR			0x00
 
-#define PM8941_WLED_REG_SINK			0x4f
-#define  PM8941_WLED_REG_SINK_MASK		0xe0
-#define  PM8941_WLED_REG_SINK_SHFT		0x05
+#define WLED3_SINK_REG_CURR_SINK			0x4f
+#define  WLED3_SINK_REG_CURR_SINK_MASK			0xe0
+#define  WLED3_SINK_REG_CURR_SINK_SHFT			0x05
 
-/* Per-'string' registers below */
-#define PM8941_WLED_REG_STR_OFFSET		0x10
+/* WLED3 per-'string' registers below */
+#define WLED3_SINK_REG_STR_OFFSET			0x10
 
-#define PM8941_WLED_REG_STR_MOD_EN_BASE		0x60
-#define  PM8941_WLED_REG_STR_MOD_MASK		BIT(7)
-#define  PM8941_WLED_REG_STR_MOD_EN		BIT(7)
+#define WLED3_SINK_REG_STR_MOD_EN_BASE			0x60
+#define  WLED3_SINK_REG_STR_MOD_MASK			BIT(7)
+#define  WLED3_SINK_REG_STR_MOD_EN			BIT(7)
 
-#define PM8941_WLED_REG_STR_SCALE_BASE		0x62
-#define  PM8941_WLED_REG_STR_SCALE_MASK		0x1f
+#define WLED3_SINK_REG_STR_FULL_SCALE_CURR		0x62
+#define  WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK	0x1f
 
-#define PM8941_WLED_REG_STR_MOD_SRC_BASE	0x63
-#define  PM8941_WLED_REG_STR_MOD_SRC_MASK	0x01
-#define  PM8941_WLED_REG_STR_MOD_SRC_INT	0x00
-#define  PM8941_WLED_REG_STR_MOD_SRC_EXT	0x01
+#define WLED3_SINK_REG_STR_MOD_SRC_BASE			0x63
+#define  WLED3_SINK_REG_STR_MOD_SRC_MASK		0x01
+#define  WLED3_SINK_REG_STR_MOD_SRC_INT			0x00
+#define  WLED3_SINK_REG_STR_MOD_SRC_EXT			0x01
 
-#define PM8941_WLED_REG_STR_CABC_BASE		0x66
-#define  PM8941_WLED_REG_STR_CABC_MASK		BIT(7)
-#define  PM8941_WLED_REG_STR_CABC_EN		BIT(7)
+#define WLED3_SINK_REG_STR_CABC_BASE			0x66
+#define  WLED3_SINK_REG_STR_CABC_MASK			BIT(7)
+#define  WLED3_SINK_REG_STR_CABC_EN			BIT(7)
 
-struct pm8941_wled_config {
-	u32 i_boost_limit;
+struct wled_config {
+	u32 boost_i_limit;
 	u32 ovp;
 	u32 switch_freq;
 	u32 num_strings;
-	u32 i_limit;
+	u32 string_i_limit;
 	bool cs_out_en;
 	bool ext_gen;
 	bool cabc_en;
 };
 
-struct pm8941_wled {
+struct wled {
 	const char *name;
 	struct regmap *regmap;
 	u16 addr;
 
-	struct pm8941_wled_config cfg;
+	struct wled_config cfg;
 };
 
-static int pm8941_wled_update_status(struct backlight_device *bl)
+static int wled_update_status(struct backlight_device *bl)
 {
-	struct pm8941_wled *wled = bl_get_data(bl);
+	struct wled *wled = bl_get_data(bl);
 	u16 val = bl->props.brightness;
 	u8 ctrl = 0;
 	int rc;
@@ -100,11 +102,11 @@ static int pm8941_wled_update_status(struct backlight_device *bl)
 		val = 0;
 
 	if (val != 0)
-		ctrl = PM8941_WLED_REG_MOD_EN_BIT;
+		ctrl = WLED3_CTRL_REG_MOD_EN_BIT;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_MOD_EN,
-			PM8941_WLED_REG_MOD_EN_MASK, ctrl);
+			wled->addr + WLED3_CTRL_REG_MOD_EN,
+			WLED3_CTRL_REG_MOD_EN_MASK, ctrl);
 	if (rc)
 		return rc;
 
@@ -112,89 +114,89 @@ static int pm8941_wled_update_status(struct backlight_device *bl)
 		u8 v[2] = { val & 0xff, (val >> 8) & 0xf };
 
 		rc = regmap_bulk_write(wled->regmap,
-				wled->addr + PM8941_WLED_REG_VAL_BASE + 2 * i,
+				wled->addr + WLED3_CTRL_REG_VAL_BASE + 2 * i,
 				v, 2);
 		if (rc)
 			return rc;
 	}
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_SYNC,
-			PM8941_WLED_REG_SYNC_MASK, PM8941_WLED_REG_SYNC_ALL);
+			wled->addr + WLED3_SINK_REG_SYNC,
+			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_ALL);
 	if (rc)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_SYNC,
-			PM8941_WLED_REG_SYNC_MASK, PM8941_WLED_REG_SYNC_CLEAR);
+			wled->addr + WLED3_SINK_REG_SYNC,
+			WLED3_SINK_REG_SYNC_MASK, WLED3_SINK_REG_SYNC_CLEAR);
 	return rc;
 }
 
-static int pm8941_wled_setup(struct pm8941_wled *wled)
+static int wled_setup(struct wled *wled)
 {
 	int rc;
 	int i;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_OVP,
-			PM8941_WLED_REG_OVP_MASK, wled->cfg.ovp);
+			wled->addr + WLED3_CTRL_REG_OVP,
+			WLED3_CTRL_REG_OVP_MASK, wled->cfg.ovp);
 	if (rc)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_BOOST,
-			PM8941_WLED_REG_BOOST_MASK, wled->cfg.i_boost_limit);
+			wled->addr + WLED3_CTRL_REG_ILIMIT,
+			WLED3_CTRL_REG_ILIMIT_MASK, wled->cfg.boost_i_limit);
 	if (rc)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
-			wled->addr + PM8941_WLED_REG_FREQ,
-			PM8941_WLED_REG_FREQ_MASK, wled->cfg.switch_freq);
+			wled->addr + WLED3_CTRL_REG_FREQ,
+			WLED3_CTRL_REG_FREQ_MASK, wled->cfg.switch_freq);
 	if (rc)
 		return rc;
 
 	if (wled->cfg.cs_out_en) {
 		u8 all = (BIT(wled->cfg.num_strings) - 1)
-				<< PM8941_WLED_REG_SINK_SHFT;
+				<< WLED3_SINK_REG_CURR_SINK_SHFT;
 
 		rc = regmap_update_bits(wled->regmap,
-				wled->addr + PM8941_WLED_REG_SINK,
-				PM8941_WLED_REG_SINK_MASK, all);
+				wled->addr + WLED3_SINK_REG_CURR_SINK,
+				WLED3_SINK_REG_CURR_SINK_MASK, all);
 		if (rc)
 			return rc;
 	}
 
 	for (i = 0; i < wled->cfg.num_strings; ++i) {
-		u16 addr = wled->addr + PM8941_WLED_REG_STR_OFFSET * i;
+		u16 addr = wled->addr + WLED3_SINK_REG_STR_OFFSET * i;
 
 		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_MOD_EN_BASE,
-				PM8941_WLED_REG_STR_MOD_MASK,
-				PM8941_WLED_REG_STR_MOD_EN);
+				addr + WLED3_SINK_REG_STR_MOD_EN_BASE,
+				WLED3_SINK_REG_STR_MOD_MASK,
+				WLED3_SINK_REG_STR_MOD_EN);
 		if (rc)
 			return rc;
 
 		if (wled->cfg.ext_gen) {
 			rc = regmap_update_bits(wled->regmap,
-					addr + PM8941_WLED_REG_STR_MOD_SRC_BASE,
-					PM8941_WLED_REG_STR_MOD_SRC_MASK,
-					PM8941_WLED_REG_STR_MOD_SRC_EXT);
+					addr + WLED3_SINK_REG_STR_MOD_SRC_BASE,
+					WLED3_SINK_REG_STR_MOD_SRC_MASK,
+					WLED3_SINK_REG_STR_MOD_SRC_EXT);
 			if (rc)
 				return rc;
 		}
 
 		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_SCALE_BASE,
-				PM8941_WLED_REG_STR_SCALE_MASK,
-				wled->cfg.i_limit);
+				addr + WLED3_SINK_REG_STR_FULL_SCALE_CURR,
+				WLED3_SINK_REG_STR_FULL_SCALE_CURR_MASK,
+				wled->cfg.string_i_limit);
 		if (rc)
 			return rc;
 
 		rc = regmap_update_bits(wled->regmap,
-				addr + PM8941_WLED_REG_STR_CABC_BASE,
-				PM8941_WLED_REG_STR_CABC_MASK,
+				addr + WLED3_SINK_REG_STR_CABC_BASE,
+				WLED3_SINK_REG_STR_CABC_MASK,
 				wled->cfg.cabc_en ?
-					PM8941_WLED_REG_STR_CABC_EN : 0);
+					WLED3_SINK_REG_STR_CABC_EN : 0);
 		if (rc)
 			return rc;
 	}
@@ -202,9 +204,9 @@ static int pm8941_wled_setup(struct pm8941_wled *wled)
 	return 0;
 }
 
-static const struct pm8941_wled_config pm8941_wled_config_defaults = {
-	.i_boost_limit = 3,
-	.i_limit = 20,
+static const struct wled_config wled3_config_defaults = {
+	.boost_i_limit = 3,
+	.string_i_limit = 20,
 	.ovp = 2,
 	.switch_freq = 5,
 	.num_strings = 0,
@@ -213,55 +215,55 @@ static int pm8941_wled_setup(struct pm8941_wled *wled)
 	.cabc_en = false,
 };
 
-struct pm8941_wled_var_cfg {
+struct wled_var_cfg {
 	const u32 *values;
 	u32 (*fn)(u32);
 	int size;
 };
 
-static const u32 pm8941_wled_i_boost_limit_values[] = {
+static const u32 wled3_boost_i_limit_values[] = {
 	105, 385, 525, 805, 980, 1260, 1400, 1680,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_i_boost_limit_cfg = {
-	.values = pm8941_wled_i_boost_limit_values,
-	.size = ARRAY_SIZE(pm8941_wled_i_boost_limit_values),
+static const struct wled_var_cfg wled3_boost_i_limit_cfg = {
+	.values = wled3_boost_i_limit_values,
+	.size = ARRAY_SIZE(wled3_boost_i_limit_values),
 };
 
-static const u32 pm8941_wled_ovp_values[] = {
+static const u32 wled3_ovp_values[] = {
 	35, 32, 29, 27,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_ovp_cfg = {
-	.values = pm8941_wled_ovp_values,
-	.size = ARRAY_SIZE(pm8941_wled_ovp_values),
+static const struct wled_var_cfg wled3_ovp_cfg = {
+	.values = wled3_ovp_values,
+	.size = ARRAY_SIZE(wled3_ovp_values),
 };
 
-static u32 pm8941_wled_num_strings_values_fn(u32 idx)
+static u32 wled3_num_strings_values_fn(u32 idx)
 {
 	return idx + 1;
 }
 
-static const struct pm8941_wled_var_cfg pm8941_wled_num_strings_cfg = {
-	.fn = pm8941_wled_num_strings_values_fn,
+static const struct wled_var_cfg wled3_num_strings_cfg = {
+	.fn = wled3_num_strings_values_fn,
 	.size = 3,
 };
 
-static u32 pm8941_wled_switch_freq_values_fn(u32 idx)
+static u32 wled3_switch_freq_values_fn(u32 idx)
 {
 	return 19200 / (2 * (1 + idx));
 }
 
-static const struct pm8941_wled_var_cfg pm8941_wled_switch_freq_cfg = {
-	.fn = pm8941_wled_switch_freq_values_fn,
+static const struct wled_var_cfg wled3_switch_freq_cfg = {
+	.fn = wled3_switch_freq_values_fn,
 	.size = 16,
 };
 
-static const struct pm8941_wled_var_cfg pm8941_wled_i_limit_cfg = {
+static const struct wled_var_cfg wled3_string_i_limit_cfg = {
 	.size = 26,
 };
 
-static u32 pm8941_wled_values(const struct pm8941_wled_var_cfg *cfg, u32 idx)
+static u32 wled3_values(const struct wled_var_cfg *cfg, u32 idx)
 {
 	if (idx >= cfg->size)
 		return UINT_MAX;
@@ -272,9 +274,9 @@ static u32 pm8941_wled_values(const struct pm8941_wled_var_cfg *cfg, u32 idx)
 	return idx;
 }
 
-static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
+static int wled_configure(struct wled *wled, struct device *dev)
 {
-	struct pm8941_wled_config *cfg = &wled->cfg;
+	struct wled_config *cfg = &wled->cfg;
 	u32 val;
 	int rc;
 	u32 c;
@@ -284,32 +286,32 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 	const struct {
 		const char *name;
 		u32 *val_ptr;
-		const struct pm8941_wled_var_cfg *cfg;
+		const struct wled_var_cfg *cfg;
 	} u32_opts[] = {
 		{
 			"qcom,current-boost-limit",
-			&cfg->i_boost_limit,
-			.cfg = &pm8941_wled_i_boost_limit_cfg,
+			&cfg->boost_i_limit,
+			.cfg = &wled3_boost_i_limit_cfg,
 		},
 		{
 			"qcom,current-limit",
-			&cfg->i_limit,
-			.cfg = &pm8941_wled_i_limit_cfg,
+			&cfg->string_i_limit,
+			.cfg = &wled3_string_i_limit_cfg,
 		},
 		{
 			"qcom,ovp",
 			&cfg->ovp,
-			.cfg = &pm8941_wled_ovp_cfg,
+			.cfg = &wled3_ovp_cfg,
 		},
 		{
 			"qcom,switching-freq",
 			&cfg->switch_freq,
-			.cfg = &pm8941_wled_switch_freq_cfg,
+			.cfg = &wled3_switch_freq_cfg,
 		},
 		{
 			"qcom,num-strings",
 			&cfg->num_strings,
-			.cfg = &pm8941_wled_num_strings_cfg,
+			.cfg = &wled3_num_strings_cfg,
 		},
 	};
 	const struct {
@@ -332,7 +334,7 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 	if (rc)
 		wled->name = dev->of_node->name;
 
-	*cfg = pm8941_wled_config_defaults;
+	*cfg = wled3_config_defaults;
 	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
 		rc = of_property_read_u32(dev->of_node, u32_opts[i].name, &val);
 		if (rc == -EINVAL) {
@@ -344,7 +346,7 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 
 		c = UINT_MAX;
 		for (j = 0; c != val; j++) {
-			c = pm8941_wled_values(u32_opts[i].cfg, j);
+			c = wled3_values(u32_opts[i].cfg, j);
 			if (c == UINT_MAX) {
 				dev_err(dev, "invalid value for '%s'\n",
 					u32_opts[i].name);
@@ -366,15 +368,15 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 	return 0;
 }
 
-static const struct backlight_ops pm8941_wled_ops = {
-	.update_status = pm8941_wled_update_status,
+static const struct backlight_ops wled_ops = {
+	.update_status = wled_update_status,
 };
 
-static int pm8941_wled_probe(struct platform_device *pdev)
+static int wled_probe(struct platform_device *pdev)
 {
 	struct backlight_properties props;
 	struct backlight_device *bl;
-	struct pm8941_wled *wled;
+	struct wled *wled;
 	struct regmap *regmap;
 	u32 val;
 	int rc;
@@ -391,42 +393,42 @@ static int pm8941_wled_probe(struct platform_device *pdev)
 
 	wled->regmap = regmap;
 
-	rc = pm8941_wled_configure(wled, &pdev->dev);
+	rc = wled_configure(wled, &pdev->dev);
 	if (rc)
 		return rc;
 
-	rc = pm8941_wled_setup(wled);
+	rc = wled_setup(wled);
 	if (rc)
 		return rc;
 
-	val = PM8941_WLED_DEFAULT_BRIGHTNESS;
+	val = WLED_DEFAULT_BRIGHTNESS;
 	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.brightness = val;
-	props.max_brightness = PM8941_WLED_REG_VAL_MAX;
+	props.max_brightness = WLED3_SINK_REG_BRIGHT_MAX;
 	bl = devm_backlight_device_register(&pdev->dev, wled->name,
 					    &pdev->dev, wled,
-					    &pm8941_wled_ops, &props);
+					    &wled_ops, &props);
 	return PTR_ERR_OR_ZERO(bl);
 };
 
-static const struct of_device_id pm8941_wled_match_table[] = {
+static const struct of_device_id wled_match_table[] = {
 	{ .compatible = "qcom,pm8941-wled" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, pm8941_wled_match_table);
+MODULE_DEVICE_TABLE(of, wled_match_table);
 
-static struct platform_driver pm8941_wled_driver = {
-	.probe = pm8941_wled_probe,
+static struct platform_driver wled_driver = {
+	.probe = wled_probe,
 	.driver	= {
-		.name = "pm8941-wled",
-		.of_match_table	= pm8941_wled_match_table,
+		.name = "qcom,wled",
+		.of_match_table	= wled_match_table,
 	},
 };
 
-module_platform_driver(pm8941_wled_driver);
+module_platform_driver(wled_driver);
 
-MODULE_DESCRIPTION("pm8941 wled driver");
+MODULE_DESCRIPTION("qcom wled driver");
 MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

