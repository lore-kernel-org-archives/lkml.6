Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF95C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7072920893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7072920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeH1UIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:08:45 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:43551 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeH1UIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:08:45 -0400
Received: by mail-ua1-f74.google.com with SMTP id g19-v6so802460uah.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 09:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IfWs4wQGOydwQlPMKbE8z3eeSZ2soCDSfgA6PGYCcfk=;
        b=AFohWMIz+bz6W/1yD1Gdw09f2S5LRO3sgrGwyY8rHF1JY07pcMeP488x4q+CdLm+2j
         k/DuGbXTX/zVaspVfe7Y8pzI5ZVTLgmGsq41DMu5wZGrF3QhMmw+UR/YkRI/oek/axEi
         qH6O38w7ZeC02bBYXSTw1M4UKfQCl+P4zN+OMa+KZOTrOYFSd49IW9qp8TGxm+cwKJMa
         kdIMdLvthiFRjhSjNPgLJI6mmf4A3oP5/O8k5qyvGODDAFCAt/a1w1gbg9gMS3vjVfNP
         rlTcUW7L9zeAnEsj7EMbs9go4BfyeIMiFpga1knaTmQdmqFXIn7Shd8KU1ULQ91+lQSw
         i1hg==
X-Gm-Message-State: APzg51CKYHmQW1ZDWzhlZIyVEyvwPJ6uTQQFOoQO7Q0awlVxF1x68aCK
        p3NVwDlQiL770Z2WTQyOJi2zHiZ1tUJOdA==
X-Google-Smtp-Source: ANB0VdbSzb2h2kCVuIy2DEtBXodd6Cpq9l+aQNak+eg/MK6rDMzvGh8DCDzSGBDqErJq0TNccfec6mCgeJLMYg==
X-Received: by 2002:a1f:542:: with SMTP id 63-v6mr1001634vkf.54.1535472980453;
 Tue, 28 Aug 2018 09:16:20 -0700 (PDT)
Date:   Tue, 28 Aug 2018 09:16:16 -0700
Message-Id: <20180828161616.93825-1-seobrien@chromium.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
Subject: [PATCH] [v2] HID: add support for Apple Magic Trackpad 2
From:   "Sean O'Brien" <seobrien@chromium.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "Sean O'Brien" <seobrien@chromium.org>,
        Marek Wyborski <marek.wyborski@emwesoft.com>,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
        Jiri Kosina <jikos@kernel.org>,
        Claudio Mettler <claudio@ponyfleisch.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB device
        Vendor 05ac (Apple)
        Device 0265 (Magic Trackpad 2)
Bluetooth device
        Vendor 004c (Apple)
        Device 0265 (Magic Trackpad 2)

Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
the device in multi-touch mode.

Signed-off-by: Claudio Mettler <claudio@ponyfleisch.ch>
Signed-off-by: Marek Wyborski <marek.wyborski@emwesoft.com>
Signed-off-by: Sean O'Brien <seobrien@chromium.org>
---

 drivers/hid/hid-ids.h        |   2 +
 drivers/hid/hid-magicmouse.c | 184 ++++++++++++++++++++++++++++-------
 2 files changed, 149 insertions(+), 37 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 79bdf0c7e351..d6d0b20cc015 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -88,9 +88,11 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
 
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
+#define USB_DEVICE_ID_APPLE_MAGICTRACKPAD2	0x0265
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI	0x020e
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_ISO	0x020f
 #define USB_DEVICE_ID_APPLE_GEYSER_ANSI	0x0214
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index b454c4386157..7f14866ea3c7 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -54,6 +54,8 @@ module_param(report_undeciphered, bool, 0644);
 MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
 
 #define TRACKPAD_REPORT_ID 0x28
