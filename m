Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BC1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3720659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="gtWNe1o/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeOqzRUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA3720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbeLEAnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:17 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57371 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbeLEAnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:43:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 618A8F63;
        Tue,  4 Dec 2018 19:43:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:43:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=AN454XcRs1240
        RLBYkm/rek3hiQlojlnwrRUjcJG5BU=; b=gtWNe1o/8WrIVRtsdqpmpa4nKnNfo
        VgoQaDt4y9lonyiu0fWewRPb8r+Kz9odIrZI16Szr11p2OKe7aBQtMToIxQfQOkp
        5vCMc5sqZnLJbgVWadF6beXp+dd2TLAvUNpql8jntFafSLr7zhnAAcYR0AOTuDxA
        JvU0tH2cxQE2jTaKy8C8puHV3xS3Arx6SZDOdkAAVvCa+N2Fe6+xXSNekkKAlLTS
        ArsgqwxilGDqAzYLKgR6/17fa0r4G8wH+i8aSeAVJVWwTO/Os/ViyHIhKuOoeHff
        tp3dXW/25YaXRfAX815nkmhFT2WA2jAQlQAVHnJEh8y/Qsg+Xjx02rVeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=AN454XcRs1240RLBYkm/rek3hiQlojlnwrRUjcJG5BU=; b=ZeOqzRUR
        7GzZrIogJJrzE22z8zHtKNY15aS1ymQOay6AC5l0BeZwvVfLGDZUGpSccfVzrjGf
        XUkttZZWNMajTbce3zDjGOcD0Ua+iADlehVADluVkyifjFti0JPmPAS0mvCjsCOY
        tsMj6Lvr3vfn72uxCOJ6hHRYKttvxdM9WWzQ0WsZXkkPtWBCNsTA4b7MUwJGrM9j
        PoYVBvdiFyQ1mrFxWtQ5kp11uV2EUFYvM3wnc6kQgAvG73WLT5aN07NawgzpMm1Z
        eOrqglnAleoTCiKEK+5RKGHnRO8KXloM3ah1kqQiIwH+hgS354mwsLFlLIBb1NM+
        gu56NY3JZVlD8Q==
X-ME-Sender: <xms:IB8HXBZvJfB-WGaWp-Fvve28xRlS9hwB3MJm0YEJWZ6hc8rUKUGmfA>
X-ME-Proxy: <xmx:IB8HXJEh51EroFqRmFrPnsFTJ-zAasFQeRBWcv3X0DOmPLjAyJSlWg>
    <xmx:IB8HXDvuT9LbwqgzHJQcZ9vLpIFGOU7crSQqlvote5MIxZBIEZqcGw>
    <xmx:IB8HXHlzmfcDBQeuvoZE0T0ZgqPsIRvjwnPr2dZMWEOS9lt7VLrv4g>
    <xmx:IB8HXENy4c949-dMe8_it79VMb2mJ56TyAMlQ4aXcI9rxLwdReW0rg>
    <xmx:IB8HXGxXjI7rxrzzvzYk9wLct0fDPLnnNRRGHRZc5gtCFCVD9Qix5w>
    <xmx:IB8HXIxgPTjuIuI3oaPJrPxRL6twK-LVhTgoX2tN38ndKjKWM498uQ>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id C20E9E49AD;
        Tue,  4 Dec 2018 19:43:09 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 7/8] HID: logitech: Enable high-resolution scrolling on Logitech mice
Date:   Wed,  5 Dec 2018 10:42:27 +1000
Message-Id: <20181205004228.10714-8-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Cutts <hcutts@chromium.org>

There are three features used by various Logitech mice for
high-resolution scrolling: the scrolling acceleration bit in HID++ 1.0,
and the x2120 and x2121 features in HID++ 2.0 and above. This patch
supports all three, and uses the multiplier reported by the mouse for
the HID++ 2.0+ features.

The full list of product IDs of mice which support high-resolution
scrolling was provided by Logitech, but the patch was tested using the
following mice (using the Unifying receiver):

* HID++ 1.0: Anywhere MX, Performance MX
* x2120: M560
* x2121: MX Anywhere 2, MX Master 2S

This patch is a combinations of the now-reverted commits 1ff2e1a44e0,
d56ca9855bf9, 5fe2ccbef9d, 044ee89028 together with some extra bits for the
directional and timeout-based reset.
The previous patch series was in hid-input, it appears this remainder
handling is logitech-specific and was moved to hid-logitech-hidpp.c and
renamed accordingly.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v1:
- get rid of the timer in favour of sched_clock()
- drop storing the multiplier and calculate value on the fly

