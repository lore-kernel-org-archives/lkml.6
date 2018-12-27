Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DF2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148A52084A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 17:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/iNCpo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbeL0RVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 12:21:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42232 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeL0RVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 12:21:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so8982985plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 09:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A1Fk6XuZaJwDoJhSao1a3h1AAr188VgBL9TY1r4IONg=;
        b=S/iNCpo+jDTNam9kTN/+w4xynNAK4xe2hU55hWPSBnMFl1/kaCQN48S0orWUifPjAd
         b66WmYIxOv9LU6toBySy+Iv2gX1mhaUcbmrs28XZ+sgC48hsackxJyu9BkLaGFmbZZE7
         5cgvpQhp8chRkAha8AScFujnj8TJE5Wt5+OwP1QcfRtWEK18TBJUTUQT+ulRgUiiD8O5
         qEAo1EQhRIyhVD163WGUbmKwjB+9fU/EswgnMMUxsWwMCgEZsAQhpUpZlRYpKzcP+Nr4
         O/oFw7cNu2hDg/GCIoLSvx+TJ9CMafMj+nYvEad2XKGUxW96p8CznlopdQhJo9ABPQr1
         tFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A1Fk6XuZaJwDoJhSao1a3h1AAr188VgBL9TY1r4IONg=;
        b=s64+r3GFtodpO2gZCYJnr16cQK16v8o5lrP53saXUfhaQY7izNxJiXo2mRejuNbCIw
         oQkeeOvQ8Bfq8kp1hDoh/59r8+WJ6PNuGp+tGlQ/QXM78Hh41dTMFAQgse5C0r81NP8w
         FiS+78LvlTAa8cRWmV/jv/mcH2I1Al5t1YptKilPJJNigCKy93L6Yo/IgOAG2DMNTrAu
         9YLlO7h7pKo44UWX+6xHWtiy+F2rfhnAgKBFpoFS2g9a99/zcXwm5sRdFVm4O3N6iB0U
         Pe/4D8ibYfCBnjLnwn4BgT9Iwper5qtLEYjppdZ/knoRcXFyu00C/zBrNW5ssI8t/USC
         Bv6g==
X-Gm-Message-State: AJcUukcua6ag/oEg4ZDtTUtLuwkmK8urX4hhTNziuhF/Z9UlQIW/9aDa
        HcY37R3ojV3ifAk9Pulx11c=
X-Google-Smtp-Source: ALg8bN6Ox0w5ISv+Xdr6kQXmzRV02k0Fj7mbYydH7JHb0DaPL2f2tZSguYVkogDcJ2TkDTnElcGTwQ==
X-Received: by 2002:a17:902:7402:: with SMTP id g2mr23877762pll.198.1545931297483;
        Thu, 27 Dec 2018 09:21:37 -0800 (PST)
Received: from nishad ([106.51.25.107])
        by smtp.gmail.com with ESMTPSA id v12sm57121777pgg.41.2018.12.27.09.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 09:21:36 -0800 (PST)
Date:   Thu, 27 Dec 2018 22:51:29 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Carmeli Tamir <carmeli.tamir@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: emxx_udc: Switch to the gpio descriptor interface
Message-ID: <20181227172124.GA28790@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert VBUS GPIO to use GPIO descriptors from <linux/gpio/consumer.h>
and stop using the old GPIO API.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 31 +++++++++++++++--------------
 drivers/staging/emxx_udc/emxx_udc.h |  2 ++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 8e8f57c4f029..a913d40f0801 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -27,7 +27,7 @@
 #include <linux/usb/gadget.h>
 
 #include <linux/irq.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include "emxx_udc.h"
 
@@ -2220,7 +2220,7 @@ static inline void _nbu2ss_check_vbus(struct nbu2ss_udc *udc)
 	mdelay(VBUS_CHATTERING_MDELAY);		/* wait (ms) */
 
 	/* VBUS ON Check*/
