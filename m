Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id zkh8AyRHGVuLOwAAmS7hNA
	; Thu, 07 Jun 2018 14:55:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 19551607E7; Thu,  7 Jun 2018 14:55:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 03E2D601C3;
	Thu,  7 Jun 2018 14:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03E2D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935467AbeFGOzj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:55:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41066 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935196AbeFGOzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:35 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbd-0005Zj-KQ; Thu, 07 Jun 2018 15:09:37 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-000340-Q9; Thu, 07 Jun 2018 15:09:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Karsten Koop" <kkoop@ld-didactic.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.942339772@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 242/410] usb: ldusb: add PIDs for new CASSY devices
 supported by this driver
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

From: Karsten Koop <kkoop@ld-didactic.de>

commit 52ad2bd8918158266fc88a05f95429b56b6a33c5 upstream.

This patch adds support for new CASSY devices to the ldusb driver. The
PIDs are also added to the ignore list in hid-quirks.

Signed-off-by: Karsten Koop <kkoop@ld-didactic.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-core.c   | 3 +++
 drivers/hid/hid-ids.h    | 3 +++
 drivers/usb/misc/ldusb.c | 6 ++++++
 3 files changed, 12 insertions(+)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2309,6 +2309,9 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERANALYSERCASSY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETESTCASSY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -582,6 +582,9 @@
 #define USB_DEVICE_ID_LD_MICROCASSYTIME		0x1033
 #define USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE	0x1035
 #define USB_DEVICE_ID_LD_MICROCASSYPH		0x1038
+#define USB_DEVICE_ID_LD_POWERANALYSERCASSY	0x1040
+#define USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY	0x1042
+#define USB_DEVICE_ID_LD_MACHINETESTCASSY	0x1043
 #define USB_DEVICE_ID_LD_JWM		0x1080
 #define USB_DEVICE_ID_LD_DMMP		0x1081
 #define USB_DEVICE_ID_LD_UMIP		0x1090
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -46,6 +46,9 @@
 #define USB_DEVICE_ID_LD_MICROCASSYTIME		0x1033	/* USB Product ID of Micro-CASSY Time (reserved) */
 #define USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE	0x1035	/* USB Product ID of Micro-CASSY Temperature */
 #define USB_DEVICE_ID_LD_MICROCASSYPH		0x1038	/* USB Product ID of Micro-CASSY pH */
+#define USB_DEVICE_ID_LD_POWERANALYSERCASSY	0x1040	/* USB Product ID of Power Analyser CASSY */
+#define USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY	0x1042	/* USB Product ID of Converter Controller CASSY */
+#define USB_DEVICE_ID_LD_MACHINETESTCASSY	0x1043	/* USB Product ID of Machine Test CASSY */
 #define USB_DEVICE_ID_LD_JWM		0x1080	/* USB Product ID of Joule and Wattmeter */
 #define USB_DEVICE_ID_LD_DMMP		0x1081	/* USB Product ID of Digital Multimeter P (reserved) */
 #define USB_DEVICE_ID_LD_UMIP		0x1090	/* USB Product ID of UMI P */
@@ -94,6 +97,9 @@ static const struct usb_device_id ld_usb
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERANALYSERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETESTCASSY) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
