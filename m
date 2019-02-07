Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9702AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3261121872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKiMYPzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBGKuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:50:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35361 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfBGKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:50:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id z18so10246989wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=3oKLYEtp34qQzSU/4qu4XNpq94BvIIyZ8kLyNwL2S7o=;
        b=xKiMYPzwqQutDnmk1DHPMvHrWqMFgHQtWScQHRE9WfQDLCHyAd2ngLfTTLr8fwiXXD
         PDpwjh7p/gdcYQzN1z9+rFYHHh5Mz5roKG60V0VJr02hlJsPvAw2mF9XulcLjXQ0Rwsm
         u2YaKDKM6JR4mCF0Q46+o9EWc48GUvxTuaoKOwh90dya2RjXvpsUtBkrJkLOsuYCxOxA
         TJwe6KyYN9HKVIYPZYB6TYXrUpFEVOuQWT9NXxq3/Ka31c0tiYpVXEMaRdVqfspjSJX+
         5xtIMc6+TidcCNjiVnnBFuuEyA7bXap6CXbAtFOQVDkxGxW5ZvjThe4F0Y5aRLPF/Sw/
         S9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=3oKLYEtp34qQzSU/4qu4XNpq94BvIIyZ8kLyNwL2S7o=;
        b=AARNw/ZyhbFf3MtS3ae41LRsZeuuYCHuFcMEwK3/DwlWbB4vvVWGvtESD7Ql3iTHMb
         DOrkYgow5w7RmKXFkppFG5WGhLpS8Uy9PYnZKeG7ehY/bm8oWiw5o0GoXWG7dqFwL3hZ
         8HiUTd1szhfp0pc5+8FuclWcRFM3h7yUyhwn2gZUmcv6lPCD28sO33Aq/XkZ0dPHVFwk
         vHVYARtj5EIe5dDsdQyExsJH1hQkr0Jcc9Mp0lp0OwtpoRtfHnGKqLRJJXo69hFW/2Js
         ayASmM79hFInbNurZ4a7uk1O5pRl9n89NwyL4M8qek5J7Cs8X4wi06WeLqEn5KtG5CSX
         OZIQ==
X-Gm-Message-State: AHQUAuY7tGMCNrc4iNOonv7tCT7k+GbmQ1CB2Z8fx70WXeaJkXJ7ZKyO
        hUZd3KWLTI9nDUV4WmnY/6tmKu0AX2Q=
X-Google-Smtp-Source: AHgI3IYq5PoPjNW9O0AwAC5467W0OW6SCzv5l+toPDjh5ASIz3SxIbvqpyb03YYEyHGB43PcDOXy9A==
X-Received: by 2002:adf:fbc7:: with SMTP id d7mr11282347wrs.275.1549536620675;
        Thu, 07 Feb 2019 02:50:20 -0800 (PST)
Received: from localhost ([49.248.196.115])
        by smtp.gmail.com with ESMTPSA id o5sm14698324wrw.46.2019.02.07.02.50.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:50:20 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 04/24] drivers: thermal: tsens: Rename variable tmdev
Date:   Thu,  7 Feb 2019 16:19:22 +0530
Message-Id: <af1c01fbb234836c448ec59f951faa954f9957b2.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmdev seems to imply that this is a device pointer when in fact it is
just private platform data for each tsens device. Rename it to priv
improve code readability.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-8916.c   | 16 +++---
 drivers/thermal/qcom/tsens-8960.c   | 82 ++++++++++++++---------------
 drivers/thermal/qcom/tsens-8974.c   | 16 +++---
 drivers/thermal/qcom/tsens-common.c | 52 +++++++++---------
 drivers/thermal/qcom/tsens-v2.c     | 12 ++---
 drivers/thermal/qcom/tsens.c        | 80 ++++++++++++++--------------
 drivers/thermal/qcom/tsens.h        |  4 +-
 7 files changed, 131 insertions(+), 131 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-8916.c b/drivers/thermal/qcom/tsens-8916.c
