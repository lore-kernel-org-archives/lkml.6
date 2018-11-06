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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B37CC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F0B206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 22:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DylVUDYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F0B206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbeKGHhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:37:20 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39326 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:35:12 -0500
Received: by mail-lf1-f66.google.com with SMTP id n18so10041653lfh.6;
        Tue, 06 Nov 2018 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GB3gxY20jem6M46iNs7NqxnjCbxETvNlptV9dU3sPUk=;
        b=DylVUDYQ2oEQWVv43cy1kz3jA8AZ/LSg4iH07muPy7qjHt7RuThDO9en8pK5gaW32B
         5du+tSDbOqDbZgJmf219mvrfmOQgv37ZrFJAnIingn7/xsVWbpS+ecmDIGTgtE3cpVCK
         nYia1Yw8Te5MvOsYz91UR5q4FGPNnmmkIcsWiR7EEBA7atgovfSDsm8lS8l4nIjxN37m
         2XvSJFfouK9Ni4Ac4R4VtI2G5E60UzfxuWjPaiuf4xqb/1U98z9BHVwLutrLCFd+vTv8
         7NuSWUKcHL0MSPWyxM4ripYcvHp1RR0D3gmf/j60NG2bx/vHcpUnauQ+RX6K4fEl0hul
         Px9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GB3gxY20jem6M46iNs7NqxnjCbxETvNlptV9dU3sPUk=;
        b=RPi1VWxwXIjBtvkjSh3lkJ7EMs/msg8fYrwryYf0PPAZx7LEd2h1x9Mn/DI3j7/yjK
         v0MnjG1Auc198G7MHTKQGziGIN8NCvF0nlQ9xY8ffUIi1dd+L9MSqUkGjtZ7hjbJ+9sD
         GrSugQZYU/hWOk9GMGjc5ZSTezDukWj7yabc0GjqTiEUBqoGgUezXnv5jGnEvcqooHCi
         qkeLyk8hXQVTMTmHIyIgjsaXbhccaqBmq3Xz35QZX9QSPgbkob3Wf4DT21PkaHTA/GJG
         dZwpgR0FmjTc1xYmAq7udzXExT6VLybmPKPLd63EqUujedMaiRwxwpKNfHgB4IUejJYQ
         /Itw==
X-Gm-Message-State: AGRZ1gJ1NEgjYEBFIK2htfSmNhr0awR2xM5u+0Y8pblS+1uhMi0JZIpx
        EsHpqTP6YT2MKRq6RA169Ag4V8Ft
X-Google-Smtp-Source: AJdET5eAzm3OhT1h4tBkIpvUxRe+QuXoEwjCJdlLeespR2oOHohDJxyuiqPsYuW/9Kg3Z7iaWtJqxw==
X-Received: by 2002:a19:4ace:: with SMTP id x197mr15687693lfa.39.1541542065191;
        Tue, 06 Nov 2018 14:07:45 -0800 (PST)
Received: from i4790k.home (bgp86.neoplus.adsl.tpnet.pl. [83.28.79.86])
        by smtp.gmail.com with ESMTPSA id c20sm3185654lfj.67.2018.11.06.14.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 14:07:44 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: [PATCH 01/24] leds: class: Improve LED and LED flash class registration API
Date:   Tue,  6 Nov 2018 23:07:09 +0100
Message-Id: <1541542052-10081-2-git-send-email-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace of_led_classdev_register() with led_classdev_register_ext(), which
accepts easily extendable struct led_init_data, instead of the fixed
struct device_node argument. The latter can be now passed in a fwnode
property of the struct led_init_data.

The modification is driven by the need for passing another argument
to the LED class initialization function - a LED class device name.
Currently it is conveyed in the "name" char pointer property of
struct led_classdev, which is semantically and functionally incorrect
since it is needed only on LED class device registration, but persists
in system memory throughout the whole LED class device lifetime.

Whereas in case of the name strings coming from DT "label" property or
statically initialized ones the cost is only the pointer size, it grows
to LED_MAX_NAME_SIZE (64) with the advent of a new LED class device naming
scheme, where color and function properties come from separate board
firmware properties and the name needs to be constructed in a new buffer.

The change will not break any existing clients since the patch alters
also existing led_classdev{_flash}_register() macro wrappers, that pass
NULL in place of init_data, which leads to using legacy name
initialization path basing on the struct led_classdev's "name" property.

Two existing users of devm_of_led_classdev_registers() are modified
to use devm_led_classdev_register(), which will not impact their
operation since they in fact didn't need to pass struct device_node on
registration from the beginning.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Daniel Mack <daniel@zonque.org>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Oleh Kravchenko <oleg@kaa.org.ua>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Simon Shields <simon@lineageos.org>
Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
---
 drivers/leds/led-class-flash.c  |  9 +++++----
 drivers/leds/led-class.c        | 34 ++++++++++++++++++++++------------
 drivers/leds/leds-cr0014114.c   |  3 +--
 drivers/leds/leds-gpio.c        |  2 +-
 include/linux/led-class-flash.h | 13 +++++++++----
 include/linux/leds.h            | 29 +++++++++++++++++++----------
 6 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
