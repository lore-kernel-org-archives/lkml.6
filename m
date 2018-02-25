Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168518-1519572340-2-6313680499532912363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519572339; b=ocR6RvwQt2pcdT6XRHXeVa/vZe/zWPSLmCBnlV90eGBNlS4
    c3taaKiV589h1NLUZLyS/a/pCWTECxTEvnnGBZY2GSJiSO1yotyC/SAXwkRqvan3
    KI3AWiTIgeEIW9pfzSm3CGocdzELVBe4bGfji39dHVokfq0Jfk5FxknncKqTmHmO
    WivxRvEqvCtoX9Ku+DON8ltlpOsG2thvZwV1MVQJEAcJGQwWm32mNodJQVHPwQzi
    eerC5vRXPqNEHE50uZZGjB3ausoM5mYFSIXlme2YxWO7KTu/py7Kb7MYSkYvQuBJ
    EQZ+zriT0rvqMAi1rZK/wFxEdO0iTLvx2Necjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572339;
    bh=lawsmZsCkXstxfuTM2bhIMMTztD6DPrZGME8OPQ7h2w=; b=f3r1l41iGTNP
    B1KnnyrxSWpFEqZTAj0zfMvrhUJzP1nBZO+JRYObUW6g20kiKHkw9aDDNkleACHq
    3YzwepPJYHrWRsIlUfHSqSUNEs0XLpNsF4A58YB9qmEOUBekhh3cWwR3zR/bzvFp
    YeIutDNxfi7mq24BXhcnS/Eeri/9aCrCp36TYqq5eHBHgMIzHk33CIc0PIU41rFG
    uQ4y0pxo5oFBjVSm8sFxTqENkQPDzTEILngcwwuttTcksXYG+pUDJfwHJI4z60eT
    0PE6xctDQTxoJFURwPyWE8OLtKK+lmCMbDf4AGgjgsUo0kH0kBpZVneYUA9KcS9n
    pRoNsDsvbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeBYPZh (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:25:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751880AbeBYPZf (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:35 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 12/12] extcon: axp288: Set USB role where necessary
Date: Sun, 25 Feb 2018 16:25:10 +0100
Message-Id: <20180225152510.10159-13-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The AXP288 BC1.2 charger detection / extcon code may seem like a strange
place to add code to control the USB role-switch on devices with an AXP288,
but there are 2 reasons to do this inside the axp288 extcon code:

1) On many devices the USB role is controlled by ACPI AML code, but the AML
   code only switches between the host and none roles, because of Windows
   not really using device mode. To make device mode work we need to toggle
   between the none/device roles based on Vbus presence, and the axp288
   extcon gets interrupts on Vbus insertion / removal.

2) In order for our BC1.2 charger detection to work properly the role
   mux must be properly set to device mode before we do the detection.

Also note the Kconfig help-text / obsolete depends on USB_PHY which are
remnants from older never upstreamed code also controlling the mux from
the axp288 extcon code.

This commit also adds code to get notifications from the INT3496 extcon
device, which is used on some devices to notify the kernel about id-pin
changes instead of them being handled through AML code.

