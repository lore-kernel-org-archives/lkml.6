Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2863135-1523871350-2-17643981944707980837
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
    1523871350; b=iAOZbYb4P7eDXslLwSDKYLbCLU5BQFb7iZ/h2DyJF511wWT/JJ
    3GktPEODo0vieWdJ04kBV8/qllwI1YC5yXM8dQX9XTQj29I6lk+jqOTVltyf8BTi
    2J463hDrHLKC5c1hKXIUfbuBfgSTzppX+dmYBLHaXUjfbzZhFazk1rVQ/4KJ/VWm
    a1rZFsS67NybqUPczEk+aDmbyxfl58TGVaFeUOLBSkhpX4ZUXNk22Nhgaw+cuFJx
    Qjv/xG6kbJjf25ieTmU03833JwF71Yz/n8nwwNEArkmnKsGp/azAZQqgFuWvr5bx
    5loIBSaW6+QBtJ/jfe2vB2JamkB9I6F9oAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523871350; bh=
    P437n3LI4hymF5WVoqj1+q0aYfcbDiU2EWdb3cc9U8k=; b=jJ4lwkWuc6jLSZDD
    AuBSz1OuuT/Ff8qVHTIAmeEQXOR80ixUQ4CR0eh8MPKJo3hquOs4gna5zRVtZ5z+
    xHKS0TKc2V240e+K6XvZs+GX7a00Vspp/0g4a7gIMLyxiF0Co1M0JTYu4o156s3M
    cli9MsUPwnAm9AcKizFtyaLVgX01B2PsMEvXE62VodRvwmP9XA2zd2YJ3pi5fioL
    YgI2vF0Cbx8xyBHFW2llTYI9AprWtk84aFyz/ucbFrQRN7ZdzdTwXxgyZzXUfuKo
    EguCE0P7bq+ImodwDbMViofJsy1MHRLms2Uzw68yJein/NdDPw5YyR00+2RUvAA/
    Mw4n5Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uRS9qd0r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z1dIJ3V0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=uRS9qd0r x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z1dIJ3V0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDg/s0gbiruJegC3Y3EnM0l178M58Grz62jwYfLj0RlZCspQmzv9tIgTTKbfD0fxBoT8Qk2jnVGOlk2TSqQldMvfAq2iAgtF+4/4JWlVKQJcPw7Nl4h+
    BY2Cll+wG27r/qUIqWNSUMnyGhoheM0MLS21yS6G2MJi3rTeQeH7EGqjngQvV86VsTGpXBmIvtSH9dtj1+6b1HIxSgSs+QtENPodDjZOWl3J/Tug54JoUbMj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VJ0dqrtC0FBM701yIksA:9
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeDPJfE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 05:35:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43504 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754386AbeDPJfD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 05:35:03 -0400
X-Google-Smtp-Source: AIpwx4/gkdZkJvoRn+zqTRS0v4dpKL5xIb8rYaDRu/tdjjckGmf0gQCiVO2TKI6Tp0vSMl31RzK8Jw==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 1/3] usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
Date: Mon, 16 Apr 2018 11:34:03 +0200
Message-Id: <20180416093405.16612-2-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180416093405.16612-1-romain.izard.pro@gmail.com>
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When converting to GPIO descriptors, gpiod_get_value automatically
handles the line inversion flags from the device tree.

Do not invert the line twice.

Fixes: 3df034081021fa4b6967ce3364bc7d867ec1c870

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 3 +--
 drivers/usb/gadget/udc/atmel_usba_udc.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 27c16399c7e8..0fe3d0feb8f7 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -417,7 +417,7 @@ static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
 static int vbus_is_present(struct usba_udc *udc)
 {
 	if (udc->vbus_pin)
-		return gpiod_get_value(udc->vbus_pin) ^ udc->vbus_pin_inverted;
+		return gpiod_get_value(udc->vbus_pin);
 
 	/* No Vbus detection: Assume always present */
 	return 1;
@@ -2076,7 +2076,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
 						GPIOD_IN);
-	udc->vbus_pin_inverted = gpiod_is_active_low(udc->vbus_pin);
 
 	if (fifo_mode == 0) {
 		pp = NULL;
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 969ce8f3c3e2..d7eb7cf4fd5c 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -326,7 +326,6 @@ struct usba_udc {
 	const struct usba_udc_errata *errata;
 	int irq;
 	struct gpio_desc *vbus_pin;
-	int vbus_pin_inverted;
 	int num_ep;
 	int configured_ep;
 	struct usba_fifo_cfg *fifo_cfg;
-- 
2.14.1

