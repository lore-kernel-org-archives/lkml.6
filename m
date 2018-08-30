Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D97C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC682082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkaJQUw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC682082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeH3Lln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:41:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35917 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbeH3Llm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:41:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so3523905pgo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eZGzryrV9wL2XxWiRsZsZ/FYHU3CIlauTRT5Wm/R1aI=;
        b=UkaJQUw8AFrqooGBC1k8RAkUzlJyFjkjvF6FI814kBLp8kYJW9uBxtWaOHFDfl/Ur+
         87MuILQi32OK1IvHNRYBvK48hXaLjBk2WMy6M9nLNamJpbUHbE6PR67w8+wWNBHlLdEs
         pudpoMqUMSrqTkDeIafkkOnCDggFrCz/TPyT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eZGzryrV9wL2XxWiRsZsZ/FYHU3CIlauTRT5Wm/R1aI=;
        b=scMyRI8NAJJJhnhr6NLkCsOAotkMIQYHD0GdJ6ETuXs0bmzFcWxUVWUHJHNjbbmOsK
         xg7C+q7DOou8cgZEpuLdh8WIWQNxLjl0//Z+TGs7tiICEbLb+Yq+r5n7j0QhsCpe6pCk
         cUPG2xztP49stEN+WuzA7v3YpL151sRkVAcTppJ94uxBmApac3eNH+yWAtEEsOWyZV4T
         sZEGY8PPLtc1IUobQB8mLz1yfhva/wsW/Hk5u9EgLrAgzrUaSDXQ6c/Glpj1vRLgdgV/
         CxltRGVgEkFCn6gFliDAUfd3q4RfGvBXw9HKUKYPnamHsO3FzZvDEBApdS5qjfasGiJ9
         f41g==
X-Gm-Message-State: APzg51CMb255UuoqBjb2qyUevjlNHQTlOQsOW556zjjK/Uhn8nRTn/EN
        335MKd9CiTXEu1TCImlz4vzuMQ==
X-Google-Smtp-Source: ANB0VdasIP1fr9StFfXi0Vau3Glv++n7g3cJW82KLDAGWh4yNJTR05NlAxunQzk5oitiXjNgxeZJDA==
X-Received: by 2002:a62:d94:: with SMTP id 20-v6mr9233759pfn.202.1535614853229;
        Thu, 30 Aug 2018 00:40:53 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q6-v6sm12096167pgq.19.2018.08.30.00.40.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 00:40:52 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Thu, 30 Aug 2018 15:40:40 +0800
Message-Id: <e24f6fa9d785f8402ab1f6ed8148d4e31f4cf7f6.1535614434.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
References: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
In-Reply-To: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
References: <f8f1439338464103cc9a4b4a93b590a9635c7fcb.1535614434.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v5:
 - None.

Changes from v4:
 - None.

Changes from v3:
 - None.

Changes from v2:
 - None.

Changes from v1:
 - Remove pattern_get interface.
---
 drivers/leds/leds-sc27xx-bltc.c |   94 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..297dd43 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -32,8 +32,13 @@
 #define SC27XX_DUTY_MASK	GENMASK(15, 0)
 #define SC27XX_MOD_MASK		GENMASK(7, 0)
 
+#define SC27XX_CURVE_SHIFT	8
+#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
+#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
+
 #define SC27XX_LEDS_OFFSET	0x10
 #define SC27XX_LEDS_MAX		3
+#define SC27XX_LEDS_PATTERN_CNT	4
 
 struct sc27xx_led {
 	char name[LED_MAX_NAME_SIZE];
@@ -122,6 +127,91 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
 	return err;
 }
 
+static int sc27xx_led_pattern_clear(struct led_classdev *ldev)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	struct regmap *regmap = leds->priv->regmap;
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	int err;
+
+	mutex_lock(&leds->priv->lock);
+
+	/* Reset the rise, high, fall and low time to zero. */
+	regmap_write(regmap, base + SC27XX_LEDS_CURVE0, 0);
+	regmap_write(regmap, base + SC27XX_LEDS_CURVE1, 0);
+
+	err = regmap_update_bits(regmap, ctrl_base,
+			(SC27XX_LED_RUN | SC27XX_LED_TYPE) << ctrl_shift, 0);
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_pattern_set(struct led_classdev *ldev,
+				  struct led_pattern *pattern,
+				  int len, u32 repeat)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	/*
+	 * Must contain 4 patterns to configure the rise time, high time, fall
+	 * time and low time to enable the breathing mode.
+	 */
+	if (len != SC27XX_LEDS_PATTERN_CNT)
+		return -EINVAL;
+
+	mutex_lock(&leds->priv->lock);
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_L_MASK, pattern[0].delta_t);
+	if (err)
+		goto out;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_L_MASK, pattern[1].delta_t);
+	if (err)
+		goto out;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_H_MASK,
+				 pattern[2].delta_t << SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_H_MASK,
+				 pattern[3].delta_t << SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
+				 SC27XX_DUTY_MASK,
+				 (pattern[0].brightness << SC27XX_DUTY_SHIFT) |
+				 SC27XX_MOD_MASK);
+	if (err)
+		goto out;
+
+	/* Enable the LED breathing mode */
+	err = regmap_update_bits(regmap, ctrl_base,
+				 SC27XX_LED_RUN << ctrl_shift,
+				 SC27XX_LED_RUN << ctrl_shift);
+
+out:
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
 static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 {
 	int i, err;
@@ -140,6 +230,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
+		led->ldev.default_trigger = "pattern";
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
@@ -241,4 +334,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
 MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

