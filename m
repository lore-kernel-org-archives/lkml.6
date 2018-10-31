Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521A72081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngcRJtrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521A72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeKACP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:15:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43508 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbeKACPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:15:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id h4-v6so7913552pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 10:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zc1khfAyWUBOdyCwV25jhN5KvcyQAnzVbTRxc9EZz0w=;
        b=ngcRJtrbPPju3/owhv5DE1bhMXH+J7tl5kR9fODo+O7gQbmnMlNFbDLAPO7jOMC3cG
         d2SWbPCp5cbiMEbA+UM3MaVmqgW9mg8GZUkxUVjGBo7uHIQgT0z9t8qjyG9b+/jXap52
         zPKMxFwbF4rV100XWb3czvsxi3QbHP+jZs280WPAG3DnmLdQoZU1x3tYDUB78L20D3/R
         eowrQwcwXPZy79YL3oUQBQdhZ9BkYMLfbSBPyx1Z0bXcrlAhTsanloI4qHCghbI8q9m2
         SQ/Pwuk93jWtTohqEJlCBIQrA8kXwEwF3Bgd0veipfWFrxJUjpr8dJqD212CdXBSudmv
         JQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zc1khfAyWUBOdyCwV25jhN5KvcyQAnzVbTRxc9EZz0w=;
        b=Q+SULxX1PD683wzvUYEOtyybjb7H/JaQzX6G1lCsTKqrULjr7yqo1m3zIELpH3e088
         ZcV8JsNZkM9pijOKcQ4VdFxwMKAXyMnaYpmtusEpOk5G3yckBpVQL8GIzfE6Mn9pXrR8
         Q0QQiAE8ro8aPxVBnV9bNqLCOP5k8WZ/sZdp1tE600JWra2V5hTma9CvmM1ACr4QBd/q
         9Q6/qAJ9uQRdbK6B3a8S3ZIelvToh6phxFe5CseHohNy+ohppSDrgVVIIZ2TegJoH4vj
         8nC7itf/FRlvOIvuYG6FOYDT2Nj8/TfPC5BETz3wHRldMrAQvyu+swmRI/0R2OzU25I6
         +uhQ==
X-Gm-Message-State: AGRZ1gJj5mUGPaq6Z1rDJTTehQ3SaqDARRsiXzXLsxx1uVQJwxpwnVb1
        bkVp4BwGN/kVHEwjiyZBxVk=
X-Google-Smtp-Source: AJdET5cyM914XxLo8m4lE4G+GTqNDanNpD/cwRPHhzTt0GlV+wMytVuoofaOnm8q4f6jSSc6Eulzmg==
X-Received: by 2002:a63:6c4a:: with SMTP id h71-v6mr3990075pgc.326.1541006220352;
        Wed, 31 Oct 2018 10:17:00 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id h2-v6sm5879263pfc.6.2018.10.31.10.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:16:59 -0700 (PDT)
Date:   Wed, 31 Oct 2018 22:46:54 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: gpio: switch GPIO portions to use GPIOLIB_IRQCHIP
Message-ID: <20181031171649.GA16800@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the GPIO driver to use the GPIO irqchip library
GPIOLIB_IRQCHIP instead of reimplementing the same.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/greybus/Kconfig |   1 +
 drivers/staging/greybus/gpio.c  | 123 ++++++--------------------------
 2 files changed, 21 insertions(+), 103 deletions(-)

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
index b1d4698019a1..32c228bad33a 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -9,9 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/gpio.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
+#include <linux/gpio/driver.h>
 #include <linux/mutex.h>
 
 #include "greybus.h"
