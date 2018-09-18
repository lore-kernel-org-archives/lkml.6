Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECA4ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD5C214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7JMFDVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD5C214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbeIRGRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36429 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbeIRGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id p5-v6so108728plk.3;
        Mon, 17 Sep 2018 17:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HByUc57ld/iWST/cDFGHHb5LTFImKWNMLwbZ92Hy5EI=;
        b=k7JMFDVFgA3jpW8EHCiQs7+U7ex4LD9uG2hARVX9W84PDP1eYLEWmrEMwF3YWt0KJp
         i2B1kDvvybbRmkqBc20BzCQ1sEro/Ef1wBvc9eTjkMhT6MauNIcqiUoX3q4rlie0KkDZ
         k6yHRh98vHHaU2/pvjJuHzFAFUhfze75J+RCehjNkBVr8g3dNPJ8qhmtiP/oXQ8nkYNT
         99oaABCgpvKwaFg0s88fuAt0uQJVJARmln1HFyYD5TuVoDgoAPAgxR1oeBDQ8qSLPvwK
         9Uo+jYxPcnYl03n2gJGBQbvX1BJBPBW8nShtgu478FfYbgo6mgZf2pCO68Ix5ewmt7qp
         ZIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HByUc57ld/iWST/cDFGHHb5LTFImKWNMLwbZ92Hy5EI=;
        b=pc7uAHEx3/xNDE76a0GhNPYoz5Zc3imgZkr3PiAOu1VCiOX0bGWZkyFavYJfqzW2iM
         pH3OM0terf66utJjcUE1IqilLYU3+kPGMSCk15TsLne419y7kkk6iWlHqNKRpGMJQ62X
         KZx5XTg2Q0YRvOfTPuFaT+ez7rd/bh5ThMuh33gzz7k2RErCn379vGQZroudBOg8vxkv
         in/d9FHIz8AB6KJMAjl2YuWeGcOOx+Iq5sfbOlK+wrRhqH487sGFUACICdXjIXdvLdU5
         8STy52/utSNpzUoM2sew6H4aBCY3Dzf43gBCwGdBrxtfk1tR6/gqyyZl1ZrBHxA1Gwq9
         tveQ==
X-Gm-Message-State: APzg51ALl1wXbODqZZ2OlfR6yUwchvqluLWWpivheGpLdflxEECOPCzJ
        azesHROK7P73jfhMdKX+dnDAATOy
X-Google-Smtp-Source: ANB0VdYfjbcmzOBC607GBea47gygW4K2rLES1Cs/GEPDgYoqAT7kOBdXLfYxGXTL7uF8vWudXJOT6g==
X-Received: by 2002:a17:902:64c1:: with SMTP id y1-v6mr26436562pli.45.1537231679210;
        Mon, 17 Sep 2018 17:47:59 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:58 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] Input: iforce - use DMA-safe buffores for USB transfers
Date:   Mon, 17 Sep 2018 17:47:28 -0700
Message-Id: <20180918004732.9875-16-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB transport has to use cache line-aligned buffers for transfers to avoid
DMA issues; serio doe snot have such restrictions. Let's move "data_in"
buffer from main driver structure into transport modules and make sure USB
requirements are respected.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 10 ++++---
 drivers/input/joystick/iforce/iforce-usb.c   | 28 +++++++++++++-------
 drivers/input/joystick/iforce/iforce.h       |  2 --
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index be44aed551f7..c73d988cbc92 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -33,6 +33,7 @@ struct iforce_serio {
 	u8 expect_packet;
 	u8 cmd_response[IFORCE_MAX_LENGTH];
 	u8 cmd_response_len;
+	u8 data_in[IFORCE_MAX_LENGTH];
 };
 
 static void iforce_serio_xmit(struct iforce *iforce)
@@ -169,7 +170,7 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce_serio->idx < iforce_serio->len) {
-		iforce->data[iforce_serio->idx++] = data;
+		iforce_serio->data_in[iforce_serio->idx++] = data;
 		iforce_serio->csum += data;
 		goto out;
 	}
@@ -178,15 +179,16 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			memcpy(iforce_serio->cmd_response, iforce->data,
-			       IFORCE_MAX_LENGTH);
+			memcpy(iforce_serio->cmd_response,
+			       iforce_serio->data_in, IFORCE_MAX_LENGTH);
 			iforce_serio->cmd_response_len = iforce_serio->len;
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
 		} else if (likely(iforce->type)) {
 			iforce_process_packet(iforce, iforce_serio->id,
-					      iforce->data, iforce_serio->len);
+					      iforce_serio->data_in,
+					      iforce_serio->len);
 		}
 
 		iforce_serio->pkt = 0;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 68155c4de412..d85258b50be2 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -30,6 +30,9 @@ struct iforce_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
 	struct urb *irq, *out;
+
+	u8 data_in[IFORCE_MAX_LENGTH] ____cacheline_aligned;
+	u8 data_out[IFORCE_MAX_LENGTH] ____cacheline_aligned;
 };
 
 static void __iforce_usb_xmit(struct iforce *iforce)
@@ -171,8 +174,8 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
-	iforce_process_packet(iforce, iforce->data[0],
-			      iforce->data + 1, urb->actual_length - 1);
+	iforce_process_packet(iforce, iforce_usb->data_in[0],
+			      iforce_usb->data_in + 1, urb->actual_length - 1);
 
 exit:
 	status = usb_submit_urb(urb, GFP_ATOMIC);
@@ -216,13 +219,16 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	epirq = &interface->endpoint[0].desc;
 	epout = &interface->endpoint[1].desc;
 
-	if (!(iforce_usb = kzalloc(sizeof(*iforce_usb) + 32, GFP_KERNEL)))
+	iforce_usb = kzalloc(sizeof(*iforce_usb), GFP_KERNEL);
+	if (!iforce_usb)
 		goto fail;
 
-	if (!(iforce_usb->irq = usb_alloc_urb(0, GFP_KERNEL)))
+	iforce_usb->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!iforce_usb->irq)
 		goto fail;
 
-	if (!(iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL)))
+	iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL);
+	if (!iforce_usb->out)
 		goto fail;
 
 	iforce = &iforce_usb->iforce;
@@ -233,11 +239,15 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
 
-	usb_fill_int_urb(iforce_usb->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
-			iforce->data, 16, iforce_usb_irq, iforce_usb, epirq->bInterval);
+	usb_fill_int_urb(iforce_usb->irq, dev,
+			 usb_rcvintpipe(dev, epirq->bEndpointAddress),
+			 iforce_usb->data_in, sizeof(iforce_usb->data_in),
+			 iforce_usb_irq, iforce_usb, epirq->bInterval);
 
-	usb_fill_int_urb(iforce_usb->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
-			iforce_usb + 1, 32, iforce_usb_out, iforce_usb, epout->bInterval);
+	usb_fill_int_urb(iforce_usb->out, dev,
+			 usb_sndintpipe(dev, epout->bEndpointAddress),
+			 iforce_usb->data_out, sizeof(iforce_usb->data_out),
+			 iforce_usb_out, iforce_usb, epout->bInterval);
 
 	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 68558c594e54..180de7a3f3a1 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -107,8 +107,6 @@ struct iforce {
 	const struct iforce_xport_ops *xport_ops;
 	int bus;
 
-	unsigned char data[IFORCE_MAX_LENGTH];
-
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
 	struct circ_buf xmit;
-- 
2.19.0.397.gdd90340f6a-goog

