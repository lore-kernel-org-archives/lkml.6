Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D52C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0200720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0200720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbeIMS5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:57:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbeIMS5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:57:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BE65FD19;
        Thu, 13 Sep 2018 13:47:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 100/115] HID: add quirk for another PIXART OEM mouse used by HP
Date:   Thu, 13 Sep 2018 15:32:00 +0200
Message-Id: <20180913131829.549127811@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131823.327472833@linuxfoundation.org>
References: <20180913131823.327472833@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/usbhid/hid-quirks.c |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -528,6 +528,7 @@
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A	0x0a4a
 #define USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A	0x0b4a
 #define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE		0x134a
+#define USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A	0x094a
 
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -99,6 +99,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0A4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_LOGITECH_OEM_USB_OPTICAL_MOUSE_0B4A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
+	{ USB_VENDOR_ID_HP, USB_PRODUCT_ID_HP_PIXART_OEM_USB_OPTICAL_MOUSE_094A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_IDEACOM, USB_DEVICE_ID_IDEACOM_IDC6680, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C007, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_C077, HID_QUIRK_ALWAYS_POLL },


