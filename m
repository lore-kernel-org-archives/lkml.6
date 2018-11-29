Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A183C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18B1206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="td3hYBT5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18B1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeK3LFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:05:35 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:43445 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeK3LFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:05:35 -0500
Received: by mail-ua1-f67.google.com with SMTP id z11so1283504uaa.10;
        Thu, 29 Nov 2018 15:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VT69y4oOrBlouGl57HQV6pts+2aKiev8C1OFTWRVUP8=;
        b=td3hYBT5M2aSztwIgMXbrNgppqVFKv5e/pum6EBqqiMPXvcMggG8h0ij5YBpSjyh4E
         /f/VPBp3Gk3okKVmrvIZ7uF+AWKfx8l3ri8XGPsu0XMWIc+8IPdctHF+g5Jy46Nogo/V
         vY3rewLTJa3R9Iin5g2U+SMxR5rWz3IUcJD5kcmv6qJheJzElxkoacOA7ejqzBuFWcPs
         YoE9opn2qeywqjvZL4ocpPaFHfhsXCOzpar3fv8xPzF3VtcY4uM03assEMY8dY5vCXoI
         hBcannSPDBpy2jjR32EGeRhlq3cZiJ2r1dgcwROAAApxbUrhNcCshzyXk0A/uzYXOv/H
         zyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VT69y4oOrBlouGl57HQV6pts+2aKiev8C1OFTWRVUP8=;
        b=WtW4gm3LDqgfTcpDjjYG6pxuH9ajNVzSVv9Ah1hj0t67QIwIMVM7IG5UD81R8ye7XR
         J6Lb6uHhGnyIaHDeo3qJpLDPKw2nW2A+invuM46qTzSm4jY3XmSsPPHLGaTKpGTqSCq2
         fFgcQmZHaRCJTMy65Dp+xBiUWd3bTZLc4OhdFJrnL7jCDUa7ZYrHwZctE2URfQbZHl18
         TXKbc4b3W+7u7DbjwspgrpVxGE26osJfGrk1oDta2fLPvxHl9SxFpMhZ2E8JcoztLKPS
         Kex8zVTXmUwYflWyOkojDNVZXIjggjuoOJ4FxeicmRSXANv4iPfbhZxLF6s30gkJptWF
         69pA==
X-Gm-Message-State: AA+aEWaAza4jus87e7YtpxcksrXIZ5bR44mvRgp7jI3Rp6R7NhallZgc
        teZBJ9fI2DsKe10as12JeMEvA62wQQ==
X-Google-Smtp-Source: AFSGD/XccNS6Lwz9v5sO2Y3Jo9ABh6KXgrqpWZm4TFNLmMWKLgGcPtKGDk8awAFXIYcHgfEX3PjZZw==
X-Received: by 2002:ab0:668a:: with SMTP id a10mr1638909uan.18.1543535896115;
        Thu, 29 Nov 2018 15:58:16 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id d195sm520831vka.29.2018.11.29.15.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:58:15 -0800 (PST)
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
Subject: [PATCH v8 2/3] x86: add support for Huawei WMI hotkeys.
Date:   Thu, 29 Nov 2018 18:57:37 -0500
Message-Id: <20181129235742.14332-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181129235742.14332-1-ayman.bagabas@gmail.com>
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for missing hotkeys on some Huawei laptops.
Laptops such as the Matebook X have non functioning hotkeys. Whereas
newer laptops such as the Matebook X Pro come with working hotkeys out
of the box.

Old laptops, such as the Matebook X, report hotkey events through ACPI
device "\WMI0". However, new laptops, such as the Matebook X Pro,
does not have this WMI device.

All the hotkeys on the Matebook X Pro work fine
without this patch except (micmute, wlan, and huawei key). These keys
and the brightness keys report events to "\AMW0" ACPI device. One
problem is that brightness keys on the Matebook X Pro work without this
patch. This results in reporting two brightness key press
events one is captured by ACPI and another by this driver.

