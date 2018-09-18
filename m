Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BECECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351CC214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWB52MIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351CC214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbeIRGRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbeIRGRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:33 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7-v6so117977pgf.2;
        Mon, 17 Sep 2018 17:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Re7V/+eHmV1ScUdnfZ229caXo8Q+chYJv59OC/pPiXI=;
        b=CWB52MIbaTOo/B0Z5tsnwYMNBFF3jehAwA0/8P0wD2qKXv95tRcZKJu1DLnL/eSkV/
         8tJy1polvDwUMg5KdqPvvPyuCUVsInbk6L3jINmSvJbehk5LxTl0SizWQwti1ZnH8l+o
         LfQz3kzzhl3V54Y6cc5VmiUSVp1Aw3AlXgvGEsnMEXFNkYdmKpS1y1yc6HrdNkxAw+0W
         LfLc8/gr41x2XE/vZctSqrh7nMGrKEpxgCzdpKhlQmz6azOscnC1MXS2nut9O5SjzLMa
         gGs/iowvhuPhFuf2eevXKCT9S2DvvoZ6vxMC5U8JazHQryCY4DknLJhOfI2YxQxrGcjm
         eM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Re7V/+eHmV1ScUdnfZ229caXo8Q+chYJv59OC/pPiXI=;
        b=L/cuitHfqjhkvnUxtvumP/q0S/zj+boc0MOKNjCSRRiIYv7V/lvvpg6jiAqkwvoF4k
         7VQIg6A1hyBw7C3G4lpm6z1kiqnxGWzO2XZ6fOSqBmHVZSlQHASBogmSuQYcSlKHIprw
         goY5vThOpAvSub3FQPq4BEJ6gglEOw1g4KL9ebNIK8c3Bsza9n0vhcbCoQl80w4Y8N3K
         qbUjpbSOnYAoiGObHqxd8cDAoruXx/nkFt5Lsy5scsnD644ay6zdUFpZwNPxIqrWfDvc
         g2Rd3eKaPlRm3QBo+razEHmlQUtQJ6mtWbPsTUEaZgH22NWH7VZcZh0B0pxEWlo2ip0H
         LKbQ==
X-Gm-Message-State: APzg51DDjCZOSKID+4vp8RQp/MJXLp2gVvgP7RL0CYKhsAQSDuIfImDb
        PAyu8EHhtf71h7GUId8Emmy48LJC
X-Google-Smtp-Source: ANB0Vdbijjxp9sHCzKpDyrbXkDj5zLHo18NEwqjbXO+dfvmuDPysQOmYyZ8/IBP+TGm11ZYs2v08Zg==
X-Received: by 2002:a63:c702:: with SMTP id n2-v6mr25934569pgg.108.1537231659032;
        Mon, 17 Sep 2018 17:47:39 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:38 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/20] Input: iforce - move get_id to the transport operations
Date:   Mon, 17 Sep 2018 17:47:15 -0700
Message-Id: <20180918004732.9875-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid #ifdef-ing out parts of the code and having conditionals in normal
control flow, let's define "get_id" transport method and move
implementation into respective transport modules.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 64 -------------------
 drivers/input/joystick/iforce/iforce-serio.c  | 17 +++++
 drivers/input/joystick/iforce/iforce-usb.c    | 29 +++++++++
 drivers/input/joystick/iforce/iforce.h        |  6 +-
 4 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index b8ca9bdfdef8..e677562efc9a 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -210,67 +210,3 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			break;
 	}
 }
