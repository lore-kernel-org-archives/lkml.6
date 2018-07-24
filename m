Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70928ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A87920852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bup4bshf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A87920852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbeGXDjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:39:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33564 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbeGXDje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:39:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id r5-v6so1743649pgv.0;
        Mon, 23 Jul 2018 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=47FTYTBUiS1s0bChhDRAFhTa8nvQdnds5VZNDDngRoA=;
        b=Bup4bshfSJ9jGc+I490DUiyVxX9GA7+A0IDiBglZnXB3wyXSFqae0L6EL6bS1Oe/Ch
         g3VcOKVcgEBNWOfUnApXPMk3pStmDBRQAX/mQw8w1xAcVev23TW/HU4/9jc8UTbxqOW1
         sbBlQStfiJJ2/CZ1yYCYBW8X1vPnfuEE8twnkyq7b442OZDsN+PEPZbEC2HuNDCj9rkf
         xKNWhQ9ojlhuLHQz9f3VtPhqp4aYLCBfOrA/TwpmZEJ+cfkG28ROFAw2ujHRpL7+OIV9
         N8a4cO1lNAdOiechmh5LKBUccMiyw59yLjpv5NCvutl04KcUyqFG3CCQNSRyEK1PTEvp
         +QQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=47FTYTBUiS1s0bChhDRAFhTa8nvQdnds5VZNDDngRoA=;
        b=BpOZZyXyCwayBCtYrylWf3EEFTh3CBTUX/pCGeXZLG/Ia6Pk42zID5RjHdk6FKluMF
         k2HuooHkQLoL8rlFYzYw6flZ4peHfuTi+PDnStE2+eLVdtJykdzXY0cWOT+y/edys3RY
         hdBRuuYAmI0Lk+86BsMYlXrbwlbCBb1d+qqzv25StxNxWDVLMUtMXxUr14JUdOpBcTYp
         Kn55cKvCz43W/p04J2w240TqIVd0Mcid0vDdlpinBw9LweJ1hNJBPbthQyvFRtlsbJkJ
         5QGvidc0UG+ABc8Q1zf4Oum1oZr6qHB5uOyuiSM7AMN1gwqIqqDd5kAIaYNyNi2KFpcM
         FwaQ==
X-Gm-Message-State: AOUpUlFSSYE1YUgf4XI9/a+bSLoozYVKmynMcFQVmg2al7w9QcJ3qQXm
        KnbH36+Nm/kwZxk+M26TVwc=
X-Google-Smtp-Source: AAOMgpdP3l3ZlGbrBFrgE37KZtK3ZSiaBZ0D7S9wwJxgAfZBTayMp9zzoExMXBEl74tbutxGbi7LOA==
X-Received: by 2002:a63:1063:: with SMTP id 35-v6mr14622169pgq.249.1532399725291;
        Mon, 23 Jul 2018 19:35:25 -0700 (PDT)
Received: from penguin.lxd ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20540942pfg.21.2018.07.23.19.35.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:35:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 2/5] Input: pxrc - fix freeing URB on device teardown
Date:   Tue, 24 Jul 2018 02:35:17 +0000
Message-Id: <20180724023520.2189-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

URB is the only resource that is not managed, and thus is destroyed too early,
before we unregister input device and stop URB in pxrc_close(). To fix it let's
install custom devm handler to free the URB at the right time in devm unwind
sequence.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 000b9b7da744..1560f0e39c34 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -119,49 +119,52 @@ static void pxrc_close(struct input_dev *input)
 	mutex_unlock(&pxrc->pm_mutex);
 }
 
+static void pxrc_free_urb(void *_pxrc)
+{
+	struct pxrc *pxrc = _pxrc;
+
+	usb_free_urb(pxrc->urb);
+}
+
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
-	int retval;
+	int error;
 
 	/* Set up the endpoint information */
 	/* This device only has an interrupt endpoint */
-	retval = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
-			NULL, NULL, &epirq, NULL);
-	if (retval) {
-		dev_err(&pxrc->intf->dev,
-			"Could not find endpoint\n");
-		goto error;
+	error = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+					  NULL, NULL, &epirq, NULL);
+	if (error) {
+		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		return error;
 	}
 
 	pxrc->bsize = usb_endpoint_maxp(epirq);
 	pxrc->epaddr = epirq->bEndpointAddress;
 	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->data)
+		return -ENOMEM;
 
 	usb_set_intfdata(pxrc->intf, pxrc);
 	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxrc->urb) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->urb)
+		return -ENOMEM;
+
+	error = devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc);
+	if (error)
+		return error;
 
 	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
 	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
 			 pxrc_usb_irq, pxrc, 1);
 
-error:
-	return retval;
-
-
+	return 0;
 }
 
 static int pxrc_input_init(struct pxrc *pxrc)
@@ -197,7 +200,7 @@ static int pxrc_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
-	int retval;
+	int error;
 
 	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
 	if (!pxrc)
@@ -206,29 +209,20 @@ static int pxrc_probe(struct usb_interface *intf,
 	mutex_init(&pxrc->pm_mutex);
 	pxrc->intf = intf;
 
-	retval = pxrc_usb_init(pxrc);
-	if (retval)
-		goto error;
+	error = pxrc_usb_init(pxrc);
+	if (error)
+		return error;
 
-	retval = pxrc_input_init(pxrc);
-	if (retval)
-		goto err_free_urb;
+	error = pxrc_input_init(pxrc);
+	if (error)
+		return error;
 
 	return 0;
-
-err_free_urb:
-	usb_free_urb(pxrc->urb);
-
-error:
-	return retval;
 }
 
 static void pxrc_disconnect(struct usb_interface *intf)
 {
-	struct pxrc *pxrc = usb_get_intfdata(intf);
-
-	usb_free_urb(pxrc->urb);
-	usb_set_intfdata(intf, NULL);
+	/* All driver resources are devm-managed. */
 }
 
 static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
-- 
2.11.0

