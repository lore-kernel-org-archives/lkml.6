Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369BBECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADA4214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx2YjMxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADA4214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeIRGRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39213 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeIRGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id i190-v6so109368pgc.6;
        Mon, 17 Sep 2018 17:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hjHW6GAdKl25iWmfD9ZbtgysZDtLOgpSph44E0kquHA=;
        b=rx2YjMxnYL88ikAKC2HG0zluRL6ROhfTH5/N4xq5Nx3OfLdKu96AbMRuE8HuQ26m+8
         Q9H2VbgufwhlUsNlGvi2kU6O04QhshbRoAVjj/wegmVMOpgSu9otAIm9m8XteBkG8oTr
         mPywTbOiirknHf9xyYCMYSjrVOFmYD+ChJO7+qkmuV4tUut1nXYkczYMl26NI+U2hUrQ
         Zwu6OJahDniIusvRzjt0dxRFbS4ORPTLIm85oFf1Pq3s50bC0xXrHS+oDVePO2zTa4Jf
         ORdC9vKONjWEdHaCExuklgO+zg1qS4H1M60OSpGm1FoxYDUnlk8IP9A5VKzQ05cqzOXE
         pWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hjHW6GAdKl25iWmfD9ZbtgysZDtLOgpSph44E0kquHA=;
        b=XTekhyf46ark/JNY9njulsr5pP6dw3HffEirCtnf8f9WoCHetlEEXfJ8ftWw7GFYlI
         qH1gfUCLYqN4FzA9BCV5XJFzAUveerhVCc34Od/ptp+YZ9S9zkCIK6UMFtSWpqc4WVfk
         RxfOxDeWRPOXahmECSFoAyfl6fSdUtl64X8R5xpFzBroN/0aXSCTK2iVGAERcORvUTlV
         YsFljBpFX9rp4MWejaZ1uX3z4ikkyT0Ozbrt49SJbwjh7rogiGNd/iYH9agZmhpXPFg3
         2aUGQ1Nr+ZZQ9GZVtil+SXVnD3MEmLvjWxCZT/VJDd9JYCNsf/d4Zqx3MstV2v8UvQa7
         O0oA==
X-Gm-Message-State: APzg51AtJAbBXJZZGiHdn8U2O2n8bbdlF90vziOW7HcGpWVXqu2VqOGS
        Qa4DcNu49LQahph5DNldD3q9F5WF
X-Google-Smtp-Source: ANB0VdZTSI8H6U1e7uKOh7dhZFlhgDe66odUfQBl/vCbzIionlJdl8MoR5YjZqd2QrWVW74OncPX3w==
X-Received: by 2002:a63:9e0a:: with SMTP id s10-v6mr25810556pgd.326.1537231657662;
        Mon, 17 Sep 2018 17:47:37 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:36 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] Input: iforce - introduce transport ops
Date:   Mon, 17 Sep 2018 17:47:14 -0700
Message-Id: <20180918004732.9875-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to tease apart the driver into core and transport modules, let's
introduce transport operations and make "xmit" the very first one such
operation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 20 ++-----------------
 drivers/input/joystick/iforce/iforce-serio.c  |  9 +++++++--
 drivers/input/joystick/iforce/iforce-usb.c    | 15 ++++++++++++--
 drivers/input/joystick/iforce/iforce.h        | 13 ++++++------
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 91893c751524..b8ca9bdfdef8 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -91,25 +91,9 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data)
 /*
  * If necessary, start the transmission
  */
-	switch (iforce->bus) {
-
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-		case IFORCE_232:
-		if (empty)
-			iforce_serial_xmit(iforce);
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB:
+	if (empty)
+		iforce->xport_ops->xmit(iforce);
 
-		if (iforce->usbdev && empty &&
-			!test_and_set_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags)) {
-
-			iforce_usb_xmit(iforce);
-		}
-		break;
-#endif
-	}
 	return 0;
 }
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index f4ba4a751fe0..c9469209f994 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -23,7 +23,7 @@
 
 #include "iforce.h"
 
-void iforce_serial_xmit(struct iforce *iforce)
+static void iforce_serio_xmit(struct iforce *iforce)
 {
 	unsigned char cs;
 	int i;
@@ -67,11 +67,15 @@ void iforce_serial_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static const struct iforce_xport_ops iforce_serio_xport_ops = {
+	.xmit		= iforce_serio_xmit,
+};
+
 static void iforce_serio_write_wakeup(struct serio *serio)
 {
 	struct iforce *iforce = serio_get_drvdata(serio);
 
-	iforce_serial_xmit(iforce);
+	iforce_serio_xmit(iforce);
 }
 
 static irqreturn_t iforce_serio_irq(struct serio *serio,
@@ -129,6 +133,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (!iforce)
 		return -ENOMEM;
 
+	iforce->xport_ops = &iforce_serio_xport_ops;
 	iforce->bus = IFORCE_232;
 	iforce->serio = serio;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 78073259c9a1..d4f7f34db9a0 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -23,7 +23,7 @@
 
 #include "iforce.h"
 
-void iforce_usb_xmit(struct iforce *iforce)
+static void __iforce_usb_xmit(struct iforce *iforce)
 {
 	int n, c;
 	unsigned long flags;
@@ -69,6 +69,16 @@ void iforce_usb_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static void iforce_usb_xmit(struct iforce *iforce)
+{
+	if (!test_and_set_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags))
+		__iforce_usb_xmit(iforce);
+}
+
+static const struct iforce_xport_ops iforce_usb_xport_ops = {
+	.xmit		= iforce_usb_xmit,
+};
+
 static void iforce_usb_irq(struct urb *urb)
 {
 	struct iforce *iforce = urb->context;
@@ -113,7 +123,7 @@ static void iforce_usb_out(struct urb *urb)
 		return;
 	}
 
-	iforce_usb_xmit(iforce);
+	__iforce_usb_xmit(iforce);
 
 	wake_up(&iforce->wait);
 }
@@ -155,6 +165,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!(iforce->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
+	iforce->xport_ops = &iforce_usb_xport_ops;
 	iforce->bus = IFORCE_USB;
 	iforce->usbdev = dev;
 	iforce->intf = intf;
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 0e9d01f8bcb6..2fea3be751ed 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -93,9 +93,16 @@ struct iforce_device {
 	signed short *ff;
 };
 
+struct iforce;
+
+struct iforce_xport_ops {
+	void (*xmit)(struct iforce *iforce);
+};
+
 struct iforce {
 	struct input_dev *dev;		/* Input device interface */
 	struct iforce_device *type;
+	const struct iforce_xport_ops *xport_ops;
 	int bus;
 
 	unsigned char data[IFORCE_MAX_LENGTH];
@@ -141,12 +148,6 @@ struct iforce {
 
 
 /* Public functions */
-/* iforce-serio.c */
-void iforce_serial_xmit(struct iforce *iforce);
-
-/* iforce-usb.c */
-void iforce_usb_xmit(struct iforce *iforce);
-
 /* iforce-main.c */
 int iforce_init_device(struct iforce *iforce);
 
-- 
2.19.0.397.gdd90340f6a-goog

