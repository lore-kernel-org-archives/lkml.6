Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401702147A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="acfBjB/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfA2Nf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:35:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35216 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfA2Nf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:35:56 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so17960831wmt.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 05:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxFrfAYs+THFoK5Dj2J2xzQ1ZkkvkOfk5WjbVRfiZK4=;
        b=acfBjB/G/RGT2SiXbA6dD6Mds2mD+gtD4cqfVmUgyVla4N42BywgZ2JpU+aXnDuqcB
         l3AP8KTcOl2uatjScbns0xMXSP+Ab1ZfRPmNEbYP4Jp+dK9zTxuMGGRCBi19ZgocPIL5
         DVyBSn8ZSxM/xnK/CKWVgPrNaNuGib7gHwFnXO0tp2u+iHOa3HQhnMi7sNzwwp+UxzaB
         s/Jv4MrnQwlSi2SHu3N464Y3voMCgUuYZ4ZIEqCM6FRvFxU0g7l4Hyzmi6JMTrSnSzLa
         2jVEzQrEQ2jr19GuGPIoeqi5ON1TVWbtuNb0uT4PS7kOWsHlF45BiYlaUGPjW2aJ8IzG
         QmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxFrfAYs+THFoK5Dj2J2xzQ1ZkkvkOfk5WjbVRfiZK4=;
        b=OYSReUZD1eVOgtZSp3gplP/FjwFQ5yuG46PT3yFo04II1fCk6YtycnOw2whv8gx1IK
         r7gN+Q7UQis8vYsS1HTOz+qN9/BZVS5PUoURP1yieOaucTkSWoHAMFdT9xCCaLFsZAYj
         fneOjbs5w7QTJ1I1nw9iPTriAk69pFYeqCRcXatrRzKF2vrjmbKF4iFUzetqdkBeCQkX
         XiTxzuJjKZ49+jY30HjAkgLPf2mBUbERiyQGQi15N2CIy70+Wi4lb8iDpFT0N6vq5ry4
         tNC+ssOx4owKn3MWoRZaavj1gwHM58paVA/lWTqkcvC/23XgVTS2MYRWDqSGBBmKgtmf
         mE/A==
X-Gm-Message-State: AJcUukd4IApHrlZMHjS5XWzuWRmHZRhbw+0m2lK8dnkp7C1BqNofJbM3
        yiyfMEINcNpZmn54Uac0M33OCA==
X-Google-Smtp-Source: ALg8bN7/l7shoWwiyIuCMtOXzlzQfq3jbt1FE3Oa72Nkp0woPkqn1e7eQl5apQCjXt4L5dAkBFY9/w==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr20055471wmh.83.1548768953782;
        Tue, 29 Jan 2019 05:35:53 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id k128sm4367891wmd.37.2019.01.29.05.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 05:35:53 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] gpio fixup domain
Date:   Tue, 29 Jan 2019 14:35:33 +0100
Message-Id: <20190129133545.1931-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129133545.1931-1-brgl@bgdev.pl>
References: <20190129133545.1931-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

---
 arch/arm/boot/dts/am335x-bone-common.dtsi |   4 +
 drivers/gpio/gpio-max77650.c              | 138 +++++++++++++++++++++-
 2 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 62f7f2ac191c..320b4c21fdf3 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -276,6 +276,10 @@
 
 			gpio-controller;
 			#gpio-cells = <2>;