This fixes:
-Device mode not working on most CHT devices with an AXP288
-Host mode not working on devices with an INT3496 ACPI device
-Charger-type misdetection (always SDP) on devices with an INT3496 when the
 USB role (always) gets initialized as host

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add depends on X86 to Kconfig (the AXP288 PMIC is only used on X86)
-Use new acpi_dev_get_first_match_name() helper to get the INT3496 device-name
-Add Heikki's Reviewed-by
---
 drivers/extcon/Kconfig         |   3 +-
 drivers/extcon/extcon-axp288.c | 177 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 171 insertions(+), 9 deletions(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index a7bca4207f44..de15bf55895b 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -30,7 +30,8 @@ config EXTCON_ARIZONA
 
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
-	depends on MFD_AXP20X && USB_PHY
+	depends on MFD_AXP20X && USB_SUPPORT && X86
+	select USB_ROLE_SWITCH
 	help
 	  Say Y here to enable support for USB peripheral detection
 	  and USB MUX switching by X-Power AXP288 PMIC.
diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
index 3ec4c715e240..51e77c7a32c2 100644
--- a/drivers/extcon/extcon-axp288.c
+++ b/drivers/extcon/extcon-axp288.c
@@ -1,6 +1,7 @@
 /*
  * extcon-axp288.c - X-Power AXP288 PMIC extcon cable detection driver
  *
+ * Copyright (c) 2017-2018 Hans de Goede <hdegoede@redhat.com>
  * Copyright (C) 2015 Intel Corporation
  * Author: Ramakrishna Pallala <ramakrishna.pallala@intel.com>
  *
@@ -14,6 +15,8 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
+#include <linux/connection.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
@@ -25,6 +28,11 @@
 #include <linux/extcon-provider.h>
 #include <linux/regmap.h>
 #include <linux/mfd/axp20x.h>
+#include <linux/usb/role.h>
+#include <linux/workqueue.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
 
 /* Power source status register */
 #define PS_STAT_VBUS_TRIGGER		BIT(0)
@@ -97,9 +105,19 @@ struct axp288_extcon_info {
 	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_irq_chip_data *regmap_irqc;
+	struct usb_role_switch *role_sw;
+	struct work_struct role_work;
 	int irq[EXTCON_IRQ_END];
 	struct extcon_dev *edev;
+	struct extcon_dev *id_extcon;
+	struct notifier_block id_nb;
 	unsigned int previous_cable;
+	bool vbus_attach;
+};
+
+static const struct x86_cpu_id cherry_trail_cpu_ids[] = {
+	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT, X86_FEATURE_ANY },
+	{}
 };
 
 /* Power up/down reason string array */
@@ -137,20 +155,74 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
 	regmap_write(info->regmap, AXP288_PS_BOOT_REASON_REG, clear_mask);
 }
 
-static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
+/*
+ * The below code to control the USB role-switch on devices with an AXP288
+ * may seem out of place, but there are 2 reasons why this is the best place
+ * to control the USB role-switch on such devices:
+ * 1) On many devices the USB role is controlled by AML code, but the AML code
+ *    only switches between the host and none roles, because of Windows not
+ *    really using device mode. To make device mode work we need to toggle
+ *    between the none/device roles based on Vbus presence, and this driver
+ *    gets interrupts on Vbus insertion / removal.
+ * 2) In order for our BC1.2 charger detection to work properly the role
+ *    mux must be properly set to device mode before we do the detection.
+ */
+
+/* Returns the id-pin value, note pulled low / false == host-mode */
+static bool axp288_get_id_pin(struct axp288_extcon_info *info)
 {
-	int ret, stat, cfg, pwr_stat;
-	u8 chrg_type;
-	unsigned int cable = info->previous_cable;
-	bool vbus_attach = false;
+	enum usb_role role;
+
+	if (info->id_extcon)
+		return extcon_get_state(info->id_extcon, EXTCON_USB_HOST) <= 0;
+
+	/* We cannot access the id-pin, see what mode the AML code has set */
+	role = usb_role_switch_get_role(info->role_sw);
+	return role != USB_ROLE_HOST;
+}
+
+static void axp288_usb_role_work(struct work_struct *work)
+{
+	struct axp288_extcon_info *info =
+		container_of(work, struct axp288_extcon_info, role_work);
+	enum usb_role role;
+	bool id_pin;
+	int ret;
+
+	id_pin = axp288_get_id_pin(info);
+	if (!id_pin)
+		role = USB_ROLE_HOST;
+	else if (info->vbus_attach)
+		role = USB_ROLE_DEVICE;
+	else
+		role = USB_ROLE_NONE;
+
+	ret = usb_role_switch_set_role(info->role_sw, role);
+	if (ret)
+		dev_err(info->dev, "failed to set role: %d\n", ret);
+}
+
+static bool axp288_get_vbus_attach(struct axp288_extcon_info *info)
+{
+	int ret, pwr_stat;
 
 	ret = regmap_read(info->regmap, AXP288_PS_STAT_REG, &pwr_stat);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to read vbus status\n");
-		return ret;
+		return false;
 	}
 
-	vbus_attach = (pwr_stat & PS_STAT_VBUS_VALID);
+	return !!(pwr_stat & PS_STAT_VBUS_VALID);
+}
+
+static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
+{
+	int ret, stat, cfg;
+	u8 chrg_type;
+	unsigned int cable = info->previous_cable;
+	bool vbus_attach = false;
+
+	vbus_attach = axp288_get_vbus_attach(info);
 	if (!vbus_attach)
 		goto no_vbus;
 
@@ -201,6 +273,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 		info->previous_cable = cable;
 	}
 
