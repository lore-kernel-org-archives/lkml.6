Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30AAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920D220685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="BD5IwikI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lghx9vih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920D220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404760AbeKVRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:13:03 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48677 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:13:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 75BB021F47;
        Thu, 22 Nov 2018 01:35:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=2NRKPg6DDQvDy
        JAKCZF+166ySrYs9Y64eU7bWIrFnUI=; b=BD5IwikIDAOfG1kww86ekIozSAa8n
        DUTW9VAr7xo/c6FsnKQtpsacde1BwjnCbLOPA+XOzJ+ZOOyAcB5F6ffLScoXNNwL
        667Mwar2RKTf/U9JHfwir7KaRQN/CkEe4X3r8T2pN10I+tQiWlHNeMOlaTOgI0s8
        wtBwH8O0TYh+Evhzpvojn1qCR+Z5RMf2pKMC1yASatYMHEhvrwwIONXXwp94z43D
        9xIz1Ktxh4Vgqfl8SUjGU+nwgv6V23QC2+uH1KBTOeUB+oyn73P+qHs1Cx5x+Fhu
        7snroaXR8Ul5KWr4yStOLJj4/54QEeSjjK57fG7iQdnB9uyPEu8W+Zzqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=2NRKPg6DDQvDyJAKCZF+166ySrYs9Y64eU7bWIrFnUI=; b=Lghx9vih
        18MGMm1yqddj4xfW1qXW+4rSZh+VcCM6pM/q5QjCS8MrNpQnhUcDAfDqJlamEe1/
        LCAkYY5QG4CFCiDp39F6N9PpQN0e9GyABXNu+3C+MiQZ4Sg1ouo/0LKUOY8zk66V
        OYAWpWMxdP152pwik3jnGf2difpoUhsdKvuYI/8DPXAJSCo6YYh4HzO6lVdKoMyq
        w0By/lsWY+05ChjhqraA1dN5eQq2UwdUYqDITlWyqW186z2XdW9lktZIAEL5nhU+
        oREQI72YgNH5Xcq6e7Cm/crR8yiQCRtkPSiS1W2YrgQA3k5bJn5LHwK/QeErBsoy
        /3juPRJdp7/NZA==
X-ME-Sender: <xms:Fk72W53c0jzWBWaCRKXHok-NpKpxKwdB7scxmo8JJhLobcucuPhF4g>
X-ME-Proxy: <xmx:Fk72WxNAbu6ljUj5jExLmBWg7IQIfd8GKmfcj92xLRLDuDVoxLB9wQ>
    <xmx:Fk72W1as9c8TQMghIdkFVQXdDYhCHutl7vHAp9Z87LT5kF-dMb98rw>
    <xmx:Fk72W7rcbdzY9r58o5N2cAAX4Viw4drWIWmNOhkZjn0MYLHcd0pKIQ>
    <xmx:Fk72W6wL7XAECNSNMI3J3QNDsTFxgS4UJWDIOBpehlrLZLf-eIiO5g>
    <xmx:Fk72W7JXzHR1y3vLZmoXgsxhnLRPRXYFVN3bRvOP-0JQJZ5AdEAs4w>
    <xmx:Fk72Wzo76LlJ4w7Y-caQ6H-eIC2sXjsid0rFRftb2hcTx2oQRoTrWA>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8702F102DE;
        Thu, 22 Nov 2018 01:34:59 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/8] HID: input: use the Resolution Multiplier for high-resolution scrolling
Date:   Thu, 22 Nov 2018 16:34:05 +1000
Message-Id: <20181122063409.15816-5-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
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
 drivers/hid/hid-input.c | 137 ++++++++++++++++++++++++++++++++++++++--
 include/linux/hid.h     |   3 +
 2 files changed, 136 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index ad823a01bd65..cf0f2ae2dbf5 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -562,6 +562,17 @@ static void hidinput_update_battery(struct hid_device *dev, int value)
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
 
