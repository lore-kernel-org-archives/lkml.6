Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F3FECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36B1214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBMfc05c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36B1214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeIRGRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33139 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeIRGRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so114756plb.0;
        Mon, 17 Sep 2018 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FgPl4w9HaMfmh7DcHLhKWt4fytbo9xppMylF8EnTB4g=;
        b=iBMfc05cYiFtjmi6BKkq+GqRLEGJ07/ySa23o9iq2HAgsyOQS8MFolQwpGOy89SbZw
         6f0sV2+WfbL2+LoFEMJJICNErqjcFuWundogy84LTkAMeL1ZEXHfM/wpzpujO4MlZ+BK
         WOqgyyEbjq7O2QDV0NOfg16w3fcwnrNe1e9j8D+R4OxA4+/xxEDLvmZK837ZK/0qnL8/
         2yXsPEU0r3NIXHNLUT2VlsNL+TNjuIWuEQ6IxykUTgpxRi6U+HOX80F74IUWKEYu7kJz
         go4VBQrazw0FMeQEPK0AUHqXf8FMNva1Y6UppB6I1po/HZ0ifeVWoOwnMhE/oBGlKuCA
         nHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FgPl4w9HaMfmh7DcHLhKWt4fytbo9xppMylF8EnTB4g=;
        b=lr0YkiAzQNNHuaLnUFRgDXOe/J340i66IvCONkrHQ2330AryPVL6qUHnuF6tnjotbv
         AoD3Lp/7lnEW4u2zevuedXm4MGFHEolY0wG98l1kWSYW04+6iEX/Ag6+oJn5MxKskem0
         IuAPlVXB61lZqFjk4oMjk+HvV5QL+43FwxOeCsb5S2sAPsnxX8xkDXvhHqTwVJFM2sW4
         f6SutQcBDJWmu9GRXPaRn1q6b4IkGzYXi6iUZxB6X27KfcMeJjjDf3fEw3YwtSHJhODg
         A95HhvGtGB9lofY13XWDC7kdcN9WBgn1maftceI9+C7R7zXfxCVHE4bDW13TEbOzNXhX
         Qg/Q==
X-Gm-Message-State: APzg51AhUpCeRgOgycMIT36KAy+tXvtKUvkyBzl9WvvDTnPAkvy3uO4h
        ejA17J4/ZL6gAX6QTJ809OM1nfxH
X-Google-Smtp-Source: ANB0Vdbvns3DTEBwzkeQtbUIvdodPN7GBXBcgw9CLmvFDow9SN25YaAfVruO8dP9wmIL92oWtOsH9g==
X-Received: by 2002:a17:902:3c5:: with SMTP id d63-v6mr26763447pld.145.1537231665987;
        Mon, 17 Sep 2018 17:47:45 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:44 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/20] Input: iforce - move transport data into transport modules
Date:   Mon, 17 Sep 2018 17:47:19 -0700
Message-Id: <20180918004732.9875-7-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves transport-specific data from main iforce structure into
transport modules.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c |  96 ++++++++-----
 drivers/input/joystick/iforce/iforce-usb.c   | 138 +++++++++++--------
 drivers/input/joystick/iforce/iforce.h       |  14 +-
 3 files changed, 144 insertions(+), 104 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index b5dea273f98e..6ff1bbeeb494 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -23,8 +23,20 @@
 
 #include "iforce.h"
 