-
-int iforce_get_id_packet(struct iforce *iforce, char *packet)
-{
-	switch (iforce->bus) {
-
-	case IFORCE_USB: {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		int status;
-
-		iforce->cr.bRequest = packet[0];
-		iforce->ctrl->dev = iforce->usbdev;
-
-		status = usb_submit_urb(iforce->ctrl, GFP_KERNEL);
-		if (status) {
-			dev_err(&iforce->intf->dev,
-				"usb_submit_urb failed %d\n", status);
-			return -1;
-		}
-
-		wait_event_interruptible_timeout(iforce->wait,
-			iforce->ctrl->status != -EINPROGRESS, HZ);
-
-		if (iforce->ctrl->status) {
-			dev_dbg(&iforce->intf->dev,
-				"iforce->ctrl->status = %d\n",
-				iforce->ctrl->status);
-			usb_unlink_urb(iforce->ctrl);
-			return -1;
-		}
-#else
-		printk(KERN_DEBUG "iforce_get_id_packet: iforce->bus = USB!\n");
-#endif
-		}
-		break;
-
-	case IFORCE_232:
-
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-		iforce->expect_packet = FF_CMD_QUERY;
-		iforce_send_packet(iforce, FF_CMD_QUERY, packet);
-
-		wait_event_interruptible_timeout(iforce->wait,
-			!iforce->expect_packet, HZ);
-
-		if (iforce->expect_packet) {
-			iforce->expect_packet = 0;
-			return -1;
-		}
-#else
-		dev_err(&iforce->dev->dev,
-			"iforce_get_id_packet: iforce->bus = SERIO!\n");
-#endif
-		break;
-
-	default:
-		dev_err(&iforce->dev->dev,
-			"iforce_get_id_packet: iforce->bus = %d\n",
-			iforce->bus);
-		break;
-	}
-
-	return -(iforce->edata[0] != packet[0]);
-}
-
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index c9469209f994..fa45ce425d47 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -67,8 +67,25 @@ static void iforce_serio_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
+{
+	iforce->expect_packet = FF_CMD_QUERY;
+	iforce_send_packet(iforce, FF_CMD_QUERY, packet);
+
+	wait_event_interruptible_timeout(iforce->wait,
+					 !iforce->expect_packet, HZ);
+
+	if (iforce->expect_packet) {
+		iforce->expect_packet = 0;
+		return -EIO;
+	}
+
+	return -(iforce->edata[0] != packet[0]);
+}
+
 static const struct iforce_xport_ops iforce_serio_xport_ops = {
 	.xmit		= iforce_serio_xmit,
+	.get_id		= iforce_serio_get_id,
 };
 
 static void iforce_serio_write_wakeup(struct serio *serio)
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d4f7f34db9a0..f7eeaad92602 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -75,8 +75,37 @@ static void iforce_usb_xmit(struct iforce *iforce)
 		__iforce_usb_xmit(iforce);
 }
 
+static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
+{
+	int status;
+
+	iforce->cr.bRequest = packet[0];
+	iforce->ctrl->dev = iforce->usbdev;
+
+	status = usb_submit_urb(iforce->ctrl, GFP_KERNEL);
+	if (status) {
+		dev_err(&iforce->intf->dev,
+			"usb_submit_urb failed %d\n", status);
+		return -EIO;
+	}
+
+	wait_event_interruptible_timeout(iforce->wait,
+		iforce->ctrl->status != -EINPROGRESS, HZ);
+
+	if (iforce->ctrl->status) {
+		dev_dbg(&iforce->intf->dev,
+			"iforce->ctrl->status = %d\n",
+			iforce->ctrl->status);
+		usb_unlink_urb(iforce->ctrl);
+		return -EIO;
+	}
+
+	return -(iforce->edata[0] != packet[0]);
+}
+
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
 	.xmit		= iforce_usb_xmit,
+	.get_id		= iforce_usb_get_id,
 };
 
 static void iforce_usb_irq(struct urb *urb)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 2fea3be751ed..f6636230be31 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -97,6 +97,7 @@ struct iforce;
 
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
+	int (*get_id)(struct iforce *iforce, u8* id);
 };
 
 struct iforce {
@@ -146,6 +147,10 @@ struct iforce {
 /* Encode a time value */
 #define TIME_SCALE(a)	(a)
 
+static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
+{
+	return iforce->xport_ops->get_id(iforce, id);
+}
 
 /* Public functions */
 /* iforce-main.c */
@@ -156,7 +161,6 @@ int iforce_control_playback(struct iforce*, u16 id, unsigned int);
 void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data);
 int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data);
 void iforce_dump_packet(struct iforce *iforce, char *msg, u16 cmd, unsigned char *data);
-int iforce_get_id_packet(struct iforce *iforce, char *packet);
 
 /* iforce-ff.c */
 int iforce_upload_periodic(struct iforce *, struct ff_effect *, struct ff_effect *);
-- 
2.19.0.397.gdd90340f6a-goog

