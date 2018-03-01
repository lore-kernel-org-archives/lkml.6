Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033480AbeCARaD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:30:03 -0500
Received: from erebus.the-tk.com ([109.74.205.187]:57606 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033467AbeCAR34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:29:56 -0500
From: Tomasz Kramkowski <tk@the-tk.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Kramkowski <tk@the-tk.com>,
        Mark Morgan Lloyd <markMLl.linux-input@telemetry.co.uk>
Subject: [PATCH 2/2] HID: elecom: add support for EX-G M-XT4DRBK trackball
Date: Thu,  1 Mar 2018 17:22:24 +0000
Message-Id: <20180301172224.1276-2-tk@the-tk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180301172224.1276-1-tk@the-tk.com>
References: <20180301172224.1276-1-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the 6th button on the ELECOM EX-G M-XT4DRBK
trackball mouse.

This is a left handed EX-G variant which only comes in a wireless (D)
model. It has a total of 6 buttons but one of these is not available
because of how the HID descriptor is configured.

Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
---
This patch depends on patch 1 in this series.

This was requested on the list [1] and on reddit [2].

There's no "Requested-by:" field but the requesters might qualify for
a "Suggested-by:". I've notified both in case they qualify and would
like their names to be included.

I do not have the hardware to test this patch but I have been informed
that an equivalent change was tested and worked. I have asked both
requesters for their help testing the patch which means that they
might be able to vouch for its functionality. However, it's unlikely
for there to be a problem.

[1]: https://marc.info/?l=linux-input&m=151915950727292
[2]: https://www.reddit.com/r/Trackballs/comments/7ut6ht/
---
 drivers/hid/hid-elecom.c | 4 +++-
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elecom.c b/drivers/hid/hid-elecom.c
index 21e15dc91aac..ae8e9413c79d 100644
--- a/drivers/hid/hid-elecom.c
+++ b/drivers/hid/hid-elecom.c
@@ -1,7 +1,7 @@
 /*
  *  HID driver for ELECOM devices:
  *  - BM084 Bluetooth Mouse
- *  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
+ *  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK, M-XT4DRBK)
  *  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
  *  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
  *
@@ -67,6 +67,7 @@ static __u8 *elecom_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		break;
 	case USB_DEVICE_ID_ELECOM_M_XT3URBK:
 	case USB_DEVICE_ID_ELECOM_M_XT3DRBK:
+	case USB_DEVICE_ID_ELECOM_M_XT4DRBK:
 		mouse_button_fixup(hdev, rdesc, *rsize, 6);
 		break;
 	case USB_DEVICE_ID_ELECOM_M_DT1URBK:
@@ -83,6 +84,7 @@ static const struct hid_device_id elecom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 830c022c3624..c8902f2f0e23 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -373,6 +373,7 @@
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 #define USB_DEVICE_ID_ELECOM_M_XT3URBK	0x00fb
 #define USB_DEVICE_ID_ELECOM_M_XT3DRBK	0x00fc
+#define USB_DEVICE_ID_ELECOM_M_XT4DRBK	0x00fd
 #define USB_DEVICE_ID_ELECOM_M_DT1URBK	0x00fe
 #define USB_DEVICE_ID_ELECOM_M_DT1DRBK	0x00ff
 #define USB_DEVICE_ID_ELECOM_M_HT1URBK	0x010c
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 9675cd500776..91049dff301f 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -337,6 +337,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_BM084) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT3DRBK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_XT4DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1URBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_DT1DRBK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ELECOM, USB_DEVICE_ID_ELECOM_M_HT1URBK) },
-- 
2.16.2
