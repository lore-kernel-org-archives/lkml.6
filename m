Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769972183E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSFaGOsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfAGQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:31:06 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45625 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAGQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:31:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so826709ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 08:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UW2WZmeMtUaU2nXUV/7Mo8+YZpT2Xc7AWu8kKBjtZUY=;
        b=VSFaGOsa75OWwHWhMUcRIuCvtUOXn9KBxk6riS+F8lig6FRfz0N/UTrqfShr8PYMdS
         tZdeZLjrc+Oy7VUwDtXXgF2wHoMuSfvFKaEEW6nOBXPYn8r8Rm2+s9SfFOg8phHeSnx4
         Gdw+YbMxol0Q+saNmDDU2eJsMjIaMM4H8SCKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UW2WZmeMtUaU2nXUV/7Mo8+YZpT2Xc7AWu8kKBjtZUY=;
        b=OeX3cQ9VXVbITKEaUg0IlAma73EAlBubpyZmC39n2iT5xWNq/WdLu2lhkAVXojNVWB
         SicgJAi70An4e/Yz2h8lJMReoAQD0+91I3clz7N7VazVz3SmYcUz3MjG5xjutwr0+CB+
         hRKS777xHPSMBL6QuQ12YmJgl4pxgE0dQH+dkiSzcVgUI7sYt9z6+3X9YYUUNLxLOxO1
         4mfn01W5lFlq+5hhOFmkFfoU3rWNmoMrE2tt5qQ7O8pqbS584UwwHkIXTS2gxdSvA8nJ
         Y8aGA5LJWo9ytjioJ3nicKhD87zjcZDDqosUCwdxWnr2PGxN7Prj5xRapcpMMO+0PpiB
         stqg==
X-Gm-Message-State: AJcUukd6KZyAJkqpx2WX4ZsNp0CrHkC625hPX68HmbF8RBLYuPmH5RQu
        cFGfeivPgkHRbFerDAGd4saqrA==
X-Google-Smtp-Source: ALg8bN7RKzJaWDklm5eX8FW4jArXuCPLokUc6KgbZlHM8G+18lrvRl4jiEluxZUknUst1pCkz7ftgg==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr29188406ljg.71.1546878661297;
        Mon, 07 Jan 2019 08:31:01 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id b69sm12936594lfl.28.2019.01.07.08.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 08:31:00 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5 v8] regulator: core: Only support passing enable GPIO descriptors
Date:   Mon,  7 Jan 2019 17:27:46 +0100
Message-Id: <20190107162746.4444-5-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190107162746.4444-1-linus.walleij@linaro.org>
References: <20190107162746.4444-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we changed all providers to pass descriptors into the core
for enable GPIOs instead of a global GPIO number, delete the support
for passing GPIO numbers in, and we get a cleanup and size reduction
in the core, and from a GPIO point of view we use the modern, cleaner
interface.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v7->v8:
- Rebase on v5.0-rc1.
ChangeLog v6->v7:
- Resend with the rest.
ChangeLog v4->v6:
- Rebase on top of the other changes.
- Renumber to fit the rest of the series.
ChangeLog v3->v4:
- Also drop ena_gpio_invert from driver data
ChangeLog v2->v3:
- Resending.
ChangeLog v1->v2:
- Rebase the patch on the other changes.
---
 drivers/regulator/core.c         | 32 ++++++--------------------------
 include/linux/regulator/driver.h | 12 +-----------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 48baa03ff3d8..bb688125ebd4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -23,7 +23,6 @@
 #include <linux/mutex.h>
 #include <linux/suspend.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
@@ -2236,35 +2235,19 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 {
 	struct regulator_enable_gpio *pin;
 	struct gpio_desc *gpiod;
-	int ret;
 
-	if (config->ena_gpiod)
-		gpiod = config->ena_gpiod;
-	else
-		gpiod = gpio_to_desc(config->ena_gpio);
+	gpiod = config->ena_gpiod;
 
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (pin->gpiod == gpiod) {
-			rdev_dbg(rdev, "GPIO %d is already used\n",
-				config->ena_gpio);
+			rdev_dbg(rdev, "GPIO is already used\n");
 			goto update_ena_gpio_to_rdev;
 		}
 	}
 
-	if (!config->ena_gpiod) {
-		ret = gpio_request_one(config->ena_gpio,
-				       GPIOF_DIR_OUT | config->ena_gpio_flags,
-				       rdev_get_name(rdev));
-		if (ret)
-			return ret;
-	}
-
 	pin = kzalloc(sizeof(struct regulator_enable_gpio), GFP_KERNEL);
-	if (pin == NULL) {
-		if (!config->ena_gpiod)
-			gpio_free(config->ena_gpio);
+	if (pin == NULL)
 		return -ENOMEM;
-	}
 
 	pin->gpiod = gpiod;
 	list_add(&pin->list, &regulator_ena_gpio_list);
@@ -2287,7 +2270,6 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
@@ -4971,15 +4953,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 			goto clean;
 	}
 
-	if (config->ena_gpiod ||
-	    ((config->ena_gpio || config->ena_gpio_initialized) &&
-	     gpio_is_valid(config->ena_gpio))) {
+	if (config->ena_gpiod) {
 		mutex_lock(&regulator_list_mutex);
 		ret = regulator_ena_gpio_request(rdev, config);
 		mutex_unlock(&regulator_list_mutex);
 		if (ret != 0) {
-			rdev_err(rdev, "Failed to request enable GPIO%d: %d\n",
-				 config->ena_gpio, ret);
+			rdev_err(rdev, "Failed to request enable GPIO: %d\n",
+				 ret);
 			goto clean;
 		}
 		/* The regulator core took over the GPIO descriptor */
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 389bcaf7900f..e511e9d1cc86 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -401,13 +401,7 @@ struct regulator_desc {
  *           NULL).
  * @regmap: regmap to use for core regmap helpers if dev_get_regmap() is
  *          insufficient.
- * @ena_gpio_initialized: GPIO controlling regulator enable was properly
- *                        initialized, meaning that >= 0 is a valid gpio
- *                        identifier and < 0 is a non existent gpio.
- * @ena_gpio: GPIO controlling regulator enable.
- * @ena_gpiod: GPIO descriptor controlling regulator enable.
- * @ena_gpio_invert: Sense for GPIO enable control.
- * @ena_gpio_flags: Flags to use when calling gpio_request_one()
+ * @ena_gpiod: GPIO controlling regulator enable.
  */
 struct regulator_config {
 	struct device *dev;
@@ -416,11 +410,7 @@ struct regulator_config {
 	struct device_node *of_node;
 	struct regmap *regmap;
 
-	bool ena_gpio_initialized;
-	int ena_gpio;
 	struct gpio_desc *ena_gpiod;
-	unsigned int ena_gpio_invert:1;
-	unsigned int ena_gpio_flags;
 };
 
 /*
-- 
2.19.2

