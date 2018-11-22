Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14031C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDF420865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="Gg+mjv7F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGcFnu1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDF420865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404816AbeKVRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:13:15 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57377 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404781AbeKVRNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:13:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A69F821F6E;
        Thu, 22 Nov 2018 01:35:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UzoHqJ5FV1gy/
        IYdGIuPlRBjP3FGH4pysmNY3PMfoRk=; b=Gg+mjv7FlvgFoIv/KXqrrNE4eDlpt
        xoFXoQOiLAhnMegPHQ4kMPCC5xqOGxm5PiZAkSqfK8282VmSS6kKx5Li/cXPfA07
        aHk4yiwwQDE88cBZZm/4LUzVhZ/46YGX8DMx+gWpL2eb83pGFkBF0jV4UwPvBA8F
        Tbk827MTV4NuPDMvOtGLe9OQaXn7Lhvb8+ah5ib/fmGUhswbxlE8nT7n/QL8GJkz
        Ym0MHG6ryBhRO39sGN2Edg8jMsFyx379xgcNbk3ucKRr86QfA4/wj28rv5rCuZ9V
        fxPYTUJs6+hR2WktP+7MaqwxQz4LTs2oHlBlvLmkRFG1TJEvptsb0Lu6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UzoHqJ5FV1gy/IYdGIuPlRBjP3FGH4pysmNY3PMfoRk=; b=UGcFnu1m
        uvTAZZNMN75IOD+20JQst+vj3CJlMlWsQLHGtNLtNd7BUXRl5G5GmOdQtmJbiiBy
        HbP54px9qvws/3SZ6rnA0BYME2vhiyNzsVAHh1DqOW7hJkqGQWTXJzxtkxdMqkku
        PLnKMmTvAYalKR/KjQnHYm+7jHtOpCDwGXRmalj2yzwpgv4kQY4BVP1eeMdAqNd+
        +4R+wAFdem03L0UnDE651otpB3DVdJZst9ugDQl4Wj4+AUyj07jpZLeJWtGbop8Q
        CaWrcl1WRIekupwraAP1Tq0Y1nunwROsPAavpWiM8+H9R/QKhAxj8yGSPxTaG3U8
        DhPAi5QkH1VrNg==
X-ME-Sender: <xms:Ik72W-40o9sImbomHWvuwWFkN-6eyZM-Q4-Hd76mHxCoYkDkGoQ11Q>
X-ME-Proxy: <xmx:Ik72W1Y318TdA63oX4V1j9BAxmq3bglbw1YcovSRZ60k38lCJ_ym8w>
    <xmx:Ik72W0xT0MJwhi17plDl3h7O5skcHjxbNFbIm4PjaZZn5XgJ0ddZ4g>
    <xmx:Ik72W0D1J8xD1kV24vaqAXPl1LDousqgxiZwr7OGnYFKLGa-dGquqg>
    <xmx:Ik72W5G9yAnamRXmBZGclTwegXeQKdHt1K3uXW1TwAkgmKXDnaXB3A>
    <xmx:Ik72W4j7WvT704IVtj8md6bi6NRMtYZVMsBaedgQNSFGrdLRGHfDzg>
    <xmx:Ik72W_M2rgCKf_yk_1zXP94EghgeamEvP1nUj9v5Ro4jVXALb1YcTA>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EC9E102DE;
        Thu, 22 Nov 2018 01:35:11 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 8/8] HID: logitech: Enable high-resolution scrolling on Logitech mice
Date:   Thu, 22 Nov 2018 16:34:09 +1000
Message-Id: <20181122063409.15816-9-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
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
Changes to the previous version:
- this is a squash of the commits above, splitting it up after all the
  changes was a tad difficult
- this looks to be a logitech-specific requirement because the firmware
  can swallow events. I moved the lot to the hidpp implementation
- added directional reset together with the threshold-based REL_WHEEL
  emulation trigger
- added a timeout to stop the emulation from sliding too much within the
  window

This was tested on an MX Anywhere 2S, Harry, please re-test on the other
mice, thanks.

 drivers/hid/hid-logitech-hidpp.c | 310 ++++++++++++++++++++++++++++++-
 1 file changed, 306 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 67ca587aecfa..8d2a7000bf0c 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/timer.h>
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
 
@@ -128,6 +137,31 @@ struct hidpp_battery {
 	bool online;
 };
 
