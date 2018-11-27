Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1482C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE32086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 02:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0M6yxsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BE32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeK0NzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 08:55:00 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37483 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbeK0NzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 08:55:00 -0500
Received: by mail-vs1-f66.google.com with SMTP id h18so12817018vsj.4;
        Mon, 26 Nov 2018 18:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+lnsOoSpKzOe0OGNePqW8hMjyow6Cx41d/JN1fD5LA=;
        b=b0M6yxsUm1rHQ/qEAmI+u40zl2CUwgLOeSSUS/ricMThCDdtBA8lviBmHYn4GUb0BG
         ydiMHZfREMuDfTgSzjbVd0ALWSXLQtOI+x4adxaBlTYVo8IdpvQfOMsLKkdr4ogdYSfL
         pWT7MP/G66kgHfUKYT0q63s2+MaKTQsb276p+4Tsgr4pic/cObDOPW+vNHkckYEl1pf5
         IFMT5KnV/XFnCJcsp9prjZt5NewBWSpznyBRAqfeegYxiY7SXcaejq6DGS0gdWZoodJG
         P11G38YTU+ew2VRE2U9rL7Vulj3Ffskt3AmCcDiagxYduBHTeP4z7s5v+yc+D7QHwz9+
         BeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+lnsOoSpKzOe0OGNePqW8hMjyow6Cx41d/JN1fD5LA=;
        b=mZMSDZDP9BBlcLcRVLxAjncFocPcOocr3bWP2nAKBDIlqpKXRj9sgNbOY+CX+zrNUf
         C0DgkV1+7u4kXgRSXqMKy/VzINfOB+pmsDvqPZgk3ajjxfTvBC14q4D11h8LakqYiHth
         8wAiF8BQ/sc0L/qeuaA8iDXHbI94gjcbSeIlP73AabuZycrE6EZArQAqaOmu29dEam5Y
         6+kjPk8ASXuqvcNuSH3dZHUjp7hh/8gVcBlGsOOBiyDA5pBkzPZEvswQWto+BBOS3r9x
         6gnYD1ANeCZ7U7v97mK4bkRAuxjAMpxLeDRQQoHL6nLeDTMhS1NCyIzbUH7rOaYiCd5u
         xhLA==
X-Gm-Message-State: AA+aEWaJt0upkp/N/XzNxNC/zLy5YOg+MIHWjenWVqNpad+HCBBL4iev
        0JKMV41+xPLQBT4Y+7YLgVmmjQ7d7w==
X-Google-Smtp-Source: AJdET5eIpTFP4+e7UtCePdkfXR5qDBSK7bWjClKRsOSNpBHra9orumNP8mtagpHOHzWsW5WYsKqIbw==
X-Received: by 2002:a67:6583:: with SMTP id z125mr11882805vsb.135.1543287517903;
        Mon, 26 Nov 2018 18:58:37 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id j82sm1006934vsd.23.2018.11.26.18.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 18:58:37 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v7 2/3] x86: add support for Huawei WMI hotkeys.