Changes to v2:
- m560 now has REL_HWHEEL_HI_RES (untested, I don't have the device)


 drivers/hid/hid-logitech-hidpp.c | 301 ++++++++++++++++++++++++++++++-
 1 file changed, 295 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 95ba9db6e613..a66daf8acd87 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 #include <linux/kfifo.h>
 #include <linux/input/mt.h>
 #include <linux/workqueue.h>
@@ -64,6 +65,14 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_NO_HIDINPUT			BIT(23)
 #define HIDPP_QUIRK_FORCE_OUTPUT_REPORTS	BIT(24)
 #define HIDPP_QUIRK_UNIFYING			BIT(25)
+#define HIDPP_QUIRK_HI_RES_SCROLL_1P0		BIT(26)
+#define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
+#define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
+
+/* Convenience constant to check for any high-res support. */
+#define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
+					 HIDPP_QUIRK_HI_RES_SCROLL_X2120 | \
+					 HIDPP_QUIRK_HI_RES_SCROLL_X2121)
 
 #define HIDPP_QUIRK_DELAYED_INIT		HIDPP_QUIRK_NO_HIDINPUT
 
@@ -128,6 +137,25 @@ struct hidpp_battery {
 	bool online;
 };
 
+/**
+ * struct hidpp_scroll_counter - Utility class for processing high-resolution
+ *                             scroll events.
+ * @dev: the input device for which events should be reported.
+ * @wheel_multiplier: the scalar multiplier to be applied to each wheel event
+ * @remainder: counts the number of high-resolution units moved since the last
+ *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
+ *             only be used by class methods.
+ * @direction: direction of last movement (1 or -1)
+ * @last_time: last event time, used to reset remainder after inactivity
+ */
+struct hidpp_scroll_counter {
+	struct input_dev *dev;
+	int wheel_multiplier;
+	int remainder;
+	int direction;
+	unsigned long long last_time;
+};
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct mutex send_mutex;
@@ -149,6 +177,7 @@ struct hidpp_device {
 	unsigned long capabilities;
 
 	struct hidpp_battery battery;
+	struct hidpp_scroll_counter vertical_wheel_counter;
 };
 
 /* HID++ 1.0 error codes */
@@ -391,6 +420,67 @@ static void hidpp_prefix_name(char **name, int name_length)
 	*name = new_name;
 }
 
+/**
+ * hidpp_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
+ *                                        events given a high-resolution wheel
+ *                                        movement.
+ * @counter: a hid_scroll_counter struct describing the wheel.
+ * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
+ *                units.
+ *
+ * Given a high-resolution movement, this function converts the movement into
+ * fractions of 120 and emits high-resolution scroll events for the input
+ * device. It also uses the multiplier from &struct hid_scroll_counter to
+ * emit low-resolution scroll events when appropriate for
+ * backwards-compatibility with userspace input libraries.
+ */
+static void hidpp_scroll_counter_handle_scroll(struct hidpp_scroll_counter *counter,
+					       int hi_res_value)
+{
+	int low_res_value, remainder, direction;
+	unsigned long long now, previous;
+
+	hi_res_value = hi_res_value * 120/counter->wheel_multiplier;
+	input_report_rel(counter->dev, REL_WHEEL_HI_RES, hi_res_value);
+
+	remainder = counter->remainder;
+	direction = hi_res_value > 0 ? 1 : -1;
+
+	now = sched_clock();
+	previous = counter->last_time;
+	counter->last_time = now;
+	/*
+	 * Reset the remainder after a period of inactivity or when the
+	 * direction changes. This prevents the REL_WHEEL emulation point
+	 * from sliding for devices that don't always provide the same
+	 * number of movements per detent.
+	 */
+	if (now - previous > 1000000000 || direction != counter->direction)
+		remainder = 0;
+
+	counter->direction = direction;
+	remainder += hi_res_value;
+
+	/* Some wheels will rest 7/8ths of a detent from the previous detent
+	 * after slow movement, so we want the threshold for low-res events to
+	 * be in the middle between two detents (e.g. after 4/8ths) as
+	 * opposed to on the detents themselves (8/8ths).
+	 */
+	if (abs(remainder) >= 60) {
+		/* Add (or subtract) 1 because we want to trigger when the wheel
+		 * is half-way to the next detent (i.e. scroll 1 detent after a
+		 * 1/2 detent movement, 2 detents after a 1 1/2 detent movement,
+		 * etc.).
+		 */
+		low_res_value = remainder / 120;
+		if (low_res_value == 0)
+			low_res_value = (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL, low_res_value);
+		remainder -= low_res_value * 120;
+	}
+	counter->remainder = remainder;
+}
+
 /* -------------------------------------------------------------------------- */
 /* HIDP++ 1.0 commands                                                        */
 /* -------------------------------------------------------------------------- */
