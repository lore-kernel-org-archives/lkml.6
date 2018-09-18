Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A5EECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE2C214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keKfW7cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE2C214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeIRGRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43436 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeIRGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:52 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so100866pgb.10;
        Mon, 17 Sep 2018 17:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSF41QL/4F8SAH9V7ryVUuaUkx8P5+uBNzviyJD1NWc=;
        b=keKfW7cj31um9Pc1Pib7/AanGNZv2U4tJ7CGewPB6IZ/HOjSd9soe81EZKGMVaXg9E
         Jp9hq51Wvgmy2b6koiCVgkgP2/M6MDp5ZivJlmdkRQhnmoO0mbTnyeFsTo9D1SIG8vfP
         j/gOsh+cKuWncAthaoMSy7rqXXKC+AKL8/Z0iqBjASQGRIqkBNYDJsBhB6s8g9wDQ+bH
         S+ZHu0q7gE/WFG2M+GlcFNWOog2+Fe+OdYQHG+OkhzWH9jwQ1gW6K85T3MkZyLZRYXpT
         RG5yjZAwUYN6Z+tJ/gpWz2F6Utd0Buf52kjjHV/WE02PijAp/9I7dVs4vdtTGSkv0e9L
         GwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSF41QL/4F8SAH9V7ryVUuaUkx8P5+uBNzviyJD1NWc=;
        b=C/ZZONNFYrZ5YQgpF3Mv2kI3zoy8HFk2QACrW1rDSCBqnB480bdP2DpEuGwAG7Mr2A
         EQ+CowZixMOrfhZrhmV5pXQCD9lQMQ+acBNCr0w1dOPo9k+fvfOzgVBr/YFMYV+Cb4eb
         saEHsiEKc2vNre5k+kqCk612VR6VjXT91Hdl10OJq9A1Srxe0451trkPV82AVTdkjH7n
         jyWovAgAnoYwOJzqIUGeEUuI1mJvkGk0zthVjw9X9zE19arfsXOoZn5uKFJc02YnpdMg
         fHy46+XXnEQ9kliL531K/qlHYjfyzk9uiydIwUSFe12WSSNuU/o/nNEeL+zSz3jXS50t
         HVEA==
X-Gm-Message-State: APzg51Dt3j2HgLXecT3DCaHovD1H7P0RmQQmi/QXPmCU4oa7DGrAMShK
        Iik2bEzPGW6Q0vujtcTXe06li4x5
X-Google-Smtp-Source: ANB0VdaPUBcojgLODMuTantcRTXx6jLb8tbWmxHZELwXiRuZTU3C07XCZGnChsBKBq06LHe2NV2Stg==
X-Received: by 2002:a63:ff1f:: with SMTP id k31-v6mr24813748pgi.20.1537231677747;
        Mon, 17 Sep 2018 17:47:57 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:56 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/20] Input: iforce - allow callers supply data buffer when fetching device IDs
Date:   Mon, 17 Sep 2018 17:47:27 -0700
Message-Id: <20180918004732.9875-15-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to move buffer handling into transport layers as the properties of
buffers (DMA-safety, alignment, etc) are different for different
transports. To allow this, let's allow caller to specify their own buffers
for the results of iforce_get_id_packet() and let transport drivers to
figure what buffers they need to use for transfers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 27 ++++++++++---------
 drivers/input/joystick/iforce/iforce-serio.c | 28 ++++++++++++++------
 drivers/input/joystick/iforce/iforce-usb.c   | 11 ++++----
 drivers/input/joystick/iforce/iforce.h       | 11 ++++----
 4 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 9964aa8b3cdc..5cb3e80f4e0d 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -225,7 +225,9 @@ int iforce_init_device(struct device *parent, u16 bustype,
 {
 	struct input_dev *input_dev;
 	struct ff_device *ff;
-	unsigned char c[] = "CEOV";
+	u8 c[] = "CEOV";
+	u8 buf[IFORCE_MAX_LENGTH];
+	size_t len;
 	int i, error;
 	int ff_effects = 0;
 
@@ -269,7 +271,7 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	for (i = 0; i < 20; i++)
-		if (!iforce_get_id_packet(iforce, "O"))
+		if (!iforce_get_id_packet(iforce, 'O', buf, &len))
 			break;
 
 	if (i == 20) { /* 5 seconds */
@@ -283,23 +285,23 @@ int iforce_init_device(struct device *parent, u16 bustype,
  * Get device info.
  */
 
-	if (!iforce_get_id_packet(iforce, "M"))
-		input_dev->id.vendor = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'M', buf, &len) || len < 3)
+		input_dev->id.vendor = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet M\n");
 
-	if (!iforce_get_id_packet(iforce, "P"))
-		input_dev->id.product = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'P', buf, &len) || len < 3)
+		input_dev->id.product = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet P\n");
 
-	if (!iforce_get_id_packet(iforce, "B"))
-		iforce->device_memory.end = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'B', buf, &len) || len < 3)
+		iforce->device_memory.end = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet B\n");
 
-	if (!iforce_get_id_packet(iforce, "N"))
-		ff_effects = iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'N', buf, &len) || len < 2)
+		ff_effects = buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet N\n");
 
