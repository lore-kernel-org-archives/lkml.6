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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68310C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACCE20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgHX2Bch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACCE20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbeKGHfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43393 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeKGHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:37 -0500
Received: by mail-lj1-f194.google.com with SMTP id g26-v6so12919886lja.10;
        Tue, 06 Nov 2018 14:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=slV4qsa78wS6d42FYQQijzQMa7TAfyRG2HkKrM8Z7oQ=;
        b=TgHX2Bchv2/da/8rYfWaZsbkQd4oHsTpF2dATrWA4QSUF5/61exhi/6M7BEJS7YHKW
         zsN3CsLVqiGbiGf98CuqOHjLjm4YVEtJRobPVu1COK9PWuyKQPMBSTvX2WQkuK+Lz0hr
         c1lw4QV63uMo24km3vsISOztMxwBEWMXHeNLMZ4D2g8WMgJBxLjeGRXhuhvCiUa0k6hc
         M7pGV/aNh3jeqbI/Xdm+OqCprliIlvysOYatY/oKxmlRgfetHSM40YdtaAzcg+17K2lB
         IpnRs7bNGa2cQyH4ivkYLzaUXci4F4inZUAju2Ms+L4CcSw0i4s96rIo3h1BMM+sALHN
         kVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=slV4qsa78wS6d42FYQQijzQMa7TAfyRG2HkKrM8Z7oQ=;
        b=jU73SlSgUDN02tK28FgaVo+E8PdcfZmcdY4mUPfPnmCDqikfwRBFrnz42I1xSvy4bI
         toTDRHHUCV5yEy2efjvbzE6hK9M3xIQd38PO7isNxRSp5I34paDLtjZ2847H2T3AcgZk
         YeZwYvNnVns9ZRNebpwKQTzpMXX8kwdX3AAnGRI+noC4ohI81ALr1J19SDwUCoxY14YS
         /9ZX8L6zazoTRtdUecPA2URLIZwQw5McIOYZIHsFxvbMLfRQqHhw0DhZmU3VqWtJnMEH
         5I6H7ywfQJKJGujvqpv/wnW+Yge+4buWhNe+yGUjcUAvXIBq2ofKFQTTH/O0xh86WlTo
         CkFw==
X-Gm-Message-State: AGRZ1gJYYSg91RObBB3vcLlUEA12GtZV6VpsaMrFK1Fe4pD8UnsKRj30
        EJ/JbGvAOdBQ9/jHajsLG26WXLjbCoM=
X-Google-Smtp-Source: AJdET5dGzQM7UvWT1OLiGDS3GytLo3jzVADJ2lkdeNjY0FenxMNxa6XpJomLUqSZgxMRMqZLUIfx/A==
X-Received: by 2002:a2e:5747:: with SMTP id r7-v6mr5180354ljd.141.1541542093479;
        Tue, 06 Nov 2018 14:08:13 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:12 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Oleh Kravchenko <oleg@kaa.org.ua>
Subject: [PATCH 16/24] leds: cr0014114: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:24 +0100
Message-Id: <1541542052-10081-17-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
---
 drivers/leds/leds-cr0014114.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 1c82152..0aee979 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -8,7 +8,6 @@
 #include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/workqueue.h>
-#include <uapi/linux/uleds.h>
 
 /*
  *  CR0014114 SPI protocol descrtiption:
@@ -40,8 +39,9 @@
 #define CR_FW_DELAY_MSEC	10
 #define CR_RECOUNT_DELAY	(HZ * 3600)
 
+#define CR_DEV_NAME		"cr0014114"
+
 struct cr0014114_led {
-	char			name[LED_MAX_NAME_SIZE];
 	struct cr0014114	*priv;
 	struct led_classdev	ldev;
 	u8			brightness;
@@ -167,8 +167,7 @@ static int cr0014114_set_sync(struct led_classdev *ldev,
 						    struct cr0014114_led,
 						    ldev);
 
-	dev_dbg(led->priv->dev, "Set brightness of %s to %d\n",
-		led->name, brightness);
+	dev_dbg(led->priv->dev, "Set brightness to %d\n", brightness);
 
 	mutex_lock(&led->priv->lock);
 	led->brightness = (u8)brightness;
@@ -183,41 +182,33 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
 	size_t			i = 0;
 	struct cr0014114_led	*led;
 	struct fwnode_handle	*child;
-	struct device_node	*np;
+	struct led_init_data	init_data;
 	int			ret;
-	const char		*str;
 
 	device_for_each_child_node(priv->dev, child) {
-		np = to_of_node(child);
 		led = &priv->leds[i];
+		init_data.fwnode = child;
 
-		ret = fwnode_property_read_string(child, "label", &str);
+		ret = led_compose_name(child, CR_DEV_NAME, ":", init_data.name);
 		if (ret)
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114::");
-		else
-			snprintf(led->name, sizeof(led->name),
-				 "cr0014114:%s", str);
+			return ret;
 
 		fwnode_property_read_string(child, "linux,default-trigger",
 					    &led->ldev.default_trigger);
 
 		led->priv			  = priv;
-		led->ldev.name			  = led->name;
 		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
 		led->ldev.brightness_set_blocking = cr0014114_set_sync;
 
-		ret = devm_led_classdev_register(priv->dev, &led->ldev);
+		ret = devm_led_classdev_register_ext(priv->dev, &led->ldev,
+						     &init_data);
 		if (ret) {
 			dev_err(priv->dev,
-				"failed to register LED device %s, err %d",
-				led->name, ret);
+				"failed to register LED device , err %d", ret);
 			fwnode_handle_put(child);
 			return ret;
 		}
 
-		led->ldev.dev->of_node = np;
-
 		i++;
 	}
 
-- 
2.1.4

