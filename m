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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5106520862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="spev2DJ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5106520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbeKGHff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:35 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35069 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbeKGHfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:34 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so12958916ljb.2;
        Tue, 06 Nov 2018 14:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=80S6lsb77TIUbOpcZGo7NUjWXITG+ozK8mtMIY4nfd4=;
        b=spev2DJ0JJR82/qxqq0psarE48yyJPAMEARxfqn42J/QMvcMwSbWODxLUQisbGLiUQ
         fWn9Jgpd02kXIlojcut4MEANW+cndlosJaZaAgYl5xjdUaevQu1vOPFP8tBxYDzSXDpP
         XIKGzN+msKdQavm0fuYuoV7/8ughWqqEQTvsdcW1vYnE5L/bVjVbu3lFKQiDcDKn5Q6X
         Uez15jayGCHgRLqUS/RPUP0FBr40P4O4dCJfaoTW3+rcrttHQN45dIekgUovZ164l3VY
         hmGntTLq/rLdTGfRb13yK+nSnjzm4WNyHOPx7vSN6iuHlNiFB/g17Jp9LQXepbauNDfv
         ovZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=80S6lsb77TIUbOpcZGo7NUjWXITG+ozK8mtMIY4nfd4=;
        b=aqVI9Dn6CPqR7+6BGK/afhmYcVp1HPDaBpJogyt1uNfY60pbBjMEzp/FyBm8LuEquc
         CeARFvbGdn5iKzUE7lCvmKS6Mozp7dvLYE1SU+BnYIP2Oc0yc+o5CYnjKK4X9NlNGRfL
         esywECTUMr9429p9TOPLviDdliw82Ak/vtN+BdNnKgKR9vD0grY2QkqJYI1wNbeLAsaz
         dusCcbl3Nn2W6gNiR/bOzI5PIysm7JTxIzzlOHtPGTvZsUOl5BhI//hzPXcMYyrq23B8
         9jl12IEvqPrhFStHoVCdb/8AsOhDABBq9ATwwik8hSBU9r7kaRYP8C4b7IFYk4vddG6/
         kh4g==
X-Gm-Message-State: AGRZ1gK8Av7s2wKtcFGCTadmCNWq2yNF9BY/hmNiitcJZdYNVXh3zKmI
        t59eTRIJ/A0Cphwf9iuc9c3mp+7OaS4=
X-Google-Smtp-Source: AJdET5exB6POr45x3FctlPLRmXS7vnXpJOj17HCjSV6m4shZ4H2gKj/q2CIerZZmYpgW0ZknDtHz1g==
X-Received: by 2002:a2e:5418:: with SMTP id i24-v6mr19801579ljb.51.1541542089786;
        Tue, 06 Nov 2018 14:08:09 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:09 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 14/24] leds: lm3601x: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:22 +0100
Message-Id: <1541542052-10081-15-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lm3601x.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/leds/leds-lm3601x.c b/drivers/leds/leds-lm3601x.c
index 081aa71..91ea652 100644
--- a/drivers/leds/leds-lm3601x.c
+++ b/drivers/leds/leds-lm3601x.c
@@ -10,7 +10,6 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LM3601X_LED_IR		0x0
 #define LM3601X_LED_TORCH	0x1
@@ -90,8 +89,6 @@ struct lm3601x_led {
 	struct regmap *regmap;
 	struct mutex lock;
 
-	char led_name[LED_MAX_NAME_SIZE];
-
 	unsigned int flash_timeout;
 	unsigned int last_flag;
 
@@ -322,10 +319,24 @@ static const struct led_flash_ops flash_ops = {
 	.fault_get		= lm3601x_flash_fault_get,
 };
 
-static int lm3601x_register_leds(struct lm3601x_led *led)
+static int lm3601x_register_leds(struct lm3601x_led *led,
+				 struct fwnode_handle *fwnode)
 {
 	struct led_classdev *led_cdev;
 	struct led_flash_setting *setting;
+	struct led_init_data init_data = { fwnode };
+	char *mode_name;
+	int ret;
+
+	if (led->led_mode == LM3601X_LED_TORCH)
+		mode_name = "torch";
+	else
+		mode_name = "infrared";
+
+	ret = led_compose_name(fwnode, led->client->name, mode_name,
+			       init_data.name);
+	if (ret < 0)
+		return ret;
 
 	led->fled_cdev.ops = &flash_ops;
 
@@ -342,20 +353,20 @@ static int lm3601x_register_leds(struct lm3601x_led *led)
 	setting->val = led->flash_current_max;
 
 	led_cdev = &led->fled_cdev.led_cdev;
-	led_cdev->name = led->led_name;
 	led_cdev->brightness_set_blocking = lm3601x_brightness_set;
 	led_cdev->max_brightness = DIV_ROUND_UP(led->torch_current_max,
 						LM3601X_TORCH_REG_DIV);
 	led_cdev->flags |= LED_DEV_CAP_FLASH;
 
-	return led_classdev_flash_register(&led->client->dev, &led->fled_cdev);
+	return led_classdev_flash_register_ext(&led->client->dev,
+						&led->fled_cdev, &init_data);
 }
 
-static int lm3601x_parse_node(struct lm3601x_led *led)
+static int lm3601x_parse_node(struct lm3601x_led *led,
+			      struct fwnode_handle **fwnode)
 {
 	struct fwnode_handle *child = NULL;
 	int ret = -ENODEV;
-	const char *name;
 
 	child = device_get_next_child_node(&led->client->dev, child);
 	if (!child) {
@@ -376,17 +387,6 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 		goto out_err;
 	}
 
-	ret = fwnode_property_read_string(child, "label", &name);
-	if (ret) {
-		if (led->led_mode == LM3601X_LED_TORCH)
-			name = "torch";
-		else
-			name = "infrared";
-	}
-
-	snprintf(led->led_name, sizeof(led->led_name),
-		"%s:%s", led->client->name, name);
-
 	ret = fwnode_property_read_u32(child, "led-max-microamp",
 					&led->torch_current_max);
 	if (ret) {
@@ -411,6 +411,8 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 		goto out_err;
 	}
 
+	*fwnode = child;
+
 out_err:
 	fwnode_handle_put(child);
 	return ret;
@@ -419,6 +421,7 @@ static int lm3601x_parse_node(struct lm3601x_led *led)
 static int lm3601x_probe(struct i2c_client *client)
 {
 	struct lm3601x_led *led;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	led = devm_kzalloc(&client->dev, sizeof(*led), GFP_KERNEL);
@@ -428,7 +431,7 @@ static int lm3601x_probe(struct i2c_client *client)
 	led->client = client;
 	i2c_set_clientdata(client, led);
 
-	ret = lm3601x_parse_node(led);
+	ret = lm3601x_parse_node(led, &fwnode);
 	if (ret)
 		return -ENODEV;
 
@@ -442,7 +445,7 @@ static int lm3601x_probe(struct i2c_client *client)
 
 	mutex_init(&led->lock);
 
-	return lm3601x_register_leds(led);
+	return lm3601x_register_leds(led, fwnode);
 }
 
 static int lm3601x_remove(struct i2c_client *client)
-- 
2.1.4