index 7b8f83c9a033..d4ad4082c800 100644
--- a/drivers/thermal/qcom/tsens-8916.c
+++ b/drivers/thermal/qcom/tsens-8916.c
@@ -39,23 +39,23 @@
 #define CAL_SEL_MASK	0xe0000000
 #define CAL_SEL_SHIFT	29
 
-static int calibrate_8916(struct tsens_priv *tmdev)
+static int calibrate_8916(struct tsens_priv *priv)
 {
 	int base0 = 0, base1 = 0, i;
 	u32 p1[5], p2[5];
 	int mode = 0;
 	u32 *qfprom_cdata, *qfprom_csel;
 
-	qfprom_cdata = (u32 *)qfprom_read(tmdev->dev, "calib");
+	qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(qfprom_cdata))
 		return PTR_ERR(qfprom_cdata);
 
-	qfprom_csel = (u32 *)qfprom_read(tmdev->dev, "calib_sel");
+	qfprom_csel = (u32 *)qfprom_read(priv->dev, "calib_sel");
 	if (IS_ERR(qfprom_csel))
 		return PTR_ERR(qfprom_csel);
 
 	mode = (qfprom_csel[0] & CAL_SEL_MASK) >> CAL_SEL_SHIFT;
-	dev_dbg(tmdev->dev, "calibration mode is %d\n", mode);
+	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
 
 	switch (mode) {
 	case TWO_PT_CALIB:
@@ -65,7 +65,7 @@ static int calibrate_8916(struct tsens_priv *tmdev)
 		p2[2] = (qfprom_cdata[1] & S2_P2_MASK) >> S2_P2_SHIFT;
 		p2[3] = (qfprom_cdata[1] & S3_P2_MASK) >> S3_P2_SHIFT;
 		p2[4] = (qfprom_cdata[1] & S4_P2_MASK) >> S4_P2_SHIFT;
-		for (i = 0; i < tmdev->num_sensors; i++)
+		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = ((base1 + p2[i]) << 3);
 		/* Fall through */
 	case ONE_PT_CALIB2:
@@ -75,18 +75,18 @@ static int calibrate_8916(struct tsens_priv *tmdev)
 		p1[2] = (qfprom_cdata[0] & S2_P1_MASK) >> S2_P1_SHIFT;
 		p1[3] = (qfprom_cdata[1] & S3_P1_MASK) >> S3_P1_SHIFT;
 		p1[4] = (qfprom_cdata[1] & S4_P1_MASK) >> S4_P1_SHIFT;
-		for (i = 0; i < tmdev->num_sensors; i++)
+		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] = (((base0) + p1[i]) << 3);
 		break;
 	default:
-		for (i = 0; i < tmdev->num_sensors; i++) {
+		for (i = 0; i < priv->num_sensors; i++) {
 			p1[i] = 500;
 			p2[i] = 780;
 		}
 		break;
 	}
 
-	compute_intercept_slope(tmdev, p1, p2, mode);
+	compute_intercept_slope(priv, p1, p2, mode);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens-8960.c b/drivers/thermal/qcom/tsens-8960.c
index 7e340eea48da..8d9b721dadb6 100644
--- a/drivers/thermal/qcom/tsens-8960.c
+++ b/drivers/thermal/qcom/tsens-8960.c
@@ -56,21 +56,21 @@
 #define TRDY_MASK		BIT(7)
 #define TIMEOUT_US		100
 
-static int suspend_8960(struct tsens_priv *tmdev)
+static int suspend_8960(struct tsens_priv *priv)
 {
 	int ret;
 	unsigned int mask;
-	struct regmap *map = tmdev->tm_map;
+	struct regmap *map = priv->tm_map;
 
-	ret = regmap_read(map, THRESHOLD_ADDR, &tmdev->ctx.threshold);
+	ret = regmap_read(map, THRESHOLD_ADDR, &priv->ctx.threshold);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(map, CNTL_ADDR, &tmdev->ctx.control);
+	ret = regmap_read(map, CNTL_ADDR, &priv->ctx.control);
 	if (ret)
 		return ret;
 
-	if (tmdev->num_sensors > 1)
+	if (priv->num_sensors > 1)
 		mask = SLP_CLK_ENA | EN;
 	else
 		mask = SLP_CLK_ENA_8660 | EN;
@@ -82,10 +82,10 @@ static int suspend_8960(struct tsens_priv *tmdev)
 	return 0;
 }
 
