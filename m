Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19707C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17ED2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/uaXTk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfAGSyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35291 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfAGSyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:10 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so1095258lfc.2;
        Mon, 07 Jan 2019 10:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2xmaLsg9+x3NOOa9a3z9y0xnBcsw3Eg+1EpWLMSG6k=;
        b=U/uaXTk48haB58XjQDNWEWvQDj2qNa+gwEXqtLDendilnltwq2czrtHqYIViYfIYJz
         58iFmatzCSe6aCoLBbj9EXpl8n4w3EWgBvHMoxGNgmbKJiiQ3n13n0piZJ29pqNrvrVG
         m8KuW55O+Jf8N2YgxyHkfDinDWS1BtMz3y0nhLdhuQgc7qSjFm6wQSwY7c8APY0ApNYD
         oh4gagTsj+0O/5VvrMvaO7b5B2l56R10Kma2YkNtHfPKo5/YzyadE/EPrVpNMUzQV+ul
         D5hT6W4Fkac45aIO5XPdjU/7GszDca2z3b95frvq/EuPEY5CBqjJVpCaA2CkhNS342Jg
         1sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2xmaLsg9+x3NOOa9a3z9y0xnBcsw3Eg+1EpWLMSG6k=;
        b=qPtJxKQevTqlUv1JXqqo12eEA+aLWtgfI7+ETIxqDDPxzLBfZaZhHiYwQoOrFxPgMK
         U8H0S8NtCQ67eqU0bDNhFadVVXFeP26FUeag2rLhaIVC1TciA+CZHTuhPp8Vffx8+uR7
         t2Vg0lpNxVpHiLggx8iuQgosRSX184LJytvRcmF12t3q13w/X+AwMXhiUcoWI731w2A7
         +UsUxgNg/b4Q60xNeT/d6SwnFCKb5sCuL5KSxkhHpQiXCmH/l9y9cdIn3ocn8Qcqzqvv
         eoajkHqOeuy5B49buWWgDvMgQAxikql46XjMssh+cL466/GR2OydAICH+Fql+Pj6Xil1
         tsQQ==
X-Gm-Message-State: AA+aEWZ1ZeaVgQWskojteSve+k3f8RLCLa7+S41qgcsq7Ct5aCUtUv5d
        lPQwFB16ENnD6avWCO4uUPQ=
X-Google-Smtp-Source: AFSGD/Vij7p1CEcLNAVrinK7J08BklMtIEMMx8FQP/f017DZC4I69rS+O9lSwHVbU739Q58zzuN8rg==
X-Received: by 2002:a19:f89:: with SMTP id 9mr30185815lfp.10.1546887247456;
        Mon, 07 Jan 2019 10:54:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:06 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 1/7] Input: tm2-touchkey: Add support for midas touchkey
Date:   Mon,  7 Jan 2019 19:53:40 +0100
Message-Id: <20190107185346.30184-2-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
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

