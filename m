Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id esWtMdRIGVumSgAAmS7hNA
	; Thu, 07 Jun 2018 15:01:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9841608B8; Thu,  7 Jun 2018 15:01:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2AC66601C3;
	Thu,  7 Jun 2018 15:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2AC66601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964824AbeFGPBh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:01:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41396 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934945AbeFGPBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:01:33 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbu-0005Zl-55; Thu, 07 Jun 2018 15:09:54 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb0-0002mB-7A; Thu, 07 Jun 2018 15:08:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Jiri Kosina" <jkosina@suse.cz>, "Dave Young" <dyoung@redhat.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.491013154@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 074/410] HID: add quirk for another PIXART OEM mouse
 used by HP
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Young <dyoung@redhat.com>

commit 01cffe9ded15c0d664e0beb33c594e00c0d57bba upstream.

This mouse keep disconnecting in runleve 3 like below, add it needs the
quirk to mute the anoying messages.

[  111.230555] usb 2-2: USB disconnect, device number 6
[  112.718156] usb 2-2: new low-speed USB device number 7 using xhci_hcd
[  112.941594] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
[  112.984866] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  113.027731] usb 2-2: Product: HP USB Optical Mouse
[  113.069977] usb 2-2: Manufacturer: PixArt
[  113.113500] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0002/input/input14
[  113.156787] hid-generic 0003:03F0:094A.0002: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0
[  173.262642] usb 2-2: USB disconnect, device number 7
[  174.750244] usb 2-2: new low-speed USB device number 8 using xhci_hcd
[  174.935740] usb 2-2: New USB device found, idVendor=03f0, idProduct=094a
[  174.990435] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[  175.014984] usb 2-2: Product: HP USB Optical Mouse
[  175.037886] usb 2-2: Manufacturer: PixArt
[  175.061794] input: PixArt HP USB Optical Mouse as /devices/pci0000:00/0000:00:14.0/usb2/2-2/2-2:1.0/0003:03F0:094A.0003/input/input15
[  175.084946] hid-generic 0003:03F0:094A.0003: input: USB HID v1.11 Mouse [PixArt HP USB Optical Mouse] on usb-0000:00:14.0-2/input0

Signed-off-by: Dave Young <dyoung@redhat.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
[bwh: Backported to 3.16:
 - Don't use HID_USB_DEVICE()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -488,6 +488,7 @@
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
+#define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A	0x094a
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_580		0x006e
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -99,6 +99,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KEYBOARD_G710_PLUS, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C01A, HID_QUIRK_ALWAYS_POLL },
