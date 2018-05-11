Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3782484-1526034086-2-11131350653260368924
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES roensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526034085; b=KqZ4hTc9aaTqZwfdCP5ihlfIPdiKp6oEB5d/w66KMRlonWC9Mx
    gikVKwCI5KW5h2b83MgkQY/YFpy+FiPf3UC9hHxalvUnpUpZAc6c2i8ICkBb47UK
    EaWjF7wYVpMB2XszMGhm0/gMHvDdJ1LwG9K4Ba9cZ6O7q2uFxtTcz4MVXudMjVoN
    JMESZvnQU4CbybE9C1c63jnvtvfY0nnUwDzj6bSkNnqdCP+erTdx4gZ6gKF4H5HO
    AHft5AuDh+2n8BvOSdPwGf9tKGUytEi3V/YmisRO+QpV7GVnUXnE7ut5AixQSrYO
    P25lZpEuDIgNIUCCLAOIgqHTQETvSVovRpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526034085; bh=
    uGutXilqH8lBHyW0LnG52av9HRf50XxCCgtq64kef1Y=; b=AVkw3Pn72H9MnJeU
    Uo6m1XaACBPrKRxJ14zaYHq1kfQ1zXE5J51v5E+EG4S4VUrSpvB4bBfpenyKppMw
    eeIC6gpVxb9uUn5gAgRHPNR6DNpd5KoZqs8FEwObc7o9JhF3dayHfsvRKKbQ8ygw
    JnIaZ97JpajiEcaTgWN9I2ac1M4a1lLTSgjKjAt3FXarPyJBOKL0EfkLkxb1Ey1Y
    caA7QWFu5dGxNFM2O7PgTJcz44o6aPuID8HfORgFr5Y2TwXtB0IbM5UJwuywXcoB
    HlFDHfOwAkPagK7WGv1BTaW/JxLyZELuBUXeXj+4ag7NvjIe8kVTNIWKfQ1CEyAH
    1IkQuw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=O9QqwmCt x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=FsNi+f/4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=O9QqwmCt x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=FsNi+f/4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKVveyPn+/tzTv8l0WkFQDWgIkyBOT+kf6761xzRfp/FrucxOavutCot5UIRZFhxi950eb61TTJH/ZtsQIJ3W5kmmmf0cxznx11fghnDOjbpKu4Ti46i
    VHJ3FI9oz9kChAFhfQr3qhOTvuIwNtmryy9fA2UWiCkPxKOzXScbwSqOrzkk5RQX/F6SfHOnoCRAn4NqktbfoSFeVvYV8uRPvqPa1aDk90q+MKSpxbT5We9n
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=HxwDzp8_ZsR2AWxVUicA:9 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeEKKVH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:21:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40503 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752894AbeEKKUf (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 11 May 2018 06:20:35 -0400
X-Google-Smtp-Source: AB8JxZo/6zLcVuha6lFRyzGUiMCdeqm7ob7TcyoMVaHQdrnbO9tLnwBkoM+33YHuyhTP/qviNcrp3w==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 2/3] usb: gadget: udc: atmel: Remove obsolete include
Date: Fri, 11 May 2018 12:19:55 +0200
Message-Id: <20180511101956.11782-3-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The include defines the private platform_data structure used with AVR
platforms. It has no user since 7c55984e191f. Remove it.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

