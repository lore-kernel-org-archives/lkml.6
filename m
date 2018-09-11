Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41506C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E5220833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 02:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ROrCjTzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E5220833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeIKHpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 03:45:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeIKHpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 03:45:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so11433956pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CkCofpfwEs4QH1lVmTm7N7Or84Tadf7ZNVO4pqCP9MM=;
        b=ROrCjTzfdxlL68xXa7NWcUs2iFjbvpUw7tMwmGBplrzg7dNcMmXzptxCu1GRDRd++r
         Xi96ZRVywL1VRA4FMqPTuQMf23zoPbiJ6SV79nMRcdZ4HuIEex/OwdEprPWkfmV7re9x
         nc1ywxyI/K9ZPxT/9DW/vCI5+Kjt/NbnSmoHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CkCofpfwEs4QH1lVmTm7N7Or84Tadf7ZNVO4pqCP9MM=;
        b=iAyYrutgyoPRnzDUrX2d+PePk6EWDvtmIXKlrb3qI0gZUMsKoiqzBnGik90xlPT7je
         60+4s0GlTMHjbu+Zpiui0BcyDs+FdD8hfpxTbFCcWXZMggz3C4dGBoCDjJH3hI/2bs/X
         kEIEva9LJOwXlZFvu0FhHLcdpqk9Zh+W5YIB47As75hq5jL/g+WC3ybdflDfxzam/zT2
         bY4wrk6FarsTdSjozD2wyvxe49nWIAHLeOz9ilQmqyjnWdvzfLUH5IdiqTor950Cgl2J
         UqYlgnHjXpXp9EvO6Ku1ls3ouz0knu22J5xm62Ey3CoJGE7gIgR0pZCBryoXFUOZCL44
         C35A==
X-Gm-Message-State: APzg51D7DM56woW3j6XRRlKlHP2/iejqC3I0lG+mhJ1ddIpwR8onfjZ4
        HlUYoIeT6YXxRZo+tNgz+myPSA==
X-Google-Smtp-Source: ANB0Vda9W71RCFU0aLH/57z7p3DliVAw8rOkxVZAXaS3Ay/mNZ6YjBfDfnouxkgpK4obHKbwZNnmyg==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr25571025pgo.374.1536634117291;
        Mon, 10 Sep 2018 19:48:37 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o20-v6sm33740029pfj.35.2018.09.10.19.48.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Sep 2018 19:48:36 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     rteysseyre@gmail.com, bjorn.andersson@linaro.org,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 2/2] leds: sc27xx: Add pattern_set/clear interfaces for LED controller
Date:   Tue, 11 Sep 2018 10:47:57 +0800
Message-Id: <5a6a541d8ed7b372b675edd135b4611ca78891a6.1536631975.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
In-Reply-To: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the 'pattern_set'and 'pattern_clear'
interfaces to support SC27XX LED breathing mode.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Pavel Machek <pavel@ucw.c>
---
Changes from v11:
 - None.

Changes from v10:
 - Add duration alignment function suggested by Jacek.
 - Add acked tag from Pavel.

Changes from v9:
 - Optimize the ABI documentation file.
 - Update the brightness value in hardware pattern mode.

Changes from v8:
 - Optimize the ABI documentation file.

Changes from v7:
 - Add its own ABI documentation file.

Changes from v6:
 - None.

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
 .../ABI/testing/sysfs-class-led-driver-sc27xx      |   22 ++++
 drivers/leds/leds-sc27xx-bltc.c                    |  121 ++++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-sc27xx

diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
new file mode 100644
index 0000000..45b1e60
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-led-driver-sc27xx
@@ -0,0 +1,22 @@
+What:		/sys/class/leds/<led>/hw_pattern
+Date:		September 2018
+KernelVersion:	4.20
+Description:
+		Specify a hardware pattern for the SC27XX LED. For the SC27XX
+		LED controller, it only supports 4 stages to make a single
+		hardware pattern, which is used to configure the rise time,
+		high time, fall time and low time for the breathing mode.
+
+		For the breathing mode, the SC27XX LED only expects one brightness
+		for the high stage. To be compatible with the hardware pattern
+		format, we should set brightness as 0 for rise stage, fall
+		stage and low stage.
+
+		Min stage duration: 125 ms
+		Max stage duration: 31875 ms
+
+		Since the stage duration step is 125 ms, the duration should be
+		a multiplier of 125, like 125ms, 250ms, 375ms, 500ms ... 31875ms.
+
+		Thus the format of the hardware pattern values should be:
+		"0 rise_duration brightness high_duration 0 fall_duration 0 low_duration".
diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..fecf27f 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -32,8 +32,18 @@
 #define SC27XX_DUTY_MASK	GENMASK(15, 0)
 #define SC27XX_MOD_MASK		GENMASK(7, 0)
 
