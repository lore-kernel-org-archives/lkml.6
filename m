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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D685C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30F206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUFjFp3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F30F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388067AbeKGHfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:21 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43372 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbeKGHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:20 -0500
Received: by mail-lj1-f195.google.com with SMTP id g26-v6so12919378lja.10;
        Tue, 06 Nov 2018 14:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+aYPUQtT/PUbh74u9dlmEfw7mrapm0u94rZngJrruH8=;
        b=MUFjFp3kTXWyIVMJzu+yELXbh+N4AK4H0Zb0waE8YtFs6BcFhHn2vigUxuqYncEC71
         o9AnCgF2n8ekK+yGyXO80XTQoJafMntUQxZdifX+hFZRsb0PpBEdhdKYhdl+soScaQ/d
         +Nja5T/bB0VdlBlddqdhky17SivA5huIYkaLq+5UxCf/Ny72millmcJe3oxUR61uC0G8
         cIfELKJskcbpqjVBRaPe5p+2WqKt37T4BVFkCcuCDkf7hHmi44McWwPypYdkdLbKidS1
         RuI6vxintUh/64V3vgJKZvfLvIVDt8oAznuyf4azbeNRv5eSZNxF/WcxPOANmipeCviw
         LZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+aYPUQtT/PUbh74u9dlmEfw7mrapm0u94rZngJrruH8=;
        b=CzDtzC7jVwXY6e08Vcg7/w2a3D7qIt8UhPxDdgQJuMOGUXjHA8MSTpH/rjgsVKvbPG
         lFX+1p3bfKnkf5stee4FmNtGMU2gHqaOrJC8fed+zqyCCX83N3YIYleUfnMHx8Frgt1T
         ex8sjw4lrl4Ju7aKokcoGC8/Kty/n6mxOCAicJFWhR41qz0WwhC0LTarA90ItowbyQlu
         duG2ImxnweM1Yz4ptds6HEy8wxxgKbQPvuN2ONQxL+QE8CRDG9W6PrPBHohLe/IGijsL
         DsGrmopNPuZluksCNtyp19szTO3dy7mhIBXhsFiBXVuZCpRU0zbN3WZnZEPgUStUHjS8
         3RbA==
X-Gm-Message-State: AGRZ1gLKV8X13FTZMHsFnJSZ4Rhp0dRs3HamA3zsnmdnGZIKLJviXWV2
        YfgPOvKjtotr2jUbKhvaSStkvisZ
X-Google-Smtp-Source: AJdET5edTp+k0ph7g6vCKXMCG+XKqf59yjs6imx6BBXgrUj6/tiY+z0ZpKaoKCeUrBGn4CPtBVVP9w==
X-Received: by 2002:a2e:5703:: with SMTP id l3-v6mr17002565ljb.106.1541542075650;
        Tue, 06 Nov 2018 14:07:55 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:55 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 06/24] leds: sc27xx-blt: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:14 +0100
Message-Id: <1541542052-10081-7-git-send-email-jacek.anaszewski@gmail.com>
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
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/leds/leds-sc27xx-bltc.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-sc27xx-bltc.c b/drivers/leds/leds-sc27xx-bltc.c
index 9d9b7aa..9fe7cb1 100644
--- a/drivers/leds/leds-sc27xx-bltc.c
+++ b/drivers/leds/leds-sc27xx-bltc.c
@@ -6,7 +6,6 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
-#include <uapi/linux/uleds.h>
 
 /* PMIC global control register definition */
 #define SC27XX_MODULE_EN0	0xc08
@@ -36,7 +35,7 @@
 #define SC27XX_LEDS_MAX		3
 
 struct sc27xx_led {
-	char name[LED_MAX_NAME_SIZE];
+	struct fwnode_handle *fwnode;
 	struct led_classdev ldev;
 	struct sc27xx_led_priv *priv;
 	u8 line;
@@ -132,16 +131,22 @@ static int sc27xx_led_register(struct device *dev, struct sc27xx_led_priv *priv)
 
 	for (i = 0; i < SC27XX_LEDS_MAX; i++) {
 		struct sc27xx_led *led = &priv->leds[i];
+		struct led_init_data init_data = { led->fwnode };
 
 		if (!led->active)
 			continue;
 
+		err = led_compose_name(led->fwnode, "sc27xx", ":",
+				       init_data.name);
+		if (err)
+			return err;
+
 		led->line = i;
 		led->priv = priv;
-		led->ldev.name = led->name;
 		led->ldev.brightness_set_blocking = sc27xx_led_set;
 
-		err = devm_led_classdev_register(dev, &led->ldev);
+		err = devm_led_classdev_register_ext(dev, &led->ldev,
+						     &init_data);
 		if (err)
 			return err;
 	}
@@ -154,7 +159,6 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node, *child;
 	struct sc27xx_led_priv *priv;
-	const char *str;
 	u32 base, count, reg;
 	int err;
 
@@ -196,15 +200,8 @@ static int sc27xx_led_probe(struct platform_device *pdev)
 			return -EINVAL;
 		}
 
+		priv->leds[reg].fwnode = of_fwnode_handle(child);
 		priv->leds[reg].active = true;
-
-		err = of_property_read_string(child, "label", &str);
-		if (err)
-			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
-				 "sc27xx::");
-		else
-			snprintf(priv->leds[reg].name, LED_MAX_NAME_SIZE,
-				 "sc27xx:%s", str);
 	}
 
 	err = sc27xx_led_register(dev, priv);
-- 
2.1.4

