Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29297C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAD52148D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 11:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KAZ9VcvV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAD52148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeIWROl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 13:14:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37095 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeIWROl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 13:14:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so16875741wrr.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 04:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=1m0YyAtxJOgDdSvDgUSwdK7l8EcqEmjPAMMrfTja28w=;
        b=KAZ9VcvVpy3LN/667gyN/UKxEuiYn6tEpJN4bbw+OVxgWufVoniUwrRtiNlG1S8KQU
         UiSzStsYc4PkL/0HjaHeW/WuCDKF0dPEyAu7dTX5IYnZSFU+3qVRI+YHdlezIoH3Ca4q
         zV0EhJizhv+/BGAxy6xdyPcTG0cxtEognrkpkUwS+TgUJjciVk26IWEKf1iTMhe7RW2b
         jI6INgG4GMZbfcTu9LAxTLgClTjZePKJzD0CjV79KRWAIjkIM8onEF2LOVYolr88/7Dw
         CZ7LiJ+LVMXqAmdEb7MuL1B8J2vlsSp/JLbiJtyooSCS8VDlgpjpl5e9O3QygfXdBCa/
         UeHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1m0YyAtxJOgDdSvDgUSwdK7l8EcqEmjPAMMrfTja28w=;
        b=l/lbpNlA90LJN3HKKZZqDt4X/lDzqJ7LRTu2cWho8iqZyO5PLiS1PfoMyt8ZSSYKbY
         9T48Bp0qcL5vK67uBDiP9x/jqpKSZVBdD9HWF8dJ3wk+oz0THRP4/OY6sU52xVJVZHye
         o8dLP+fUTAOOkK3ZvefCnFiek/q3+pMWU0fFlf9/wPWYiFbdW+cBa6NPFprKdtUQOFeO
         bMGPdB7X3K9nwJgafRwpT8DWCiouPz4LW5iFnYssPjoUFTdUQZXqLn3RCU2Isd1Q9n7K
         bWWh4JEwVI/NryYKkKodNX3YZ5Xnn8k1ISHmCnBVZpbg824cZJ9VNgE+ambdCx1wfMHf
         vJZw==
X-Gm-Message-State: ABuFfoiG+eo5LmENbZJ5zGjWfD9v1fAgtaIQhGyctzzmjhGSGl+PYgMQ
        5cTktRkPYppvCpxViatGBuNcBw==
X-Google-Smtp-Source: ACcGV63eNMYRiWBJ/PDDVgChvhSWcvB5QD9Yj3NKtsnmfoK3djF0gsKscolV729VoxERBQLIw2f0gA==
X-Received: by 2002:adf:e603:: with SMTP id p3-v6mr1970200wrm.254.1537701451542;
        Sun, 23 Sep 2018 04:17:31 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id a1-v6sm5241800wrt.9.2018.09.23.04.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 04:17:30 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] gpio: mockup: use device properties instead of platform_data
Date:   Sun, 23 Sep 2018 13:17:27 +0200
Message-Id: <20180923111727.10378-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users want to introduce device tree support to the mockup driver.
Let's make it easier by switching to using generic device properties.
The driver stays compatible with previous use cases and after this
conversion there'll be no need to change the way probing of mockup
GPIO chips works.

Tested with libgpiod test suite.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/gpio/gpio-mockup.c | 82 ++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index d66b7a768ecd..4e66bd83b76c 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -18,6 +18,7 @@
 #include <linux/irq_sim.h>
 #include <linux/debugfs.h>
 #include <linux/uaccess.h>
+#include <linux/property.h>
 
 #include "gpiolib.h"
 
@@ -28,6 +29,8 @@
  * of GPIO lines.
  */
 #define GPIO_MOCKUP_MAX_RANGES	(GPIO_MOCKUP_MAX_GC * 2)
+/* Maximum of three properties + the sentinel. */
+#define GPIO_MOCKUP_MAX_PROP	4
 
 #define gpio_mockup_err(...)	pr_err(GPIO_MOCKUP_NAME ": " __VA_ARGS__)
 
@@ -59,13 +62,6 @@ struct gpio_mockup_dbgfs_private {
 	int offset;
 };
 
-struct gpio_mockup_platform_data {
-	int base;
-	int ngpio;
-	int index;
-	bool named_lines;
-};
-
 static int gpio_mockup_ranges[GPIO_MOCKUP_MAX_RANGES];
 static int gpio_mockup_num_ranges;
 module_param_array(gpio_mockup_ranges, int, &gpio_mockup_num_ranges, 0400);
