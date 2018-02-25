Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-153198-1519572526-2-13648931298108173224
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
    t=1519572525; b=GrtLgeoqc2PPkPaK8ujiXpNfhoAuLRz1NJHVozkuLjOIafO
    fgQWy1A3o9cYt6jXRWQVHaRk7GSCV74rSG3EOC7W03TumZNudoDwYZ77kBvGO6wS
    n7OQh47zTh6EoH0BPNR1Zwej7FkAOz7/untZ+Ju3HMDtcARHqAbMPhbVPmgmzSq9
    XXNvLKlqomcRfaaBfxjKm5z1ezzDLrkO0C/CtgjKvMVR6IiQ5FW54EjLHeyKqBFK
    1WhnRWm18/4UUch9W+5elFO/ThGytMMfLhx8yMNnVXZA+1wB4AtYQwwvm+6yM/ex
    nD2OIYZ6JaZmsTxvI+/7gbkA9tpbcl2GggquVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572525;
    bh=5XK08InJOPBAqVPRJ1JL+itTgqwEhj8KW5yE1MROhMY=; b=XKwRmwOO465S
    edcjKDMUclpCKyL5o9jajEyjuKXOKz/l1FRTCsFHWnZeHjPYTufeOxjEFoxbH1Y+
    ooChZtB8jqLMdgWUQQtFR6J9WyE6C0IAXyy5RJftNI2NRzEwh3jdWYoOo4UJlmZj
    9PPpBrTKBGD4riY11U+AsHwjP9k6iW8Pk1jAL4hUiqzyTQRyz6bmqua9C7vMMIpB
    I+k01O3hG2AksJPBg79zrcPWsSO2NHORFaE4YtUqGJLz9Vm0Ccsxm06xMmJQ9qx6
    k9iwe4EYF12CFZ9Hlc9Y5rkJ8FSiNjlJbUC/vk34ArjgpnmAzk2IpVTdt7ZETb3e
    gEJejFufhg==
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
        id S1751868AbeBYP2d (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:28:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751667AbeBYPZQ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:16 -0500
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
Subject: [PATCH v2 01/12] drivers: base: Unified device connection lookup
Date: Sun, 25 Feb 2018 16:24:59 +0100
Message-Id: <20180225152510.10159-2-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Several frameworks - clk, gpio, phy, pmw, etc. - maintain
lookup tables for describing connections and provide custom
API for handling them. This introduces a single generic
lookup table and API for the connections.

The motivation for this commit is centralizing the
connection lookup, but the goal is to ultimately extract the
connection descriptions also from firmware by using the
fwnode_graph_* functions and other mechanisms that are
available.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a (struct devcon) cast to the DEVCON() macro
---
 Documentation/driver-api/device_connection.rst |  43 ++++++++
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 139 +++++++++++++++++++++++++
 include/linux/connection.h                     |  33 ++++++
 4 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 include/linux/connection.h

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
new file mode 100644
index 000000000000..d52604448356
--- /dev/null
+++ b/Documentation/driver-api/device_connection.rst
@@ -0,0 +1,43 @@
+==================
+Device connections
+==================
+
+Introduction
+------------
+
+Devices have often connections to other devices that are out side of the direct
+child/parent relationship. A serial or network communication controller, which
+could be a PCI device, may need to be able to get a reference to its PHY
+component, which could be attached to for example the I2C bus. Some device
+drivers need to be able to control the clocks or the GPIOs for their devices,
+and so on.
+
+Device connections are generic descriptions of any type of connection between
+two separate devices.
+
+Device connections alone do not create a dependency between the two devices.
+They are only descriptions which are not tied to either of devices directly.
+A dependency between the two devices exists only if one of the two endpoint
+devices requests a reference to the other. The descriptions themselves can be
+defined in firmware (not yet supported) or they can be build-in.
+
+Usage
+-----
+
+Device connections should exist before device ``->probe`` callback is called for
+either endpoint devices in the description. If the connections are defined in
+firmware, this is not a problem. It should be considered if the connection
+descriptions are "build-in", and need to be added separately.
+
+The connection description consist of the names of the two devices with the
+connection, i.e. the endpoints, and unique identifier for the connection which
+is needed if there are multiple connections between the two devices.
+
+After a descriptions exist, the devices in it can request reference to the other
+endpoint device, or they can request the description itself.
+
+API
+---
+
+.. kernel-doc:: drivers/base/devcon.c
+   : functions: __device_find_connection device_find_connection add_device_connection remove_device_connection
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index e32a52490051..12a7f64d35a9 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -5,7 +5,8 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
-			   topology.o container.o property.o cacheinfo.o
+			   topology.o container.o property.o cacheinfo.o \
+			   devcon.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/devcon.c b/drivers/base/devcon.c
new file mode 100644
index 000000000000..6f9e4f7280a5
--- /dev/null
+++ b/drivers/base/devcon.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Device connections
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/connection.h>
+#include <linux/device.h>
+
+static DEFINE_MUTEX(devcon_lock);
+static LIST_HEAD(devcon_list);
+
+/**
+ * __device_find_connection - Find physical connection to a device
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @dev and an other
+ * device. @match will be used to convert the connection description to data the
+ * caller is expecting to be returned.
+ */
+void *__device_find_connection(struct device *dev, const char *con_id,
+			       void *data,
+			       void *(*match)(struct devcon *con, int ep,
+					      void *data))
+{
+	const char *devname = dev_name(dev);
+	struct devcon *con;
+	void *ret = NULL;
+	int ep;
+
+	if (!match)
+		return NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(con, &devcon_list, list) {
+		ep = match_string(con->endpoint, 2, devname);
+		if (ep < 0)
+			continue;
+
+		if (con_id && strcmp(con->id, con_id))
+			continue;
+
+		ret = match(con, !ep, data);
+		if (ret)
+			break;
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__device_find_connection);
+
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/i2c.h>
+#include <linux/pci.h>
+
+static struct bus_type *generic_match_buses[] = {
+	&platform_bus_type,
+#ifdef CONFIG_PCI
+	&pci_bus_type,
+#endif
+#ifdef CONFIG_I2C
+	&i2c_bus_type,
+#endif
+#ifdef CONFIG_SPI_MASTER
+	&spi_bus_type,
+#endif
+	NULL,
+};
+
+/* This tries to find the device from the most common bus types by name. */
+static void *generic_match(struct devcon *con, int ep, void *data)
+{
+	struct bus_type *bus;
+	struct device *dev;
+
+	for (bus = generic_match_buses[0]; bus; bus++) {
+		dev = bus_find_device_by_name(bus, NULL, con->endpoint[ep]);
+		if (dev)
+			return dev;
+	}
+
+	/*
+	 * We only get called if a connection was found, tell the caller to
+	 * wait for the other device to show-up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * device_find_connection - Find two devices connected together
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ *
+ * Find a connection with unique identifier @con_id between @dev and an
+ * other device. On success returns handle to the device that is connected
+ * to @dev, with the reference count for the found device incremented. Returns
+ * NULL if no matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a
+ * connection was found but the other device has not been enumerated yet.
+ */
+struct device *device_find_connection(struct device *dev, const char *con_id)
+{
+	return __device_find_connection(dev, con_id, generic_match, NULL);
+}
+EXPORT_SYMBOL_GPL(device_find_connection);
+
+/**
+ * add_device_connection - Register a collection of connection descriptions
+ * @con: Collection of connection descriptions to be registered
+ */
+void add_device_connection(struct devcon *con)
+{
+	mutex_lock(&devcon_lock);
+	list_add_tail_rcu(&con->list, &devcon_list);
+	mutex_unlock(&devcon_lock);
+}
+EXPORT_SYMBOL_GPL(add_device_connection);
+
+/**
+ * remove_device_connections - Unregister collection of connection descriptions
+ * @con: Collection of connection descriptions to be unregistered
+ */
+void remove_device_connection(struct devcon *con)
+{
+	mutex_lock(&devcon_lock);
+	list_del_rcu(&con->list);
+	mutex_unlock(&devcon_lock);
+	/* The caller may free the devcon struct immediately afterwards. */
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(remove_device_connection);
diff --git a/include/linux/connection.h b/include/linux/connection.h
new file mode 100644
index 000000000000..0b4430eae53a
--- /dev/null
+++ b/include/linux/connection.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef _LINUX_CONNECTION_H_
+#define _LINUX_CONNECTION_H_
+
+#include <linux/list.h>
+
+struct device;
+
+/**
+ * struct devcon - Device Connection Descriptor
+ * @endpoint: The names of the two devices connected together
+ * @id: Unique identifier for the connection
+ */
+struct devcon {
+	const char		*endpoint[2];
+	const char		*id;
+	struct list_head	list;
+};
+
+void *__device_find_connection(struct device *dev, const char *con_id,
+			       void *data,
+			       void *(*match)(struct devcon *con, int ep,
+					      void *data));
+
+struct device *device_find_connection(struct device *dev, const char *con_id);
+
+#define DEVCON(_ep0, _ep1, _id)    (struct devcon) { { _ep0, _ep1 }, _id, }
+
+void add_device_connection(struct devcon *con);
+void remove_device_connection(struct devcon *con);
+
+#endif /* _LINUX_CONNECTION_H_ */
-- 
2.14.3