+#define TRACKPAD2_USB_REPORT_ID 0x02
+#define TRACKPAD2_BT_REPORT_ID 0x31
 #define MOUSE_REPORT_ID    0x29
 #define DOUBLE_REPORT_ID   0xf7
 /* These definitions are not precise, but they're close enough.  (Bits
@@ -91,6 +93,19 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TRACKPAD_RES_Y \
 	((TRACKPAD_MAX_Y - TRACKPAD_MIN_Y) / (TRACKPAD_DIMENSION_Y / 100))
 
+#define TRACKPAD2_DIMENSION_X (float)16000
+#define TRACKPAD2_MIN_X -3678
+#define TRACKPAD2_MAX_X 3934
+#define TRACKPAD2_RES_X \
+	((TRACKPAD2_MAX_X - TRACKPAD2_MIN_X) / (TRACKPAD2_DIMENSION_X / 100))
+#define TRACKPAD2_DIMENSION_Y (float)11490
+#define TRACKPAD2_MIN_Y -2478
+#define TRACKPAD2_MAX_Y 2587
+#define TRACKPAD2_RES_Y \
+	((TRACKPAD2_MAX_Y - TRACKPAD2_MIN_Y) / (TRACKPAD2_DIMENSION_Y / 100))
+
+#define MAX_TOUCHES		16
+
 /**
  * struct magicmouse_sc - Tracks Magic Mouse-specific data.
  * @input: Input device through which we report events.
@@ -115,8 +130,8 @@ struct magicmouse_sc {
 		short scroll_x;
 		short scroll_y;
 		u8 size;
-	} touches[16];
-	int tracking_ids[16];
+	} touches[MAX_TOUCHES];
+	int tracking_ids[MAX_TOUCHES];
 };
 
 static int magicmouse_firm_touch(struct magicmouse_sc *msc)
@@ -183,6 +198,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 {
 	struct input_dev *input = msc->input;
 	int id, x, y, size, orientation, touch_major, touch_minor, state, down;
+	int pressure = 0;
 
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
 		id = (tdata[6] << 2 | tdata[5] >> 6) & 0xf;
@@ -194,7 +210,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		touch_minor = tdata[4];
 		state = tdata[7] & TOUCH_STATE_MASK;
 		down = state != TOUCH_STATE_NONE;
-	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
 		id = (tdata[7] << 2 | tdata[6] >> 6) & 0xf;
 		x = (tdata[1] << 27 | tdata[0] << 19) >> 19;
 		y = -((tdata[3] << 30 | tdata[2] << 22 | tdata[1] << 14) >> 19);
@@ -204,6 +220,18 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		touch_minor = tdata[5];
 		state = tdata[8] & TOUCH_STATE_MASK;
 		down = state != TOUCH_STATE_NONE;
+	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 */
+		id = tdata[8] & 0xf;
+		x = (tdata[1] << 27 | tdata[0] << 19) >> 19;
+		y = -((tdata[3] << 30 | tdata[2] << 22 | tdata[1] << 14) >> 19);
+		size = tdata[6];
+		orientation = (tdata[8] >> 5) - 4;
+		touch_major = tdata[4];
+		touch_minor = tdata[5];
+		/* Prevent zero and low pressure values */
+		pressure = tdata[7] + 30;
+		state = tdata[3] & 0xC0;
+		down = state == 0x80;
 	}
 
 	/* Store tracking ID and other fields. */
@@ -215,7 +243,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	/* If requested, emulate a scroll wheel by detecting small
 	 * vertical touch motions.
 	 */
-	if (emulate_scroll_wheel) {
+	if (emulate_scroll_wheel &&
+			(input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE)) {
 		unsigned long now = jiffies;
 		int step_x = msc->touches[id].scroll_x - x;
 		int step_y = msc->touches[id].scroll_y - y;
@@ -258,7 +287,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	if (down)
 		msc->ntouches++;
 
-	input_mt_slot(input, id);
+	input_mt_slot(input, input_mt_get_slot_by_key(input, id));
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, down);
 
 	/* Generate the input events for this touch. */
@@ -269,10 +298,14 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
 
+		if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2)
+			input_report_abs(input, ABS_MT_PRESSURE, pressure);
+
 		if (report_undeciphered) {
 			if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
 				input_event(input, EV_MSC, MSC_RAW, tdata[7]);
-			else /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+			else if (input->id.product ==
+					USB_DEVICE_ID_APPLE_MAGICTRACKPAD)
 				input_event(input, EV_MSC, MSC_RAW, tdata[8]);
 		}
 	}
