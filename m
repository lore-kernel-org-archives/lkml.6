Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C28208AD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhAAdOzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C28208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeGPPIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:08:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41359 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeGPPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:08:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id v22-v6so18943933lfe.8;
        Mon, 16 Jul 2018 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5n7TlSp8IHVDpgIU7r+I8Ph6HATZOugNeoiUTvUVQE0=;
        b=KhAAdOzpQVv4rP3BLpsQ9bU9DJLv4ALB9XbcWUB7pfFYAjQS2d/oGrvIeFydj+WCrD
         iJ79lF8WsNzL31wXjesvaQ2dLGPTrf9CZHh6zUovTArFeZE1b+iNCmXq8ap2jzgHvKSv
         6TH/XXjxVEKCtuDjHkjlqcodyvq2rvYEVPTjGNIxhCm0zPjEYCu4agcyIj8ICwpbvhzn
         Iq0vDbklSlGC0jP+OmzRPOeLn7jewIW8nX9We03WA7rYnBCbeRQI8TNnQJepOSo+q/cs
         /a2FR0JFtBeoftYGFqlZY40n+IUPt5Afu3utS/QR/eS6vnv7nnJ3bKErjHx42OgwKjEz
         k4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5n7TlSp8IHVDpgIU7r+I8Ph6HATZOugNeoiUTvUVQE0=;
        b=t+Pir+nQt7y+S+FZdAzdTPSWkurvvjYZj59yY5QMiLFc+2/g3CFCjhVyw3XdWWjPpd
         q3FUhkbAZ2q7rGcLLAYsFAh4NQ98MqYpt+gvnq8GsYUyyUNnQhBmVJ92I4X6NHCkfF/a
         w5TYOpL+U+gCegU3u0iA6VIVTCSDJ+OTE1uKgsjWDeQG7OsbHPsTiiEtmWJUMJ0RPv4w
         zstYwyYqZlVaHqhIYfCilTfuo0G/BRWBLlOqL9le5RDsPG0Wfb0Q9Qv50Y0JYUEn5lGM
         U2XjS7HCNtoaD6+BACw9ibFQPa5NxY9NP62A7WLhhsXWD9FgIXDZYSTq5WUnqv4qN6F8
         iZ0w==
X-Gm-Message-State: AOUpUlGwXNNFXLectja/aV8Ae8R6cql4GtziJ25Zodxft1ksjNBpULeX
        9WlSVxkGIrz7UkgoDmlZtdgquw==
X-Google-Smtp-Source: AAOMgpcy7XTh+jhKlljdWQVh8KItRNafe763+Sz7ta02rWnSFYL24k5cZpGIEg67/o6o9eTqUkz9Tg==
X-Received: by 2002:a19:2887:: with SMTP id o129-v6mr12201099lfo.95.1531752060950;
        Mon, 16 Jul 2018 07:41:00 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26dfb-74736162.cust.telenor.se. [46.194.109.251])
        by smtp.gmail.com with ESMTPSA id h40-v6sm3153894lfi.84.2018.07.16.07.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:40:59 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: pxrc - do not store USB device in private struct
Date:   Mon, 16 Jul 2018 16:40:14 +0200
Message-Id: <20180716144014.6331-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB device is only needed during setup, so put it back after
initialization and do not store it in our private struct.

Also, the USB device is a parent of USB interface so our driver
model rules ensure that USB device should not disappear while
interface device is still there.
So not keep a refcount on the device is safe.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..46a7acb747bf 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -27,7 +27,6 @@ MODULE_DEVICE_TABLE(usb, pxrc_table);
 
 struct pxrc {
 	struct input_dev	*input;
-	struct usb_device	*udev;
 	struct usb_interface	*intf;
 	struct urb		*urb;
 	struct mutex		pm_mutex;
@@ -120,7 +119,7 @@ static void pxrc_close(struct input_dev *input)
 	mutex_unlock(&pxrc->pm_mutex);
 }
 
-static int pxrc_usb_init(struct pxrc *pxrc)
+static int pxrc_usb_init(struct pxrc *pxrc, struct usb_device *udev)
 {
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
@@ -145,7 +144,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	}
 
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -154,8 +153,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		goto error;
 	}
 
-	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
+	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
 						pxrc_usb_irq, pxrc, 1);
 
 error:
@@ -164,7 +163,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 
 }
 
-static int pxrc_input_init(struct pxrc *pxrc)
+static int pxrc_input_init(struct pxrc *pxrc, struct usb_device *udev)
 {
 	pxrc->input = devm_input_allocate_device(&pxrc->intf->dev);
 	if (pxrc->input == NULL) {
@@ -174,7 +173,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(pxrc->udev, &pxrc->input->id);
+	usb_to_input_id(udev, &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -197,6 +196,7 @@ static int pxrc_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
+	struct usb_device *udev;
 	int retval;
 
 	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
@@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	mutex_init(&pxrc->pm_mutex);
-	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
+	udev = usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf = intf;
 
-	retval = pxrc_usb_init(pxrc);
+	retval = pxrc_usb_init(pxrc, udev);
 	if (retval)
 		goto error;
 
-	retval = pxrc_input_init(pxrc);
+	retval = pxrc_input_init(pxrc, udev);
 	if (retval)
 		goto err_free_urb;
 
+	usb_put_dev(udev);
 	return 0;
 
 err_free_urb:
 	usb_free_urb(pxrc->urb);
 
 error:
+	usb_put_dev(udev);
 	return retval;
 }
 
-- 
2.18.0

