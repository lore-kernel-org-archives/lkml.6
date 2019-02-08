Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A29C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561FB2147C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 07:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR1UGIUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBHH5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 02:57:43 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfBHH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 02:57:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1317913pld.6;
        Thu, 07 Feb 2019 23:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ClMomtiiEvaIEoVvm0QPIpv59zFu+qFORLn5IZp+DYA=;
        b=bR1UGIUkQ9DonkVQkwPk8It6g21Kr80dK6JS+GhCXfpEteUitCSXDXTM7X+g2Jl+pr
         fsauy4GmUVPUE4s2ZfiavQP/T7R6aABd5p1E6nCtQLl6i8Bj8FIUxsNogedO3Ec5MpMl
         bD+ls6J6hKavc63l1sOEBq3O7HeDlUAfRkiNkoJjhPmQVSuI4KYTU4YiNnXeEN6QOjxT
         GjTUWSsUNk2+Qb1aU8q70JMUpM1l5LptDx1ZBctxDNORjswE7whe04/byOdVrnvmUwyv
         L3YXG3N9Cp0IOMKQ64M8Y2LUZ3V3eoHYvRCj1NHsYX6vptADLEVXlcd7u22yOfTKgtl0
         q3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ClMomtiiEvaIEoVvm0QPIpv59zFu+qFORLn5IZp+DYA=;
        b=oXLGurjt9K4fyCypnFXCiDWjlz+LU2BnYAPgfvDAq3E3MhdiUIzk5e9ur41wwIgdX1
         8ru7shx1Z8zWUWhzMSx4NkmB/XYi76DyHfFEhxfvO7XscZhBK43eAjBwiwDyCPFqbC7H
         mUv2/JCnp51WvhFERsXtmroASQzVm9tM612EWEzxTMSdJKIGDKl5TZLky0w8Tt6zbm59
         s7dWq+uVBY2khw1JQA9vzCMJiDOezX1LEK7cGw2MhT6qWMOc7it89w1wFhIRdX74+ziK
         Fpm/+gS3qdXg5fBWE7G8A66JRvdQdDussPiSACCQyV0bvWD445dXoa7rDB9bgSb/wGd6
         7LBg==
X-Gm-Message-State: AHQUAubSUnmCUX2VHjHu3FR2GxXL6Z/YWpxRj+BYPpOAjb5dK549Zm45
        vnoQjoNoE3IjPjW1uIonEGtxavvd
X-Google-Smtp-Source: AHgI3IZ1Hb0lxk+UNr0/pWZ+I8vrRDwr6C31JjPq6Uho640gSTlCFIF9s10kBP+643/t3YsxVb3/0g==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr21345938plb.185.1549612661712;
        Thu, 07 Feb 2019 23:57:41 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id l19sm2596232pfi.71.2019.02.07.23.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 23:57:40 -0800 (PST)
Date:   Thu, 7 Feb 2019 23:57:39 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sven Van Asbroeck <TheSven73@googlemail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Input: cap11xx - switch to using set_brightness_blocking()
Message-ID: <20190208075739.GA95091@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating LED state requires access to regmap and therefore we may sleep,
so we could not do that directly form set_brightness() method.
Historically we used private work to adjust the brightness, but with the
introduction of set_brightness_blocking() we no longer need it.

As a bonus, not having our own work item means we do not have
use-after-free issue as we neglected to cancel outstanding work on
driver unbind.

Reported-by: Sven Van Asbroeck <thesven73@gmail.com>
Reviewed-by: Sven Van Asbroeck <TheSven73@googlemail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: no longer checking current brightness before trying to update since
    regmap should take care of caching and skipping updates when needed
    (Jacek).

 drivers/input/keyboard/cap11xx.c | 35 ++++++++++----------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 312916f99597..73686c2460ce 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -75,9 +75,7 @@
 struct cap11xx_led {
 	struct cap11xx_priv *priv;
 	struct led_classdev cdev;
-	struct work_struct work;
 	u32 reg;
-	enum led_brightness new_brightness;
 };
 #endif
 
@@ -233,30 +231,21 @@ static void cap11xx_input_close(struct input_dev *idev)
 }
 
 #ifdef CONFIG_LEDS_CLASS
-static void cap11xx_led_work(struct work_struct *work)
+static int cap11xx_led_set(struct led_classdev *cdev,
+			    enum led_brightness value)
 {
-	struct cap11xx_led *led = container_of(work, struct cap11xx_led, work);
+	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
 	struct cap11xx_priv *priv = led->priv;
-	int value = led->new_brightness;
 
 	/*
-	 * All LEDs share the same duty cycle as this is a HW limitation.
-	 * Brightness levels per LED are either 0 (OFF) and 1 (ON).
+	 * All LEDs share the same duty cycle as this is a HW
+	 * limitation. Brightness levels per LED are either
+	 * 0 (OFF) and 1 (ON).
 	 */
-	regmap_update_bits(priv->regmap, CAP11XX_REG_LED_OUTPUT_CONTROL,
-				BIT(led->reg), value ? BIT(led->reg) : 0);
-}
-
-static void cap11xx_led_set(struct led_classdev *cdev,
-			   enum led_brightness value)
-{
-	struct cap11xx_led *led = container_of(cdev, struct cap11xx_led, cdev);
-
-	if (led->new_brightness == value)
-		return;
-
-	led->new_brightness = value;
-	schedule_work(&led->work);
+	return regmap_update_bits(priv->regmap,
+				  CAP11XX_REG_LED_OUTPUT_CONTROL,
+				  BIT(led->reg),
+				  value ? BIT(led->reg) : 0);
 }
 
 static int cap11xx_init_leds(struct device *dev,
@@ -299,7 +288,7 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.default_trigger =
 			of_get_property(child, "linux,default-trigger", NULL);
 		led->cdev.flags = 0;
-		led->cdev.brightness_set = cap11xx_led_set;
+		led->cdev.brightness_set_blocking = cap11xx_led_set;
 		led->cdev.max_brightness = 1;
 		led->cdev.brightness = LED_OFF;
 
@@ -312,8 +301,6 @@ static int cap11xx_init_leds(struct device *dev,
 		led->reg = reg;
 		led->priv = priv;
 
-		INIT_WORK(&led->work, cap11xx_led_work);
-
 		error = devm_led_classdev_register(dev, &led->cdev);
 		if (error) {
 			of_node_put(child);
-- 
2.20.1.791.gb4d0f1c61a-goog


-- 
Dmitry
