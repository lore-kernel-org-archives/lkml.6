Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1B3C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B492083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSi5teGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B492083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeLGK6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:37 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42072 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLGK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so3155846lja.9;
        Fri, 07 Dec 2018 02:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tMGx8zhco17hmo8awxHrpDIsJFqu4IFXryZSTaXOr8=;
        b=NSi5teGKjXgiNTQxbOGvbOMqSUhf2oEOFDwuQElHjKx850YBGeHLvX5nDRA3VFsq0z
         MSlx946Jex0LBpJahQzHbdkG7BAwTuq+UsZq1torjreTjZo7e/B8NZxLxgUcZdvYUYtS
         chraWA6JAHo5F96+ylMGTQdgP/MJjMQs2QgG3I3dEsnQ7WopT5ZcZn0oxM3ULxV2+to/
         /TTBz8gLg6xHvw+tnxA5+0vXKoAunTTBQEwpTtyVbo6tRhM4zvQ7MRR7BYHfKGdo2Orp
         Brm7ENfs68GnI6Bb7x8V5AZ9KqnUPdMmibCfdG2gXAhh9GirAc9qHAXHaFjaxOwgOel+
         QakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tMGx8zhco17hmo8awxHrpDIsJFqu4IFXryZSTaXOr8=;
        b=ukI3BRF5cFzn5ucg+CWizIWD8xqADyPAMScjXEgP5dhU85vlqskY/QdVz9M1GMFRIP
         ykq6f3WtW5YTRLUU3FUxY8Hp5KJc4FCPldMF1fzAf5J38E9C2RMbOKAKVvitXcF4ZFkA
         +3bCerZG1B7Ca9IDChn7z6UTu/muV+8lLUOSLg7mWoLOxh5eWds4dFerNLYHuaIANuVl
         IocMAPCor0uxx8kD8ICq7vx3SxDjbaMZhq128EU85wbyH2Y90TRWOHe+7GC+0vZcld85
         ODCOqe0ikGFrhvHVgOSWcRzQnF+HZrlJB03nufaQFn8XmO1u/tHhcSM0QVr2TEDs4Bfz
         +RwQ==
X-Gm-Message-State: AA+aEWZ2MOl0zL+bIMuLJlZ+yIYgiC1/9hjNQgZgB4uLPKk0Yuuu9d8c
        xR1p62jaTMaYib70esHXEqA=
X-Google-Smtp-Source: AFSGD/WXh4+2rS9TVJQ1dicR0XkRrL74WyHW/BOwYvYo7xK+3Gv3p77xMt4Q2dfaEd2yruAzNvz9BA==
X-Received: by 2002:a2e:449c:: with SMTP id b28-v6mr1032863ljf.47.1544180309456;
        Fri, 07 Dec 2018 02:58:29 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:28 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 7/8] Input: tm2-touchkey: Add support for aries touchkey variant
Date:   Fri,  7 Dec 2018 11:58:10 +0100
Message-Id: <20181207105811.1831-8-pawel.mikolaj.chmiel@gmail.com>
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

From: Jonathan Bakker <xc-racer2@live.ca>

The touchkey variant found on aries board is slighty different,
it uses a fixed regulator and writes/read to the same place

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 56 +++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index ebc275ab8ad1..6f1235183c21 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -28,7 +28,10 @@
 
 #define TM2_TOUCHKEY_DEV_NAME "tm2-touchkey"
 #define MIDAS_TOUCHKEY_DEV_NAME "midas-touchkey"
+#define ARIES_TOUCHKEY_DEV_NAME "aries-touchkey"
 
+#define ARIES_TOUCHKEY_CMD_LED_ON	0x1
+#define ARIES_TOUCHKEY_CMD_LED_OFF	0x2
 #define TM2_TOUCHKEY_CMD_LED_ON		0x10
 #define TM2_TOUCHKEY_CMD_LED_OFF	0x20
 #define TM2_TOUCHKEY_BIT_PRESS_EV	BIT(3)
@@ -40,6 +43,10 @@ struct touchkey_variant {
 	const char *name;
 	u8 keycode_reg;
 	u8 base_reg;
+	u8 cmd_led_on;
+	u8 cmd_led_off;
+	bool no_reg;
+	bool fixed_regulator;
 };
 
 struct tm2_touchkey_data {
@@ -57,12 +64,24 @@ static struct touchkey_variant tm2_touchkey_variant = {
 	.name = TM2_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x03,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
 };
 
 static struct touchkey_variant midas_touchkey_variant = {
 	.name = MIDAS_TOUCHKEY_DEV_NAME,
 	.keycode_reg = 0x00,
 	.base_reg = 0x00,
+	.cmd_led_on = TM2_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = TM2_TOUCHKEY_CMD_LED_OFF,
+};
+
+static struct touchkey_variant aries_touchkey_variant = {
+	.name = ARIES_TOUCHKEY_DEV_NAME,
+	.no_reg = true,
+	.fixed_regulator = true,
+	.cmd_led_on = ARIES_TOUCHKEY_CMD_LED_ON,
+	.cmd_led_off = ARIES_TOUCHKEY_CMD_LED_OFF,
 };
 
 static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
@@ -75,15 +94,20 @@ static void tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 
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
@@ -116,8 +140,11 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
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
@@ -143,6 +170,14 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
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
 
@@ -251,6 +286,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (touchkey->variant->fixed_regulator)
+		tm2_touchkey_led_brightness_set(&touchkey->led_dev, LED_ON);
+
 	return 0;
 }
 
@@ -286,6 +324,7 @@ static SIMPLE_DEV_PM_OPS(tm2_touchkey_pm_ops,
 static const struct i2c_device_id tm2_touchkey_id_table[] = {
 	{ TM2_TOUCHKEY_DEV_NAME, 0 },
 	{ MIDAS_TOUCHKEY_DEV_NAME, 0 },
+	{ ARIES_TOUCHKEY_DEV_NAME, 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, tm2_touchkey_id_table);
@@ -297,6 +336,9 @@ static const struct of_device_id tm2_touchkey_of_match[] = {
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