A solution would be to check if such event came from the "\AMW0" WMI driver
then skip reporting event. Another solution would be to leave this to user-space to handle. Which
can be achieved by using "hwdb" tables and remap those keys to "unknown".
This solution seems more natural to me because it leaves the decision to
user-space.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |  16 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 238 ++++++++++++++++++++++++++++++
 3 files changed, 255 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 87f70e8f4dd0..27db3ce7a1e1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1292,6 +1292,22 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config HUAWEI_WMI
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	select LEDS_CLASS
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
index 000000000000..5371c8e2ded7
--- /dev/null
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -0,0 +1,238 @@
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
+#include <linux/wmi.h>
+
+/*
+ * Huawei WMI Events GUIDs
+ */
+#define WMI0_EVENT_GUID "59142400-C6A3-40fa-BADB-8A2652834100"
+#define AMW0_EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+
+struct huawei_wmi_priv {
+	struct input_dev *idev;
+	struct led_classdev cdev;
+	acpi_handle handle;
+	char *acpi_method;
+};
+
+static const struct key_entry huawei_wmi_keymap[] __initconst = {
+	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY,    0x284, { KEY_MUTE } },
+	{ KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
+	{ KE_KEY,    0x286, { KEY_VOLUMEUP } },
+	{ KE_KEY,    0x287, { KEY_MICMUTE } },
+	{ KE_KEY,    0x289, { KEY_WLAN } },
+	// Huawei |M| button
+	{ KE_KEY,	 0x28a, { KEY_CONFIG } },
+	// Keyboard light
+	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
+	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
+	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+	{ KE_END,	 0 }
+};
+
+static int huawei_wmi_micmute_led_set(struct led_classdev *led_cdev,
+		enum led_brightness brightness)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(led_cdev->dev->parent);
+	acpi_status status;
+	union acpi_object args[3];
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+
+	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+	args[0].integer.value = 0;
+	args[1].integer.value = 0x04;
+	args[2].integer.value = brightness ? 1 : 0;
+
+	if (strcmp(priv->acpi_method, "WPIN") == 0) {
+		args[0].integer.value = 1;
+		args[2].integer.value = brightness ? 0 : 1;
+	}
+
+	status = acpi_evaluate_object(priv->handle, priv->acpi_method, &arg_list, NULL);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+
+	return 0;
+}
+
+static int huawei_wmi_leds_setup(struct wmi_device *wdev)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	acpi_status status;
+
+	// Skip registering LED subsystem if no ACPI method was found.
+	status = acpi_get_handle(priv->handle, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
+	if (ACPI_FAILURE(status))
+		return 0;
+
+	if (acpi_has_method(priv->handle, "SPIN"))
+		priv->acpi_method = "SPIN";
+	else if (acpi_has_method(priv->handle, "WPIN"))
+		priv->acpi_method = "WPIN";
+	else
+		return 0;
+
+	priv->cdev.name = "platform::micmute";
+	priv->cdev.max_brightness = 1;
+	priv->cdev.brightness_set_blocking = huawei_wmi_micmute_led_set;
+	priv->cdev.default_trigger = "audio-micmute";
+	priv->cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
+	priv->cdev.dev = &wdev->dev;
+
+	return devm_led_classdev_register(&wdev->dev, &priv->cdev);
+}
+
+static void huawei_wmi_process_key(struct wmi_device *wdev, int code)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	const struct key_entry *key;
+
+	/*
+	 * WMI0 uses code 0x80 to indicate a hotkey event.
+	 * The actual key is fetched from the method WQ00.
+	 */
+	if (code == 0x80) {
+		acpi_status status;
+		acpi_handle handle;
+		unsigned long long result;
+		union acpi_object args[1];
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
+
+		args[0].type = ACPI_TYPE_INTEGER;
+		args[0].integer.value = 0;
+
+		status = acpi_get_handle(NULL, "\\WMI0", &handle);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&wdev->dev, "Unable to get ACPI handle\n");
+			return;
+		}
+
+		status = acpi_evaluate_integer(NULL, "WQ00", &arg_list, &result);
+		if (ACPI_FAILURE(status)) {
+			dev_err(&wdev->dev, "Unable to evaluate ACPI method\n");
+			return;
+		}
+
+		code = result;
+	}
+
+	key = sparse_keymap_entry_from_scancode(priv->idev, code);
+	if (!key) {
+		dev_info(&wdev->dev, "Unknown key pressed, code: 0x%04x\n", code);
+		return;
+	}
+
+	sparse_keymap_report_entry(priv->idev, key, 1, true);
+}
+
+static void huawei_wmi_notify(struct wmi_device *wdev,
+		union acpi_object *obj)
+{
+	if (obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(wdev, obj->integer.value);
+	else
+		dev_info(&wdev->dev, "Bad response type %d\n", obj->type);
+}
+
+static int huawei_wmi_input_setup(struct wmi_device *wdev)
+{
+	struct huawei_wmi_priv *priv = dev_get_drvdata(&wdev->dev);
+	int err;
+
+	priv->idev = devm_input_allocate_device(&wdev->dev);
+	if (!priv->idev)
+		return -ENOMEM;
+
+	priv->idev->name = "Huawei WMI hotkeys";
+	priv->idev->phys = "wmi/input0";
+	priv->idev->id.bustype = BUS_HOST;
+	priv->idev->dev.parent = &wdev->dev;
+
+	err = sparse_keymap_setup(priv->idev, huawei_wmi_keymap, NULL);
+	if (err)
+		return err;
+
+	err = input_register_device(priv->idev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int huawei_wmi_probe(struct wmi_device *wdev)
+{
+	struct huawei_wmi_priv *priv;
+	int err;
+
+	priv = devm_kzalloc(&wdev->dev, sizeof(struct huawei_wmi_priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	dev_set_drvdata(&wdev->dev, priv);
+
+	err = huawei_wmi_input_setup(wdev);
+	if (err)
+		return err;
+
+	err = huawei_wmi_leds_setup(wdev);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static const struct wmi_device_id huawei_wmi_id_table[] = {
+	{ .guid_string = WMI0_EVENT_GUID },
+	{ .guid_string = AMW0_EVENT_GUID },
+	{  }
+};
+
+static struct wmi_driver huawei_wmi_driver = {
+	.driver = {
+		.name = "huawei-wmi",
+	},
+	.id_table = huawei_wmi_id_table,
+	.probe = huawei_wmi_probe,
+	.notify = huawei_wmi_notify,
+};
+
+static int __init huawei_wmi_init(void)
+{
+	if (!(wmi_has_guid(WMI0_EVENT_GUID) || wmi_has_guid(AMW0_EVENT_GUID))) {
+		pr_debug("Compatible WMI GUID not found\n");
+		return -ENODEV;
+	}
+
+	return wmi_driver_register(&huawei_wmi_driver);
+}
+
+static void __exit huawei_wmi_exit(void)
+{
+	wmi_driver_unregister(&huawei_wmi_driver);
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
+
+MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
+MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1

