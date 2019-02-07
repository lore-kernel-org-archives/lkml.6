Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A89C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB6E21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 12:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKclIgRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBGM4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 07:56:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46167 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfBGM4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 07:56:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so4723176pls.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 04:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=IMOq2Akho+4m31uQd4WeKnRvq63fThBL3U3/6BakR0U=;
        b=PKclIgRj5qFjo8HkiY9vUen1nTxxtJ/v8aVnsKPwXq9MJ6+0VZkc7lAT4jY7aokXG6
         htrP6kt4lR4PwjHD3XcGchoGyxNuRWZJxfJbeMsXcweTXpOrm6ySHdA3ZwDrIknVSz8e
         VNxfsLquNary7T6P9pXTHNbMoN/KBPQUVFXeyqOAYV7hRv/Jc9WOwdBSw+UrG93FgrzS
         jwNd9vkjZTiazewwhNhkCo+mMBhcEut8o9zjJJVNHt+EAmBwvnCgesYHC5kQtzeqm8AE
         D8GHidEm7FKVk/h1PvY/gn9p+c2lgbdlDJXAqrxIcCn6wcgXMjrGlImuR1xW7tpT/PYr
         CWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=IMOq2Akho+4m31uQd4WeKnRvq63fThBL3U3/6BakR0U=;
        b=sxIypuhS70q6qldQY1n+Kc6Pc8JNZp1kAmAFJWQbnxg3eaHw3D/Uqu9qnyjAASwZgW
         ajMC4BmoDCE53GWI46bhTasOvrrMibdGAHXN+zCDeeMTwBw7zcOk61TuT+nF4Z93yqEx
         c52vI4jthfR7Vc7jHfDrVOfXvQTqBqa4p9tIPFXzGK+cMMUO1qgbhIJUgpB2a4amBSgH
         1GoJPqC3BAEZ+Hog0xml606ShXoosUtZpZkLxG0THkZOhie0PktuXGwAMU0XDN+60hho
         1ABcuhQyhbADQ+Hta4jwfkuTDJqQgEBpqQ1kRxyrp5fupGIQY1L1XHl+lITmCHpxHnhT
         7fgg==
X-Gm-Message-State: AHQUAuZEsm/9Vh45MUoNkIXHBWse+Az0FhCy3QWgeGzieK++ZTAXp83+
        YYo25bRxA94GjWYBR5lJCF/YGMG4+Fs=
X-Google-Smtp-Source: AHgI3IaIAB65jfhUMW/Utimb6abqHXHVxuslUBAeF89XhHd9sCMczU9tNfLwNSQKUT877Pid1LmVyA==
X-Received: by 2002:a17:902:2ec1:: with SMTP id r59mr16575570plb.254.1549544178148;
        Thu, 07 Feb 2019 04:56:18 -0800 (PST)
Received: from localhost ([2402:3a80:c80:4138:75dd:3900:1d90:762f])
        by smtp.gmail.com with ESMTPSA id n186sm11863521pfn.137.2019.02.07.04.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 04:56:17 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: [PATCH v1 14/24] drivers: thermal: tsens: Add new operation to check if a sensor is enabled
Date:   Thu,  7 Feb 2019 16:19:32 +0530
Message-Id: <f8dd502d2981590526f9c2e44fbb4c0d36a3aa0c.1549525708.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1549525708.git.amit.kucheria@linaro.org>
References: <cover.1549525708.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

is_sensor_enabled() checks if the sensors are enabled on this platform.
It is possible that the SoC might choose not to enable all the sensors
that the IP block is capable of supporting.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/qcom/tsens-common.c | 14 ++++++++++++++
 drivers/thermal/qcom/tsens-v0_1.c   |  1 +
 drivers/thermal/qcom/tsens-v2.c     |  1 +
 drivers/thermal/qcom/tsens.c        |  5 +++++
 drivers/thermal/qcom/tsens.h        |  1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/thermal/qcom/tsens-common.c b/drivers/thermal/qcom/tsens-common.c
index 39cd5733fd44..020409d8daf0 100644
--- a/drivers/thermal/qcom/tsens-common.c
+++ b/drivers/thermal/qcom/tsens-common.c
@@ -69,6 +69,20 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	}
 }
 
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
+{
+	u32 val;
+	int ret;
+
+	if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
+		return -EINVAL;
+	ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
+	if (ret)
+		return ret;
+
+	return val & (1 << hw_id);
+}
+
 static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
 {
 	int degc, num, den;
diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index 02907751c201..ad1052e05e45 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -332,6 +332,7 @@ const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFFSET */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF, 0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF, 1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF, 3, 13),
 
 	/* ----- TM ------ */
 	/* UPPER_LOWER_INTERRUPT_CTRL */
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 962e47c54dca..e0aac59d72ec 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -99,6 +99,7 @@ const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* CTRL_OFF */
 	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
 	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
+	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3, 18),
 
 	/* ----- TM ------ */
 	/* INTERRUPT ENABLE */
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 057b33353ba3..fc44cac31fa5 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -82,6 +82,11 @@ static int tsens_register(struct tsens_priv *priv)
 	struct thermal_zone_device *tzd;
 
 	for (i = 0;  i < priv->num_sensors; i++) {
+		if (!is_sensor_enabled(priv, priv->sensor[i].hw_id)) {
+			dev_err(priv->dev, "sensor %d: disabled\n",
+				priv->sensor[i].hw_id);
+			continue;
+		}
 		priv->sensor[i].priv = priv;
 		priv->sensor[i].id = i;
 		tzd = devm_thermal_zone_of_sensor_register(priv->dev, i,
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 20d89f8a6c3e..da4cfb23dfe9 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -254,6 +254,7 @@ char *qfprom_read(struct device *dev, const char *cname);
 void compute_intercept_slope(struct tsens_priv *priv, u32 *pt1, u32 *pt2, u32 mode);
 int init_common(struct tsens_priv *priv);
 int get_temp_common(struct tsens_priv *priv, int i, int *temp);
+bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id);
 
 /* TSENS target */
 extern const struct tsens_plat_data data_8960;
-- 
2.17.1

