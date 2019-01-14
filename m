Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0A4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C978B2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDNhvgEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfANO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:56:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36893 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfANO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:56:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so9563097pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bk7hbJG4dM90E5i9aM0dtnwN9SxjQDq6eoCUnkotJNY=;
        b=pDNhvgEZgYNGfo2d+H9v+OFgdYiqE4uCWdDBSlJ4QuVrFdrca/RZbvKHVmP6LpUeKX
         oCuIpKoUXXa0l1e17VA6M3yDAQJCX4IwPh9R8oea2G1+DjGWAk/OEDbF1UuIFgRa8kJc
         MQ9sFEIeRR9mRS2kVfN6nk0CWKus/y9fNKuOsaepQvX2m19ytGAGvUpeL0GgCQZP4UGM
         tqbTvi2UmyMMMbaOwo5rg58mW53yp1GdAsxODNiW1qC1AUi2Ro4p77HR6n/7mZwnM1o1
         fG3SLzfVr8HXOTIOtfas3VQ4Nfu/nAgCPysaK+q8EnaY7MV58uvOlMLyBOXe4SdKfVk7
         y5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bk7hbJG4dM90E5i9aM0dtnwN9SxjQDq6eoCUnkotJNY=;
        b=GLAPN3pL7LLfg2tJr1Siv3DyWXoBG3l2sqkIZlYR7Dw+OGHORBauYMktT4N3tXfeM7
         hzcbYgVzIv+ZTpwtRRVPUrUICEDz2QDyM96DRhHTbFM8joPiipG81NfehJ4F3PUuN2Z4
         AQquaHmI8thGqzAztAcZhYQnadlsoy3lfdjEXJ5KPI4UqOqpdlMZKimnJ5R2eLOsI4ob
         hbydCQv7JY37sieO+HDVFkU8HO4IQs3V4lHZFf6WOA4NtbASzmdmHeZojIjqYep22tRj
         hwlMtvyc9RBrlcNmt5CwMrp3SU32P11odzW79jIfY/sVpmnLGCYqf1ACw/K0tG21SX5g
         TnOg==
X-Gm-Message-State: AJcUukcOuxwByftJGCLaEBeDyS4v34kXHxYDejz4kajqPNocrY+s6ar5
        f2yMZ3MSwxb+RwzH5ORiVzab78p+XgUvh8Sr
X-Google-Smtp-Source: ALg8bN5elXuSEA2MjDc+QDgosjT1hrCAiscg7+iWvSWzrviDbL5iqDIzzu52TGSTL84UFF9bEE9/vg==
X-Received: by 2002:a62:2b8b:: with SMTP id r133mr25739468pfr.246.1547477783503;
        Mon, 14 Jan 2019 06:56:23 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id r4sm970708pgn.54.2019.01.14.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 06:56:22 -0800 (PST)
Date:   Mon, 14 Jan 2019 20:26:16 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nishad Kamdar <nishadkamdar@gmail.com>
Subject: [PATCH v7 1/3] staging: greybus: gpio: switch GPIO portions to use
 GPIOLIB_IRQCHIP
Message-ID: <b547970693963d6e62845c7925a75ef68122f1ba.1547476997.git.nishadkamdar@gmail.com>
References: <cover.1547476997.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1547476997.git.nishadkamdar@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPIO driver to use the GPIO irqchip library
GPIOLIB_IRQCHIP instead of reimplementing the same.

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
Changes in v7:
 - No change.
Changes in v5:
 - Restore "struct irq_chip irqc" in "struct gb_gpio_controller"
   This is because we cannot use the gpio-chip irqchip, as that
   will register the irqchip automatically and possibly in an
   incompatible way.
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
 drivers/staging/greybus/gpio.c  | 156 ++------------------------------
 3 files changed, 11 insertions(+), 148 deletions(-)

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
index e110681e6f86..3151004d26fb 100644
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
@@ -39,11 +39,6 @@ struct gb_gpio_controller {
 
 	struct gpio_chip	chip;
 	struct irq_chip		irqc;
-	struct irq_chip		*irqchip;
-	struct irq_domain	*irqdomain;
-	unsigned int		irq_base;
-	irq_flow_handler_t	irq_handler;
-	unsigned int		irq_default_type;
 	struct mutex		irq_lock;
 };
 #define gpio_chip_to_gb_gpio_controller(chip) \
@@ -391,7 +386,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	irq = irq_find_mapping(ggc->irqdomain, event->which);
+	irq = irq_find_mapping(ggc->chip.irq.domain, event->which);
 	if (!irq) {
 		dev_err(dev, "failed to find IRQ\n");
 		return -EINVAL;
@@ -506,135 +501,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
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
@@ -694,7 +560,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	gpio->get = gb_gpio_get;
 	gpio->set = gb_gpio_set;
 	gpio->set_config = gb_gpio_set_config;
-	gpio->to_irq = gb_gpio_to_irq;
 	gpio->base = -1;		/* Allocate base dynamically */
 	gpio->ngpio = ggc->line_max + 1;
 	gpio->can_sleep = true;
@@ -703,24 +568,24 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
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
@@ -744,7 +609,6 @@ static void gb_gpio_remove(struct gbphy_device *gbphy_dev)
 
 	gb_connection_disable_rx(connection);
 	gpiochip_remove(&ggc->chip);
-	gb_gpio_irqchip_remove(ggc);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(ggc->lines);
-- 
2.17.1