@@ -315,8 +317,9 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	for (i = 0; c[i]; i++)
-		if (!iforce_get_id_packet(iforce, c + i))
-			iforce_dump_packet(iforce, "info", iforce->ecmd, iforce->edata);
+		if (!iforce_get_id_packet(iforce, c[i], buf, &len))
+			iforce_dump_packet(iforce, "info",
+					   (FF_CMD_QUERY & 0xff00) | len, buf);
 
 /*
  * Disable spring, enable force feedback.
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 8d7eba9c9f0e..be44aed551f7 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -31,6 +31,8 @@ struct iforce_serio {
 	int idx, pkt, len, id;
 	u8 csum;
 	u8 expect_packet;
+	u8 cmd_response[IFORCE_MAX_LENGTH];
+	u8 cmd_response_len;
 };
 
 static void iforce_serio_xmit(struct iforce *iforce)
@@ -81,24 +83,34 @@ static void iforce_serio_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
-static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
+static int iforce_serio_get_id(struct iforce *iforce, u8 id,
+			       u8 *response_data, size_t *response_len)
 {
 	struct iforce_serio *iforce_serio = container_of(iforce,
 							 struct iforce_serio,
 							 iforce);
 
 	iforce_serio->expect_packet = HI(FF_CMD_QUERY);
-	iforce_send_packet(iforce, FF_CMD_QUERY, packet);
+	iforce_serio->cmd_response_len = 0;
+
+	iforce_send_packet(iforce, FF_CMD_QUERY, &id);
 
 	wait_event_interruptible_timeout(iforce->wait,
 					 !iforce_serio->expect_packet, HZ);
 
 	if (iforce_serio->expect_packet) {
 		iforce_serio->expect_packet = 0;
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
-	return -(iforce->edata[0] != packet[0]);
+	if (iforce_serio->cmd_response[0] != id)
+		return -EIO;
+
+	memcpy(response_data, iforce_serio->cmd_response,
+	       iforce_serio->cmd_response_len);
+	*response_len = iforce_serio->cmd_response_len;
+
+	return 0;
 }
 
 static int iforce_serio_start_io(struct iforce *iforce)
@@ -127,7 +139,7 @@ static void iforce_serio_write_wakeup(struct serio *serio)
 }
 
 static irqreturn_t iforce_serio_irq(struct serio *serio,
-		unsigned char data, unsigned int flags)
+				    unsigned char data, unsigned int flags)
 {
 	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
 	struct iforce *iforce = &iforce_serio->iforce;
@@ -166,9 +178,9 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			iforce->ecmd = (iforce_serio->id << 8) |
-					iforce_serio->idx;
-			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
+			memcpy(iforce_serio->cmd_response, iforce->data,
+			       IFORCE_MAX_LENGTH);
+			iforce_serio->cmd_response_len = iforce_serio->len;
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index b3743fde2a3a..68155c4de412 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -87,7 +87,8 @@ static void iforce_usb_xmit(struct iforce *iforce)
 		__iforce_usb_xmit(iforce);
 }
 
-static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
+static int iforce_usb_get_id(struct iforce *iforce, u8 id,
+			     u8 *response_data, size_t *response_len)
 {
 	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
 						     iforce);
@@ -100,18 +101,18 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 
 	status = usb_control_msg(iforce_usb->usbdev,
 				 usb_rcvctrlpipe(iforce_usb->usbdev, 0),
-				 packet[0],
+				 id,
 				 USB_TYPE_VENDOR | USB_DIR_IN |
 					USB_RECIP_INTERFACE,
 				 0, 0, buf, IFORCE_MAX_LENGTH, HZ);
 	if (status < 0) {
 		dev_err(&iforce_usb->intf->dev,
 			"usb_submit_urb failed: %d\n", status);
-	} else if (buf[0] != packet[0]) {
+	} else if (buf[0] != id) {
 		status = -EIO;
 	} else {
-		iforce->ecmd = 0xff00 | status;
-		memcpy(iforce->edata, buf, status);
+		memcpy(response_data, buf, status);
+		*response_len = status;
 		status = 0;
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index ce3c6aead8b6..68558c594e54 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -95,7 +95,8 @@ struct iforce;
 
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
-	int (*get_id)(struct iforce *iforce, u8* id);
+	int (*get_id)(struct iforce *iforce, u8 id,
+		      u8 *response_data, size_t *response_len);
 	int (*start_io)(struct iforce *iforce);
 	void (*stop_io)(struct iforce *iforce);
 };
@@ -107,8 +108,6 @@ struct iforce {
 	int bus;
 
 	unsigned char data[IFORCE_MAX_LENGTH];
-	unsigned char edata[IFORCE_MAX_LENGTH];
-	u16 ecmd;
 
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
@@ -135,9 +134,11 @@ struct iforce {
 /* Encode a time value */
 #define TIME_SCALE(a)	(a)
 
-static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
+static inline int iforce_get_id_packet(struct iforce *iforce, u8 id,
+				       u8 *response_data, size_t *response_len)
 {
-	return iforce->xport_ops->get_id(iforce, id);
+	return iforce->xport_ops->get_id(iforce, id,
+					 response_data, response_len);
 }
 
 /* Public functions */
-- 
2.19.0.397.gdd90340f6a-goog

