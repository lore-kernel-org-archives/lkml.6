Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1DE2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="AQvIUM2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfBTMUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:20:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39487 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbfBTMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:20:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id m11so17397575lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awZcUE8KjPx4JjfHwl+NUlW0cvkJAjQR4gtYqX8pG1Q=;
        b=AQvIUM2UJSjZFBFNmBiEQyPIT1k955/9GNyBhp3qYScYk6k6NvpWpYWldYKRTJDvV+
         lOGQ8VMYSvv1R7eEwv0NepBy/gAbuKobStR8qIKjUPmPTnmrvqFYhj3uouzZxSHY1Qv0
         NxlPd+9ztrnBIk/95fhFx6HM5YJ71+rZcIc5Vo43ltYFHeKIykl571qefDsCrrZg1Sxi
         yAxS+F9OQ19Rt3BUjnmb88JiJgpR/aEfIhPr5+QIXmbYfnFEJbxAE3uN3F2ZlGmcPLIm
         q9ax/LqlnUDJSsrdrRSPXcyooDXau5di4GqdN1VO/FlHJUVm5qWRlowXyqgNhD7sHz9n
         8jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awZcUE8KjPx4JjfHwl+NUlW0cvkJAjQR4gtYqX8pG1Q=;
        b=Z01mWDwTyMhhq7ad6yWNTemc/Dr8AbxRoWkDBz1BjiR7oNnN+cwdSItiYqdpDjmQZS
         dzEy3rT2/nak0a8B+Mo1mYrupiWaxOanZb6YzgT0mUdRDRSL+0MZwZwavPV3RcatgGwS
         nzWrrlQwX/zdkMiHq7n80BizFcBlqFzIo1Vk+3Hb0ztbshYoEkgWm9/FN3LQEYdreznh
         MxGGqAyfSxzg615SSZMY3rudRk3rDwHawiWicmrfBhgZ8nwwsSYaNCflkG+zD62foa3x
         jfM+J3v5oLLbFKE00d61MlVPuj6dVSOH950YcZ/GQs92zSSf9B6m+4MdRx2szsJBqrfp
         RdAw==
X-Gm-Message-State: AHQUAuaVmI48f1aJnJSULdaaOlkahMjEaNBMg7RrZherB4wqyr5asoPF
        To5Y/iVq7BK1PvfCw+7Efav4GhggWG0=
X-Google-Smtp-Source: AHgI3IZd0JognXw7W6uxoYeqpFE1xYGVtSv2MfMqLodRViW0Es2mKTbWuSzTbaQg+sJAXh9Ehfgsvg==
X-Received: by 2002:a19:f00c:: with SMTP id p12mr13898523lfc.12.1550665217158;
        Wed, 20 Feb 2019 04:20:17 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:20:16 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] usb: gadget: atmel: support USB suspend
Date:   Wed, 20 Feb 2019 13:20:00 +0100
Message-Id: <20190220122001.5713-3-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220122001.5713-1-jonas@norrbonn.se>
References: <20190220122001.5713-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for USB suspend to the Atmel UDC.

When suspended, the UDC clock can be stopped, resulting in some power
savings.  The "wake up" interrupt will fire irregardless of whether the
clock is running or not, allowing the UDC clock to be restarted when the
USB master wants to wake the device again.

The IRQ state of this device is somewhat fiddly.  The "wake up" IRQ
seems to actually be a "bus activity" indicator; the IRQ is almost
continuously asserted so enabling this IRQ should only be done after a
suspend when the wake IRQ becomes relevant.  Similarly, the "suspend"
IRQ detects "bus inactivity" and may therefore fire together with a
"wake" if the two types of activity coincide during the period between
two IRQ handler invocations; therefore, it's important to ignore the
"suspend" IRQ while waiting for a wake-up.

This has been tested on a SAMA5D2 board.

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Cristian Birsan <cristian.birsan@microchip.com>
CC: Felipe Balbi <balbi@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-usb@vger.kernel.org
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 55 ++++++++++++++++++++++---
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 +
 2 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 9d18fdddd9b2..740cb9308a86 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1703,6 +1703,9 @@ static void usba_dma_irq(struct usba_udc *udc, struct usba_ep *ep)
 	}
 }
 
+static int start_clock(struct usba_udc *udc);
+static void stop_clock(struct usba_udc *udc);
+
 static irqreturn_t usba_udc_irq(int irq, void *devid)
 {
 	struct usba_udc *udc = devid;
@@ -1720,10 +1723,13 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	DBG(DBG_INT, "irq, status=%#08x\n", status);
 
 	if (status & USBA_DET_SUSPEND) {
-		toggle_bias(udc, 0);
-		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND);
+		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND|USBA_WAKE_UP);
 		usba_int_enb_set(udc, USBA_WAKE_UP);
+		usba_int_enb_clear(udc, USBA_DET_SUSPEND);
+		udc->suspended = true;
+		toggle_bias(udc, 0);
 		udc->bias_pulse_needed = true;
