Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205632-1517477797-2-18074178783691616712
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
    t=1517477797; b=f8KMwOv768wUEuEWYPcdOe3+o6kwpOnE/Cjew1LYhjAc05i
    BOSghHDSUxOXtGqU9L6Nqr+ld2LuE2EBjYGkaDrduKHZu8X4kdJ5ZYBmv8Bqkxtc
    nflSpFIgTlT4VUKrsTiTm5FfNwxEq52eSj4DjABHa8fuQzhlmPzRDYqEWUCQJL6j
    esv3PdLCl7xQOkwXRwqRDH6APMLLxAnd5bczTvZBbGw4sYYfiFieinTuj0IHpw6F
    b7B9Z4aj5Z/1dJfX0EiL/MB0uL+c78vKOk5wNThxpM704q70JbdOpB2j9562gszL
    r32vQcDAGrnGrxaVSQJ3EIHI1NTl3LZ2X245JIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1517477797; bh=jcAkEAx1PkVIheZt+YlX+RIA4mYM9QrAQ0WVKMgZouo=; b=m
    9hme4AWkeHsZv4Kq+qMqq+GDYOG6z0tejWDVfP5G4vhBMBBiJARooYZmr9kEgbRr
    j/t6qm298rsR6h3ZqpQq25lAb7fPLJxHgawfF1aDkdaRePxnjak9TjncID0svCQR
    WeT8isdrg6f4UgaMgtJhzxzw2IeGjiL6yhL/T8pmqtfBG/OTsGPfofC+pI1Yn6oW
    uAPKArulSPApNtEtXYKyqjrsXeki6O5RF5W2kmmR7izye0OkflYc6vxbHbCksyNN
    2HrxYS7Fppdfhg6mSjw98lmbo4p7iuFYyfH+zvlNQdUK2qoN5D3vrmNRUP+VsnHK
    x5reNwbShxSanzt0W/GTw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeBAJgY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 04:36:24 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:16810 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeBAJgV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 04:36:21 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511852400";
   d="scan'208";a="10737638"
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <nicolas.ferre@microchip.com>, <balbi@kernel.org>,
        <alexandre.belloni@free-electrons.com>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 1/2] usb: gadget: udc: atmel: remove code related to platform stuff
Date: Thu, 1 Feb 2018 10:34:31 +0100
Message-ID: <20180201093432.21919-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

With the removal of AVR platforms, code related to platform stuff
is useless.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 73 +--------------------------------
 1 file changed, 2 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 075eaaa8a408..dc2604ec38f8 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2019,7 +2019,6 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static void at91sam9rl_toggle_bias(struct usba_udc *udc, int is_on)
 {
 	regmap_update_bits(udc->pmc, AT91_CKGR_UCKR, AT91_PMC_BIASEN,
@@ -2204,71 +2203,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 err:
 	return ERR_PTR(ret);
 }
-#else
-static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
-						    struct usba_udc *udc)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif
-
-static struct usba_ep * usba_udc_pdata(struct platform_device *pdev,
-						 struct usba_udc *udc)
-{
-	struct usba_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct usba_ep *eps;
-	int i;
-
-	if (!pdata)
-		return ERR_PTR(-ENXIO);
-
-	eps = devm_kzalloc(&pdev->dev, sizeof(struct usba_ep) * pdata->num_ep,
-			   GFP_KERNEL);
-	if (!eps)
-		return ERR_PTR(-ENOMEM);
-
-	udc->gadget.ep0 = &eps[0].ep;
-
-	udc->vbus_pin = pdata->vbus_pin;
-	udc->vbus_pin_inverted = pdata->vbus_pin_inverted;
-	udc->num_ep = pdata->num_ep;
-
-	INIT_LIST_HEAD(&eps[0].ep.ep_list);
-
-	for (i = 0; i < pdata->num_ep; i++) {
-		struct usba_ep *ep = &eps[i];
-
-		ep->ep_regs = udc->regs + USBA_EPT_BASE(i);
-		ep->dma_regs = udc->regs + USBA_DMA_BASE(i);
-		ep->fifo = udc->fifo + USBA_FIFO_BASE(i);
-		ep->ep.ops = &usba_ep_ops;
-		ep->ep.name = pdata->ep[i].name;
-		ep->fifo_size = pdata->ep[i].fifo_size;
-		usb_ep_set_maxpacket_limit(&ep->ep, ep->fifo_size);
-		ep->udc = udc;
-		INIT_LIST_HEAD(&ep->queue);
-		ep->nr_banks = pdata->ep[i].nr_banks;
-		ep->index = pdata->ep[i].index;
-		ep->can_dma = pdata->ep[i].can_dma;
-		ep->can_isoc = pdata->ep[i].can_isoc;
-
-		if (i == 0) {
-			ep->ep.caps.type_control = true;
-		} else {
-			ep->ep.caps.type_iso = ep->can_isoc;
-			ep->ep.caps.type_bulk = true;
-			ep->ep.caps.type_int = true;
-		}
-
-		ep->ep.caps.dir_in = true;
-		ep->ep.caps.dir_out = true;
-
-		if (i)
-			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
-	}
-
-	return eps;
-}
 
 static int usba_udc_probe(struct platform_device *pdev)
 {
@@ -2335,10 +2269,7 @@ static int usba_udc_probe(struct platform_device *pdev)
 	usba_writel(udc, CTRL, USBA_DISABLE_MASK);
 	clk_disable_unprepare(pclk);
 
-	if (pdev->dev.of_node)
-		udc->usba_ep = atmel_udc_of_init(pdev, udc);
-	else
-		udc->usba_ep = usba_udc_pdata(pdev, udc);
+	udc->usba_ep = atmel_udc_of_init(pdev, udc);
 
 	toggle_bias(udc, 0);
 
@@ -2462,7 +2393,7 @@ static struct platform_driver udc_driver = {
 	.driver		= {
 		.name		= "atmel_usba_udc",
 		.pm		= &usba_udc_pm_ops,
-		.of_match_table	= of_match_ptr(atmel_udc_dt_ids),
+		.of_match_table	= atmel_udc_dt_ids,
 	},
 };
 
-- 
2.12.2

