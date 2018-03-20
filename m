Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeCTLFK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752533AbeCTLFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:02 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/7] HID: use BIT macro instead of plain integers for flags
Date: Tue, 20 Mar 2018 12:04:47 +0100
Message-Id: <20180320110451.16582-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can lead to some hairy situation with the developer losing
a day or two realizing that 4 should be after 2, not 3.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

--
 include/linux/hid.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index dfea5a656a1a..ea78336984d3 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -26,6 +26,7 @@
 #define __HID_H
 
 
+#include <linux/bitops.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/list.h>
@@ -494,13 +495,13 @@ struct hid_output_fifo {
 	char *raw_report;
 };
 
-#define HID_CLAIMED_INPUT	1
-#define HID_CLAIMED_HIDDEV	2
-#define HID_CLAIMED_HIDRAW	4
-#define HID_CLAIMED_DRIVER	8
+#define HID_CLAIMED_INPUT	BIT(0)
+#define HID_CLAIMED_HIDDEV	BIT(1)
+#define HID_CLAIMED_HIDRAW	BIT(2)
+#define HID_CLAIMED_DRIVER	BIT(3)
 
-#define HID_STAT_ADDED		1
-#define HID_STAT_PARSED		2
+#define HID_STAT_ADDED		BIT(0)
+#define HID_STAT_PARSED		BIT(1)
 
 struct hid_input {
 	struct list_head list;
-- 
2.14.3
