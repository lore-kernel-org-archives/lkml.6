Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E08EC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F422081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ooIIyKOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F422081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeKBNRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 09:17:22 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44962 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeKBNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 09:17:21 -0400
Received: by mail-ua1-f66.google.com with SMTP id i30so219044uae.11;
        Thu, 01 Nov 2018 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ju0EHp5DDPgeJtHoBeb9/yartdMBJ2pVo/Kmy944BHw=;
        b=ooIIyKOMXg34Y5Ah3HEl12ONi8uajDozeuNm6KwTM3c+3FoD3KwUQVQzgwf/lopTUY
         DJN0PxaShbH/RX718+GHA0c2lKfZg3w+Qe4u5m9j7VgYEQa8iG5bvL2lkrMMFpNORmiL
         9b++z4McfbaDfmuyHAg3NftvSWrO/GCPJ1DPzjyTJtJhvQz9y7gEqLjBd/DsQ2ZC3XFD
         pRu55q1BjXy+JyoulysV2es/FYvqmZ12eh8NMxvPLk/bYxYYEPauvSvNjAS9z54oqJC4
         cBK1mf3EUyEFB0wTIlO2fiSIwVrZvX+HNfd0IhUWWLKC2gZ+J31uITsTmF/3xu0ZheSk
         4QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ju0EHp5DDPgeJtHoBeb9/yartdMBJ2pVo/Kmy944BHw=;
        b=ORvZuYkAjvoOpdtJeULR3H2A8ezHVsuzLs2W2DHds5rYuRCzo6WZ4GtrtPcd8ul/D1
         yo2URljQW2dP/MfiqDg98UuAt2ezpcuea0rWJPOsMJ4okCJ0MklxhN5+89KUiewtExCE
         D6kXjD7CPeBN6v5HYGsvwrI7V5dOtRIM0ejIlUCBgmIyOjCADZp2g/Gk6/6LwnODGAi/
         A+qyUMDobyquLS/hIpNzaUM+Cf/8KQAgQ4XeUHDAynD+yujeBMq2LTjYKpJFfpEtUpKP
         7v4wEjFVtzk4FCWcZHcCv8W7Y4vS+YP0QTkzXvd/4aBN787sGn4m3ZOe7NAfGOiD+GtM
         ogVA==
X-Gm-Message-State: AGRZ1gILmVw1k266lFA0V3lLERHP3Dvj3OCbJEzTi7OWw4liS9zkpv/s
        2C/e/byyc7cX/+d8gUsJWg==
X-Google-Smtp-Source: AJdET5fsYFD+TqMxgwwhRd5y5imILJdBXqFXoymXBhcCukhJZRw0Tp75b3HCHkGAc4DlSLq+gUwo+w==
X-Received: by 2002:ab0:a8c:: with SMTP id d12mr4677880uak.67.1541131898607;
        Thu, 01 Nov 2018 21:11:38 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a2sm1661150uaa.15.2018.11.01.21.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 21:11:38 -0700 (PDT)
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
Subject: [PATCH v2 1/3] x86: add support for Huawei WMI hotkeys.
Date:   Fri,  2 Nov 2018 00:11:13 -0400
Message-Id: <20181102041120.7603-2-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181102041120.7603-1-ayman.bagabas@gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for missing hotkeys on some Huawei laptops.
Currently, only Huawei Matebook X Pro is supported. The driver
recognizes the following keys: brightness keys, micmute, wlan, and
Huawei special key. The brightness keys are ignored since they work out
of the box.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/Kconfig      |  13 ++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei_wmi.c | 223 ++++++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/platform/x86/huawei_wmi.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0c1aa6c314f5..c6813981e45c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1229,6 +1229,19 @@ config I2C_MULTI_INSTANTIATE
 	  To compile this driver as a module, choose M here: the module
 	  will be called i2c-multi-instantiate.
 
+config HUAWEI_LAPTOP
+	tristate "Huawei WMI hotkeys driver"
+	depends on ACPI
+	depends on ACPI_WMI
+	depends on INPUT
+	select INPUT_SPARSEKMAP
+	help
+	  This driver provides support for Huawei WMI hotkeys.
+	  It enables the missing keys and adds support to micmute
+	  led found on these laptops.q
+	  Supported devices are:
+	  - Matebook X Pro
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e6d1becf81ce..5984354e18ff 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ACERHDF)		+= acerhdf.o
 obj-$(CONFIG_HP_ACCEL)		+= hp_accel.o
 obj-$(CONFIG_HP_WIRELESS)	+= hp-wireless.o
 obj-$(CONFIG_HP_WMI)		+= hp-wmi.o
+obj-$(CONFIG_HUAWEI_LAPTOP)		+= huawei_wmi.o
 obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
 obj-$(CONFIG_GPD_POCKET_FAN)	+= gpd-pocket-fan.o
 obj-$(CONFIG_TC1100_WMI)	+= tc1100-wmi.o
diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
new file mode 100644
index 000000000000..83545217ac19
--- /dev/null
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Huawei WMI Hotkeys Driver
+ *
+ *  Copyright (C) 2018		  Ayman Bagabas <ayman.bagabas@gmail.com>
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+#include <linux/acpi.h>
+#include <linux/wmi.h>
+
+MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
+MODULE_DESCRIPTION("Huawei WMI hotkeys");
+MODULE_LICENSE("GPL");
+
+#define DEVICE_NAME "huawei"
+#define MODULE_NAME DEVICE_NAME"_wmi"
+
+/*
+ * Huawei WMI Devices GUIDs
+ */
+#define AMW0_GUID "ABBC0F5B-8EA1-11D1-A000-C90629100000" // \_SB.AMW0
+
+/*
+ * Huawei WMI Events GUIDs
+ */
+#define EVENT_GUID "ABBC0F5C-8EA1-11D1-A000-C90629100000"
+
+MODULE_ALIAS("wmi:"AMW0_GUID);
+MODULE_ALIAS("wmi:"EVENT_GUID);
+
+enum {
+	MICMUTE_LED_ON = 0x00010B04,
+	MICMUTE_LED_OFF = 0x00000B04,
+};
+
+static const struct key_entry huawei_wmi_keymap[] __initconst = {
+		{ KE_IGNORE, 0x281, { KEY_BRIGHTNESSDOWN } },
+		{ KE_IGNORE, 0x282, { KEY_BRIGHTNESSUP } },
+		{ KE_KEY,	0x287, { KEY_MICMUTE } },
+		{ KE_KEY,	0x289, { KEY_WLAN } },
+		// Huawei |M| button
+		{ KE_KEY,	0x28a, { KEY_PROG1 } },
+		{ KE_END,	0 }
+};
+
+struct huawei_wmi_device {
+	struct input_dev *inputdev;
+};
+static struct huawei_wmi_device *wmi_device;
+
+int huawei_wmi_micmute_led_set(bool on)
+{
+	u32 args = (on) ? MICMUTE_LED_ON : MICMUTE_LED_OFF;
+	struct acpi_buffer input = { (acpi_size)sizeof(args), &args };
+	acpi_status status;
+
+	status = wmi_evaluate_method(AMW0_GUID, 0, 1, &input, NULL);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(huawei_wmi_micmute_led_set);
+
+static void huawei_wmi_process_key(struct input_dev *input_dev, int code)
+{
+	const struct key_entry *key;
+
+	key = sparse_keymap_entry_from_scancode(input_dev, code);
+
+	if (!key) {
+		pr_info("%s: Unknown key pressed, code: 0x%04x\n",
+					MODULE_NAME, code);
+		return;
+	}
+
+	sparse_keymap_report_entry(input_dev, key, 1, true);
+}
+
+static void huawei_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (ACPI_FAILURE(status)) {
+		pr_err("%s: Bad event status 0x%x\n",
+					MODULE_NAME, status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_INTEGER)
+		huawei_wmi_process_key(wmi_device->inputdev,
+							obj->integer.value);
+	else
+		pr_info("%s: Unknown response received %d\n",
+					MODULE_NAME, obj->type);
+
+	kfree(response.pointer);
+}
+
+static int huawei_input_init(void)
+{
+	acpi_status status;
+	int err;
+
+	wmi_device->inputdev = input_allocate_device();
+	if (!wmi_device->inputdev)
+		return -ENOMEM;
+
+	wmi_device->inputdev->name = "Huawei WMI hotkeys";
+	wmi_device->inputdev->phys = "wmi/input0";
+	wmi_device->inputdev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(wmi_device->inputdev,
+			huawei_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	status = wmi_install_notify_handler(EVENT_GUID,
+			huawei_wmi_notify,
+			NULL);
+
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_free_dev;
+	}
+
+	err = input_register_device(wmi_device->inputdev);
+	if (err)
+		goto err_remove_notifier;
+
+	return 0;
+
+
+err_remove_notifier:
+	wmi_remove_notify_handler(EVENT_GUID);
+err_free_dev:
+	input_free_device(wmi_device->inputdev);
+	return err;
+}
+
+static void huawei_input_exit(void)
+{
+	wmi_remove_notify_handler(EVENT_GUID);
+	input_unregister_device(wmi_device->inputdev);
+}
+
+static int __init huawei_wmi_setup(void)
+{
+	int err;
+
+	wmi_device = kmalloc(sizeof(struct huawei_wmi_device), GFP_KERNEL);
+	if (!wmi_device)
+		return -ENOMEM;
+
+	err = huawei_input_init();
+	if (err)
+		goto err_input;
+
+	return 0;
+
+err_input:
+	return err;
+}
+
+static void huawei_wmi_destroy(void)
+{
+	huawei_input_exit();
+	kfree(wmi_device);
+}
+
+static int __init huawei_wmi_init(void)
+{
+	int err;
+
+	if (!wmi_has_guid(EVENT_GUID)) {
+		pr_warn("%s: No known WMI GUID found\n", MODULE_NAME);
+		return -ENODEV;
+	}
+
+	err = huawei_wmi_setup();
+	if (err) {
+		pr_err("%s: Failed to setup device\n", MODULE_NAME);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit huawei_wmi_exit(void)
+{
+	huawei_wmi_destroy();
+	pr_debug("%s: Driver unloaded successfully\n", MODULE_NAME);
+}
+
+module_init(huawei_wmi_init);
+module_exit(huawei_wmi_exit);
-- 
2.17.2

