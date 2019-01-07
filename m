Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415372147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOuNbKzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbfAGSyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37970 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfAGSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so1080479lfk.5;
        Mon, 07 Jan 2019 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L4bb9ndCPhJNyXeb/1qH8VH7BbvWrL2P/9iDLwRWQao=;
        b=DOuNbKzoEJ4J2WByL1LbHQ6BAwdFPdYnrvmg5arzhf6wbMqN7br8UaCx83hWLBGUhc
         Lf6WLg1iQ9tTRXYU843vm5hg7UTyi9TaMM1jBVEtQxcv93ANTpnz9v6VD2Ro2RHDoq+4
         9a/iHl3jew/l/rYfy5kDGR7om65Grxijf7e1dZlNATvaRW18Ayte6iV8MLkGNyXPGvVC
         yd2qs8IyWvtNwDdlraFJFATutR0USTYkK4vFrkhVCMAy/8DTfOZz6ISKsvobJltYSkVE
         Yv8WPIwj8HsuqN82X94pd/CPpe/AcJEhYTGc1pVeZ/VKtp/WGa/t/jJlS716FQppRcAN
         GvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L4bb9ndCPhJNyXeb/1qH8VH7BbvWrL2P/9iDLwRWQao=;
        b=nI3kjRzfWJYGeTAmcJemwDms1UFvqrts++7rimUfhvHN13sV55F5aFaZb0sZzdFUM/
         f9J+RLNYDma6HxOBDT5odX2QEpdGopUnVZEAqLrxm3UATQMp57rptZENnA6c9c8YZIZD
         jXlk+Udqe5aBnGZcNyLJVM3XqtHP6vJMLD9VA9XNm4m39cdVmDnDd6/z8BqM6iwDcnVK
         4qDnqVY8slm3wD8Z4GXf4TxtBl6/aq+gmf7/KhZFpW+tUghc5LcKZBvWcnM8is/q5+vq
         azg1SSf0oR4C0eurwPFxSvenLALLX7DNoe84X39X7R/H1XAjCtW+CWccMffDnlEBCPd/
         LQqQ==
X-Gm-Message-State: AA+aEWaFrSl9Bp7eCwxCZlhhlJPBxlJ3n5hpl9BQv6rHPU5rA/IyPRtL
        9OZ4KNjH7ZlrKZ4MdzLt/rc=
X-Google-Smtp-Source: AFSGD/VBySk+MsMdzrrfiAepo+XTanHwE4mhojMVa1Rny72WvW6WppS6u0zLKImuj0Boz/vwfisRkA==
X-Received: by 2002:a19:d90c:: with SMTP id q12mr29896473lfg.24.1546887254272;
        Mon, 07 Jan 2019 10:54:14 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:13 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 6/7] Input: tm2-touchkey: Add support for aries touchkey variant
Date:   Mon,  7 Jan 2019 19:53:45 +0100
Message-Id: <20190107185346.30184-7-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

The touchkey variant found on aries board is slighty different,
it uses a fixed regulator and writes/read to the same place

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 53 +++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index b55faf597d8a..7dbef96559d2 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -28,6 +28,8 @@
 
 #define TM2_TOUCHKEY_DEV_NAME		"tm2-touchkey"
 
+#define ARIES_TOUCHKEY_CMD_LED_ON	0x1
+#define ARIES_TOUCHKEY_CMD_LED_OFF	0x2
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -38,6 +40,10 @@
 struct touchkey_variant {
 	u8 keycode_reg;
 	u8 base_reg;
+	u8 cmd_led_on;
+	u8 cmd_led_off;
+	bool no_reg;
+	bool fixed_regulator;
 };
 
 struct tm2_touchkey_data {
@@ -54,11 +60,22 @@ struct tm2_touchkey_data {
 static const struct touchkey_variant tm2_touchkey_variant = {
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
 };
 
 static const struct touchkey_variant midas_touchkey_variant = {
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
+};
+
+static struct touchkey_variant aries_touchkey_variant = {
+	.no_reg = true,
+	.fixed_regulator = true,
+	.cmd_led_on = ARIES_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -71,15 +88,20 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
 	if (brightness == LED_OFF) {
 		volt = TM2_TOUCHKEY_LED_VOLTAGE_MIN;
-		data = TM2_TOUCHKEY_CMD_LED_OFF;
+		data = touchkey->variant->cmd_led_off;
 	} else {
 		volt = TM2_TOUCHKEY_LED_VOLTAGE_MAX;
-		data = TM2_TOUCHKEY_CMD_LED_ON;
+		data = touchkey->variant->cmd_led_on;
 	}
 
-	regulator_set_voltage(touchkey->vdd, volt, volt);
-	i2c_smbus_write_byte_data(touchkey->client,
-				  touchkey->variant->base_reg, data);
+	if (!touchkey->variant->fixed_regulator)
+		regulator_set_voltage(touchkey->vdd, volt, volt);
+
+	if (touchkey->variant->no_reg)
+		i2c_smbus_write_byte(touchkey->client, data);
+	else
+		i2c_smbus_write_byte_data(touchkey->client,
+					  touchkey->variant->base_reg, data);
 }
 
 static int tm2_touchkey_power_enable(struct tm2_touchkey_data *touchkey)
@@ -112,8 +134,11 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	int index;
 	int i;
 
-	data = i2c_smbus_read_byte_data(touchkey->client,
-					touchkey->variant->keycode_reg);
+	if (touchkey->variant->no_reg)
+		data = i2c_smbus_read_byte(touchkey->client);
+	else
+		data = i2c_smbus_read_byte_data(touchkey->client,
+						touchkey->variant->keycode_reg);
 	if (data < 0) {
 		dev_err(&touchkey->client->dev,
 			"failed to read i2c data: %d\n", data);
@@ -139,6 +164,14 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	input_sync(touchkey->input_dev);
 
 out:
+	if (touchkey->variant->fixed_regulator &&
+				data & TM2_TOUCHKEY_BIT_PRESS_EV) {
+		/* touch turns backlight on, so make sure we're in sync */
+		if (touchkey->led_dev.brightness == LED_OFF)
+			tm2_touchkey_led_brightness_set(&touchkey->led_dev,
+							LED_OFF);
+	}
+
 	return IRQ_HANDLED;
 }
 
@@ -246,6 +279,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (touchkey->variant->fixed_regulator)
+		tm2_touchkey_led_brightness_set(&touchkey->led_dev, LED_ON);
+
 	return 0;
 }
 
@@ -291,6 +327,9 @@ static const struct of_device_id tm2_touchkey_of_match[] = {
 	}, {
 		.compatible = "cypress,midas-touchkey",
 		.data = &midas_touchkey_variant,
+	}, {
+		.compatible = "cypress,aries-touchkey",
+		.data = &aries_touchkey_variant,
 	},
 	{ },
 };
-- 
2.17.1

