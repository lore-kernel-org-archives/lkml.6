Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AA1ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D11214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4KDFBzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D11214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbeIRGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44622 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729317AbeIRGRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so98678pff.11;
        Mon, 17 Sep 2018 17:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9fPmGeH09lvYWzOnYyXVlgxV08wm82k6fO9Keh58/Q=;
        b=W4KDFBzOokSQSjaoYFgqShO0Kntru5hAsbiQ2B1OcSqlGZ9h1y1PZMzqXhjoWx09VH
         6d0w/crTslpL6mX/ER5TxAQLIWDyPdEXK7gezyfUWPhNKJlH4zMnHyA61T0mujWfcJ8q
         YYWXGRzkTdGyBBM4cUpzpqwTgLIAxSoBzE3NM+HgLxguY+JnbE8RYS8k3jiOkdcbxn6y
         2ZL9XWhpXBUGU5Thbntt/lNVH5VTrsgua0ayKtc9iXVck1XdLqVvOlJbKZTeun+M3Gm2
         97MPQeBqiGbovF9Lu3xBAnzIxu4mp893cOHoQ2HL6ugoXFziW6NoXkjodW/HFYel+tuC
         69Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9fPmGeH09lvYWzOnYyXVlgxV08wm82k6fO9Keh58/Q=;
        b=AMMIx7nLMsdcyGFiuxw+poGRBgx8F95+eMFUX24iIQzCZaKg6hY1qBZ+riUlverNrt
         Sus4rLyRGPsv0vrIMdb5HPFQhdcFqapqNMt2tlxb7ywbeR9m13Glx2KRztRSU2O2Dl1g
         4ozQx3wGPBGw/ac264mRylVMuy2ri5i8P6YCrrj3NgskteQSZQkIuP1jUcQi5OLvKvYB
         fiukEBfWq3fOiDX2Jv7Y+6aZgIEAnJ0PA/6fQ++5mXmChOTxjILhbN3L0jUS6t3qjyOf
         Q0NwlaQw4D3XVJrwHaDPJ9KPYH/jDVwZ0mIJ3PoiKxPYBpU+Yw3iocholGPzJErqjcDP
         wAtw==
X-Gm-Message-State: APzg51BkaLd51kMIctnvc/B3qbOinCtOX/T9FRoVHEsnjEAIYMSf2mj0
        sPB/Nl3Zm11A938WoeGequYO/fz/
X-Google-Smtp-Source: ANB0Vdb+Ij37vctV+QHpsCgNHPfh/VEDa2QYFWNpyRezqXYbA/s1VeXBip2PSQDLMIzjYkmGuV/J/g==
X-Received: by 2002:a63:350f:: with SMTP id c15-v6mr10942237pga.206.1537231668796;
        Mon, 17 Sep 2018 17:47:48 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:47 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] Input: iforce - use DMA-safe buffer when getting IDs from USB
Date:   Mon, 17 Sep 2018 17:47:21 -0700
Message-Id: <20180918004732.9875-9-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working with USB devices we need to use DMA-safe buffers,
and iforce->edata is not one. Let's rework the code to allocate
temporary buffer (iforce_get_id() is called only during initialization
so there is no reason to have permanent buffer) and use it. While at it,
let's utilize usb_control_msg() API which simplifies code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-usb.c | 68 +++++++---------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 9d635f01cf19..cefaa1c5abc7 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -29,8 +29,7 @@ struct iforce_usb {
 
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
-	struct urb *irq, *out, *ctrl;
-	struct usb_ctrlrequest cr;
+	struct urb *irq, *out;
 };
 
 static void __iforce_usb_xmit(struct iforce *iforce)
@@ -92,30 +91,32 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 {
 	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
 						     iforce);
+	u8 *buf;
 	int status;
 
