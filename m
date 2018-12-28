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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B85A20879
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pynw+y1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbeL1Pq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:46:29 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40585 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732943AbeL1PqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:46:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so14778754lfe.7;
        Fri, 28 Dec 2018 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TVTilf2im2mIwScoPJHnBUS9MY3MXep8YuucLBXaAE=;
        b=Pynw+y1g8O+tIUwrgImDqGBlTg80nCAOEP0Lnlg0OxrgRCBHOTV1uY/BM26zaq/MK3
         DNavxyag+ZXiN7l1QOlS8Z0fp5FYZ+5ugY6RwATvb836rqDt9Q1DAYnEl0JqLsrk7SzE
         oc9zAUh4dkoSDZPTdyUbBoGMW/l+BJj5SgUL48Fx+gHPvFKDXeYv3kcN54pZtOWeazcF
         Mn9ZpyplqYx/k2Sz12IHZFOdthFdGwyKoRl12lTT7vhosaD8eRaiYGSy1fSdby3wiX1I
         L/kxF0ypuwxQybyhNKKzrZpspLFyboOo9E2J2SCsWcahlbaB/6qw7olqg+sdxUQW5HUw
         1dNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TVTilf2im2mIwScoPJHnBUS9MY3MXep8YuucLBXaAE=;
        b=daKgNKWVIBcNTyaAz1QK1YIIe7I+mZus9KTAq0/ZVjq6qAoMEIWFeR4DPiuHsLxm/U
         JMgDNJ638ixSFQc05sTPAb9zU0dwREH4HAeHGq+drQ3gvmXbGmIYeoaKxiRcXPWX5Lmu
         CzJ6pePLQOERrMdHB8i2cgwERBRJaUtpjBRKDB+rr6KBFtdciNTqzx2GphEzn75+KQ1g
         Pdg7Ys7XbaOHH2Nv5gJlH4+Bz5g/ZjV4xg1VX2x6lnreHhfoOLM0jBPTRqN+O9d8Bgf9
         8d5on9Xwt1L/iJasK7PADwNwlOpJNz4kw4I0c+7PHQ0K5D4eicUdSf++SoJNqrb0oiEV
         QTIg==
X-Gm-Message-State: AA+aEWZ8ruiWX74vCoJsvIUJPGiplSUcBPteoQM2rMZhRX/PeZX0uOS1
        Jsm+9BSIOZyUsWrnaubKYIc=
X-Google-Smtp-Source: AFSGD/W4JTza2aLzstfGoA/Ve8TMBIJzQHV8xVzWMZknn7Ahu3LQn6K9SiekNZrIilRM5szsseSvRg==
X-Received: by 2002:a19:5059:: with SMTP id z25mr13990700lfj.120.1546011981695;
        Fri, 28 Dec 2018 07:46:21 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:7146:fd07:48ff:9665])
        by smtp.googlemail.com with ESMTPSA id c203sm8042444lfe.95.2018.12.28.07.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:46:21 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v2 4/7] Input: tm2-touchkey: Allow specifying custom keycodes
Date:   Fri, 28 Dec 2018 16:46:06 +0100
Message-Id: <20181228154609.14846-5-pawel.mikolaj.chmiel@gmail.com>
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

Not all devices use the same keycodes in the same order,
so add possibility to define keycodes for buttons present
on actual hardware.

If keycodes property is not present, we assume that device has
at least MENU and BACK keys.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v1:
  - Because key codes could be bigger than 255, use ints for keycodes
---
 drivers/input/keyboard/tm2-touchkey.c | 49 +++++++++++++++------------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 0336789ab1bb..c5adb928c6b4 100644
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

