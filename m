Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1734499-1521033159-2-6452398256230401974
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
    t=1521033157; b=LHQqXFCU0P1t0ICk9zteQlII9GdVZrmYnmcdnUo0cU1HHKJ
    X/xTu5hHq5TSDf9f9B9hiKAOV6XGtuVX+OIljqXqDKQyKYjzkcSDP7AUCVoIw6hR
    8WlcigGX8H5EqBzxtktG+MPD0+hRweJ+qpgTzzT7TJon0YjMuhleV1YFFMpF0Yiy
    fR/ntfRHdWlpnoGY5ctPRIXMhzKs1h7f0WQFMCAAi2tGuXHhHFNIo/l9jBWM6F6v
    gQKKi5zmyTJq6SenPxHZ2777It+MIxE7YL9f+jcPYRgEwFY7n5EmevMKraXBloex
    4jy5/4LI9hrnc2rzcO17UoIDiSwuNa+z0PeMQtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521033157;
    bh=CsYmx+6Ju5kPSkXJlBIPu+L6xN8C29Llp11ZL4Lm+rs=; b=aOSOsArV7NvH
    d2p0GoPWL/zMMikX+kBr7zgEPMxUBEg3kkyWRw5WE5C8GgxZ7EKTSueteGwujKxs
    fvxidr9FiSVu08oVquLnWQogZx1uR6dEt8B85X6o6EjgmcgwuPYqrfOSMfFiNIkS
    Cc//aU4KdcwHlYr8JJZ65aDhwUGJepjKpErHIWjpgZA4zfN8TEUJN9QKQIR9tvaD
    1nr9fxYTGDDyjrKW3mJ64K1Bwy4WaAb7TdlWefKlgFg12usbx9VpAu1ruag+X1CH
    leTM/piD4Z3agkKvRjtLYWR7ZuK55q84D4gSEkbye7/dxYvgEUohoankF7ashQXw
    Bzqpzyw7kw==
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
        id S1752150AbeCNNM3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:12:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:10531 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbeCNNM1 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991607"
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
Subject: [PATCH v8 02/12] usb: typec: API for controlling USB Type-C Multiplexers
Date: Wed, 14 Mar 2018 16:12:05 +0300
Message-Id: <20180314131215.70833-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

USB Type-C connectors consist of various muxes and switches
that route the pins on the connector to the right locations.
The USB Type-C drivers need to be able to control the muxes,
as they are the ones that know things like the cable plug
orientation, and the current mode that was negotiated with
the partner.

This introduces a small API for registering and controlling
cable plug orientation switches, and separate small API for
registering and controlling pin multiplexer/demultiplexer
switches that are needed with Accessory/Alternate Modes.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Add #include-s for a few missing headers to drivers/usb/typec/mux.c
-Various spelling and gramar fixes in the docs pointed out by Randy Dunlap
---
 Documentation/driver-api/usb/typec.rst |  73 +++++++++++--
 drivers/usb/typec/Makefile             |   1 +
 drivers/usb/typec/{typec.c => class.c} |  70 ++++++++++++
 drivers/usb/typec/mux.c                | 191 +++++++++++++++++++++++++++++++++
 include/linux/usb/typec.h              |  14 +++
 include/linux/usb/typec_mux.h          |  55 ++++++++++
 6 files changed, 393 insertions(+), 11 deletions(-)
 rename drivers/usb/typec/{typec.c => class.c} (95%)
 create mode 100644 drivers/usb/typec/mux.c
 create mode 100644 include/linux/usb/typec_mux.h

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index 8a7249f2ff04..feb31946490b 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -61,7 +61,7 @@ Registering the ports
 The port drivers will describe every Type-C port they control with struct
 typec_capability data structure, and register them with the following API:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_register_port typec_unregister_port
 
 When registering the ports, the prefer_role member in struct typec_capability
@@ -80,7 +80,7 @@ typec_partner_desc. The class copies the details of the partner during
 registration. The class offers the following API for registering/unregistering
 partners.
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_register_partner typec_unregister_partner
 
 The class will provide a handle to struct typec_partner if the registration was
@@ -92,7 +92,7 @@ should include handle to struct usb_pd_identity instance. The class will then
 create a sysfs directory for the identity under the partner device. The result
 of Discover Identity command can then be reported with the following API:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_partner_set_identity
 
 Registering Cables
