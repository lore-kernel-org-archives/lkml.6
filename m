Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D2EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6DE2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6jZr8hC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6DE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbeKGHf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46477 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbeKGHf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:27 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so4297577ljh.13;
        Tue, 06 Nov 2018 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yBvfAjDh8H+8DcT1xiLHYVyhCSlTFTX9rjgs07sbUNA=;
        b=Q6jZr8hCghpxz2dClWOI4xWf9h+zOYrhY+LwcXZnCTiuLuk90p/qhYyqFDZxbvlZXZ
         A2cC9rahkc8CbuzY/NCYrSAH6lsqf4GKDoOfwD9XwaOLaHODkLiipNoeAF4PKoBhGP/v
         7fr/aI3g2mACgo8lKQvZCHEhMGAkExsNUn73BXgmDpQ7NSTa8AgcL7jTFYs4EtI/0wVy
         XaSJa7WVgDnF9nEacGeP5c82W8o8NLxr9nKpCdZ9W374/fsZVl3zjHiWdNvWOG0HaGH6
         GX8dzRF9GKKueuoRnqzzaCoDOtG8/K121gVQwscVA4wdt1XCGTsI/iX1ZP8WID5IS0Fx
         UthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yBvfAjDh8H+8DcT1xiLHYVyhCSlTFTX9rjgs07sbUNA=;
        b=Eyz3/r0Q7EYjz0qWTPxrUw0RN6+XdKVcoEy+2grHIZQ7QIsnXAWbLPzRxNrZ2Nc8CZ
         UGlyf539hdTCezK9R3UUTSgP0ngAHsJZsJ3dBStULsBzTHh3mngPo2DtCaMbzwe15Dw/
         mJ6R2pOnBLAs6ljxGSmys9kcKGpvsBLa2hnyPcyVrGNojr5luvaLoRI8EsneLfNL8f3A
         7SQSwIHo/F1vp3MHvV2fYDVS4p50/pmu8vfgw+eXGwKLbWKg3B/Zz4b7DL6AUbEMNbzJ
         vzHzs+ceiy6iZo2HUaekBFihxTkGh+2NfY+2lA6gkQ1anYjICI4ysjEMpQbCILt8JHf4
         oKkQ==
X-Gm-Message-State: AGRZ1gKMVAiH67eX+ivCPiBl3xq3OlF/Jmyn8PazU5QBKuE9h5/FJEwd
        rxhCTbHzvhgnEDfRvZkufAQ7TNWvqgg=
X-Google-Smtp-Source: AJdET5fPya4+/YYf8ieyNGybH/MD3OdBoK9fvcoZdAgU4/mduxoVoQo8eOtD0Ic46ZaeeZeCpn29Cw==
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr19725966lji.60.1541542082730;
        Tue, 06 Nov 2018 14:08:02 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:02 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 10/24] leds: lp8860: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:18 +0100
Message-Id: <1541542052-10081-11-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using generic LED support for composing LED class
device name.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lp8860.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 39c72a9..7c12ccd 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -22,7 +22,6 @@
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LP8860_DISP_CL1_BRT_MSB		0x00
 #define LP8860_DISP_CL1_BRT_LSB		0x01
@@ -87,6 +86,8 @@
 
 #define LP8860_CLEAR_FAULTS		0x01
 
+#define LP8860_NAME			"lp8860"
+
 /**
  * struct lp8860_led -
  * @lock - Lock for reading/writing the device
@@ -96,7 +97,6 @@
  * @eeprom_regmap - EEPROM register map
  * @enable_gpio - VDDIO/EN gpio to enable communication interface
  * @regulator - LED supply regulator pointer
- * @label - LED label
  */
 struct lp8860_led {
 	struct mutex lock;
@@ -106,7 +106,6 @@ struct lp8860_led {
 	struct regmap *eeprom_regmap;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	char label[LED_MAX_NAME_SIZE];
 };
 
 struct lp8860_eeprom_reg {
@@ -387,25 +386,26 @@ static int lp8860_probe(struct i2c_client *client,
 	struct lp8860_led *led;
 	struct device_node *np = client->dev.of_node;
 	struct device_node *child_node;
-	const char *name;
+	struct led_init_data init_data;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
 	if (!led)
 		return -ENOMEM;
 
-	for_each_available_child_of_node(np, child_node) {
-		led->led_dev.default_trigger = of_get_property(child_node,
-						    "linux,default-trigger",
-						    NULL);
-
-		ret = of_property_read_string(child_node, "label", &name);
-		if (!ret)
-			snprintf(led->label, sizeof(led->label), "%s:%s",
-				 id->name, name);
-		else
-			snprintf(led->label, sizeof(led->label),
-				"%s::display_cluster", id->name);
-	}
+	child_node = of_get_next_available_child(np, NULL);
+	if (!child_node)
+		return -EINVAL;
+
+	init_data.fwnode = of_fwnode_handle(child_node),
+
+	led->led_dev.default_trigger = of_get_property(child_node,
+					    "linux,default-trigger",
+					    NULL);
+
+	ret = led_compose_name(init_data.fwnode, LP8860_NAME,
+			       ":display_cluster", init_data.name);
+	if (ret)
+		return ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&client->dev,
 						   "enable", GPIOD_OUT_LOW);
@@ -420,7 +420,6 @@ static int lp8860_probe(struct i2c_client *client,
 		led->regulator = NULL;
 
 	led->client = client;
-	led->led_dev.name = led->label;
 	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
 
 	mutex_init(&led->lock);
@@ -447,7 +446,8 @@ static int lp8860_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	ret = devm_led_classdev_register(&client->dev, &led->led_dev);
+	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&client->dev, "led register err: %d\n", ret);
 		return ret;
-- 
2.1.4

