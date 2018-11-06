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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27C9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBFE20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7LKCWXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BBFE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbeKGHfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34823 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeKGHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so10064230lfi.2;
        Tue, 06 Nov 2018 14:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfRbCJQAtwCjLAbsjnCZsOWeAPcIfNc2DWqBi/np9so=;
        b=q7LKCWXqtMWPz/myvyMGQyuoTGfF3Rx9qfLoy8A8I7bQGl6rzqWOFa1MO9B7Untebe
         JJ0MXvxCRi6eXJJEeXa086ut2j2Eol8fKuUrYcMeTyXVFGYJCpIONWAIBxIQ35CDqm2t
         Rsq76hxNY9bJdxFWgQCVo1c8bOy5TwsIBA4NH6CRRNs4JIPbMteLTkgaGQVVYndS6piV
         uendnFfrQ7yUgzW1yFOmpVdz6WWgUdVCISXdPVTQEJJHJcbfaq2BJAI2B45Nbs4s0Nzb
         juHVo0Si6P6ZBVFOg3BcfxPHWkW+hEthIytWrFX8QvjNnDXWEUX7I8l1dkg5pFQ+gTki
         JgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfRbCJQAtwCjLAbsjnCZsOWeAPcIfNc2DWqBi/np9so=;
        b=WvGV2qSXnpg902z62wehSWDym7WyaiXwL+3OOcNdNbDczAbc8wBuSQCkpmQeuprnA6
         SqjglbpvX+bQSBoRlqYBJ4/txEPlwDiUot2rZOMsmrfwPPjLoL5Tn1nJH6ZN0wrl4h6h
         GqzVkDZUniuqWfiTu5mN8rZxyHcp1bG4B4thnzOJgMqlhWP5IdE7Qc4w4cXL38BHyUY1
         0a2TsJddZsx/6o3E7aahLomDTLSvQY7aSI9M14LrzJcLvZWirG2d9E0oJZuyKMrupwpL
         i8YpNUulqz4tJ5QSi48IlQEFFF+A7fBq8vmMCMGGRhT2HBGNEkmU+0m6A2Wm5Hm8vEoP
         h+FA==
X-Gm-Message-State: AGRZ1gKBiVegFq2yVXnKs/ZfAWT26WHm7zq50wXdqyNeMOFFe+D6c8eu
        XHBAqWfo1hk3PP+jVYwfML3v6lIASj0=
X-Google-Smtp-Source: AJdET5dqp6I61QXdOpTeXZUxx2DUK6YDUIv+HkVeuBoE6mHokXJYcpVLh5+Y5BUWGNUoMg/2AiYTow==
X-Received: by 2002:a19:9b50:: with SMTP id d77mr16646985lfe.137.1541542100045;
        Tue, 06 Nov 2018 14:08:20 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:19 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 20/24] leds: as3645a: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:28 +0100
Message-Id: <1541542052-10081-21-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/leds/leds-as3645a.c | 65 ++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 36 deletions(-)

diff --git a/drivers/leds/leds-as3645a.c b/drivers/leds/leds-as3645a.c
index 98a69b1..d7f6037 100644
--- a/drivers/leds/leds-as3645a.c
+++ b/drivers/leds/leds-as3645a.c
@@ -132,11 +132,6 @@ struct as3645a_config {
 	u32 peak;
 };
 
