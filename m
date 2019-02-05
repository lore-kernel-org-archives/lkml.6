Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F39CC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F252083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="d3WKo8eB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbfBEK0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40327 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729135AbfBEKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:25:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so2973056wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/GL6TAVsAWMWv6rIhzwoCCzzRgo3ZMIcqFR/djAd6I=;
        b=d3WKo8eB3yRzuClYyGTdXU0QVvC+8MO/2cTApJ7QNZr4Q89dri92jyiteAPtxwYxpf
         7fv1gKogUJUyjhhc2yl6yXHClcOWPspuYPDwzIKER+Qr2LBm0TKG2SKYsxZGl+gyqnuc
         S6em5tcP0q3QFCLhEiu+tMWLM3Md+zUNaTFok2erBYb/I8hrthWdu2e4unrHW6yQHAqE
         o3r1uVTYVTnWnLyTpbXcgH/Wz0L3OQY9uHGHSD4Yw0gf5nsnjGOpSQffaIN4i4VdUu7X
         AhoalZvbCJ6dfzbOeHakNo/Z0Z/a84r1eqpFDi7/kwIfCKxa53/QYGgpqiUfq7F699/I
         dWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/GL6TAVsAWMWv6rIhzwoCCzzRgo3ZMIcqFR/djAd6I=;
        b=BthwLYHXM58JLflfAdzHhxDO+sv9FOqN3dPgQFB+8ffc/cz7yFR5w9YI0QcMxNqX3f
         LMKS+v4tqT8lTR5WKewoXhCej9smB81PNYgjSLf6SZNB6DiqbEmGGrrqtpbPee0yXza0
         JCav7udCiQZgIwE8GA8zNC2LW+TJrGb7eelsg/SadZ8VgO1TZEFL0GnyG6KhX9756RrL
         D+qytaWFZJ0b4izfj851tMdUcC4rWXTKyEhHyQGx4EJDFsIw34SWyGKwJn/Ml0DyE9Nc
         Zqzfgp01DzIUbAZJ98nnv1bTnUVpLZm3+n2EQDttmAqTti6ONgrDOHzOLGetaSF7rJEU
         URaQ==
X-Gm-Message-State: AHQUAuZujgg/xc4i61oeKKk7KUzcgdSdcrlApLaBnXAxT0lL2P23Z/4o
        os+gqHTf1FDyukmK5rRDEIFl+tTLIHs=
X-Google-Smtp-Source: AHgI3IboT4sJytApBlOT4oNjPmPFzKoGAT3aHPsK5SJ3CRAsX2jkrXCefUsNtMGSfW7Xr+RwMGtSOA==
X-Received: by 2002:a1c:e345:: with SMTP id a66mr3070901wmh.12.1549362356311;
        Tue, 05 Feb 2019 02:25:56 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:55 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 5/8] usb: ohci-da8xx: add vbus and overcurrent gpios
Date:   Tue,  5 Feb 2019 11:25:43 +0100
Message-Id: <20190205102546.29457-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are two users upstream which register external callbacks for
switching the port power on/off and overcurrent protection. Both
users only use two GPIOs for that. Instead of having that functionality
in the board files, move the logic into the OHCI driver - including
the interrupt handler for overcurrent detection.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 99 ++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index e8ede0b5e3f0..a4aa0c473c4f 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/jiffies.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -40,6 +41,8 @@ struct da8xx_ohci_hcd {
 	struct regulator *vbus_reg;
 	struct notifier_block nb;
 	unsigned int reg_enabled;
+	struct gpio_desc *vbus_gpio;
+	struct gpio_desc *oc_gpio;
 };
 
 #define to_da8xx_ohci(hcd) (struct da8xx_ohci_hcd *)(hcd_to_ohci(hcd)->priv)
@@ -86,12 +89,13 @@ static void ohci_da8xx_disable(struct usb_hcd *hcd)
 static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
+	struct device *dev = hcd->self.controller;
 	int ret;
 
-	if (hub && hub->set_power)
-		return hub->set_power(1, on);
+	if (da8xx_ohci->vbus_gpio) {
+		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, on);
+		return 0;
+	}
 
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
@@ -119,11 +123,9 @@ static int ohci_da8xx_set_power(struct usb_hcd *hcd, int on)
 static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->get_power)
-		return hub->get_power(1);
+	if (da8xx_ohci->vbus_gpio)
+		return gpiod_get_value_cansleep(da8xx_ohci->vbus_gpio);
 
 	if (da8xx_ohci->vbus_reg)
 		return regulator_is_enabled(da8xx_ohci->vbus_reg);
@@ -134,13 +136,11 @@ static int ohci_da8xx_get_power(struct usb_hcd *hcd)
 static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	unsigned int flags;
 	int ret;
 
-	if (hub && hub->get_oci)
-		return hub->get_oci(1);
+	if (da8xx_ohci->oc_gpio)
+		return gpiod_get_value_cansleep(da8xx_ohci->oc_gpio);
 
 	if (!da8xx_ohci->vbus_reg)
 		return 0;
