Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBD5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F1720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="gyiZzDWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAKMv8wQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F1720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbeLEAnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:06 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51963 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbeLEAnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:43:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 539CD9F6;
        Tue,  4 Dec 2018 19:43:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:43:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=4nh/gMm0Rp8ZP
        nBrhgwTENSa1vBkF+BMM0sXvXIyJsc=; b=gyiZzDWVyGnSbretAtrQJpPkia5RJ
        rMcKRTChjp0+mMoz+XIHoHC3p9rcCZd7nI3DIO/FspRWGen1aiFT4kGq3iVBoX54
        xHFM+C4Xs2SM5ZszXaTDPf1CXeWvlhbvAyiGzNdJoUSYpxlzqzg3umRP3SAJO56d
        Z3/xnX9SZTtkZBabq67SGeUzTyo98FgxW1L2r7pUmVTC6qDijfqcTpicki1w+vQs
        2WLe9ecjFiA58P570Fexcmf0O6GJyNvYJYuOCsLyBEfnY1o71Ouyz4NkwUvT7HBK
        zx7Vv332brHkH42zUWNeclvwszVOfEUJ5iN1jzGejFG2jIvxjf3jU6iDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=4nh/gMm0Rp8ZPnBrhgwTENSa1vBkF+BMM0sXvXIyJsc=; b=YAKMv8wQ
        HFPCKa5z90ur8ouiOZHJDV8AUnJtGSZXUzJjx4Ymub6J48gaStjBMJrwqU7TdhyW
        pqhz/LUTR4QGCkd083o2kA7uFTB+6aRxoDH3OOeneJZNyU4coh4Z0S5egylemnxV
        /fb9kKg8aoJv6rQhQed1lloUQ4KphGQ+zRYUZiSTGzWCBkJM0aHjNM60UeJ4uY0X
        OYnYUUOkTzW1dObBJksXI4SZ3xuzR5bHvc38E3UUNGusvSD+RVVi48o4R+BWXvQ7
        nRI0LV/cnh1t7t8W/feFG41VFAb8AzM1Z7q05Yz2/6hIwfckXwLWmo8H2hdGrNW1
        BKsWLCSuha7nNg==
X-ME-Sender: <xms:FR8HXG_cPWdO8sO6pHuqRGNk5PPQnNhVrrICwMdiftKkDTVNsX805A>
X-ME-Proxy: <xmx:FR8HXDuF4WroTecYEugv3IpoF4muGg_y7QmC8OrtdKk2W-SWoBJQvg>
    <xmx:FR8HXFvYdpf_H_y31A2Z4JXGpG2r5SddCEX0h98Ou6A2YbBVbd9SxA>
    <xmx:FR8HXPPkpyTDxfyYnwaCnIvEPHc2rlswliTzGcCOYbKuVnBKR-OWxg>
    <xmx:FR8HXIbeo4-Wv3c3ndukOnqFuG0jGWijNyqwaCPr0iu7gbdp-zy4SQ>
    <xmx:FR8HXFaqprlwtFdBq-JfW4Ur_U9ClkefFS8T4rL6f09Jz-EBMfPOog>
    <xmx:FR8HXBdEHzL6JvEIWN_q-yyyvblyDrFWXS3YETEeOIL7t_VOgSbjQw>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id D5B0EE49AD;
        Tue,  4 Dec 2018 19:42:58 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 4/8] HID: input: use the Resolution Multiplier for high-resolution scrolling
Date:   Wed,  5 Dec 2018 10:42:24 +1000
Message-Id: <20181205004228.10714-5-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Windows uses a magic number of 120 for a wheel click. High-resolution
scroll wheels are supposed to use a fraction of 120 to signal smaller
scroll steps. This is implemented by the Resolution Multiplier in the
device itself.

If the multiplier is present in the report descriptor, set it to the
logical max and then use the resolution multiplier to calculate the
high-resolution events. This is the recommendation by Microsoft, see
http://msdn.microsoft.com/en-us/windows/hardware/gg487477.aspx

Note that all mice encountered so far have a logical min/max of 0/1, so
it's a binary "yes or no" to high-res scrolling anyway.

To make userspace simpler, always enable the REL_WHEEL_HI_RES bit. Where
the device doesn't support high-resolution scrolling, the value for the
high-res data will simply be a multiple of 120 every time. For userspace,
if REL_WHEEL_HI_RES is available that is the one to be used.

Potential side-effect: a device with a Resolution Multiplier applying to
other Input items will have those items set to the logical max as well.
This cannot easily be worked around but it is doubtful such devices exist.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes since v1:
- drop the wheel factor and calculate the hi-res value as the event comes
  in. This fixes the issue with a multiplier of 16, makes the code simpler
  too because we don't have to refresh anything after setting the
  multiplier.

Changes since v2:
- unchanged

 drivers/hid/hid-input.c | 108 ++++++++++++++++++++++++++++++++++++++--
 include/linux/hid.h     |   3 ++
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d6fab5798487..59a5608b8dc0 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -712,7 +712,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 				map_abs_clear(usage->hid & 0xf);
 			break;
 
-		case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:
+		case HID_GD_WHEEL:
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				set_bit(REL_WHEEL, input->relbit);
+				map_rel(REL_WHEEL_HI_RES);
+			} else {
+				map_abs(usage->hid & 0xf);
+			}
+			break;
+		case HID_GD_SLIDER: case HID_GD_DIAL:
 			if (field->flags & HID_MAIN_ITEM_RELATIVE)
 				map_rel(usage->hid & 0xf);
 			else
