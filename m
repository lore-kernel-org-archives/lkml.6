Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0A420879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6ZWnpza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeL1PqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45637 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732458AbeL1PqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id s5-v6so18975329ljd.12;
        Fri, 28 Dec 2018 07:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2xmaLsg9+x3NOOa9a3z9y0xnBcsw3Eg+1EpWLMSG6k=;
        b=j6ZWnpzaUE8IsVW8h95j1dgurX0cQUReZzv2NKRSV7cf4NRV5B8nZfLW6AatBXxXRT
         5C/0YgWiZh2V9Y3znq63LfxsWHRZPgCvJ3PPn6yxioEzkatf8sEeJ28vwceX1MjfFC15
         48aWlPJwD/oyOs92FaOCdsi31+Sa+JGuFhQOJgoTkHwZe01h+VnHYLTOb2Dtsj9Qsnea
         /YfQz1/E2NwZYgK45OSr8RN9dFkIB7t6HebWLPGxygMgZJw4dncCakRiigO1QmcHl5RK
         dz3KpMPFqpjY2CUwqipXRAilh25Z/zEO6sYPFMDY4zAB7aVrI49YJJnAEiiAZU6Wwvv9
         DbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2xmaLsg9+x3NOOa9a3z9y0xnBcsw3Eg+1EpWLMSG6k=;
        b=t6K6VGFL/GYGvtWjUL0f0cvRSafxB/N9lI8d1vzJFcjZBbwppT3+vHDXxUQol6VIGx
         E2knfgatCiAgNOtrVYPjbC1Z5dfmQ21uyKx09Em312Khs7SrJSX+tmd4wqho2ye6Q0Ey
         4LBODQAzj/IXsFe7jFjxZA3BBq8OKOu9LAGQZE1rebOXsXd06qtBdDi9aOioiXFC4HZQ
         5RPdDKbEpamwJf9CWqEtAp8OGCg3wctKNP4M1KNpoXktMTitegIWelN8xIuQ7Myeylky
         lZCGKWbBM4AhVPiNR7KB1pRHMj/Le9fFF8dDS0H3Vf7OIPAzRbjlmrAPWswOokGZynq/
         Fg+Q==
X-Gm-Message-State: AJcUukfcXPyrY1+efzkhjwUDleKKX1/p+Egy0GB0wFfiXQAtt0Q5geNY
        H8bPC/pQBzS91J639Out46s=
X-Google-Smtp-Source: ALg8bN7cJwfUs/UJIpQBrXMTgtXzFnvSjLpmGnxFBBB1U1BftQVtaNZIqAUouRwtXYnHx4WYWxo7KA==
X-Received: by 2002:a2e:8719:: with SMTP id m25-v6mr17777397lji.121.1546011976515;
        Fri, 28 Dec 2018 07:46:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:15 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 1/7] Input: tm2-touchkey: Add support for midas touchkey
Date:   Fri, 28 Dec 2018 16:46:03 +0100
Message-Id: <20181228154609.14846-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Shields <simon@lineageos.org>

The touchkey on midas boards is almost identical.
The only real difference is that it uses the same register for both
keycode and base.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Droped separate name changes
  - Added missing const in few places
  - Removed redundant cast
---
 drivers/input/keyboard/tm2-touchkey.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index abc266e40e17..5a1fe08bdd76 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -22,12 +22,12 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 
 #define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
-#define TM2_TOUCHKEY_KEYCODE_REG	0x03
-#define TM2_TOUCHKEY_BASE_REG		0x00
+
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,12 +40,28 @@ enum {
 	TM2_TOUCHKEY_KEY_BACK,
 };
 
+struct touchkey_variant {
+	u8 keycode_reg;
+	u8 base_reg;
+};
+
 struct tm2_touchkey_data {
 	struct i2c_client *client;
 	struct input_dev *input_dev;
 	struct led_classdev led_dev;
 	struct regulator *vdd;
 	struct regulator_bulk_data regulators[2];
+	const struct touchkey_variant *variant;
+};
+
+static const struct touchkey_variant tm2_touchkey_variant = {
+	.keycode_reg = 0x03,
+	.base_reg = 0x00,
+};
+
+static const struct touchkey_variant midas_touchkey_variant = {
+	.keycode_reg = 0x00,
+	.base_reg = 0x00,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -66,7 +82,7 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	regulator_set_voltage(touchkey->vdd, volt, volt);
 	i2c_smbus_write_byte_data(touchkey->client,
-				  TM2_TOUCHKEY_BASE_REG, data);
+				  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -99,7 +115,7 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int key;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
-					TM2_TOUCHKEY_KEYCODE_REG);
+					touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -153,6 +169,8 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->client = client;
 	i2c_set_clientdata(client, touchkey);
 
+	touchkey->variant = of_device_get_match_data(&client->dev);
+
 	touchkey->regulators[0].supply = "vcc";
 	touchkey->regulators[1].supply = "vdd";
 	error = devm_regulator_bulk_get(&client->dev,
@@ -262,7 +280,13 @@ static const struct i2c_device_id tm2_touchkey_id_table[] = {
 MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
 
 static const struct of_device_id tm2_touchkey_of_match[] = {
-	{ .compatible = "cypress,tm2-touchkey", },
+	{
+		.compatible = "cypress,tm2-touchkey",
+		.data = &tm2_touchkey_variant,
+	}, {
+		.compatible = "cypress,midas-touchkey",
+		.data = &midas_touchkey_variant,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tm2_touchkey_of_match);
-- 
2.17.1

