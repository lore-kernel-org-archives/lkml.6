Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1141692-1521542004-2-944462685593759662
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii', plain='us-ascii'
X-Attached: v9-0001-drivers-base-Unified-device-connection-lookup.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521542003; b=SCExpNsqnjYB+Gf0qQxA2pj5xF+kRxaf1VNZauvrH3j7Juw
    W/IVS+N//tYxEbUo/cAfin5lXkNnDLwi2+u0yPBu/YPut7GxiPFvUmnNUs705k/7
    O5a7Lyia+A6YMi7NzxyyzbAE3QMXQUvaXJLrZXOI56985MJcH74KOzPZBEJy3HVb
    bGEqvYExxA47bGb1OX/79S1sJK5T3ougCBQO3/MOPTp2oymbFxWJILkkQwpyOcJC
    5Wxps9H62YayepfYzMhuUo0iDNou4Xk/XwD9nhW9GLQT3YbG96egd6qR86kqYp0S
    /xVMiiG7CRz+77JkINuWh6KVL/cGyF/OC/OmUtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521542003; bh=k/BRTyv5j5OuChdBQCT6K/Nf+W
    04PxR4+bMsnznOpnM=; b=WtfODkANEMJxm7Bghwf4VpW2OOi/SxtdxW5hL+1SbW
    bvR0vpKHasI45p9cuhCPteSJ7ysvvXUf27nGhHeePUSXQnnA2S5MaBEMw5KIIFSf
    3IGfDIihiKXIc6/p9zec/IiXsDxyhunP+Dm2Ek4JKjC4UUDTfuMWZ7VfmxCXkG9o
    enjpjpddYKdztsKEPv5S3BlskamOlcDzfTObtxfkg22EiZ8zau2D0aoMRK322dwo
    p3dFDmMVTqWNCgiuK9nrb9hcm4cgblFxwnJHTjBtjOiIwo8Hi4PlIEXSSuS1DO3b
    M/6yudBYuDsoiPDjRKosYSVQJJZ1HVSoqISBIneIH4AQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeCTKdG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 06:33:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:30742 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752136AbeCTKdF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 20 Mar 2018 06:33:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208,223";a="39561284"
Date: Tue, 20 Mar 2018 12:32:59 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v8 01/12] drivers: base: Unified device connection lookup
Message-ID: <20180320103259.GJ11689@kuha.fi.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
 <20180314131215.70833-2-heikki.krogerus@linux.intel.com>
 <20180320092004.GA21081@kroah.com>
 <20180320100412.GI11689@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20180320100412.GI11689@kuha.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 20, 2018 at 12:04:12PM +0200, Heikki Krogerus wrote:
