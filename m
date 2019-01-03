Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B68C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70C8208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO5lJ11t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732240AbfACQPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:15:52 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40463 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbfACQPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:15:49 -0500
Received: by mail-io1-f66.google.com with SMTP id k2so4778851iog.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vuvi6u2kdmRVvvF6W2XrA/o1hI0WSElk0ZmfAMtbvKM=;
        b=hO5lJ11tSMT5a1SnHP+wyK2M9/YVI/ggZswFaHG+gBODembZEGktJ0UOkBiDYmHFlf
         4szJPOBWARXlRrS6a705mlDZ9BRKZp8/vWX69bQSKj+FKCMrPVH9inq8nAuwGJdcTdA7
         S2GwFnqEPPi8U8btkLn1FGUHoRmF6gxrZCzxZTLczTyYVrUjcDpM1ESoPouYLcKOjEMv
         aV7hUzp+wX8d7CJdECKjCTqDvq/dQvq9NrpfQE0yWPNnv6ycSKxNUhQyv1+XPQEnxF+Y
         XCXukuF7t4g4KIZCnRgRqD3zBfrcuAe+w2gQfjlVKsxOka7no8sQFvPTdH/Mp1JLK1Ra
         E6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vuvi6u2kdmRVvvF6W2XrA/o1hI0WSElk0ZmfAMtbvKM=;
        b=apE+gs6/OKfrcpFjyMYEMoi16GsF/v1awT8t4GGSavpV5HILow75/reP3zTnpFXfnt
         ADxTOB1gg15LpokecEYbfxUBpEa7EVpIMDb+Vg+7QvqsRl7JrncIGgPvXUPtPIvhKxrw
         jfD3J1yDtNwNqhpq4p7YbqG0hKUIhgYjNBYJJWzPNmfLBfONu0sGCpFXwqXR1UdRbb8a
         UDi9xqAPgVO6dm0uRvZ/zRiZqwr61fZgd5726/zM8cbY7I3/4Ab7K7Ep1TaO++aztci1
         eboGdn3zSWSFtvk3PPpkl4CJwXQqnVPdx+j1whhFXiPOsHir3e3p61YYaKVd1FvtkX3P
         Wrpg==
X-Gm-Message-State: AJcUukerEIWAqGXRbk436PNnDkMsa+6r+UXj/qqvoCwLgK8E0PABAaX4
        YcyBRdpnXsA3FoAdnKvzW4c=
X-Google-Smtp-Source: ALg8bN7dyTErgW29znA7oEdIusc+uO5gVuYoIpLAKNB5qEtz/awX5paaCNjGwpPO5qhoq+3TyHuIWw==
X-Received: by 2002:a5e:c206:: with SMTP id v6mr17326990iop.60.1546532147636;
        Thu, 03 Jan 2019 08:15:47 -0800 (PST)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id d11sm6018423ioq.31.2019.01.03.08.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 08:15:47 -0800 (PST)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@googlemail.com>
To:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH fieldbus v6 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Date:   Thu,  3 Jan 2019 11:15:33 -0500
Message-Id: <20190103161538.20637-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190103161538.20637-1-TheSven73@googlemail.com>
References: <20190103161538.20637-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fieldbus device (client) adapters allow data exchange with a PLC aka.
"Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)

They are typically used when a Linux device wants to expose itself
as an actuator, motor, console light, switch, etc. over the fieldbus.

This framework is designed to provide a generic interface to Fieldbus
Devices from both the Linux Kernel and the userspace.

Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
---
 Documentation/ABI/testing/fieldbus-dev-cdev   |  31 ++
 .../ABI/testing/sysfs-class-fieldbus-dev      |  62 ++++
 Documentation/fieldbus_dev/fieldbus_dev.txt   |  66 ++++
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/fieldbus/Kconfig                      |  19 +
 drivers/fieldbus/Makefile                     |   9 +
 drivers/fieldbus/dev_core.c                   | 348 ++++++++++++++++++
 include/linux/fieldbus_dev.h                  | 105 ++++++
 9 files changed, 643 insertions(+)
 create mode 100644 Documentation/ABI/testing/fieldbus-dev-cdev
 create mode 100644 Documentation/ABI/testing/sysfs-class-fieldbus-dev
 create mode 100644 Documentation/fieldbus_dev/fieldbus_dev.txt
 create mode 100644 drivers/fieldbus/Kconfig
 create mode 100644 drivers/fieldbus/Makefile
 create mode 100644 drivers/fieldbus/dev_core.c
 create mode 100644 include/linux/fieldbus_dev.h

