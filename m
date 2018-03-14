Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1743198-1521033183-2-9638623585123427812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521033180; b=PEqAvgkxsgvaL2A+/dosfclR+u+iZH35tcfPXNULyyB+Dgj
    m56u8zHN8fPlR61buXl2bwMjZS0MplpIUI4fnXVRIvkx+5SL3MxNYKLPy2VR6M+Q
    EHHOY6qc57R6tut6FG/OLTaHyBzODYeJfC9Ay6mQjMmFWPjagLUDB904RyUmwcD4
    rDmhqgH/mLZK9Lzvpy07Bh6RJytpC5dCD6tMft/mhVXaVoQfUkR8Oz3GklF/6YG1
    8tGO6CiM8xzm17RzyFFclnmg5ate4Fd/xMhucQHnXFdgwi8tCCjZ6fuAemfdz2zS
    7ffLMVVaWBrPDLnaIxZEsA9ZzhL+wCKhLmWXJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521033180;
    bh=gQC3Kev/swrZP4yLaZPcSwmOK5wo7u8XUJ+MPuOUjTo=; b=nfi0QgJlc3fE
    XKOs06jFLCsFmOUMRfUugdedpX5U5vu3ESvegpjmOftW7Ue3BahKe/pswmYi7aiC
    +96QMGlqKS9z1BWKJdQt0GSt26UFVP2b5+alRbSKxoiYDw5EaKOGxMNCf+LoPfCZ
    iay+2mEh2mytFXuhfihBjYAtIG5AznM/f321EmED/LFp3Gx4P41x+fig2sMt/7px
    03q8CoOjB+6hpVU3VltsLmo3D0W+UTCOOWLWMf3Ybfha9WKpXvC/oLX58Qp7Mg9b
    wwHI0z+4mFW2jg/2voVGAeAH0OfeF50PeWcsyC+xWE2k3r2gMy6nrgbIGGcIpBuK
    W33MkQoRcw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeCNNMz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:12:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:3923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752340AbeCNNMx (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991716"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v8 09/12] usb: roles: Add Intel xHCI USB role switch driver
Date: Wed, 14 Mar 2018 16:12:12 +0300
Message-Id: <20180314131215.70833-10-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v7:
- Declare intel_xhci_usb_remove() as static

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
index 93a12af4f180..5f1988cddbe8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14385,6 +14385,12 @@ S:	Maintained
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
index 000000000000..58c1b60a33c1
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
+static int intel_xhci_usb_remove(struct platform_device *pdev)
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
2.16.1

