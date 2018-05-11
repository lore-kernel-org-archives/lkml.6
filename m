Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752413-1526034067-2-17210809382075889934
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
    1526034067; b=Nbvw8nzagqwOJEJvC/9O3WbowtnJtBKGjsS3XJp4Q8DgJuCVj+
    dta2X5IrAsPbQWLWnOgDkjxgjS/0+q02ulf32hhjGi4/JdPtaamOohUp7+Q6DTp/
    mrWjk58tEAqrhfLILGE3NSibyQncBHClERppXyrciKgO0l9GzJEtNsfSt+A7LRDu
    CebcCb9jp7nO0rcuALFZTM1DRSWBdjeoPodmXzCE9TH+71VmkRd4yAj2kDJqCpJ/
    29LMfq5Zekk4lz3pERi6Kiy/UHEHnmDMfJ71EmuItpqe3sio5lT6FgA+kCOoQ2WA
    rJwBh8nMunEA6O66iEbuvZtZwbbfjVL5egdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526034067; bh=
    lNK2+sc4RVSIKt+WgmvwkwKghPKwqSNojeq7Op5uILg=; b=iKFYhRV3+Hh75Y/U
    MEF/c5t/nar2rpK5YifMEdKCcKVlnOpm57tJKWdYAo+BEbvZVkacAqyHNYZXGQUi
    0998M7ITpIELOjmG3O2QF3QtnAYMiLYP6EVlkUKU7UprvAOvUXVNclPtQRGSi9+U
    5iksDV+owAV+AVqJ52OaS/jFKc1QwzbYc5eDGkTmnDXol38odlEy/0684o4WjTsE
    omxVbdESjbHVOJ+CQTfDpRTH40vCif3xbhgO/jOGTqnEXWwuq2Pn8qkYvk+3JkGv
    GW2bjeHMuwIllIfCHFurnApzptVXeTzBrKNGRhhRUW0vww9wA8coMjZWPnuqny5o
    ioi5UQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=sjZebSZd x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=H/f0894T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=sjZebSZd x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=H/f0894T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNna+9PsTVkrOk2jFBoQc1kqnpauHUiIia5KrUIAc2oiumMOspTvDjmV5jdB3ZAy5UyznY1dBKu34U7nrGLheAXul19269nO6HgNpmgwpEP2ZqsPBWUB
    xnB01dYB/27EX+6C2spraFUS4s4+Te811XKrEZyIkWfOygr+p3DqBJF7pi2ueK8JX4Ezk/1a7BRlEHjMM+lEG3tctpBVotGXd7nU8yYo48AF9j3ujpW19Eem
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=x7bEGLp0ZPQA:10 a=za2JL7ueGaoA:10
    a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=rxdpzU7rld3lb_cjp70A:9 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeEKKUg (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 06:20:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38059 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752841AbeEKKUd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 11 May 2018 06:20:33 -0400
X-Google-Smtp-Source: AB8JxZpYftRL+rpxKmfI+FRdiOt1dx0E9fTGTrHpH5nL9NroL/WjhOtkBx97UvUpmTajBsJeI9B0sQ==
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH v2 1/3] usb: gadget: udc: atmel: GPIO inversion is handled by gpiod
Date: Fri, 11 May 2018 12:19:54 +0200
Message-Id: <20180511101956.11782-2-romain.izard.pro@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180511101956.11782-1-romain.izard.pro@gmail.com>
References: <20180511101956.11782-1-romain.izard.pro@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When converting to GPIO descriptors, gpiod_get_value automatically
handles the line inversion flags from the device tree.

Do not invert the line twice.

Fixes: 3df034081021 ("usb: gadget: udc: atmel: convert to use GPIO descriptors")
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
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

