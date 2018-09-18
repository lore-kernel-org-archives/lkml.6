Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318EECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0803214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nko+JCW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0803214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbeIRGRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39288 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeIRGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so103509plp.6;
        Mon, 17 Sep 2018 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I+6YNMxcg8OUbqbH0Mt0mHDfm7vio0fVTRA9D6WdfA0=;
        b=nko+JCW8qRpn1h8QgWy72A9JJZSFlA7W4KXj0ywB/6KcH0CFxKIVA8aS5s/HfSHa9U
         KZXbhnXshlOa35Cw8Ap9Dhg1mMd9Yw8S0aM2QY0XnQm065rfos8xyQnQCX+D0I3Bt17S
         dKdOvt8OMLqWjho+sbFiy5IQlec5fixrceo0TUFuN4HrK+Dw+FNOpM79pITqjTPnA8rP
         yqYA4iw0fiH13lj/RHqi75v1G7Byus97+otIhIpYpDlUwig1MgTiShggcwuAeGzCHQT1
         GaIH+HarH22K2BZTWkZZ+yZGd+VtPpU+Bf1/pbd3t4fIw0L/F5nhmpBvpJ7wV+GSaWzk
         4zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I+6YNMxcg8OUbqbH0Mt0mHDfm7vio0fVTRA9D6WdfA0=;
        b=P2Xo8rwCTSAuNXj01VCmoWNRhbD3uupKqvNYBrKdeAk5sQLzSrKVPYwGwBrRp0Xb6f
         xXdfuP7Ja2/X7BGIrZ7AwfWPeB08GjC/yPr+cC3SNJhGknzG0OCfrXSUSPlhfdltT5LC
         gx2jITbS5zj0EYWKOvCeJc4cYrrOlKS5kKf/astEwRU3zf4w+MRvQd87+mUIwsMDPhJo
         OufO4w3/LW9k9vtZAhfhgmXCzM+RWAZSS5zwm4HMFLobdiLfg5qLWa2lD8UGGr+M/X40
         u9P8GKXJ+KsZ1u4a5byuaHj6Xspi4iWKI0DyVp7anSIdJKhu6N68ce1/lzmkQ5Z4kMJO
         SvwA==
X-Gm-Message-State: APzg51A07n3Q3EviNmgxKnSCId6T2YDbwxF2yKJQteJYfexpi7H4kuH3
        mjNKTOhpXILAet5bdn7PZ7v8CTjQ
X-Google-Smtp-Source: ANB0VdYhmuoeiZUTpzdVDaDwe55QOF4PqbkPs1CkeBT3VuyWJ4jOzP99TmXFNgwpFveEken7PNB0oQ==
X-Received: by 2002:a17:902:402:: with SMTP id 2-v6mr26631501ple.277.1537231662492;
        Mon, 17 Sep 2018 17:47:42 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:40 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] Input: iforce - introduce start and stop io transport ops
Date:   Mon, 17 Sep 2018 17:47:17 -0700
Message-Id: <20180918004732.9875-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add start_io() and stop_io() transport methods so that core
does not have to know the details.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 25 ++------------------
 drivers/input/joystick/iforce/iforce-serio.c | 13 ++++++++++
 drivers/input/joystick/iforce/iforce-usb.c   | 17 +++++++++++++
 drivers/input/joystick/iforce/iforce.h       |  2 ++
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 58d5cfe46526..4401ca4a4c38 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -185,15 +185,7 @@ static int iforce_open(struct input_dev *dev)
 {
 	struct iforce *iforce = input_get_drvdata(dev);
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB:
-			iforce->irq->dev = iforce->usbdev;
-			if (usb_submit_urb(iforce->irq, GFP_KERNEL))
-				return -EIO;
-			break;
-#endif
-	}
+	iforce->xport_ops->start_io(iforce);
 
 	if (test_bit(EV_FF, dev->evbit)) {
 		/* Enable force feedback */
@@ -226,20 +218,7 @@ static void iforce_close(struct input_dev *dev)
 			!test_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags));
 	}
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	case IFORCE_USB:
-		usb_kill_urb(iforce->irq);
-		usb_kill_urb(iforce->out);
-		usb_kill_urb(iforce->ctrl);
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	case IFORCE_232:
-		//TODO: Wait for the last packets to be sent
-		break;
-#endif
-	}
+	iforce->xport_ops->stop_io(iforce);
 }
 
 int iforce_init_device(struct iforce *iforce)
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index eca2f6eca7f0..afc7521b430d 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -83,9 +83,22 @@ static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
 	return -(iforce->edata[0] != packet[0]);
 }
 
+static int iforce_serio_start_io(struct iforce *iforce)
+{
+	/* No special handling required */
+	return 0;
+}
+
+static void iforce_serio_stop_io(struct iforce *iforce)
+{
+	//TODO: Wait for the last packets to be sent
+}
+
 static const struct iforce_xport_ops iforce_serio_xport_ops = {
 	.xmit		= iforce_serio_xmit,
 	.get_id		= iforce_serio_get_id,
+	.start_io	= iforce_serio_start_io,
+	.stop_io	= iforce_serio_stop_io,
 };
 
 static void iforce_serio_write_wakeup(struct serio *serio)
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index f7eeaad92602..10b583b5fc82 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -103,9 +103,26 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 	return -(iforce->edata[0] != packet[0]);
 }
 
+static int iforce_usb_start_io(struct iforce *iforce)
+{
+	if (usb_submit_urb(iforce->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void iforce_usb_stop_io(struct iforce *iforce)
+{
+	usb_kill_urb(iforce->irq);
+	usb_kill_urb(iforce->out);
+	usb_kill_urb(iforce->ctrl);
+}
+
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
 	.xmit		= iforce_usb_xmit,
 	.get_id		= iforce_usb_get_id,
+	.start_io	= iforce_usb_start_io,
+	.stop_io	= iforce_usb_stop_io,
 };
 
 static void iforce_usb_irq(struct urb *urb)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index f6636230be31..c020d61eccf2 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -98,6 +98,8 @@ struct iforce;
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
 	int (*get_id)(struct iforce *iforce, u8* id);
+	int (*start_io)(struct iforce *iforce);
+	void (*stop_io)(struct iforce *iforce);
 };
 
 struct iforce {
-- 
2.19.0.397.gdd90340f6a-goog

