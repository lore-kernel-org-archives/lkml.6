Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A97BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5B12089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865485;
	bh=oOPp1sMmtXsMjLtc7RpP0csua0OPEwzfNvNv365vAIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eIRs/UwvT787DLt3IwoL2mcPaWOeFGQ93bpUONB90p/F6WIk8EMM/+CBc42YfgnjQ
	 EWyRniQJ2LLBI+ROGVQUow3mEbiGJfQ8iUyInhZFuQxbQlIJ8j8hmLXtIOTSpT3QeN
	 a+de09XHhj37p2GSjsbGWZ7SAY1g/3QNUPbx6J+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfAGMvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:51:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728591AbfAGMvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:51:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 889A920651;
        Mon,  7 Jan 2019 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865479;
        bh=oOPp1sMmtXsMjLtc7RpP0csua0OPEwzfNvNv365vAIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=biASztiC0rZJjQ7GGb8VP0sIM6pHeVeb26/wSQpTgL3yq70PuX+DLbSpscPy59AO8
         M2Jwmu1HzXKyx95pDmWR9zYT4QyHKzd5c0OowRL+i8GxbqYBK/7CnoK90vvkctlOXw
         bzGbRPqPBBnaGfM8JEbTNJOt6maX1/yIAUbD3BDM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 082/170] usb: roles: Add a description for the class to Kconfig
Date:   Mon,  7 Jan 2019 13:31:49 +0100
Message-Id: <20190107104502.734276773@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit c3788cd9963eb2e77de3c24142fb7c67b61f1a26 upstream.

That makes the USB role switch support option visible and
selectable for the user. The class driver is also moved to
drivers/usb/roles/ directory.

This will fix an issue that we have with the Intel USB role
switch driver on systems that don't have USB Type-C connectors:

Intel USB role switch driver depends on the USB role switch
class as it should, but since there was no way for the user
to enable the USB role switch class, there was also no way
to select that driver. USB Type-C drivers select the USB
role switch class which makes the Intel USB role switch
driver available and therefore hides the problem.

So in practice Intel USB role switch driver was depending on
USB Type-C drivers.

