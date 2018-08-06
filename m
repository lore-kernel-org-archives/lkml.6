Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8C8C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498CF21A11
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBziubs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498CF21A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732196AbeHFOPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:15:11 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:32934 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732150AbeHFOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:15:10 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so4781426plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=6OweEQF4blgca9x+9WOfZwW8lLDXX9E03wJIYWGhaOE=;
        b=WBziubs2sMpL+YgTHHcJ6Tz6AGzR27ySXt7MljjsC5vnyl1mAI108l3D+05PF0DhFB
         AJJUncpdhIoPCgq6DCBh1FwYyHHyxdVyjIkPOm8o16xHTKaIG4If/pBFgUxSBJxZ2ClN
         HGP6+veWG/9dk5yYV5FQ4OMW95uSyqbhblbrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=6OweEQF4blgca9x+9WOfZwW8lLDXX9E03wJIYWGhaOE=;
        b=b4nmg3Yd/LkMOr7ecferoJONgq8hniAemuiFYikLAEK1PZErHurKBtMuJBqCi3OeT1
         AyUWoL3ULvNk2BHvG/C2EceffS4aiw1W5tXnb7X5U+WCHQtYTk1uUSVtCwtF7XLbwfht
         duqGNRk/8wbUfb2rWKud3vNgHJhOzMQ70ctQeEYc1H4o0apYLYhNeNz/wKmUIudItw1B
         arGebA3KlnKAQgiMK7irPQfW6BEdnafsZ9v/XydMQ9ZttheTQ/cMfOkwODdh02T12GlV
         GddS+sYw2ya6eiD2KF38u4e12b1Bq/Sb9TPArBnYgOl1QU3TwwK/KUKw+Q74X3hXZnGv
         yzZw==
X-Gm-Message-State: AOUpUlEQ7GRLt2djbm1cMT6LQ0QvsJcX69vGf+iXhySkCXILefE5I4xV
        PMiOdtuE+zCl6AHRsGE+MOmJoA==
X-Google-Smtp-Source: AAOMgpfIGAYhsm8jRTow8WlKcfjzrGluxddWp5L32HJEhjIdtKk6eb+Doo7FJy05deuYY8mGAHyAWw==
X-Received: by 2002:a17:902:e3:: with SMTP id a90-v6mr13971189pla.227.1533557181541;
        Mon, 06 Aug 2018 05:06:21 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 21-v6sm16592354pgx.20.2018.08.06.05.06.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 05:06:21 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Mon,  6 Aug 2018 20:06:00 +0800
Message-Id: <9cafaf169e15698ec1c936e07b6a520307009f08.1533556992.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
In-Reply-To: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
References: <1dc5d394324b2bf1ffe229b8e42691fab6d749e0.1533556992.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
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

