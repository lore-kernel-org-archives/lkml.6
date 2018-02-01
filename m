Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205632-1517477806-2-6473212701188757250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517477806; b=ZYQCuJmpyf/gghXQJ84HkwpuHbm9H+lu9BMupOEesqnUUlj
    Vcm3Z8OR1RQgQSMJZ0xPZUfCh1j8cephJ+yit0fMczPlcEXowrdcp/2vVdFEKPif
    oh2yfLPCEphamgdtzUcWDAzwpPzSleb4vw0CWUDUoj5ZT5pXO6Tq5eG+wWsHTdPq
    k+k3elteONnePkoRt1mrT4O6SptQDUf/eXCZ7yv9oBp3dnTtNwVD7tsQjqyzS5et
    cdRbNXd+5b7+Qms38VY1qGCKtzlRZsuVxklRuXLg6lLydJ/WRtvD/uUEqMDVxkUl
    JhJT8ugm/Mu3RPPl45qcZngBDw50+7xiona+Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517477806; bh=rfbMtgRThsxZmwEjDQ0Vmj3y92
    B5gBJ0bkXyoLEIFjk=; b=jkNj+A2BvEpOuKeELn1rNZAIyR6rO19zIle/NQK0fH
    ZN9r2sg+7wRn22s/zIMU3pLLMUskyPanVMGJOKEczbduKYxUyp1b7ky20s3jBQBn
    uwpsRjbj267Hy/TEOzXSG4PISpgFKzMKA12Q+RWkDdiJestErDGYvKDdASPeuUZq
    giQyrLat7jgqaNnzvzRO0p/NreJsLj+cWhjRKgM1zVloNaDop+Rnxc6fc8nUB4AD
    vNbUm+iYDo1b5ZN2+youm+5iod9yPn0p+zF1317ffF3cIAYHVpPZjwvcxKzzjtdP
    ZJX8VFEVHBSTD7+7diIYunXTNwaNvBmpY/kfKl2HL5Tg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeBAJgm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 04:36:42 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16810 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751522AbeBAJgX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 04:36:23 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511852400";
   d="scan'208";a="10737640"
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <nicolas.ferre@microchip.com>, <balbi@kernel.org>,
        <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 2/2] usb: gadget: udc: atmel: convert to use GPIO descriptors
Date: Thu, 1 Feb 2018 10:34:32 +0100
Message-ID: <20180201093432.21919-2-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180201093432.21919-1-ludovic.desroches@microchip.com>
References: <20180201093432.21919-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use GPIO descriptors instead of relying on the old method.
Include irq.h header since it is needed and was indirectly
included through of_gpio.h.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 51 ++++++++++++++-------------------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++-
 2 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index dc2604ec38f8..ddd49281b427 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -23,7 +23,8 @@
 #include <linux/usb/atmel_usba_udc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
+#include <linux/irq.h>
+#include <linux/gpio/consumer.h>
 
 #include "atmel_usba_udc.h"
 #define USBA_VBUS_IRQFLAGS (IRQF_ONESHOT \
