Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2871405-1523871326-2-14927458468872870057
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
    1523871325; b=efbLia+nWmUOhIj6g6hL79/IHzrAEwlgAuke0PK3J0jWmSq4T4
    LlqEWgl67Q9OcufYCsyPwfyXfHmBq2NMvYjnR0CGGZf6FNwrtKN0SqYILw5ixKNT
    SOzvY82DIgWx6WY9y/vs9VbFlqGwNueHJo107RIMZv8Z7r3QERxEkgCdwRVPPEZq
    pYD//BWISi1MrsMoeqc+nlySC4GvR5epkz5RohUfvnu0vMSzN+wk2nrl1coQcIY7
    dkBeZCf9jYeJP9oMP18MOI90wQiQzjKB3LsvaZiLn6vVqpbfdrofg6KQcHdj/TdN
    CxyMXdMTyXcgMf80ttSp4lbC/lZxu8+4XptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523871325; bh=
    zQp2urLoktqoQKBj+73Y3HQMvHK38S/CbZ6zFgPplFc=; b=kiP/MPi/paq/rFHe
    1v3Qa8T6GhFIU0+CEOvnihgbFrfLpbNM3tQohXy9gP3HABG57A8e4E2cDR/rJGQi
    FuI1557QXypF7b5LKWRGkJem8Rdvxhla98yBlYDbDRX1EtckrEtz2D9/7i1egoiF
    loTNRQToz6jDZ+2/T5w/LmYw+uDxKgSS2sIhZZMFVtEq0RWH7QPlTaSzIBZFWAQ5
    Rg8DFU2KPzwj56JC/jvVHwdGV0YDYiSXAy8Xq9GEsJX/aLfYmGq0bIbcFuZ0atNc
    Q7rSwcBTavo0H1DZ7PnFZ9iZUxCKxR3L50bRHwE2iAKT9rbY5XVW1KKGt5YiOTMR
    iJ5SnQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HRnriMv8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ntyVT4D1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=HRnriMv8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ntyVT4D1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOAY+aMNb24Cb8biK9LSP9wtprWT1BSeBxnjinhUcI4bbyD6Ojwv/DHOz4vcnLQ/bCKpV1TtPs+kLkSpLLVv+5wyk0f8u1OtGfPoR4mi5KgnYdFFYFlp
    XHcNSo4r2zpS34sbWiCIkzA+pgFQcDjxqWNK4nngxR0P3qfSdNZLOSp5848xnLrVHw1XeeE49EJuD2zPbViel2GQFjN4X6CNcUfmDZlcu70TO+0a0SzqbjGp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=HxwDzp8_ZsR2AWxVUicA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754491AbeDPJfI (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 05:35:08 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33715 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeDPJfF (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 05:35:05 -0400
X-Google-Smtp-Source: AIpwx49t8dxFYM1vF2iEQY9oqqbDxZdBHj/DBawRbaWqAJ7qCYTeJXPcCgutVlmlk6j8RZ8I6evu2g==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 2/3] usb: gadget: udc: atmel: Remove obsolete include
Date: Mon, 16 Apr 2018 11:34:04 +0200
Message-Id: <20180416093405.16612-3-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The include defines the private platform_data structure used with AVR
platforms. It has no user since 7c55984e191f. Remove it.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c |  1 -
 include/linux/usb/atmel_usba_udc.h      | 24 ------------------------
 2 files changed, 25 deletions(-)
 delete mode 100644 include/linux/usb/atmel_usba_udc.h

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 0fe3d0feb8f7..b9623e228609 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -20,7 +20,6 @@
 #include <linux/ctype.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
-#include <linux/usb/atmel_usba_udc.h>
 #include <linux/delay.h>
 #include <linux/of.h>
 #include <linux/irq.h>
diff --git a/include/linux/usb/atmel_usba_udc.h b/include/linux/usb/atmel_usba_udc.h
deleted file mode 100644
index 9bb00df3b53f..000000000000
--- a/include/linux/usb/atmel_usba_udc.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Platform data definitions for Atmel USBA gadget driver.
- */
-#ifndef __LINUX_USB_USBA_H
-#define __LINUX_USB_USBA_H
-
-struct usba_ep_data {
-	char	*name;
-	int	index;
-	int	fifo_size;
-	int	nr_banks;
-	int	can_dma;
-	int	can_isoc;
-};
-
-struct usba_platform_data {
-	int			vbus_pin;
-	int			vbus_pin_inverted;
-	int			num_ep;
-	struct usba_ep_data	ep[0];
-};
-
-#endif /* __LINUX_USB_USBA_H */
-- 
2.14.1

