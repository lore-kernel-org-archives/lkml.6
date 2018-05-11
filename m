Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752413-1526034050-2-8639480211324441680
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
    1526034049; b=AUVHYdcC7X8DpARy4q1V4iKBmZITRn7LU95dZ9jfh6WyouGoUo
    ObetZQpFY15ICdkdHwNzviAQvu772mH3wsYPcxKd+sBIgbrKnnaIb08wUS7czq5d
    T5zab8b+9COOnj6q9TfA+5WUeM+bwlnYgnLTKK4f7pfTMzAexowEVjEUSJ6Mlt2M
    E85EsemihmjQ7jPnUhDjIzrKsxuLrrRxUYtNSik4ySPX4zLdoIyRgiEn1saF9oqF
    BhBhphlUPWhHFSVuuuGXBgE4k3nnXzBOFPnLomABJX5b/MpbQjSLXGrl873HlWQf
    1Zsk0R1rU9utxJNIdqHMKzN+1sU+a5J+Skhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526034049; bh=
    vyDO9fdneG6gGaIoDsHBXUbPPVwFpCal7G+F7u+s2Hc=; b=dfRIzZLi+eVGK+H8
    Ponnt7LxZJuRF+JaJJ2ffFMAOhMaqLi0FpGZKMjci608brsiXNjPu6ZRdi7YzRLN
    uEx52VpAATv5SxyM3N/PL8SXkIYKvG/RACfPjS2FDC+I5EiuMQgKREyL/tYS7Nv/
    XdvSlrMJVkJqzvB+xgnKbtMHgXvc2/ghtCOPvKM6bfMXVvvHFQmHj8bvOtd1bAMg
    zaaTN5/lbM18xgyYPa0nHdcF1UDyf2FJQCoSbA6OoEVT/GhV6zXPI6v+LZMjigYP
    wcy9G97r/4LHPRApkQLabMGtOF4VFMcUYRQLcguKhQ1iQwUO7QdhgUW68lwjQV/Z
    0xrZWg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=evQq2t43 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=h1PURzpW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=evQq2t43 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=h1PURzpW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDd2AgLpAq+lIafkQ4rv6GXpFGuC3NW0XewsBsuW4csfQYnBQVvGsMenbGEdvhvIe9lwhJr+8x0+UCBg6Bj7Yh1lfP2lSdEcek9nNRF4GT6OfljatjVj
    x7Kra1ZmJjCit7BaX7cQgNK7ERpn9CCV3R5tV85ZGmg3oCWIgwITMGp0dWa15Na7zglZkXckGG8Kd2qJ5XWTYRMTuGnhB1RtJxPvSp77q4wpGdp7JEWQAZ9i
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=iJV5URIOCaHoMKCIuLQA:9 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeEKKUk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:20:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45109 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752925AbeEKKUh (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 11 May 2018 06:20:37 -0400
X-Google-Smtp-Source: AB8JxZptihyQt7/VQGQll3ItRviD+UQCk8eHCPQSWL/ANaI9EmiteGem/GpYFDUDaNgawOts1EbyMA==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 3/3] usb: gadget: udc: atmel: Fix indenting
Date: Fri, 11 May 2018 12:19:56 +0200
Message-Id: <20180511101956.11782-4-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix the fallout of the conversion to GPIO descriptors in 3df034081021.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