Fixes: f6fb9ec02be1 ("usb: roles: Add Intel xHCI USB role switch driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/Kconfig         |    4 
 drivers/usb/common/Makefile |    1 
 drivers/usb/common/roles.c  |  314 --------------------------------------------
 drivers/usb/roles/Kconfig   |   13 +
 drivers/usb/roles/Makefile  |    4 
 drivers/usb/roles/class.c   |  314 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 330 insertions(+), 320 deletions(-)

--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -205,8 +205,4 @@ config USB_ULPI_BUS
 	  To compile this driver as a module, choose M here: the module will
 	  be called ulpi.
 
-config USB_ROLE_SWITCH
-	tristate
-	select USB_COMMON
-
 endif # USB_SUPPORT
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -9,4 +9,3 @@ usb-common-$(CONFIG_USB_LED_TRIG) += led
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
 obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
-obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles.o
--- a/drivers/usb/common/roles.c
+++ /dev/null
@@ -1,314 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * USB Role Switch Support
- *
- * Copyright (C) 2018 Intel Corporation
- * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
- *         Hans de Goede <hdegoede@redhat.com>
- */
-
-#include <linux/usb/role.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-
-static struct class *role_class;
-
-struct usb_role_switch {
-	struct device dev;
-	struct mutex lock; /* device lock*/
-	enum usb_role role;
-
-	/* From descriptor */
-	struct device *usb2_port;
-	struct device *usb3_port;
-	struct device *udc;
-	usb_role_switch_set_t set;
-	usb_role_switch_get_t get;
-	bool allow_userspace_control;
-};
-
-#define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
-
-/**
- * usb_role_switch_set_role - Set USB role for a switch
- * @sw: USB role switch
- * @role: USB role to be switched to
- *
- * Set USB role @role for @sw.
- */
-int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
-{
-	int ret;
-
-	if (IS_ERR_OR_NULL(sw))
-		return 0;
-
-	mutex_lock(&sw->lock);
-
-	ret = sw->set(sw->dev.parent, role);
-	if (!ret)
-		sw->role = role;
-
-	mutex_unlock(&sw->lock);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
-
-/**
- * usb_role_switch_get_role - Get the USB role for a switch
- * @sw: USB role switch
- *
- * Depending on the role-switch-driver this function returns either a cached
- * value of the last set role, or reads back the actual value from the hardware.
- */
-enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
-{
-	enum usb_role role;
-
-	if (IS_ERR_OR_NULL(sw))
-		return USB_ROLE_NONE;
-
-	mutex_lock(&sw->lock);
-
-	if (sw->get)
-		role = sw->get(sw->dev.parent);
-	else
-		role = sw->role;
-
-	mutex_unlock(&sw->lock);
-
-	return role;
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
-
-static int __switch_match(struct device *dev, const void *name)
-{
-	return !strcmp((const char *)name, dev_name(dev));
-}
-
-static void *usb_role_switch_match(struct device_connection *con, int ep,
-				   void *data)
-{
-	struct device *dev;
-
-	dev = class_find_device(role_class, NULL, con->endpoint[ep],
-				__switch_match);
-
-	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
-}
-
-/**
- * usb_role_switch_get - Find USB role switch linked with the caller
- * @dev: The caller device
- *
- * Finds and returns role switch linked with @dev. The reference count for the
- * found switch is incremented.
- */
-struct usb_role_switch *usb_role_switch_get(struct device *dev)
-{
-	struct usb_role_switch *sw;
-
-	sw = device_connection_find_match(dev, "usb-role-switch", NULL,
-					  usb_role_switch_match);
-
-	if (!IS_ERR_OR_NULL(sw))
-		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
-
-	return sw;
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_get);
-
-/**
- * usb_role_switch_put - Release handle to a switch
- * @sw: USB Role Switch
- *
- * Decrement reference count for @sw.
- */
-void usb_role_switch_put(struct usb_role_switch *sw)
-{
-	if (!IS_ERR_OR_NULL(sw)) {
-		put_device(&sw->dev);
-		module_put(sw->dev.parent->driver->owner);
-	}
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_put);
-
-static umode_t
-usb_role_switch_is_visible(struct kobject *kobj, struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, typeof(*dev), kobj);
-	struct usb_role_switch *sw = to_role_switch(dev);
-
-	if (sw->allow_userspace_control)
-		return attr->mode;
-
-	return 0;
-}
-
-static const char * const usb_roles[] = {
-	[USB_ROLE_NONE]		= "none",
-	[USB_ROLE_HOST]		= "host",
-	[USB_ROLE_DEVICE]	= "device",
-};
-
-static ssize_t
-role_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct usb_role_switch *sw = to_role_switch(dev);
-	enum usb_role role = usb_role_switch_get_role(sw);
-
-	return sprintf(buf, "%s\n", usb_roles[role]);
-}
-
-static ssize_t role_store(struct device *dev, struct device_attribute *attr,
-			  const char *buf, size_t size)
-{
-	struct usb_role_switch *sw = to_role_switch(dev);
-	int ret;
-
-	ret = sysfs_match_string(usb_roles, buf);
-	if (ret < 0) {
-		bool res;
-
-		/* Extra check if the user wants to disable the switch */
-		ret = kstrtobool(buf, &res);
-		if (ret || res)
-			return -EINVAL;
-	}
-
-	ret = usb_role_switch_set_role(sw, ret);
-	if (ret)
-		return ret;
-
-	return size;
-}
-static DEVICE_ATTR_RW(role);
-
-static struct attribute *usb_role_switch_attrs[] = {
-	&dev_attr_role.attr,
-	NULL,
-};
-
-static const struct attribute_group usb_role_switch_group = {
-	.is_visible = usb_role_switch_is_visible,
-	.attrs = usb_role_switch_attrs,
-};
-
-static const struct attribute_group *usb_role_switch_groups[] = {
-	&usb_role_switch_group,
-	NULL,
-};
-
-static int
-usb_role_switch_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	int ret;
-
-	ret = add_uevent_var(env, "USB_ROLE_SWITCH=%s", dev_name(dev));
-	if (ret)
-		dev_err(dev, "failed to add uevent USB_ROLE_SWITCH\n");
-
-	return ret;
-}
-
-static void usb_role_switch_release(struct device *dev)
-{
-	struct usb_role_switch *sw = to_role_switch(dev);
-
-	kfree(sw);
-}
-
-static const struct device_type usb_role_dev_type = {
-	.name = "usb_role_switch",
-	.groups = usb_role_switch_groups,
-	.uevent = usb_role_switch_uevent,
-	.release = usb_role_switch_release,
-};
-
-/**
- * usb_role_switch_register - Register USB Role Switch
- * @parent: Parent device for the switch
- * @desc: Description of the switch
- *
- * USB Role Switch is a device capable or choosing the role for USB connector.
- * On platforms where the USB controller is dual-role capable, the controller
- * driver will need to register the switch. On platforms where the USB host and
- * USB device controllers behind the connector are separate, there will be a
- * mux, and the driver for that mux will need to register the switch.
- *
- * Returns handle to a new role switch or ERR_PTR. The content of @desc is
- * copied.
- */
-struct usb_role_switch *
-usb_role_switch_register(struct device *parent,
-			 const struct usb_role_switch_desc *desc)
-{
-	struct usb_role_switch *sw;
-	int ret;
-
-	if (!desc || !desc->set)
-		return ERR_PTR(-EINVAL);
-
-	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
-	if (!sw)
-		return ERR_PTR(-ENOMEM);
-
-	mutex_init(&sw->lock);
-
-	sw->allow_userspace_control = desc->allow_userspace_control;
-	sw->usb2_port = desc->usb2_port;
-	sw->usb3_port = desc->usb3_port;
-	sw->udc = desc->udc;
-	sw->set = desc->set;
-	sw->get = desc->get;
-
-	sw->dev.parent = parent;
-	sw->dev.class = role_class;
-	sw->dev.type = &usb_role_dev_type;
-	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
-
-	ret = device_register(&sw->dev);
-	if (ret) {
-		put_device(&sw->dev);
-		return ERR_PTR(ret);
-	}
-
-	/* TODO: Symlinks for the host port and the device controller. */
-
-	return sw;
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_register);
-
-/**
- * usb_role_switch_unregister - Unregsiter USB Role Switch
- * @sw: USB Role Switch
- *
- * Unregister switch that was registered with usb_role_switch_register().
- */
-void usb_role_switch_unregister(struct usb_role_switch *sw)
-{
-	if (!IS_ERR_OR_NULL(sw))
-		device_unregister(&sw->dev);
-}
-EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
-
-static int __init usb_roles_init(void)
-{
-	role_class = class_create(THIS_MODULE, "usb_role");
-	return PTR_ERR_OR_ZERO(role_class);
-}
-subsys_initcall(usb_roles_init);
-
-static void __exit usb_roles_exit(void)
-{
-	class_destroy(role_class);
-}
-module_exit(usb_roles_exit);
-
-MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
-MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("USB Role Class");
--- a/drivers/usb/roles/Kconfig
+++ b/drivers/usb/roles/Kconfig
@@ -1,3 +1,16 @@
+config USB_ROLE_SWITCH
+	tristate "USB Role Switch Support"
+	help
+	  USB Role Switch is a device that can select the USB role - host or
+	  device - for a USB port (connector). In most cases dual-role capable
+	  USB controller will also represent the switch, but on some platforms
+	  multiplexer/demultiplexer switch is used to route the data lines on
+	  the USB connector between separate USB host and device controllers.
+
+	  Say Y here if your USB connectors support both device and host roles.
+	  To compile the driver as module, choose M here: the module will be
+	  called roles.ko.
+
 if USB_ROLE_SWITCH
 
 config USB_ROLES_INTEL_XHCI
--- a/drivers/usb/roles/Makefile
+++ b/drivers/usb/roles/Makefile
@@ -1 +1,3 @@
-obj-$(CONFIG_USB_ROLES_INTEL_XHCI) += intel-xhci-usb-role-switch.o
+obj-$(CONFIG_USB_ROLE_SWITCH)		+= roles.o
+roles-y					:= class.o
+obj-$(CONFIG_USB_ROLES_INTEL_XHCI)	+= intel-xhci-usb-role-switch.o
--- /dev/null
+++ b/drivers/usb/roles/class.c
@@ -0,0 +1,314 @@
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
+	struct usb_role_switch *sw;
+
+	sw = device_connection_find_match(dev, "usb-role-switch", NULL,
+					  usb_role_switch_match);
+
+	if (!IS_ERR_OR_NULL(sw))
+		WARN_ON(!try_module_get(sw->dev.parent->driver->owner));
+
+	return sw;
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
+	if (!IS_ERR_OR_NULL(sw)) {
+		put_device(&sw->dev);
+		module_put(sw->dev.parent->driver->owner);
+	}
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


