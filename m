Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07970C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78A2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="rcZPB63i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfBTMUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:20:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39172 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfBTMUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:20:18 -0500
Received: by mail-lj1-f194.google.com with SMTP id g80so20601843ljg.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tfaveN+cB7E5HOlJgyDgTMgL0/lTVFeedC/fRB32HM=;
        b=rcZPB63i2KLSDRTv4dfIm0pYaDVSEWk2ftBAFZ5fQiWWpsvgnugh0UFD8H/MAFQxoP
         WKvEA2nGC/KALsMZs59ZhZ4icC5kAL3EWINnB0ZOWUM1ts4K2685ou91VqDOkObqnd4Z
         +4O95qIJbKM+2UyjjQLYFComGRQDuSARUqX7Or7dR6bi88PdyQzxm8cxHcv6NLPkSS2P
         YpRP4i+q1pHuEWCnaWSBooey7eQvRpWhZcdg9BVGZrBq51luxbdk2dx0X9NdYzxIFld8
         2fPkQ50aPdFAH0zQ937IX/xiTgg+McFG5174MEfm4/4dsDa6Kbn80z0/IJUqP2nbfvCU
         HUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tfaveN+cB7E5HOlJgyDgTMgL0/lTVFeedC/fRB32HM=;
        b=AD5bzbpIyN9SNuph18YY5pFq9bogH9WbfiBQJlf9cxVmu131yOEpra4Hc9MVlICl2P
         jhFLBCkA+VksNlII7ef8yljprLcKuHzLYb8WjySfi/sz/ouFCLefaIAMNRQfWpxoP4QH
         Bt/qYJY1auXk1cB7UvP8wLJ4QmopkT9slH9D7dPs9L3iwFxXsqm340Oa6PusuxMMK8iu
         Wx5mwCDWOkCmPV+a56r0M9f4boOFKzi+7Y9SfA45mo+Gta36FuYA2XI2+1eRmdYNCCd2
         d6pihZo3liH15zWqA5gPdApkciEOqoym75yhbazV1M3RLGjfJG9x57Wx4jwmC18XzUQe
         VK+A==
X-Gm-Message-State: AHQUAuZjTcFuBIC8wBIZ8w9ALntPLloRtxjWmoFP5Apx0K+NZa5Amuc7
        7S0+nww1pGhkYi096jxsDXc4Hmr+jmE=
X-Google-Smtp-Source: AHgI3IYrQCiIUhsZpbt8/7/4ODJ5cjLPuMl//ZxG1g9HQl9PseFR2rWgHZDdYv+Lfcg6hfP7jUYVww==
X-Received: by 2002:a2e:9b95:: with SMTP id z21mr3226407lji.155.1550665215496;
        Wed, 20 Feb 2019 04:20:15 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id r2-v6sm5270270lja.78.2019.02.20.04.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 04:20:15 -0800 (PST)
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
Subject: [PATCH 1/3] usb: gadget: atmel_usba_udc: simplify setting of interrupt-enabled mask
Date:   Wed, 20 Feb 2019 13:19:59 +0100
Message-Id: <20190220122001.5713-2-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190220122001.5713-1-jonas@norrbonn.se>
References: <20190220122001.5713-1-jonas@norrbonn.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds set and clear functions for enabling/disabling
interrupts.  This simplifies the implementation a bit as the masking of
previously set bits doesn't need to be so explicit.

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
 drivers/usb/gadget/udc/atmel_usba_udc.c | 29 ++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 51a2b9232baa..9d18fdddd9b2 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -358,8 +358,20 @@ static inline u32 usba_int_enb_get(struct usba_udc *udc)
 	return udc->int_enb_cache;
 }
 
-static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
+static inline void usba_int_enb_set(struct usba_udc *udc, u32 mask)
 {
+	u32 val;
+
+	val = udc->int_enb_cache | mask;
+	usba_writel(udc, INT_ENB, val);
+	udc->int_enb_cache = val;
+}
+
+static inline void usba_int_enb_clear(struct usba_udc *udc, u32 mask)
+{
+	u32 val;
+
+	val = udc->int_enb_cache & ~mask;
 	usba_writel(udc, INT_ENB, val);
 	udc->int_enb_cache = val;
 }
@@ -629,14 +641,12 @@ usba_ep_enable(struct usb_ep *_ep, const struct usb_endpoint_descriptor *desc)
 	if (ep->can_dma) {
 		u32 ctrl;
 
-		usba_int_enb_set(udc, usba_int_enb_get(udc) |
-				      USBA_BF(EPT_INT, 1 << ep->index) |
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1 << ep->index) |
 				      USBA_BF(DMA_INT, 1 << ep->index));
 		ctrl = USBA_AUTO_VALID | USBA_INTDIS_DMA;
 		usba_ep_writel(ep, CTL_ENB, ctrl);
 	} else {
-		usba_int_enb_set(udc, usba_int_enb_get(udc) |
-				      USBA_BF(EPT_INT, 1 << ep->index));
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1 << ep->index));
 	}
 
 	spin_unlock_irqrestore(&udc->lock, flags);
@@ -680,8 +690,7 @@ static int usba_ep_disable(struct usb_ep *_ep)
 		usba_dma_readl(ep, STATUS);
 	}
 	usba_ep_writel(ep, CTL_DIS, USBA_EPT_ENABLE);
-	usba_int_enb_set(udc, usba_int_enb_get(udc) &
-			      ~USBA_BF(EPT_INT, 1 << ep->index));
+	usba_int_enb_clear(udc, USBA_BF(EPT_INT, 1 << ep->index));
 
 	request_complete_list(ep, &req_list, -ESHUTDOWN);
 
@@ -1713,7 +1722,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (status & USBA_DET_SUSPEND) {
 		toggle_bias(udc, 0);
 		usba_writel(udc, INT_CLR, USBA_DET_SUSPEND);
-		usba_int_enb_set(udc, int_enb | USBA_WAKE_UP);
+		usba_int_enb_set(udc, USBA_WAKE_UP);
 		udc->bias_pulse_needed = true;
 		DBG(DBG_BUS, "Suspend detected\n");
 		if (udc->gadget.speed != USB_SPEED_UNKNOWN
@@ -1727,7 +1736,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 	if (status & USBA_WAKE_UP) {
 		toggle_bias(udc, 1);
 		usba_writel(udc, INT_CLR, USBA_WAKE_UP);
-		usba_int_enb_set(udc, int_enb & ~USBA_WAKE_UP);
+		usba_int_enb_clear(udc, USBA_WAKE_UP);
 		DBG(DBG_BUS, "Wake Up CPU detected\n");
 	}
 
@@ -1796,7 +1805,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 				| USBA_BF(BK_NUMBER, USBA_BK_NUMBER_ONE)));
 		usba_ep_writel(ep0, CTL_ENB,
 				USBA_EPT_ENABLE | USBA_RX_SETUP);
-		usba_int_enb_set(udc, int_enb | USBA_BF(EPT_INT, 1) |
+		usba_int_enb_set(udc, USBA_BF(EPT_INT, 1) |
 				      USBA_DET_SUSPEND | USBA_END_OF_RESUME);
 
 		/*
-- 
2.19.1