@@ -158,10 +158,8 @@ static int ohci_da8xx_get_oci(struct usb_hcd *hcd)
 static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->set_power)
+	if (da8xx_ohci->vbus_gpio)
 		return 1;
 
 	if (da8xx_ohci->vbus_reg)
@@ -173,10 +171,8 @@ static int ohci_da8xx_has_set_power(struct usb_hcd *hcd)
 static int ohci_da8xx_has_oci(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 
-	if (hub && hub->get_oci)
+	if (da8xx_ohci->oc_gpio)
 		return 1;
 
 	if (da8xx_ohci->vbus_reg)
@@ -196,19 +192,6 @@ static int ohci_da8xx_has_potpgt(struct usb_hcd *hcd)
 	return 0;
 }
 
-/*
- * Handle the port over-current indicator change.
- */
-static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub,
-				    unsigned port)
-{
-	ocic_mask |= 1 << port;
-
-	/* Once over-current is detected, the port needs to be powered down */
-	if (hub->get_oci(port) > 0)
-		hub->set_power(port, 0);
-}
-
 static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 				unsigned long event, void *data)
 {
@@ -223,16 +206,23 @@ static int ohci_da8xx_regulator_event(struct notifier_block *nb,
 	return 0;
 }
 
+static irqreturn_t ohci_da8xx_oc_handler(int irq, void *data)
+{
+	struct da8xx_ohci_hcd *da8xx_ohci = data;
+
+	if (gpiod_get_value_cansleep(da8xx_ohci->oc_gpio))
+		gpiod_set_value_cansleep(da8xx_ohci->vbus_gpio, 0);
+
+	return IRQ_HANDLED;
+}
+
 static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci = to_da8xx_ohci(hcd);
 	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
 	int ret = 0;
 
-	if (hub && hub->ocic_notify) {
-		ret = hub->ocic_notify(ohci_da8xx_ocic_handler);
-	} else if (da8xx_ohci->vbus_reg) {
+	if (!da8xx_ohci->oc_gpio && da8xx_ohci->vbus_reg) {
 		da8xx_ohci->nb.notifier_call = ohci_da8xx_regulator_event;
 		ret = devm_regulator_register_notifier(da8xx_ohci->vbus_reg,
 						&da8xx_ohci->nb);
@@ -244,15 +234,6 @@ static int ohci_da8xx_register_notify(struct usb_hcd *hcd)
 	return ret;
 }
 
-static void ohci_da8xx_unregister_notify(struct usb_hcd *hcd)
-{
-	struct device *dev		= hcd->self.controller;
-	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
-
-	if (hub && hub->ocic_notify)
-		hub->ocic_notify(NULL);
-}
-
 static int ohci_da8xx_reset(struct usb_hcd *hcd)
 {
 	struct device *dev		= hcd->self.controller;
@@ -403,9 +384,9 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 {
 	struct da8xx_ohci_hcd *da8xx_ohci;
 	struct device *dev = &pdev->dev;
+	int error, hcd_irq, oc_irq;
 	struct usb_hcd	*hcd;
 	struct resource *mem;
-	int error, irq;
 
 	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, dev, dev_name(dev));
 	if (!hcd)
@@ -443,6 +424,27 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 		}
 	}
 
+	da8xx_ohci->vbus_gpio = devm_gpiod_get_optional(dev, "vbus",
+							GPIOD_OUT_HIGH);
+	if (IS_ERR(da8xx_ohci->vbus_gpio))
+		goto err;
+
+	da8xx_ohci->oc_gpio = devm_gpiod_get_optional(dev, "oc", GPIOD_IN);
+	if (IS_ERR(da8xx_ohci->oc_gpio))
+		goto err;
+
+	if (da8xx_ohci->oc_gpio) {
+		oc_irq = gpiod_to_irq(da8xx_ohci->oc_gpio);
+		if (oc_irq < 0)
+			goto err;
+
+		error = devm_request_irq(dev, oc_irq, ohci_da8xx_oc_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				"OHCI over-current indicator", da8xx_ohci);
+		if (error)
+			goto err;
+	}
+
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	hcd->regs = devm_ioremap_resource(dev, mem);
 	if (IS_ERR(hcd->regs)) {
@@ -452,13 +454,13 @@ static int ohci_da8xx_probe(struct platform_device *pdev)
 	hcd->rsrc_start = mem->start;
 	hcd->rsrc_len = resource_size(mem);
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	hcd_irq = platform_get_irq(pdev, 0);
+	if (hcd_irq < 0) {
 		error = -ENODEV;
 		goto err;
 	}
 
-	error = usb_add_hcd(hcd, irq, 0);
+	error = usb_add_hcd(hcd, hcd_irq, 0);
 	if (error)
 		goto err;
 
@@ -481,7 +483,6 @@ static int ohci_da8xx_remove(struct platform_device *pdev)
 {
 	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
 
-	ohci_da8xx_unregister_notify(hcd);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
-- 
2.20.1

