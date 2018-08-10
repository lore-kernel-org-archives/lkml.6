Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B31C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AE12239B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiByNORm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01AE12239B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbeHJCot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:44:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43620 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHJCos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:44:48 -0400
Received: by mail-pl0-f66.google.com with SMTP id x6-v6so3231705plv.10;
        Thu, 09 Aug 2018 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mB2ee99yJompP0vqryH+TpGEuchkZOGRWt3PCnCXNGA=;
        b=AiByNORmaBaf7lmNPaDecVcRnIa2rCPDSXZWKcfEHxb7fsgKcU30VWNzSeKzPf0j4t
         4/Cr0qDN9u2aIzPp3s6C064nz4FJhFByq7ZzJptEihNQN4odhz6svfRdku/7SBBetpKU
         jWiSJAexL+la5Dd552KIPq5O8LIzZD40qf+HU2vCmDTBIZ2UdIbYBfwGGIQ7UitAMP8m
         vmuBGnz19yd0pdOWZ8nJCfaJ7flA4TErYMsTyywMBgpN9GBURb6uwBW5Yty4LBshY1qn
         f1hMPDJpxwOBsbxJR0KKGX3XPPuPnFPemnoLIlKZ8YGu6Z3+HXU9Q0XgjfAl/BJcfyq0
         x/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mB2ee99yJompP0vqryH+TpGEuchkZOGRWt3PCnCXNGA=;
        b=DlW8pXlprB43QJF8OjN1WetS6dXZMW0KJSPKrolrPe3BZjzlgFXqCjelJD4cWZsSU+
         HmfSLXBc/uSYiaVivkrxinx/YNx9wyqsaxEd/xrN0/v6pOxdB5dEtIqtewKelhAxOTiL
         ZVroc75LRI97U9qYHZWXqqXnr13CuNaG7sAKWmhGnYX4jB65bxxSa/L+Y2XFCMehDCAF
         ljocpc2aSrssMDVwY7Zw+tYQiyDGjf17Rk3Y86HiGtqtFSQU5Ml2nkziNNl0hgzk1Ckg
         m5KL8jijRYWs9gXS5+ETOi5ev+5ZQcn6CAuByUWU5m+94gvT7JRHcuJobUTrTc41WQUW
         angQ==
X-Gm-Message-State: AOUpUlGl36AX3Yvv3RbHktsrVOsxiz+9CAIpRVV/5rFbDTho+cThkwj1
        tUc5MrqAdNCSaDkMHfpF1nY=
X-Google-Smtp-Source: AA+uWPzGGBpNLrDEjjzkmFRZQguxLWKG+Oertn+pvTN3wkGnlHJpsssIlSKIGBCqpfrQVUX8T1W1Hw==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr3866972plb.87.1533860250399;
        Thu, 09 Aug 2018 17:17:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v22-v6sm20558035pfi.60.2018.08.09.17.17.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 17:17:29 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH] hid: microsoft: Add rumble support for Xbox One S controller
Date:   Thu,  9 Aug 2018 17:17:14 -0700
Message-Id: <20180810001714.14659-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HID quirk driver for Xbox One S controller over bluetooth.

This driver only adds support for rumble. Standard controller
functionality is exposed by default HID driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/Kconfig         |   8 ++
 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-microsoft.c | 142 ++++++++++++++++++++++++++++++++++--
 drivers/hid/hid-quirks.c    |   1 +
 4 files changed, 147 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a49a10437c40..b2e983cb32f0 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -589,6 +589,14 @@ config HID_MICROSOFT
 	---help---
 	Support for Microsoft devices that are not fully compliant with HID standard.
 
+config MICROSOFT_FF
+	bool "Microsoft Xbox One S controller force feedback support"
+	depends on HID_MICROSOFT
+	select INPUT_FF_MEMLESS
+	---help---
+	Say Y here if you have a Microsoft Xbox One S controller and want to enable
+	force feedback support for it.
+
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
 	depends on HID
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c7981ddd8776..c8b4bc7fe053 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -798,6 +798,7 @@
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
+#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 96e7d3231d2f..e2bd31d54e62 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -29,10 +29,29 @@
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
 