@@ -255,26 +251,37 @@ static int gpio_mockup_name_lines(struct device *dev,
 
 static int gpio_mockup_probe(struct platform_device *pdev)
 {
-	struct gpio_mockup_platform_data *pdata;
 	struct gpio_mockup_chip *chip;
 	struct gpio_chip *gc;
-	int rv, base, ngpio;
 	struct device *dev;
-	char *name;
+	const char *name;
+	int rv, base;
+	u16 ngpio;
 
 	dev = &pdev->dev;
-	pdata = dev_get_platdata(dev);
-	base = pdata->base;
-	ngpio = pdata->ngpio;
+
+	rv = device_property_read_u32(dev, "gpio-base", &base);
+	if (rv && rv == -ENOENT)
+		base = -1;
+
+	rv = device_property_read_u16(dev, "nr-gpios", &ngpio);
+	if (rv)
+		return rv;
+
+	rv = device_property_read_string(dev, "chip-name", &name);
+	if (rv)
+		name = NULL;
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "%s-%c",
-			      pdev->name, pdata->index);
-	if (!name)
-		return -ENOMEM;
+	if (!name) {
+		name = devm_kasprintf(dev, GFP_KERNEL,
+				      "%s-%c", pdev->name, pdev->id + 'A');
+		if (!name)
+			return -ENOMEM;
+	}
 
 	gc = &chip->gc;
 	gc->base = base;
@@ -295,7 +302,7 @@ static int gpio_mockup_probe(struct platform_device *pdev)
 	if (!chip->lines)
 		return -ENOMEM;
 
-	if (pdata->named_lines) {
+	if (device_property_read_bool(dev, "named-gpio-lines")) {
 		rv = gpio_mockup_name_lines(dev, chip);
 		if (rv)
 			return rv;
@@ -339,9 +346,11 @@ static void gpio_mockup_unregister_pdevs(void)
 
 static int __init gpio_mockup_init(void)
 {
-	int i, num_chips, err = 0, index = 'A';
-	struct gpio_mockup_platform_data pdata;
+	struct property_entry properties[GPIO_MOCKUP_MAX_PROP];
+	int i, prop, num_chips, err = 0, base;
+	struct platform_device_info pdevinfo;
 	struct platform_device *pdev;
+	u16 ngpio;
 
 	if ((gpio_mockup_num_ranges < 2) ||
 	    (gpio_mockup_num_ranges % 2) ||
@@ -371,17 +380,28 @@ static int __init gpio_mockup_init(void)
 	}
 
 	for (i = 0; i < num_chips; i++) {
-		pdata.index = index++;
-		pdata.base = gpio_mockup_range_base(i);
-		pdata.ngpio = pdata.base < 0
-				? gpio_mockup_range_ngpio(i)
-				: gpio_mockup_range_ngpio(i) - pdata.base;
-		pdata.named_lines = gpio_mockup_named_lines;
-
-		pdev = platform_device_register_resndata(NULL,
-							 GPIO_MOCKUP_NAME,
-							 i, NULL, 0, &pdata,
-							 sizeof(pdata));
+		memset(properties, 0, sizeof(properties));
+		memset(&pdevinfo, 0, sizeof(pdevinfo));
+		prop = 0;
+
+		base = gpio_mockup_range_base(i);
+		if (base >= 0)
+			properties[prop++] = PROPERTY_ENTRY_U32("gpio-base",
+								base);
+
+		ngpio = base < 0 ? gpio_mockup_range_ngpio(i)
+				 : gpio_mockup_range_ngpio(i) - base;
+		properties[prop++] = PROPERTY_ENTRY_U16("nr-gpios", ngpio);
+
+		if (gpio_mockup_named_lines)
+			properties[prop++] = PROPERTY_ENTRY_BOOL(
+						"named-gpio-lines");
+
+		pdevinfo.name = GPIO_MOCKUP_NAME;
+		pdevinfo.id = i;
+		pdevinfo.properties = properties;
+
+		pdev = platform_device_register_full(&pdevinfo);
 		if (IS_ERR(pdev)) {
 			gpio_mockup_err("error registering device");
 			platform_driver_unregister(&gpio_mockup_driver);
-- 
2.18.0

