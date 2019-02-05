Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B00EC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578562075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbfBEJEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:04:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46427 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:04:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so2170949ljh.13;
        Tue, 05 Feb 2019 01:04:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUQ5JIe6tSnYfUZ9hquGsp4jQxfcuLm9eU/In1aybU8=;
        b=OBDYMnrn6dIhhZ8fCozoXZDIj9JNy/psjDICX+saK/JhjLVwXwDhZkiP+/rBdkESLk
         nH2+qTu6XNjglHSfu6hfqbKhmvx2DkVh9x0jR3os/vK8xE3OKyWpNJg7eLMI3UjP/DH8
         SPH1RoUh8+BsbkyjgJS+s1gtuCqEiHsfgtUU9uegjEF40jIl8i3ZJa8C2Kbkie/Rvwrh
         ga1CFhEjCGfDZcbbtbCm73eG3qCIbO3mKvDwHXbcs1WJ69xnscAofPH5oVY/hhMYGKFy
         GtkVS9yNyigyInKTxbPNeJZs3pER0pd3wYkOu4f2Xxw5YZ9Cvoes8AxdRHEv57a308ri
         aMNw==
X-Gm-Message-State: AHQUAubCVWVc1gWa3UcK5aN4t5b2YuDuYqZF42hnUQLHbDTZ0FM6Agic
        hsSjKTm1n42SUnkmFdmhrvI=
X-Google-Smtp-Source: AHgI3IYET342hzn7eZsRy2AeHJoBDpiPlmZt4k2f6bU5z5BWAbjOTelxT7owgda1YCPN2Bv/b3fsZA==
X-Received: by 2002:a2e:9a16:: with SMTP id o22-v6mr2329898lji.112.1549357480230;
        Tue, 05 Feb 2019 01:04:40 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b25sm3622554lfa.96.2019.02.05.01.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 01:04:39 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:04:27 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v6 01/10] mfd: bd718x7.h split to ROHM common and bd718x7
 specific parts
Message-ID: <0f5a3b94f936556c1ad05da58bfb35182ae20a96.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549356505.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the bd718x7.h to ROHM common and bd718x7 specific parts
so that we do not need to add same things in every new ROHM
PMIC header. Please note that this change requires changes also
in bd718x7 sub-device drivers for regulators and clk.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/mfd/rohm-bd718x7.c       | 23 ++++++++++++-----------
 include/linux/mfd/rohm-bd718x7.h | 22 ++++++++--------------
 include/linux/mfd/rohm-generic.h | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+), 25 deletions(-)
 create mode 100644 include/linux/mfd/rohm-generic.h

diff --git a/drivers/mfd/rohm-bd718x7.c b/drivers/mfd/rohm-bd718x7.c
index a29d529a96f4..7beb444a57cb 100644
--- a/drivers/mfd/rohm-bd718x7.c
+++ b/drivers/mfd/rohm-bd718x7.c
@@ -98,18 +98,19 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 		return -ENOMEM;
 
 	bd718xx->chip_irq = i2c->irq;
-	bd718xx->chip_type = (unsigned int)(uintptr_t)
+	bd718xx->chip.chip_type = (unsigned int)(uintptr_t)
 				of_device_get_match_data(&i2c->dev);
-	bd718xx->dev = &i2c->dev;
+	bd718xx->chip.dev = &i2c->dev;
 	dev_set_drvdata(&i2c->dev, bd718xx);
 
-	bd718xx->regmap = devm_regmap_init_i2c(i2c, &bd718xx_regmap_config);
-	if (IS_ERR(bd718xx->regmap)) {
+	bd718xx->chip.regmap = devm_regmap_init_i2c(i2c,
+						    &bd718xx_regmap_config);
+	if (IS_ERR(bd718xx->chip.regmap)) {
 		dev_err(&i2c->dev, "regmap initialization failed\n");
-		return PTR_ERR(bd718xx->regmap);
+		return PTR_ERR(bd718xx->chip.regmap);
 	}
 
-	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->regmap,
+	ret = devm_regmap_add_irq_chip(&i2c->dev, bd718xx->chip.regmap,
 				       bd718xx->chip_irq, IRQF_ONESHOT, 0,
 				       &bd718xx_irq_chip, &bd718xx->irq_data);
 	if (ret) {
@@ -118,7 +119,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure short press to 10 milliseconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG0,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_SHORT_PRESS_10MS);
@@ -129,7 +130,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 	}
 
 	/* Configure long press to 10 seconds */