+struct ms_data {
+	unsigned long quirks;
+	struct hid_device *hdev;
+	struct work_struct ff_worker;
+	__u8 strong;
+	__u8 weak;
+	__u8 *output_report_dmabuf;
+};
+
+struct xb1s_ff_report {
+	__u8	report_id;
+	__u8	enable;
+	__u8	magnitude[4];
+	__u8	duration_10ms;
+	__u8	start_delay_10ms;
+	__u8	loop_count;
+};
+
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	/*
 	 * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -134,7 +153,8 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
@@ -153,7 +173,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_DUPLICATE_USAGES)
 		clear_bit(usage->code, *bit);
@@ -164,7 +185,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 	struct input_dev *input;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
@@ -219,12 +241,96 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+#ifdef CONFIG_MICROSOFT_FF
+
+#define XB1S_FF_REPORT		3
+#define ENABLE_WEAK		BIT(0)
+#define ENABLE_STRONG		BIT(1)
+#define MAGNITUDE_WEAK		3
+#define MAGNITUDE_STRONG	2
+
+static void ms_ff_worker(struct work_struct *work)
+{
+	struct ms_data *ms = container_of(work, struct ms_data, ff_worker);
+	struct hid_device *hdev = ms->hdev;
+	struct xb1s_ff_report *r =
+		(struct xb1s_ff_report *) ms->output_report_dmabuf;
+	int ret;
+
+	memset(r, 0, sizeof(*r));
+
+	r->report_id = XB1S_FF_REPORT;
+	r->enable = ENABLE_WEAK | ENABLE_STRONG;
+	/*
+	 * Specifying maximum duration and maximum loop count should
+	 * cover maximum duration of a single effect: 65536 ms
+	 */
+	r->duration_10ms = U8_MAX;
+	r->loop_count = U8_MAX;
+	r->magnitude[MAGNITUDE_STRONG] = ms->strong; /* left actuator */
+	r->magnitude[MAGNITUDE_WEAK] = ms->weak;     /* right actuator */
+
+	ret = hid_hw_output_report(hdev, (__u8 *)r, sizeof(*r));
+	if (ret)
+		hid_warn(hdev, "failed to send FF report\n");
+}
+
+static int ms_play_effect(struct input_dev *dev, void *data,
+			  struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct ms_data *ms = hid_get_drvdata(hid);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	/* Magnitude is 0..100 so scale the 16-bit input here */
+	ms->strong = ((u32) effect->u.rumble.strong_magnitude * 100) / U16_MAX;
+	ms->weak = ((u32) effect->u.rumble.weak_magnitude * 100) / U16_MAX;
+
+	schedule_work(&ms->ff_worker);
+	return 0;
+}
+
+static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
+{
+	struct hid_input *hidinput = list_entry(hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
+
+	ms->hdev = hdev;
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
+	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
+						sizeof(struct xb1s_ff_report),
+						GFP_KERNEL);
+	if (ms->output_report_dmabuf == NULL)
+		return -ENOMEM;
+
+	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(input_dev, NULL, ms_play_effect);
+}
+
+#else
+static int ms_init_ff(struct hid_device *hdev, struct ms_data *ms)
+{
+	return 0;
+}
+#endif
+
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
+	struct ms_data *ms;
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	ms = devm_kzalloc(&hdev->dev, sizeof(*ms), GFP_KERNEL);
+	if (ms == NULL)
+		return -ENOMEM;
+
+	ms->quirks = quirks;
+
+	hid_set_drvdata(hdev, ms);
 
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
@@ -242,11 +348,32 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
+	if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
+	    hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {
+		ret = ms_init_ff(hdev, ms);
+		if (ret) {
+			hid_err(hdev,
+				"could not initialize ff, continuing anyway");
+		}
+	}
+
 	return 0;
 err_free:
 	return ret;
 }
 
+static void ms_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+
+	if (IS_ENABLED(CONFIG_MICROSOFT_FF) &&
+	    hdev->product == USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) {
+		struct ms_data *ms = hid_get_drvdata(hdev);
+
+		cancel_work_sync(&ms->ff_worker);
+	}
+}
+
 static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV),
 		.driver_data = MS_HIDINPUT },
@@ -281,6 +408,10 @@ static const struct hid_device_id ms_devices[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
+#ifdef CONFIG_MICROSOFT_FF
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+		.driver_data = 0 },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ms_devices);
@@ -293,6 +424,7 @@ static struct hid_driver ms_driver = {
 	.input_mapped = ms_input_mapped,
 	.event = ms_event,
 	.probe = ms_probe,
+	.remove = ms_remove,
 };
 module_hid_driver(ms_driver);
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..10fefd0ed43c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -496,6 +496,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER) },
 #endif
 #if IS_ENABLED(CONFIG_HID_MONTEREY)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
-- 
2.17.1

