Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F91C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6B206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2S8FECC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD6B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeIHRnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:43:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38904 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:43:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so14350461ljc.5;
        Sat, 08 Sep 2018 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=v+R/vY78/OIXQXs+XNmHNNf7pkAg0Feo2vxorrLrsvg=;
        b=Q2S8FECC3z98iCDxxL3QcRHUtQmxass44bUh2SYkW0/Ge1RBG14/l+XCoTW+1uG39c
         s3MGyTHh7/c+gpbmwAAl3uy8SfMruOTQ7Tr6VStwHFnb8ptIApYA2W52jhm6Wp9B3HWn
         78a02yHMJXi7aBtvSUnA0XqsI5BCDi7lwImELomTSzH2wvI2pz9Y+uexNqgLRqJ/7GrL
         bXblwGAMb35gjRLbiHCj5acv7/BJzj7zfwL9A0PJnUKmJHUC4Cff5J/1NdUf7NcwQCja
         4bKCcU1PJ9kgRRceDCAxc60pgBWL8o2Qqsbr11FEZcJnGnxZL5LMLhefjgtd/8SLqXDL
         6wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=v+R/vY78/OIXQXs+XNmHNNf7pkAg0Feo2vxorrLrsvg=;
        b=T9Wsx1mBC8AWLfBsz3LsNxCQw4RKPtbe2r6k8wpTXEg8PQiOVOoLaEKINMcsVVRrvN
         hC3HMFsIrptzalwVptmRUsIZMx5IAR7OjVFA03IMGnLXjM663vNsvBoOb5HmGPnM6/7+
         J1LItzpI6zB0+tSh0aYk3HCTJGp5Z32xHYW0UsYM8T56cxAIL0sKxCZ/stPhkMnBocPz
         bRau5R/2QdgyOkZv9fvlVodC5loWtiIStVUhVxJJ1P5Gc6VJIRaN4H+rXAikF8XK268l
         Ajh8ZlP+uZd80TI68fA6SKc+vKn85Zn/TYxuW9GJIYk2fT8dxCgtgZ6nR18hwXbJwvR9
         1FIg==
X-Gm-Message-State: APzg51DC7zT3d2HJ2/Q+waWpK7V5qq/khWzuAHOrUp5nKNAnIfMgUPZ3
        0iKryNBc2S2h2i8N5M3qGV4VFDiCoyo=
X-Google-Smtp-Source: ANB0VdaS7TDf+rZt9TJfjfoiZDuXwSCUfT9jFbtkZUitIj26MR8a4tymNyPMlj6cPIh+E47w+8sZcA==
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr7437144ljj.33.1536411477793;
        Sat, 08 Sep 2018 05:57:57 -0700 (PDT)
Received: from kristrev-ThinkPad-X1-Carbon-2nd.lan ([2001:470:df69:ab30:9e70:3805:32d7:22d7])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1740189lfc.32.2018.09.08.05.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 05:57:57 -0700 (PDT)
From:   Kristian Evensen <kristian.evensen@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kristian Evensen <kristian.evensen@gmail.com>
Subject: [PATCH] option: Improve Quectel EP06 detection
Date:   Sat,  8 Sep 2018 14:57:54 +0200
Message-Id: <20180908125754.1947-1-kristian.evensen@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/usb/serial/option.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 0215b70c4efc..835dcd2875a7 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1081,8 +1081,9 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06),
-	  .driver_info = RSVD(4) | RSVD(5) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(1) | RSVD(2) | RSVD(3) | RSVD(4) | RSVD(5) },
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
@@ -1999,6 +2001,17 @@ static int option_probe(struct usb_serial *serial,
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
+	    iface_desc->bInterfaceSubClass && iface_desc->bNumEndpoints == 3)
+		return -ENODEV;
+
 	/* Store the device flags so we can use them during attach. */
 	usb_set_serial_data(serial, (void *)device_flags);
 
-- 
2.14.1