-	ret = regmap_update_bits(bd718xx->regmap,
+	ret = regmap_update_bits(bd718xx->chip.regmap,
 				 BD718XX_REG_PWRONCONFIG1,
 				 BD718XX_PWRBTN_PRESS_DURATION_MASK,
 				 BD718XX_PWRBTN_LONG_PRESS_10S);
@@ -149,7 +150,7 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 
 	button.irq = ret;
 
-	ret = devm_mfd_add_devices(bd718xx->dev, PLATFORM_DEVID_AUTO,
+	ret = devm_mfd_add_devices(bd718xx->chip.dev, PLATFORM_DEVID_AUTO,
 				   bd718xx_mfd_cells,
 				   ARRAY_SIZE(bd718xx_mfd_cells), NULL, 0,
 				   regmap_irq_get_domain(bd718xx->irq_data));
@@ -162,11 +163,11 @@ static int bd718xx_i2c_probe(struct i2c_client *i2c,
 static const struct of_device_id bd718xx_of_match[] = {
 	{
 		.compatible = "rohm,bd71837",
-		.data = (void *)BD718XX_TYPE_BD71837,
+		.data = (void *)ROHM_CHIP_TYPE_BD71837,
 	},
 	{
 		.compatible = "rohm,bd71847",
-		.data = (void *)BD718XX_TYPE_BD71847,
+		.data = (void *)ROHM_CHIP_TYPE_BD71847,
 	},
 	{ }
 };
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index fd194bfc836f..7f2dbde402a1 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -4,14 +4,9 @@
 #ifndef __LINUX_MFD_BD718XX_H__
 #define __LINUX_MFD_BD718XX_H__
 
+#include <linux/mfd/rohm-generic.h>
 #include <linux/regmap.h>
 
-enum {
-	BD718XX_TYPE_BD71837 = 0,
-	BD718XX_TYPE_BD71847,
-	BD718XX_TYPE_AMOUNT
-};
-
 enum {
 	BD718XX_BUCK1 = 0,
 	BD718XX_BUCK2,
@@ -321,18 +316,17 @@ enum {
 	BD718XX_PWRBTN_LONG_PRESS_15S
 };
 
-struct bd718xx_clk;
-
 struct bd718xx {
-	unsigned int chip_type;
-	struct device *dev;
-	struct regmap *regmap;
-	unsigned long int id;
+	/*
+	 * Please keep this as the first member here as some
+	 * drivers (clk) supporting more than one chip may only know this
+	 * generic struct 'struct rohm_regmap_dev' and assume it is
+	 * the first chunk of parent device's private data.
+	 */
+	struct rohm_regmap_dev chip;
 
 	int chip_irq;
 	struct regmap_irq_chip_data *irq_data;
-
-	struct bd718xx_clk *clk;
 };
 
 #endif /* __LINUX_MFD_BD718XX_H__ */
diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
new file mode 100644
index 000000000000..bff15ac26f2c
--- /dev/null
+++ b/include/linux/mfd/rohm-generic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (C) 2018 ROHM Semiconductors */
+
+#ifndef __LINUX_MFD_ROHM_H__
+#define __LINUX_MFD_ROHM_H__
+
+enum {
+	ROHM_CHIP_TYPE_BD71837 = 0,
+	ROHM_CHIP_TYPE_BD71847,
+	ROHM_CHIP_TYPE_BD70528,
+	ROHM_CHIP_TYPE_AMOUNT
+};
+
+struct rohm_regmap_dev {
+	unsigned int chip_type;
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+#endif
-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
