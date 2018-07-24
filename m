Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F83ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F720875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRrhwViW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657F720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeGXDjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:39:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39363 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGXDjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:39:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so1732273pgs.6;
        Mon, 23 Jul 2018 19:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLSF+BmBzA82MKAwclF7qlR9x+wLogW6Okqt+cqPy0o=;
        b=lRrhwViW8bXd/hkcshQCAVaL3AzEHWAnMklq/bh8etHp/5zzpFLxvUMPilL3PrR+/K
         bHI7+NhnuUWMUJa0QVNjCqtmkaUPtkP6JGfd72dU5Fs2pIjyFCUL1RANka7phpeiT2JI
         F+w0Y0uqS6OcxzCdgdTl2pjB/V53yxUwoTIhYTQ/c2ApT792P4f+XqKCmtQQtMMbLkEL
         90/1ogzfKwJ67GCUUnE6R0dtFeHvv64bdRHoroRg4PvsD/hRkQwNRSEqXNad2cGGjmpT
         p8F7fzywJKob2+/NXhPN/uwY1KjmIEFPhr4WIz81XgzeiJOM5ZL7NW4lsIRKNiH1RD+p
         81mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLSF+BmBzA82MKAwclF7qlR9x+wLogW6Okqt+cqPy0o=;
        b=Ee5ePOexYEPUQl2tvTWGtPGTfNewgUWPwpbeCwgLFUCEnOIXIZUmVDHERqRGoHls0v
         dr+MbPQXJo91wKFPKo7BkI1vQutHHXEA/FDiHpaAMnUoegdoELvsM4wGdFAeP8G1enJn
         WBCWJntjeowu8Hbqki9YcqWNb9k2tCAwKYwCIBI+YJzW8vptqPWI7hnn4AISBq/+mqim
         pMz5CpQ7TXRYbxSTNDNFi9fYc8fbzslvYLCAMAu6bhDGnFpzlL5sVgMWWQHF0O8PLmV6
         ODd8TETKo1NydECQp0eTK9C5V2PsK/YhmnDUPlgSNaJCLzEiV4HKccVcV19hSVCeLrVg
         Wugg==
X-Gm-Message-State: AOUpUlGNLRqOjHz/RlFc1FRVIylhKiTUDkGymUnDVIalDzkBTfvxh9wT
        oTxePeCyItbm+s7pH7FqwY30my8Y
X-Google-Smtp-Source: AAOMgpdCXjS1pjr5881fA1ld6HGS0aDOQY8wvFs09P4TQ14baebWmxXLmQkrQIkYiFvAr7JdQn32xQ==
X-Received: by 2002:a65:5784:: with SMTP id b4-v6mr14748879pgr.315.1532399730467;
        Mon, 23 Jul 2018 19:35:30 -0700 (PDT)
Received: from penguin.lxd ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20540942pfg.21.2018.07.23.19.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:35:29 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 5/5] Input: pxrc - flatten probe code
Date:   Tue, 24 Jul 2018 02:35:20 +0000
Message-Id: <20180724023520.2189-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of splitting probe code into separate USB and input setup, flatten it.
This allows for easier inspection of order of set up steps, since the probe code
is reasonably small.

Move input-related initialization (phys) from USB block to input block.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 84 ++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 887a0df9d9a7..ea2bf5951d67 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -3,7 +3,6 @@
  * Driver for Phoenix RC Flight Controller Adapter
  *
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
- *
  */
 
 #include <linux/kernel.h>
@@ -16,8 +15,8 @@
 #include <linux/mutex.h>
 #include <linux/input.h>
 
-#define PXRC_VENDOR_ID	(0x1781)
-#define PXRC_PRODUCT_ID	(0x0898)
+#define PXRC_VENDOR_ID		0x1781
+#define PXRC_PRODUCT_ID		0x0898
 
 struct pxrc {
 	struct input_dev	*input;
@@ -118,59 +117,66 @@ static void pxrc_free_urb(void *_pxrc)
 	usb_free_urb(pxrc->urb);
 }
 
-static int pxrc_usb_init(struct pxrc *pxrc)
+static int pxrc_probe(struct usb_interface *intf,
+		      const struct usb_device_id *id)
 {
-	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct pxrc *pxrc;
 	struct usb_endpoint_descriptor *epirq;
 	size_t xfer_size;
 	void *xfer_buf;
-	unsigned int pipe;
 	int error;
 
-	/* Set up the endpoint information */
-	/* This device only has an interrupt endpoint */
-	error = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+	/*
+	 * Locate the endpoint information. This device only has an
+	 * interrupt endpoint.
+	 */
+	error = usb_find_common_endpoints(intf->cur_altsetting,
 					  NULL, NULL, &epirq, NULL);
 	if (error) {
-		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		dev_err(&intf->dev, "Could not find endpoint\n");
 		return error;
 	}
 
-	xfer_size = usb_endpoint_maxp(epirq);
-	xfer_buf = devm_kmalloc(&pxrc->intf->dev, xfer_size, GFP_KERNEL);
-	if (!xfer_buf)
+	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
+	if (!pxrc)
 		return -ENOMEM;
 
+	mutex_init(&pxrc->pm_mutex);
+	pxrc->intf = intf;
+
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+
+	xfer_size = usb_endpoint_maxp(epirq);
+	xfer_buf = devm_kmalloc(&intf->dev, xfer_size, GFP_KERNEL);
+	if (!xfer_buf)
+		return -ENOMEM;
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pxrc->urb)
 		return -ENOMEM;
 
-	error = devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc);
+	error = devm_add_action_or_reset(&intf->dev, pxrc_free_urb, pxrc);
 	if (error)
 		return error;
 
-	pipe = usb_rcvintpipe(udev, epirq->bEndpointAddress),
-	usb_fill_int_urb(pxrc->urb, udev, pipe, xfer_buf, xfer_size,
-			 pxrc_usb_irq, pxrc, 1);
+	usb_fill_int_urb(pxrc->urb, udev,
+			 usb_rcvintpipe(udev, epirq->bEndpointAddress),
+			 xfer_buf, xfer_size, pxrc_usb_irq, pxrc, 1);
 
-	return 0;
-}
-
-static int pxrc_input_init(struct pxrc *pxrc)
-{
-	pxrc->input = devm_input_allocate_device(&pxrc->intf->dev);
-	if (pxrc->input == NULL) {
-		dev_err(&pxrc->intf->dev, "couldn't allocate input device\n");
+	pxrc->input = devm_input_allocate_device(&intf->dev);
+	if (!pxrc->input) {
+		dev_err(&intf->dev, "couldn't allocate input device\n");
 		return -ENOMEM;
 	}
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
+
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
+	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(interface_to_usbdev(pxrc->intf), &pxrc->input->id);
+
+	usb_to_input_id(udev, &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -186,27 +192,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	input_set_drvdata(pxrc->input, pxrc);
 
-	return input_register_device(pxrc->input);
-}
-
-static int pxrc_probe(struct usb_interface *intf,
-		      const struct usb_device_id *id)
-{
-	struct pxrc *pxrc;
-	int error;
-
-	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
-	if (!pxrc)
-		return -ENOMEM;
-
-	mutex_init(&pxrc->pm_mutex);
-	pxrc->intf = intf;
-
-	error = pxrc_usb_init(pxrc);
-	if (error)
-		return error;
-
-	error = pxrc_input_init(pxrc);
+	error = input_register_device(pxrc->input);
 	if (error)
 		return error;
 
-- 
2.11.0