-static int resume_8960(struct tsens_priv *tmdev)
+static int resume_8960(struct tsens_priv *priv)
 {
 	int ret;
-	struct regmap *map = tmdev->tm_map;
+	struct regmap *map = priv->tm_map;
 
 	ret = regmap_update_bits(map, CNTL_ADDR, SW_RST, SW_RST);
 	if (ret)
@@ -95,80 +95,80 @@ static int resume_8960(struct tsens_priv *tmdev)
 	 * Separate CONFIG restore is not needed only for 8660 as
 	 * config is part of CTRL Addr and its restored as such
 	 */
-	if (tmdev->num_sensors > 1) {
+	if (priv->num_sensors > 1) {
 		ret = regmap_update_bits(map, CONFIG_ADDR, CONFIG_MASK, CONFIG);
 		if (ret)
 			return ret;
 	}
 
-	ret = regmap_write(map, THRESHOLD_ADDR, tmdev->ctx.threshold);
+	ret = regmap_write(map, THRESHOLD_ADDR, priv->ctx.threshold);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(map, CNTL_ADDR, tmdev->ctx.control);
+	ret = regmap_write(map, CNTL_ADDR, priv->ctx.control);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int enable_8960(struct tsens_priv *tmdev, int id)
+static int enable_8960(struct tsens_priv *priv, int id)
 {
 	int ret;
 	u32 reg, mask;
 
-	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg);
+	ret = regmap_read(priv->tm_map, CNTL_ADDR, &reg);
 	if (ret)
 		return ret;
 
 	mask = BIT(id + SENSOR0_SHIFT);
-	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg | SW_RST);
+	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg | SW_RST);
 	if (ret)
 		return ret;
 
-	if (tmdev->num_sensors > 1)
+	if (priv->num_sensors > 1)
 		reg |= mask | SLP_CLK_ENA | EN;
 	else
 		reg |= mask | SLP_CLK_ENA_8660 | EN;
 
-	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg);
+	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static void disable_8960(struct tsens_priv *tmdev)
+static void disable_8960(struct tsens_priv *priv)
 {
 	int ret;
 	u32 reg_cntl;
 	u32 mask;
 
-	mask = GENMASK(tmdev->num_sensors - 1, 0);
+	mask = GENMASK(priv->num_sensors - 1, 0);
 	mask <<= SENSOR0_SHIFT;
 	mask |= EN;
 
-	ret = regmap_read(tmdev->tm_map, CNTL_ADDR, &reg_cntl);
+	ret = regmap_read(priv->tm_map, CNTL_ADDR, &reg_cntl);
 	if (ret)
 		return;
 
 	reg_cntl &= ~mask;
 
-	if (tmdev->num_sensors > 1)
+	if (priv->num_sensors > 1)
 		reg_cntl &= ~SLP_CLK_ENA;
 	else
 		reg_cntl &= ~SLP_CLK_ENA_8660;
 
-	regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
+	regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 }
 
