Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B403BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD1520854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFgei6WY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD1520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIMOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:30:42 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46374 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeIMOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:30:42 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so3992488ljj.13;
        Thu, 13 Sep 2018 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvyjQMihlUHdoi57V5s5noOvDcWJQCxt1PQLEaYWtY4=;
        b=uFgei6WYWCBvEkcQtVweGI0aitdAe5azgluUXyyGcsb1/HlCD99vwTl5DyYWaq2DRQ
         zAoUUA3Jo7RDb5J2aD2UF+l4qN+Zw1KKd0WiZ5+V1GNsYETrTaoM3/15rWJG0AKuFMrB
         4T44J/pCqIDsphbE2x8XVIKxUrMEahyGRGUL+uql9verBBH9iWcbsOjyM5Bf/cZOKsU2
         sU3mN2FBWzsT7AcgJNd0etHOhygzwn9SyJBzBm7uPGXC2/gDXdGN0tfYpSNt8wEeb9HT
         wZ4apRf3MFOdwC0z4XoZ02M37Zt7rABt7wF5oRGlgIqKJO5mDFSq9PasxX1ReBhCroef
         gc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NvyjQMihlUHdoi57V5s5noOvDcWJQCxt1PQLEaYWtY4=;
        b=OcV8ka5ETdZkGnegngR9hHEdVtpLwYd3ZwbPd6NtQWLlq0PhOwiQpaW/Ll+I+gqrtC
         up6wVEPnVY3PcQdUKNizWLYz43KdT/5IgOG8KtaE49oGhRpUrHk1Kd4jlZXhxun8DD+x
         g6UQ/TVPUlEhzMRHbO06RSsdlJUNdOC42ICctsokSmTBpi0iR1N7r0MTZexm7xegSzJV
         s8OV7S3/kaFG/6ZOVRWMrpcCqnHIVhlLgQAHHkQxubRkRBwXgvzwRZ68C64XeP3eXZJJ
         TdBBkg+XgiayF2u2BNrohmAvCt4EnNGxoxP3lhw504Dr9Fzrf0wdrbfreRicmlab5yNi
         GzOQ==
X-Gm-Message-State: APzg51B/nA+VIsjrObankItPyts56JTBcNNljeSJ5sJw74P7LW7uKZMR
        w7SZZ93fkMA48Ukfo0FyR54=
X-Google-Smtp-Source: ANB0Vdasamz84fHVn4cizh9CFNDuPxuKhuKGuujbRjSu8iPlLBxPbfGbekHA0KxgV//LpGjHAyv8eQ==
X-Received: by 2002:a2e:947:: with SMTP id 68-v6mr3766863ljj.1.1536830521359;
        Thu, 13 Sep 2018 02:22:01 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m11-v6sm604363lfk.70.2018.09.13.02.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 02:22:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1g0Np3-0000DA-Fv; Thu, 13 Sep 2018 11:22:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Dan Williams <dcbw@redhat.com>, Lars Melin <larsm17@gmail.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] USB: serial: option: improve Quectel EP06 detection
Date:   Thu, 13 Sep 2018 11:21:49 +0200
Message-Id: <20180913092152.770-1-johan@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913091753.GA3443@localhost>
References: <20180913091753.GA3443@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kristian Evensen <kristian.evensen@gmail.com>

The Quectel EP06 (and EM06/EG06) LTE modem supports updating the USB
configuration, without the VID/PID or configuration number changing.
When the configuration is updated and interfaces are added/removed, the
interface numbers are updated. This causes our current code for matching
EP06 not to work as intended, as the assumption about reserved
interfaces no longer holds. If for example the diagnostic (first)
interface is removed, option will (try to) bind to the QMI interface.

This patch improves EP06 detection by replacing the current match with
two matches, and those matches check class, subclass and protocol as
well as VID and PID. The diag interface exports class, subclass and
protocol as 0xff. For the other serial interfaces, class is 0xff and
subclass and protocol are both 0x0.

The modem can export the following devices and always in this order:
diag, nmea, at, ppp. qmi and adb. This means that diag can only ever be
interface 0, and interface numbers 1-5 should be marked as reserved. The
three other serial devices can have interface numbers 0-3, but I have
not marked any interfaces as reserved. The reason is that the serial
devices are the only interfaces exported by the device where subclass
and protocol is 0x0.

QMI exports the same class, subclass and protocol values as the diag
interface. However, the two interfaces have different number of
endpoints, QMI has three and diag two. I have added a check for number
of interfaces if VID/PID matches the EP06, and we ignore the device if
number of interfaces equals three (and subclass is set).

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Dan Williams <dcbw@redhat.com>
[ johan: drop uneeded RSVD(5) for ADB ]
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/option.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0215b70c4efc..382feafbd127 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1081,8 +1081,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06),
-	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
@@ -1985,6 +1986,7 @@ static int option_probe(struct usb_serial *serial,
 {
 	struct usb_interface_descriptor *iface_desc =
 				&serial->interface->cur_altsetting->desc;
+	struct usb_device_descriptor *dev_desc = &serial->dev->descriptor;
 	unsigned long device_flags = id->driver_info;
 
 	/* Never bind to the CD-Rom emulation interface	*/
@@ -1999,6 +2001,18 @@ static int option_probe(struct usb_serial *serial,
 	if (device_flags & RSVD(iface_desc->bInterfaceNumber))
 		return -ENODEV;
 
+	/*
+	 * Don't bind to the QMI device of the Quectel EP06/EG06/EM06. Class,
+	 * subclass and protocol is 0xff for both the diagnostic port and the
+	 * QMI interface, but the diagnostic port only has two endpoints (QMI
+	 * has three).
+	 */
+	if (dev_desc->idVendor == cpu_to_le16(QUECTEL_VENDOR_ID) &&
+	    dev_desc->idProduct == cpu_to_le16(QUECTEL_PRODUCT_EP06) &&
+	    iface_desc->bInterfaceSubClass && iface_desc->bNumEndpoints == 3) {
+		return -ENODEV;
+	}
+
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);
 
-- 
2.19.0