Date:   Mon, 26 Nov 2018 21:57:48 -0500
Message-Id: <20181127025752.6459-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181127025752.6459-1-ayman.bagabas@gmail.com>
References: <20181127025752.6459-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for missing hotkeys on some Huawei laptops.
Currently, only Huawei Matebook X and Matebook X Pro is supported.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |  15 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 247 ++++++++++++++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 87f70e8f4dd0..0f9db4275fb4 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1292,6 +1292,21 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config HUAWEI_WMI
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	select LEDS_TRIGGERS
+	select LEDS_TRIGGER_AUDIO
+	help
+	  This driver provides support for Huawei WMI hotkeys.
+	  It enables the missing keys and adds support to the micmute
+	  LED found on some of these laptops.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called huawei-wmi.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 39ae94135406..d841c550e3cc 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ACERHDF)		+= acerhdf.o
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_HUAWEI_WMI)		+= huawei-wmi.o
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
new file mode 100644
index 000000000000..b6157c5b7f4a
--- /dev/null
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Huawei WMI hotkeys
+ *
+ *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL v2");
+
+/*
+ * Huawei WMI Events GUIDs
+ */
+#define MBX_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+#define MBXP_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+
+MODULE_ALIAS("wmi:"MBX_EVENT_GUID);
+MODULE_ALIAS("wmi:"MBXP_EVENT_GUID);
+
+static const struct key_entry huawei_wmi_keymap[] __initconst = {
+		{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
+		{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
+		{ KE_KEY,    0x284, { KEY_MUTE } },
+		{ KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
+		{ KE_KEY,    0x286, { KEY_VOLUMEUP } },
+		{ KE_KEY,    0x287, { KEY_MICMUTE } },
+		{ KE_KEY,    0x289, { KEY_WLAN } },
+		// Huawei |M| button
+		{ KE_KEY,    0x28a, { KEY_CONFIG } },
+		// Keyboard light
+		{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
+		{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
+		{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+		{ KE_END,    0 }
+};
+
+static char *event_guid;
+static struct input_dev *inputdev;
+
+static int huawei_wmi_micmute_led_set(bool on)
+{
+	acpi_handle handle;
+	char *method;
+	union acpi_object args[3];
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+
+	handle = ACPI_HANDLE(&inputdev->dev);
+	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = 0x04;
+
+	if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
+		args[0].integer.value = 0;
+		args[2].integer.value = on ? 1 : 0;
+	} else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
+		args[0].integer.value = 1;
+		args[2].integer.value = on ? 0 : 1;
+	} else {
+		dev_err(&inputdev->dev, "Unable to find ACPI method\n");
+		return -ENOSYS;
+	}
+
+	acpi_evaluate_object(handle, method, &arg_list, NULL);
+
+	return 0;
+}
+
+static int micmute_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	int state = brightness != LED_OFF;
+	int err;
+
+	err = huawei_wmi_micmute_led_set(state);
+	return err < 0 ? err : 0;
+}
+
+static struct led_classdev micmute_led_cdev = {
+	.name = "huawei::micmute",
+	.max_brightness = 1,
+	.brightness_set_blocking = micmute_led_set,
+	.default_trigger = "audio-micmute",
+};
+
+static void huawei_wmi_process_key(struct input_dev *inputdev, int code)
+{
+	const struct key_entry *key;
+
+	/*
+	 * MBX uses code 0x80 to indicate a hotkey event.
+	 * The actual key is fetched from the method WQ00.
+	 */
+	if (code == 0x80) {
+		acpi_status status;
+		unsigned long long result;
+		const char *method = "\\WMI0.WQ00";
+		union acpi_object args[1];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		args[0].type = ACPI_TYPE_INTEGER;
+		args[0].integer.value = 0;
+
+		status = acpi_evaluate_integer(ACPI_HANDLE(&inputdev->dev), (char *)method, &arg_list, &result);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&inputdev->dev, "Unable to evaluate ACPI method %s\n", method);
+			return;
+		}
+
+		code = result;
+	}
+
+	key = sparse_keymap_entry_from_scancode(inputdev, code);
+	if (!key) {
+		dev_info(&inputdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
+		return;
+	}
+
+	/*
+	 * The MBXP handles backlight natively using ACPI,
+	 * but not the MBX. If MBXP is being used, skip reporting event.
+	 */
+	if ((key->sw.code == KEY_BRIGHTNESSUP || key->sw.code == KEY_BRIGHTNESSDOWN)
+			&& strcmp(event_guid, MBXP_EVENT_GUID) == 0)
+		return;
+
+	sparse_keymap_report_entry(inputdev, key, 1, true);
+}
+
+static void huawei_wmi_notify(u32 value, void *context)
+{
+	struct input_dev *inputdev = context;
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&inputdev->dev, "Bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(inputdev, obj->integer.value);
+	else
+		dev_info(&inputdev->dev, "Unknown response received %d\n", obj->type);
+
+	kfree(response.pointer);
+}
+
+static int huawei_wmi_input_init(void)
+{
+	acpi_status status;
+	int err;
+
+	inputdev = input_allocate_device();
+	if (!inputdev)
+		return -ENOMEM;
+
+	inputdev->name = "Huawei WMI hotkeys";
+	inputdev->phys = "wmi/input0";
+	inputdev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(inputdev, huawei_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	status = wmi_install_notify_handler(event_guid,
+			huawei_wmi_notify,
+			inputdev);
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_free_dev;
+	}
+
+	err = input_register_device(inputdev);
+	if (err)
+		goto err_remove_notifier;
+
+	return 0;
+
+err_remove_notifier:
+	wmi_remove_notify_handler(event_guid);
+err_free_dev:
+	input_free_device(inputdev);
+	return err;
+}
+
+static void huawei_wmi_input_exit(void)
+{
+	wmi_remove_notify_handler(event_guid);
+	input_unregister_device(inputdev);
+}
+
+static int __init huawei_wmi_init(void)
+{
+	int err;
+
+	if (wmi_has_guid(MBX_EVENT_GUID)) {
+		event_guid = MBX_EVENT_GUID;
+	} else if (wmi_has_guid(MBXP_EVENT_GUID)) {
+		event_guid = MBXP_EVENT_GUID;
+	} else {
+		pr_warn("Compatible WMI GUID not found\n");
+		return -ENODEV;
+	}
+
+	err = huawei_wmi_input_init();
+	if (err)
+		goto err_input;
+
+	micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	err = led_classdev_register(&inputdev->dev, &micmute_led_cdev);
+	if (err)
+		goto err_leds;
+
+	return 0;
+
+err_leds:
+	huawei_wmi_input_exit();
+err_input:
+	return err;
+}
+
+static void __exit huawei_wmi_exit(void)
+{
+	led_classdev_unregister(&micmute_led_cdev);
+	huawei_wmi_input_exit();
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
-- 
2.19.1

