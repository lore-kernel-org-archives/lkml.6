Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D18DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F4BD20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 17:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHHBbhmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F4BD20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406179AbeKWDrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:47:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41965 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbeKWDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:47:39 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so2184484pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q5lVi/XKX9zwzxhleNmQKYQrpga+xqbiNMbCQQIONjA=;
        b=SHHBbhmVmWsIijQhCmpr7Tf8g8cNkuwBFkPey1SI6UUKtJNUOHqX5dj7ow+Qkc9vf4
         FxROtKBFLjebPS14HiHTESUWf9oOqnGGcdI7a1sv2eEuY2mVFmoR5pI8YaV8g7rbcMMl
         z8Rvw4ylxN9ab6xp6ut5ABfX4CbopcPRYViVEgHXiLa2GQ4OF6gs4l+FEtA/RAW2FAIr
         jS0+ueR7UF9Idsj7osX6nDPxGlX2o4TEITv2L01bl+6RtxAH8SooeO+VmN48L2isbGSi
         PeySqzFsAFmDFxFCTPXgcic+gfN29ZAiwjZ1a1HQLy9oqURtyAIGoskcgdglfc1Hsn1Y
         EjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5lVi/XKX9zwzxhleNmQKYQrpga+xqbiNMbCQQIONjA=;
        b=Nak1UTY7MfjDW3cMPmA2h4z9oWRSLopHcLthiQ709gKMFLzZaKaLj2HbjOsoQuQG8Y
         CFojaJuXtaHwNDI+Y5gtWhsQPRoR4iPpRC345SgBAZKpXs6a3PqFiLpIK4oUdNjdzz3N
         NjUvWR+TsC3Ay70Z08bjEknZNs6w3irIA+8t1Db/kwzOuYKDItTfON4+5ta9YnvVAuKp
         EVF8qb/2SkB+HpFVVd17SbXPlMSXjqvO3RY1cafY6v78y4Xo+PWLLyz+ePmhRwPaoP9A
         6mo3eINNeQR806tidWMh5F9Ya2BoR8Epo5vkacJvpn3EgiIYhXwLxu9iblZze1Wuved6
         w5pw==
X-Gm-Message-State: AA+aEWZFb0EAIE3HqEL5+bHPSuN1s3Q7ji9LZaGsLjl1Qbacb04PZG6r
        nk9EbPG+qZn/omOKVcOQzRE=
X-Google-Smtp-Source: AFSGD/VnwW5l70zJZLEMcfa02MJya8oN9JAdDvNWPxyOR3dYcE4RUFhyA7zYFI8MG3kJtmyvC9gGog==
X-Received: by 2002:a63:1a4b:: with SMTP id a11mr10864943pgm.254.1542906443175;
        Thu, 22 Nov 2018 09:07:23 -0800 (PST)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id k15sm2884376pfb.147.2018.11.22.09.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 09:07:22 -0800 (PST)
Date:   Thu, 22 Nov 2018 22:37:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] staging: greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <e12d2f21115c71820d4d68168181e5ebe4340f0f.1542898267.git.nishadkamdar@gmail.com>
References: <cover.1542898267.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542898267.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPIO driver to use the GPIO irqchip library
GPIOLIB_IRQCHIP instead of reimplementing the same.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v2:
 - Retained irq.h and irqdomain.h headers.
 - Dropped function gb_gpio_irqchip_add() and
   called gpiochip_irqchip_add() from probe().
 - Referred https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org.
---
 drivers/staging/greybus/Kconfig |   1 +
 drivers/staging/greybus/gpio.c  | 184 ++++----------------------------
 2 files changed, 24 insertions(+), 161 deletions(-)

diff --git a/drivers/staging/greybus/Kconfig b/drivers/staging/greybus/Kconfig
index ab096bcef98c..b571e4e8060b 100644
--- a/drivers/staging/greybus/Kconfig
+++ b/drivers/staging/greybus/Kconfig
@@ -148,6 +148,7 @@ if GREYBUS_BRIDGED_PHY
 config GREYBUS_GPIO
 	tristate "Greybus GPIO Bridged PHY driver"
 	depends on GPIOLIB
+	select GPIOLIB_IRQCHIP
 	---help---
 	  Select this option if you have a device that follows the
 	  Greybus GPIO Bridged PHY Class specification.
diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index b1d4698019a1..2ec54744171d 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -9,9 +9,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/gpio/driver.h>
 #include <linux/mutex.h>
 
 #include "greybus.h"
@@ -39,15 +39,8 @@ struct gb_gpio_controller {
 
 	struct gpio_chip	chip;
 	struct irq_chip		irqc;
-	struct irq_chip		*irqchip;
-	struct irq_domain	*irqdomain;
-	unsigned int		irq_base;
-	irq_flow_handler_t	irq_handler;
-	unsigned int		irq_default_type;
 	struct mutex		irq_lock;
 };
