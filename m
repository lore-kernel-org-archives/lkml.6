Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1258868-1519986137-2-8319398897434153618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519986136; b=HEF1Qs+NGCiUU65eeNhZZECh2i1b9M+F4ms2KmQKexlqZ0i
    1xvv0JTCvgbLdJ62PN+f8T/OlWUpmkUj3anJsvrl68DH7rptD6L3lMwivjCPk0U4
    un1YW33ZR3UyG4E1RG+u6mf+kdK9yo9kCwWj5mRrvZeb7LQP/d9jgnKwtKjHJ0zf
    T/C0BJUEidskb21YTWrnY+FyX/u6cTBW2H9zyFVtc0Xgaqn4Z0K3v1pT9tK4XepK
    66MVumF3UWu9wsfWKsylBEZK2yHS4MeaOX5t+hqQ46deGRC6HgRfhjI7pXaMxsev
    IOnWs8SbH+8LwcM2K8BCPnvOXA/2qjhR5J3Woqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519986136;
    bh=hlZZt/Ceuc41LZJVZz8IkzjCthKN4NrjV6ahfDLCWo8=; b=NlLYqxGLtm1e
    S7nlhBIzxXQr0QGLebcHuSzQenXqKs39HHzXAnmiSKujS/zn21UIH57pov31UJIC
    yBpApycjkESbaPyWWlmay+GngT0S2J242l9dSXgtidsHkZvx3oOA+Glhqczg2Sju
    lyuf0FZG6s95a7J2fRuj2WwKhW3eUE/No7AF2jEUlhNaqnlgEDVwXlGmArvOmzWV
    x7kgaa1FZp5xODU7jaQOX8iUjBj43E89kTvIyoaZAuUUOB/5yaz4vNng84IpuN5Z
    +6AsA0cP/VBCmuflVyLxPxtWSZXQRIKTz1yJfR6e6fiHF6vlh6GVl2wd/AXlb6hy
    pdK6AEF6XQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946001AbeCBKWM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 05:22:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426333AbeCBKVT (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 2 Mar 2018 05:21:19 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v6 09/12] usb: roles: Add Intel xHCI USB role switch driver
Date: Fri,  2 Mar 2018 11:20:54 +0100
Message-Id: <20180302102057.8917-10-hdegoede@redhat.com>
In-Reply-To: <20180302102057.8917-1-hdegoede@redhat.com>
References: <20180302102057.8917-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Various Intel SoCs (Cherry Trail, Broxton and others) have an internal USB
role switch for swiching the OTG USB data lines between the xHCI host
controller and the dwc3 gadget controller.

Note on some Cherry Trail systems there is ACPI/AML code listening to
edge interrupts on the id-pin (through an _AIE ACPI method) and switching
the role between ROLE_HOST and ROLE_NONE based on the id-pin. Note it does
not set the role to ROLE_DEVICE, because device-mode is usually not used
under Windows.

The presence of AML code which modifies the cfg0 reg (on some systems)
means that our read/write/modify of cfg0 may race with the AML code
doing the same to avoid this we take the global ACPI lock while doing
the read/write/modify.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
-Add Andy's Reviewed-by
-Add Heikki's Reviewed-by

Changes in v2:
-Drop unnecessary depends on EXTCON from Kconfig
-Use BIT(), resource_size()
-Various other small style fixes
---
 MAINTAINERS                                    |   6 +
 drivers/usb/Kconfig                            |   2 +
 drivers/usb/Makefile                           |   2 +
 drivers/usb/roles/Kconfig                      |  14 ++
 drivers/usb/roles/Makefile                     |   1 +
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 192 +++++++++++++++++++++++++
 6 files changed, 217 insertions(+)
 create mode 100644 drivers/usb/roles/Kconfig
 create mode 100644 drivers/usb/roles/Makefile
 create mode 100644 drivers/usb/roles/intel-xhci-usb-role-switch.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ac4d5471af43..0a18231fde06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14393,6 +14393,12 @@ S:	Maintained
 F:	Documentation/hid/hiddev.txt
 F:	drivers/hid/usbhid/
 
