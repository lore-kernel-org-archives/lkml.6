Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeCTLJw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:09:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752776AbeCTLFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:05 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/7] HID: use BIT() macro for quirks too
Date: Tue, 20 Mar 2018 12:04:48 +0100
Message-Id: <20180320110451.16582-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should prevent future mess ups fortunately.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--
 include/linux/hid.h | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index ea78336984d3..3ad758dc285c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -311,13 +311,13 @@ struct hid_item {
  * HID connect requests
  */
 
-#define HID_CONNECT_HIDINPUT		0x01
-#define HID_CONNECT_HIDINPUT_FORCE	0x02
-#define HID_CONNECT_HIDRAW		0x04
-#define HID_CONNECT_HIDDEV		0x08
-#define HID_CONNECT_HIDDEV_FORCE	0x10
-#define HID_CONNECT_FF			0x20
-#define HID_CONNECT_DRIVER		0x40
+#define HID_CONNECT_HIDINPUT		BIT(0)
+#define HID_CONNECT_HIDINPUT_FORCE	BIT(1)
+#define HID_CONNECT_HIDRAW		BIT(2)
+#define HID_CONNECT_HIDDEV		BIT(3)
+#define HID_CONNECT_HIDDEV_FORCE	BIT(4)
+#define HID_CONNECT_FF			BIT(5)
+#define HID_CONNECT_DRIVER		BIT(6)
 #define HID_CONNECT_DEFAULT	(HID_CONNECT_HIDINPUT|HID_CONNECT_HIDRAW| \
 		HID_CONNECT_HIDDEV|HID_CONNECT_FF)
 
@@ -330,25 +330,25 @@ struct hid_item {
  */
 #define MAX_USBHID_BOOT_QUIRKS 4
 
-#define HID_QUIRK_INVERT			0x00000001
-#define HID_QUIRK_NOTOUCH			0x00000002
-#define HID_QUIRK_IGNORE			0x00000004
-#define HID_QUIRK_NOGET				0x00000008
-#define HID_QUIRK_HIDDEV_FORCE			0x00000010
-#define HID_QUIRK_BADPAD			0x00000020
-#define HID_QUIRK_MULTI_INPUT			0x00000040
-#define HID_QUIRK_HIDINPUT_FORCE		0x00000080
-#define HID_QUIRK_NO_EMPTY_INPUT		0x00000100
-/* 0x00000200 reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
-#define HID_QUIRK_ALWAYS_POLL			0x00000400
-#define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
-#define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		0x00020000
-#define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	0x00040000
-#define HID_QUIRK_HAVE_SPECIAL_DRIVER		0x00080000
-#define HID_QUIRK_FULLSPEED_INTERVAL		0x10000000
-#define HID_QUIRK_NO_INIT_REPORTS		0x20000000
-#define HID_QUIRK_NO_IGNORE			0x40000000
-#define HID_QUIRK_NO_INPUT_SYNC			0x80000000
+#define HID_QUIRK_INVERT			BIT(0)
+#define HID_QUIRK_NOTOUCH			BIT(1)
+#define HID_QUIRK_IGNORE			BIT(2)
+#define HID_QUIRK_NOGET				BIT(3)
+#define HID_QUIRK_HIDDEV_FORCE			BIT(4)
+#define HID_QUIRK_BADPAD			BIT(5)
+#define HID_QUIRK_MULTI_INPUT			BIT(6)
+#define HID_QUIRK_HIDINPUT_FORCE		BIT(7)
+#define HID_QUIRK_NO_EMPTY_INPUT		BIT(8)
+/* BIT(9) reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
+#define HID_QUIRK_ALWAYS_POLL			BIT(10)
+#define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
+#define HID_QUIRK_SKIP_OUTPUT_REPORT_ID		BIT(17)
+#define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
+#define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
+#define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
+#define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
+#define HID_QUIRK_NO_IGNORE			BIT(30)
+#define HID_QUIRK_NO_INPUT_SYNC			BIT(31)
 
 /*
  * HID device groups
-- 
2.14.3