@@ -1157,6 +1247,99 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x2120: Hi-resolution scrolling                                            */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_HI_RESOLUTION_SCROLLING			0x2120
+
+#define CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE	0x10
+
+static int hidpp_hrs_set_highres_scrolling_mode(struct hidpp_device *hidpp,
+	bool enabled, u8 *multiplier)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	u8 params[1];
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp,
+				     HIDPP_PAGE_HI_RESOLUTION_SCROLLING,
+				     &feature_index,
+				     &feature_type);
+	if (ret)
+		return ret;
+
+	params[0] = enabled ? BIT(0) : 0;
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HI_RESOLUTION_SCROLLING_SET_HIGHRES_SCROLLING_MODE,
+					  params, sizeof(params), &response);
+	if (ret)
+		return ret;
+	*multiplier = response.fap.params[1];
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+/* 0x2121: HiRes Wheel                                                        */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_HIRES_WHEEL		0x2121
+
+#define CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY	0x00
+#define CMD_HIRES_WHEEL_SET_WHEEL_MODE		0x20
+
+static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
+	u8 *multiplier)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
+				     &feature_index, &feature_type);
+	if (ret)
+		goto return_default;
+
+	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
+					  CMD_HIRES_WHEEL_GET_WHEEL_CAPABILITY,
+					  NULL, 0, &response);
+	if (ret)
+		goto return_default;
+
+	*multiplier = response.fap.params[0];
+	return 0;
+return_default:
+	hid_warn(hidpp->hid_dev,
+		 "Couldn't get wheel multiplier (error %d)\n", ret);
+	return ret;
+}
+
+static int hidpp_hrw_set_wheel_mode(struct hidpp_device *hidpp, bool invert,
+	bool high_resolution, bool use_hidpp)
+{
+	u8 feature_index;
+	u8 feature_type;
+	int ret;
+	u8 params[1];
+	struct hidpp_report response;
+
+	ret = hidpp_root_get_feature(hidpp, HIDPP_PAGE_HIRES_WHEEL,
+				     &feature_index, &feature_type);
+	if (ret)
+		return ret;
+
+	params[0] = (invert          ? BIT(2) : 0) |
+		    (high_resolution ? BIT(1) : 0) |
+		    (use_hidpp       ? BIT(0) : 0);
+
+	return hidpp_send_fap_command_sync(hidpp, feature_index,
+					   CMD_HIRES_WHEEL_SET_WHEEL_MODE,
+					   params, sizeof(params), &response);
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x4301: Solar Keyboard                                                     */
 /* -------------------------------------------------------------------------- */
@@ -2408,10 +2591,15 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_key(mydata->input, BTN_RIGHT,
 			!!(data[1] & M560_MOUSE_BTN_RIGHT));
 
-		if (data[1] & M560_MOUSE_BTN_WHEEL_LEFT)
+		if (data[1] & M560_MOUSE_BTN_WHEEL_LEFT) {
 			input_report_rel(mydata->input, REL_HWHEEL, -1);
-		else if (data[1] & M560_MOUSE_BTN_WHEEL_RIGHT)
+			input_report_rel(mydata->input, REL_HWHEEL_HI_RES,
+					 -120);
+		} else if (data[1] & M560_MOUSE_BTN_WHEEL_RIGHT) {
 			input_report_rel(mydata->input, REL_HWHEEL, 1);
+			input_report_rel(mydata->input, REL_HWHEEL_HI_RES,
+					 120);
+		}
 
 		v = hid_snto32(hid_field_extract(hdev, data+3, 0, 12), 12);
 		input_report_rel(mydata->input, REL_X, v);
@@ -2420,7 +2608,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		input_report_rel(mydata->input, REL_WHEEL, v);
+		hidpp_scroll_counter_handle_scroll(
+				&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
@@ -2447,6 +2636,8 @@ static void m560_populate_input(struct hidpp_device *hidpp,
 	__set_bit(REL_Y, mydata->input->relbit);
 	__set_bit(REL_WHEEL, mydata->input->relbit);
 	__set_bit(REL_HWHEEL, mydata->input->relbit);
+	__set_bit(REL_WHEEL_HI_RES, mydata->input->relbit);
+	__set_bit(REL_HWHEEL_HI_RES, mydata->input->relbit);
 }
 
 static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -2548,6 +2739,37 @@ static int g920_get_config(struct hidpp_device *hidpp)
 	return 0;
 }
 
+/* -------------------------------------------------------------------------- */
+/* High-resolution scroll wheels                                              */
+/* -------------------------------------------------------------------------- */
+
+static int hi_res_scroll_enable(struct hidpp_device *hidpp)
+{
+	int ret;
+	u8 multiplier = 1;
+
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
+		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
+		if (ret == 0)
+			ret = hidpp_hrw_get_wheel_capability(hidpp, &multiplier);
+	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
+		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
+							   &multiplier);
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
+		ret = hidpp10_enable_scrolling_acceleration(hidpp);
+		multiplier = 8;
+	}
+	if (ret)
+		return ret;
+
+	if (multiplier == 0)
+		multiplier = 1;
+
+	hidpp->vertical_wheel_counter.wheel_multiplier = multiplier;
+	hid_info(hidpp->hid_dev, "multiplier = %d\n", multiplier);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -2593,6 +2815,9 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
+
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
+		hidpp->vertical_wheel_counter.dev = input;
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2711,6 +2936,27 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
 	return 0;
 }
 
