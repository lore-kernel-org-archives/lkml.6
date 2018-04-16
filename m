Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2863135-1523871341-2-648087037425803831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523871340; b=Np83BSli2AbT2XuGvGGik9n5oNkJBNuFVlnRpDPMIFiQ/sstZ5
    Gu/5fH7pzhDb+UFJ6TRcBXvUPNP58cZA39ZZ3PlTXMLxofDah6DUNlIUJG2osgQt
    SpdGr8kfhyz5KTjwMf2pDvGfftYkfSG8fbmvK3AfB9Kys6L/UaVqdpCYsNxCQA/3
    x8cJhTpPDyj9HnNkPBDRxP2H1og/o8tY7TEtR9OoLTilhLiJ+nbmE8xIwUVPGnIU
    Cmej7pwET/Frq2WP9bFsS+20iynzOc2qEDXK39r8aKyRPMfnSNpFE1NDZR+WdRlA
    aOvpzU+Bs5k89loqr2sroI0GgYt2EzdeWo1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523871340; bh=
    ndomcY730qpvljywNT3fZwFdtfgk4GPMTTh0WF4ZdvM=; b=aN6x7KBrET8TYQ2H
    LdcPWW7NJTYY+sIiTOqakEHP23HXoX7So5l7j3sqIyTeFrYXnlNehSa82a//uvh+
    W8gpSwOffZcLw9xHzQHlhPa8urq9ObRAiXK1oW+0JV0gNvab3N98JkP4sXEBnT7O
    GMJOB7YU7pfiJEii7EC13tVK2Z93gY81peqNL8XbrE1HHAYFcritc0u5CLPqtbSc
    iF4bBh+wFDks5zrNjxaPUxSecWyWCDXnoWAv8nZZ7KVtJfE3lvPPuVjPIY8A95FH
    7AHXTn7XOM5n1PhMJNPnXQe30xPFq6bznf7ytWmtnwRqHE/r1bVrfkjBuhpAL1na
    05hDAA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CByDKVMb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CVYGx6j2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CByDKVMb x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=CVYGx6j2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUJCPPViYK3GjWSTbGWYY6RafVfoxqlCx9jdUfD/8RuokgIQyVXFu0DeMIvXv09pQhNPj79+8xV4VVD3cMASbYVmRbcmgETEoMX/jIplseK22Y8jlSO
    ynwobh7VXWnOGl71FVa2hotbABb1DetlCdJOAiJijoyRQtCQ4nKi5f+RI0Rc38oEajdL8GXYIH8kpMWYjNZHqLKSsWZGAitOcoe8lBHif+wNQOGuGCNFBUi4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=LUq13_q-lkgHzjwGxDEA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752775AbeDPJfY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 05:35:24 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39406 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeDPJfI (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 05:35:08 -0400
X-Google-Smtp-Source: AIpwx4+9RKybvyuyFZl/dCx07YixCdhsIWcn30tU9SfFW3zym+03/7teOTVMaq3FzABQ4lTBjcFNRQ==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 3/3] usb: gadget: udc: atmel: Fix indenting
Date: Mon, 16 Apr 2018 11:34:05 +0200
Message-Id: <20180416093405.16612-4-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix the fallout of the conversion to GPIO descriptors in 3df034081021.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index b9623e228609..2f586f2bda7e 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2277,15 +2277,15 @@ static int usba_udc_probe(struct platform_device *pdev)
 	if (udc->vbus_pin) {
 		irq_set_status_flags(gpiod_to_irq(udc->vbus_pin), IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(&pdev->dev,
-					gpiod_to_irq(udc->vbus_pin), NULL,
-					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
-					"atmel_usba_udc", udc);
-			if (ret) {
-				udc->vbus_pin = NULL;
-				dev_warn(&udc->pdev->dev,
-					 "failed to request vbus irq; "
-					 "assuming always on\n");
-			}
+				gpiod_to_irq(udc->vbus_pin), NULL,
+				usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
+				"atmel_usba_udc", udc);
+		if (ret) {
+			udc->vbus_pin = NULL;
+			dev_warn(&udc->pdev->dev,
+				 "failed to request vbus irq; "
+				 "assuming always on\n");
+		}
 	}
 
 	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
-- 
2.14.1