+
+			interrupt-parent = <&pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-names = "GPI";
 		};
 
 		leds {
diff --git a/drivers/gpio/gpio-max77650.c b/drivers/gpio/gpio-max77650.c
index 3f03f4e8956c..03a5a2ed07f8 100644
--- a/drivers/gpio/gpio-max77650.c
+++ b/drivers/gpio/gpio-max77650.c
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/max77650.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
@@ -34,7 +35,8 @@
 struct max77650_gpio_chip {
 	struct regmap *map;
 	struct gpio_chip gc;
-	int irq;
+	struct fwnode_handle *fwnode;
+	struct irq_domain *domain;
 };
 
 static int max77650_gpio_direction_input(struct gpio_chip *gc,
@@ -130,20 +132,114 @@ static int max77650_gpio_set_config(struct gpio_chip *gc,
 	}
 }
 
+static struct irq_chip max77650_gpio_irq_chip = {
+	.name = "max77650-gpio",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = irq_chip_unmask_parent,
+	.irq_set_type = irq_chip_set_type_parent,
+};
+
+static int max77650_gpio_irq_domain_activate(struct irq_domain *domain,
+					     struct irq_data *data,
+					     bool reserve)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	return gpiochip_lock_as_irq(&chip->gc, data->hwirq);
+}
+
+static void max77650_gpio_irq_domain_deactivate(struct irq_domain *domain,
+						struct irq_data *data)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	return gpiochip_unlock_as_irq(&chip->gc, data->hwirq);
+}
+
+static int max77650_gpio_domain_translate(struct irq_domain *domain,
+					  struct irq_fwspec *fwspec,
+					  unsigned long *hwirq,
+					  unsigned int *type)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+
+	if (fwspec->param_count != 2 || fwspec->param[0] >= chip->gc.ngpio)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1];
+
+	return 0;
+}
+
+static int max77650_gpio_domain_alloc(struct irq_domain *domain,
+				      unsigned int virq,
+				      unsigned int nr_irqs, void *data)
+{
+	struct max77650_gpio_chip *chip = domain->host_data;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
+	irq_hw_number_t hwirq;
+	unsigned int type;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	ret = max77650_gpio_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	irq_domain_set_info(domain, virq, hwirq,
+			    &max77650_gpio_irq_chip, chip,
+			    handle_level_irq, NULL, NULL);
+
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	parent_fwspec.param_count = 4;
+	parent_fwspec.param[0] = 0;
+	parent_fwspec.param[1] = hwirq;
+	parent_fwspec.param[2] = 0;
+	parent_fwspec.param[3] = fwspec->param[1];
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+
+	return 0;
+}
+
+static const struct irq_domain_ops max77650_gpio_irq_domain_ops = {
+	.activate = max77650_gpio_irq_domain_activate,
+	.deactivate = max77650_gpio_irq_domain_deactivate,
+	.alloc = max77650_gpio_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+	.translate = max77650_gpio_domain_translate,
+};
+
 static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
 {
 	struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = chip->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = 0;
+	fwspec.param[1] = IRQ_TYPE_LEVEL_LOW;
 
-	return chip->irq;
+	return irq_create_fwspec_mapping(&fwspec);
 }
 
 static int max77650_gpio_probe(struct platform_device *pdev)
 {
+	struct device_node *of_node, *parent_node;
+	struct irq_domain *parent_domain;
 	struct max77650_gpio_chip *chip;
 	struct device *dev, *parent;
 	struct i2c_client *i2c;
+	int rv;
 
 	dev = &pdev->dev;
+	of_node = dev->of_node;
 	parent = dev->parent;
 	i2c = to_i2c_client(parent);
 
@@ -151,13 +247,29 @@ static int max77650_gpio_probe(struct platform_device *pdev)
 	if (!chip)
 		return -ENOMEM;
 
+	chip->fwnode = dev->fwnode;
+	platform_set_drvdata(pdev, chip);
+
 	chip->map = dev_get_regmap(parent, NULL);
 	if (!chip->map)
 		return -ENODEV;
 
-	chip->irq = platform_get_irq_byname(pdev, "GPI");
-	if (chip->irq < 0)
-		return chip->irq;
+	parent_node = of_irq_find_parent(of_node);
+	if (!parent_node)
+		return -ENXIO;
+
+	parent_domain = irq_find_host(parent_node);
+	of_node_put(parent_node);
+	if (!parent_domain)
+		return -ENXIO;
+
+	chip->fwnode = of_node_to_fwnode(of_node);
+	chip->domain = irq_domain_create_hierarchy(parent_domain, 0, 1,
+						chip->fwnode,
+						&max77650_gpio_irq_domain_ops,
+						chip);
+	if (!chip->domain)
+		return -ENODEV;
 
 	chip->gc.base = -1;
 	chip->gc.ngpio = 1;
@@ -174,7 +286,20 @@ static int max77650_gpio_probe(struct platform_device *pdev)
 	chip->gc.set_config = max77650_gpio_set_config;
 	chip->gc.to_irq = max77650_gpio_to_irq;
 
-	return devm_gpiochip_add_data(dev, &chip->gc, chip);
+	rv = devm_gpiochip_add_data(dev, &chip->gc, chip);
+	if (rv)
+		irq_domain_remove(chip->domain);
+
+	return rv;
+}
+
+static int max77650_gpio_remove(struct platform_device *pdev)
+{
+	struct max77650_gpio_chip *chip = platform_get_drvdata(pdev);
+
+	irq_domain_remove(chip->domain);
+
+	return 0;
 }
 
 static struct platform_driver max77650_gpio_driver = {
@@ -182,6 +307,7 @@ static struct platform_driver max77650_gpio_driver = {
 		.name = "max77650-gpio",
 	},
 	.probe = max77650_gpio_probe,
+	.remove = max77650_gpio_remove,
 };
 module_platform_driver(max77650_gpio_driver);
 
-- 
2.20.1