-#define gpio_chip_to_gb_gpio_controller(chip) \
-	container_of(chip, struct gb_gpio_controller, chip)
 #define irq_data_to_gpio_chip(d) (d->domain->host_data)
 
 static int gb_gpio_line_count_operation(struct gb_gpio_controller *ggc)
@@ -276,7 +269,7 @@ static void _gb_gpio_irq_set_type(struct gb_gpio_controller *ggc,
 static void gb_gpio_irq_mask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = true;
@@ -286,7 +279,7 @@ static void gb_gpio_irq_mask(struct irq_data *d)
 static void gb_gpio_irq_unmask(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	line->masked = false;
@@ -296,7 +289,7 @@ static void gb_gpio_irq_unmask(struct irq_data *d)
 static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 	struct device *dev = &ggc->gbphy_dev->dev;
 	u8 irq_type;
@@ -334,7 +327,7 @@ static int gb_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 static void gb_gpio_irq_bus_lock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	mutex_lock(&ggc->irq_lock);
 }
@@ -342,7 +335,7 @@ static void gb_gpio_irq_bus_lock(struct irq_data *d)
 static void gb_gpio_irq_bus_sync_unlock(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_to_gpio_chip(d);
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	struct gb_gpio_line *line = &ggc->lines[d->hwirq];
 
 	if (line->irq_type_pending) {
@@ -391,7 +384,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	irq = irq_find_mapping(ggc->irqdomain, event->which);
+	irq = irq_find_mapping(ggc->chip.irq.domain, event->which);
 	if (!irq) {
 		dev_err(dev, "failed to find IRQ\n");
 		return -EINVAL;
@@ -411,21 +404,21 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 
 static int gb_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_activate_operation(ggc, (u8)offset);
 }
 
 static void gb_gpio_free(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_deactivate_operation(ggc, (u8)offset);
 }
 
 static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -439,7 +432,7 @@ static int gb_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
 
 static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_in_operation(ggc, (u8)offset);
 }
@@ -447,14 +440,14 @@ static int gb_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
 static int gb_gpio_direction_output(struct gpio_chip *chip, unsigned int offset,
 				    int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	return gb_gpio_direction_out_operation(ggc, (u8)offset, !!value);
 }
 
 static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u8 which;
 	int ret;
 
@@ -468,7 +461,7 @@ static int gb_gpio_get(struct gpio_chip *chip, unsigned int offset)
 
 static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 
 	gb_gpio_set_value_operation(ggc, (u8)offset, !!value);
 }
@@ -476,7 +469,7 @@ static void gb_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
 static int gb_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 			      unsigned long config)
 {
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
+	struct gb_gpio_controller *ggc = gpiochip_get_data(chip);
 	u32 debounce;
 
 	if (pinconf_to_config_param(config) != PIN_CONFIG_INPUT_DEBOUNCE)
@@ -506,135 +499,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
 	return ret;
 }
 
