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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67133C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6DD2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgpJnqKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6DD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbeKGHft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbeKGHfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:48 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so4298369ljh.13;
        Tue, 06 Nov 2018 14:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LJ6SOaj7NyIQapLj64p4Wg1aYkRzp9U5EfWFNYR9Uko=;
        b=hgpJnqKGcwdresOJpu7asQFIcCaG6k3KNVBPUzoOm9EecRK9LPqNLZOFs/FcysKpcq
         c9AQOeHsogJG/0lF61iFZf7Gc4jqYG7oNCoXo1D+o8q8X9yY9CqhDMlkGdTRUg6tNO4E
         2zgVM2SU8+wLISuNSefNHFYig7I4mCU/S+I56Pvwl1vel32WGrxlHY5yQ5SlZwUw56Pq
         2pSLZTS0xxB+fVZEsMbbXJrAKGsOTzMvYoCb+wmDeStDdmSlpL2YDnK31rjb4EOZPymw
         2dxD2CSiYSrvBK2bf4EqZM20lkuQlLFgJ3K9HKnqJwOjk+ddqQvEUxORYTGWwtgQ9QYf
         la7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LJ6SOaj7NyIQapLj64p4Wg1aYkRzp9U5EfWFNYR9Uko=;
        b=W4sZE/cK07qphLLYStUqNlPbRRmsb3zZDItzYY1cNCNnCaOAtb9MgD04QcmLaPug6s
         A8D5+41CcHU5uIVFAiJ5POD8RZH+ACwGzU8a5YB17UMt7qWI0aXO5ncF4x/yB/8cyzgn
         5fy5z+S6dQeAAxS1k0S5det+6HIBgcgsbF0sUkD9I13avezDA7T2N25BwcuwtZ8JteLe
         rzEG6lo/UHU72ZkuPgbpzVTNpVbVFabB6lxG/yytSMcDvUxXKMzht/iaei/sFgqsMvH8
         +0lx1e3wGKsfl6OBFqrVJMuSZYnBIrdbmRue7KELN778nT7TCmVBrhvCNbQupOjLl9MP
         757A==
X-Gm-Message-State: AGRZ1gKozfxcnQVQGdi9dN2zOLo0RNmg43iAMg1eNnUz6iIKUskagBzn
        0WSvCWovOtggpAcbEhwBGSrKi+0SfMU=
X-Google-Smtp-Source: AJdET5c+3ZDW6Y3TigCDxN92rE6ZzECzwHfaOma7cBcMLx56zl+KJDHyeSWBmXVltUbZRudZP1oXOg==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr17690038ljf.96.1541542104360;
        Tue, 06 Nov 2018 14:08:24 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:23 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 22/24] leds: gpio: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:30 +0100
Message-Id: <1541542052-10081-23-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/leds/leds-gpio.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index c87fbd3..69a3cde 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -77,11 +77,19 @@ static int gpio_blink_set(struct led_classdev *led_cdev,
 
 static int create_gpio_led(const struct gpio_led *template,
 	struct gpio_led_data *led_dat, struct device *parent,
-	struct device_node *np, gpio_blink_set_t blink_set)
+	struct fwnode_handle *fwnode, gpio_blink_set_t blink_set)
 {
+	struct led_init_data init_data = { fwnode };
 	int ret, state;
 
-	led_dat->cdev.name = template->name;
+	if (template->name) {
+		led_dat->cdev.name = template->name;
+	} else {
+		ret = led_compose_name(fwnode, NULL, NULL, init_data.name);
+		if (ret)
+			return ret;
+	}
+
 	led_dat->cdev.default_trigger = template->default_trigger;
 	led_dat->can_sleep = gpiod_cansleep(led_dat->gpiod);
 	if (!led_dat->can_sleep)
@@ -112,7 +120,8 @@ static int create_gpio_led(const struct gpio_led *template,
 	if (ret < 0)
 		return ret;
 
-	return devm_led_classdev_register(parent, &led_dat->cdev);
+	return devm_led_classdev_register_ext(parent, &led_dat->cdev,
+					      &init_data);
 }
 
 struct gpio_leds_priv {
@@ -145,15 +154,6 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		struct gpio_led_data *led_dat = &priv->leds[priv->num_leds];
 		struct gpio_led led = {};
 		const char *state = NULL;
-		struct device_node *np = to_of_node(child);
-
-		ret = fwnode_property_read_string(child, "label", &led.name);
-		if (ret && IS_ENABLED(CONFIG_OF) && np)
-			led.name = np->name;
-		if (!led.name) {
-			fwnode_handle_put(child);
-			return ERR_PTR(-EINVAL);
-		}
 
 		led.gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL, child,
 							     GPIOD_ASIS,
@@ -183,12 +183,11 @@ static struct gpio_leds_priv *gpio_leds_create(struct platform_device *pdev)
 		if (fwnode_property_present(child, "panic-indicator"))
 			led.panic_indicator = 1;
 
-		ret = create_gpio_led(&led, led_dat, dev, np, NULL);
+		ret = create_gpio_led(&led, led_dat, dev, child, NULL);
 		if (ret < 0) {
 			fwnode_handle_put(child);
 			return ERR_PTR(ret);
 		}
-		led_dat->cdev.dev->of_node = np;
 		priv->num_leds++;
 	}
 
-- 
2.1.4

