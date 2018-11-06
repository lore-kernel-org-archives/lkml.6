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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A708C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311FD20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFsoyKLQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311FD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbeKGHfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:24 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40954 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbeKGHfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so12929676lji.7;
        Tue, 06 Nov 2018 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qDyqAqmkGXXy6g/SCqoQOXDsTD0E+dcunugChNP+S3E=;
        b=PFsoyKLQgUOtt61QWCJEen1+EZzHJC3LnLtfajguyMJnFbfLbaC22kAyRSjRld4WWr
         686gcTdjM4fIOsjm1gXNqpL+13Ce6cypJ+yRq/ei6gWHBKf99rKw5PSDGYZRXA7YB9rx
         yCk3scUESOgOrpK+erMg3qvndZXWIDRGbmQYo7MBwjIQd/2xb5D8ne4dyE7b5gZjgqjY
         msgoloj034BBRGtRNV27V5/PoPGEWqeGf0qCtqIK+XhiRzmZokM1KdSemEVheO2nOyC/
         b4Ie0Z7mO0EE2WFOWaxwZptzMbTt8yHRJfnK1gm8eFuZsSN9Yq9Y1CD53OKfMHOQ2sEZ
         exFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qDyqAqmkGXXy6g/SCqoQOXDsTD0E+dcunugChNP+S3E=;
        b=inIStgFWX+L4ZjhAXCyFjTXgNJMDC45pYzWLvugSUc3cTKYPnliQ7fBALuS1Qrf0gY
         pCKQiV18JKzaCtuqU5CJ3O5mr12Nk6MdXDyda/zWcrNibf6Nolgdtbc5ELqJBrVbXtKo
         CEaGmsprBbXbO70Vr2az1PqsHOqKbOCKt3wRp16i4Z5QV1Jcs5ApCjRPaDJeIvXm/mYU
         8D98AVUIqk7Cz+/y3y/86d+oxknKr0BynX/XAU8QJCRvNx7mrH2fDqTgfyrXSQRMWOBY
         gDxEyWwCyokBbg2ApBWJQQapF9Tey+QG3dYXbnd3OidfXS/0hPmoO24CAnJYf0Ts+aW1
         km6A==
X-Gm-Message-State: AGRZ1gLLHQy4deYfd5mMF3jZ/gpsPOMmx+hM7+8ROnUnSrpBNuvhsc7D
        yyHKrC7M8WnrDu8p/n+zsFjDz+HTg9U=
X-Google-Smtp-Source: AJdET5coJfhpKe8FA/14jn4sNNehNAYueMZIOPPAulQye7BM/His5/08LGcXU9wy6YbCKGEHdkvHsA==
X-Received: by 2002:a2e:9c08:: with SMTP id s8-v6mr15482237lji.149.1541542078965;
        Tue, 06 Nov 2018 14:07:58 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:58 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Daniel Mack <daniel@zonque.org>
Subject: [PATCH 08/24] leds: lt3593: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:16 +0100
Message-Id: <1541542052-10081-9-git-send-email-jacek.anaszewski@gmail.com>
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
Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 drivers/leds/leds-lt3593.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/leds/leds-lt3593.c b/drivers/leds/leds-lt3593.c
index de3623e..d005abc 100644
--- a/drivers/leds/leds-lt3593.c
+++ b/drivers/leds/leds-lt3593.c
@@ -10,10 +10,10 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <uapi/linux/uleds.h>
+
+#define LED_LT3593_NAME "lt3593"
 
 struct lt3593_led_data {
-	char name[LED_MAX_NAME_SIZE];
 	struct led_classdev cdev;
 	struct gpio_desc *gpiod;
 };
@@ -111,6 +111,7 @@ static int lt3593_led_probe(struct platform_device *pdev)
 	struct fwnode_handle *child;
 	int ret, state = LEDS_GPIO_DEFSTATE_OFF;
 	enum gpiod_flags flags = GPIOD_OUT_LOW;
+	struct led_init_data init_data;
 	const char *tmp;
 
 	if (dev_get_platdata(dev)) {
@@ -138,14 +139,11 @@ static int lt3593_led_probe(struct platform_device *pdev)
 		return PTR_ERR(led_data->gpiod);
 
 	child = device_get_next_child_node(dev, NULL);
+	init_data.fwnode = child;
 
-	ret = fwnode_property_read_string(child, "label", &tmp);
-	if (ret < 0)
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593::");
-	else
-		snprintf(led_data->name, sizeof(led_data->name),
-			 "lt3593:%s", tmp);
+	ret = led_compose_name(child, LED_LT3593_NAME, ":", init_data.name);
+	if (ret)
+		return ret;
 
 	fwnode_property_read_string(child, "linux,default-trigger",
 				    &led_data->cdev.default_trigger);
@@ -160,11 +158,10 @@ static int lt3593_led_probe(struct platform_device *pdev)
 		}
 	}
 
-	led_data->cdev.name = led_data->name;
 	led_data->cdev.brightness_set_blocking = lt3593_led_set;
 	led_data->cdev.brightness = state ? LED_FULL : LED_OFF;
 
-	ret = devm_led_classdev_register(dev, &led_data->cdev);
+	ret = devm_led_classdev_register_ext(dev, &led_data->cdev, &init_data);
 	if (ret < 0) {
 		fwnode_handle_put(child);
 		return ret;
-- 
2.1.4

