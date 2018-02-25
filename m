Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-153198-1519572445-2-2202413265840145333
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
    t=1519572444; b=PZisRx7eMN9GUjRn6EmwnzvGhYlppchtn9pTkJbBavRyUoA
    OpuwZtdH4GFcGstwW0t1HOvazQ3OvzrUhxOCkciF28zsDYRg2MZ34MYvyNZzN2OM
    cdY+g/YtLdrvd4UfdAw2j59uDshscWCDBbe71KEdeEr+BC/DarDwE75fpsMyUd+s
    VEb9CHjoKpK6ms9ffSDlbNwRVmy/LSFbItyW8iNVreCyecVVPqHf1SNeYt65szus
    O1nOOo/pE0n2KO1bk7i58xNUHdBpAiKZvUD4yLVUDvx/IR0aO9R2kfoPOfd9v5Lg
    buFvQ4EXGFvxPRfWbiLLmGdI7VIMiGk6KivEhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572444;
    bh=ShXz4kgJU0nLwL3xySr4xATLAr0aiH01B9kaDog9clc=; b=rdSQq7ibGDGm
    0nQXuNoyH+vYNLRsqCebBTuDhI+V+9yxWuFbU1jbAyBddi1TYGUEt8IJdUvv/khu
    1jfGQ8C3ucVUx/UgUWudGHsveJwqeDOlcn8P6bRZYRZjWHC70O1W6OCpDjqwg2fs
    ck0VIxv9bifDOWM0gt3ZkVJ0rRXoH9C/AU7dODLDoywlTSKHevbGky/eAhw5MVsC
    HEkIngBx24AogzZ9YFjIwa9paYU7c8re5FtIYdgcyYa8/TcJTJuPmHujbxrKsag7
    Ud261sgGeIuPjehMkVo4JezSHhozhPCl6vtReaq2N86SMlk1Uj5qwfZcahQs566i
    p5U0jPlwaw==
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
        id S1751829AbeBYPZZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:25:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751682AbeBYPZR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:17 -0500
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
Subject: [PATCH v2 02/12] usb: typec: Start using ERR_PTR
Date: Sun, 25 Feb 2018 16:25:00 +0100
Message-Id: <20180225152510.10159-3-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

In order to allow the USB Type-C Class driver take care of
things like muxes and other possible dependencies for the
port drivers, returning ERR_PTR instead of NULL from the
registration functions in case of failure.

The reason for taking over control of the muxes for example
is because handling them in the port drivers would be just
boilerplate.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add IS_ERR_OR_NULL() checks to the unregister functions
---
 drivers/usb/typec/tcpm.c      | 16 +++++++++-------
 drivers/usb/typec/tps6598x.c  | 15 ++++++++-------
 drivers/usb/typec/typec.c     | 44 +++++++++++++++++++++----------------------
 drivers/usb/typec/ucsi/ucsi.c | 31 ++++++++++++++++++------------
 4 files changed, 58 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index f4d563ee7690..7cd28b700a7f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -1044,7 +1044,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		break;
 	case CMDT_RSP_ACK:
 		/* silently drop message if we are not connected */
