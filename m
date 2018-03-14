Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1734499-1521033161-2-8356604111779842898
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
    t=1521033160; b=le2AqP7GaC3fCFvOWQlASWBShSzK5vbw8uf2VCjIpluDR2+
    3Tf+7egR2/z2kjgvJrM8mREmKj7c9w2rg4mvnoF7lumFCQ5APCihRd5DDdOZkT/e
    zxEKST+9izqr1i9o0hp/1XoqZMOQHECHDFAAZ8hkeDfwJm/v/bHHsna5hyvAybP9
    rTAWANdk0PcKf9hRH0vLp2LgNX1ItQuAINOnlL17KfRzFH6BUTVruEc3sJJMAoZm
    hEIBqMoGezT1ny7+CGRpIDHSQu1IXml6av8HUenGzhDo6Rkuzhj5HC54AeKf3Hp3
    ARBo62Db/98s+UUB17mpCjjzkaKzFGNJcqfHalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521033160;
    bh=ExY/x6loDTqHpcZDlCFYgjjYV2tw9T1XUnvKBvkSnO0=; b=QWNMlQrbLdOU
    WXofMc74m8a42+9JOXxRGcDcAdRtkeh25moCdKNX4BFJLasBx8j/w92boXS9sOZx
    zbEw7iumjbE1mepQokdIwawR+/hFeVgYBCGQJIhC7aRsEiwHqAsbXQ4oOosbEg/4
    iQRCGwtP67UMl2Gz47UviVcpjh4Z1v17RNs1mwjEYA1cBoRIKAGUlSXsmuYWWIQq
    JHkQbBdz9VvTOXErV5NnYLKcsLd303XCKMY9a99VMNeHRH4WapzJgwvCaq1aa8Y8
    32eKJZcIb8kU0SZyjnyWgRCzV5KE63jd/DQxXYHKeLN3J6N8CWPG+vETQt1HLth6
    Qv0/jeUGFQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
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
        id S1752164AbeCNNMi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:12:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:3923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeCNNMd (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991626"
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
Subject: [PATCH v8 03/12] usb: common: Small class for USB role switches
Date: Wed, 14 Mar 2018 16:12:06 +0300
Message-Id: <20180314131215.70833-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB role switch is a device that can be used to choose the
data role for USB connector. With dual-role capable USB
controllers, the controller itself will be the switch, but
on some platforms the USB host and device controllers are
separate IPs and there is a mux between them and the
connector. On those platforms the mux driver will need to
register the switch.

With USB Type-C connectors, the host-to-device relationship
is negotiated over the Configuration Channel (CC). That
means the USB Type-C drivers need to be in control of the
role switch. The class provides a simple API for the USB
Type-C drivers for the control.

For other types of USB connectors (mainly microAB) the class
provides user space control via sysfs attribute file that
can be used to request role swapping from the switch.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Consistently use IS_ERR_OR_NULL where applicable
-Add Andy's Reviewed-by

Changes in v2:
-Minor style fixes from review of v1
---
 Documentation/ABI/testing/sysfs-class-usb_role |  21 ++
 drivers/usb/Kconfig                            |   3 +
 drivers/usb/common/Makefile                    |   1 +
 drivers/usb/common/roles.c                     | 305 +++++++++++++++++++++++++
 include/linux/usb/role.h                       |  53 +++++
 5 files changed, 383 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
 create mode 100644 drivers/usb/common/roles.c
 create mode 100644 include/linux/usb/role.h

diff --git a/Documentation/ABI/testing/sysfs-class-usb_role b/Documentation/ABI/testing/sysfs-class-usb_role
new file mode 100644
index 000000000000..3b810a425a52
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-usb_role
@@ -0,0 +1,21 @@
+What:		/sys/class/usb_role/
+Date:		Jan 2018
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Place in sysfs for USB Role Switches. USB Role Switch is a
+		device that can select the data role (host or device) for USB
+		port.
+
+What:		/sys/class/usb_role/<switch>/role
+Date:		Jan 2018
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The current role of the switch. This attribute can be used for
+		requesting role swapping with non-USB Type-C ports. With USB
+		Type-C ports, the ABI defined for USB Type-C connector class
+		must be used.
+
+		Valid values:
+		- none
+		- host
+		- device
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 148f3ee70286..f278958e04ca 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -203,4 +203,7 @@ config USB_ULPI_BUS
 	  To compile this driver as a module, choose M here: the module will
 	  be called ulpi.
 
+config USB_ROLE_SWITCH
+	tristate
+
 endif # USB_SUPPORT
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 0a7c45e85481..fb4d5ef4165c 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -9,3 +9,4 @@ usb-common-$(CONFIG_USB_LED_TRIG) += led.o
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
 obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
+obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles.o
diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
new file mode 100644
index 000000000000..15cc76e22123
--- /dev/null
+++ b/drivers/usb/common/roles.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Role Switch Support
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ *         Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/usb/role.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+static struct class *role_class;
+
+struct usb_role_switch {
+	struct device dev;
+	struct mutex lock; /* device lock*/
+	enum usb_role role;
+
+	/* From descriptor */
+	struct device *usb2_port;
+	struct device *usb3_port;
+	struct device *udc;
+	usb_role_switch_set_t set;
+	usb_role_switch_get_t get;
+	bool allow_userspace_control;
+};
+
+#define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
+
+/**
+ * usb_role_switch_set_role - Set USB role for a switch
+ * @sw: USB role switch
+ * @role: USB role to be switched to
+ *
+ * Set USB role @role for @sw.
+ */
+int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(sw))
+		return 0;
+
+	mutex_lock(&sw->lock);
+
+	ret = sw->set(sw->dev.parent, role);
+	if (!ret)
+		sw->role = role;
+
+	mutex_unlock(&sw->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
+
+/**
+ * usb_role_switch_get_role - Get the USB role for a switch
+ * @sw: USB role switch
+ *
+ * Depending on the role-switch-driver this function returns either a cached
+ * value of the last set role, or reads back the actual value from the hardware.
+ */
+enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
+{
+	enum usb_role role;
+
+	if (IS_ERR_OR_NULL(sw))
+		return USB_ROLE_NONE;
+
+	mutex_lock(&sw->lock);
+
+	if (sw->get)
+		role = sw->get(sw->dev.parent);
+	else
+		role = sw->role;
+
+	mutex_unlock(&sw->lock);
+
+	return role;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
+
+static int __switch_match(struct device *dev, const void *name)
+{
+	return !strcmp((const char *)name, dev_name(dev));
+}
+
+static void *usb_role_switch_match(struct device_connection *con, int ep,
+				   void *data)
+{
+	struct device *dev;
+
+	dev = class_find_device(role_class, NULL, con->endpoint[ep],
+				__switch_match);
+
+	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * usb_role_switch_get - Find USB role switch linked with the caller
+ * @dev: The caller device
+ *
+ * Finds and returns role switch linked with @dev. The reference count for the
+ * found switch is incremented.
+ */
+struct usb_role_switch *usb_role_switch_get(struct device *dev)
+{
+	return device_connection_find_match(dev, "usb-role-switch", NULL,
+					    usb_role_switch_match);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_get);
+
+/**
+ * usb_role_switch_put - Release handle to a switch
+ * @sw: USB Role Switch
+ *
+ * Decrement reference count for @sw.
+ */
+void usb_role_switch_put(struct usb_role_switch *sw)
+{
+	if (!IS_ERR_OR_NULL(sw))
+		put_device(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_put);
+
+static umode_t
+usb_role_switch_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct usb_role_switch *sw = to_role_switch(dev);
+
+	if (sw->allow_userspace_control)
+		return attr->mode;
+
+	return 0;
+}
+
+static const char * const usb_roles[] = {
+	[USB_ROLE_NONE]		= "none",
+	[USB_ROLE_HOST]		= "host",
+	[USB_ROLE_DEVICE]	= "device",
+};
+
+static ssize_t
+role_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+	enum usb_role role = usb_role_switch_get_role(sw);
+
+	return sprintf(buf, "%s\n", usb_roles[role]);
+}
+
+static ssize_t role_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+	int ret;
+
+	ret = sysfs_match_string(usb_roles, buf);
+	if (ret < 0) {
+		bool res;
+
+		/* Extra check if the user wants to disable the switch */
+		ret = kstrtobool(buf, &res);
+		if (ret || res)
+			return -EINVAL;
+	}
+
+	ret = usb_role_switch_set_role(sw, ret);
+	if (ret)
+		return ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(role);
+
+static struct attribute *usb_role_switch_attrs[] = {
+	&dev_attr_role.attr,
+	NULL,
+};
+
+static const struct attribute_group usb_role_switch_group = {
+	.is_visible = usb_role_switch_is_visible,
+	.attrs = usb_role_switch_attrs,
+};
+
+static const struct attribute_group *usb_role_switch_groups[] = {
+	&usb_role_switch_group,
+	NULL,
+};
+
+static int
+usb_role_switch_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = add_uevent_var(env, "USB_ROLE_SWITCH=%s", dev_name(dev));
+	if (ret)
+		dev_err(dev, "failed to add uevent USB_ROLE_SWITCH\n");
+
+	return ret;
+}
+
+static void usb_role_switch_release(struct device *dev)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+
+	kfree(sw);
+}
+
+static const struct device_type usb_role_dev_type = {
+	.name = "usb_role_switch",
+	.groups = usb_role_switch_groups,
+	.uevent = usb_role_switch_uevent,
+	.release = usb_role_switch_release,
+};
+
+/**
+ * usb_role_switch_register - Register USB Role Switch
+ * @parent: Parent device for the switch
+ * @desc: Description of the switch
+ *
+ * USB Role Switch is a device capable or choosing the role for USB connector.
+ * On platforms where the USB controller is dual-role capable, the controller
+ * driver will need to register the switch. On platforms where the USB host and
+ * USB device controllers behind the connector are separate, there will be a
+ * mux, and the driver for that mux will need to register the switch.
+ *
+ * Returns handle to a new role switch or ERR_PTR. The content of @desc is
+ * copied.
+ */
+struct usb_role_switch *
+usb_role_switch_register(struct device *parent,
+			 const struct usb_role_switch_desc *desc)
+{
+	struct usb_role_switch *sw;
+	int ret;
+
+	if (!desc || !desc->set)
+		return ERR_PTR(-EINVAL);
+
+	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&sw->lock);
+
+	sw->allow_userspace_control = desc->allow_userspace_control;
+	sw->usb2_port = desc->usb2_port;
+	sw->usb3_port = desc->usb3_port;
+	sw->udc = desc->udc;
+	sw->set = desc->set;
+	sw->get = desc->get;
+
+	sw->dev.parent = parent;
+	sw->dev.class = role_class;
+	sw->dev.type = &usb_role_dev_type;
+	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
+
+	ret = device_register(&sw->dev);
+	if (ret) {
+		put_device(&sw->dev);
+		return ERR_PTR(ret);
+	}
+
+	/* TODO: Symlinks for the host port and the device controller. */
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_register);
+
+/**
+ * usb_role_switch_unregister - Unregsiter USB Role Switch
+ * @sw: USB Role Switch
+ *
+ * Unregister switch that was registered with usb_role_switch_register().
+ */
+void usb_role_switch_unregister(struct usb_role_switch *sw)
+{
+	if (!IS_ERR_OR_NULL(sw))
+		device_unregister(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
+
+static int __init usb_roles_init(void)
+{
+	role_class = class_create(THIS_MODULE, "usb_role");
+	return PTR_ERR_OR_ZERO(role_class);
+}
+subsys_initcall(usb_roles_init);
+
+static void __exit usb_roles_exit(void)
+{
+	class_destroy(role_class);
+}
+module_exit(usb_roles_exit);
+
+MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("USB Role Class");
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
new file mode 100644
index 000000000000..edc51be4a77c
--- /dev/null
+++ b/include/linux/usb/role.h
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __LINUX_USB_ROLE_H
+#define __LINUX_USB_ROLE_H
+
+#include <linux/device.h>
+
+struct usb_role_switch;
+
+enum usb_role {
+	USB_ROLE_NONE,
+	USB_ROLE_HOST,
+	USB_ROLE_DEVICE,
+};
+
+typedef int (*usb_role_switch_set_t)(struct device *dev, enum usb_role role);
+typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
+
+/**
+ * struct usb_role_switch_desc - USB Role Switch Descriptor
+ * @usb2_port: Optional reference to the host controller port device (USB2)
+ * @usb3_port: Optional reference to the host controller port device (USB3)
+ * @udc: Optional reference to the peripheral controller device
+ * @set: Callback for setting the role
+ * @get: Callback for getting the role (optional)
+ * @allow_userspace_control: If true userspace may change the role through sysfs
+ *
+ * @usb2_port and @usb3_port will point to the USB host port and @udc to the USB
+ * device controller behind the USB connector with the role switch. If
+ * @usb2_port, @usb3_port and @udc are included in the description, the
+ * reference count for them should be incremented by the caller of
+ * usb_role_switch_register() before registering the switch.
+ */
+struct usb_role_switch_desc {
+	struct device *usb2_port;
+	struct device *usb3_port;
+	struct device *udc;
+	usb_role_switch_set_t set;
+	usb_role_switch_get_t get;
+	bool allow_userspace_control;
+};
+
+int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
+enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
+struct usb_role_switch *usb_role_switch_get(struct device *dev);
+void usb_role_switch_put(struct usb_role_switch *sw);
+
+struct usb_role_switch *
+usb_role_switch_register(struct device *parent,
+			 const struct usb_role_switch_desc *desc);
+void usb_role_switch_unregister(struct usb_role_switch *sw);
+
+#endif /* __LINUX_USB_ROLE_H */
-- 
2.16.1