-struct as3645a_names {
-	char flash[32];
-	char indicator[32];
-};
-
 struct as3645a {
 	struct i2c_client *client;
 
@@ -492,12 +487,10 @@ static int as3645a_detect(struct as3645a *flash)
 }
 
 static int as3645a_parse_node(struct as3645a *flash,
-			      struct as3645a_names *names,
 			      struct device_node *node)
 {
 	struct as3645a_config *cfg = &flash->cfg;
 	struct device_node *child;
-	const char *name;
 	int rval;
 
 	for_each_child_of_node(node, child) {
@@ -524,13 +517,6 @@ static int as3645a_parse_node(struct as3645a *flash,
 		return -ENODEV;
 	}
 
-	rval = of_property_read_string(flash->flash_node, "label", &name);
-	if (!rval)
-		strlcpy(names->flash, name, sizeof(names->flash));
-	else
-		snprintf(names->flash, sizeof(names->flash),
-			 "%pOFn:flash", node);
-
 	rval = of_property_read_u32(flash->flash_node, "flash-timeout-us",
 				    &cfg->flash_timeout_us);
 	if (rval < 0) {
@@ -568,13 +554,6 @@ static int as3645a_parse_node(struct as3645a *flash,
 		goto out_err;
 	}
 
-	rval = of_property_read_string(flash->indicator_node, "label", &name);
-	if (!rval)
-		strlcpy(names->indicator, name, sizeof(names->indicator));
-	else
-		snprintf(names->indicator, sizeof(names->indicator),
-			 "%pOFn:indicator", node);
-
 	rval = of_property_read_u32(flash->indicator_node, "led-max-microamp",
 				    &cfg->indicator_max_ua);
 	if (rval < 0) {
@@ -592,21 +571,27 @@ static int as3645a_parse_node(struct as3645a *flash,
 	return rval;
 }
 
-static int as3645a_led_class_setup(struct as3645a *flash,
-				   struct as3645a_names *names)
+static int as3645a_led_class_setup(struct as3645a *flash)
 {
 	struct led_classdev *fled_cdev = &flash->fled.led_cdev;
 	struct led_classdev *iled_cdev = &flash->iled_cdev;
+	struct led_init_data init_data;
 	struct led_flash_setting *cfg;
 	int rval;
 
-	iled_cdev->name = names->indicator;
+	init_data.fwnode = of_fwnode_handle(flash->indicator_node);
+	rval = led_compose_name(init_data.fwnode, AS_NAME, "indicator",
+				init_data.name);
+	if (rval < 0)
+		return rval;
+
 	iled_cdev->brightness_set_blocking = as3645a_set_indicator_brightness;
 	iled_cdev->max_brightness =
 		flash->cfg.indicator_max_ua / AS_INDICATOR_INTENSITY_STEP;
 	iled_cdev->flags = LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_register(&flash->client->dev, iled_cdev);
+	rval = led_classdev_register_ext(&flash->client->dev, iled_cdev,
+					 &init_data);
 	if (rval < 0)
 		return rval;
 
@@ -624,7 +609,12 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 
 	flash->fled.ops = &as3645a_led_flash_ops;
 
-	fled_cdev->name = names->flash;
+	init_data.fwnode = of_fwnode_handle(flash->flash_node);
+	rval = led_compose_name(init_data.fwnode, AS_NAME, "flash",
+				init_data.name);
+	if (rval < 0)
+		goto out_err;
+
 	fled_cdev->brightness_set_blocking = as3645a_set_assist_brightness;
 	/* Value 0 is off in LED class. */
 	fled_cdev->max_brightness =
@@ -632,14 +622,18 @@ static int as3645a_led_class_setup(struct as3645a *flash,
 				       flash->cfg.assist_max_ua) + 1;
 	fled_cdev->flags = LED_DEV_CAP_FLASH | LED_CORE_SUSPENDRESUME;
 
-	rval = led_classdev_flash_register(&flash->client->dev, &flash->fled);
-	if (rval) {
-		led_classdev_unregister(iled_cdev);
-		dev_err(&flash->client->dev,
-			"led_classdev_flash_register() failed, error %d\n",
-			rval);
-	}
+	rval = led_classdev_flash_register_ext(&flash->client->dev,
+					       &flash->fled, &init_data);
+	if (rval)
+		goto out_err;
+
+	return rval;
 
+out_err:
+	led_classdev_unregister(iled_cdev);
+	dev_err(&flash->client->dev,
+		"led_classdev_flash_register() failed, error %d\n",
+		rval);
 	return rval;
 }
 
@@ -686,7 +680,6 @@ static int as3645a_v4l2_setup(struct as3645a *flash)
 
 static int as3645a_probe(struct i2c_client *client)
 {
-	struct as3645a_names names;
 	struct as3645a *flash;
 	int rval;
 
@@ -699,7 +692,7 @@ static int as3645a_probe(struct i2c_client *client)
 
 	flash->client = client;
 
-	rval = as3645a_parse_node(flash, &names, client->dev.of_node);
+	rval = as3645a_parse_node(flash, client->dev.of_node);
 	if (rval < 0)
 		return rval;
 
@@ -714,7 +707,7 @@ static int as3645a_probe(struct i2c_client *client)
 	if (rval)
 		goto out_mutex_destroy;
 
-	rval = as3645a_led_class_setup(flash, &names);
+	rval = as3645a_led_class_setup(flash);
 	if (rval)
 		goto out_mutex_destroy;
 
-- 
2.1.4