-	iforce_usb->cr.bRequest = packet[0];
-	iforce_usb->ctrl->dev = iforce_usb->usbdev;
-
-	status = usb_submit_urb(iforce_usb->ctrl, GFP_KERNEL);
-	if (status) {
+	buf = kmalloc(IFORCE_MAX_LENGTH, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	status = usb_control_msg(iforce_usb->usbdev,
+				 usb_rcvctrlpipe(iforce_usb->usbdev, 0),
+				 packet[0],
+				 USB_TYPE_VENDOR | USB_DIR_IN |
+					USB_RECIP_INTERFACE,
+				 0, 0, buf, IFORCE_MAX_LENGTH, HZ);
+	if (status < 0) {
 		dev_err(&iforce_usb->intf->dev,
-			"usb_submit_urb failed %d\n", status);
-		return -EIO;
-	}
-
-	wait_event_interruptible_timeout(iforce->wait,
-		iforce_usb->ctrl->status != -EINPROGRESS, HZ);
-
-	if (iforce_usb->ctrl->status) {
-		dev_dbg(&iforce_usb->intf->dev,
-			"iforce->ctrl->status = %d\n",
-			iforce_usb->ctrl->status);
-		usb_unlink_urb(iforce_usb->ctrl);
-		return -EIO;
+			"usb_submit_urb failed: %d\n", status);
+	} else if (buf[0] != packet[0]) {
+		status = -EIO;
+	} else {
+		iforce->ecmd = 0xff00 | status;
+		memcpy(iforce->edata, buf, status);
+		status = 0;
 	}
 
-	return -(iforce->edata[0] != packet[0]);
+	kfree(buf);
+	return status;
 }
 
 static int iforce_usb_start_io(struct iforce *iforce)
@@ -136,7 +137,6 @@ static void iforce_usb_stop_io(struct iforce *iforce)
 
 	usb_kill_urb(iforce_usb->irq);
 	usb_kill_urb(iforce_usb->out);
-	usb_kill_urb(iforce_usb->ctrl);
 }
 
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
@@ -197,18 +197,6 @@ static void iforce_usb_out(struct urb *urb)
 	wake_up(&iforce->wait);
 }
 
-static void iforce_usb_ctrl(struct urb *urb)
-{
-	struct iforce_usb *iforce_usb = urb->context;
-	struct iforce *iforce = &iforce_usb->iforce;
-
-	if (urb->status)
-		return;
-
-	iforce->ecmd = 0xff00 | urb->actual_length;
-	wake_up(&iforce->wait);
-}
-
 static int iforce_usb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -236,9 +224,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!(iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
-	if (!(iforce_usb->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
-		goto fail;
-
 	iforce = &iforce_usb->iforce;
 
 	iforce->xport_ops = &iforce_usb_xport_ops;
@@ -247,19 +232,12 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
 
-	iforce_usb->cr.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN | USB_RECIP_INTERFACE;
-	iforce_usb->cr.wIndex = 0;
-	iforce_usb->cr.wLength = cpu_to_le16(16);
-
 	usb_fill_int_urb(iforce_usb->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
 			iforce->data, 16, iforce_usb_irq, iforce_usb, epirq->bInterval);
 
 	usb_fill_int_urb(iforce_usb->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
 			iforce_usb + 1, 32, iforce_usb_out, iforce_usb, epout->bInterval);
 
-	usb_fill_control_urb(iforce_usb->ctrl, dev, usb_rcvctrlpipe(dev, 0),
-			(void*) &iforce_usb->cr, iforce->edata, 16, iforce_usb_ctrl, iforce_usb);
-
 	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
 		goto fail;
@@ -271,7 +249,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (iforce_usb) {
 		usb_free_urb(iforce_usb->irq);
 		usb_free_urb(iforce_usb->out);
-		usb_free_urb(iforce_usb->ctrl);
 		kfree(iforce_usb);
 	}
 
@@ -288,7 +265,6 @@ static void iforce_usb_disconnect(struct usb_interface *intf)
 
 	usb_free_urb(iforce_usb->irq);
 	usb_free_urb(iforce_usb->out);
-	usb_free_urb(iforce_usb->ctrl);
 
 	kfree(iforce_usb);
 }
-- 
2.19.0.397.gdd90340f6a-goog