-		if (!port->partner)
+		if (IS_ERR_OR_NULL(port->partner))
 			break;
 
 		switch (cmd) {
@@ -3743,8 +3743,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->port_type = tcpc->config->type;
 
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
-	if (!port->typec_port) {
-		err = -ENOMEM;
+	if (IS_ERR(port->typec_port)) {
+		err = PTR_ERR(port->typec_port);
 		goto out_destroy_wq;
 	}
 
@@ -3753,15 +3753,17 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 		i = 0;
 		while (paltmode->svid && i < ARRAY_SIZE(port->port_altmode)) {
-			port->port_altmode[i] =
-			  typec_port_register_altmode(port->typec_port,
-						      paltmode);
-			if (!port->port_altmode[i]) {
+			struct typec_altmode *alt;
+
+			alt = typec_port_register_altmode(port->typec_port,
+							  paltmode);
+			if (IS_ERR(alt)) {
 				tcpm_log(port,
 					 "%s: failed to register port alternate mode 0x%x",
 					 dev_name(dev), paltmode->svid);
 				break;
 			}
+			port->port_altmode[i] = alt;
 			i++;
 			paltmode++;
 		}
diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
index 2719f5d382f7..37a15c14a6c6 100644
--- a/drivers/usb/typec/tps6598x.c
+++ b/drivers/usb/typec/tps6598x.c
@@ -158,15 +158,15 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 		desc.identity = &tps->partner_identity;
 	}
 
-	tps->partner = typec_register_partner(tps->port, &desc);
-	if (!tps->partner)
-		return -ENODEV;
-
 	typec_set_pwr_opmode(tps->port, mode);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
 	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
 	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
 
+	tps->partner = typec_register_partner(tps->port, &desc);
+	if (IS_ERR(tps->partner))
+		return PTR_ERR(tps->partner);
+
 	if (desc.identity)
 		typec_partner_set_identity(tps->partner);
 
@@ -175,7 +175,8 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
 
 static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
 {
-	typec_unregister_partner(tps->partner);
+	if (!IS_ERR(tps->partner))
+		typec_unregister_partner(tps->partner);
 	tps->partner = NULL;
 	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
 	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
@@ -418,8 +419,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps->typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
 
 	tps->port = typec_register_port(&client->dev, &tps->typec_cap);
-	if (!tps->port)
-		return -ENODEV;
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_connect(tps, status);
diff --git a/drivers/usb/typec/typec.c b/drivers/usb/typec/typec.c
index 735726ced602..dc28ad868d93 100644
--- a/drivers/usb/typec/typec.c
+++ b/drivers/usb/typec/typec.c
@@ -386,7 +386,7 @@ typec_register_altmode(struct device *parent,
 
 	alt = kzalloc(sizeof(*alt), GFP_KERNEL);
 	if (!alt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	alt->svid = desc->svid;
 	alt->n_modes = desc->n_modes;
@@ -402,7 +402,7 @@ typec_register_altmode(struct device *parent,
 		dev_err(parent, "failed to register alternate mode (%d)\n",
 			ret);
 		put_device(&alt->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return alt;
@@ -417,7 +417,7 @@ typec_register_altmode(struct device *parent,
  */
 void typec_unregister_altmode(struct typec_altmode *alt)
 {
-	if (alt)
+	if (!IS_ERR_OR_NULL(alt))
 		device_unregister(&alt->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_altmode);
@@ -509,7 +509,7 @@ EXPORT_SYMBOL_GPL(typec_partner_register_altmode);
  *
  * Registers a device for USB Type-C Partner described in @desc.
  *
- * Returns handle to the partner on success or NULL on failure.
+ * Returns handle to the partner on success or ERR_PTR on failure.
  */
 struct typec_partner *typec_register_partner(struct typec_port *port,
 					     struct typec_partner_desc *desc)
@@ -519,7 +519,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 
 	partner = kzalloc(sizeof(*partner), GFP_KERNEL);
 	if (!partner)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	partner->usb_pd = desc->usb_pd;
 	partner->accessory = desc->accessory;
@@ -542,7 +542,7 @@ struct typec_partner *typec_register_partner(struct typec_port *port,
 	if (ret) {
 		dev_err(&port->dev, "failed to register partner (%d)\n", ret);
 		put_device(&partner->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return partner;
@@ -557,7 +557,7 @@ EXPORT_SYMBOL_GPL(typec_register_partner);
  */
 void typec_unregister_partner(struct typec_partner *partner)
 {
-	if (partner)
+	if (!IS_ERR_OR_NULL(partner))
 		device_unregister(&partner->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_partner);
@@ -587,7 +587,7 @@ static const struct device_type typec_plug_dev_type = {
  * the plug lists in response to Discover Modes command need to be listed in an
  * array in @desc.
  *
- * Returns handle to the alternate mode on success or NULL on failure.
+ * Returns handle to the alternate mode on success or ERR_PTR on failure.
  */
 struct typec_altmode *
 typec_plug_register_altmode(struct typec_plug *plug,
@@ -606,7 +606,7 @@ EXPORT_SYMBOL_GPL(typec_plug_register_altmode);
  * Cable Plug represents a plug with electronics in it that can response to USB
  * Power Delivery SOP Prime or SOP Double Prime packages.
  *
- * Returns handle to the cable plug on success or NULL on failure.
+ * Returns handle to the cable plug on success or ERR_PTR on failure.
  */
 struct typec_plug *typec_register_plug(struct typec_cable *cable,
 				       struct typec_plug_desc *desc)
@@ -617,7 +617,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 
 	plug = kzalloc(sizeof(*plug), GFP_KERNEL);
 	if (!plug)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sprintf(name, "plug%d", desc->index);
 
@@ -631,7 +631,7 @@ struct typec_plug *typec_register_plug(struct typec_cable *cable,
 	if (ret) {
 		dev_err(&cable->dev, "failed to register plug (%d)\n", ret);
 		put_device(&plug->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return plug;
@@ -646,7 +646,7 @@ EXPORT_SYMBOL_GPL(typec_register_plug);
  */
 void typec_unregister_plug(struct typec_plug *plug)
 {
-	if (plug)
+	if (!IS_ERR_OR_NULL(plug))
 		device_unregister(&plug->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_plug);
@@ -724,7 +724,7 @@ EXPORT_SYMBOL_GPL(typec_cable_set_identity);
  * Registers a device for USB Type-C Cable described in @desc. The cable will be
  * parent for the optional cable plug devises.
  *
- * Returns handle to the cable on success or NULL on failure.
+ * Returns handle to the cable on success or ERR_PTR on failure.
  */
 struct typec_cable *typec_register_cable(struct typec_port *port,
 					 struct typec_cable_desc *desc)
@@ -734,7 +734,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 
 	cable = kzalloc(sizeof(*cable), GFP_KERNEL);
 	if (!cable)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	cable->type = desc->type;
 	cable->active = desc->active;
@@ -757,7 +757,7 @@ struct typec_cable *typec_register_cable(struct typec_port *port,
 	if (ret) {
 		dev_err(&port->dev, "failed to register cable (%d)\n", ret);
 		put_device(&cable->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return cable;
@@ -772,7 +772,7 @@ EXPORT_SYMBOL_GPL(typec_register_cable);
  */
 void typec_unregister_cable(struct typec_cable *cable)
 {
-	if (cable)
+	if (!IS_ERR_OR_NULL(cable))
 		device_unregister(&cable->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_cable);
@@ -1256,7 +1256,7 @@ EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
  * This routine is used to register an alternate mode that @port is capable of
  * supporting.
  *
- * Returns handle to the alternate mode on success or NULL on failure.
+ * Returns handle to the alternate mode on success or ERR_PTR on failure.
  */
 struct typec_altmode *
 typec_port_register_altmode(struct typec_port *port,
@@ -1273,7 +1273,7 @@ EXPORT_SYMBOL_GPL(typec_port_register_altmode);
  *
  * Registers a device for USB Type-C Port described in @cap.
  *
- * Returns handle to the port on success or NULL on failure.
+ * Returns handle to the port on success or ERR_PTR on failure.
  */
 struct typec_port *typec_register_port(struct device *parent,
 				       const struct typec_capability *cap)
@@ -1285,12 +1285,12 @@ struct typec_port *typec_register_port(struct device *parent,
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		kfree(port);
-		return NULL;
+		return ERR_PTR(id);
 	}
 
 	if (cap->type == TYPEC_PORT_DFP)
@@ -1326,7 +1326,7 @@ struct typec_port *typec_register_port(struct device *parent,
 	if (ret) {
 		dev_err(parent, "failed to register port (%d)\n", ret);
 		put_device(&port->dev);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return port;
@@ -1341,7 +1341,7 @@ EXPORT_SYMBOL_GPL(typec_register_port);
  */
 void typec_unregister_port(struct typec_port *port)
 {
-	if (port)
+	if (!IS_ERR_OR_NULL(port))
 		device_unregister(&port->dev);
 }
 EXPORT_SYMBOL_GPL(typec_unregister_port);
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 79046fe66426..69d544cfcd45 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -260,38 +260,45 @@ static void ucsi_pwr_opmode_change(struct ucsi_connector *con)
 
 static int ucsi_register_partner(struct ucsi_connector *con)
 {
-	struct typec_partner_desc partner;
+	struct typec_partner_desc desc;
+	struct typec_partner *partner;
 
 	if (con->partner)
 		return 0;
 
-	memset(&partner, 0, sizeof(partner));
+	memset(&desc, 0, sizeof(desc));
 
 	switch (con->status.partner_type) {
 	case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
-		partner.accessory = TYPEC_ACCESSORY_DEBUG;
+		desc.accessory = TYPEC_ACCESSORY_DEBUG;
 		break;
 	case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
-		partner.accessory = TYPEC_ACCESSORY_AUDIO;
+		desc.accessory = TYPEC_ACCESSORY_AUDIO;
 		break;
 	default:
 		break;
 	}
 
-	partner.usb_pd = con->status.pwr_op_mode == UCSI_CONSTAT_PWR_OPMODE_PD;
+	desc.usb_pd = con->status.pwr_op_mode == UCSI_CONSTAT_PWR_OPMODE_PD;
 
-	con->partner = typec_register_partner(con->port, &partner);
-	if (!con->partner) {
-		dev_err(con->ucsi->dev, "con%d: failed to register partner\n",
-			con->num);
-		return -ENODEV;
+	partner = typec_register_partner(con->port, &desc);
+	if (IS_ERR(partner)) {
+		dev_err(con->ucsi->dev,
+			"con%d: failed to register partner (%ld)\n", con->num,
+			PTR_ERR(partner));
+		return PTR_ERR(partner);
 	}
 
+	con->partner = partner;
+
 	return 0;
 }
 
 static void ucsi_unregister_partner(struct ucsi_connector *con)
 {
+	if (!con->partner)
+		return;
+
 	typec_unregister_partner(con->partner);
 	con->partner = NULL;
 }
@@ -606,8 +613,8 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
 
 	/* Register the connector */
 	con->port = typec_register_port(ucsi->dev, cap);
-	if (!con->port)
-		return -ENODEV;
+	if (IS_ERR(con->port))
+		return PTR_ERR(con->port);
 
 	/* Get the status */
 	UCSI_CMD_GET_CONNECTOR_STATUS(ctrl, con->num);
-- 
2.14.3