diff --git a/Documentation/ABI/testing/fieldbus-dev-cdev b/Documentation/ABI/testing/fieldbus-dev-cdev
new file mode 100644
index 000000000000..2c71f63ce0f9
--- /dev/null
+++ b/Documentation/ABI/testing/fieldbus-dev-cdev
@@ -0,0 +1,31 @@
+What:		/dev/fieldbus_devX
+Date:		December 2018
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		The cdev interface to drivers for Fieldbus Device Memory
+			(aka. Process Memory).
+
+		The following file operations are supported:
+
+		open(2)
+		Create an I/O context associated with the file descriptor.
+
+		read(2)
+		Read from Process Memory's "read area".
+		Clears POLLERR | POLLPRI from the file descriptor.
+
+		write(2)
+		Write to Process Memory's "write area".
+
+		poll(2), select(2), epoll_wait(2) etc.
+		When a "Process Memory Read Area Changed" event occurs,
+		POLLERR | POLLPRI will be set on the file descriptor.
+		Note that POLLIN | POLLOUT events are always set, because the
+		process memory area is always readable and writable.
+
+		close(2)
+		Free up the I/O context that was associated
+		with the file descriptor.
+
+Users:		TBD
diff --git a/Documentation/ABI/testing/sysfs-class-fieldbus-dev b/Documentation/ABI/testing/sysfs-class-fieldbus-dev
new file mode 100644
index 000000000000..f0e45ec34400
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fieldbus-dev
@@ -0,0 +1,62 @@
+What:		/sys/class/fieldbus_dev/fieldbus_devX/card_name
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		Human-readable name of the Fieldbus Device.
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/fieldbus_type
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		The type of fieldbus implemented by this device.
+		Possible values:
+			'unknown'
+			'profinet'
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/fieldbus_id
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		The unique fieldbus id associated with this device.
+		The exact format of this id is fieldbus type dependent, e.g.
+		a mac address for profinet.
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/read_area_size
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		The size, in bytes, of the Process Memory read area.
+		Note: this area is accessible by reading from the associated
+			character device (/dev/fieldbus_devX).
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/write_area_size
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		The size, in bytes, of the Process Memory write area.
+		Note: this area is accessible by writing to the associated
+			character device (/dev/fieldbus_devX)
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/online
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		Whether the fieldbus is online or offline.
+		Possible values:
+			'1' meaning 'online'
+			'0' meaning 'offline'
+		Note: an uevent is generated when this property changes.
+
+What:		/sys/class/fieldbus_dev/fieldbus_devX/enabled
+KernelVersion:	4.21
+Contact:	Sven Van Asbroeck <TheSven73@googlemail.com>
+Description:
+		Whether the device is enabled (power on) or
+			disabled (power off).
+		Possible values:
+			'1' meaning enabled
+			'0' meaning disabled
+		Normally a r/o property, but optionally r/w:
+		Writing '1' enables the device (power on) with default
+			settings.
+		Writing '0' disables the card (power off).
diff --git a/Documentation/fieldbus_dev/fieldbus_dev.txt b/Documentation/fieldbus_dev/fieldbus_dev.txt
new file mode 100644
index 000000000000..56af3f650fa3
--- /dev/null
+++ b/Documentation/fieldbus_dev/fieldbus_dev.txt
@@ -0,0 +1,66 @@
+                       Fieldbus-Device Subsystem
+               ============================================
+
+Part 0 - What is a Fieldbus Device ?
+------------------------------------
+
+Fieldbus is the name of a family of industrial computer network protocols used
+for real-time distributed control, standardized as IEC 61158.
+
+A complex automated industrial system -- such as manufacturing assembly line --
+usually needs a distributed control system -- an organized hierarchy of
+controller systems -- to function. In this hierarchy, there is usually a
+Human Machine Interface (HMI) at the top, where an operator can monitor or
+operate the system. This is typically linked to a middle layer of programmable
+logic controllers (PLC) via a non-time-critical communications system
+(e.g. Ethernet). At the bottom of the control chain is the fieldbus that links
+the PLCs to the components that actually do the work, such as sensors,
+actuators, electric motors, console lights, switches, valves and contactors.
+
+(Source: Wikipedia)
+
+A "Fieldbus Device" is such an actuator, motor, console light, switch, ...
+controlled via the Fieldbus by a PLC aka "Fieldbus Controller".
+
+Communication between PLC and device typically happens via process data memory,
+separated into input and output areas. The Fieldbus then cyclically transfers
+the PLC's output area to the device's input area, and vice versa.
+
+Part I - Why do we need this subsystem?
+---------------------------------------
+
+Fieldbus device (client) adapters are commercially available. They allow data
+exchange with a PLC aka "Fieldbus Controller" via process data memory.
+
+They are typically used when a Linux device wants to expose itself as an
+actuator, motor, console light, switch, etc. over the fieldbus.
+
+The purpose of this subsystem is:
+a) present a general, standardized, extensible API/ABI to userspace; and
+b) present a convenient interface to drivers.
+
+Part II - How can drivers use the subsystem?
+--------------------------------------------
+
+Any driver that wants to register as a Fieldbus Device should allocate and
+populate a 'struct fieldbus_dev' (from include/linux/fieldbus_dev.h).
+Registration then happens by calling fieldbus_dev_register().
+
+Part III - How can userspace use the subsystem?
+-----------------------------------------------
+
+Fieldbus protocols and adapters are diverse and varied. However, they share
+a limited few common behaviours and properties. This allows us to define
+a simple interface consisting of a character device and a set of sysfs files:
+
+See:
+Documentation/ABI/testing/sysfs-class-fieldbus-dev
+Documentation/ABI/testing/fieldbus-dev-cdev
+
+Note that this simple interface does not provide a way to modify adapter
+configuration settings. It is therefore useful only for adapters that get their
+configuration settings some other way, e.g. non-volatile memory on the adapter,
+through the network, ...
+
+At a later phase, this simple interface can easily co-exist with a future
+(netlink-based ?) configuration settings interface.
diff --git a/drivers/Kconfig b/drivers/Kconfig
index b1b4114bf27b..a914ed469e60 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -220,6 +220,8 @@ source "drivers/visorbus/Kconfig"
 
 source "drivers/siox/Kconfig"
 
