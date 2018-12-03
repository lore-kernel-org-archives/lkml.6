Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE471C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C275208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TL8CMvrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C275208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeLCSyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:54:01 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41793 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLCSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:54:00 -0500
Received: by mail-yb1-f194.google.com with SMTP id t13-v6so5733124ybb.8;
        Mon, 03 Dec 2018 10:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8zZTnSbo8cQ2o+GieMnXGxj9kwkcdcthOGgnhLwEJto=;
        b=TL8CMvrbwbAsiLk4yRT2+ojo9qVqIP8OrMr+j5fd/HckSNKhZMHIy3ih1yGNRGj5C3
         Qe7B3wG/1Euyr0oPTTg0El8J7O8ItEXSj3h9Kh/6mweUjyb8RMzwATpM4xMdCQ40gpva
         o1wIhc169I7Wbo91ekBD7xpJxQw9GKPwMxscFtbtyIZtOjVxX7pL4ATdWMa2F/cUMZ0c
         jKvJykPdhJEiRSuIbcnlF4CDar9vl587Wj1SOIV58nZZy+qKRcc3Hz7j7D8jGMUK1ojR
         73IVH6qyCJOXJz2LJbOiULZVfJmN2mVeAziknZRer5/rryK17Q+0Ox/6ondD9MbriKi7
         0C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8zZTnSbo8cQ2o+GieMnXGxj9kwkcdcthOGgnhLwEJto=;
        b=ikcrDXhrzFKFzIgxdCwLZQ+088vgEEutax8XUV80Vhrn0sUioXOxNBt9Sb3HiwngHo
         VdVvl1aN7Tu0whjy88HivW3kb3tXJ42DWiYfu+pg5iEPzG2GLa9LRajHeptZ2AgLaGh7
         xvfsuagAuJBX6g/wcvA9XRQp0Yzpb42IbH9pz60wodb2/UqF2xR6xhygKMoGhISeXaZL
         aZEF8xfC5sstFDryuhTd5fgVqQedL6ijUhdkwacX9QO5+9xCJ3AM3X8Mvny8wG095+Hc
         lGEy7valJk2POX5HhNCBKvkV3+4s18bpFp8AyKjhm0LQK+9pXWc5ykHsH3DXN2VlFeZE
         b17g==
X-Gm-Message-State: AA+aEWYsx06McQBGLSLT6vVveuqxOASi6n1YMR1RhCgko7aS8kfAvhDu
        ZeVC2jDWmaj4nNhRNPTVMQ==
X-Google-Smtp-Source: AFSGD/XK+cFkwVPQqO1PahdHnfto/u+b6CkSNaVTkr6w1Sa2XEjyLwZ4U9viaAAPWSmYBMRT2knsQg==
X-Received: by 2002:a25:aca6:: with SMTP id x38mr2651743ybi.49.1543863236971;
        Mon, 03 Dec 2018 10:53:56 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id u132sm4842769ywc.11.2018.12.03.10.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 10:53:56 -0800 (PST)
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
Subject: [PATCH v9 2/3] x86: add support for Huawei WMI hotkeys.
Date:   Mon,  3 Dec 2018 13:53:39 -0500
Message-Id: <20181203185344.3521-3-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203185344.3521-1-ayman.bagabas@gmail.com>
References: <20181203185344.3521-1-ayman.bagabas@gmail.com>
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
then skip reporting event. Another solution would be to leave this to
user-space to handle. Which can be achieved by using "hwdb" tables and
remap those keys to "unknown". This solution seems more natural to me
because it leaves the decision to user-space.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |  16 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 226 ++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
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
index 000000000000..afa030fd1285
--- /dev/null
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -0,0 +1,226 @@
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
+static const struct key_entry huawei_wmi_keymap[] = {
+	{ KE_KEY,    0x281, { KEY_BRIGHTNESSDOWN } },
+	{ KE_KEY,    0x282, { KEY_BRIGHTNESSUP } },
+	{ KE_KEY,    0x284, { KEY_MUTE } },
+	{ KE_KEY,    0x285, { KEY_VOLUMEDOWN } },
+	{ KE_KEY,    0x286, { KEY_VOLUMEUP } },
+	{ KE_KEY,    0x287, { KEY_MICMUTE } },
+	{ KE_KEY,    0x289, { KEY_WLAN } },
+	// Huawei |M| button
+	{ KE_KEY,    0x28a, { KEY_CONFIG } },
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
+	args[1].integer.value = 0x04;
+
+	if (strcmp(priv->acpi_method, "SPIN") == 0) {
+		args[0].integer.value = 0;
+		args[2].integer.value = brightness ? 1 : 0;
+	} else if (strcmp(priv->acpi_method, "WPIN") == 0) {
+		args[0].integer.value = 1;
+		args[2].integer.value = brightness ? 0 : 1;
+	} else {
+		return -EINVAL;
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
+	status = acpi_get_handle(NULL, "\\_SB.PCI0.LPCB.EC0", &priv->handle);
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
+	priv->cdev.flags = LED_CORE_SUSPENDRESUME;
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
+module_wmi_driver(huawei_wmi_driver);
+
+MODULE_ALIAS("wmi:"WMI0_EVENT_GUID);
+MODULE_ALIAS("wmi:"AMW0_EVENT_GUID);
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL v2");
-- 
2.19.2

