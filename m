Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE332ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850D7214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrqAzBQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850D7214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeIRGR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIRGR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so94335pga.13;
        Mon, 17 Sep 2018 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGr4r8GexPsIaQ1Kf4tDzDfD+BK7SJUhhOLQe4lCNHQ=;
        b=JrqAzBQXzqzRm8CAvx2CoJlW68eG/pfc9S84gG/1VU9EB8xswSmtIWVo3aLEC89ouJ
         zi8JjMixw09X1+Joy/A44Jm6XnEkqjWiq/o2tXSFJb7AbqWp8G7reRk73/7SepPafu3A
         0CxSob0Wrept/M1+UO5oLQfNrD1qGtIdgyXKVNzBmf63nbRkOPi2EaTfm8UDhTHV98FF
         IgHFa4oH5jGUtgXJ0Sp4vw0W7PdDRuP974DMWquDl1I6U88f0Jzx+iYswKVJig7wjFWD
         bXn5A/quemrPLr/8M805/kFR0sfbVg8kgInJCCAGdbvN8sWT4RyGQrexgdLlNeEAhBzz
         aZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGr4r8GexPsIaQ1Kf4tDzDfD+BK7SJUhhOLQe4lCNHQ=;
        b=kd+jLS/sU8QCjmMhXjBea1yTv+o+Kuztp6bioCrnvQDuz6moB0VaU4d/PDdf4hTh7Q
         dpIaktQSrAXS6hd9UhZ9WuB4bOT9K4S7/A6YW3cTbQrnjsSqGez/0A95U6GeGyo6cneN
         EFMhxHuSC8zF/VNRBA4W9eGkrTcoZuUUmfEFKXCJy5lFng+Lsce/QuasRuduUkROyFl/
         XxbZzdV1crsa1NNdj6UegWuCgWBII0dbSgRZNbfKIu9P1JmWKF2yNT/kdiTS6sgojdhL
         7tUoly8Eitqjhj37VX/CvtiDeOMaB6tYWICLSKbY5BZ7XeDUVVT5R977SVdaZGON6B4/
         rLBg==
X-Gm-Message-State: APzg51B6RPBFxvlpZU3gLQzgxvsYWbz5D1AEyg//6Q01n5nyh+Buwh9X
        NmWO3G4enyLKAE6kJGPmj3/IhHCf
X-Google-Smtp-Source: ANB0VdZ8ncM130KU6cbc0qtp46dPwEBlk+lBV8vC8EoObvpLh4G0NqK0TnsYz9uNUL5o4Niii9f60w==
X-Received: by 2002:a63:d74f:: with SMTP id w15-v6mr25579512pgi.306.1537231683097;
        Mon, 17 Sep 2018 17:48:03 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:48:01 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 18/20] Input: iforce - drop bus type from iforce structure
Date:   Mon, 17 Sep 2018 17:47:30 -0700
Message-Id: <20180918004732.9875-18-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not needed anymore as behavior is controlled by the transport
operations set up for given device.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 1 -
 drivers/input/joystick/iforce/iforce-usb.c   | 1 -
 drivers/input/joystick/iforce/iforce.h       | 5 -----
 3 files changed, 7 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index c73d988cbc92..277522d0f324 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -214,7 +214,6 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	iforce = &iforce_serio->iforce;
 
 	iforce->xport_ops = &iforce_serio_xport_ops;
-	iforce->bus = IFORCE_232;
 
 	iforce_serio->serio = serio;
 	serio_set_drvdata(serio, iforce_serio);
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d85258b50be2..ae2dd5b5a416 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -234,7 +234,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce = &iforce_usb->iforce;
 
 	iforce->xport_ops = &iforce_usb_xport_ops;
-	iforce->bus = IFORCE_USB;
 
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 180de7a3f3a1..3e91cc381488 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -38,10 +38,6 @@
 
 #define IFORCE_MAX_LENGTH	16
 
-/* iforce::bus */
-#define IFORCE_232	1
-#define IFORCE_USB	2
-
 #define IFORCE_EFFECTS_MAX	32
 
 /* Each force feedback effect is made of one core effect, which can be
@@ -105,7 +101,6 @@ struct iforce {
 	struct input_dev *dev;		/* Input device interface */
 	struct iforce_device *type;
 	const struct iforce_xport_ops *xport_ops;
-	int bus;
 
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
-- 
2.19.0.397.gdd90340f6a-goog