-	reg_dt = gpio_get_value(VBUS_VALUE);
+	reg_dt = gpiod_get_value(vbus_gpio);
 	if (reg_dt == 0) {
 		udc->linux_suspended = 0;
 
@@ -2247,7 +2247,7 @@ static inline void _nbu2ss_check_vbus(struct nbu2ss_udc *udc)
 		}
 	} else {
 		mdelay(5);		/* wait (5ms) */
-		reg_dt = gpio_get_value(VBUS_VALUE);
+		reg_dt = gpiod_get_value(vbus_gpio);
 		if (reg_dt == 0)
 			return;
 
@@ -2311,7 +2311,7 @@ static inline void _nbu2ss_int_usb_suspend(struct nbu2ss_udc *udc)
 	u32	reg_dt;
 
 	if (udc->usb_suspended == 0) {
-		reg_dt = gpio_get_value(VBUS_VALUE);
+		reg_dt = gpiod_get_value(vbus_gpio);
 
 		if (reg_dt == 0)
 			return;
@@ -2351,7 +2351,7 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 	struct nbu2ss_udc	*udc = (struct nbu2ss_udc *)_udc;
 	struct fc_regs __iomem *preg = udc->p_regs;
 
-	if (gpio_get_value(VBUS_VALUE) == 0) {
+	if (gpiod_get_value(vbus_gpio) == 0) {
 		_nbu2ss_writel(&preg->USB_INT_STA, ~USB_INT_STA_RW);
 		_nbu2ss_writel(&preg->USB_INT_ENA, 0);
 		return IRQ_HANDLED;
@@ -2360,7 +2360,7 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 	spin_lock(&udc->lock);
 
 	for (;;) {
-		if (gpio_get_value(VBUS_VALUE) == 0) {
+		if (gpiod_get_value(vbus_gpio) == 0) {
 			_nbu2ss_writel(&preg->USB_INT_STA, ~USB_INT_STA_RW);
 			_nbu2ss_writel(&preg->USB_INT_ENA, 0);
 			status = 0;
@@ -2750,7 +2750,7 @@ static int nbu2ss_ep_fifo_status(struct usb_ep *_ep)
 
 	preg = udc->p_regs;
 
-	data = gpio_get_value(VBUS_VALUE);
+	data = gpiod_get_value(vbus_gpio);
 	if (data == 0)
 		return -EINVAL;
 
@@ -2790,7 +2790,7 @@ static void  nbu2ss_ep_fifo_flush(struct usb_ep *_ep)
 		return;
 	}
 
-	data = gpio_get_value(VBUS_VALUE);
+	data = gpiod_get_value(vbus_gpio);
 	if (data == 0)
 		return;
 
@@ -2832,7 +2832,7 @@ static int nbu2ss_gad_get_frame(struct usb_gadget *pgadget)
 	}
 
 	udc = container_of(pgadget, struct nbu2ss_udc, gadget);
-	data = gpio_get_value(VBUS_VALUE);
+	data = gpiod_get_value(vbus_gpio);
 	if (data == 0)
 		return -EINVAL;
 
@@ -2854,7 +2854,7 @@ static int nbu2ss_gad_wakeup(struct usb_gadget *pgadget)
 
 	udc = container_of(pgadget, struct nbu2ss_udc, gadget);
 
-	data = gpio_get_value(VBUS_VALUE);
+	data = gpiod_get_value(vbus_gpio);
 	if (data == 0) {
 		dev_warn(&pgadget->dev, "VBUS LEVEL = %d\n", data);
 		return -EINVAL;
@@ -3119,12 +3119,13 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 	}
 
 	/* VBUS Interrupt */
-	irq_set_irq_type(INT_VBUS, IRQ_TYPE_EDGE_BOTH);
-	status = request_irq(INT_VBUS,
+	vbus_irq = gpiod_to_irq(vbus_gpio);
+	irq_set_irq_type(vbus_irq, IRQ_TYPE_EDGE_BOTH);
+	status = request_irq(vbus_irq,
 			     _nbu2ss_vbus_irq, IRQF_SHARED, driver_name, udc);
 
 	if (status != 0) {
-		dev_err(udc->dev, "request_irq(INT_VBUS) failed\n");
+		dev_err(udc->dev, "request_irq(vbus_irq) failed\n");
 		return status;
 	}
 
@@ -3160,7 +3161,7 @@ static int nbu2ss_drv_remove(struct platform_device *pdev)
 	}
 
 	/* Interrupt Handler - Release */
-	free_irq(INT_VBUS, udc);
+	free_irq(vbus_irq, udc);
 
 	return 0;
 }
@@ -3201,7 +3202,7 @@ static int nbu2ss_drv_resume(struct platform_device *pdev)
 	if (!udc)
 		return 0;
 
-	data = gpio_get_value(VBUS_VALUE);
+	data = gpiod_get_value(vbus_gpio);
 	if (data) {
 		udc->vbus_active = 1;
 		udc->devstate = USB_STATE_POWERED;
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index e28a74da9633..b8c3dee5626c 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -30,6 +30,8 @@
 /* below hacked up for staging integration */
 #define GPIO_VBUS 0 /* GPIO_P153 on KZM9D */
 #define INT_VBUS 0 /* IRQ for GPIO_P153 */
+struct gpio_desc *vbus_gpio;
+int vbus_irq;
 
 /*------------ Board dependence(Wait) */
 
-- 
2.17.1

