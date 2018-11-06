Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F68C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2675F2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GB4854oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2675F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388917AbeKGHfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:35:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46022 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388627AbeKGHfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so10027089lfa.12;
        Tue, 06 Nov 2018 14:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ww2hpLfDLKDvjl1uIL7lVH48m7tb1vI3NB9tcxovGu0=;
        b=GB4854oXXCXXFK75+d4JcZgoMj9nyW0kTZ7MT+i9yuDiVpCeuq5416LV87IRDwlzoe
         Z0lmNvJ+KSkgC7WwNzNv8PPf3DPWXVzxQnRu4ZdYfbsyVbXvQVxBtyD6XHyPHp9zb0ak
         5LgVVwCb2jCuKX8yTNg9vfqnyc8c5VEvJKsokUNUXH+Pzae2vdMd7gCysdUPxt2XxWgA
         mIOj3DvEIqobd7p9QBUg5lD7678MVowk9KgvteHwhylffLMKBC7xltySL3efGWmR/WHr
         hkEeNT6xTTptRalFe2pWgNhvbTj3BJrauIIegsgWmgjH7t5d62ooYqcsP0NIqq3AYVa0
         btlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ww2hpLfDLKDvjl1uIL7lVH48m7tb1vI3NB9tcxovGu0=;
        b=HvII6M1n2bogculA+z+HACEnmbfyIrcbFEGyId/W03Q94s/E8MZk4GG31jI7+YAk7r
         gg3QpckIIe1gU4F5IgwybAh/RLVPUwRlag9RzJ27SgA47wkEhSxFzOXlMqCqKM2qB435
         uAg1n4cdQIpO4G88fsoTMC/Vzd2tgKBoxEtuIliyIsrrFzqGdtknhKi7kgYSfGIgmQ0R
         4u1O3QRoI3rOo6lCX8mfvy5otHESchgJebmQCi+/rr3xmRwY83yYVmCg47wqCCbDrpHf
         TLyK0qvWOv/Q56DkEZubOzh6zewZcZywAHCld8bEHfHuBi2QOgdSxWfwIU9WdzCbQvDI
         7mLw==
X-Gm-Message-State: AGRZ1gIpFLwP95Of1z42XCjyQRSm+8iSYggsBGfZ2Eb8StqEA3vtpR/R
        Yd3mecSgeOpYH7LWCMOEK2bnKOtugv8=
X-Google-Smtp-Source: AJdET5fLfY6b693X9cwnpE+LZzLpOq0hpc2JiKeFCrZz+r1KEkw2PiE93ZKlypa16324aaLqiyoEVA==
X-Received: by 2002:ac2:4299:: with SMTP id m25-v6mr16005307lfh.115.1541542096660;
        Tue, 06 Nov 2018 14:08:16 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:08:16 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com
Subject: [PATCH 18/24] leds: aat1290: Use led_compose_name()
Date:   Tue,  6 Nov 2018 23:07:26 +0100
Message-Id: <1541542052-10081-19-git-send-email-jacek.anaszewski@gmail.com>
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
---
 drivers/leds/leds-aat1290.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-aat1290.c b/drivers/leds/leds-aat1290.c
index 43bd8a4..9132a6e 100644
--- a/drivers/leds/leds-aat1290.c
+++ b/drivers/leds/leds-aat1290.c
@@ -45,6 +45,8 @@
 #define AAT1290_FLASH_TM_NUM_LEVELS	16
 #define AAT1290_MM_CURRENT_SCALE_SIZE	15
 
+#define AAT1290_NAME			"aat1290"
+
 
 struct aat1290_led_config_data {
 	/* maximum LED current in movie mode */
@@ -78,7 +80,6 @@ struct aat1290_led {
 	int *mm_current_scale;
 	/* device mode */
 	bool movie_mode;
-
 	/* brightness cache */
 	unsigned int torch_brightness;
 };
@@ -218,7 +219,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
 			struct aat1290_led_config_data *cfg,
 			struct device_node **sub_node)
 {
-	struct led_classdev *led_cdev = &led->fled_cdev.led_cdev;
 	struct device *dev = &led->pdev->dev;
 	struct device_node *child_node;
 #if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
@@ -257,9 +257,6 @@ static int aat1290_led_parse_dt(struct aat1290_led *led,
 		return -EINVAL;
 	}
 
-	led_cdev->name = of_get_property(child_node, "label", NULL) ? :
-						child_node->name;
-
 	ret = of_property_read_u32(child_node, "led-max-microamp",
 				&cfg->max_mm_current);
 	/*
@@ -469,6 +466,7 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	struct aat1290_led *led;
 	struct led_classdev *led_cdev;
 	struct led_classdev_flash *fled_cdev;
+	struct led_init_data init_data;
 	struct aat1290_led_config_data led_cfg = {};
 	struct v4l2_flash_config v4l2_sd_cfg = {};
 	int ret;
@@ -488,6 +486,12 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	init_data.fwnode = of_fwnode_handle(sub_node);
+	ret = led_compose_name(init_data.fwnode, AAT1290_NAME, NULL,
+			       init_data.name);
+	if (ret < 0)
+		return ret;
+
 	mutex_init(&led->lock);
 
 	/* Initialize LED Flash class device */
@@ -498,7 +502,8 @@ static int aat1290_led_probe(struct platform_device *pdev)
 	aat1290_init_flash_timeout(led, &led_cfg);
 
 	/* Register LED Flash class device */
-	ret = led_classdev_flash_register(&pdev->dev, fled_cdev);
+	ret = led_classdev_flash_register_ext(&pdev->dev, fled_cdev,
+					      &init_data);
 	if (ret < 0)
 		goto err_flash_register;
 
-- 
2.1.4