+#define SC27XX_CURVE_SHIFT	8
+#define SC27XX_CURVE_L_MASK	GENMASK(7, 0)
+#define SC27XX_CURVE_H_MASK	GENMASK(15, 8)
+
 #define SC27XX_LEDS_OFFSET	0x10
 #define SC27XX_LEDS_MAX		3
+#define SC27XX_LEDS_PATTERN_CNT	4
+/* Stage duration step, in milliseconds */
+#define SC27XX_LEDS_STEP	125
+/* Minimum and maximum duration, in milliseconds */
+#define SC27XX_DELTA_T_MIN	SC27XX_LEDS_STEP
+#define SC27XX_DELTA_T_MAX	(SC27XX_LEDS_STEP * 255)
 
 struct sc27xx_led {
 	char name[LED_MAX_NAME_SIZE];
@@ -122,6 +132,113 @@ static int sc27xx_led_set(struct led_classdev *ldev, enum led_brightness value)
 	return err;
 }
 
+static void sc27xx_led_clamp_align_delta_t(u32 *delta_t)
+{
+	u32 v, offset, t = *delta_t;
+
+	v = t + SC27XX_LEDS_STEP / 2;
+	v = clamp_t(u32, v, SC27XX_DELTA_T_MIN, SC27XX_DELTA_T_MAX);
+	offset = v - SC27XX_DELTA_T_MIN;
+	offset = SC27XX_LEDS_STEP * (offset / SC27XX_LEDS_STEP);
+
+	*delta_t = SC27XX_DELTA_T_MIN + offset;
+}
+
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
+	ldev->brightness = LED_OFF;
+
+	mutex_unlock(&leds->priv->lock);
+
+	return err;
+}
+
+static int sc27xx_led_pattern_set(struct led_classdev *ldev,
+				  struct led_pattern *pattern,
+				  u32 len, int repeat)
+{
+	struct sc27xx_led *leds = to_sc27xx_led(ldev);
+	u32 base = sc27xx_led_get_offset(leds);
+	u32 ctrl_base = leds->priv->base + SC27XX_LEDS_CTRL;
+	u8 ctrl_shift = SC27XX_CTRL_SHIFT * leds->line;
+	struct regmap *regmap = leds->priv->regmap;
+	int err;
+
+	/*
+	 * Must contain 4 tuples to configure the rise time, high time, fall
+	 * time and low time to enable the breathing mode.
+	 */
+	if (len != SC27XX_LEDS_PATTERN_CNT)
+		return -EINVAL;
+
+	mutex_lock(&leds->priv->lock);
+
+	sc27xx_led_clamp_align_delta_t(&pattern[0].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_L_MASK,
+				 pattern[0].delta_t / SC27XX_LEDS_STEP);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[1].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_L_MASK,
+				 pattern[1].delta_t / SC27XX_LEDS_STEP);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[2].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE0,
+				 SC27XX_CURVE_H_MASK,
+				 (pattern[2].delta_t / SC27XX_LEDS_STEP) <<
+				 SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+	sc27xx_led_clamp_align_delta_t(&pattern[3].delta_t);
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_CURVE1,
+				 SC27XX_CURVE_H_MASK,
+				 (pattern[3].delta_t / SC27XX_LEDS_STEP) <<
+				 SC27XX_CURVE_SHIFT);
+	if (err)
+		goto out;
+
+	err = regmap_update_bits(regmap, base + SC27XX_LEDS_DUTY,
+				 SC27XX_DUTY_MASK,
+				 (pattern[1].brightness << SC27XX_DUTY_SHIFT) |
+				 SC27XX_MOD_MASK);
+	if (err)
+		goto out;
+
+	/* Enable the LED breathing mode */
+	err = regmap_update_bits(regmap, ctrl_base,
+				 SC27XX_LED_RUN << ctrl_shift,
+				 SC27XX_LED_RUN << ctrl_shift);
+	if (!err)
+		ldev->brightness = pattern[1].brightness;
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
@@ -140,6 +257,9 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 		led->priv = priv;
 		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
+		led->ldev.pattern_set = sc27xx_led_pattern_set;
+		led->ldev.pattern_clear = sc27xx_led_pattern_clear;
+		led->ldev.default_trigger = "pattern";
 
 		err = devm_led_classdev_register(dev, &led->ldev);
 		if (err)
@@ -241,4 +361,5 @@ static int sc27xx_led_remove(struct platform_device *pdev)
 
 MODULE_DESCRIPTION("Spreadtrum SC27xx breathing light controller driver");
 MODULE_AUTHOR("Xiaotong Lu <xiaotong.lu@spreadtrum.com>");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
 MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

