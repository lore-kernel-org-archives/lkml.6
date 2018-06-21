Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27B3C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934B8224DA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvTE71xc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934B8224DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933978AbeFUWmR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:42:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40940 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933653AbeFUWmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:15 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so6615317lfc.7;
        Thu, 21 Jun 2018 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IkWEj4MJxmai4vzpckcnzaQtnDAXgiUEdfdEKzLaXHw=;
        b=nvTE71xcUSgZPqP7M+tYjjtVkemrE7M/AazT9wt5E6tM0cp4H1EBWTjTdnG6jOwVZn
         /LwpkBx4zkBpBSIEl7EVQNZulyewyIHl6A2iFV/lA8IsrcdTXLO2jznutx2DOdzXpBAZ
         cdLGDBCdGv0sGeN0fpWesHL2Q6tf9tyVYHYN+h7JA7sYHIKVSmR9SugpGQLjOhv2rAvA
         YHotBmByEoSbhg6nWmvIbKD60rWL6rNE8qOQ9luQa1iyKUFRfkSXDf2YpagRkbLP8mvm
         r0ZSImNPS+GLFnRSKZFxXbXtkNIbw9Ux7tHezJEQjEwnJrudifqI1UuItWLJYwiH5BQj
         q0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IkWEj4MJxmai4vzpckcnzaQtnDAXgiUEdfdEKzLaXHw=;
        b=cyrTgObVaLjpwkAwFERBR6X1WCK0UfIbvX+tiFENmqmmt9vE+DnARAoNKc3QAc1+8h
         WC9XIggK7MoS0YIJbOHPzbIBi9KL+0C0XDY0EE+Awdqobw6SZo00ZA0wPiX+P6PiV7Jn
         RQuBNdCOMeTHiWKFUZU2D+QODozXofErObta4yYEgFxtG5ASL+2LYwta2QBoqH1288iP
         6X16vlSRk8uMbkgM3sbOtN+vsgb/jDmBHufA2oN4A7A3wQIacD+HxR3TwPhsgAyUB48f
         U+uWHWezyVtPbiqfNudoI9pevAldCQugPO1Y1HnEZgsSHUj90hUM5ZRYXTnapfHC/jJk
         Sb2g==
X-Gm-Message-State: APt69E0jf9JJV7wA0rQDQDHdW8NZIbKfnIlq+lR2rBza3/deu7ksMJeX
        Sog2mVpLo0lS/0gwBBpZCT4=
X-Google-Smtp-Source: ADUXVKKyt73FhuBnG2oHHXpDygyglzT8zH0+YtqSv56qLszEJgOodRSmm1OJz+vTBTmI9HZHw6v9Lw==
X-Received: by 2002:a2e:6e19:: with SMTP id j25-v6mr18941369ljc.61.1529620933308;
        Thu, 21 Jun 2018 15:42:13 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:12 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 02/10] Input: ams_delta_serio: convert to platform driver
Date:   Fri, 22 Jun 2018 00:41:20 +0200
Message-Id: <20180621224128.17623-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to an "ams-delta-serio" platform driver.  For it to
be used with Amstrad Delta, register an "ams-delta-serio" platform
device from the board init file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 arch/arm/mach-omap1/board-ams-delta.c |  6 ++++++
 drivers/input/serio/ams_delta_serio.c | 34 +++++++++++++++++++++-------------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 18e0ff437b27..2119d2d3ba84 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -504,12 +504,18 @@ static struct platform_device cx20442_codec_device = {
 	.id     = -1,
 };
 
+static struct platform_device ams_delta_serio_device = {
+	.name		= "ams-delta-serio",
+	.id		= PLATFORM_DEVID_NONE,
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
 	&ams_delta_kp_device,
 	&ams_delta_camera_device,
 	&ams_delta_audio_device,
+	&ams_delta_serio_device,
 };
 
 static struct platform_device *late_devices[] __initdata = {
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 3df501c3421b..a2a7fa19bf49 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -22,15 +22,17 @@
  */
 #include <linux/gpio.h>
 #include <linux/irq.h>
+#include <linux/platform_device.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
-#include <asm/mach-types.h>
 #include <mach/board-ams-delta.h>
 
 #include <mach/ams-delta-fiq.h>
 
+#define DRIVER_NAME	"ams-delta-serio"
+
 MODULE_AUTHOR("Matt Callow");
 MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
 MODULE_LICENSE("GPL");
@@ -126,13 +128,10 @@ static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 	},
 };
 
-static int __init ams_delta_serio_init(void)
+static int ams_delta_serio_init(struct platform_device *pdev)
 {
 	int err;
 
-	if (!machine_is_ams_delta())
-		return -ENODEV;
-
 	ams_delta_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
 	if (!ams_delta_serio)
 		return -ENOMEM;
@@ -142,22 +141,22 @@ static int __init ams_delta_serio_init(void)
 	ams_delta_serio->close = ams_delta_serio_close;
 	strlcpy(ams_delta_serio->name, "AMS DELTA keyboard adapter",
 			sizeof(ams_delta_serio->name));
-	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
+	strlcpy(ams_delta_serio->phys, dev_name(&pdev->dev),
 			sizeof(ams_delta_serio->phys));
+	ams_delta_serio->dev.parent = &pdev->dev;
 
 	err = gpio_request_array(ams_delta_gpios,
 				ARRAY_SIZE(ams_delta_gpios));
 	if (err) {
-		pr_err("ams_delta_serio: Couldn't request gpio pins\n");
+		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
 		goto serio;
 	}
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
 			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
-			"ams-delta-serio", 0);
+			DRIVER_NAME, 0);
 	if (err < 0) {
-		pr_err("ams_delta_serio: couldn't request gpio interrupt %d\n",
-				gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
+		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
 		goto gpio;
 	}
 	/*
@@ -179,13 +178,22 @@ static int __init ams_delta_serio_init(void)
 	kfree(ams_delta_serio);
 	return err;
 }
-module_init(ams_delta_serio_init);
 
-static void __exit ams_delta_serio_exit(void)
+static int ams_delta_serio_exit(struct platform_device *pdev)
 {
 	serio_unregister_port(ams_delta_serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
 	gpio_free_array(ams_delta_gpios,
 			ARRAY_SIZE(ams_delta_gpios));
+
+	return 0;
 }
-module_exit(ams_delta_serio_exit);
+
+static struct platform_driver ams_delta_serio_driver = {
+	.probe	= ams_delta_serio_init,
+	.remove	= ams_delta_serio_exit,
+	.driver	= {
+		.name	= DRIVER_NAME
+	},
+};
+module_platform_driver(ams_delta_serio_driver);
-- 
2.16.4