@@ -415,8 +416,8 @@ static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
 
 static int vbus_is_present(struct usba_udc *udc)
 {
-	if (gpio_is_valid(udc->vbus_pin))
-		return gpio_get_value(udc->vbus_pin) ^ udc->vbus_pin_inverted;
+	if (udc->vbus_pin)
+		return gpiod_get_value(udc->vbus_pin) ^ udc->vbus_pin_inverted;
 
 	/* No Vbus detection: Assume always present */
 	return 1;
@@ -1975,8 +1976,8 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 
 	mutex_lock(&udc->vbus_mutex);
 
-	if (gpio_is_valid(udc->vbus_pin))
-		enable_irq(gpio_to_irq(udc->vbus_pin));
+	if (udc->vbus_pin)
+		enable_irq(gpiod_to_irq(udc->vbus_pin));
 
 	/* If Vbus is present, enable the controller and wait for reset */
 	udc->vbus_prev = vbus_is_present(udc);
@@ -1990,8 +1991,8 @@ static int atmel_usba_start(struct usb_gadget *gadget,
 	return 0;
 
 err:
-	if (gpio_is_valid(udc->vbus_pin))
-		disable_irq(gpio_to_irq(udc->vbus_pin));
+	if (udc->vbus_pin)
+		disable_irq(gpiod_to_irq(udc->vbus_pin));
 
 	mutex_unlock(&udc->vbus_mutex);
 
@@ -2006,8 +2007,8 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 {
 	struct usba_udc *udc = container_of(gadget, struct usba_udc, gadget);
 
-	if (gpio_is_valid(udc->vbus_pin))
-		disable_irq(gpio_to_irq(udc->vbus_pin));
+	if (udc->vbus_pin)
+		disable_irq(gpiod_to_irq(udc->vbus_pin));
 
 	if (fifo_mode == 0)
 		udc->configured_ep = 1;
@@ -2054,7 +2055,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 {
 	u32 val;
 	const char *name;
-	enum of_gpio_flags flags;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
 	struct device_node *pp;
@@ -2074,9 +2074,9 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->num_ep = 0;
 
-	udc->vbus_pin = of_get_named_gpio_flags(np, "atmel,vbus-gpio", 0,
-						&flags);
-	udc->vbus_pin_inverted = (flags & OF_GPIO_ACTIVE_LOW) ? 1 : 0;
+	udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
+						GPIOD_IN);
+	udc->vbus_pin_inverted = gpiod_is_active_low(udc->vbus_pin);
 
 	if (fifo_mode == 0) {
 		pp = NULL;
@@ -2239,7 +2239,6 @@ static int usba_udc_probe(struct platform_device *pdev)
 	udc->pdev = pdev;
 	udc->pclk = pclk;
 	udc->hclk = hclk;
-	udc->vbus_pin = -ENODEV;
 
 	ret = -ENOMEM;
 	udc->regs = devm_ioremap(&pdev->dev, regs->start, resource_size(regs));
@@ -2285,24 +2284,18 @@ static int usba_udc_probe(struct platform_device *pdev)
 	}
 	udc->irq = irq;
 
-	if (gpio_is_valid(udc->vbus_pin)) {
-		if (!devm_gpio_request(&pdev->dev, udc->vbus_pin, "atmel_usba_udc")) {
-			irq_set_status_flags(gpio_to_irq(udc->vbus_pin),
-					IRQ_NOAUTOEN);
-			ret = devm_request_threaded_irq(&pdev->dev,
-					gpio_to_irq(udc->vbus_pin), NULL,
+	if (udc->vbus_pin) {
+		irq_set_status_flags(gpiod_to_irq(udc->vbus_pin), IRQ_NOAUTOEN);
+		ret = devm_request_threaded_irq(&pdev->dev,
+					gpiod_to_irq(udc->vbus_pin), NULL,
 					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
 					"atmel_usba_udc", udc);
 			if (ret) {
-				udc->vbus_pin = -ENODEV;
+				udc->vbus_pin = NULL;
 				dev_warn(&udc->pdev->dev,
 					 "failed to request vbus irq; "
 					 "assuming always on\n");
 			}
-		} else {
-			/* gpio_request fail so use -EINVAL for gpio_is_valid */
-			udc->vbus_pin = -EINVAL;
-		}
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
@@ -2354,9 +2347,9 @@ static int usba_udc_suspend(struct device *dev)
 	 * Device may wake up. We stay clocked if we failed
 	 * to request vbus irq, assuming always on.
 	 */
-	if (gpio_is_valid(udc->vbus_pin)) {
+	if (udc->vbus_pin) {
 		usba_stop(udc);
-		enable_irq_wake(gpio_to_irq(udc->vbus_pin));
+		enable_irq_wake(gpiod_to_irq(udc->vbus_pin));
 	}
 
 out:
@@ -2372,8 +2365,8 @@ static int usba_udc_resume(struct device *dev)
 	if (!udc->driver)
 		return 0;
 
-	if (device_may_wakeup(dev) && gpio_is_valid(udc->vbus_pin))
-		disable_irq_wake(gpio_to_irq(udc->vbus_pin));
+	if (device_may_wakeup(dev) && udc->vbus_pin)
+		disable_irq_wake(gpiod_to_irq(udc->vbus_pin));
 
 	/* If Vbus is present, enable the controller and wait for reset */
 	mutex_lock(&udc->vbus_mutex);
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 860a00a6fdd0..969ce8f3c3e2 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -7,6 +7,8 @@
 #ifndef __LINUX_USB_GADGET_USBA_UDC_H__
 #define __LINUX_USB_GADGET_USBA_UDC_H__
 
+#include <linux/gpio/consumer.h>
+
 /* USB register offsets */
 #define USBA_CTRL				0x0000
 #define USBA_FNUM				0x0004
@@ -323,7 +325,7 @@ struct usba_udc {
 	struct platform_device *pdev;
 	const struct usba_udc_errata *errata;
 	int irq;
-	int vbus_pin;
+	struct gpio_desc *vbus_pin;
 	int vbus_pin_inverted;
 	int num_ep;
 	int configured_ep;
-- 
2.12.2