+static void hidinput_set_wheel_factor(struct hid_usage *usage)
+{
+	/*
+	 * Windows reports one wheels click as value 120.  Where a high-res
+	 * scroll wheel is present, a fraction of 120 is reported instead.
+	 * Our REL_WHEEL_HI_RES axis does the same because all HW must
+	 * adhere to the 120 expectation.
+	 */
+	usage->wheel_factor = 120/usage->resolution_multiplier;
+}
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
 				     struct hid_usage *usage)
 {
@@ -709,7 +720,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 				map_abs_clear(usage->hid & 0xf);
 			break;
 
-		case HID_GD_SLIDER: case HID_GD_DIAL: case HID_GD_WHEEL:
+		case HID_GD_WHEEL:
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				hidinput_set_wheel_factor(usage);
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
@@ -1009,7 +1029,11 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
-		case 0x238: map_rel(REL_HWHEEL);		break;
+		case 0x238: /* AC Pan */
+			hidinput_set_wheel_factor(usage);
+			set_bit(REL_HWHEEL, input->relbit);
+			map_rel(REL_HWHEEL_HI_RES);
+			break;
 		case 0x23d: map_key_clear(KEY_EDIT);		break;
 		case 0x25f: map_key_clear(KEY_CANCEL);		break;
 		case 0x269: map_key_clear(KEY_INSERT);		break;
@@ -1026,7 +1050,6 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x2ca: map_key_clear(KEY_KBDINPUTASSIST_NEXTGROUP);		break;
 		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
 		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
-
 		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
@@ -1197,6 +1220,39 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 }
 
+static void hidinput_handle_scroll(struct hid_device *hid,
+				   struct hid_field *field,
+				   struct hid_usage *usage,
+				   struct input_dev *input,
+				   __s32 value)
+{
+	int code;
+	struct hid_input *hidinput;
+	int hi_res, lo_res;
+
+	if (value == 0)
+		return;
+
+	hidinput = field->hidinput;
+	if (!hidinput)
+		return;
+
+	if (usage->code == REL_WHEEL_HI_RES)
+		code = REL_WHEEL;
+	else
+		code = REL_HWHEEL;
+
+	hi_res = usage->wheel_factor * value;
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
@@ -1259,6 +1315,12 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	if ((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UNKNOWN */
 		return;
 
+	if ((usage->type == EV_REL) && (usage->code == REL_WHEEL_HI_RES ||
+					usage->code == REL_HWHEEL_HI_RES)) {
+		hidinput_handle_scroll(hid, field, usage, input, value);
+		return;
+	}
+
 	if ((usage->type == EV_ABS) && (field->flags & HID_MAIN_ITEM_RELATIVE) &&
 			(usage->code == ABS_VOLUME)) {
 		int count = abs(value);
@@ -1486,6 +1548,72 @@ static void hidinput_close(struct input_dev *dev)
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
+
+	/* now refresh the wheel factor */
+	rep_enum = &hid->report_enum[HID_INPUT_REPORT];
+	list_for_each_entry(rep, &rep_enum->report_list, list) {
+		for (i = 0; i < rep->maxfield; i++) {
+			for (j = 0; j < rep->field[i]->maxusage; j++) {
+				usage = &rep->field[i]->usage[j];
+
+				if (usage->hid == HID_GD_WHEEL ||
+				    usage->hid == HID_CP_AC_PAN)
+					hidinput_set_wheel_factor(usage);
+			}
+		}
+	}
+}
+
 static void report_features(struct hid_device *hid)
 {
 	struct hid_driver *drv = hid->driver;
@@ -1779,6 +1907,8 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 		}
 	}
 
+	hidinput_change_resolution_multipliers(hid);
+
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		if (drv->input_configured &&
 		    drv->input_configured(hid, hidinput))
@@ -1837,4 +1967,3 @@ void hidinput_disconnect(struct hid_device *hid)
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

