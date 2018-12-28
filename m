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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF8CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8620879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElN2qHHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbeL1Pqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40591 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbeL1Pq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:27 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so14778851lfe.7;
        Fri, 28 Dec 2018 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sX4MCT1F/XIaDetWT6pN9Vbnh7JjfzaWkdPb+65pu78=;
        b=ElN2qHHRyipb6UMC8EsDeWEVj1I/1ALf9QQNVQ8nzu1hUeSYCAmkUfFmXguno6SIC+
         p0/pUfYZC11YEMmR9LksSSf2iCF5jguvnMPiO0PdfN2zL2IsTHBJha6E+tAQJEf9T26G
         pg3cB5uT0ldjA1hh6FI5S10SZbxE0AH7NhCElN2gdn1+2FOzPaZ5gYXkBr/8rNvoGmre
         26AP+b9Im372KpC3RnTYt4v1SOSlpuA/Pf+j/la34695CJIAz36VDTyAuPoLMrY6HhGa
         i1mA4/986O7MclC2ZdWr8/XOzBamjwAI69FoglvPyzvYB0wf/O+dts2pnsJ8Y1eR3XX0
         7zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sX4MCT1F/XIaDetWT6pN9Vbnh7JjfzaWkdPb+65pu78=;
        b=aAgqHDN4p6xGRFyASqGIMKP4HqTgzrnygesZzNgfQGhGNzNxIKUnPRAHZ96nGNUBjB
         /E7k9JZ2RKUgmbjSOML8MDegRuLAmsUg5IiSltqR/Z+69K2A9PyRZH2Y9myOjpIcQRu+
         9g4TwaSmO23nDnP2ITpDDrMt+A+v+JAcTrmjGJR2d6vD80uViQG8G05EteBRV1yQa5dq
         aNme4Il63sldZe8LVQfWDUPGrMZe0bE26srD0uS2NR83vKX8gVNefaXilSw9IosRqZ5P
         hhAShLzhqJZQd2+VfYpyMeQ5Kine/WVEFWFz4Q7x7h6t/gECe8qAzQ/QEeVfcwL6VDv/
         Yuew==
X-Gm-Message-State: AA+aEWZ9VDhZOPW43mgiRRvqFeObYVYbAsSUTq/IOyOVgyZBVsKcq2Xd
        QNUu8FQTRAfbcpnlkh5o9HY=
X-Google-Smtp-Source: AFSGD/VQuEgjFfGsTfLlqZ6lxyi/Z0bXxE0D7LmZyHokMVWCviq/eZ1GUbGDYR0pLBpyX8U/1nKuNA==
X-Received: by 2002:a19:f204:: with SMTP id q4mr15279955lfh.133.1546011985040;
        Fri, 28 Dec 2018 07:46:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:24 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 6/7] Input: tm2-touchkey: Add support for aries touchkey variant
Date:   Fri, 28 Dec 2018 16:46:08 +0100
Message-Id: <20181228154609.14846-7-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

The touchkey variant found on aries board is slighty different,
it uses a fixed regulator and writes/read to the same place

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 53 +++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index c5adb928c6b4..05ad71797e60 100644
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

