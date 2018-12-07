Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E023C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC78C208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uis4/8d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC78C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbeLGK6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:58:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32845 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeLGK6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:58:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so3215272ljd.0;
        Fri, 07 Dec 2018 02:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=knG6SyfDCGJn7gk77p8M/RfgY6AhBS/jOJor+ETKwuw=;
        b=uis4/8d3PSYf/KxJPBFPuq9zQk3n9I1r43bfgu34jnZp3cClc8v7T0hFu/ZmO74kCG
         +z2odhEXVfiUA//0yijq0pqdjlX82wEGazAVERPdykzpT6cjeo2C3ZAu5e1TgC8w90K/
         yl+1zI7nmr04kclTC1N4IHQLhTnucirn6ogWZgWYaH9zfoCom0vFodXEGrSP4mSt/e/8
         wN56qiGqB/Q0k8eTsbZMM5gGl6qYbQoxg9g2YPs2c9ZEwrVP7k6xEldGNrKnc+O3+vOZ
         tF7bgt4vm4XOC9zWhkZqXtuSAeTekWtYSp9D10x6Az0eDFe9dpmWN/2OMGbKnFp6UPIw
         Xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=knG6SyfDCGJn7gk77p8M/RfgY6AhBS/jOJor+ETKwuw=;
        b=JD3uRaMdnuk84MaRZ0R85kJ9lwXPieCmDdiZsBwmA4zI2UdRdQMQQIEqoGHQbJx90j
         uK5SBJAxJGpaaWWBHNOiiEwpixQQiyNwiXhSOjMrL0u0x/IxunhGPFGPTuDJNviLzTa7
         BPfP1s1WqBpsePLLhnyw1H0Wc4vfjTYVoqEnZJ3n85XAt5x0kbo5JVgskeeQcMPmCyWk
         XNwwKGHA7EpK7b3Ycs00+mZX2Gtc9hQK0F5pecd9KQDq/idFyQUp/ADexl8tAUjnxNyC
         fBNO0bCqpkYUzKhv33JbF21JBqfsOl/KUyqgsTZOngnQl1PTvv8j+QhDidjEknZc5OLb
         N2/g==
X-Gm-Message-State: AA+aEWZ1Lb3e/aiXiL0zZCUqVXm8HnBsKqh5vPT2h/x/+oEtf32TNWNU
        NtZTqjckPb6I+aA/S1cXOFk=
X-Google-Smtp-Source: AFSGD/Wk8R/X1JZz5dmYqkGgc5MPuZ4AupG3QqXjIRee+wlCAt+xQqCeYlFddi77aNdVpzyIvwRuYg==
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr1048761ljh.135.1544180306549;
        Fri, 07 Dec 2018 02:58:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id a20-v6sm523362ljf.28.2018.12.07.02.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 02:58:25 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH 5/8] Input: tm2-touchkey: Allow specifying custom keycodes
Date:   Fri,  7 Dec 2018 11:58:08 +0100
Message-Id: <20181207105811.1831-6-pawel.mikolaj.chmiel@gmail.com>
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

Not all devices use the same keycodes in the same order

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 49 +++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index a73894b8dede..ebc275ab8ad1 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -36,11 +36,6 @@
 #define TM2_TOUCHKEY_LED_VOLTAGE_MIN	2500000
 #define TM2_TOUCHKEY_LED_VOLTAGE_MAX	3300000
 
-enum {
-	TM2_TOUCHKEY_KEY_MENU = 0x1,
-	TM2_TOUCHKEY_KEY_BACK,
-};
-
 struct touchkey_variant {
 	const char *name;
 	u8 keycode_reg;
@@ -54,6 +49,8 @@ struct tm2_touchkey_data {
 	struct regulator *vdd;
 	struct regulator_bulk_data regulators[2];
 	struct touchkey_variant *variant;
+	u8 keycodes[4];
+	int num_keycodes;
 };
 
 static struct touchkey_variant tm2_touchkey_variant = {
@@ -116,7 +113,8 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 {
 	struct tm2_touchkey_data *touchkey = devid;
 	int data;
-	int key;
+	int index;
+	int i;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
 					touchkey->variant->keycode_reg);
@@ -126,26 +124,20 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 		goto out;
 	}
 
-	switch (data & TM2_TOUCHKEY_BIT_KEYCODE) {
-	case TM2_TOUCHKEY_KEY_MENU:
-		key = KEY_PHONE;
-		break;
-
-	case TM2_TOUCHKEY_KEY_BACK:
-		key = KEY_BACK;
-		break;
-
-	default:
+	index = (data & TM2_TOUCHKEY_BIT_KEYCODE) - 1;
+	if (index < 0 || index >= touchkey->num_keycodes) {
 		dev_warn(&touchkey->client->dev,
-			 "unhandled keycode, data %#02x\n", data);
+			 "invalid keycode index %d\n", index);
 		goto out;
 	}
 
 	if (data & TM2_TOUCHKEY_BIT_PRESS_EV) {
-		input_report_key(touchkey->input_dev, KEY_PHONE, 0);
-		input_report_key(touchkey->input_dev, KEY_BACK, 0);
+		for (i = 0; i < touchkey->num_keycodes; i++)
+			input_report_key(touchkey->input_dev,
+					 touchkey->keycodes[i], 0);
 	} else {
-		input_report_key(touchkey->input_dev, key, 1);
+		input_report_key(touchkey->input_dev,
+				 touchkey->keycodes[index], 1);
 	}
 
 	input_sync(touchkey->input_dev);
@@ -157,8 +149,10 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 static int tm2_touchkey_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
+	struct device_node *np = client->dev.of_node;
 	struct tm2_touchkey_data *touchkey;
 	int error;
+	int i;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -189,6 +183,16 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	/* Save VDD for easy access */
 	touchkey->vdd = touchkey->regulators[1].consumer;
 
+	touchkey->num_keycodes = of_property_read_variable_u8_array(np,
+					"keycodes", touchkey->keycodes, 0,
+					ARRAY_SIZE(touchkey->keycodes));
+	if (touchkey->num_keycodes <= 0) {
+		/* default keycodes */
+		touchkey->keycodes[0] = KEY_PHONE;
+		touchkey->keycodes[1] = KEY_BACK;
+		touchkey->num_keycodes = 2;
+	}
+
 	error = tm2_touchkey_power_enable(touchkey);
 	if (error) {
 		dev_err(&client->dev, "failed to power up device: %d\n", error);
@@ -213,8 +217,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->input_dev->name = touchkey->variant->name;
 	touchkey->input_dev->id.bustype = BUS_I2C;
 
-	input_set_capability(touchkey->input_dev, EV_KEY, KEY_PHONE);
-	input_set_capability(touchkey->input_dev, EV_KEY, KEY_BACK);
+	for (i = 0; i < touchkey->num_keycodes; i++)
+		input_set_capability(touchkey->input_dev, EV_KEY,
+				     touchkey->keycodes[i]);
 
 	error = input_register_device(touchkey->input_dev);
 	if (error) {
-- 
2.17.1