@@ -113,7 +113,7 @@ typec_cable_desc and about a plug in struct typec_plug_desc. The class copies
 the details during registration. The class offers the following API for
 registering/unregistering cables and their plugs:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_register_cable typec_unregister_cable typec_register_plug typec_unregister_plug
 
 The class will provide a handle to struct typec_cable and struct typec_plug if
@@ -125,7 +125,7 @@ include handle to struct usb_pd_identity instance. The class will then create a
 sysfs directory for the identity under the cable device. The result of Discover
 Identity command can then be reported with the following API:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_cable_set_identity
 
 Notifications
@@ -135,7 +135,7 @@ When the partner has executed a role change, or when the default roles change
 during connection of a partner or cable, the port driver must use the following
 APIs to report it to the class:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_set_data_role typec_set_pwr_role typec_set_vconn_role typec_set_pwr_opmode
 
 Alternate Modes
@@ -150,7 +150,7 @@ and struct typec_altmode_desc which is a container for all the supported modes.
 Ports that support Alternate Modes need to register each SVID they support with
 the following API:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_port_register_altmode
 
 If a partner or cable plug provides a list of SVIDs as response to USB Power
@@ -159,12 +159,12 @@ registered.
 
 API for the partners:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_partner_register_altmode
 
 API for the Cable Plugs:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_plug_register_altmode
 
 So ports, partners and cable plugs will register the alternate modes with their
@@ -172,11 +172,62 @@ own functions, but the registration will always return a handle to struct
 typec_altmode on success, or NULL. The unregistration will happen with the same
 function:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_unregister_altmode
 
 If a partner or cable plug enters or exits a mode, the port driver needs to
 notify the class with the following API:
 
-.. kernel-doc:: drivers/usb/typec/typec.c
+.. kernel-doc:: drivers/usb/typec/class.c
    :functions: typec_altmode_update_active
+
+Multiplexer/DeMultiplexer Switches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+USB Type-C connectors may have one or more mux/demux switches behind them. Since
+the plugs can be inserted right-side-up or upside-down, a switch is needed to
+route the correct data pairs from the connector to the USB controllers. If
+Alternate or Accessory Modes are supported, another switch is needed that can
+route the pins on the connector to some other component besides USB. USB Type-C
+Connector Class supplies an API for registering those switches.
+
+.. kernel-doc:: drivers/usb/typec/mux.c
+   :functions: typec_switch_register typec_switch_unregister typec_mux_register typec_mux_unregister
+
+In most cases the same physical mux will handle both the orientation and mode.
+However, as the port drivers will be responsible for the orientation, and the
+alternate mode drivers for the mode, the two are always separated into their
+own logical components: "mux" for the mode and "switch" for the orientation.
+
+When a port is registered, USB Type-C Connector Class requests both the mux and
+the switch for the port. The drivers can then use the following API for
+controlling them:
+
+.. kernel-doc:: drivers/usb/typec/class.c
+   :functions: typec_set_orientation typec_set_mode
+
+If the connector is dual-role capable, there may also be a switch for the data
+role. USB Type-C Connector Class does not supply separate API for them. The
+port drivers can use USB Role Class API with those.
+
+Illustration of the muxes behind a connector that supports an alternate mode:
+
+                     ------------------------
+                     |       Connector      |
+                     ------------------------
+                            |         |
+                     ------------------------
+                      \     Orientation    /
+                       --------------------
+                                |
+                       --------------------
+                      /        Mode        \
+                     ------------------------
+                         /              \
+      ------------------------        --------------------
+      |       Alt Mode       |       /      USB Role      \
+      ------------------------      ------------------------
+                                         /            \
+                     ------------------------      ------------------------
+                     |       USB Host       |      |       USB Device     |
+                     ------------------------      ------------------------
diff --git a/drivers/usb/typec/Makefile b/drivers/usb/typec/Makefile
index bb3138a6eaac..56b2e9516ec1 100644
--- a/drivers/usb/typec/Makefile
+++ b/drivers/usb/typec/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_TYPEC)		+= typec.o
+typec-y				:= class.o mux.o
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm.o
 obj-y				+= fusb302/
 obj-$(CONFIG_TYPEC_WCOVE)	+= typec_wcove.o