+		stop_clock(udc);
 		DBG(DBG_BUS, "Suspend detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
 				&& udc->driver && udc->driver->suspend) {
@@ -1734,14 +1740,17 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	}
 
 	if (status & USBA_WAKE_UP) {
+		start_clock(udc);
 		toggle_bias(udc, 1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
-		usba_int_enb_clear(udc, USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
 
 	if (status & USBA_END_OF_RESUME) {
+		udc->suspended = false;
 		usba_writel(udc, INT_CLR, USBA_END_OF_RESUME);
+		usba_int_enb_clear(udc, USBA_WAKE_UP);
+		usba_int_enb_set(udc, USBA_DET_SUSPEND);
 		generate_bias_pulse(udc);
 		DBG(DBG_BUS, "Resume detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
@@ -1756,6 +1765,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (dma_status) {
 		int i;
 
+		usba_int_enb_set(udc, USBA_DET_SUSPEND);
+
 		for (i = 1; i <= USBA_NR_DMAS; i++)
 			if (dma_status & (1 << i))
 				usba_dma_irq(udc, &udc->usba_ep[i]);
@@ -1765,6 +1776,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (ep_status) {
 		int i;
 
+		usba_int_enb_set(udc, USBA_DET_SUSPEND);
+
 		for (i = 0; i < udc->num_ep; i++)
 			if (ep_status & (1 << i)) {
 				if (ep_is_control(&udc->usba_ep[i]))
@@ -1778,7 +1791,9 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		struct usba_ep *ep0, *ep;
 		int i, n;
 
-		usba_writel(udc, INT_CLR, USBA_END_OF_RESET);
+		usba_writel(udc, INT_CLR,
+			USBA_END_OF_RESET|USBA_END_OF_RESUME
+			|USBA_DET_SUSPEND|USBA_WAKE_UP);
 		generate_bias_pulse(udc);
 		reset_all_endpoints(udc);
 
@@ -1805,6 +1820,11 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 				| USBA_BF(BK_NUMBER, USBA_BK_NUMBER_ONE)));
 		usba_ep_writel(ep0, CTL_ENB,
 				USBA_EPT_ENABLE | USBA_RX_SETUP);
+
+		/* If we get reset while suspended... */
+		udc->suspended = false;
+		usba_int_enb_clear(udc, USBA_WAKE_UP);
+
 		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1) |
 				      USBA_DET_SUSPEND | USBA_END_OF_RESUME);
 
@@ -1872,9 +1892,19 @@ static int usba_start(struct usba_udc *udc)
 	if (ret)
 		return ret;
 
+	if (udc->suspended)
+		return 0;
+
 	spin_lock_irqsave(&udc->lock, flags);
 	toggle_bias(udc, 1);
 	usba_writel(udc, CTRL, USBA_ENABLE_MASK);
+	/* Clear all requested and pending interrupts... */
+	usba_writel(udc, INT_ENB, 0);
+	udc->int_enb_cache = 0;
+	usba_writel(udc, INT_CLR,
+		USBA_END_OF_RESET|USBA_END_OF_RESUME
+		|USBA_DET_SUSPEND|USBA_WAKE_UP);
+	/* ...and enable just 'reset' IRQ to get us started */
 	usba_int_enb_set(udc, USBA_END_OF_RESET);
 	spin_unlock_irqrestore(&udc->lock, flags);
 
@@ -1885,6 +1915,9 @@ static void usba_stop(struct usba_udc *udc)
 {
 	unsigned long flags;
 
+	if (udc->suspended)
+		return;
+
 	spin_lock_irqsave(&udc->lock, flags);
 	udc->gadget.speed = USB_SPEED_UNKNOWN;
 	reset_all_endpoints(udc);
@@ -1912,6 +1945,7 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 		if (vbus) {
 			usba_start(udc);
 		} else {
+			udc->suspended = false;
 			usba_stop(udc);
 
 			if (udc->driver->disconnect)
@@ -1975,6 +2009,7 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	if (fifo_mode == 0)
 		udc->configured_ep = 1;
 
+	udc->suspended = false;
 	usba_stop(udc);
 
 	udc->driver = NULL;
@@ -2288,6 +2323,7 @@ static int usba_udc_suspend(struct device *dev)
 	mutex_lock(&udc->vbus_mutex);
 
 	if (!device_may_wakeup(dev)) {
+		udc->suspended = false;
 		usba_stop(udc);
 		goto out;
 	}
@@ -2297,10 +2333,13 @@ static int usba_udc_suspend(struct device *dev)
 	 * to request vbus irq, assuming always on.
 	 */
 	if (udc->vbus_pin) {
+		/* FIXME: right to stop here...??? */
 		usba_stop(udc);
 		enable_irq_wake(gpiod_to_irq(udc->vbus_pin));
 	}
 
+	enable_irq_wake(udc->irq);
+
 out:
 	mutex_unlock(&udc->vbus_mutex);
 	return 0;
@@ -2314,8 +2353,12 @@ static int usba_udc_resume(struct device *dev)
 	if (!udc->driver)
 		return 0;
 
-	if (device_may_wakeup(dev) && udc->vbus_pin)
-		disable_irq_wake(gpiod_to_irq(udc->vbus_pin));
+	if (device_may_wakeup(dev)) {
+		if (udc->vbus_pin)
+			disable_irq_wake(gpiod_to_irq(udc->vbus_pin));
+
+		disable_irq_wake(udc->irq);
+	}
 
 	/* If Vbus is present, enable the controller and wait for reset */
 	mutex_lock(&udc->vbus_mutex);
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 58c96730e32e..24e6fbd3bb99 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -331,6 +331,7 @@ struct usba_udc {
 	struct usba_ep *usba_ep;
 	bool bias_pulse_needed;
 	bool clocked;
+	bool suspended;
 
 	u16 devstatus;
 
-- 
2.19.1

