Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE23C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A024208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 03:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="a7Lxh40w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9NfvM56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A024208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeK1Oku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:40:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35871 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726972AbeK1Okt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 09:40:49 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B86F922125;
        Tue, 27 Nov 2018 22:40:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 27 Nov 2018 22:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:mime-version:content-type
        :in-reply-to; s=fm1; bh=XJkITOqSz/3tgb+hyVjPqE+Z9mkKVtmsm6uG7qzs
        Lko=; b=a7Lxh40w9IHOqfEn2qCgGULErIy8XprUpAv7NYesGEZ0icIn6j/P1D15
        Z4D1ZFrqLbqlcDLvyHFd4jpltWEUvAUhMQkqLZIvWtWxIhvYvQEZp4+dBRi+AaPs
        +UH8zBKbV/1r1BaoWEGftdTGEEfGF+BwMlDxe1aCfsrOjPcuNxWI6pyZ8jSaToBD
        jn3WndXWI1dkC7sLXPmKjwYOrRlACstjaPkzS6GCWlKxDXUhnT5ho9gYdt1/Dq52
        G8puX20cTJ0SKejT5F6nQzYyCS4GqFOB2B5vKbUtDHUJ62TDlPU3/B+hKYB36nDm
        u0KSrSdUpvx3mopx8In0jbPgnj3Tdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XJkITOqSz/3tgb+hy
        VjPqE+Z9mkKVtmsm6uG7qzsLko=; b=p9NfvM56pCvmDlsXeUQF7T7OfUSf3SqP9
        IASAEytXI2QfoZTo8FgOKIwLKzeae8CZZZEtdgjBQw91sO3EagRYFEHWiwD7V5vE
        7prew+KPfYbu9RMXcE96o1USJvyXydN/nH9pSDeP0CQ1qx4FdT8RTO20WysBR1fO
        PA8YgQVqh1W1lNLOGGWz1TzVBAM/Ym2fQtsX4YetqcksF4wFL9G8/GUmnjFCiZ4m
        GCEotxOkeJJZ4YXECEv0fpe7Ny58DAYg3mDDKrSyTElXGhiF4MkppgR3+Ygk4kNL
        geyeyw3Y5iq2UDMbQG7DxKYkTV+t7E9VkskWO3v5MUtKQENm4ps+Q==
X-ME-Sender: <xms:Ow7-W41xY4v3wj6rRRAWXX_lvASNCatSRXl6aM467XTi-OxMmYBL2g>
X-ME-Proxy: <xmx:Ow7-W0rHxQVre3zpna_BTXjgRKFaBCChWMT5aHk4n2_OUMg7wmjUWA>
    <xmx:Ow7-W3dmKG1Cwd0raaO0hEbQ3LfhULziRj7Z9KQivO3K8It0IjL50Q>
    <xmx:Ow7-W9YPoDZbm-NOhWQxFZVuM9pF2AFyYLPbS6prw8xdn1hPSptMpg>
    <xmx:Ow7-W6BrSGrD6rMzVwfD-T_i5zIGo3XBkz_27xt13b1BfqN5xJdy0w>
    <xmx:Ow7-W4BI334CuqXuf0mt1qg-AfaMRMwSGrPdbDlc8tnkeDgHnfqACw>
    <xmx:Ow7-WxEiEHDWxtoq0dW69r66FM5VJgdQ7mdMxSXtMoE1JvhFDWm9-g>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9AEF102DD;
        Tue, 27 Nov 2018 22:40:40 -0500 (EST)
Date:   Wed, 28 Nov 2018 13:40:40 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 4/8] HID: input: use the Resolution Multiplier for
 high-resolution scrolling
Message-ID: <20181128034040.GA20947@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122063409.15816-5-peter.hutterer@who-t.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Changes to v1:
- drop the wheel factor and calculate the hi-res value as the event comes
  in. This fixes the issue with a multiplier of 16, makes the code simpler
  too because we don't have to refresh anything after setting the
  multiplier.

 drivers/hid/hid-input.c | 108 ++++++++++++++++++++++++++++++++++++++--
 include/linux/hid.h     |   3 ++
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ad823a01bd65..328ce163aea8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -709,7 +709,15 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
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
@@ -1009,7 +1017,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
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
@@ -1197,6 +1208,38 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
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
@@ -1259,6 +1302,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
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
@@ -1486,6 +1535,58 @@ static void hidinput_close(struct input_dev *dev)
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
@@ -1779,6 +1880,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	hidinput_change_resolution_multipliers(hid);
+
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		if (drv->input_configured &&
 		    drv->input_configured(hid, hidinput))
@@ -1837,4 +1940,3 @@ void hidinput_disconnect(struct hid_device *hid)
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
2.19.1

