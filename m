Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17977ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC834214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RraQOg4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC834214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbeIRGRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40972 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeIRGRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so105291pfk.8;
        Mon, 17 Sep 2018 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TJUB5Y8stsaj+NlXR7or8AWO9SD70GBJBp+fkS7Z/BE=;
        b=RraQOg4M6cKTWVCfIpuljXY3YVE61hnDxIvFLYatvHAVB7WhPgPivPl6XoNjZF0tvi
         T8UiGYlGPq1UbZy4TsvL0c0gLB4fB2K/UVmI7v2pXs6hrfceCt9xV3qyBW3mnNTlGZs5
         YZa3zuEUFowKqPO+Z5B4D2lwgvW65SrcqX002vf7mi7QZHvuBSl49wwJ8BIcCyBX0aBG
         N+Bw0EPZHHTIkVoxSz+fpXrPE5Sll0XWHzE/wnt+H7FdcxGqwArapoBkazFTxV3dwMdc
         3Bx+2aiBRZnRexaH+l0l+lEkYA3tZS8Yg/do0ZekUK8Ubu/ZuePdk3RJgHVqocGRMwuB
         fFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TJUB5Y8stsaj+NlXR7or8AWO9SD70GBJBp+fkS7Z/BE=;
        b=SVFlzg+LZJMEnuL0h2c5aAVhyg6el8LX4FO9PBICN1/AVkrrLmhp74qVHSebqKoJBU
         AYaU/BCGnJ8RvzeiQNPGc3EF43ZeTsLS9jyMIHsOliBw0OT3+ObHPQghjc12Evo3aRJ3
         a8a29WN8GSYbfsJzH949b8Oexxc+WsmyN/t+uw5VBfwrOxzkqa4dWik8ALv64F6ahXjG
         fk2Ug8HrtQWZubSPagU6Mu/dzCvX5PsRrl+Ot2DWIQVwDLoyuOmNKe/UTCUKt/phtmOo
         hu78IHQYWMRLEXm6HVZkLSzxulU4QewLYjrHJjzyqNlTC9RQpZl1mmV3BGBr9eqVri1q
         +cIw==
X-Gm-Message-State: APzg51C2LnnEcjSCQImyVMqOatjx3CsCAzuYWoGwEAL6MjAdww6cQCR2
        4l47Sk6Ff8X7z99F3vdGJbmmuboo
X-Google-Smtp-Source: ANB0VdbDVxbZzmz8UwRTU74nZ/O97ERrf+Nv/3E1dcvPW1iU86x6yjAIJMpPdIpe3K+BNID58iNc1A==
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr28340287pfd.32.1537231673018;
        Mon, 17 Sep 2018 17:47:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] Input: iforce - do not combine arguments for iforce_process_packet()
Date:   Mon, 17 Sep 2018 17:47:24 -0700
Message-Id: <20180918004732.9875-12-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code combines packet type and data length into single argument to
iforce_process_packet() and then has to untangle it. It is much clearer to
simply use separate arguments.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 9 +++++----
 drivers/input/joystick/iforce/iforce-serio.c   | 8 ++++----
 drivers/input/joystick/iforce/iforce-usb.c     | 4 ++--
 drivers/input/joystick/iforce/iforce.h         | 3 ++-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index ffd1dd65deb8..35b7a5206977 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -166,7 +166,8 @@ static void iforce_report_hats_buttons(struct iforce *iforce, u8 *data)
 	}
 }
 
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+void iforce_process_packet(struct iforce *iforce,
+			   u8 packet_id, u8 *data, size_t len)
 {
 	struct input_dev *dev = iforce->dev;
 	int i, j;
@@ -176,14 +177,14 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	if (!iforce->type)
 		return;
 
-	switch (HI(cmd)) {
+	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
 		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
 		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
 		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
-		if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+		if (len >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
 			input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
 
 		iforce_report_hats_buttons(iforce, data);
@@ -217,7 +218,7 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
 
-		for (j = 3; j < LO(cmd); j += 2)
+		for (j = 3; j < len; j += 2)
 			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 6c6411fbdc32..f8bf7d2aa59f 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -163,16 +163,16 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce_serio->idx == iforce_serio->len) {
-		u16 cmd = (iforce_serio->id << 8) | iforce_serio->idx;
-
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			iforce->ecmd = cmd;
+			iforce->ecmd = (iforce_serio->id << 8) |
+					iforce_serio->idx;
 			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
 		}
 
-		iforce_process_packet(iforce, cmd, iforce->data);
+		iforce_process_packet(iforce, iforce_serio->id,
+				      iforce->data, iforce_serio->len);
 
 		iforce_serio->pkt = 0;
 		iforce_serio->id  = 0;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index cefaa1c5abc7..b3743fde2a3a 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -170,8 +170,8 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
-	iforce_process_packet(iforce,
-		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1);
+	iforce_process_packet(iforce, iforce->data[0],
+			      iforce->data + 1, urb->actual_length - 1);
 
 exit:
 	status = usb_submit_urb(urb, GFP_ATOMIC);
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 3e3df83b9d77..ce3c6aead8b6 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -147,7 +147,8 @@ int iforce_init_device(struct device *parent, u16 bustype,
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data);
+void iforce_process_packet(struct iforce *iforce,
+			   u8 packet_id, u8 *data, size_t len);
 int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data);
 void iforce_dump_packet(struct iforce *iforce, char *msg, u16 cmd, unsigned char *data);
 
-- 
2.19.0.397.gdd90340f6a-goog

