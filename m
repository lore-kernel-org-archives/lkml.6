Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB79BECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77AC6214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwSXywbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77AC6214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeIRGR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47031 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbeIRGR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so94352pga.13;
        Mon, 17 Sep 2018 17:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CqGMjCUs/uvCGUwiT2aDuH2Habwf0XsqYCKkMi9e1Fg=;
        b=bwSXywbRDwDbIzMxWPzc/3CTV+SOiWfrH3g4cDrTA/xGXTo5ZJ+8nXRBN2C3r6V6N5
         mWFvEim+4O4nmTwJL9TUze3ba9C8jZ/M6RYWwxA+89yuPdCHu7Yk6v5Fg4KobM0s3cMG
         h5cnjb4DstFGW6reczOzxETqossn5urlwIAGFKF0EiEWljdNqTrNA/pAgsLmC2l/VB5U
         /4xQA8C41k3eZoP3P9E0rjJDpLmCaXs4w8bo/uNeByNCZiF7/+wwFq+DJ5MSSnjTbOlM
         zDB+5Qyy0pUgscA1+QnRS7VhuaW4kIjlVFNXlS10KwY+LFme/at8rXsxxibN+PzSou1P
         G1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CqGMjCUs/uvCGUwiT2aDuH2Habwf0XsqYCKkMi9e1Fg=;
        b=LAau34VQOE6HmDOVcSgIIKB3kJnWwIufFhD8Y26eyFZNWxou1P8Nao+u5+flpB9BVb
         gWEX72wFNNnapiXlmpz43YDjXceWvQ4wzO/5qfRdDYlv9EMTqhnrf9k9NG6JP5pkPuNc
         Mhh0NI51PZq26QWYgiLaJ4u+0f94R/O8iQd97L61fXlgFT9GpJWRMF+aRuMwhRxWU85e
         UiOToSjR7nu/fmS0+D+WPDjAQ+jCu5zIKrXc1cSSgK+lT2iIjKsCtfP6GbDyUeJLdnFN
         Uc+G5aAYe0CiHqEhq7XmbDez42+M7eqyLnj+ZpnfWfXu3XuWzkwT9FDh35f52IS2HBny
         h+9w==
X-Gm-Message-State: APzg51CEQp1Ts8nd+XWMFjdKeGoZavfNSUrIZ/ZjLzRMWzubvxBoLmyX
        hSBvJe2NKYpqcmG1y1Cj2Rd1tdnF
X-Google-Smtp-Source: ANB0VdaEwjF6o+Tv3Umj6ZPXN1Xi/VDfVjYtseoiVDbEF880FSZv7k3ozFISxeaYbvNeJPZQlWJ9Vg==
X-Received: by 2002:a63:2106:: with SMTP id h6-v6mr25155554pgh.161.1537231684502;
        Mon, 17 Sep 2018 17:48:04 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:48:03 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] Input: iforce - drop couple of temps from transport code
Date:   Mon, 17 Sep 2018 17:47:31 -0700
Message-Id: <20180918004732.9875-19-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transport initialization code now deals mostly with transport-specific
data, so we can drop couple of temporary variables.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 7 ++-----
 drivers/input/joystick/iforce/iforce-usb.c   | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 277522d0f324..e7692a38591e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -204,16 +204,13 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct iforce_serio *iforce_serio;
-	struct iforce *iforce;
 	int err;
 
 	iforce_serio = kzalloc(sizeof(*iforce_serio), GFP_KERNEL);
 	if (!iforce_serio)
 		return -ENOMEM;
 
-	iforce = &iforce_serio->iforce;
-
-	iforce->xport_ops = &iforce_serio_xport_ops;
+	iforce_serio->iforce.xport_ops = &iforce_serio_xport_ops;
 
 	iforce_serio->serio = serio;
 	serio_set_drvdata(serio, iforce_serio);
@@ -222,7 +219,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (err)
 		goto fail1;
 
-	err = iforce_init_device(&serio->dev, BUS_RS232, iforce);
+	err = iforce_init_device(&serio->dev, BUS_RS232, &iforce_serio->iforce);
 	if (err)
 		goto fail2;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index ae2dd5b5a416..a1e670781441 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -208,7 +208,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *interface;
 	struct usb_endpoint_descriptor *epirq, *epout;
 	struct iforce_usb *iforce_usb;
-	struct iforce *iforce;
 	int err = -ENOMEM;
 
 	interface = intf->cur_altsetting;
@@ -231,9 +230,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!iforce_usb->out)
 		goto fail;
 
-	iforce = &iforce_usb->iforce;
-
-	iforce->xport_ops = &iforce_usb_xport_ops;
+	iforce_usb->iforce.xport_ops = &iforce_usb_xport_ops;
 
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
@@ -248,7 +245,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 			 iforce_usb->data_out, sizeof(iforce_usb->data_out),
 			 iforce_usb_out, iforce_usb, epout->bInterval);
 
-	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
+	err = iforce_init_device(&intf->dev, BUS_USB, &iforce_usb->iforce);
 	if (err)
 		goto fail;
 
-- 
2.19.0.397.gdd90340f6a-goog

