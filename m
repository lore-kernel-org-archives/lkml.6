Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD0DC65BAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A936B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek9cZ/sw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A936B2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGK60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34624 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGK6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:24 -0500
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so3188651ljd.1;
        Fri, 07 Dec 2018 02:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUoyo020/7BIZvMbKzva5ANhccuHEj+8T05zfMoqMeE=;
        b=Ek9cZ/swgV831GL11fcs5pRo/VUbRKraW3SAj7n0I9R/Qf5ACzaOJ9wdEjwEVIwoId
         F2PxZ3nTDQ0K/KpdfIrFONItdhBcTawSXIAE1WFdynOQEKTCgqn+kZVtmn3ZhfXLlDlO
         Q29JPh4gWQFJ45vJ005dvU0219MnXqr32HXGEgOOC2ZaYppMLlmAMkHG+n3gFqlUwpN+
         fcYA9vLjr7DKR6OqnHS0OduROdDTmENVFQWAjZVXova1GUCS//Cx+oC1yxibI5xG1tR5
         zEEnqQ/ZKm85LHgTFOTuD8yDIKJ+QpuXY9hFbIP+bMKQFm/SCF9JbzSWO0kKGJfhUHKs
         evhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUoyo020/7BIZvMbKzva5ANhccuHEj+8T05zfMoqMeE=;
        b=Hooxo20vIsccYQCjFU0vLwmMHYf5Zz+CyqcKws5GlcJgOlS+VC5B6OpFdlBfTIPUmx
         RRwPklEti1OCMiW/s8b9RyePFrJSgadMEOmuONaNNvNlleChme7HPvyU7JraTmqTYI1g
         J32MZd9azT/wdr86lfQWc9G5S+X2uTKnDdSU/jLsG0EYTj8/elicZiuj62/8cbFD9aSu
         Q7ml+hFjcvs+CFNvxYyjmWtnk+ltZfrF6e5i2y+wKxsueJofwDzE0wf6J1SMybnNe/qT
         AEAKpd2WMxFGWuPBWRyRcMXzsWww8tZWF4QP08/aayvrr6CHoGX1/ZD5Lm7CrNUOkdJG
         s4EA==
X-Gm-Message-State: AA+aEWaQnH42ycBmBJFmmQdiNhB98AmdCedBBEw66FFKkq2LtV1lMkxh
        mHfjt25DL6JFex3c6BmeL7U=
X-Google-Smtp-Source: AFSGD/WuDaS2RUpquw9zhrr9UMzZKG1qtsmQktRetVcim3wBmLobXOZKtSzcGIvHozsBfRzcHwkecQ==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr1048293ljg.151.1544180301013;
        Fri, 07 Dec 2018 02:58:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:20 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 1/8] Input: tm2-touchkey: Add support for midas touchkey
Date:   Fri,  7 Dec 2018 11:58:04 +0100
Message-Id: <20181207105811.1831-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
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
 drivers/input/keyboard/tm2-touchkey.c | 48 ++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index abc266e40e17..37a5ced24009 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -22,12 +22,13 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/pm.h>
 #include <linux/regulator/consumer.h>
 
-#define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
-#define TM2_TOUCHKEY_KEYCODE_REG	0x03
-#define TM2_TOUCHKEY_BASE_REG		0x00
+#define TM2_TOUCHKEY_DEV_NAME "tm2-touchkey"
+#define MIDAS_TOUCHKEY_DEV_NAME "midas-touchkey"
+
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,12 +41,31 @@ enum {
 	TM2_TOUCHKEY_KEY_BACK,
 };
 
+struct touchkey_variant {
+	const char *name;
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
+	struct touchkey_variant *variant;
+};
+
+static struct touchkey_variant tm2_touchkey_variant = {
+	.name = "tm2-touchkey",
+	.keycode_reg = 0x03,
+	.base_reg = 0x00,
+};
+
+static struct touchkey_variant midas_touchkey_variant = {
+	.name = "midas-touchkey",
+	.keycode_reg = 0x00,
+	.base_reg = 0x00,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -66,7 +86,7 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	regulator_set_voltage(touchkey->vdd, volt, volt);
 	i2c_smbus_write_byte_data(touchkey->client,
-				  TM2_TOUCHKEY_BASE_REG, data);
+				  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -99,7 +119,7 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int key;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
-					TM2_TOUCHKEY_KEYCODE_REG);
+					touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -153,6 +173,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->client = client;
 	i2c_set_clientdata(client, touchkey);
 
+	touchkey->variant = (struct touchkey_variant *)
+		of_device_get_match_data(&client->dev);
+
 	touchkey->regulators[0].supply = "vcc";
 	touchkey->regulators[1].supply = "vdd";
 	error = devm_regulator_bulk_get(&client->dev,
@@ -187,7 +210,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	touchkey->input_dev->name = TM2_TOUCHKEY_DEV_NAME;
+	touchkey->input_dev->name = touchkey->variant->name;
 	touchkey->input_dev->id.bustype = BUS_I2C;
 
 	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
@@ -203,7 +226,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	error = devm_request_threaded_irq(&client->dev, client->irq,
 					  NULL, tm2_touchkey_irq_handler,
 					  IRQF_ONESHOT,
-					  TM2_TOUCHKEY_DEV_NAME, touchkey);
+					  touchkey->variant->name, touchkey);
 	if (error) {
 		dev_err(&client->dev,
 			"failed to request threaded irq: %d\n", error);
@@ -211,7 +234,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	}
 
 	/* led device */
-	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
+	touchkey->led_dev.name = touchkey->variant->name;
 	touchkey->led_dev.brightness = LED_FULL;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
@@ -257,12 +280,19 @@ static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
 
 static const struct i2c_device_id tm2_touchkey_id_table[] = {
 	{ TM2_TOUCHKEY_DEV_NAME, 0 },
+	{ MIDAS_TOUCHKEY_DEV_NAME, 0 },
 	{ },
 };
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