index cf39827..8d1c117 100644
--- a/drivers/leds/led-class-flash.c
+++ b/drivers/leds/led-class-flash.c
@@ -285,8 +285,9 @@ static void led_flash_init_sysfs_groups(struct led_classdev_flash *fled_cdev)
 	led_cdev->groups = flash_groups;
 }
 
-int led_classdev_flash_register(struct device *parent,
-				struct led_classdev_flash *fled_cdev)
+int led_classdev_flash_register_ext(struct device *parent,
+				    struct led_classdev_flash *fled_cdev,
+				    struct led_init_data *init_data)
 {
 	struct led_classdev *led_cdev;
 	const struct led_flash_ops *ops;
@@ -312,13 +313,13 @@ int led_classdev_flash_register(struct device *parent,
 	}
 
 	/* Register led class device */
-	ret = led_classdev_register(parent, led_cdev);
+	ret = led_classdev_register_ext(parent, led_cdev, init_data);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(led_classdev_flash_register);
+EXPORT_SYMBOL_GPL(led_classdev_flash_register_ext);
 
 void led_classdev_flash_unregister(struct led_classdev_flash *fled_cdev)
 {
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 3c7e348..8c80763 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -17,6 +17,7 @@
 #include <linux/leds.h>
 #include <linux/list.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
@@ -244,18 +245,25 @@ static int led_classdev_next_name(const char *init_name, char *name,
 }
 
 /**
- * of_led_classdev_register - register a new object of led_classdev class.
+ * led_classdev_register_ext - register a new object of led_classdev class.
  *
  * @parent: parent of LED device
  * @led_cdev: the led_classdev structure for this device.
- * @np: DT node describing this LED
+ * @init_data: LED class device initialization data
  */
-int of_led_classdev_register(struct device *parent, struct device_node *np,
-			    struct led_classdev *led_cdev)
+int led_classdev_register_ext(struct device *parent,
+			      struct led_classdev *led_cdev,
+			      struct led_init_data *init_data)
 {
 	char name[LED_MAX_NAME_SIZE];
 	int ret;
 
+	if (init_data && init_data->name) {
+		led_cdev->name = init_data->name;
+	} else {
+		dev_info(parent, "init_data not available");
+	}
+
 	ret = led_classdev_next_name(led_cdev->name, name, sizeof(name));
 	if (ret < 0)
 		return ret;
@@ -268,7 +276,8 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 		mutex_unlock(&led_cdev->led_access);
 		return PTR_ERR(led_cdev->dev);
 	}
-	led_cdev->dev->of_node = np;
+	if (init_data && init_data->fwnode)
+		led_cdev->dev->of_node = to_of_node(init_data->fwnode);
 
 	if (ret)
 		dev_warn(parent, "Led %s renamed to %s due to name collision",
@@ -313,7 +322,7 @@ int of_led_classdev_register(struct device *parent, struct device_node *np,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(of_led_classdev_register);
+EXPORT_SYMBOL_GPL(led_classdev_register_ext);
 
 /**
  * led_classdev_unregister - unregisters a object of led_properties class.
@@ -358,14 +367,15 @@ static void devm_led_classdev_release(struct device *dev, void *res)
 }
 
 /**
- * devm_of_led_classdev_register - resource managed led_classdev_register()
+ * devm_led_classdev_register_ext - resource managed led_classdev_register_ext()
  *
  * @parent: parent of LED device
  * @led_cdev: the led_classdev structure for this device.
+ * @init_data: LED class device initialization data
  */
-int devm_of_led_classdev_register(struct device *parent,
-				  struct device_node *np,
-				  struct led_classdev *led_cdev)
+int devm_led_classdev_register_ext(struct device *parent,
+				   struct led_classdev *led_cdev,
+				   struct led_init_data *init_data)
 {
 	struct led_classdev **dr;
 	int rc;
@@ -374,7 +384,7 @@ int devm_of_led_classdev_register(struct device *parent,
 	if (!dr)
 		return -ENOMEM;
 
-	rc = of_led_classdev_register(parent, np, led_cdev);
+	rc = led_classdev_register_ext(parent, led_cdev, init_data);
 	if (rc) {
 		devres_free(dr);
 		return rc;
@@ -385,7 +395,7 @@ int devm_of_led_classdev_register(struct device *parent,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(devm_of_led_classdev_register);
+EXPORT_SYMBOL_GPL(devm_led_classdev_register_ext);
 
 static int devm_led_classdev_match(struct device *dev, void *res, void *data)
 {
diff --git a/drivers/leds/leds-cr0014114.c b/drivers/leds/leds-cr0014114.c
index 0e42624..1c82152 100644
--- a/drivers/leds/leds-cr0014114.c
+++ b/drivers/leds/leds-cr0014114.c
@@ -207,8 +207,7 @@ static int cr0014114_probe_dt(struct cr0014114 *priv)
 		led->ldev.max_brightness	  = CR_MAX_BRIGHTNESS;
 		led->ldev.brightness_set_blocking = cr0014114_set_sync;
 
-		ret = devm_of_led_classdev_register(priv->dev, np,
-						    &led->ldev);
+		ret = devm_led_classdev_register(priv->dev, &led->ldev);
 		if (ret) {
 			dev_err(priv->dev,
 				"failed to register LED device %s, err %d",
diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index 32fa752..c87fbd3 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -112,7 +112,7 @@ static int create_gpio_led(const struct gpio_led *template,
 	if (ret < 0)
 		return ret;
 
-	return devm_of_led_classdev_register(parent, np, &led_dat->cdev);
+	return devm_led_classdev_register(parent, &led_dat->cdev);
 }
 
 struct gpio_leds_priv {
diff --git a/include/linux/led-class-flash.h b/include/linux/led-class-flash.h
index 700efaa..28a73d0 100644
--- a/include/linux/led-class-flash.h
+++ b/include/linux/led-class-flash.h
@@ -90,15 +90,20 @@ static inline struct led_classdev_flash *lcdev_to_flcdev(
 }
 
 /**
- * led_classdev_flash_register - register a new object of led_classdev class
- *				 with support for flash LEDs
+ * fwnode_led_classdev_flash_register - register a new object of led_classdev
+ *					class with support for flash LEDs
  * @parent: the flash LED to register
+ * @fwnode: the flash LED fwnode handle
  * @fled_cdev: the led_classdev_flash structure for this device
  *
  * Returns: 0 on success or negative error value on failure
  */
-extern int led_classdev_flash_register(struct device *parent,
-				struct led_classdev_flash *fled_cdev);
+extern int led_classdev_flash_register_ext(struct device *parent,
+					struct led_classdev_flash *fled_cdev,
+					struct led_init_data *init_data);
+
+#define led_classdev_flash_register(parent, fled_cdev)		\
+	led_classdev_flash_register_ext(parent, fled_cdev, NULL)
 
 /**
  * led_classdev_flash_unregister - unregisters an object of led_classdev class
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 834683d..646c49a 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -20,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <uapi/linux/uleds.h>
 
 struct device;
 /*
@@ -33,6 +34,13 @@ enum led_brightness {
 	LED_FULL	= 255,
 };
 
+struct led_init_data {
+	/* Device fwnode handle */
+	struct fwnode_handle *fwnode;
+	/* Requested LED class device name */
+	char name[LED_MAX_NAME_SIZE];
+};
+
 struct led_classdev {
 	const char		*name;
 	enum led_brightness	 brightness;
@@ -73,6 +81,7 @@ struct led_classdev {
 	 */
 	int (*brightness_set_blocking)(struct led_classdev *led_cdev,
 				       enum led_brightness brightness);
+
 	/* Get LED brightness level */
 	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
 
@@ -123,16 +132,16 @@ struct led_classdev {
 	struct mutex		led_access;
 };
 
-extern int of_led_classdev_register(struct device *parent,
-				    struct device_node *np,
-				    struct led_classdev *led_cdev);
-#define led_classdev_register(parent, led_cdev)				\
-	of_led_classdev_register(parent, NULL, led_cdev)
-extern int devm_of_led_classdev_register(struct device *parent,
-					 struct device_node *np,
-					 struct led_classdev *led_cdev);
-#define devm_led_classdev_register(parent, led_cdev)			\
-	devm_of_led_classdev_register(parent, NULL, led_cdev)
+extern int led_classdev_register_ext(struct device *parent,
+				     struct led_classdev *led_cdev,
+				     struct led_init_data *init_data);
+#define led_classdev_register(parent, led_cdev)			\
+	led_classdev_register_ext(parent, led_cdev, NULL)
+extern int devm_led_classdev_register_ext(struct device *parent,
+					  struct led_classdev *led_cdev,
+					  struct led_init_data *init_data);
+#define devm_led_classdev_register(parent, led_cdev)		\
+	devm_led_classdev_register_ext(parent, led_cdev, NULL)
 extern void led_classdev_unregister(struct led_classdev *led_cdev);
 extern void devm_led_classdev_unregister(struct device *parent,
 					 struct led_classdev *led_cdev);
-- 
2.1.4