+USB INTEL XHCI ROLE MUX DRIVER
+M:	Hans de Goede <hdegoede@redhat.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/roles/intel-xhci-usb-role-switch.c
+
 USB ISP116X DRIVER
 M:	Olav Kongas <ok@artecdesign.ee>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index f278958e04ca..75f7fb151f71 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -171,6 +171,8 @@ source "drivers/usb/gadget/Kconfig"
 
 source "drivers/usb/typec/Kconfig"
 
+source "drivers/usb/roles/Kconfig"
+
 config USB_LED_TRIG
 	bool "USB LED Triggers"
 	depends on LEDS_CLASS && LEDS_TRIGGERS
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 060643a1b5c8..7d1b8c82b208 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -65,3 +65,5 @@ obj-$(CONFIG_USB_COMMON)	+= common/
 obj-$(CONFIG_USBIP_CORE)	+= usbip/
 
 obj-$(CONFIG_TYPEC)		+= typec/
+
+obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles/
diff --git a/drivers/usb/roles/Kconfig b/drivers/usb/roles/Kconfig
new file mode 100644
index 000000000000..f5a5e6f79f1b
--- /dev/null
+++ b/drivers/usb/roles/Kconfig
@@ -0,0 +1,14 @@
+if USB_ROLE_SWITCH
+
+config USB_ROLES_INTEL_XHCI
+	tristate "Intel XHCI USB Role Switch"
+	depends on ACPI && X86
+	help
+	  Driver for the internal USB role switch for switching the USB data
+	  lines between the xHCI host controller and the dwc3 gadget controller
+	  found on various Intel SoCs.
+
+	  To compile the driver as a module, choose M here: the module will
+	  be called intel-xhci-usb-role-switch.
+
+endif # USB_ROLE_SWITCH
diff --git a/drivers/usb/roles/Makefile b/drivers/usb/roles/Makefile
new file mode 100644
index 000000000000..e44b179ba275
--- /dev/null
+++ b/drivers/usb/roles/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_USB_ROLES_INTEL_XHCI) += intel-xhci-usb-role-switch.o
diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
new file mode 100644
index 000000000000..3d7be5eace49
--- /dev/null
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Intel XHCI (Cherry Trail, Broxton and others) USB OTG role switch driver
+ *
+ * Copyright (c) 2016-2017 Hans de Goede <hdegoede@redhat.com>
+ *
+ * Loosely based on android x86 kernel code which is:
+ *
+ * Copyright (C) 2014 Intel Corp.
+ *
+ * Author: Wu, Hao
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/usb/role.h>
+
+/* register definition */
+#define DUAL_ROLE_CFG0			0x68
+#define SW_VBUS_VALID			BIT(24)
+#define SW_IDPIN_EN			BIT(21)
+#define SW_IDPIN			BIT(20)
+
+#define DUAL_ROLE_CFG1			0x6c
+#define HOST_MODE			BIT(29)
+
+#define DUAL_ROLE_CFG1_POLL_TIMEOUT	1000
+
+#define DRV_NAME			"intel_xhci_usb_sw"
+
+struct intel_xhci_usb_data {
+	struct usb_role_switch *role_sw;
+	void __iomem *base;
+};
+
+struct intel_xhci_acpi_match {
+	const char *hid;
+	int hrv;
+};
+
+/*
+ * ACPI IDs for PMICs which do not support separate data and power role
+ * detection (USB ACA detection for micro USB OTG), we allow userspace to
+ * change the role manually on these.
+ */
+static const struct intel_xhci_acpi_match allow_userspace_ctrl_ids[] = {
+	{ "INT33F4",  3 }, /* X-Powers AXP288 PMIC */
+};
+
+static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
+{
+	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
+	unsigned long timeout;
+	acpi_status status;
+	u32 glk, val;
+
+	/*
+	 * On many CHT devices ACPI event (_AEI) handlers read / modify /
+	 * write the cfg0 register, just like we do. Take the ACPI lock
+	 * to avoid us racing with the AML code.
+	 */
+	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
+	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
+		dev_err(dev, "Error could not acquire lock\n");
+		return -EIO;
+	}
+
+	/* Set idpin value as requested */
+	val = readl(data->base + DUAL_ROLE_CFG0);
+	switch (role) {
+	case USB_ROLE_NONE:
+		val |= SW_IDPIN;
+		val &= ~SW_VBUS_VALID;
+		break;
+	case USB_ROLE_HOST:
+		val &= ~SW_IDPIN;
+		val &= ~SW_VBUS_VALID;
+		break;
+	case USB_ROLE_DEVICE:
+		val |= SW_IDPIN;
+		val |= SW_VBUS_VALID;
+		break;
+	}
+	val |= SW_IDPIN_EN;
+
+	writel(val, data->base + DUAL_ROLE_CFG0);
+
+	acpi_release_global_lock(glk);
+
+	/* In most case it takes about 600ms to finish mode switching */
+	timeout = jiffies + msecs_to_jiffies(DUAL_ROLE_CFG1_POLL_TIMEOUT);
+
+	/* Polling on CFG1 register to confirm mode switch.*/
+	do {
+		val = readl(data->base + DUAL_ROLE_CFG1);
+		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST))
+			return 0;
+
+		/* Interval for polling is set to about 5 - 10 ms */
+		usleep_range(5000, 10000);
+	} while (time_before(jiffies, timeout));
+
+	dev_warn(dev, "Timeout waiting for role-switch\n");
+	return -ETIMEDOUT;
+}
+
+static enum usb_role intel_xhci_usb_get_role(struct device *dev)
+{
+	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
+	enum usb_role role;
+	u32 val;
+
+	val = readl(data->base + DUAL_ROLE_CFG0);
+
+	if (!(val & SW_IDPIN))
+		role = USB_ROLE_HOST;
+	else if (val & SW_VBUS_VALID)
+		role = USB_ROLE_DEVICE;
+	else
+		role = USB_ROLE_NONE;
+
+	return role;
+}
+
+static struct usb_role_switch_desc sw_desc = {
+	.set = intel_xhci_usb_set_role,
+	.get = intel_xhci_usb_get_role,
+};
+
+static int intel_xhci_usb_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct intel_xhci_usb_data *data;
+	struct resource *res;
+	int i;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	for (i = 0; i < ARRAY_SIZE(allow_userspace_ctrl_ids); i++)
+		if (acpi_dev_present(allow_userspace_ctrl_ids[i].hid, "1",
+				     allow_userspace_ctrl_ids[i].hrv))
+			sw_desc.allow_userspace_control = true;
+
+	platform_set_drvdata(pdev, data);
+
+	data->role_sw = usb_role_switch_register(dev, &sw_desc);
+	if (IS_ERR(data->role_sw))
+		return PTR_ERR(data->role_sw);
+
+	return 0;
+}
+
+int intel_xhci_usb_remove(struct platform_device *pdev)
+{
+	struct intel_xhci_usb_data *data = platform_get_drvdata(pdev);
+
+	usb_role_switch_unregister(data->role_sw);
+	return 0;
+}
+
+static const struct platform_device_id intel_xhci_usb_table[] = {
+	{ .name = DRV_NAME },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, intel_xhci_usb_table);
+
+static struct platform_driver intel_xhci_usb_driver = {
+	.driver = {
+		.name = DRV_NAME,
+	},
+	.id_table = intel_xhci_usb_table,
+	.probe = intel_xhci_usb_probe,
+	.remove = intel_xhci_usb_remove,
+};
+
+module_platform_driver(intel_xhci_usb_driver);
+
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_DESCRIPTION("Intel XHCI USB role switch driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3