@@ -40,8 +38,6 @@ struct gb_gpio_controller {
 	struct gpio_chip	chip;
 	struct irq_chip		irqc;
 	struct irq_chip		*irqchip;
-	struct irq_domain	*irqdomain;
-	unsigned int		irq_base;
 	irq_flow_handler_t	irq_handler;
 	unsigned int		irq_default_type;
 	struct mutex		irq_lock;
@@ -365,6 +361,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 {
 	struct gb_connection *connection = op->connection;
 	struct gb_gpio_controller *ggc = gb_connection_get_data(connection);
+	struct gpio_chip *gc = &ggc->chip;
 	struct device *dev = &ggc->gbphy_dev->dev;
 	struct gb_message *request;
 	struct gb_gpio_irq_event_request *event;
@@ -391,7 +388,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	irq = irq_find_mapping(ggc->irqdomain, event->which);
+	irq = irq_find_mapping(gc->irq.domain, event->which);
 	if (!irq) {
 		dev_err(dev, "failed to find IRQ\n");
 		return -EINVAL;
@@ -506,68 +503,6 @@ static int gb_gpio_controller_setup(struct gb_gpio_controller *ggc)
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
 /**
  * gb_gpio_irqchip_add() - adds an irqchip to a gpio chip
  * @chip: the gpio chip to add the irqchip to
@@ -595,8 +530,7 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
 			 unsigned int type)
 {
 	struct gb_gpio_controller *ggc;
-	unsigned int offset;
-	unsigned int irq_base;
+	unsigned int err;
 
 	if (!chip || !irqchip)
 		return -EINVAL;
@@ -606,35 +540,21 @@ static int gb_gpio_irqchip_add(struct gpio_chip *chip,
 	ggc->irqchip = irqchip;
 	ggc->irq_handler = handler;
 	ggc->irq_default_type = type;
-	ggc->irqdomain = irq_domain_add_simple(NULL,
-					ggc->line_max + 1, first_irq,
-					&gb_gpio_domain_ops, chip);
-	if (!ggc->irqdomain) {
-		ggc->irqchip = NULL;
-		return -EINVAL;
-	}
 
-	/*
-	 * Prepare the mapping since the irqchip shall be orthogonal to
-	 * any gpio calls. If the first_irq was zero, this is
-	 * necessary to allocate descriptors for all IRQs.
-	 */
-	for (offset = 0; offset < (ggc->line_max + 1); offset++) {
-		irq_base = irq_create_mapping(ggc->irqdomain, offset);
-		if (offset == 0)
-			ggc->irq_base = irq_base;
+	err = gpiochip_irqchip_add(chip,
+				   irqchip,
+				   first_irq,
+				   ggc->irq_handler,
+				   type
+				   );
+	if (err) {
+		ggc->irqchip = NULL;
+		return err;
 	}
 
 	return 0;
 }
 
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
@@ -693,7 +613,6 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
 	gpio->get = gb_gpio_get;
 	gpio->set = gb_gpio_set;
 	gpio->set_config = gb_gpio_set_config;
-	gpio->to_irq = gb_gpio_to_irq;
 	gpio->base = -1;		/* Allocate base dynamically */
 	gpio->ngpio = ggc->line_max + 1;
 	gpio->can_sleep = true;
@@ -702,24 +621,23 @@ static int gb_gpio_probe(struct gbphy_device *gbphy_dev,
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
+	ret = gb_gpio_irqchip_add(gpio, irqc, 0,
+				  handle_level_irq, IRQ_TYPE_NONE);
 	if (ret) {
-		dev_err(&gbphy_dev->dev, "failed to add gpio chip: %d\n", ret);
-		goto exit_gpio_irqchip_remove;
+		dev_err(&gbphy_dev->dev, "failed to add irq chip: %d\n", ret);
+		gpiochip_remove(gpio);
+		goto exit_line_free;
 	}
 
 	gbphy_runtime_put_autosuspend(gbphy_dev);
 	return 0;
 
-exit_gpio_irqchip_remove:
-	gb_gpio_irqchip_remove(ggc);
 exit_line_free:
 	kfree(ggc->lines);
 exit_connection_disable:
@@ -743,7 +661,6 @@ static void gb_gpio_remove(struct gbphy_device *gbphy_dev)
 
 	gb_connection_disable_rx(connection);
 	gpiochip_remove(&ggc->chip);
-	gb_gpio_irqchip_remove(ggc);
 	gb_connection_disable(connection);
 	gb_connection_destroy(connection);
 	kfree(ggc->lines);
-- 
2.17.1