+/**
+ * struct hidpp_scroll_counter - Utility class for processing high-resolution
+ *                             scroll events.
+ * @dev: the input device for which events should be reported.
+ * @wheel_multiplier: the scalar multiplier to be applied to wheel
+ *                    data as a fraction of 120.  For example, if
+ *                    moving the wheel by one detent would result in a
+ *                    value of 1 in low-resolution mode but 8 in
+ *                    high-resolution, the multiplier is 120/8.
+ * @remainder: counts the number of high-resolution units moved since the last
+ *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
+ *             only be used by class methods.
+ * @direction: direction of last movement (1 or -1)
+ * @time: the timer to reset the remainder after a period of inactivity
+ */
+struct hidpp_scroll_counter {
+	struct input_dev *dev;
+	int wheel_multiplier;
+
+	int remainder;
+	int direction;
+
+	struct timer_list timer;
+};
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct mutex send_mutex;
@@ -149,6 +183,7 @@ struct hidpp_device {
 	unsigned long capabilities;
 
 	struct hidpp_battery battery;
+	struct hidpp_scroll_counter vertical_wheel_counter;
 };
 
 /* HID++ 1.0 error codes */
@@ -391,6 +426,65 @@ static void hidpp_prefix_name(char **name, int name_length)
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
+
+	hi_res_value *= counter->wheel_multiplier;
+	input_report_rel(counter->dev, REL_WHEEL_HI_RES, hi_res_value);
+
+	/*
+	 * Update the low-res remainder with the high-res value,
+	 * but reset if the direction has changed.
+	 */
+	remainder = counter->remainder;
+	direction = hi_res_value > 0 ? 1 : -1;
+	if (direction != counter->direction)
+		remainder = 0;
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
+
+	/*
+	 * Even with the above, our emulation point still slides around with
+	 * some movements. Reset it after a second of no activity.
+	 */
+	mod_timer(&counter->timer, jiffies + msecs_to_jiffies(1000));
+}
+
 /* -------------------------------------------------------------------------- */
 /* HIDP++ 1.0 commands                                                        */
 /* -------------------------------------------------------------------------- */
@@ -1157,6 +1251,99 @@ static int hidpp_battery_get_property(struct power_supply *psy,
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
@@ -2420,7 +2607,8 @@ static int m560_raw_event(struct hid_device *hdev, u8 *data, int size)
 		input_report_rel(mydata->input, REL_Y, v);
 
 		v = hid_snto32(data[6], 8);
-		input_report_rel(mydata->input, REL_WHEEL, v);
+		hidpp_scroll_counter_handle_scroll(
+				&hidpp->vertical_wheel_counter, v);
 
 		input_sync(mydata->input);
 	}
@@ -2548,6 +2736,37 @@ static int g920_get_config(struct hidpp_device *hidpp)
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
+		multiplier = 120;
+
+	hidpp->vertical_wheel_counter.wheel_multiplier = 120/multiplier;
+	hid_info(hidpp->hid_dev, "multiplier = %d\n", multiplier);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* Generic HID++ devices                                                      */
 /* -------------------------------------------------------------------------- */
@@ -2593,6 +2812,11 @@ static void hidpp_populate_input(struct hidpp_device *hidpp,
 		wtp_populate_input(hidpp, input, origin_is_hid_core);
 	else if (hidpp->quirks & HIDPP_QUIRK_CLASS_M560)
 		m560_populate_input(hidpp, input, origin_is_hid_core);
+
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL) {
+		input_set_capability(input, EV_REL, REL_WHEEL_HI_RES);
+		hidpp->vertical_wheel_counter.dev = input;
+	}
 }
 
 static int hidpp_input_configured(struct hid_device *hdev,
@@ -2711,6 +2935,27 @@ static int hidpp_raw_event(struct hid_device *hdev, struct hid_report *report,
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
@@ -2922,6 +3167,9 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
+	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
+		hi_res_scroll_enable(hidpp);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
@@ -2952,6 +3200,15 @@ static const struct attribute_group ps_attribute_group = {
 	.attrs = sysfs_attrs
 };
 
+
+
+static void hidpp_scroll_timeout(struct timer_list *t)
+{
+	struct hidpp_scroll_counter *counter = from_timer(counter, t,
+							  timer);
+	counter->remainder = 0;
+}
+
 static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct hidpp_device *hidpp;
@@ -2992,6 +3249,9 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto allocate_fail;
 	}
 
+	timer_setup(&hidpp->vertical_wheel_counter.timer,
+		    hidpp_scroll_timeout, 0);
+
 	INIT_WORK(&hidpp->work, delayed_work_cb);
 	mutex_init(&hidpp->send_mutex);
 	init_waitqueue_head(&hidpp->wait);
@@ -3096,6 +3356,8 @@ static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
 
+	del_timer_sync(&hidpp->vertical_wheel_counter.timer);
+
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
@@ -3107,6 +3369,10 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
+#define LDJ_DEVICE(product) \
+	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
+		   USB_VENDOR_ID_LOGITECH, (product))
+
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
 	  LDJ_DEVICE(0x4011),
@@ -3119,10 +3385,39 @@ static const struct hid_device_id hidpp_devices[] = {
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
 	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
@@ -3139,12 +3434,19 @@ static const struct hid_device_id hidpp_devices[] = {
 
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
2.19.1