@@ -283,14 +316,23 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
-	int x = 0, y = 0, ii, clicks = 0, npoints;
+	int x = 0, y = 0, ii, clicks = 0, npoints, prefix_size;
 
 	switch (data[0]) {
 	case TRACKPAD_REPORT_ID:
-		/* Expect four bytes of prefix, and N*9 bytes of touch data. */
-		if (size < 4 || ((size - 4) % 9) != 0)
+	case TRACKPAD2_BT_REPORT_ID:
+	case TRACKPAD2_USB_REPORT_ID:
+		/* Expect four or twelve bytes of prefix, and N*9 bytes of
+		 * touch data.
+		 */
+		if (data[0] == TRACKPAD_REPORT_ID ||
+				data[0] == TRACKPAD2_BT_REPORT_ID)
+			prefix_size = 4;
+		else /*TRACKPAD2_USB_REPORT_ID*/
+			prefix_size = 12;
+		if (size < prefix_size || ((size - prefix_size) % 9) != 0)
 			return 0;
-		npoints = (size - 4) / 9;
+		npoints = (size - prefix_size) / 9;
 		if (npoints > 15) {
 			hid_warn(hdev, "invalid size value (%d) for TRACKPAD_REPORT_ID\n",
 					size);
@@ -298,15 +340,10 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		}
 		msc->ntouches = 0;
 		for (ii = 0; ii < npoints; ii++)
-			magicmouse_emit_touch(msc, ii, data + ii * 9 + 4);
+			magicmouse_emit_touch(msc, ii,
+					data + ii * 9 + prefix_size);
 
 		clicks = data[1];
-
-		/* The following bits provide a device specific timestamp. They
-		 * are unused here.
-		 *
-		 * ts = data[1] >> 6 | data[2] << 2 | data[3] << 10;
-		 */
 		break;
 	case MOUSE_REPORT_ID:
 		/* Expect six bytes of prefix, and N*8 bytes of touch data. */
@@ -352,9 +389,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		magicmouse_emit_buttons(msc, clicks & 3);
 		input_report_rel(input, REL_X, x);
 		input_report_rel(input, REL_Y, y);
-	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
 		input_report_key(input, BTN_MOUSE, clicks & 1);
 		input_mt_report_pointer_emulation(input, true);
+	} else /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 */ {
+		input_mt_sync_frame(input);
+		input_report_key(input, BTN_MOUSE, clicks & 1);
 	}
 
 	input_sync(input);
@@ -364,6 +404,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hdev)
 {
 	int error;
+	int mt_flags = 0;
 
 	__set_bit(EV_KEY, input->evbit);
 
@@ -380,7 +421,7 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 			__set_bit(REL_WHEEL, input->relbit);
 			__set_bit(REL_HWHEEL, input->relbit);
 		}
-	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+	} else if (input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
 		/* input->keybit is initialized with incorrect button info
 		 * for Magic Trackpad. There really is only one physical
 		 * button (BTN_LEFT == BTN_MOUSE). Make sure we don't
@@ -397,19 +438,35 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 		__set_bit(BTN_TOUCH, input->keybit);
 		__set_bit(INPUT_PROP_POINTER, input->propbit);
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) */
+
+		/* setting the device name to ensure the same driver settings
+		 * get loaded, whether connected through bluetooth or USB
+		 */
+		input->name = "Apple Inc. Magic Trackpad 2";
+
+		__clear_bit(EV_MSC, input->evbit);
+		__clear_bit(BTN_0, input->keybit);
+		__clear_bit(BTN_RIGHT, input->keybit);
+		__clear_bit(BTN_MIDDLE, input->keybit);
+		__set_bit(BTN_MOUSE, input->keybit);
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+		__set_bit(BTN_TOOL_FINGER, input->keybit);
+
+		mt_flags = INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
+				INPUT_MT_TRACK;
 	}
 
 
 	__set_bit(EV_ABS, input->evbit);
 
