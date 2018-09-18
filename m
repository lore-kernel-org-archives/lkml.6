Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86917ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CFC214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKYzLolW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CFC214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbeIRGRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35700 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeIRGRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2-v6so111909plo.2;
        Mon, 17 Sep 2018 17:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptHpG94iG8JdtUK1/m7tAxhwZpuHN0rNhGhfBTFsAvc=;
        b=RKYzLolWwan4vuO4GKC1pQNY8McACKheEYxMbc0L+io2IckRAdzriZJgzg45kxn6pr
         v8a7lm8w4dj1AkE4NS9vphKa6qzYUB+u8yurYKIEz+pasSsaqK0+ztpQvAjF+UwDcHJe
         OjhSerr41DVlBz3/ePO/+rrRrnGz6e0rBB6sSeIGeS3BlVZ/KbdTJe+HAjL0JetKbJHm
         7VBMkt/lGABgOoW2Y3/9yce0bEz+VvccydHKpgrW1JV7FB3HXSg7F+nhUVGu7xyY7be0
         lkmJFJN9WSYItX97/MOclTecyUfQ8rOMSEEXpwL87rSXwbYS/DPDp3Cr2WzHNBQk97Ip
         g7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptHpG94iG8JdtUK1/m7tAxhwZpuHN0rNhGhfBTFsAvc=;
        b=XvEuTmi6Judfcyd7XYlF21rnxHCyyk6ITAH3AvqkrbinEpkUedYpA1NxmoEwXkvGlE
         8SQ5l9ZX7RKiA79dqher/Dz9QW9XEZmVpj6VXdKNjywgA5fIwi74BFEB/jCw+8MOQVFc
         oTgBa7cKbBQ3l4kPhoGE8TLjyqDnEi77dwdzwWkoveAxfzkjiahVebbj4mZCPhmHj4ov
         D8sTfZ61j5A0IOapxs2fii6XSzfdy5d3mrYxhRjA4Hbi0q2YsR3L/kY+0IdzeIN8uKoo
         rP515G7JkY1thkK5LZLhY+dtZBLGS/LAqOsYOJoEWuRxHrrHqfzrGnTMxDfCKl3lExF0
         cd8w==
X-Gm-Message-State: APzg51A6ZxSAiQC09WcCSEULZ+dK2j/WoG7575zlhqHYtETuyxIRqToS
        Pqja/BllwQk0rDeQTarLg1TbqyBQ
X-Google-Smtp-Source: ANB0VdbtAML6YP93rw61DspBR096C7IEhVrAorlv+W04DchUhXKzD9JPMfTIdgvDGqP5jcMrzLvT7A==
X-Received: by 2002:a17:902:22e:: with SMTP id 43-v6mr27311411plc.118.1537231664425;
        Mon, 17 Sep 2018 17:47:44 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] Input: iforce - add bus type and parent arguments to iforce_init_device()
Date:   Mon, 17 Sep 2018 17:47:18 -0700
Message-Id: <20180918004732.9875-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the parent device for the USB-connected controllers is now
USB interface instead of USB device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 19 ++++---------------
 drivers/input/joystick/iforce/iforce-serio.c |  2 +-
 drivers/input/joystick/iforce/iforce-usb.c   |  2 +-
 drivers/input/joystick/iforce/iforce.h       |  3 ++-
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 4401ca4a4c38..894769d03df3 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -221,7 +221,8 @@ static void iforce_close(struct input_dev *dev)
 	iforce->xport_ops->stop_io(iforce);
 }
 
-int iforce_init_device(struct iforce *iforce)
+int iforce_init_device(struct device *parent, u16 bustype,
+		       struct iforce *iforce)
 {
 	struct input_dev *input_dev;
 	struct ff_device *ff;
@@ -243,20 +244,8 @@ int iforce_init_device(struct iforce *iforce)
  * Input device fields.
  */
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	case IFORCE_USB:
-		input_dev->id.bustype = BUS_USB;
-		input_dev->dev.parent = &iforce->usbdev->dev;
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	case IFORCE_232:
-		input_dev->id.bustype = BUS_RS232;
-		input_dev->dev.parent = &iforce->serio->dev;
-		break;
-#endif
-	}
+	input_dev->id.bustype = bustype;
+	input_dev->dev.parent = parent;
 
 	input_set_drvdata(input_dev, iforce);
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index afc7521b430d..b5dea273f98e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -183,7 +183,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (err)
 		goto fail1;
 
-	err = iforce_init_device(iforce);
+	err = iforce_init_device(&serio->dev, BUS_RS232, iforce);
 	if (err)
 		goto fail2;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 10b583b5fc82..824df4273774 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -229,7 +229,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	usb_fill_control_urb(iforce->ctrl, dev, usb_rcvctrlpipe(dev, 0),
 			(void*) &iforce->cr, iforce->edata, 16, iforce_usb_ctrl, iforce);
 
-	err = iforce_init_device(iforce);
+	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
 		goto fail;
 
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index c020d61eccf2..3ee9245a415b 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -156,7 +156,8 @@ static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
 
 /* Public functions */
 /* iforce-main.c */
-int iforce_init_device(struct iforce *iforce);
+int iforce_init_device(struct device *parent, u16 bustype,
+		       struct iforce *iforce);
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
-- 
2.19.0.397.gdd90340f6a-goog

