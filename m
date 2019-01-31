Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA73C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F016218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfAaMCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:02:41 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37909 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaMCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:02:40 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so2441839lja.5;
        Thu, 31 Jan 2019 04:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PUQ5JIe6tSnYfUZ9hquGsp4jQxfcuLm9eU/In1aybU8=;
        b=nYfh9pnCVhCyUFipinp+BOqWko9FnkaiOqBNWWTy7+oaSv+IYLj2SfrTT7yTQJV5WA
         z2H90ssUAkbMuPdFg1XPRsrfk6LPv4052/7dx3ajR6nSTBorzYFe9f6Rvz0puKwY7t64
         cXqvyJDWdTtOaWKBuSTOqdVngnEAdPjlKN/RCuB0ZAEyIwwslSTduxUuRHmuRFL9OGQf
         BqhEy4CAv2B1r9VJmvchCKISMfSeEtMp5IPH8l1qVFDEaZsGMOTslXRuCu2EDiI3Skp9
         8s3xdJNjg9mZn148+7is6zfwozjrNsnEtiLJbsI8MzV9pw2aHlitE6LQnmiu7J5Nt2oQ
         GrVg==
X-Gm-Message-State: AJcUukf71B10+yhXn5E5g9Lt+rc0RGm4p9jhuPU2/1wJ1KqZI/H/ESSm
        y62ibP3CCyqTyi3DFe56qnU=
X-Google-Smtp-Source: ALg8bN40674hXsQmeXMjTRugtb/fto3n1QniKutg7HInhUG5ghSJXwecTWOENrvVud7XHjTTs5dciw==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr27835305ljg.164.1548936156789;
        Thu, 31 Jan 2019 04:02:36 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p21sm806119lfj.10.2019.01.31.04.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:02:36 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:02:24 +0200
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
Subject: [RFC PATCH v4 01/10] mfd: bd718x7.h split to ROHM common and bd718x7
 specific parts
Message-ID: <0f5a3b94f936556c1ad05da58bfb35182ae20a96.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548935790.git.matti.vaittinen@fi.rohmeurope.com>
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
