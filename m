Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7387C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FB720A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JkwFuDdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FB720A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeHWUKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:10:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38985 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeHWUKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:10:54 -0400
Received: by mail-pg1-f196.google.com with SMTP id m3-v6so1962468pgp.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/hGecNIspqsS2kcLrsC8xl2GZeYuv37zgn6ShBEXyg=;
        b=JkwFuDdWCUYKz1Y4ENqvCE0k7yNMZlmvPFfWCKR8kYHx3njFJqHwA4G8RaaRejiMaq
         BjB3t0ykTewyYtXLJmKS38keJJC7TKutFzHlXuRDubvc2UWP0gggPjG66azJygu+bzbE
         tCl7/UZksQgetD1+jWwpYL4CU3hnEjMFymN3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n/hGecNIspqsS2kcLrsC8xl2GZeYuv37zgn6ShBEXyg=;
        b=V7pOz6jHaWBxZtuQqr+KY2yjERwAwzWVJHApzQOM6gHjhuRc6eiedgBKIuJAgEfSNy
         tNI3R76hPSaxnnI/EzOxTLfqw82E+K1BAc33Smt++hS3Nv53io70anHwSYPNFe45HKSp
         qpDFQ+zRg+kwG/4PWJCC0DPlX3LDe4pR79Kfjo/Mfbw3jQdMCMH8nH9l5vjJ822DUYB9
         y62vUZi27OPA4KtIMsxZsFuxo+hrbqs2fKUXGKYRxFHu+pC8ZzZ3VGI3LH2fzOStagjk
         2sbmct3mwoEnmKL/px8DrcqDgNsbh0365bsspeCmTNQhXFWFe9jEgZa7jggoUmwKJePk
         erPA==
X-Gm-Message-State: AOUpUlF3zQrR/U+gKhRN9FPS6JErRz2zHXdMz29hF5tdfOdD6Kp/I6f/
        ld5nSniBm8gg+kEjoEgRvn6ayE5Wwzk=
X-Google-Smtp-Source: AA+uWPy/yo0U1XLRCfWbP2K4JmxXjnuBKJ98FDBujAESTnRHXM+c0QM091yu+ipm5MSCzGTqg3RhdA==
X-Received: by 2002:a17:902:7845:: with SMTP id e5-v6mr58331517pln.197.1535042421717;
        Thu, 23 Aug 2018 09:40:21 -0700 (PDT)
Received: from seobrien0.mtv.corp.google.com ([2620:15c:202:201:caef:1ffb:e3b5:94f2])
        by smtp.gmail.com with ESMTPSA id a19-v6sm9274340pfj.38.2018.08.23.09.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 09:40:20 -0700 (PDT)
From:   Sean O'Brien <seobrien@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH] HID: add support for Apple Magic Keyboards
Date:   Thu, 23 Aug 2018 09:40:05 -0700
Message-Id: <20180823164005.201582-1-seobrien@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB device
	Vendor 05ac (Apple)
	Device 026c (Magic Keyboard with Numeric Keypad)

Bluetooth devices
	Vendor 004c (Apple)
	Device 0267 (Magic Keyboard)
	Device 026c (Magic Keyboard with Numeric Keypad)

Support already exists for the Magic Keyboard over USB connection.
This patch adds support for the Magic Keyboard over Bluetooth
connection, and for the Magic Keyboard with Numeric Keypad over
Bluetooth and USB connection.

Signed-off-by: Sean O'Brien <seobrien@chromium.org>
---

 drivers/hid/hid-apple.c  | 9 ++++++++-
 drivers/hid/hid-ids.h    | 2 ++
 drivers/hid/hid-quirks.c | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 25b7bd56ae11..1cb41992aaa1 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -335,7 +335,8 @@ static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
+	if (usage->hid == (HID_UP_CUSTOM | 0x0003) ||
+			usage->hid == (HID_UP_MSVENDOR | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
 		set_bit(EV_REP, hi->input->evbit);
 		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
@@ -472,6 +473,12 @@ static const struct hid_device_id apple_devices[] = {
 		.driver_data = APPLE_NUMLOCK_EMULATION | APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
 		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
+		.driver_data = APPLE_HAS_FN },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI),
+		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ANSI),
 		.driver_data = APPLE_HAS_FN },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_WELLSPRING_ISO),
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 79bdf0c7e351..5dbe3fb82690 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -88,6 +88,7 @@
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
 
 #define USB_VENDOR_ID_APPLE		0x05ac
+#define BT_VENDOR_ID_APPLE		0x004c
 #define USB_DEVICE_ID_APPLE_MIGHTYMOUSE	0x0304
 #define USB_DEVICE_ID_APPLE_MAGICMOUSE	0x030d
 #define USB_DEVICE_ID_APPLE_MAGICTRACKPAD	0x030e
@@ -157,6 +158,7 @@
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO   0x0256
 #define USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS   0x0257
 #define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI   0x0267
+#define USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI   0x026c
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ANSI	0x0290
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_ISO	0x0291
 #define USB_DEVICE_ID_APPLE_WELLSPRING8_JIS	0x0292
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..a3b3aecf8628 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -270,6 +270,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_ISO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_WIRELESS_2011_JIS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_ANSI) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGIC_KEYBOARD_NUMPAD_ANSI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY) },
 #endif
-- 
2.18.0.1017.ga543ac7ca45-goog

