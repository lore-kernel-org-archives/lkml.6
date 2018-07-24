Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D22ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FBE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGg8qQtL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FBE20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbeGXDjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:39:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41552 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388201AbeGXDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:39:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id z8-v6so1731563pgu.8;
        Mon, 23 Jul 2018 19:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cdOh9KwZQ3VRGuvdHjTJJMYb7otdnGJ6QUlutkWC3j4=;
        b=EGg8qQtLRDnSBMQ75vagucSQWWkgOwtUb3C8+Jq5OQuijEDH6AqXRb0rE1bvqhxzi5
         uTvidBgOTbWgnnmgNpD9TkGZ3uYEkjcTWteyatLMXl7OyPoKdgJP1aerYwizHWcQcLHj
         tSkSycaDiHxClL3a/wxDXLJGHV9d0l/fZ1/NYsg5oRQJOdOzb/+FOVlzsP/aW02ULWBK
         wB0sjqi8JhgdridRX1OpWFaeC3I4BUK9EgvhFAFte6nFuZEzSJrDv3H1kGnd3sd4Kn8T
         q0p6niGOTM+OsM+cgtiyOoH23aWIW/PYkN1sTiqTOSlwnneMStphl1/zVy9Hq7Ltt9lz
         mRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cdOh9KwZQ3VRGuvdHjTJJMYb7otdnGJ6QUlutkWC3j4=;
        b=CyRN3foBfoFdYPfQW2BfTlX6d+xWuQtkNKh2nslk15+mKgL5UFNcpkJBUGw6wgTR4m
         OqSU8SzYHzGvabjGl45RFNjRwar6cQwjJPRBAxqvcfuRs5Kx7czyUWGGPFTZEQPO8kmn
         MFz5ReSqh7IwKJOytxuieatC27u8LUK0rYXlKp5PPaf1K8vltsGf66eLUkjzJdNE5CUh
         PPxL20yHb2Rxl1SL9Pxmm2ZCRb2HbGHw4mBjOZ7DDbdVtfJICv5e74zXW5HJiNolYTVe
         LgnoyEyAGDrds95T89mDNdSWRqbwtuznxopZGBRLbp3bdBiMQZYkkYmojeeoaIC/6K64
         h4rg==
X-Gm-Message-State: AOUpUlGDx1JUKJbrNDQs9/Mnr2N6x0Ab1PsORmqtAapDz1OKWs0gjOAl
        KBC6hWl9UHPWzORCGuXNGrcGDpJd
X-Google-Smtp-Source: AAOMgpdkuTPLaU4BrZrMO3JyeJvIWt9fdHmUx1pV3vz6BJJ5SYNsLjrl2FnTQ4HmAwQ+kQe/hhT+KA==
X-Received: by 2002:a62:4704:: with SMTP id u4-v6mr15706310pfa.76.1532399723082;
        Mon, 23 Jul 2018 19:35:23 -0700 (PDT)
Received: from penguin.lxd ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id n9-v6sm20540942pfg.21.2018.07.23.19.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 19:35:21 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 1/5] Input: pxrc - do not store USB device in private struct
Date:   Tue, 24 Jul 2018 02:35:16 +0000
Message-Id: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Folkesson <marcus.folkesson@gmail.com>

The USB device is only needed during setup, so put it back after
initialization and do not store it in our private struct.

Also, the USB device is a parent of USB interface so our driver
model rules ensure that USB device should not disappear while
interface device is still there; there is no need to take reference
to the USB device.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Patchwork-Id: 10526903
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..000b9b7da744 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -27,7 +27,6 @@ MODULE_DEVICE_TABLE(usb, pxrc_table);
 
 struct pxrc {
 	struct input_dev	*input;
-	struct usb_device	*udev;
 	struct usb_interface	*intf;
 	struct urb		*urb;
 	struct mutex		pm_mutex;
@@ -122,6 +121,7 @@ static void pxrc_close(struct input_dev *input)
 
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
+	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
 	int retval;
@@ -145,7 +145,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	}
 
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -154,9 +154,9 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		goto error;
 	}
 
-	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
-						pxrc_usb_irq, pxrc, 1);
+	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
+			 pxrc_usb_irq, pxrc, 1);
 
 error:
 	return retval;
@@ -174,7 +174,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(pxrc->udev, &pxrc->input->id);
+	usb_to_input_id(interface_to_usbdev(pxrc->intf), &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -204,7 +204,6 @@ static int pxrc_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	mutex_init(&pxrc->pm_mutex);
-	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf = intf;
 
 	retval = pxrc_usb_init(pxrc);
-- 
2.11.0

