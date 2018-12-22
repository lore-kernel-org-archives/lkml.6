Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84889C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3579021A7F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFNhUWnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391538AbeLVRn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:43:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLVRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:43:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so4066154pfc.6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 09:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3jyBa/zCBt9uBjh305bgNYGJDiA38YRl9YO1xewAWtY=;
        b=XFNhUWnua2wXgBgk/9rLW4fvtxXHK44pkUxc6RzPfjlVRzMLayvOFS3WWcXcPyLcIH
         i45Cuza9gfPZTRceMDKfJ7x9HMkMtAsNxFdG4uH+jQf6xhrQKVbW9MjzcgZ8+uq+XCjF
         F+buEglwA72jrnyqa47YDvwzgOe5jAeVJzZ95XVqRtN2YGFr0gLp5BiL8SsJUnHnW6UD
         DeA5qVNjKO1+rpXRt0Tr/cerr985i/wezO5NhWUrISdotbTmMa4daVYDgHCqrhSUaOIn
         Tu6eYE+Zpr8g9hntPIMvOG08er43G0qWEXr2KrwsJhRXu/7RS3u9UgTgpEtyuksLQk1R
         6BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3jyBa/zCBt9uBjh305bgNYGJDiA38YRl9YO1xewAWtY=;
        b=YP10Dv5BcYR/Brnc4Jasc68H8qaOPKYduouXQOBCYAje+3tTxvxwr0tjPhMe3MAJQC
         brWXNVr0x+B44R+ygDJEgPm+ZPPRad4JJkXliaOOzQli9TQT21K6llX1k+hxV4JFtSQL
         B0tGv6nNALEDzWlbVF4qmhWIKFwzyO1iavsM6HrWNXkXI4wixzRmVGn47CsY0cAeaqaS
         iC5YMHUxUFGX5/n+3rUSR7yN8f6vOuHBmxe9u65+BisG+/SqHWUrClNvVBYSmcvgK6uc
         udBesjFtSKZTMNhKU0yoR1PL71nPuvjGa6hOAJb8ncnmTvj1ofsijpNlI+E6gx7IGiIZ
         kgkg==
X-Gm-Message-State: AJcUukcgCYVgVNIjYKNT4nG/CEabcbLuVhOoA7EkYtbl9guDUb/owHHW
        sXim1Tr1KM5fGmAegMZnCxTKUoOUKqA=
X-Google-Smtp-Source: ALg8bN7U7zuMTk+HDRUys6Gsuc91Qgz7Fey4xSmf9qlHBBAp2dnmYvK4xPsUgy24LedvoI3A4/zZyg==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr6390292pgc.165.1545490029901;
        Sat, 22 Dec 2018 06:47:09 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id e123sm31325725pgc.58.2018.12.22.06.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 06:47:09 -0800 (PST)
Date:   Sat, 22 Dec 2018 20:17:02 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v4 1/4] staging: greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <4a2b9c3439a806870e2cbc1f772bd97ea9448dfb.1545488665.git.nishadkamdar@gmail.com>
References: <cover.1545488665.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545488665.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPIO driver to use the GPIO irqchip library
GPIOLIB_IRQCHIP instead of reimplementing the same.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v4:
 - Remove changes related to conversion to gpiochip_get_data() to
   include it as a new patch.
 - Remove the 'struct irq_chip' field from 'struct gb_gpio_controller'
   as struct gpio_chip will have an irqchip whenever
   CONFIG_GPIOLIB_IRQCHIP is selected.
 - Update the TODO file as per the changes.
Changes in v3:
 - Combine patches as into a patch series.
Changes in v2:
 - Retained irq.h and irqdomain.h headers.
 - Dropped function gb_gpio_irqchip_add() and
   called gpiochip_irqchip_add() from probe().
 - Referred https://lkml.kernel.org/r/1476054589-28422-1-git-send-email-linus.walleij@linaro.org.
---
 drivers/staging/greybus/Kconfig |   1 +
 drivers/staging/greybus/TODO    |   2 -
 drivers/staging/greybus/gpio.c  | 159 +++-----------------------------
 3 files changed, 12 insertions(+), 150 deletions(-)

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
diff --git a/drivers/staging/greybus/TODO b/drivers/staging/greybus/TODO
index 3b90a5711998..31f1f2cb401c 100644
--- a/drivers/staging/greybus/TODO
+++ b/drivers/staging/greybus/TODO
@@ -1,5 +1,3 @@
 * Convert all uses of the old GPIO API from <linux/gpio.h> to the
   GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
   lines from device tree or ACPI.
-* Convert the GPIO driver to use the GPIO irqchip library
-  GPIOLIB_IRQCHIP instead of reimplementing the same.
diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index e110681e6f86..1af291aa1b6e 100644
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
@@ -38,12 +38,6 @@ struct gb_gpio_controller {
 	struct gb_gpio_line	*lines;
 
 	struct gpio_chip	chip;
-	struct irq_chip		irqc;
-	struct irq_chip		*irqchip;
-	struct irq_domain	*irqdomain;
-	unsigned int		irq_base;
-	irq_flow_handler_t	irq_handler;
-	unsigned int		irq_default_type;
 	struct mutex		irq_lock;
 };
 #define gpio_chip_to_gb_gpio_controller(chip) \
@@ -391,7 +385,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	irq = irq_find_mapping(ggc->irqdomain, event->which);
+	irq = irq_find_mapping(ggc->chip.irq.domain, event->which);
 	if (!irq) {
 		dev_err(dev, "failed to find IRQ\n");
 		return -EINVAL;
@@ -506,135 +500,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
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
-			       struct irq_chip *irqchip,
-			       unsigned int first_irq,
-			       irq_flow_handler_t handler,
-			       unsigned int type)
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
-					       ggc->line_max + 1, first_irq,
-					       &gb_gpio_domain_ops, chip);
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
@@ -670,7 +535,7 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_connection_disable;
 
-	irqc = &ggc->irqc;
+	irqc = ggc->chip.irq.chip;
 	irqc->irq_mask = gb_gpio_irq_mask;
 	irqc->irq_unmask = gb_gpio_irq_unmask;
 	irqc->irq_set_type = gb_gpio_irq_set_type;
@@ -694,7 +559,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	gpio->get = gb_gpio_get;
 	gpio->set = gb_gpio_set;
 	gpio->set_config = gb_gpio_set_config;
-	gpio->to_irq = gb_gpio_to_irq;
 	gpio->base = -1;		/* Allocate base dynamically */
 	gpio->ngpio = ggc->line_max + 1;
 	gpio->can_sleep = true;
@@ -703,24 +567,24 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	if (ret)
 		goto exit_line_free;
 
-	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
-				  handle_level_irq, IRQ_TYPE_NONE);
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
@@ -744,7 +608,6 @@ static void gb_gpio_remove(struct gbphy_device *gbphy_dev)
 
 	gb_connection_disable_rx(connection);
 	gpiochip_remove(&ggc->chip);
-	gb_gpio_irqchip_remove(ggc);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(ggc->lines);
-- 
2.17.1