@@ -1012,7 +1020,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
-		case 0x238: map_rel(REL_HWHEEL);		break;
+		case 0x238: /* AC Pan */
+			set_bit(REL_HWHEEL, input->relbit);
+			map_rel(REL_HWHEEL_HI_RES);
+			break;
 		case 0x23d: map_key_clear(KEY_EDIT);		break;
 		case 0x25f: map_key_clear(KEY_CANCEL);		break;
 		case 0x269: map_key_clear(KEY_INSERT);		break;
@@ -1200,6 +1211,38 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 }
 
+static void hidinput_handle_scroll(struct hid_usage *usage,
+				   struct input_dev *input,
+				   __s32 value)
+{
+	int code;
+	int hi_res, lo_res;
+
+	if (value == 0)
+		return;
+
+	if (usage->code == REL_WHEEL_HI_RES)
+		code = REL_WHEEL;
+	else
+		code = REL_HWHEEL;
+
+	/*
+	 * Windows reports one wheel click as value 120. Where a high-res
+	 * scroll wheel is present, a fraction of 120 is reported instead.
+	 * Our REL_WHEEL_HI_RES axis does the same because all HW must
+	 * adhere to the 120 expectation.
+	 */
+	hi_res = value * 120/usage->resolution_multiplier;
+
+	usage->wheel_accumulated += hi_res;
+	lo_res = usage->wheel_accumulated/120;
+	if (lo_res)
+		usage->wheel_accumulated -= lo_res * 120;
+
+	input_event(input, EV_REL, code, lo_res);
+	input_event(input, EV_REL, usage->code, hi_res);
+}
+
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
 {
 	struct input_dev *input;
@@ -1262,6 +1305,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	if ((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
 		return;
 
+	if ((usage->type == EV_REL) && (usage->code == REL_WHEEL_HI_RES ||
+					usage->code == REL_HWHEEL_HI_RES)) {
+		hidinput_handle_scroll(usage, input, value);
+		return;
+	}
+
 	if ((usage->type == EV_ABS) && (field->flags & HID_MAIN_ITEM_RELATIVE) &&
 			(usage->code == ABS_VOLUME)) {
 		int count = abs(value);
@@ -1489,6 +1538,58 @@ static void hidinput_close(struct input_dev *dev)
 	hid_hw_close(hid);
 }
 
+static void hidinput_change_resolution_multipliers(struct hid_device *hid)
+{
+	struct hid_report_enum *rep_enum;
+	struct hid_report *rep;
+	struct hid_usage *usage;
+	int i, j;
+
+	rep_enum = &hid->report_enum[HID_FEATURE_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		bool update_needed = false;
+
+		if (rep->maxfield == 0)
+			continue;
+
+		/*
+		 * If we have more than one feature within this report we
+		 * need to fill in the bits from the others before we can
+		 * overwrite the ones for the Resolution Multiplier.
+		 */
+		if (rep->maxfield > 1) {
+			hid_hw_request(hid, rep, HID_REQ_GET_REPORT);
+			hid_hw_wait(hid);
+		}
+
+		for (i = 0; i < rep->maxfield; i++) {
+			__s32 logical_max = rep->field[i]->logical_maximum;
+
+			/* There is no good reason for a Resolution
+			 * Multiplier to have a count other than 1.
+			 * Ignore that case.
+			 */
+			if (rep->field[i]->report_count != 1)
+				continue;
+
+			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				usage = &rep->field[i]->usage[j];
+
+				if (usage->hid != HID_GD_RESOLUTION_MULTIPLIER)
+					continue;
+
+				*rep->field[i]->value = logical_max;
+				update_needed = true;
+			}
+		}
+		if (update_needed)
+			hid_hw_request(hid, rep, HID_REQ_SET_REPORT);
+	}
+
+	/* refresh our structs */
+	hid_setup_resolution_multiplier(hid);
+}
+
 static void report_features(struct hid_device *hid)
 {
 	struct hid_driver *drv = hid->driver;
@@ -1782,6 +1883,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	hidinput_change_resolution_multipliers(hid);
+
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		if (drv->input_configured &&
 		    drv->input_configured(hid, hidinput))
@@ -1840,4 +1943,3 @@ void hidinput_disconnect(struct hid_device *hid)
 	cancel_work_sync(&hid->led_work);
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
-
diff --git a/include/linux/hid.h b/include/linux/hid.h
index fd8d860365a4..93db548f8761 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -233,6 +233,7 @@ struct hid_item {
 #define HID_DC_BATTERYSTRENGTH	0x00060020
 
 #define HID_CP_CONSUMER_CONTROL	0x000c0001
+#define HID_CP_AC_PAN		0x000c0238
 
 #define HID_DG_DIGITIZER	0x000d0001
 #define HID_DG_PEN		0x000d0002
@@ -441,11 +442,13 @@ struct hid_usage {
 	__s8	  resolution_multiplier;/* Effective Resolution Multiplier
 					   (HUT v1.12, 4.3.1), default: 1 */
 	/* hidinput data */
+	__s8	  wheel_factor;		/* 120/resolution_multiplier */
 	__u16     code;			/* input driver code */
 	__u8      type;			/* input driver type */
 	__s8	  hat_min;		/* hat switch fun */
 	__s8	  hat_max;		/* ditto */
 	__s8	  hat_dir;		/* ditto */
+	__s16	  wheel_accumulated;	/* hi-res wheel */
 };
 
 struct hid_input;
-- 
2.19.2

