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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F8C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790DE2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfi74SVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfAGSyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:54:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41467 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfAGSyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:14 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so1241754ljc.8;
        Mon, 07 Jan 2019 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZHCO4PB5R9mGa0HRcFdo1+yp8HDWMwNcsydZLbmBsI=;
        b=rfi74SVx0nA3nKa8vxqpibbOjUMjwV2TmnFNRpSZglZhZrcIxN66MsUdKKGV1ZMg7P
         CCSEzVj2jMW10uIRHASbf5dNAIblAgXMVoXweorBGHgAQUH+HlrHkDWr7cHktUa7pSRw
         y41ClJlV/HHGgy0jCi4MjTha4LzrLep1DU8+MwQy8hp22l0Cr54W8RgNgscJvztgZKG1
         W4xP0ARSqzBzZtXx5sBmRpCCY2SdCJnNVmvcrx37fwXluKpUVOjQQv/KaC8B1SIKs2r2
         Ki5monsCpBsJz5tP/7cDtHxNPZrmzFwjbiYU4pcNINFIZHGFnk2gOfDuxjYyuX8zcTRM
         8Z2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZHCO4PB5R9mGa0HRcFdo1+yp8HDWMwNcsydZLbmBsI=;
        b=s+A5lW8FdKI4phVWv97MLGZVhzQqtflZU87i1Qn1oIW8xKbsaeVeBaStt47HhyP9fP
         ReXkfb7bKkERhlCT4nozElbrrFvencwL8gG/UeeWnaIn1pVA03OSx+TiyWik2jJ6PgjX
         um9h4KPT0t+ccaqsuJA4eEcI+pzy8lvFbe/zwpfKJ4WCRvwUiCtyVQNr2vIT1VGAvrj8
         oHFZGq6PSbiHSvdXBzqNL47P9nCa8bk9OZdtM1woFxPQdYbL2xiNfm+IEGaNKK241E0B
         4/LdT0JyCFzx+MaqaaR7jcJHdHu6L1DtF/Wru+RAQ8AERYWvHFu2KRtLoN77guBaAzmo
         wkHw==
X-Gm-Message-State: AJcUukd4QbcOrICLcd2VGYVXtzMM765ddN92v8CZAbcD0s+TVKeDL1X6
        YH81VFGv/8qx4/rGkQ8SgLSx7ZJOgvrACw==
X-Google-Smtp-Source: ALg8bN488wK0WUXnAUY4jT9OiSxYuCxI2tVms568V2aBMZtSTBajvIspNIZbkAoK6w6LejBXJpHyAA==
X-Received: by 2002:a2e:80d3:: with SMTP id r19-v6mr33696307ljg.151.1546887251525;
        Mon, 07 Jan 2019 10:54:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:10 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 4/7] Input: tm2-touchkey: Allow specifying custom keycodes
Date:   Mon,  7 Jan 2019 19:53:43 +0100
Message-Id: <20190107185346.30184-5-pawel.mikolaj.chmiel@gmail.com>
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

Not all devices use the same keycodes in the same order,
so add possibility to define keycodes for buttons present
on actual hardware.

If keycodes property is not present, we assume that device has
at least MENU and BACK keys.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v2:
  - Change property name from keycodes to linux,keycodes

Changes from v1:
  - Because key codes could be bigger than 255, use ints for keycodes
---
 drivers/input/keyboard/tm2-touchkey.c | 49 +++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 0336789ab1bb..b55faf597d8a 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -35,11 +35,6 @@
 #define TM2_TOUCHKEY_LED_VOLTAGE_MIN	2500000
 #define TM2_TOUCHKEY_LED_VOLTAGE_MAX	3300000
 
-enum {
-	TM2_TOUCHKEY_KEY_MENU = 0x1,
-	TM2_TOUCHKEY_KEY_BACK,
-};
-
 struct touchkey_variant {
 	u8 keycode_reg;
 	u8 base_reg;
@@ -52,6 +47,8 @@ struct tm2_touchkey_data {
 	struct regulator *vdd;
 	struct regulator_bulk_data regulators[2];
 	const struct touchkey_variant *variant;
+	u32 keycodes[4];
+	int num_keycodes;
 };
 
 static const struct touchkey_variant tm2_touchkey_variant = {
@@ -112,7 +109,8 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 {
 	struct tm2_touchkey_data *touchkey = devid;
 	int data;
-	int key;
+	int index;
+	int i;
 
 	data = i2c_smbus_read_byte_data(touchkey->client,
 					touchkey->variant->keycode_reg);
@@ -122,26 +120,20 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
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
@@ -153,8 +145,10 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 static int tm2_touchkey_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
+	struct device_node *np = client->dev.of_node;
 	struct tm2_touchkey_data *touchkey;
 	int error;
+	int i;
 
 	if (!i2c_check_functionality(client->adapter,
 			I2C_FUNC_SMBUS_BYTE | I2C_FUNC_SMBUS_BYTE_DATA)) {
@@ -184,6 +178,16 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	/* Save VDD for easy access */
 	touchkey->vdd = touchkey->regulators[1].consumer;
 
+	touchkey->num_keycodes = of_property_read_variable_u32_array(np,
+					"linux,keycodes", touchkey->keycodes, 0,
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
@@ -208,8 +212,9 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	touchkey->input_dev->name = TM2_TOUCHKEY_DEV_NAME;
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