+struct iforce_serio {
+	struct iforce iforce;
+
+	struct serio *serio;
+	int idx, pkt, len, id;
+	u8 csum;
+	u8 expect_packet;
+};
+
 static void iforce_serio_xmit(struct iforce *iforce)
 {
+	struct iforce_serio *iforce_serio = container_of(iforce,
+							 struct iforce_serio,
+							 iforce);
 	unsigned char cs;
 	int i;
 	unsigned long flags;
@@ -45,19 +57,20 @@ static void iforce_serio_xmit(struct iforce *iforce)
 
 	cs = 0x2b;
 
-	serio_write(iforce->serio, 0x2b);
+	serio_write(iforce_serio->serio, 0x2b);
 
-	serio_write(iforce->serio, iforce->xmit.buf[iforce->xmit.tail]);
+	serio_write(iforce_serio->serio, iforce->xmit.buf[iforce->xmit.tail]);
 	cs ^= iforce->xmit.buf[iforce->xmit.tail];
 	XMIT_INC(iforce->xmit.tail, 1);
 
 	for (i=iforce->xmit.buf[iforce->xmit.tail]; i >= 0; --i) {
-		serio_write(iforce->serio, iforce->xmit.buf[iforce->xmit.tail]);
+		serio_write(iforce_serio->serio,
+			    iforce->xmit.buf[iforce->xmit.tail]);
 		cs ^= iforce->xmit.buf[iforce->xmit.tail];
 		XMIT_INC(iforce->xmit.tail, 1);
 	}
 
-	serio_write(iforce->serio, cs);
+	serio_write(iforce_serio->serio, cs);
 
 	if (test_and_clear_bit(IFORCE_XMIT_AGAIN, iforce->xmit_flags))
 		goto again;
@@ -69,14 +82,18 @@ static void iforce_serio_xmit(struct iforce *iforce)
 
 static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
 {
-	iforce->expect_packet = FF_CMD_QUERY;
+	struct iforce_serio *iforce_serio = container_of(iforce,
+							 struct iforce_serio,
+							 iforce);
+
+	iforce_serio->expect_packet = HI(FF_CMD_QUERY);
 	iforce_send_packet(iforce, FF_CMD_QUERY, packet);
 
 	wait_event_interruptible_timeout(iforce->wait,
-					 !iforce->expect_packet, HZ);
+					 !iforce_serio->expect_packet, HZ);
 
-	if (iforce->expect_packet) {
-		iforce->expect_packet = 0;
+	if (iforce_serio->expect_packet) {
+		iforce_serio->expect_packet = 0;
 		return -EIO;
 	}
 
@@ -111,54 +128,56 @@ static void iforce_serio_write_wakeup(struct serio *serio)
 static irqreturn_t iforce_serio_irq(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct iforce *iforce = serio_get_drvdata(serio);
+	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
+	struct iforce *iforce = &iforce_serio->iforce;
 
-	if (!iforce->pkt) {
+	if (!iforce_serio->pkt) {
 		if (data == 0x2b)
-			iforce->pkt = 1;
+			iforce_serio->pkt = 1;
 		goto out;
 	}
 
-	if (!iforce->id) {
+	if (!iforce_serio->id) {
 		if (data > 3 && data != 0xff)
-			iforce->pkt = 0;
+			iforce_serio->pkt = 0;
 		else
-			iforce->id = data;
+			iforce_serio->id = data;
 		goto out;
 	}
 
-	if (!iforce->len) {
+	if (!iforce_serio->len) {
 		if (data > IFORCE_MAX_LENGTH) {
-			iforce->pkt = 0;
-			iforce->id = 0;
+			iforce_serio->pkt = 0;
+			iforce_serio->id = 0;
 		} else {
-			iforce->len = data;
+			iforce_serio->len = data;
 		}
 		goto out;
 	}
 
-	if (iforce->idx < iforce->len) {
-		iforce->csum += iforce->data[iforce->idx++] = data;
+	if (iforce_serio->idx < iforce_serio->len) {
+		iforce->data[iforce_serio->idx++] = data;
+		iforce_serio->csum += data;
 		goto out;
 	}
 
-	if (iforce->idx == iforce->len) {
-		u16 cmd = (iforce->id << 8) | iforce->idx;
+	if (iforce_serio->idx == iforce_serio->len) {
+		u16 cmd = (iforce_serio->id << 8) | iforce_serio->idx;
 
 		/* Handle command completion */
-		if (HI(iforce->expect_packet) == HI(cmd)) {
-			iforce->expect_packet = 0;
+		if (iforce_serio->expect_packet == iforce_serio->id) {
+			iforce_serio->expect_packet = 0;
 			iforce->ecmd = cmd;
 			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
 		}
 
 		iforce_process_packet(iforce, cmd, iforce->data);
 
-		iforce->pkt = 0;
-		iforce->id  = 0;
-		iforce->len = 0;
-		iforce->idx = 0;
-		iforce->csum = 0;
+		iforce_serio->pkt = 0;
+		iforce_serio->id  = 0;
+		iforce_serio->len = 0;
+		iforce_serio->idx = 0;
+		iforce_serio->csum = 0;
 	}
 out:
 	return IRQ_HANDLED;
@@ -166,18 +185,21 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 
 static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
+	struct iforce_serio *iforce_serio;
 	struct iforce *iforce;
 	int err;
 
-	iforce = kzalloc(sizeof(struct iforce), GFP_KERNEL);
-	if (!iforce)
+	iforce_serio = kzalloc(sizeof(*iforce_serio), GFP_KERNEL);
+	if (!iforce_serio)
 		return -ENOMEM;
 
+	iforce = &iforce_serio->iforce;
+
 	iforce->xport_ops = &iforce_serio_xport_ops;
 	iforce->bus = IFORCE_232;
-	iforce->serio = serio;
 
-	serio_set_drvdata(serio, iforce);
+	iforce_serio->serio = serio;
+	serio_set_drvdata(serio, iforce_serio);
 
 	err = serio_open(serio, drv);
 	if (err)
@@ -191,18 +213,18 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 
  fail2:	serio_close(serio);
  fail1:	serio_set_drvdata(serio, NULL);
-	kfree(iforce);
+	kfree(iforce_serio);
 	return err;
 }
 
 static void iforce_serio_disconnect(struct serio *serio)
 {
-	struct iforce *iforce = serio_get_drvdata(serio);
+	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
 
-	input_unregister_device(iforce->dev);
+	input_unregister_device(iforce_serio->iforce.dev);
 	serio_close(serio);
 	serio_set_drvdata(serio, NULL);
-	kfree(iforce);
+	kfree(iforce_serio);
 }
 
 static const struct serio_device_id iforce_serio_ids[] = {
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 824df4273774..d4e7a24922cd 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -23,8 +23,19 @@
 
 #include "iforce.h"
 
+struct iforce_usb {
+	struct iforce iforce;
+
+	struct usb_device *usbdev;
+	struct usb_interface *intf;
+	struct urb *irq, *out, *ctrl;
+	struct usb_ctrlrequest cr;
+};
+
 static void __iforce_usb_xmit(struct iforce *iforce)
 {
+	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
+						     iforce);
 	int n, c;
 	unsigned long flags;
 
@@ -36,31 +47,32 @@ static void __iforce_usb_xmit(struct iforce *iforce)
 		return;
 	}
 
-	((char *)iforce->out->transfer_buffer)[0] = iforce->xmit.buf[iforce->xmit.tail];
+	((char *)iforce_usb->out->transfer_buffer)[0] = iforce->xmit.buf[iforce->xmit.tail];
 	XMIT_INC(iforce->xmit.tail, 1);
 	n = iforce->xmit.buf[iforce->xmit.tail];
 	XMIT_INC(iforce->xmit.tail, 1);
 
-	iforce->out->transfer_buffer_length = n + 1;
-	iforce->out->dev = iforce->usbdev;
+	iforce_usb->out->transfer_buffer_length = n + 1;
+	iforce_usb->out->dev = iforce_usb->usbdev;
 
 	/* Copy rest of data then */
 	c = CIRC_CNT_TO_END(iforce->xmit.head, iforce->xmit.tail, XMIT_SIZE);
 	if (n < c) c=n;
 
-	memcpy(iforce->out->transfer_buffer + 1,
+	memcpy(iforce_usb->out->transfer_buffer + 1,
 	       &iforce->xmit.buf[iforce->xmit.tail],
 	       c);
 	if (n != c) {
-		memcpy(iforce->out->transfer_buffer + 1 + c,
+		memcpy(iforce_usb->out->transfer_buffer + 1 + c,
 		       &iforce->xmit.buf[0],
 		       n-c);
 	}
 	XMIT_INC(iforce->xmit.tail, n);
 
-	if ( (n=usb_submit_urb(iforce->out, GFP_ATOMIC)) ) {
+	if ( (n=usb_submit_urb(iforce_usb->out, GFP_ATOMIC)) ) {
 		clear_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags);
-		dev_warn(&iforce->intf->dev, "usb_submit_urb failed %d\n", n);
+		dev_warn(&iforce_usb->intf->dev,
+			 "usb_submit_urb failed %d\n", n);
 	}
 
 	/* The IFORCE_XMIT_RUNNING bit is not cleared here. That's intended.
@@ -77,26 +89,28 @@ static void iforce_usb_xmit(struct iforce *iforce)
 
 static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 {
+	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
+						     iforce);
 	int status;
 
-	iforce->cr.bRequest = packet[0];
-	iforce->ctrl->dev = iforce->usbdev;
+	iforce_usb->cr.bRequest = packet[0];
+	iforce_usb->ctrl->dev = iforce_usb->usbdev;
 
-	status = usb_submit_urb(iforce->ctrl, GFP_KERNEL);
+	status = usb_submit_urb(iforce_usb->ctrl, GFP_KERNEL);
 	if (status) {
-		dev_err(&iforce->intf->dev,
+		dev_err(&iforce_usb->intf->dev,
 			"usb_submit_urb failed %d\n", status);
 		return -EIO;
 	}
 
 	wait_event_interruptible_timeout(iforce->wait,
-		iforce->ctrl->status != -EINPROGRESS, HZ);
+		iforce_usb->ctrl->status != -EINPROGRESS, HZ);
 
-	if (iforce->ctrl->status) {
-		dev_dbg(&iforce->intf->dev,
+	if (iforce_usb->ctrl->status) {
+		dev_dbg(&iforce_usb->intf->dev,
 			"iforce->ctrl->status = %d\n",
-			iforce->ctrl->status);
-		usb_unlink_urb(iforce->ctrl);
+			iforce_usb->ctrl->status);
+		usb_unlink_urb(iforce_usb->ctrl);
 		return -EIO;
 	}
 
@@ -105,7 +119,10 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 
 static int iforce_usb_start_io(struct iforce *iforce)
 {
-	if (usb_submit_urb(iforce->irq, GFP_KERNEL))
+	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
+						     iforce);
+
+	if (usb_submit_urb(iforce_usb->irq, GFP_KERNEL))
 		return -EIO;
 
 	return 0;
@@ -113,9 +130,12 @@ static int iforce_usb_start_io(struct iforce *iforce)
 
 static void iforce_usb_stop_io(struct iforce *iforce)
 {
-	usb_kill_urb(iforce->irq);
-	usb_kill_urb(iforce->out);
-	usb_kill_urb(iforce->ctrl);
+	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
+						     iforce);
+
+	usb_kill_urb(iforce_usb->irq);
+	usb_kill_urb(iforce_usb->out);
+	usb_kill_urb(iforce_usb->ctrl);
 }
 
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
@@ -127,8 +147,9 @@ static const struct iforce_xport_ops iforce_usb_xport_ops = {
 
 static void iforce_usb_irq(struct urb *urb)
 {
-	struct iforce *iforce = urb->context;
-	struct device *dev = &iforce->intf->dev;
+	struct iforce_usb *iforce_usb = urb->context;
+	struct iforce *iforce = &iforce_usb->iforce;
+	struct device *dev = &iforce_usb->intf->dev;
 	int status;
 
 	switch (urb->status) {
@@ -152,7 +173,7 @@ static void iforce_usb_irq(struct urb *urb)
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1);
 
 exit:
-	status = usb_submit_urb (urb, GFP_ATOMIC);
+	status = usb_submit_urb(urb, GFP_ATOMIC);
 	if (status)
 		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
 			__func__, status);
@@ -160,11 +181,12 @@ static void iforce_usb_irq(struct urb *urb)
 
 static void iforce_usb_out(struct urb *urb)
 {
-	struct iforce *iforce = urb->context;
+	struct iforce_usb *iforce_usb = urb->context;
+	struct iforce *iforce = &iforce_usb->iforce;
 
 	if (urb->status) {
 		clear_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags);
-		dev_dbg(&iforce->intf->dev, "urb->status %d, exiting\n",
+		dev_dbg(&iforce_usb->intf->dev, "urb->status %d, exiting\n",
 			urb->status);
 		return;
 	}
@@ -176,8 +198,12 @@ static void iforce_usb_out(struct urb *urb)
 
 static void iforce_usb_ctrl(struct urb *urb)
 {
-	struct iforce *iforce = urb->context;
-	if (urb->status) return;
+	struct iforce_usb *iforce_usb = urb->context;
+	struct iforce *iforce = &iforce_usb->iforce;
+
+	if (urb->status)
+		return;
+
 	iforce->ecmd = 0xff00 | urb->actual_length;
 	wake_up(&iforce->wait);
 }
@@ -188,6 +214,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct usb_host_interface *interface;
 	struct usb_endpoint_descriptor *epirq, *epout;
+	struct iforce_usb *iforce_usb;
 	struct iforce *iforce;
 	int err = -ENOMEM;
 
@@ -199,49 +226,52 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	epirq = &interface->endpoint[0].desc;
 	epout = &interface->endpoint[1].desc;
 
-	if (!(iforce = kzalloc(sizeof(struct iforce) + 32, GFP_KERNEL)))
+	if (!(iforce_usb = kzalloc(sizeof(*iforce_usb) + 32, GFP_KERNEL)))
 		goto fail;
 
-	if (!(iforce->irq = usb_alloc_urb(0, GFP_KERNEL)))
+	if (!(iforce_usb->irq = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
-	if (!(iforce->out = usb_alloc_urb(0, GFP_KERNEL)))
+	if (!(iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
-	if (!(iforce->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
+	if (!(iforce_usb->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
+	iforce = &iforce_usb->iforce;
+
 	iforce->xport_ops = &iforce_usb_xport_ops;
 	iforce->bus = IFORCE_USB;
-	iforce->usbdev = dev;
-	iforce->intf = intf;
 
-	iforce->cr.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN | USB_RECIP_INTERFACE;
-	iforce->cr.wIndex = 0;
-	iforce->cr.wLength = cpu_to_le16(16);
+	iforce_usb->usbdev = dev;
+	iforce_usb->intf = intf;
+
+	iforce_usb->cr.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN | USB_RECIP_INTERFACE;
+	iforce_usb->cr.wIndex = 0;
+	iforce_usb->cr.wLength = cpu_to_le16(16);
 
-	usb_fill_int_urb(iforce->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
-			iforce->data, 16, iforce_usb_irq, iforce, epirq->bInterval);
+	usb_fill_int_urb(iforce_usb->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
+			iforce->data, 16, iforce_usb_irq, iforce_usb, epirq->bInterval);
 
-	usb_fill_int_urb(iforce->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
-			iforce + 1, 32, iforce_usb_out, iforce, epout->bInterval);
+	usb_fill_int_urb(iforce_usb->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
+			iforce_usb + 1, 32, iforce_usb_out, iforce_usb, epout->bInterval);
 
-	usb_fill_control_urb(iforce->ctrl, dev, usb_rcvctrlpipe(dev, 0),
-			(void*) &iforce->cr, iforce->edata, 16, iforce_usb_ctrl, iforce);
+	usb_fill_control_urb(iforce_usb->ctrl, dev, usb_rcvctrlpipe(dev, 0),
+			(void*) &iforce_usb->cr, iforce->edata, 16, iforce_usb_ctrl, iforce_usb);
 
 	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
 		goto fail;
 
-	usb_set_intfdata(intf, iforce);
+	usb_set_intfdata(intf, iforce_usb);
 	return 0;
 
 fail:
-	if (iforce) {
-		usb_free_urb(iforce->irq);
-		usb_free_urb(iforce->out);
-		usb_free_urb(iforce->ctrl);
-		kfree(iforce);
+	if (iforce_usb) {
+		usb_free_urb(iforce_usb->irq);
+		usb_free_urb(iforce_usb->out);
+		usb_free_urb(iforce_usb->ctrl);
+		kfree(iforce_usb);
 	}
 
 	return err;
@@ -249,17 +279,17 @@ static int iforce_usb_probe(struct usb_interface *intf,
 
 static void iforce_usb_disconnect(struct usb_interface *intf)
 {
-	struct iforce *iforce = usb_get_intfdata(intf);
+	struct iforce_usb *iforce_usb = usb_get_intfdata(intf);
 
 	usb_set_intfdata(intf, NULL);
 
-	input_unregister_device(iforce->dev);
+	input_unregister_device(iforce_usb->iforce.dev);
 
-	usb_free_urb(iforce->irq);
-	usb_free_urb(iforce->out);
-	usb_free_urb(iforce->ctrl);
+	usb_free_urb(iforce_usb->irq);
+	usb_free_urb(iforce_usb->out);
+	usb_free_urb(iforce_usb->ctrl);
 
-	kfree(iforce);
+	kfree(iforce_usb);
 }
 
 static const struct usb_device_id iforce_usb_ids[] = {
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 3ee9245a415b..d9712c48ba74 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -111,19 +111,7 @@ struct iforce {
 	unsigned char data[IFORCE_MAX_LENGTH];
 	unsigned char edata[IFORCE_MAX_LENGTH];
 	u16 ecmd;
-	u16 expect_packet;
-
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	struct serio *serio;		/* RS232 transfer */
-	int idx, pkt, len, id;
-	unsigned char csum;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	struct usb_device *usbdev;	/* USB transfer */
-	struct usb_interface *intf;
-	struct urb *irq, *out, *ctrl;
-	struct usb_ctrlrequest cr;
-#endif
+
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
 	struct circ_buf xmit;
-- 
2.19.0.397.gdd90340f6a-goog