+static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
+	struct hid_usage *usage, __s32 value)
+{
+	/* This function will only be called for scroll events, due to the
+	 * restriction imposed in hidpp_usages.
+	 */
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	struct hidpp_scroll_counter *counter = &hidpp->vertical_wheel_counter;
+	/* A scroll event may occur before the multiplier has been retrieved or
+	 * the input device set, or high-res scroll enabling may fail. In such
+	 * cases we must return early (falling back to default behaviour) to
+	 * avoid a crash in hidpp_scroll_counter_handle_scroll.
+	 */
+	if (!(hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) || value == 0
+	    || counter->dev == NULL || counter->wheel_multiplier == 0)
+		return 0;
+
+	hidpp_scroll_counter_handle_scroll(counter, value);
+	return 1;
+}
+
 static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
@@ -2922,6 +3168,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
+		hi_res_scroll_enable(hidpp);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
@@ -3107,6 +3356,10 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
+#define LDJ_DEVICE(product) \
+	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
+		   USB_VENDOR_ID_LOGITECH, (product))
+
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
@@ -3121,10 +3374,39 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	{ /* Mouse Logitech Anywhere MX */
+	  LDJ_DEVICE(0x1017), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech Cube */
+	  LDJ_DEVICE(0x4010), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
+	{ /* Mouse Logitech M335 */
+	  LDJ_DEVICE(0x4050), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech M515 */
+	  LDJ_DEVICE(0x4007), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
 	{ /* Mouse logitech M560 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x402d),
-	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
+	  LDJ_DEVICE(0x402d),
+	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560
+		| HIDPP_QUIRK_HI_RES_SCROLL_X2120 },
+	{ /* Mouse Logitech M705 (firmware RQM17) */
+	  LDJ_DEVICE(0x101b), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
+	{ /* Mouse Logitech M705 (firmware RQM67) */
+	  LDJ_DEVICE(0x406d), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech M720 */
+	  LDJ_DEVICE(0x405e), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Anywhere 2 */
+	  LDJ_DEVICE(0x404a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb013), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb018), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0xb01f), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Anywhere 2S */
+	  LDJ_DEVICE(0x406a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master */
+	  LDJ_DEVICE(0x4041), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4060), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ LDJ_DEVICE(0x4071), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech MX Master 2S */
+	  LDJ_DEVICE(0x4069), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
+	{ /* Mouse Logitech Performance MX */
+	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
 	{ /* Keyboard logitech K400 */
 	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, 0x4024),
@@ -3144,12 +3426,19 @@ static const struct hid_device_id hidpp_devices[] = {
 
 MODULE_DEVICE_TABLE(hid, hidpp_devices);
 
+static const struct hid_usage_id hidpp_usages[] = {
+	{ HID_GD_WHEEL, EV_REL, REL_WHEEL_HI_RES },
+	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
+};
+
 static struct hid_driver hidpp_driver = {
 	.name = "logitech-hidpp-device",
 	.id_table = hidpp_devices,
 	.probe = hidpp_probe,
 	.remove = hidpp_remove,
 	.raw_event = hidpp_raw_event,
+	.usage_table = hidpp_usages,
+	.event = hidpp_event,
 	.input_configured = hidpp_input_configured,
 	.input_mapping = hidpp_input_mapping,
 	.input_mapped = hidpp_input_mapped,
-- 
2.19.2

