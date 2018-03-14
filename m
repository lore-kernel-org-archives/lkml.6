Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1734499-1521033293-2-5473216612651670903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521033292; b=EhYAtiOMJDrq7EkSCTKL8Pn/iyRvnWGvl3T/ZaZN4VyA7nL
    g5wwfNUimLVZCLzeZmwU+iDcEQcsifDI9wqwZ57p9C9I9rBcVvm5vEcm6N1a6IB0
    /58WOxYJhA8E2ybj80xUaX3/qr0M1D74ai2qqze+QXaC8C7ls4CVaXJj0KT6ZRER
    Inm+KiDZqAFmp3GdJZ+hQlJDvvztLht46IkyGo4TTJtKOBUkC1FIaHrVgLPfnk/j
    J6JhGMMPq6tOgKhk9wXslPzLH6p1KIjU+t3Kf2+twhvRo80EGW2Eqrq4IZsRsd05
    ho4pk7aKfXXqHmF21PfV/Kq8yNUYP13oq54z1vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521033292;
    bh=S5IKb6qeCnYEhoc1R+NoZce0iDpOX1L9fW9/Qn9tfOs=; b=e+BTfq2PJuwF
    yRuN1zpTlA9qhjdghDTRMj/CMVJE3q+U9oNKheNO+a2nSjvK2DlWUTGf+2akwhhM
    jUp+sapHYg7a9MRk8pXo9IK8DIsflEt0o9A1ocnD8Zdwn0EXomUq78MITnk+6Z2U
    Tyo/0YdMAbM9zhwoN2ZebSLSiAb/0CmxfM1i0Nea+W7wao7KCuQschFiuTzKXgD3
    aYafd3F2Vd/kRQwgu32hIVA5UmYJWrYA/KpeuAf132AW3BrRQich5dKLA5GBaPK3
    Xq4LwDJyE7+eeOjxpd7MYI99VbxUXN6SSxR0jV0PZUZTFvojPvuXf9oG/enVFPVU
    Ld3+H5jVbA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
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
        id S1752520AbeCNNOh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:14:37 -0400
Received: from mga07.intel.com ([134.134.136.100]:3923 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeCNNMn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 09:12:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991685"
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
Subject: [PATCH v8 06/12] usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch functions
Date: Wed, 14 Mar 2018 16:12:09 +0300
Message-Id: <20180314131215.70833-7-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
References: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hans de Goede <hdegoede@redhat.com>

Remove the unused (not implemented anywhere) tcpc_mux_dev abstraction
and replace it with calling the new typec_set_orientation,
usb_role_switch_set and typec_set_mode functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
-Add Andy's Reviewed-by

Changes in v3:
-Add Guenter's Reviewed-by

Changes in v2:
-Added Heikki's Reviewed-by
---
 drivers/usb/typec/Kconfig           |  1 +
 drivers/usb/typec/fusb302/fusb302.c |  1 -
 drivers/usb/typec/tcpm.c            | 46 ++++++++++++++++++++++++++++---------
 include/linux/usb/tcpm.h            | 10 --------
 4 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/typec/Kconfig b/drivers/usb/typec/Kconfig
index bcb2744c5977..a2a0684e7c82 100644
--- a/drivers/usb/typec/Kconfig
+++ b/drivers/usb/typec/Kconfig
@@ -48,6 +48,7 @@ if TYPEC
 config TYPEC_TCPM
 	tristate "USB Type-C Port Controller Manager"
 	depends on USB
+	select USB_ROLE_SWITCH
 	help
 	  The Type-C Port Controller Manager provides a USB PD and USB Type-C
 	  state machine for use with Type-C Port Controllers.
diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index f2d98c3c1f30..f0a2f8954bbd 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -1239,7 +1239,6 @@ static void init_tcpc_dev(struct tcpc_dev *fusb302_tcpc_dev)
 	fusb302_tcpc_dev->set_roles = tcpm_set_roles;
 	fusb302_tcpc_dev->start_drp_toggling = tcpm_start_drp_toggling;
 	fusb302_tcpc_dev->pd_transmit = tcpm_pd_transmit;
-	fusb302_tcpc_dev->mux = NULL;
 }
 
 static const char * const cc_polarity_name[] = {
diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 5e527e2e1506..3f0851bfe18f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -20,6 +20,7 @@
 #include <linux/usb/pd.h>
 #include <linux/usb/pd_bdo.h>
 #include <linux/usb/pd_vdo.h>
+#include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
 #include <linux/workqueue.h>
@@ -176,6 +177,7 @@ struct tcpm_port {
 	struct typec_port *typec_port;
 
 	struct tcpc_dev	*tcpc;
+	struct usb_role_switch *role_sw;
 
 	enum typec_role vconn_role;
 	enum typec_role pwr_role;
@@ -607,18 +609,25 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
 static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
-			enum usb_role usb_role)
+			enum usb_role usb_role,
+			enum typec_orientation orientation)
 {
-	int ret = 0;
+	int ret;
 
-	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
-		 mode, usb_role, port->polarity);
+	tcpm_log(port, "Requesting mux mode %d, usb-role %d, orientation %d",
+		 mode, usb_role, orientation);
 
