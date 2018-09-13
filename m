Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CCCC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D169220854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTzTTB6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D169220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbeIMOaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:30:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33208 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeIMOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:30:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so4032000ljj.0;
        Thu, 13 Sep 2018 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrpPmSf/Ir/AP2WGlMpgLdi04RIUiS4FuIpJJIM8Qcw=;
        b=gTzTTB6+HtkgjgS5YAIxcP8oN3ofdc6yeHk+Xw853yXm+lzLPy4MYo6ULvP5wmnBem
         Txof5CPTsntbGU5zbLiK2giLmukv2Wcfw9bnh8g2MNPHqL0YfS0gJhR101UknijzzMr6
         jr6gEWSURWLH/Fao1uataEnv8jDEyuKqZSUxs4GZZ5QvLTFKSquBQkq5qqJ8PagFWzQ5
         7vr+R9jiqfZKcCPJJ0WSu1WAoAJ98XwSLUbu7bbjkOfFgYTqWQBK6cqjhsiQhGEViiXr
         bPGq9FkjqsM29VIqBt3ciapr9EMNzHuRkbkK4Q5lDFuDfL680VxjZHZyWvk8vCD4KJYY
         Cb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WrpPmSf/Ir/AP2WGlMpgLdi04RIUiS4FuIpJJIM8Qcw=;
        b=VNILyuaulMtynot+QJjOJ0ZQTQHz7RIuIU6Fv6yqazs4WlxUF7yQcyfubl+MCmALSo
         e2Qx4XbnOxnpHqjUINTCIHfhHOKsECl/5hQQuOgJTfcb4yEdFEfsHl4hKJuhekndpcjd
         H897pS2/tT8eK59AL4NVNqAlSy90q8CP3lFvZ7MMZNaBtetSHL1mOTQf5fndu411Oyu4
         2EoiaQVBEyheGg3hwIeDVrhxlachZhLwaisnzcbFpDFZESMifWmF0tELh43qZwrZ9n9Z
         qfcu1jkjzz8/og4cyxxHeGGuRwRiN5TpfH2D55hjiBGgOqslOJDEKgu5OA64UJgf7Axi
         qQNA==
X-Gm-Message-State: APzg51AuFh4ngS+qKU4Yz4dxzKhGqRhPHr7xQBA3pWnNrkqyHYcaqRGF
        u4zz1nLGmb+wgCWt7yGYN3SUiPHs
X-Google-Smtp-Source: ANB0VdapW6g5V2tGTcLU4RJ6qXrOKkBwm/aHmMeYzzu5GQ5bs03YhYKOaXuiZjSp/rdIxD5CFhF3XQ==
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr3834798lje.70.1536830525308;
        Thu, 13 Sep 2018 02:22:05 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q85-v6sm628461lfg.20.2018.09.13.02.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 02:22:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1g0Np7-0000DH-Ej; Thu, 13 Sep 2018 11:22:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Dan Williams <dcbw@redhat.com>, Lars Melin <larsm17@gmail.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 2/2] USB: serial: option: add two-endpoints device-id flag
Date:   Thu, 13 Sep 2018 11:21:50 +0200
Message-Id: <20180913092152.770-2-johan@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913092152.770-1-johan@kernel.org>
References: <20180913091753.GA3443@localhost>
 <20180913092152.770-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow matching on interfaces having two endpoints by adding a new
device-id flag.

This allows for the handling of devices whose interface numbers can
change (e.g. Quectel EP06) to be contained in the device-id table.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/option.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 382feafbd127..241a73e172a1 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -561,6 +561,9 @@ static void option_instat_callback(struct urb *urb);
 /* Interface is reserved */
 #define RSVD(ifnum)	((BIT(ifnum) & 0xff) << 0)
 
+/* Interface must have two endpoints */
+#define NUMEP2		BIT(16)
+
 
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
@@ -1082,7 +1085,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
-	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) },
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | NUMEP2 },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
@@ -1986,7 +1989,6 @@ static int option_probe(struct usb_serial *serial,
 {
 	struct usb_interface_descriptor *iface_desc =
 				&serial->interface->cur_altsetting->desc;
-	struct usb_device_descriptor *dev_desc = &serial->dev->descriptor;
 	unsigned long device_flags = id->driver_info;
 
 	/* Never bind to the CD-Rom emulation interface	*/
@@ -2002,16 +2004,11 @@ static int option_probe(struct usb_serial *serial,
 		return -ENODEV;
 
 	/*
-	 * Don't bind to the QMI device of the Quectel EP06/EG06/EM06. Class,
-	 * subclass and protocol is 0xff for both the diagnostic port and the
-	 * QMI interface, but the diagnostic port only has two endpoints (QMI
-	 * has three).
+	 * Allow matching on bNumEndpoints for devices whose interface numbers
+	 * change (e.g. Quectel EP06).
 	 */
-	if (dev_desc->idVendor == cpu_to_le16(QUECTEL_VENDOR_ID) &&
-	    dev_desc->idProduct == cpu_to_le16(QUECTEL_PRODUCT_EP06) &&
-	    iface_desc->bInterfaceSubClass && iface_desc->bNumEndpoints == 3) {
+	if (device_flags & NUMEP2 && iface_desc->bNumEndpoints != 2)
 		return -ENODEV;
-	}
 
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);
-- 
2.19.0

