Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-515744-1520865345-2-7381896758077431119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520865344; b=HebuOPafFM74WlyRcXrgP/K/h6zvfzdMnq9sIXms6vE8kwK
    ObQD2ex9NXZhXLVfHzy+u9XgjEWKYGCJea3MSvbNXOJhFc+D4g/TlSpSH0WOG8Bt
    A9up9C/10GTcohJH1D3Y1uTB2j4tZS2Z5Rcm1bAO+ZbPB4DYtu4l/AwWZkBRhVm8
    rM6OERrWIxXf0nhIWmw1YLvRmEaQ8dZXBBqDY/yUoMeeF2TIECDxuGRQnu8frgWP
    VB9ehbTbU6TNzYz5kivSW59j/8B8fyUbwhLmZI9K1/KIfHXtTGfwnWCjsayYdT2r
    WFlYdmzh4IqfWGAY122RJURie0YwXUEzjlUmNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1520865344;
    bh=Pk5GLNhGT0Aqd4m5LOxwSp8JlYLeWSn38xAd/VwuIgs=; b=wQL/Q0g+Whx3
    7oxaqHLLfFgOHOHHhc36Xt1CW1TbCxlfhkZSVpMiAkdG9yOeb0Xcm8/HD+77bjj/
    ZFTz6+i36xpwc1o4rjJyMdex1xMbG+jrUa8OMWtb5uP1lJneP3pNpxThuzHGv1N4
    Ob3pw07dsE8szQOP+Y4l3YiZvpqbntCNwgSZJteLsmQ9Wo6i/qW+EpSbctSG/S1U
    BpTXCzyUVWb7OIiiDzKBJtCGwsjkfgvLZfK/AMPoknzQ2cNu8ayO2hhAGsphjaKD
    K3PO4wUqcvmlQuBfDIyofDXzkEMg2V7Miqsa3fz3KxuwzQtzgzAcL8qD9GzLIdjv
    goA1Jr42Eg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
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
        id S932433AbeCLOfb (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 10:35:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:22085 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752250AbeCLOfR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 12 Mar 2018 10:35:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="37471122"
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
Subject: [PATCH v7 12/12] extcon: axp288: Set USB role where necessary
Date: Mon, 12 Mar 2018 17:34:31 +0300
Message-Id: <20180312143431.82396-13-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
References: <20180312143431.82396-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v2:
-Add depends on X86 to Kconfig (the AXP288 PMIC is only used on X86)
-Use new acpi_dev_get_first_match_name() helper to get the INT3496 device-name
-Add Heikki's Reviewed-by
---
 drivers/extcon/Kconfig         |   3 +-
 drivers/extcon/extcon-axp288.c | 176 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 170 insertions(+), 9 deletions(-)

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
index 3ec4c715e240..a983708b77a6 100644
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
@@ -14,6 +15,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
@@ -25,6 +27,11 @@
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
@@ -97,9 +104,19 @@ struct axp288_extcon_info {
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
@@ -137,20 +154,74 @@ static void axp288_extcon_log_rsi(struct axp288_extcon_info *info)
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
 
@@ -201,6 +272,12 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
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
@@ -210,6 +287,18 @@ static int axp288_handle_chrg_det_event(struct axp288_extcon_info *info)
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
@@ -231,10 +320,20 @@ static void axp288_extcon_enable(struct axp288_extcon_info *info)
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
@@ -245,9 +344,33 @@ static int axp288_extcon_probe(struct platform_device *pdev)
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
@@ -289,6 +412,19 @@ static int axp288_extcon_probe(struct platform_device *pdev)
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
 
@@ -308,8 +444,32 @@ static struct platform_driver axp288_extcon_driver = {
 		.name = "axp288_extcon",
 	},
 };
-module_platform_driver(axp288_extcon_driver);
+
+static struct device_connection axp288_extcon_role_sw_conn = {
+	.endpoint[0] = "axp288_extcon",
+	.endpoint[1] = "intel_xhci_usb_sw-role-switch",
+	.id = "usb-role-switch",
+};
+
+static int __init axp288_extcon_init(void)
+{
+	if (x86_match_cpu(cherry_trail_cpu_ids))
+		device_connection_add(&axp288_extcon_role_sw_conn);
+
+	return platform_driver_register(&axp288_extcon_driver);
+}
+module_init(axp288_extcon_init);
+
+static void __exit axp288_extcon_exit(void)
+{
+	if (x86_match_cpu(cherry_trail_cpu_ids))
+		device_connection_remove(&axp288_extcon_role_sw_conn);
+
+	platform_driver_unregister(&axp288_extcon_driver);
+}
+module_exit(axp288_extcon_exit);
 
 MODULE_AUTHOR("Ramakrishna Pallala <ramakrishna.pallala@intel.com>");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("X-Powers AXP288 extcon driver");
 MODULE_LICENSE("GPL v2");
-- 
2.16.1