+source "drivers/fieldbus/Kconfig"
+
 source "drivers/slimbus/Kconfig"
 
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 14e36f52f67a..c483618f1384 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -189,3 +189,4 @@ obj-$(CONFIG_MULTIPLEXER)	+= mux/
 obj-$(CONFIG_UNISYS_VISORBUS)	+= visorbus/
 obj-$(CONFIG_SIOX)		+= siox/
 obj-$(CONFIG_GNSS)		+= gnss/
+obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus/
diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
new file mode 100644
index 000000000000..5c2bef950d04
--- /dev/null
+++ b/drivers/fieldbus/Kconfig
@@ -0,0 +1,19 @@
+menuconfig FIELDBUS_DEV
+	bool "Fieldbus Device Support"
+	help
+	  Support for Fieldbus Device Adapters.
+
+	  Fieldbus device (client) adapters allow data exchange with a PLC aka.
+	  "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
+
+	  They are typically used when a Linux device wants to expose itself
+	  as an actuator, motor, console light, switch, etc. over the fieldbus.
+
+	  This framework is designed to provide a generic interface to Fieldbus
+	  Devices from both the Linux Kernel and the userspace.
+
+	  If unsure, say no.
+
+if FIELDBUS_DEV
+
+endif
diff --git a/drivers/fieldbus/Makefile b/drivers/fieldbus/Makefile
new file mode 100644
index 000000000000..23877def5803
--- /dev/null
+++ b/drivers/fieldbus/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for fieldbus_dev drivers.
+#
+
+obj-$(CONFIG_FIELDBUS_DEV)	+= fieldbus_dev.o
+fieldbus_dev-y			:= dev_core.o
+
+# Devices
diff --git a/drivers/fieldbus/dev_core.c b/drivers/fieldbus/dev_core.c
new file mode 100644
index 000000000000..0ca7e3331d74
--- /dev/null
+++ b/drivers/fieldbus/dev_core.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Fieldbus Device Driver Core
+ *
+ */
+
+#include <linux/fieldbus_dev.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/poll.h>
+
+/* Maximum number of fieldbus devices */
+#define MAX_FIELDBUSES		32
+
+/* the dev_t structure to store the dynamically allocated fieldbus devices */
+static dev_t fieldbus_devt;
+static DEFINE_IDA(fieldbus_ida);
+static DEFINE_MUTEX(fieldbus_mtx);
+
+static const char ctrl_enabled[] = "enabled";
+static const char ctrl_disabled[] = "disabled";
+
+static ssize_t online_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", !!fb->online);
+}
+static DEVICE_ATTR_RO(online);
+
+static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	if (!fb->enable_get)
+		return -EINVAL;
+	return sprintf(buf, "%d\n", !!fb->enable_get(fb));
+}
+
+static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t n)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+	bool value;
+	int ret;
+
+	if (!fb->simple_enable_set)
+		return -ENOTSUPP;
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+	ret = fb->simple_enable_set(fb, value);
+	if (ret < 0)
+		return ret;
+	return n;
+}
+static DEVICE_ATTR_RW(enabled);
+
+static ssize_t card_name_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	/*
+	 * card_name was provided by child driver, could potentially be long.
+	 * protect against buffer overrun.
+	 */
+	return snprintf(buf, PAGE_SIZE, "%s\n", fb->card_name);
+}
+static DEVICE_ATTR_RO(card_name);
+
+static ssize_t read_area_size_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", fb->read_area_sz);
+}
+static DEVICE_ATTR_RO(read_area_size);
+
+static ssize_t write_area_size_show(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%d\n", fb->write_area_sz);
+}
+static DEVICE_ATTR_RO(write_area_size);
+
+static ssize_t fieldbus_id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+
+	return fb->fieldbus_id_get(fb, buf, PAGE_SIZE);
+}
+static DEVICE_ATTR_RO(fieldbus_id);
+
+static ssize_t fieldbus_type_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+	const char *t;
+
+	switch (fb->fieldbus_type) {
+	case FIELDBUS_DEV_TYPE_PROFINET:
+		t = "profinet";
+		break;
+	default:
+		t = "unknown";
+		break;
+	}
+
+	return sprintf(buf, "%s\n", t);
+}
+static DEVICE_ATTR_RO(fieldbus_type);
+
+static struct attribute *fieldbus_attrs[] = {
+	&dev_attr_enabled.attr,
+	&dev_attr_card_name.attr,
+	&dev_attr_fieldbus_id.attr,
+	&dev_attr_read_area_size.attr,
+	&dev_attr_write_area_size.attr,
+	&dev_attr_online.attr,
+	&dev_attr_fieldbus_type.attr,
+	NULL,
+};
+
+static umode_t fieldbus_is_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct fieldbus_dev *fb = dev_get_drvdata(dev);
+	umode_t mode = attr->mode;
+
+	if (attr == &dev_attr_enabled.attr) {
+		mode = 0;
+		if (fb->enable_get)
+			mode |= 0444;
+		if (fb->simple_enable_set)
+			mode |= 0200;
+	}
+
+	return mode;
+}
+
+static const struct attribute_group fieldbus_group = {
+	.attrs = fieldbus_attrs,
+	.is_visible = fieldbus_is_visible,
+};
+__ATTRIBUTE_GROUPS(fieldbus);
+
+static struct class fieldbus_class = {
+	.name =		"fieldbus_dev",
+	.owner =	THIS_MODULE,
+	.dev_groups =	fieldbus_groups,
+};
+
+struct fb_open_file {
+	struct fieldbus_dev *fbdev;
+	int dc_event;
+};
+
+static int fieldbus_open(struct inode *inode, struct file *filp)
+{
+	struct fb_open_file *of;
+	struct fieldbus_dev *fbdev = container_of(inode->i_cdev,
+						struct fieldbus_dev,
+						cdev);
+
+	of = kzalloc(sizeof(*of), GFP_KERNEL);
+	if (!of)
+		return -ENOMEM;
+	of->fbdev = fbdev;
+	filp->private_data = of;
+	return 0;
+}
+
+static int fieldbus_release(struct inode *node, struct file *filp)
+{
+	struct fb_open_file *of = filp->private_data;
+
+	kfree(of);
+	return 0;
+}
+
+static ssize_t fieldbus_read(struct file *filp, char __user *buf, size_t size,
+				loff_t *offset)
+{
+	struct fb_open_file *of = filp->private_data;
+	struct fieldbus_dev *fbdev = of->fbdev;
+
+	of->dc_event = fbdev->dc_event;
+	return fbdev->read_area(fbdev, buf, size, offset);
+}
+
+static ssize_t fieldbus_write(struct file *filp, const char __user *buf,
+			size_t size, loff_t *offset)
+{
+	struct fb_open_file *of = filp->private_data;
+	struct fieldbus_dev *fbdev = of->fbdev;
+
+	return fbdev->write_area(fbdev, buf, size, offset);
+}
+
+static unsigned int fieldbus_poll(struct file *filp, poll_table *wait)
+{
+	struct fb_open_file *of = filp->private_data;
+	struct fieldbus_dev *fbdev = of->fbdev;
+	unsigned int mask = POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM;
+
+	poll_wait(filp, &fbdev->dc_wq, wait);
+	/* data changed ? */
+	if (fbdev->dc_event != of->dc_event)
+		mask |= POLLPRI | POLLERR;
+	return mask;
+}
+
+static const struct file_operations fieldbus_fops = {
+	.open		= fieldbus_open,
+	.release	= fieldbus_release,
+	.read		= fieldbus_read,
+	.write		= fieldbus_write,
+	.poll		= fieldbus_poll,
+	.llseek		= generic_file_llseek,
+	.owner		= THIS_MODULE,
+};
+
+void fieldbus_dev_area_updated(struct fieldbus_dev *fb)
+{
+	fb->dc_event++;
+	wake_up_all(&fb->dc_wq);
+}
+EXPORT_SYMBOL_GPL(fieldbus_dev_area_updated);
+
+void fieldbus_dev_online_changed(struct fieldbus_dev *fb, bool online)
+{
+	fb->online = online;
+	kobject_uevent(&fb->dev->kobj, KOBJ_CHANGE);
+}
+EXPORT_SYMBOL_GPL(fieldbus_dev_online_changed);
+
+static void __fieldbus_dev_unregister(struct fieldbus_dev *fb)
+{
+	if (!fb)
+		return;
+	device_destroy(&fieldbus_class, fb->cdev.dev);
+	cdev_del(&fb->cdev);
+	ida_simple_remove(&fieldbus_ida, fb->id);
+}
+
+void fieldbus_dev_unregister(struct fieldbus_dev *fb)
+{
+	mutex_lock(&fieldbus_mtx);
+	__fieldbus_dev_unregister(fb);
+	mutex_unlock(&fieldbus_mtx);
+}
+EXPORT_SYMBOL_GPL(fieldbus_dev_unregister);
+
+static int __fieldbus_dev_register(struct fieldbus_dev *fb)
+{
+	dev_t devno;
+	int err;
+
+	if (!fb)
+		return -EINVAL;
+	if (!fb->read_area || !fb->write_area || !fb->fieldbus_id_get)
+		return -EINVAL;
+	fb->id = ida_simple_get(&fieldbus_ida, 0, MAX_FIELDBUSES, GFP_KERNEL);
+	if (fb->id < 0)
+		return fb->id;
+	devno = MKDEV(MAJOR(fieldbus_devt), fb->id);
+	init_waitqueue_head(&fb->dc_wq);
+	cdev_init(&fb->cdev, &fieldbus_fops);
+	err = cdev_add(&fb->cdev, devno, 1);
+	if (err) {
+		pr_err("fieldbus_dev%d unable to add device %d:%d\n",
+			fb->id, MAJOR(fieldbus_devt), fb->id);
+		goto err_cdev;
+	}
+	fb->dev = device_create(&fieldbus_class, fb->parent, devno, fb,
+				"fieldbus_dev%d", fb->id);
+	if (IS_ERR(fb->dev)) {
+		err = PTR_ERR(fb->dev);
+		goto err_dev_create;
+	}
+	return 0;
+
+err_dev_create:
+	cdev_del(&fb->cdev);
+err_cdev:
+	ida_simple_remove(&fieldbus_ida, fb->id);
+	return err;
+}
+
+int fieldbus_dev_register(struct fieldbus_dev *fb)
+{
+	int err;
+
+	mutex_lock(&fieldbus_mtx);
+	err = __fieldbus_dev_register(fb);
+	mutex_unlock(&fieldbus_mtx);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(fieldbus_dev_register);
+
+static int __init fieldbus_init(void)
+{
+	int err;
+
+	err = class_register(&fieldbus_class);
+	if (err < 0) {
+		pr_err("fieldbus_dev: could not register class\n");
+		return err;
+	}
+	err = alloc_chrdev_region(&fieldbus_devt, 0,
+					MAX_FIELDBUSES, "fieldbus_dev");
+	if (err < 0) {
+		pr_err("fieldbus_dev: unable to allocate char dev region\n");
+		goto err_alloc;
+	}
+	return 0;
+
+err_alloc:
+	class_unregister(&fieldbus_class);
+	return err;
+}
+
+static void __exit fieldbus_exit(void)
+{
+	unregister_chrdev_region(fieldbus_devt, MAX_FIELDBUSES);
+	class_unregister(&fieldbus_class);
+}
+
+subsys_initcall(fieldbus_init);
+module_exit(fieldbus_exit);
+
+MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
+MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
+MODULE_DESCRIPTION("Fieldbus Device Driver Core");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fieldbus_dev.h b/include/linux/fieldbus_dev.h
new file mode 100644
index 000000000000..e67548c82ba6
--- /dev/null
+++ b/include/linux/fieldbus_dev.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Fieldbus Device Driver Core
+ *
+ */
+
+#ifndef __FIELDBUS_DEV_H
+#define __FIELDBUS_DEV_H
+
+#include <linux/cdev.h>
+#include <linux/wait.h>
+
+enum fieldbus_dev_type {
+	FIELDBUS_DEV_TYPE_UNKNOWN = 0,
+	FIELDBUS_DEV_TYPE_PROFINET,
+};
+
+/**
+ * struct fieldbus_dev - Fieldbus device
+ * @read_area:		[DRIVER] function to read the process data area of the
+ *				 device. same parameters/return values as
+ *				 the read function in struct file_operations
+ * @write_area:		[DRIVER] function to write to the process data area of
+ *				 the device. same parameters/return values as
+ *				 the write function in struct file_operations
+ * @write_area_sz	[DRIVER] size of the writable process data area
+ * @read_area_sz	[DRIVER] size of the readable process data area
+ * @card_name		[DRIVER] name of the card, e.g. "ACME Inc. profinet"
+ * @fieldbus_type	[DRIVER] fieldbus type of this device, e.g.
+ *					FIELDBUS_DEV_TYPE_PROFINET
+ * @enable_get		[DRIVER] function which returns true if the card
+ *				 is enabled, false otherwise
+ * @fieldbus_id_get	[DRIVER] function to retrieve the unique fieldbus id
+ *				 by which this device can be identified;
+ *				 return value follows the snprintf convention
+ * @simple_enable_set	[DRIVER] (optional) function to enable the device
+ *				 according to its default settings
+ * @parent		[DRIVER] (optional) the device's parent device
+ */
+struct fieldbus_dev {
+	ssize_t (*read_area)(struct fieldbus_dev *fbdev, char __user *buf,
+			size_t size, loff_t *offset);
+	ssize_t (*write_area)(struct fieldbus_dev *fbdev,
+			const char __user *buf, size_t size, loff_t *offset);
+	size_t write_area_sz, read_area_sz;
+	const char *card_name;
+	enum fieldbus_dev_type fieldbus_type;
+	bool (*enable_get)(struct fieldbus_dev *fbdev);
+	int (*fieldbus_id_get)(struct fieldbus_dev *fbdev, char *buf,
+					size_t max_size);
+	int (*simple_enable_set)(struct fieldbus_dev *fbdev, bool enable);
+	struct device *parent;
+
+	/* private data */
+	int id;
+	struct cdev cdev;
+	struct device *dev;
+	int dc_event;
+	wait_queue_head_t dc_wq;
+	bool online;
+};
+
+#ifdef CONFIG_FIELDBUS_DEV
+
+/**
+ * fieldbus_dev_unregister()
+ *	- unregister a previously registered fieldbus device
+ * @fb:		Device structure previously registered
+ **/
+void fieldbus_dev_unregister(struct fieldbus_dev *fb);
+
+/**
+ * fieldbus_dev_register()
+ *	- register a device with the fieldbus device subsystem
+ * @fb:		Device structure filled by the device driver
+ **/
+int __must_check fieldbus_dev_register(struct fieldbus_dev *fb);
+
+/**
+ * fieldbus_dev_area_updated()
+ *	- notify the subsystem that an external fieldbus controller updated
+ *			the process data area
+ * @fb:		Device structure
+ **/
+void fieldbus_dev_area_updated(struct fieldbus_dev *fb);
+
+/**
+ * fieldbus_dev_online_changed()
+ *	- notify the subsystem that the fieldbus online status changed
+ * @fb:		Device structure
+ **/
+void fieldbus_dev_online_changed(struct fieldbus_dev *fb, bool online);
+
+#else /* CONFIG_FIELDBUS_DEV */
+
+void fieldbus_dev_unregister(struct fieldbus_dev *fb) {}
+int __must_check fieldbus_dev_register(struct fieldbus_dev *fb)
+{
+	return -ENOTSUPP;
+}
+void fieldbus_dev_area_updated(struct fieldbus_dev *fb) {}
+void fieldbus_dev_online_changed(struct fieldbus_dev *fb, bool online) {}
+
+#endif /* CONFIG_FIELDBUS_DEV */
+#endif /* __FIELDBUS_DEV_H */
-- 
2.17.1