diff --git a/drivers/usb/typec/typec.c b/drivers/usb/typec/class.c
similarity index 95%
rename from drivers/usb/typec/typec.c
rename to drivers/usb/typec/class.c
index dc28ad868d93..2620a694704f 100644
--- a/drivers/usb/typec/typec.c
+++ b/drivers/usb/typec/class.c
@@ -11,6 +11,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_mux.h>
 
 struct typec_mode {
 	int				index;
@@ -70,6 +71,10 @@ struct typec_port {
 	enum typec_port_type		port_type;
 	struct mutex			port_type_lock;
 
+	enum typec_orientation		orientation;
+	struct typec_switch		*sw;
+	struct typec_mux		*mux;
+
 	const struct typec_capability	*cap;
 };
 
@@ -92,6 +97,7 @@ static const struct device_type typec_port_dev_type;
 static DEFINE_IDA(typec_index_ida);
 static struct class *typec_class;
 
+/* ------------------------------------------------------------------------- */
 /* Common attributes */
 
 static const char * const typec_accessory_modes[] = {
@@ -1137,6 +1143,8 @@ static void typec_release(struct device *dev)
 	struct typec_port *port = to_typec_port(dev);
 
 	ida_simple_remove(&typec_index_ida, port->id);
+	typec_switch_put(port->sw);
+	typec_mux_put(port->mux);
 	kfree(port);
 }
 
@@ -1246,6 +1254,47 @@ void typec_set_pwr_opmode(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
 
+/* ------------------------------------------ */
+/* API for Multiplexer/DeMultiplexer Switches */
+
+/**
+ * typec_set_orientation - Set USB Type-C cable plug orientation
+ * @port: USB Type-C Port
+ * @orientation: USB Type-C cable plug orientation
+ *
+ * Set cable plug orientation for @port.
+ */
+int typec_set_orientation(struct typec_port *port,
+			  enum typec_orientation orientation)
+{
+	int ret;
+
+	if (port->sw) {
+		ret = port->sw->set(port->sw, orientation);
+		if (ret)
+			return ret;
+	}
+
+	port->orientation = orientation;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_set_orientation);
+
+/**
+ * typec_set_mode - Set mode of operation for USB Type-C connector
+ * @port: USB Type-C port for the connector
+ * @mode: Operation mode for the connector
+ *
+ * Set mode @mode for @port. This function will configure the muxes needed to
+ * enter @mode.
+ */
+int typec_set_mode(struct typec_port *port, int mode)
+{
+	return port->mux ? port->mux->set(port->mux, mode) : 0;
+}
+EXPORT_SYMBOL_GPL(typec_set_mode);
+
 /* --------------------------------------- */
 
 /**
@@ -1293,6 +1342,18 @@ struct typec_port *typec_register_port(struct device *parent,
 		return ERR_PTR(id);
 	}
 
+	port->sw = typec_switch_get(cap->fwnode ? &port->dev : parent);
+	if (IS_ERR(port->sw)) {
+		ret = PTR_ERR(port->sw);
+		goto err_switch;
+	}
+
+	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
+	if (IS_ERR(port->mux)) {
+		ret = PTR_ERR(port->mux);
+		goto err_mux;
+	}
+
 	if (cap->type == TYPEC_PORT_DFP)
 		role = TYPEC_SOURCE;
 	else if (cap->type == TYPEC_PORT_UFP)
@@ -1330,6 +1391,15 @@ struct typec_port *typec_register_port(struct device *parent,
 	}
 
 	return port;
+
+err_mux:
+	typec_switch_put(port->sw);
+
+err_switch:
+	ida_simple_remove(&typec_index_ida, port->id);
+	kfree(port);
+
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(typec_register_port);
 
diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
new file mode 100644
index 000000000000..f89093bd7185
--- /dev/null
+++ b/drivers/usb/typec/mux.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * USB Type-C Multiplexer/DeMultiplexer Switch support
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ *         Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/usb/typec_mux.h>
+
+static DEFINE_MUTEX(switch_lock);
+static DEFINE_MUTEX(mux_lock);
+static LIST_HEAD(switch_list);
+static LIST_HEAD(mux_list);
+
+static void *typec_switch_match(struct device_connection *con, int ep,
+				void *data)
+{
+	struct typec_switch *sw;
+
+	list_for_each_entry(sw, &switch_list, entry)
+		if (!strcmp(con->endpoint[ep], dev_name(sw->dev)))
+			return sw;
+
+	/*
+	 * We only get called if a connection was found, tell the caller to
+	 * wait for the switch to show up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * typec_switch_get - Find USB Type-C orientation switch
+ * @dev: The caller device
+ *
+ * Finds a switch linked with @dev. Returns a reference to the switch on
+ * success, NULL if no matching connection was found, or
+ * ERR_PTR(-EPROBE_DEFER) when a connection was found but the switch
+ * has not been enumerated yet.
+ */
+struct typec_switch *typec_switch_get(struct device *dev)
+{
+	struct typec_switch *sw;
+
+	mutex_lock(&switch_lock);
+	sw = device_connection_find_match(dev, "typec-switch", NULL,
+					  typec_switch_match);
+	if (!IS_ERR_OR_NULL(sw))
+		get_device(sw->dev);
+	mutex_unlock(&switch_lock);
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(typec_switch_get);
+
+/**
+ * typec_put_switch - Release USB Type-C orientation switch
+ * @sw: USB Type-C orientation switch
+ *
+ * Decrement reference count for @sw.
+ */
+void typec_switch_put(struct typec_switch *sw)
+{
+	if (!IS_ERR_OR_NULL(sw))
+		put_device(sw->dev);
+}
+EXPORT_SYMBOL_GPL(typec_switch_put);
+
+/**
+ * typec_switch_register - Register USB Type-C orientation switch
+ * @sw: USB Type-C orientation switch
+ *
+ * This function registers a switch that can be used for routing the correct
+ * data pairs depending on the cable plug orientation from the USB Type-C
+ * connector to the USB controllers. USB Type-C plugs can be inserted
+ * right-side-up or upside-down.
+ */
+int typec_switch_register(struct typec_switch *sw)
+{
+	mutex_lock(&switch_lock);
+	list_add_tail(&sw->entry, &switch_list);
+	mutex_unlock(&switch_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_switch_register);
+
+/**
+ * typec_switch_unregister - Unregister USB Type-C orientation switch
+ * @sw: USB Type-C orientation switch
+ *
+ * Unregister switch that was registered with typec_switch_register().
+ */
+void typec_switch_unregister(struct typec_switch *sw)
+{
+	mutex_lock(&switch_lock);
+	list_del(&sw->entry);
+	mutex_unlock(&switch_lock);
+}
+EXPORT_SYMBOL_GPL(typec_switch_unregister);
+
+/* ------------------------------------------------------------------------- */
+
+static void *typec_mux_match(struct device_connection *con, int ep, void *data)
+{
+	struct typec_mux *mux;
+
+	list_for_each_entry(mux, &mux_list, entry)
+		if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
+			return mux;
+
+	/*
+	 * We only get called if a connection was found, tell the caller to
+	 * wait for the switch to show up.
+	 */
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * typec_mux_get - Find USB Type-C Multiplexer
+ * @dev: The caller device
+ *
+ * Finds a mux linked to the caller. This function is primarily meant for the
+ * Type-C drivers. Returns a reference to the mux on success, NULL if no
+ * matching connection was found, or ERR_PTR(-EPROBE_DEFER) when a connection
+ * was found but the mux has not been enumerated yet.
+ */
+struct typec_mux *typec_mux_get(struct device *dev)
+{
+	struct typec_mux *mux;
+
+	mutex_lock(&mux_lock);
+	mux = device_connection_find_match(dev, "typec-mux", NULL,
+					   typec_mux_match);
+	if (!IS_ERR_OR_NULL(mux))
+		get_device(mux->dev);
+	mutex_unlock(&mux_lock);
+
+	return mux;
+}
+EXPORT_SYMBOL_GPL(typec_mux_get);
+
+/**
+ * typec_mux_put - Release handle to a Multiplexer
+ * @mux: USB Type-C Connector Multiplexer/DeMultiplexer
+ *
+ * Decrements reference count for @mux.
+ */
+void typec_mux_put(struct typec_mux *mux)
+{
+	if (!IS_ERR_OR_NULL(mux))
+		put_device(mux->dev);
+}
+EXPORT_SYMBOL_GPL(typec_mux_put);
+
+/**
+ * typec_mux_register - Register Multiplexer routing USB Type-C pins
+ * @mux: USB Type-C Connector Multiplexer/DeMultiplexer
+ *
+ * USB Type-C connectors can be used for alternate modes of operation besides
+ * USB when Accessory/Alternate Modes are supported. With some of those modes,
+ * the pins on the connector need to be reconfigured. This function registers
+ * multiplexer switches routing the pins on the connector.
+ */
+int typec_mux_register(struct typec_mux *mux)
+{
+	mutex_lock(&mux_lock);
+	list_add_tail(&mux->entry, &mux_list);
+	mutex_unlock(&mux_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(typec_mux_register);
+
+/**
+ * typec_mux_unregister - Unregister Multiplexer Switch
+ * @sw: USB Type-C Connector Multiplexer/DeMultiplexer
+ *
+ * Unregister mux that was registered with typec_mux_register().
+ */
+void typec_mux_unregister(struct typec_mux *mux)
+{
+	mutex_lock(&mux_lock);
+	list_del(&mux->entry);
+	mutex_unlock(&mux_lock);
+}
+EXPORT_SYMBOL_GPL(typec_mux_unregister);
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 0d44ce6af08f..2408e5c2ed91 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -60,6 +60,12 @@ enum typec_accessory {
 
 #define TYPEC_MAX_ACCESSORY	3
 
+enum typec_orientation {
+	TYPEC_ORIENTATION_NONE,
+	TYPEC_ORIENTATION_NORMAL,
+	TYPEC_ORIENTATION_REVERSE,
+};
+
 /*
  * struct usb_pd_identity - USB Power Delivery identity data
  * @id_header: ID Header VDO
@@ -185,6 +191,8 @@ struct typec_partner_desc {
  * @pd_revision: USB Power Delivery Specification revision if supported
  * @prefer_role: Initial role preference
  * @accessory: Supported Accessory Modes
+ * @sw: Cable plug orientation switch
+ * @mux: Multiplexer switch for Alternate/Accessory Modes
  * @fwnode: Optional fwnode of the port
  * @try_role: Set data role preference for DRP port
  * @dr_set: Set Data Role
@@ -202,6 +210,8 @@ struct typec_capability {
 	int			prefer_role;
 	enum typec_accessory	accessory[TYPEC_MAX_ACCESSORY];
 
+	struct typec_switch	*sw;
+	struct typec_mux	*mux;
 	struct fwnode_handle	*fwnode;
 
 	int		(*try_role)(const struct typec_capability *,
@@ -245,4 +255,8 @@ void typec_set_pwr_role(struct typec_port *port, enum typec_role role);
 void typec_set_vconn_role(struct typec_port *port, enum typec_role role);
 void typec_set_pwr_opmode(struct typec_port *port, enum typec_pwr_opmode mode);
 
+int typec_set_orientation(struct typec_port *port,
+			  enum typec_orientation orientation);
+int typec_set_mode(struct typec_port *port, int mode);
+
 #endif /* __LINUX_USB_TYPEC_H */
diff --git a/include/linux/usb/typec_mux.h b/include/linux/usb/typec_mux.h
new file mode 100644
index 000000000000..12c1b057834b
--- /dev/null
+++ b/include/linux/usb/typec_mux.h
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __USB_TYPEC_MUX
+#define __USB_TYPEC_MUX
+
+#include <linux/list.h>
+#include <linux/usb/typec.h>
+
+struct device;
+
+/**
+ * struct typec_switch - USB Type-C cable orientation switch
+ * @dev: Switch device
+ * @entry: List entry
+ * @set: Callback to the driver for setting the orientation
+ *
+ * USB Type-C pin flipper switch routing the correct data pairs from the
+ * connector to the USB controller depending on the orientation of the cable
+ * plug.
+ */
+struct typec_switch {
+	struct device *dev;
+	struct list_head entry;
+
+	int (*set)(struct typec_switch *sw, enum typec_orientation orientation);
+};
+
+/**
+ * struct typec_switch - USB Type-C connector pin mux
+ * @dev: Mux device
+ * @entry: List entry
+ * @set: Callback to the driver for setting the state of the mux
+ *
+ * Pin Multiplexer/DeMultiplexer switch routing the USB Type-C connector pins to
+ * different components depending on the requested mode of operation. Used with
+ * Accessory/Alternate modes.
+ */
+struct typec_mux {
+	struct device *dev;
+	struct list_head entry;
+
+	int (*set)(struct typec_mux *mux, int state);
+};
+
+struct typec_switch *typec_switch_get(struct device *dev);
+void typec_switch_put(struct typec_switch *sw);
+int typec_switch_register(struct typec_switch *sw);
+void typec_switch_unregister(struct typec_switch *sw);
+
+struct typec_mux *typec_mux_get(struct device *dev);
+void typec_mux_put(struct typec_mux *mux);
+int typec_mux_register(struct typec_mux *mux);
+void typec_mux_unregister(struct typec_mux *mux);
+
+#endif /* __USB_TYPEC_MUX */
-- 
2.16.1

