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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F99C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98F620862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwk/tUsZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98F620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388675AbeKGHfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:32 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35888 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbeKGHfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:30 -0500
Received: by mail-lf1-f66.google.com with SMTP id h192so10059873lfg.3;
        Tue, 06 Nov 2018 14:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pQ3RqqPBhFl7F5HnXPaRV0SJnc5UQSH91FFkBID0Mo4=;
        b=bwk/tUsZAPeLbEMf8uScIs3rCMHbAfJEV1E/QMdLpZSg+5a+C0YM7X8s5RFQV4ZycU
         a+/h6XH/DviBezZN95pm6clNNg6qY/KiLzD9UPD/h9Khaj0EkkLkT9sOFORXSUjR4RR/
         rRnIYseaMV6Me4Jd6zVtOuPa1+VoFuOgg0p2NRQfA4I75L4vWZLaeVAmfhxu98yET4mf
         9qYFsgXXT0z2vTMYO5dj5vKu0ZDJcoVhylxUn8ysrlG5Q0pkLogZh2/hA+rajdPAly7Q
         mIPawwIqGWeDfgGGzx3whneG9vZGfBZPITb4c10/tox/nd6o6ZeXV733hMbJHmZVhuea
         ZBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pQ3RqqPBhFl7F5HnXPaRV0SJnc5UQSH91FFkBID0Mo4=;
        b=Q+8a9nIqHLaomAq7qhaXVbAaoD5qN/V6hhJxSGVqxe3+stc2dQYT0aepRjO1HtNh4I
         c4ay0KFxR7rA4A8j5KCha84oSUQ3ydr/j/eKp+1Lc5V3fLr8nPrezGOAyQelMTYtcqBI
         DeWew1xFEjGFyD8L1xQOuFsM6pj4OTRtArNi6sc4ooxcAQEIIpC2B/9zk5TVItdExcQD
         H4ETfVkF1jq4iSGvFpPKTPrsx5QsNkzOBpY+bnJINPfn3sCzIQPOD0UnVQu1AvM4ZPZC
         U4KTyxEJDEHba5I/n0v26yvwMZhKS5Sy8j1VBXrthsQTh+evwyEhLrBdTw+iGBcoPFoX
         R66Q==
X-Gm-Message-State: AGRZ1gJ4QA/bdX12998xr5zGC+u74LMx5MGvqv2I/4ZYT+zdAI6+d6FE
        OeOpZcN6RVrS5gJi3wkT/C3YbsW/g9o=
X-Google-Smtp-Source: AJdET5c+vXsbCBN9CtKQiIktw51ZlX9eTRmU3anxseLk69X2EW4L+NyR70rBTQQsSLzL20gk2PdjvQ==
X-Received: by 2002:a19:914b:: with SMTP id y11mr15455296lfj.98.1541542086251;
        Tue, 06 Nov 2018 14:08:06 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:05 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 12/24] leds: lm3692x: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:20 +0100
Message-Id: <1541542052-10081-13-git-send-email-jacek.anaszewski@gmail.com>
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
 drivers/leds/leds-lm3692x.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 4f413a7..9dfc0f2 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -13,7 +13,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-#include <uapi/linux/uleds.h>
 
 #define LM36922_MODEL	0
 #define LM36923_MODEL	1
@@ -95,6 +94,9 @@
 #define LM3692X_FAULT_FLAG_SHRT BIT(3)
 #define LM3692X_FAULT_FLAG_OPEN BIT(4)
 
+#define LM36922_NAME "lm36922"
+#define LM36923_NAME "lm36923"
+
 /**
  * struct lm3692x_led -
  * @lock - Lock for reading/writing the device
@@ -103,7 +105,6 @@
  * @regmap - Devices register map
  * @enable_gpio - VDDIO/EN gpio to enable communication interface
  * @regulator - LED supply regulator pointer
- * @label - LED label
  * @led_enable - LED sync to be enabled
  * @model_id - Current device model ID enumerated
  */
@@ -114,7 +115,6 @@ struct lm3692x_led {
 	struct regmap *regmap;
 	struct gpio_desc *enable_gpio;
 	struct regulator *regulator;
-	char label[LED_MAX_NAME_SIZE];
 	int led_enable;
 	int model_id;
 };
@@ -325,7 +325,8 @@ static int lm3692x_init(struct lm3692x_led *led)
 static int lm3692x_probe_dt(struct lm3692x_led *led)
 {
 	struct fwnode_handle *child = NULL;
-	const char *name;
+	struct led_init_data init_data;
+	char *model_name;
 	int ret;
 
 	led->enable_gpio = devm_gpiod_get_optional(&led->client->dev,
@@ -346,17 +347,20 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		dev_err(&led->client->dev, "No LED Child node\n");
 		return -ENODEV;
 	}
+	init_data.fwnode = child;
 
-	fwnode_property_read_string(child, "linux,default-trigger",
-				    &led->led_dev.default_trigger);
+	if (led->model_id == LM36922_MODEL)
+		model_name =  LM36922_NAME;
+	else
+		model_name =  LM36923_NAME;
 
-	ret = fwnode_property_read_string(child, "label", &name);
+	ret = led_compose_name(child, model_name, ":backlight_cluster",
+			       init_data.name);
 	if (ret)
-		snprintf(led->label, sizeof(led->label),
-			"%s::", led->client->name);
-	else
-		snprintf(led->label, sizeof(led->label),
-			 "%s:%s", led->client->name, name);
+		return ret;
+
+	fwnode_property_read_string(child, "linux,default-trigger",
+				    &led->led_dev.default_trigger);
 
 	ret = fwnode_property_read_u32(child, "reg", &led->led_enable);
 	if (ret) {
@@ -364,16 +368,13 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		return ret;
 	}
 
-	led->led_dev.name = led->label;
-
-	ret = devm_led_classdev_register(&led->client->dev, &led->led_dev);
+	ret = devm_led_classdev_register_ext(&led->client->dev, &led->led_dev,
+					     &init_data);
 	if (ret) {
 		dev_err(&led->client->dev, "led register err: %d\n", ret);
 		return ret;
 	}
 
-	led->led_dev.dev->of_node = to_of_node(child);
-
 	return 0;
 }
 
@@ -439,8 +440,8 @@ static int lm3692x_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3692x_id[] = {
-	{ "lm36922", LM36922_MODEL },
-	{ "lm36923", LM36923_MODEL },
+	{ LM36922_NAME, LM36922_MODEL },
+	{ LM36923_NAME, LM36923_MODEL },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lm3692x_id);
-- 
2.1.4

