Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7126BECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D2720817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmGtHGuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D2720817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbeKICx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:53:57 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43239 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:53:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id x1so5699971vsc.10;
        Thu, 08 Nov 2018 09:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=XERwZdq20iB5eit7K7ANBmcTZZ79b7jDtewPhWUJx78=;
        b=kmGtHGuQ8xl9BuPazvPVwxY1J/PL9hbQKcoNBjZNt6zCu5kUKKD4naBno4QBslhNDr
         55yzgTdC4HwOSWxrdwLMU+ARLBq5e9GnazSzcBoG5xkm6hKdHqbVXt+Jph55cL4wL+2c
         8bFQc5ajG6uzpOhWXv84C9EJEzOFqgAGY9TGxM8SZHbcPPAz+cmTMA1CCGwJyi7oPd4P
         tc7JnNZvEBCKFcPGGbfgJy8TcF6RBEUam/0hQawg83LNEl7jewpRm68M0Gas5K23Yzk2
         gewqc9W9zKOO60UANJ43CTCTbpLH+vD6+mWgBdpkzVK0XAQBSiSwB1wXgb3QdLyLLiEx
         U1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=XERwZdq20iB5eit7K7ANBmcTZZ79b7jDtewPhWUJx78=;
        b=oBQqiX7EGXD10xLFxHUQj3HXUnRsChAkUOu6oiRwH/FFbRUPSEI/xFm/pfGBhcbm32
         ytoiKUXuatf3dXpek6wRanztHIuTXXIeTo0D8P/HH+iT4QtMVMS7zPQIZx+nF8K68iEz
         OncVfBTiIWyMOUxx+6YpgLnHNxnHrfPw92ab29yXDNxWaE0g6JDOwyAOu/MbOgOAqVwE
         ilsPT1JVZ4XsOatme102IqDDEF4uSPy3wjcUO3sg/dYEg1PZSbqyqsBHWPnTvEu0Fn6c
         bIrCtWdH/dt20xxOTflclJVHpCcmTfKRQXa6WX1DBtGqlGfzbKUBC/86q4q9tXhD4ZMn
         Rpsw==
X-Gm-Message-State: AGRZ1gKePT9SNhaUsHVipsO0HN1YZx9hSOFpXeR4Sgr5cS1szA5E9Ioa
        2OCyJtM6EvUItyg2ekp6mw==
X-Google-Smtp-Source: AJdET5feQ52KxZvH6FTrTC3u4z9Lcg+tlElIp2vwxoxfLYoJbjkRQ0ZwZXf35d3howWGDJ9v8Pd2YA==
X-Received: by 2002:a67:b34b:: with SMTP id b11mr2451547vsm.28.1541697448095;
        Thu, 08 Nov 2018 09:17:28 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id y195sm1792776vkd.0.2018.11.08.09.17.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 09:17:27 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v3 1/3] x86: add support for Huawei WMI hotkeys.
Date:   Thu,  8 Nov 2018 12:16:53 -0500
Message-Id: <20181108171701.4444-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108171701.4444-1-ayman.bagabas@gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for missing hotkeys on some Huawei laptops.
Currently, only Huawei Matebook X and Matebook X Pro is supported.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |  11 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei_wmi.c | 235 ++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 drivers/platform/x86/huawei_wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 54f6a40c75c6..b45c1294df7e 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1288,6 +1288,17 @@ config INTEL_ATOMISP2_PM
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_atomisp2_pm.
 
+config HUAWEI_LAPTOP
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for Huawei WMI hotkeys.
+	  It enables the missing keys and adds support to the micmute
+	  LED found on some of these laptops.
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 39ae94135406..ee93655d8bc1 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ACERHDF)		+= acerhdf.o
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_HUAWEI_LAPTOP)		+= huawei_wmi.o
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
new file mode 100644
index 000000000000..658c44ab2126
--- /dev/null
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -0,0 +1,235 @@
+/*
+ *  Huawei WMI hotkeys
+ *
+ *  Copyright (C) 2018	      Ayman Bagabas <ayman.bagabas@gmail.com>
+ *
+ *  This program is free software: you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation, either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/module.h>
+
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL");
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
+		{ KE_KEY,	 0x287, { KEY_MICMUTE } },
+		{ KE_KEY,	 0x289, { KEY_WLAN } },
+		// Huawei |M| button
+		{ KE_KEY,	 0x28a, { KEY_PROG1 } },
+		// Keyboard light
+		{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
+		{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
+		{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+		{ KE_END,	 0 }
+};
+
+static char *event_guid;
+static struct input_dev *inputdev;
+
+int huawei_wmi_micmute_led_set(bool on)
+{
+	acpi_handle handle = ACPI_HANDLE(&inputdev->dev);
+	char *method;
+	union acpi_object args[3];
+	args[0].type = args[1].type = args[2].type = ACPI_TYPE_INTEGER;
+	args[1].integer.value = 0x04;
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+
+	if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.SPIN")) {
+		args[0].integer.value = 0;
+		args[2].integer.value = on ? 1 : 0;
+	} else if (acpi_has_method(handle, method = "\\_SB.PCI0.LPCB.EC0.WPIN")) {
+		args[0].integer.value = 1;
+		args[2].integer.value = on ? 0 : 1;
+	} else {
+		pr_err("Unable to find ACPI method\n");
+		return -1;
+	}
+
+	acpi_evaluate_object(handle, method, &arg_list, NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(huawei_wmi_micmute_led_set);
+
+static void huawei_wmi_process_key(struct input_dev *inputdev, int code)
+{
+	const struct key_entry *key;
+
+	/*
+	 * MBX uses code 0x80 to indicate a hotkey event.
+	 * The actual key is fetched from the method WQ00
+	 */
+	if (code == 0x80) {
+		acpi_status status;
+		unsigned long long result;
+		const char *method = "\\WMI0.WQ00";
+		union acpi_object args[] = {
+				{ .type = ACPI_TYPE_INTEGER  },
+		};
+		args[0].integer.value = 0;
+		struct acpi_object_list arg_list = {
+			.pointer = args,
+			.count = ARRAY_SIZE(args),
+		};
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
+	if ((key->sw.code == KEY_BRIGHTNESSUP
+			|| key->sw.code == KEY_BRIGHTNESSDOWN)
+			&& strcmp(event_guid, MBXP_EVENT_GUID) == 0)
+		return;
+
+	sparse_keymap_report_entry(inputdev, key, 1, true);
+}
+
+static void huawei_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+	struct input_dev *inputdev = (struct input_dev*)context;
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
+	err = sparse_keymap_setup(inputdev,
+			huawei_wmi_keymap, NULL);
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
+		pr_warn("No known WMI GUID found\n");
+		return -ENODEV;
+	}
+
+	err = huawei_wmi_input_init();
+	if (err) {
+		pr_err("Failed to setup input device\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit huawei_wmi_exit(void)
+{
+	huawei_wmi_input_exit();
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
-- 
2.17.2