+	if (info->role_sw && info->vbus_attach != vbus_attach) {
+		info->vbus_attach = vbus_attach;
+		/* Setting the role can take a while */
+		queue_work(system_long_wq, &info->role_work);
+	}
+
 	return 0;
 
 dev_det_ret:
@@ -210,6 +288,18 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
 	return ret;
 }
 
+static int axp288_extcon_id_evt(struct notifier_block *nb,
+				unsigned long event, void *param)
+{
+	struct axp288_extcon_info *info =
+		container_of(nb, struct axp288_extcon_info, id_nb);
+
+	/* We may not sleep and setting the role can take a while */
+	queue_work(system_long_wq, &info->role_work);
+
+	return NOTIFY_OK;
+}
+
 static irqreturn_t axp288_extcon_isr(int irq, void *data)
 {
 	struct axp288_extcon_info *info = data;
@@ -231,10 +321,20 @@ static void axp288_extcon_enable(struct axp288_extcon_info *info)
 					BC_GLOBAL_RUN, BC_GLOBAL_RUN);
 }
 
+static void axp288_put_role_sw(void *data)
+{
+	struct axp288_extcon_info *info = data;
+
+	cancel_work_sync(&info->role_work);
+	usb_role_switch_put(info->role_sw);
+}
+
 static int axp288_extcon_probe(struct platform_device *pdev)
 {
 	struct axp288_extcon_info *info;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	const char *name;
 	int ret, i, pirq;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -245,9 +345,33 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 	info->regmap = axp20x->regmap;
 	info->regmap_irqc = axp20x->regmap_irqc;
 	info->previous_cable = EXTCON_NONE;
+	INIT_WORK(&info->role_work, axp288_usb_role_work);
+	info->id_nb.notifier_call = axp288_extcon_id_evt;
 
 	platform_set_drvdata(pdev, info);
 
+	info->role_sw = usb_role_switch_get(dev);
+	if (IS_ERR(info->role_sw))
+		return PTR_ERR(info->role_sw);
+	if (info->role_sw) {
+		ret = devm_add_action_or_reset(dev, axp288_put_role_sw, info);
+		if (ret)
+			return ret;
+
+		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
+		if (name) {
+			info->id_extcon = extcon_get_extcon_dev(name);
+			if (!info->id_extcon)
+				return -EPROBE_DEFER;
+
+			dev_info(dev, "controlling USB role\n");
+		} else {
+			dev_info(dev, "controlling USB role based on Vbus presence\n");
+		}
+	}
+
+	info->vbus_attach = axp288_get_vbus_attach(info);
+
 	axp288_extcon_log_rsi(info);
 
 	/* Initialize extcon device */
@@ -289,6 +413,19 @@ static int axp288_extcon_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (info->id_extcon) {
+		ret = devm_extcon_register_notifier_all(dev, info->id_extcon,
+							&info->id_nb);
+		if (ret)
+			return ret;
+	}
+
+	/* Make sure the role-sw is set correctly before doing BC detection */
+	if (info->role_sw) {
+		queue_work(system_long_wq, &info->role_work);
+		flush_work(&info->role_work);
+	}
+
 	/* Start charger cable type detection */
 	axp288_extcon_enable(info);
 
@@ -308,8 +445,32 @@ static struct platform_driver axp288_extcon_driver = {
 		.name = "axp288_extcon",
 	},
 };
-module_platform_driver(axp288_extcon_driver);
+
+static struct devcon axp288_extcon_role_sw_conn = {
+	.endpoint[0] = "axp288_extcon",
+	.endpoint[1] = "intel_xhci_usb_sw-role-switch",
+	.id = "usb-role-switch",
+};
+
+static int __init axp288_extcon_init(void)
+{
+	if (x86_match_cpu(cherry_trail_cpu_ids))
+		add_device_connection(&axp288_extcon_role_sw_conn);
+
+	return platform_driver_register(&axp288_extcon_driver);
+}
+module_init(axp288_extcon_init);
+
+static void __exit axp288_extcon_exit(void)
+{
+	if (x86_match_cpu(cherry_trail_cpu_ids))
+		remove_device_connection(&axp288_extcon_role_sw_conn);
+
+	platform_driver_unregister(&axp288_extcon_driver);
+}
+module_exit(axp288_extcon_exit);
 
 MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("X-Powers AXP288 extcon driver");
 MODULE_LICENSE("GPL v2");
-- 
2.14.3

