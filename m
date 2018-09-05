Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF89C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C009620836
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOnDJhCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C009620836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIEHCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:02:36 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39169 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEHCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:02:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id w14-v6so2540006plp.6;
        Tue, 04 Sep 2018 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YnsH0aBrI2QqUVui8CGJi/u6tnXpu40yRVQN6YeBM7E=;
        b=JOnDJhCXcSo8nHvqdt5aAXUFJovqhhKkOU5pOgzi3TzyIggd/4z/oceoNBeXeG+V0I
         aUAFRvhaBMoHtTyuaVZAhuZcaQgXD5rr7GmBCXpIe+GscWEw1tAcLORl3iZmvcSkAJBw
         LKDn4KW6Y25C/BQdWFEqnL29hILm0Qe3sMYwTZX1UXKGVur4XG+GV3wzTz1mOhiB6tR1
         fyI7DOFeLEJSICs+R7km/ntOPg2WAriM/A7U2VId0bRT4lLpt68u4j5y1fWIO8LcSAQm
         3a1AX29Xy5H9jnWPFJF4eQOsfQgoEsu/wj7oriXUhUmAi0Vyl9YJPqHNs+LBF1UiuTv1
         HTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YnsH0aBrI2QqUVui8CGJi/u6tnXpu40yRVQN6YeBM7E=;
        b=D0dmYsmq5g+Jf84Jmep5m8klCgxfDX/RMftMMu9PShrRYkCgZd8BUi1N5vHNZNYOLH
         DtWRiXJtosFKXXKvw39VU23EzXhoq25dgLon1om0Ctm/KsYEupSMwbU0tKI+lE1xPc6A
         o2lIE6vBc986NHHLgoMH2CxhkzBemY6hjW+QvnEhfWJws7+2UlCNcngheq90E+geDsXu
         3+KEjT+wPWDgUEfOBfnAtJRv6QIVMJQNaXKfquTY99qyP3LpRT/7mhhVbuBx5R3C+Kjp
         dd6LUapV+/37pmORqqyWE5Be72ouCwy6n5FCxvDQv0m44i20phOCpIoXFGGYnjcMZ/To
         zS+Q==
X-Gm-Message-State: APzg51ACBWP1bBJ4stWAERyBHdRoyJE93We/RmPX4Wu9vierIlwBPA/7
        fi7MiwbXPYE0Dem+h9Ej2AM=
X-Google-Smtp-Source: ANB0VdZk7hHdlzLkK/7YpH9V3kTyW1MOtAaDuhzUfcDU4KmgC9zdhwRAe79iwNPZwtFIRV+zlsp+MA==
X-Received: by 2002:a17:902:4a:: with SMTP id 68-v6mr29736862pla.276.1536114881707;
        Tue, 04 Sep 2018 19:34:41 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id 8-v6sm383531pgu.10.2018.09.04.19.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 19:34:41 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
X-Google-Original-From: Song Qiang <songqiang.1304521@gmail.com>
To:     jacek.anaszewski@gmail.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] leds: leds-gpio: Add a condition check for active low leds.
Date:   Wed,  5 Sep 2018 10:34:36 +0800
Message-Id: <20180905023436.11826-1-songqiang.1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some leds on our board are active low leds, which means these leds
are lighted when the corresponding gpio line is low, while the
original leds-gpio driver default all leds are active high leds.
This patch adds a devicetree node "light-state", whose value should
be "high" for active high leds and "low" for active low leds.
The default value is "high" for compatible for the original driver.

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 .../devicetree/bindings/leds/leds-gpio.txt    | 15 +++++++++++
 drivers/leds/leds-gpio.c                      | 25 +++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-gpio.txt b/Documentation/devicetree/bindings/leds/leds-gpio.txt
index a48dda268f81..0a8fad75c704 100644
--- a/Documentation/devicetree/bindings/leds/leds-gpio.txt
+++ b/Documentation/devicetree/bindings/leds/leds-gpio.txt
@@ -23,6 +23,9 @@ LED sub-node properties:
   remains up.
 - panic-indicator : (optional)
   see Documentation/devicetree/bindings/leds/common.txt
+- light-state: (optional) Values should be "high" or "low", which indicates
+	the state of the GPIO pin when the led is on.
+  see Documentation/devicetree/bindings/leds/common.txt
 
 Examples:
 
@@ -64,3 +67,15 @@ leds {
 		retain-state-suspended;
 	};
 };
+
+leds {
+	compatible = "gpio-leds";
+
+	led0 {
+		label = "led0";
+		gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+		linux,default-trigger = "heartbeat";
+		default-state = "off";
+		light-state = "low";
+	};
+}
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 764c31301f90..463ded0c71ac 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -26,9 +26,13 @@ struct gpio_led_data {
 	struct gpio_desc *gpiod;
 	u8 can_sleep;
 	u8 blinking;
+	u8 light_state;
 	gpio_blink_set_t platform_gpio_blink_set;
 };
 
+#define LEDS_GPIO_LIGHTSTATE_HIGH	0
+#define LEDS_GPIO_LIGHTSTATE_LOW	1
+
 static inline struct gpio_led_data *
 			cdev_to_gpio_led_data(struct led_classdev *led_cdev)
 {
@@ -42,9 +46,15 @@ static void gpio_led_set(struct led_classdev *led_cdev,
 	int level;
 
 	if (value == LED_OFF)
-		level = 0;
+		if (led_dat->light_state == LEDS_GPIO_LIGHTSTATE_HIGH)
+			level = 0;
+		else
+			level = 1;
 	else
-		level = 1;
+		if (led_dat->light_state == LEDS_GPIO_LIGHTSTATE_HIGH)
+			level = 1;
+		else
+			level = 0;
 
 	if (led_dat->blinking) {
 		led_dat->platform_gpio_blink_set(led_dat->gpiod, level,
@@ -205,6 +215,17 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 				led.default_state = LEDS_GPIO_DEFSTATE_OFF;
 		}
 
+		if (!fwnode_property_read_string(child, "light-state",
+						 &state)) {
+			if (!strcmp(state, "low"))
+				led_dat->light_state =
+					LEDS_GPIO_LIGHTSTATE_LOW;
+			else{
+				led_dat->light_state =
+					LEDS_GPIO_LIGHTSTATE_HIGH;
+			}
+		}
+
 		if (fwnode_property_present(child, "retain-state-suspended"))
 			led.retain_state_suspended = 1;
 		if (fwnode_property_present(child, "retain-state-shutdown"))
-- 
2.17.1