-	if (port->tcpc->mux)
-		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
-					   port->polarity);
+	ret = typec_set_orientation(port->typec_port, orientation);
+	if (ret)
+		return ret;
 
-	return ret;
+	if (port->role_sw) {
+		ret = usb_role_switch_set_role(port->role_sw, usb_role);
+		if (ret)
+			return ret;
+	}
+
+	return typec_set_mode(port->typec_port, mode);
 }
 
 static int tcpm_set_polarity(struct tcpm_port *port,
@@ -731,15 +740,21 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 			  enum typec_role role, enum typec_data_role data)
 {
+	enum typec_orientation orientation;
 	enum usb_role usb_role;
 	int ret;
 
+	if (port->polarity == TYPEC_POLARITY_CC1)
+		orientation = TYPEC_ORIENTATION_NORMAL;
+	else
+		orientation = TYPEC_ORIENTATION_REVERSE;
+
 	if (data == TYPEC_HOST)
 		usb_role = USB_ROLE_HOST;
 	else
 		usb_role = USB_ROLE_DEVICE;
 
-	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
+	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -2086,7 +2101,8 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
 
@@ -2130,7 +2146,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -3732,6 +3749,12 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 	port->port_type = tcpc->config->type;
 
+	port->role_sw = usb_role_switch_get(port->dev);
+	if (IS_ERR(port->role_sw)) {
+		err = PTR_ERR(port->role_sw);
+		goto out_destroy_wq;
+	}
+
 	port->typec_port = typec_register_port(port->dev, &port->typec_caps);
 	if (IS_ERR(port->typec_port)) {
 		err = PTR_ERR(port->typec_port);
@@ -3767,6 +3790,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	return port;
 
 out_destroy_wq:
+	usb_role_switch_put(port->role_sw);
 	destroy_workqueue(port->wq);
 	return ERR_PTR(err);
 }
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 3e8bdaa5085a..f0d839daeaea 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,7 +16,6 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
-#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -113,14 +112,6 @@ enum tcpc_mux_mode {
 			  TCPC_MUX_DP_ENABLED,
 };
 
-struct tcpc_mux_dev {
-	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
-		   enum usb_role usb_role,
-		   enum typec_cc_polarity polarity);
-	bool dfp_only;
-	void *priv_data;
-};
-
 /**
  * struct tcpc_dev - Port configuration and callback functions
  * @config:	Pointer to port configuration
@@ -172,7 +163,6 @@ struct tcpc_dev {
 	int (*try_role)(struct tcpc_dev *dev, int role);
 	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
 			   const struct pd_message *msg);
-	struct tcpc_mux_dev *mux;
 };
 
 struct tcpm_port;
-- 
2.16.1

