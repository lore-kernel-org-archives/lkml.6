Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IWsGNgzeG1sYUQAAmS7hNA
	; Sat, 09 Jun 2018 14:02:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2B2C608BF; Sat,  9 Jun 2018 14:02:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpC8CwSU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2504B6074D;
	Sat,  9 Jun 2018 14:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2504B6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753351AbeFIOCu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 10:02:50 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42628 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIOCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 10:02:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id v135-v6so24168436lfa.9;
        Sat, 09 Jun 2018 07:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mOjLsJfnKdGMrPPfSAYY48IQW/M2iyitMXHZcPfc+Bc=;
        b=DpC8CwSUS27YBAwqW1vSudxGoz7qmAyZVRlDW/MsOO639ld5s8YSbRfb0uzIGU31A0
         fRijTPxPeiItH196pEdxaVfpFFvQMPrsbVmT/0tfRfzz9+S6i7pVt7t1/J6YGKiBRz8o
         efodSyuwLLfKauC9/85w5V175rokr+cmkDEh3QlFbXlW3AXILFcns3IS2ZQyhLAP38cW
         J9d4rWJ+IMSDaWtrIonno+l9OPXdJo9q66HtDvc7PNRoBW081Yw+MM85UA2D5CdBzHVi
         VhEh3CCCOyR0m/sN+PHheXCZgJHIqt2Q5hivVunDFVcV44l1afyqrb6SCPNStoBP53Cu
         V9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mOjLsJfnKdGMrPPfSAYY48IQW/M2iyitMXHZcPfc+Bc=;
        b=kIBa+iHgqjlYikXW9+yCPqC2vkO3b13AvAwos3voPC0xlH0yJcbVOO3kRXibnFxhhy
         YowX+3ZzEql7aiMU4CJ7rEAWcd/2BL3Mgd+CvDX6X4eFK3CzpvzgjrmiG2fzQScEWKcG
         UgJ3pOcLj/jEH0XjG9XaIQ2Yzxpj+cQfD3ARfn6QA7O0JmCZmHEZ7aQifZQlpBCNKI7P
         9Oq2fczB6ydjtCRP8qL7wGRAQLviVePlSU5d7dYLi1xxdc/Y0BlTnKJ1vGuxes6hjkz2
         hBfqaxPLnBK0y697uABcAZl6iPHvI49YpXGA5ZFW0+XddwoWNIaTd8+Hn403PpcVYBPN
         67Hw==
X-Gm-Message-State: APt69E2+4dZNj660du1VZLO07CutwYBMCe3hoNKZQkh7oROiJct5b8PO
        wbHb9UKGbgEW6oamlG59V/o=
X-Google-Smtp-Source: ADUXVKKgdijZdWPTDV0itN7GLvBHpgCGKWt8sjcomNosd+E1zwWYYwvwv2ZkdRQ79MYGybG3In175g==
X-Received: by 2002:a19:cc4b:: with SMTP id c72-v6mr6676158lfg.30.1528552963947;
        Sat, 09 Jun 2018 07:02:43 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-40-98.dynamic.gprs.plus.pl. [31.0.40.98])
        by smtp.gmail.com with ESMTPSA id n84-v6sm4477727lfi.19.2018.06.09.07.02.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Jun 2018 07:02:43 -0700 (PDT)
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 02/10] Input: ams_delta_serio: convert to platform driver
Date: Sat,  9 Jun 2018 16:02:16 +0200
Message-Id: <20180609140224.32606-2-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180609140224.32606-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the driver to an "ams-delta-serio" platform driver.  For it to
be used with Amstrad Delta, register an "ams-delta-serio" platform
device from the board init file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
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
2.16.1