-static int init_8960(struct tsens_priv *tmdev)
+static int init_8960(struct tsens_priv *priv)
 {
 	int ret, i;
 	u32 reg_cntl;
 
-	tmdev->tm_map = dev_get_regmap(tmdev->dev, NULL);
-	if (!tmdev->tm_map)
+	priv->tm_map = dev_get_regmap(priv->dev, NULL);
+	if (!priv->tm_map)
 		return -ENODEV;
 
 	/*
@@ -177,21 +177,21 @@ static int init_8960(struct tsens_priv *tmdev)
 	 * but the control registers stay in the same place, i.e
 	 * directly after the first 5 status registers.
 	 */
-	for (i = 0; i < tmdev->num_sensors; i++) {
+	for (i = 0; i < priv->num_sensors; i++) {
 		if (i >= 5)
-			tmdev->sensor[i].status = S0_STATUS_ADDR + 40;
-		tmdev->sensor[i].status += i * 4;
+			priv->sensor[i].status = S0_STATUS_ADDR + 40;
+		priv->sensor[i].status += i * 4;
 	}
 
 	reg_cntl = SW_RST;
-	ret = regmap_update_bits(tmdev->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
+	ret = regmap_update_bits(priv->tm_map, CNTL_ADDR, SW_RST, reg_cntl);
 	if (ret)
 		return ret;
 
-	if (tmdev->num_sensors > 1) {
+	if (priv->num_sensors > 1) {
 		reg_cntl |= SLP_CLK_ENA | (MEASURE_PERIOD << 18);
 		reg_cntl &= ~SW_RST;
-		ret = regmap_update_bits(tmdev->tm_map, CONFIG_ADDR,
+		ret = regmap_update_bits(priv->tm_map, CONFIG_ADDR,
 					 CONFIG_MASK, CONFIG);
 	} else {
 		reg_cntl |= SLP_CLK_ENA_8660 | (MEASURE_PERIOD << 16);
@@ -199,30 +199,30 @@ static int init_8960(struct tsens_priv *tmdev)
 		reg_cntl |= CONFIG_8660 << CONFIG_SHIFT_8660;
 	}
 
-	reg_cntl |= GENMASK(tmdev->num_sensors - 1, 0) << SENSOR0_SHIFT;
-	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
+	reg_cntl |= GENMASK(priv->num_sensors - 1, 0) << SENSOR0_SHIFT;
+	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 	if (ret)
 		return ret;
 
 	reg_cntl |= EN;
-	ret = regmap_write(tmdev->tm_map, CNTL_ADDR, reg_cntl);
+	ret = regmap_write(priv->tm_map, CNTL_ADDR, reg_cntl);
 	if (ret)
 		return ret;
 
 	return 0;
 }
 
-static int calibrate_8960(struct tsens_priv *tmdev)
+static int calibrate_8960(struct tsens_priv *priv)
 {
 	int i;
 	char *data;
 
-	ssize_t num_read = tmdev->num_sensors;
-	struct tsens_sensor *s = tmdev->sensor;
+	ssize_t num_read = priv->num_sensors;
+	struct tsens_sensor *s = priv->sensor;
 
-	data = qfprom_read(tmdev->dev, "calib");
+	data = qfprom_read(priv->dev, "calib");
 	if (IS_ERR(data))
-		data = qfprom_read(tmdev->dev, "calib_backup");
+		data = qfprom_read(priv->dev, "calib_backup");
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
@@ -243,21 +243,21 @@ static inline int code_to_mdegC(u32 adc_code, const struct tsens_sensor *s)
 	return adc_code * slope + offset;
 }
 
-static int get_temp_8960(struct tsens_priv *tmdev, int id, int *temp)
+static int get_temp_8960(struct tsens_priv *priv, int id, int *temp)
 {
 	int ret;
 	u32 code, trdy;
-	const struct tsens_sensor *s = &tmdev->sensor[id];
+	const struct tsens_sensor *s = &priv->sensor[id];
 	unsigned long timeout;
 
 	timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
 	do {
-		ret = regmap_read(tmdev->tm_map, INT_STATUS_ADDR, &trdy);
+		ret = regmap_read(priv->tm_map, INT_STATUS_ADDR, &trdy);
 		if (ret)
 			return ret;
 		if (!(trdy & TRDY_MASK))
 			continue;
-		ret = regmap_read(tmdev->tm_map, s->status, &code);
+		ret = regmap_read(priv->tm_map, s->status, &code);
 		if (ret)
 			return ret;
 		*temp = code_to_mdegC(code, s);
diff --git a/drivers/thermal/qcom/tsens-8974.c b/drivers/thermal/qcom/tsens-8974.c
index f983f98f2176..303157fd00be 100644
--- a/drivers/thermal/qcom/tsens-8974.c
+++ b/drivers/thermal/qcom/tsens-8974.c
@@ -91,7 +91,7 @@
 
 #define BIT_APPEND		0x3
 
-static int calibrate_8974(struct tsens_priv *tmdev)
+static int calibrate_8974(struct tsens_priv *priv)
 {
 	int base1 = 0, base2 = 0, i;
 	u32 p1[11], p2[11];
@@ -99,11 +99,11 @@ static int calibrate_8974(struct tsens_priv *tmdev)
 	u32 *calib, *bkp;
 	u32 calib_redun_sel;
 
-	calib = (u32 *)qfprom_read(tmdev->dev, "calib");
+	calib = (u32 *)qfprom_read(priv->dev, "calib");
 	if (IS_ERR(calib))
 		return PTR_ERR(calib);
 
-	bkp = (u32 *)qfprom_read(tmdev->dev, "calib_backup");
+	bkp = (u32 *)qfprom_read(priv->dev, "calib_backup");
 	if (IS_ERR(bkp))
 		return PTR_ERR(bkp);
 
@@ -184,25 +184,25 @@ static int calibrate_8974(struct tsens_priv *tmdev)
 
 	switch (mode) {
 	case ONE_PT_CALIB:
-		for (i = 0; i < tmdev->num_sensors; i++)
+		for (i = 0; i < priv->num_sensors; i++)
 			p1[i] += (base1 << 2) | BIT_APPEND;
 		break;
 	case TWO_PT_CALIB:
-		for (i = 0; i < tmdev->num_sensors; i++) {
+		for (i = 0; i < priv->num_sensors; i++) {
 			p2[i] += base2;
 			p2[i] <<= 2;
 			p2[i] |= BIT_APPEND;
 		}
 		/* Fall through */
 	case ONE_PT_CALIB2:
-		for (i = 0; i < tmdev->num_sensors; i++) {
+		for (i = 0; i < priv->num_sensors; i++) {
 			p1[i] += base1;
 			p1[i] <<= 2;
 			p1[i] |= BIT_APPEND;
 		}
 		break;
 	default:
-		for (i = 0; i < tmdev->num_sensors; i++)
+		for (i = 0; i < priv->num_sensors; i++)
 			p2[i] = 780;
 		p1[0] = 502;
 		p1[1] = 509;
@@ -218,7 +218,7 @@ static int calibrate_8974(struct tsens_priv *tmdev)
 		break;
 	}
 
-	compute_intercept_slope(tmdev, p1, p2, mode);
+	compute_intercept_slope(priv, p1, p2, mode);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 128ee3621b41..af87216ee407 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -46,18 +46,18 @@ char *qfprom_read(struct device *dev, const char *cname)
  * and offset values are derived from tz->tzp->slope and tz->tzp->offset
  * resp.
  */
-void compute_intercept_slope(struct tsens_priv *tmdev, u32 *p1,
+void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			     u32 *p2, u32 mode)
 {
 	int i;
 	int num, den;
 
-	for (i = 0; i < tmdev->num_sensors; i++) {
-		dev_dbg(tmdev->dev,
+	for (i = 0; i < priv->num_sensors; i++) {
+		dev_dbg(priv->dev,
 			"sensor%d - data_point1:%#x data_point2:%#x\n",
 			i, p1[i], p2[i]);
 
-		tmdev->sensor[i].slope = SLOPE_DEFAULT;
+		priv->sensor[i].slope = SLOPE_DEFAULT;
 		if (mode == TWO_PT_CALIB) {
 			/*
 			 * slope (m) = adc_code2 - adc_code1 (y2 - y1)/
@@ -66,13 +66,13 @@ void compute_intercept_slope(struct tsens_priv *tmdev, u32 *p1,
 			num = p2[i] - p1[i];
 			num *= SLOPE_FACTOR;
 			den = CAL_DEGC_PT2 - CAL_DEGC_PT1;
-			tmdev->sensor[i].slope = num / den;
+			priv->sensor[i].slope = num / den;
 		}
 
-		tmdev->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
+		priv->sensor[i].offset = (p1[i] * SLOPE_FACTOR) -
 				(CAL_DEGC_PT1 *
-				tmdev->sensor[i].slope);
-		dev_dbg(tmdev->dev, "offset:%d\n", tmdev->sensor[i].offset);
+				priv->sensor[i].slope);
+		dev_dbg(priv->dev, "offset:%d\n", priv->sensor[i].offset);
 	}
 }
 
@@ -95,15 +95,15 @@ static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 	return degc;
 }
 
-int get_temp_common(struct tsens_priv *tmdev, int id, int *temp)
+int get_temp_common(struct tsens_priv *priv, int id, int *temp)
 {
-	struct tsens_sensor *s = &tmdev->sensor[id];
+	struct tsens_sensor *s = &priv->sensor[id];
 	u32 code;
 	unsigned int status_reg;
 	int last_temp = 0, ret;
 
-	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
-	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * SN_ADDR_OFFSET;
+	ret = regmap_read(priv->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & SN_ST_TEMP_MASK;
@@ -127,34 +127,34 @@ static const struct regmap_config tsens_srot_config = {
 	.reg_stride	= 4,
 };
 
-int __init init_common(struct tsens_priv *tmdev)
+int __init init_common(struct tsens_priv *priv)
 {
 	void __iomem *tm_base, *srot_base;
 	struct resource *res;
 	u32 code;
 	int ret;
-	struct platform_device *op = of_find_device_by_node(tmdev->dev->of_node);
-	u16 ctrl_offset = tmdev->reg_offsets[SROT_CTRL_OFFSET];
+	struct platform_device *op = of_find_device_by_node(priv->dev->of_node);
+	u16 ctrl_offset = priv->reg_offsets[SROT_CTRL_OFFSET];
 
 	if (!op)
 		return -EINVAL;
 
 	if (op->num_resources > 1) {
 		/* DT with separate SROT and TM address space */
-		tmdev->tm_offset = 0;
+		priv->tm_offset = 0;
 		res = platform_get_resource(op, IORESOURCE_MEM, 1);
 		srot_base = devm_ioremap_resource(&op->dev, res);
 		if (IS_ERR(srot_base))
 			return PTR_ERR(srot_base);
 
-		tmdev->srot_map = devm_regmap_init_mmio(tmdev->dev, srot_base,
+		priv->srot_map = devm_regmap_init_mmio(priv->dev, srot_base,
 							&tsens_srot_config);
-		if (IS_ERR(tmdev->srot_map))
-			return PTR_ERR(tmdev->srot_map);
+		if (IS_ERR(priv->srot_map))
+			return PTR_ERR(priv->srot_map);
 
 	} else {
 		/* old DTs where SROT and TM were in a contiguous 2K block */
-		tmdev->tm_offset = 0x1000;
+		priv->tm_offset = 0x1000;
 	}
 
 	res = platform_get_resource(op, IORESOURCE_MEM, 0);
@@ -162,16 +162,16 @@ int __init init_common(struct tsens_priv *tmdev)
 	if (IS_ERR(tm_base))
 		return PTR_ERR(tm_base);
 
-	tmdev->tm_map = devm_regmap_init_mmio(tmdev->dev, tm_base, &tsens_config);
-	if (IS_ERR(tmdev->tm_map))
-		return PTR_ERR(tmdev->tm_map);
+	priv->tm_map = devm_regmap_init_mmio(priv->dev, tm_base, &tsens_config);
+	if (IS_ERR(priv->tm_map))
+		return PTR_ERR(priv->tm_map);
 
-	if (tmdev->srot_map) {
-		ret = regmap_read(tmdev->srot_map, ctrl_offset, &code);
+	if (priv->srot_map) {
+		ret = regmap_read(priv->srot_map, ctrl_offset, &code);
 		if (ret)
 			return ret;
 		if (!(code & TSENS_EN)) {
-			dev_err(tmdev->dev, "tsens device is not enabled\n");
+			dev_err(priv->dev, "tsens device is not enabled\n");
 			return -ENODEV;
 		}
 	}
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index d812fd3f4567..8b700772d903 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -12,16 +12,16 @@
 #define LAST_TEMP_MASK		0xfff
 #define STATUS_VALID_BIT	BIT(21)
 
-static int get_temp_tsens_v2(struct tsens_priv *tmdev, int id, int *temp)
+static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 {
-	struct tsens_sensor *s = &tmdev->sensor[id];
+	struct tsens_sensor *s = &priv->sensor[id];
 	u32 code;
 	unsigned int status_reg;
 	u32 last_temp = 0, last_temp2 = 0, last_temp3 = 0;
 	int ret;
 
-	status_reg = tmdev->tm_offset + STATUS_OFFSET + s->hw_id * 4;
-	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	status_reg = priv->tm_offset + STATUS_OFFSET + s->hw_id * 4;
+	ret = regmap_read(priv->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	last_temp = code & LAST_TEMP_MASK;
@@ -29,7 +29,7 @@ static int get_temp_tsens_v2(struct tsens_priv *tmdev, int id, int *temp)
 		goto done;
 
 	/* Try a second time */
-	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	ret = regmap_read(priv->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
@@ -40,7 +40,7 @@ static int get_temp_tsens_v2(struct tsens_priv *tmdev, int id, int *temp)
 	}
 
 	/* Try a third/last time */
-	ret = regmap_read(tmdev->tm_map, status_reg, &code);
+	ret = regmap_read(priv->tm_map, status_reg, &code);
 	if (ret)
 		return ret;
 	if (code & STATUS_VALID_BIT) {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 074fbb4d70f2..4582d2b30e94 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -15,38 +15,38 @@
 static int tsens_get_temp(void *data, int *temp)
 {
 	const struct tsens_sensor *s = data;
-	struct tsens_priv *tmdev = s->tmdev;
+	struct tsens_priv *priv = s->priv;
 
-	return tmdev->ops->get_temp(tmdev, s->id, temp);
+	return priv->ops->get_temp(priv, s->id, temp);
 }
 
 static int tsens_get_trend(void *p, int trip, enum thermal_trend *trend)
 {
 	const struct tsens_sensor *s = p;
-	struct tsens_priv *tmdev = s->tmdev;
+	struct tsens_priv *priv = s->priv;
 
-	if (tmdev->ops->get_trend)
-		return  tmdev->ops->get_trend(tmdev, s->id, trend);
+	if (priv->ops->get_trend)
+		return  priv->ops->get_trend(priv, s->id, trend);
 
 	return -ENOTSUPP;
 }
 
 static int  __maybe_unused tsens_suspend(struct device *dev)
 {
-	struct tsens_priv *tmdev = dev_get_drvdata(dev);
+	struct tsens_priv *priv = dev_get_drvdata(dev);
 
-	if (tmdev->ops && tmdev->ops->suspend)
-		return tmdev->ops->suspend(tmdev);
+	if (priv->ops && priv->ops->suspend)
+		return priv->ops->suspend(priv);
 
 	return 0;
 }
 
 static int __maybe_unused tsens_resume(struct device *dev)
 {
-	struct tsens_priv *tmdev = dev_get_drvdata(dev);
+	struct tsens_priv *priv = dev_get_drvdata(dev);
 
-	if (tmdev->ops && tmdev->ops->resume)
-		return tmdev->ops->resume(tmdev);
+	if (priv->ops && priv->ops->resume)
+		return priv->ops->resume(priv);
 
 	return 0;
 }
@@ -76,22 +76,22 @@ static const struct thermal_zone_of_device_ops tsens_of_ops = {
 	.get_trend = tsens_get_trend,
 };
 
-static int tsens_register(struct tsens_priv *tmdev)
+static int tsens_register(struct tsens_priv *priv)
 {
 	int i;
 	struct thermal_zone_device *tzd;
 
-	for (i = 0;  i < tmdev->num_sensors; i++) {
-		tmdev->sensor[i].tmdev = tmdev;
-		tmdev->sensor[i].id = i;
-		tzd = devm_thermal_zone_of_sensor_register(tmdev->dev, i,
-							   &tmdev->sensor[i],
+	for (i = 0;  i < priv->num_sensors; i++) {
+		priv->sensor[i].priv = priv;
+		priv->sensor[i].id = i;
+		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
+							   &priv->sensor[i],
 							   &tsens_of_ops);
 		if (IS_ERR(tzd))
 			continue;
-		tmdev->sensor[i].tzd = tzd;
-		if (tmdev->ops->enable)
-			tmdev->ops->enable(tmdev, i);
+		priv->sensor[i].tzd = tzd;
+		if (priv->ops->enable)
+			priv->ops->enable(priv, i);
 	}
 	return 0;
 }
@@ -101,7 +101,7 @@ static int tsens_probe(struct platform_device *pdev)
 	int ret, i;
 	struct device *dev;
 	struct device_node *np;
-	struct tsens_priv *tmdev;
+	struct tsens_priv *priv;
 	const struct tsens_plat_data *data;
 	const struct of_device_id *id;
 	u32 num_sensors;
@@ -129,55 +129,55 @@ static int tsens_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	tmdev = devm_kzalloc(dev,
-			     struct_size(tmdev, sensor, num_sensors),
+	priv = devm_kzalloc(dev,
+			     struct_size(priv, sensor, num_sensors),
 			     GFP_KERNEL);
-	if (!tmdev)
+	if (!priv)
 		return -ENOMEM;
 
-	tmdev->dev = dev;
-	tmdev->num_sensors = num_sensors;
-	tmdev->ops = data->ops;
-	for (i = 0;  i < tmdev->num_sensors; i++) {
+	priv->dev = dev;
+	priv->num_sensors = num_sensors;
+	priv->ops = data->ops;
+	for (i = 0;  i < priv->num_sensors; i++) {
 		if (data->hw_ids)
-			tmdev->sensor[i].hw_id = data->hw_ids[i];
+			priv->sensor[i].hw_id = data->hw_ids[i];
 		else
-			tmdev->sensor[i].hw_id = i;
+			priv->sensor[i].hw_id = i;
 	}
 	for (i = 0; i < REG_ARRAY_SIZE; i++) {
-		tmdev->reg_offsets[i] = data->reg_offsets[i];
+		priv->reg_offsets[i] = data->reg_offsets[i];
 	}
 
-	if (!tmdev->ops || !tmdev->ops->init || !tmdev->ops->get_temp)
+	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
 		return -EINVAL;
 
-	ret = tmdev->ops->init(tmdev);
+	ret = priv->ops->init(priv);
 	if (ret < 0) {
 		dev_err(dev, "tsens init failed\n");
 		return ret;
 	}
 
-	if (tmdev->ops->calibrate) {
-		ret = tmdev->ops->calibrate(tmdev);
+	if (priv->ops->calibrate) {
+		ret = priv->ops->calibrate(priv);
 		if (ret < 0) {
 			dev_err(dev, "tsens calibration failed\n");
 			return ret;
 		}
 	}
 
-	ret = tsens_register(tmdev);
+	ret = tsens_register(priv);
 
-	platform_set_drvdata(pdev, tmdev);
+	platform_set_drvdata(pdev, priv);
 
 	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
 {
-	struct tsens_priv *tmdev = platform_get_drvdata(pdev);
+	struct tsens_priv *priv = platform_get_drvdata(pdev);
 
-	if (tmdev->ops->disable)
-		tmdev->ops->disable(tmdev);
+	if (priv->ops->disable)
+		priv->ops->disable(priv);
 
 	return 0;
 }
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 936bdc7b1bc2..61ca2905ee7a 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -16,7 +16,7 @@ struct tsens_priv;
 
 /**
  * struct tsens_sensor - data for each sensor connected to the tsens device
- * @tmdev: tsens device instance that this sensor is connected to
+ * @priv: tsens device instance that this sensor is connected to
  * @tzd: pointer to the thermal zone that this sensor is in
  * @offset: offset of temperature adjustment curve
  * @id: Sensor ID
@@ -25,7 +25,7 @@ struct tsens_priv;
  * @status: 8960-specific variable to track 8960 and 8660 status register offset
  */
 struct tsens_sensor {
-	struct tsens_priv		*tmdev;
+	struct tsens_priv		*priv;
 	struct thermal_zone_device	*tzd;
 	int				offset;
 	int				id;
-- 
2.17.1