-/**
- * gb_gpio_irq_map() - maps an IRQ into a GB gpio irqchip
- * @d: the irqdomain used by this irqchip
- * @irq: the global irq number used by this GB gpio irqchip irq
- * @hwirq: the local IRQ/GPIO line offset on this GB gpio
- *
- * This function will set up the mapping for a certain IRQ line on a
- * GB gpio by assigning the GB gpio as chip data, and using the irqchip
- * stored inside the GB gpio.
- */
-static int gb_gpio_irq_map(struct irq_domain *domain, unsigned int irq,
-			   irq_hw_number_t hwirq)
-{
-	struct gpio_chip *chip = domain->host_data;
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
-
-	irq_set_chip_data(irq, ggc);
-	irq_set_chip_and_handler(irq, ggc->irqchip, ggc->irq_handler);
-	irq_set_noprobe(irq);
-	/*
-	 * No set-up of the hardware will happen if IRQ_TYPE_NONE
-	 * is passed as default type.
-	 */
-	if (ggc->irq_default_type != IRQ_TYPE_NONE)
-		irq_set_irq_type(irq, ggc->irq_default_type);
-
-	return 0;
-}
-
-static void gb_gpio_irq_unmap(struct irq_domain *d, unsigned int irq)
-{
-	irq_set_chip_and_handler(irq, NULL, NULL);
-	irq_set_chip_data(irq, NULL);
-}
-
-static const struct irq_domain_ops gb_gpio_domain_ops = {
-	.map	= gb_gpio_irq_map,
-	.unmap	= gb_gpio_irq_unmap,
-};
-
-/**
- * gb_gpio_irqchip_remove() - removes an irqchip added to a gb_gpio_controller
- * @ggc: the gb_gpio_controller to remove the irqchip from
- *
- * This is called only from gb_gpio_remove()
- */
-static void gb_gpio_irqchip_remove(struct gb_gpio_controller *ggc)
-{
-	unsigned int offset;
-
-	/* Remove all IRQ mappings and delete the domain */
-	if (ggc->irqdomain) {
-		for (offset = 0; offset < (ggc->line_max + 1); offset++)
-			irq_dispose_mapping(irq_find_mapping(ggc->irqdomain,
-							     offset));
-		irq_domain_remove(ggc->irqdomain);
-	}
-
-	if (ggc->irqchip)
-		ggc->irqchip = NULL;
-}
-
-/**
- * gb_gpio_irqchip_add() - adds an irqchip to a gpio chip
- * @chip: the gpio chip to add the irqchip to
- * @irqchip: the irqchip to add to the adapter
- * @first_irq: if not dynamically assigned, the base (first) IRQ to
- * allocate gpio irqs from
- * @handler: the irq handler to use (often a predefined irq core function)
- * @type: the default type for IRQs on this irqchip, pass IRQ_TYPE_NONE
- * to have the core avoid setting up any default type in the hardware.
- *
- * This function closely associates a certain irqchip with a certain
- * gpio chip, providing an irq domain to translate the local IRQs to
- * global irqs, and making sure that the gpio chip
- * is passed as chip data to all related functions. Driver callbacks
- * need to use container_of() to get their local state containers back
- * from the gpio chip passed as chip data. An irqdomain will be stored
- * in the gpio chip that shall be used by the driver to handle IRQ number
- * translation. The gpio chip will need to be initialized and registered
- * before calling this function.
- */
-static int gb_gpio_irqchip_add(struct gpio_chip *chip,
-			 struct irq_chip *irqchip,
-			 unsigned int first_irq,
-			 irq_flow_handler_t handler,
-			 unsigned int type)
-{
-	struct gb_gpio_controller *ggc;
-	unsigned int offset;
-	unsigned int irq_base;
-
-	if (!chip || !irqchip)
-		return -EINVAL;
-
-	ggc = gpio_chip_to_gb_gpio_controller(chip);
-
-	ggc->irqchip = irqchip;
-	ggc->irq_handler = handler;
-	ggc->irq_default_type = type;
-	ggc->irqdomain = irq_domain_add_simple(NULL,
-					ggc->line_max + 1, first_irq,
-					&gb_gpio_domain_ops, chip);
-	if (!ggc->irqdomain) {
-		ggc->irqchip = NULL;
-		return -EINVAL;
-	}
-
-	/*
-	 * Prepare the mapping since the irqchip shall be orthogonal to
-	 * any gpio calls. If the first_irq was zero, this is
-	 * necessary to allocate descriptors for all IRQs.
-	 */
-	for (offset = 0; offset < (ggc->line_max + 1); offset++) {
-		irq_base = irq_create_mapping(ggc->irqdomain, offset);
-		if (offset == 0)
-			ggc->irq_base = irq_base;
-	}
-
-	return 0;
-}
-
-static int gb_gpio_to_irq(struct gpio_chip *chip, unsigned int offset)
-{
-	struct gb_gpio_controller *ggc = gpio_chip_to_gb_gpio_controller(chip);
-
-	return irq_find_mapping(ggc->irqdomain, offset);
-}
-
 static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 			 const struct gbphy_device_id *id)
 {
@@ -693,7 +557,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	gpio->get = gb_gpio_get;
 	gpio->set = gb_gpio_set;
 	gpio->set_config = gb_gpio_set_config;
-	gpio->to_irq = gb_gpio_to_irq;
 	gpio->base = -1;		/* Allocate base dynamically */
 	gpio->ngpio = ggc->line_max + 1;
 	gpio->can_sleep = true;
@@ -702,24 +565,24 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_line_free;
 
-	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
-				   handle_level_irq, IRQ_TYPE_NONE);
+	ret = gpiochip_add(gpio);
 	if (ret) {
-		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
+		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
 		goto exit_line_free;
 	}
 
-	ret = gpiochip_add(gpio);
+	ret = gpiochip_irqchip_add(gpio, irqc, 0, handle_level_irq,
+				   IRQ_TYPE_NONE);
 	if (ret) {
-		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
-		goto exit_gpio_irqchip_remove;
+		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
+		goto exit_gpiochip_remove;
 	}
 
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 	return 0;
 
-exit_gpio_irqchip_remove:
-	gb_gpio_irqchip_remove(ggc);
+exit_gpiochip_remove:
+	gpiochip_remove(gpio);
 exit_line_free:
 	kfree(ggc->lines);
 exit_connection_disable:
@@ -743,7 +606,6 @@ static void gb_gpio_remove(struct gbphy_device *gbphy_dev)
 
 	gb_connection_disable_rx(connection);
 	gpiochip_remove(&ggc->chip);
-	gb_gpio_irqchip_remove(ggc);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(ggc->lines);
-- 
2.17.1