> > > +void device_connection_remove(struct device_connection *con)
> > > +{
> > > +	mutex_lock(&devcon_lock);
> > > +	list_del_rcu(&con->list);
> > 
> > See, rcu?
> 
> True. I'll send one more version.

Before I do that, Hans, can you quickly check this and see that I
have not made any more mistakes? I don't trust myself anymore with
these.


Thanks,

-- 
heikki

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="v9-0001-drivers-base-Unified-device-connection-lookup.patch"

>From f5693bfddb6fa733d701ab4b692b1c3b2473ba8f Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Fri, 2 Mar 2018 11:20:46 +0100
Subject: [PATCH v9 01/12] drivers: base: Unified device connection lookup

Several frameworks - clk, gpio, phy, pmw, etc. - maintain
lookup tables for describing connections and provide custom
API for handling them. This introduces a single generic
lookup table and API for the connections.

The motivation for this commit is centralizing the
connection lookup, but the goal is to ultimately extract the
connection descriptions also from firmware by using the
fwnode_graph_* functions and other mechanisms that are
available.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v9
- Now really stop using rcu.
- Decalaring the bus types as extern so we don't have to include the header
  files.

Changes in v8:
- No longer using rcu.

Changes in v7:
- API naming improvements suggested by Greg
- Prototypes to device.h, also suggested by Greg
- I removed the DEVCON() macro as it was not used yet and it needs to be
  rewritten

Changes in v6:
-Fix data and match arguments being swapped in __device_find_connection()
 call in device_find_connection() (as noticed by Jun Li)

Changes in v5:
-Add missing documentation for @list struct devcon member

Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Various spelling and gramar fixes in the docs pointed out by Randy Dunlap

Changes in v2:
-Add a (struct devcon) cast to the DEVCON() macro
---
 Documentation/driver-api/device_connection.rst |  43 ++++++++
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 136 +++++++++++++++++++++++++
 include/linux/device.h                         |  22 ++++
 4 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c

diff --git a/Documentation/driver-api/device_connection.rst b/Documentation/driver-api/device_connection.rst
new file mode 100644
index 000000000000..affbc5566ab0
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
+Devices often have connections to other devices that are outside of the direct
+child/parent relationship. A serial or network communication controller, which
+could be a PCI device, may need to be able to get a reference to its PHY
+component, which could be attached for example to the I2C bus. Some device
+drivers need to be able to control the clocks or the GPIOs for their devices,
+and so on.
+
+Device connections are generic descriptions of any type of connection between
+two separate devices.
+
+Device connections alone do not create a dependency between the two devices.
+They are only descriptions which are not tied to either of the devices directly.
+A dependency between the two devices exists only if one of the two endpoint
+devices requests a reference to the other. The descriptions themselves can be
+defined in firmware (not yet supported) or they can be built-in.
+
+Usage
+-----
+
+Device connections should exist before device ``->probe`` callback is called for
+either endpoint device in the description. If the connections are defined in
+firmware, this is not a problem. It should be considered if the connection
+descriptions are "built-in", and need to be added separately.
+
+The connection description consists of the names of the two devices with the
+connection, i.e. the endpoints, and unique identifier for the connection which
+is needed if there are multiple connections between the two devices.
+
+After a description exists, the devices in it can request reference to the other
+endpoint device, or they can request the description itself.
+
+API
+---
+
+.. kernel-doc:: drivers/base/devcon.c
+   : functions: device_connection_find_match device_connection_find device_connection_add device_connection_remove
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index f261143fafbf..888725ad59f7 100644
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
index 000000000000..d427e806cd73
--- /dev/null
+++ b/drivers/base/devcon.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * Device connections
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/device.h>
+
+static DEFINE_MUTEX(devcon_lock);
+static LIST_HEAD(devcon_list);
+
+/**
+ * device_connection_find_match - Find physical connection to a device
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ *
+ * Find a connection with unique identifier @con_id between @dev and another
+ * device. @match will be used to convert the connection description to data the
+ * caller is expecting to be returned.
+ */
+void *device_connection_find_match(struct device *dev, const char *con_id,
+			       void *data,
+			       void *(*match)(struct device_connection *con,
+					      int ep, void *data))
+{
+	const char *devname = dev_name(dev);
+	struct device_connection *con;
+	void *ret = NULL;
+	int ep;
+
+	if (!match)
+		return NULL;
+
+	mutex_lock(&devcon_lock);
+
+	list_for_each_entry(con, &devcon_list, list) {
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
+	mutex_unlock(&devcon_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_connection_find_match);
+
+extern struct bus_type platform_bus_type;
+extern struct bus_type pci_bus_type;
+extern struct bus_type i2c_bus_type;
+extern struct bus_type spi_bus_type;
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
+static void *generic_match(struct device_connection *con, int ep, void *data)
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
+	 * wait for the other device to show up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * device_connection_find - Find two devices connected together
+ * @dev: Device with the connection
+ * @con_id: Identifier for the connection
+ *
+ * Find a connection with unique identifier @con_id between @dev and
+ * another device. On success returns handle to the device that is connected
+ * to @dev, with the reference count for the found device incremented. Returns
+ * NULL if no matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a
+ * connection was found but the other device has not been enumerated yet.
+ */
+struct device *device_connection_find(struct device *dev, const char *con_id)
+{
+	return device_connection_find_match(dev, con_id, NULL, generic_match);
+}
+EXPORT_SYMBOL_GPL(device_connection_find);
+
+/**
+ * device_connection_add - Register a connection description
+ * @con: The connection description to be registered
+ */
+void device_connection_add(struct device_connection *con)
+{
+	mutex_lock(&devcon_lock);
+	list_add_tail(&con->list, &devcon_list);
+	mutex_unlock(&devcon_lock);
+}
+EXPORT_SYMBOL_GPL(device_connection_add);
+
+/**
+ * device_connections_remove - Unregister connection description
+ * @con: The connection description to be unregistered
+ */
+void device_connection_remove(struct device_connection *con)
+{
+	mutex_lock(&devcon_lock);
+	list_del(&con->list);
+	mutex_unlock(&devcon_lock);
+}
+EXPORT_SYMBOL_GPL(device_connection_remove);
diff --git a/include/linux/device.h b/include/linux/device.h
index e81fcea5d8a0..0059b99e1f25 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -730,6 +730,28 @@ struct device_dma_parameters {
 	unsigned long segment_boundary_mask;
 };
 
+/**
+ * struct device_connection - Device Connection Descriptor
+ * @endpoint: The names of the two devices connected together
+ * @id: Unique identifier for the connection
+ * @list: List head, private, for internal use only
+ */
+struct device_connection {
+	const char		*endpoint[2];
+	const char		*id;
+	struct list_head	list;
+};
+
+void *device_connection_find_match(struct device *dev, const char *con_id,
+				void *data,
+				void *(*match)(struct device_connection *con,
+					       int ep, void *data));
+
+struct device *device_connection_find(struct device *dev, const char *con_id);
+
+void device_connection_add(struct device_connection *con);
+void device_connection_remove(struct device_connection *con);
+
 /**
  * enum device_link_state - Device link states.
  * @DL_STATE_NONE: The presence of the drivers is not being tracked.
-- 
2.16.2


--7AUc2qLy4jB3hD7Z--