-	error = input_mt_init_slots(input, 16, 0);
+	error = input_mt_init_slots(input, MAX_TOUCHES, mt_flags);
 	if (error)
 		return error;
 	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255 << 2,
 			     4, 0);
 	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 255 << 2,
 			     4, 0);
-	input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
 
 	/* Note: Touch Y position from the device is inverted relative
 	 * to how pointer motion is reported (and relative to how USB
@@ -418,6 +475,7 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 	 * inverse of the reported Y.
 	 */
 	if (input->id.product == USB_DEVICE_ID_APPLE_MAGICMOUSE) {
+		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_X,
 				     MOUSE_MIN_X, MOUSE_MAX_X, 4, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y,
@@ -427,7 +485,8 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 				  MOUSE_RES_X);
 		input_abs_set_res(input, ABS_MT_POSITION_Y,
 				  MOUSE_RES_Y);
-	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+	} else if (input->id.product ==  USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
+		input_set_abs_params(input, ABS_MT_ORIENTATION, -31, 32, 1, 0);
 		input_set_abs_params(input, ABS_X, TRACKPAD_MIN_X,
 				     TRACKPAD_MAX_X, 4, 0);
 		input_set_abs_params(input, ABS_Y, TRACKPAD_MIN_Y,
@@ -443,11 +502,29 @@ static int magicmouse_setup_input(struct input_dev *input, struct hid_device *hd
 				  TRACKPAD_RES_X);
 		input_abs_set_res(input, ABS_MT_POSITION_Y,
 				  TRACKPAD_RES_Y);
+	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 */
+		input_set_abs_params(input, ABS_MT_PRESSURE, 0, 283, 0, 0);
+		input_set_abs_params(input, ABS_PRESSURE, 0, 283, 0, 0);
+		input_set_abs_params(input, ABS_MT_ORIENTATION, -3, 4, 0, 0);
+		input_set_abs_params(input, ABS_X, TRACKPAD2_MIN_X,
+				     TRACKPAD2_MAX_X, 0, 0);
+		input_set_abs_params(input, ABS_Y, TRACKPAD2_MIN_Y,
+				     TRACKPAD2_MAX_Y, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_X,
+				     TRACKPAD2_MIN_X, TRACKPAD2_MAX_X, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y,
+				     TRACKPAD2_MIN_Y, TRACKPAD2_MAX_Y, 0, 0);
+
+		input_abs_set_res(input, ABS_X, TRACKPAD2_RES_X);
+		input_abs_set_res(input, ABS_Y, TRACKPAD2_RES_Y);
+		input_abs_set_res(input, ABS_MT_POSITION_X, TRACKPAD2_RES_X);
+		input_abs_set_res(input, ABS_MT_POSITION_Y, TRACKPAD2_RES_Y);
 	}
 
 	input_set_events_per_packet(input, 60);
 
-	if (report_undeciphered) {
+	if (report_undeciphered &&
+	    input->id.product != USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) {
 		__set_bit(EV_MSC, input->evbit);
 		__set_bit(MSC_RAW, input->mscbit);
 	}
@@ -465,7 +542,8 @@ static int magicmouse_input_mapping(struct hid_device *hdev,
 		msc->input = hi->input;
 
 	/* Magic Trackpad does not give relative data after switching to MT */
-	if (hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD &&
+	if ((hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD ||
+	     hi->input->id.product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2) &&
 	    field->flags & HID_MAIN_ITEM_RELATIVE)
 		return -1;
 
@@ -494,11 +572,19 @@ static int magicmouse_input_configured(struct hid_device *hdev,
 static int magicmouse_probe(struct hid_device *hdev,
 	const struct hid_device_id *id)
 {
-	const u8 feature[] = { 0xd7, 0x01 };
-	u8 *buf;
+	__u8 feature_mt[] = { 0xD7, 0x01 };
+	__u8 feature_mt_trackpad2_usb[] = { 0x02, 0x01 };
+	__u8 feature_mt_trackpad2_bt[] = { 0xF1, 0x02, 0x01 };
+	__u8 *feature;
 	struct magicmouse_sc *msc;
 	struct hid_report *report;
 	int ret;
+	int feature_size;
+
+	if (id->vendor == USB_VENDOR_ID_APPLE &&
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 &&
+	    hdev->type != HID_TYPE_USBMOUSE)
+		return 0;
 
 	msc = devm_kzalloc(&hdev->dev, sizeof(*msc), GFP_KERNEL);
 	if (msc == NULL) {
@@ -532,11 +618,18 @@ static int magicmouse_probe(struct hid_device *hdev,
 	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE)
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
 			MOUSE_REPORT_ID, 0);
-	else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD */
+	else if (id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
 			TRACKPAD_REPORT_ID, 0);
 		report = hid_register_report(hdev, HID_INPUT_REPORT,
 			DOUBLE_REPORT_ID, 0);
+	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 */
+		if (id->vendor == BT_VENDOR_ID_APPLE)
+			report = hid_register_report(hdev, HID_INPUT_REPORT,
+				TRACKPAD2_BT_REPORT_ID, 0);
+		else /* USB_VENDOR_ID_APPLE */
+			report = hid_register_report(hdev, HID_INPUT_REPORT,
+				TRACKPAD2_USB_REPORT_ID, 0);
 	}
 
 	if (!report) {
@@ -546,12 +639,6 @@ static int magicmouse_probe(struct hid_device *hdev,
 	}
 	report->size = 6;
 
-	buf = kmemdup(feature, sizeof(feature), GFP_KERNEL);
-	if (!buf) {
-		ret = -ENOMEM;
-		goto err_stop_hw;
-	}
-
 	/*
 	 * Some devices repond with 'invalid report id' when feature
 	 * report switching it into multitouch mode is sent to it.
@@ -560,10 +647,29 @@ static int magicmouse_probe(struct hid_device *hdev,
 	 * but there seems to be no other way of switching the mode.
 	 * Thus the super-ugly hacky success check below.
 	 */
-	ret = hid_hw_raw_request(hdev, buf[0], buf, sizeof(feature),
-				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
-	kfree(buf);
-	if (ret != -EIO && ret != sizeof(feature)) {
+	if (id->product == USB_DEVICE_ID_APPLE_MAGICMOUSE ||
+	    id->product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD) {
+		feature_size = sizeof(feature_mt);
+		feature = kmemdup(feature_mt, feature_size, GFP_KERNEL);
+	} else { /* USB_DEVICE_ID_APPLE_MAGICTRACKPAD2 */
+		if (id->vendor == BT_VENDOR_ID_APPLE) {
+			feature_size = sizeof(feature_mt_trackpad2_bt);
+			feature = kmemdup(feature_mt_trackpad2_bt,
+					  feature_size, GFP_KERNEL);
+		} else { /* USB_VENDOR_ID_APPLE */
+			feature_size = sizeof(feature_mt_trackpad2_usb);
+			feature = kmemdup(feature_mt_trackpad2_usb,
+					  feature_size, GFP_KERNEL);
+		}
+	}
+	if (!feature) {
+		ret = -ENOMEM;
+		goto err_stop_hw;
+	}
+	ret = hid_hw_raw_request(hdev, feature[0], feature, feature_size,
+				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+	kfree(feature);
+	if (ret != -EIO && ret != feature_size) {
 		hid_err(hdev, "unable to request touch data (%d)\n", ret);
 		goto err_stop_hw;
 	}
@@ -579,6 +685,10 @@ static const struct hid_device_id magic_mice[] = {
 		USB_DEVICE_ID_APPLE_MAGICMOUSE), .driver_data = 0 },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICTRACKPAD), .driver_data = 0 },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2), .driver_data = 0 },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2), .driver_data = 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, magic_mice);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

