Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-168518-1519572490-2-16996868364616015356
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
    t=1519572490; b=uKUYXCIW1hiDEL7wBhaQBr5AuGEIAAffaiR3QVnbICihWW7
    Q1Bo3U4xNC/Rngpjp5VwihEl2uLrCm/VtM2JlAP7tS4xtbxQoB95dfn0NYk3J4uc
    602rvMANqBgupMAm7XwAR0hXs6FambEu/6GqnLdkz6SagtEMcmftpuoQZl3rqYhu
    l8UCEYC3LfuVd6evZeC2lLkM++kpJ4MFmdNdDTWvWTsvqDI/61bMn1TIDE+Wl0f8
    h2HcTSRIS1eqCI/aY2lssEVjFn3d3wX1NVaV3VQqSnL/qwgqo/hBJ7ITg4DJtg4C
    ORxkU9/Y/zypUyaEyYnE7RUKo3w0h10GcumpObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572490;
    bh=c4U7wcOc50iyJcC4c8RcguceDj6k0BPU5S4mu1Uq2Ac=; b=kn5mUL+KXVW4
    Y0lX861ZgrvKZEesOCRPnb3hxvSxKdstpwi2gFVFMU4gyP7msnf/q1jiMrlh86K8
    O85CpwcvRoEBm3gZUfB0XSlAk2Wyw2QOEf3dGSMfs7qz9+IHgDtOhDK/kiDccuNP
    aU59h60UQvnaCxTSeiPaVBv1V6aThAJhyb8Qc8oGzew7qYFw9hyZcIDIpG25+UFU
    DVBNeFzntxrOf6m5ag/G23VOYZR8y47tpwHhpFPohlNcmvm7wKdGvL8rMPjV2gkT
    drhbWeYmRq9GzfLz4zLiLJrvjRYNFqPlooOMb83pQtdA6gOhsYprpandOSdpanoo
    g74+VyGBUQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeBYP1r (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:27:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751762AbeBYPZW (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:22 -0500
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
Subject: [PATCH v2 05/12] usb: typec: tcpm: Set USB role switch to device mode when configured as such
Date: Sun, 25 Feb 2018 16:25:03 +0100
Message-Id: <20180225152510.10159-6-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Setting the mux to MUX_NONE and the switch to USB_SWITCH_DISCONNECT when
the data-role is device is not correct. Plenty of devices support
operating as USB device through a (separate) USB device controller.

We really need 2 different versions of USB_SWITCH_CONNECT,
USB_SWITCH_CONNECT_HOST and USB_SWITCH_DEVICE. Rather then modifying the
tcpc_usb_switch enum for this, simply remove it and switch to the
usb_role enum which provides exactly this, this will save use needing to
convert betweent the 2 enums when calling an usb-role-switch driver later.

Besides switching to the usb_role type, this commit also actually sets the
mux to TYPEC_MUX_USB and the switch to USB_ROLE_DEVICE instead of setting
both to none when the data-role is device.

This commit also makes tcpm_reset_port() call tcpm_mux_set(port,
TYPEC_MUX_NONE, USB_ROLE_NONE) so that the mux and switch
do _not_ stay in their last mode after a detach.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Added Heikki's Reviewed-by
---
 drivers/usb/typec/tcpm.c | 22 +++++++++++-----------
 include/linux/usb/tcpm.h |  8 ++------
 2 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 7cd28b700a7f..00ca2822432f 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -618,15 +618,15 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
 static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
-			enum tcpc_usb_switch config)
+			enum usb_role usb_role)
 {
 	int ret = 0;
 
-	tcpm_log(port, "Requesting mux mode %d, config %d, polarity %d",
-		 mode, config, port->polarity);
+	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
+		 mode, usb_role, port->polarity);
 
 	if (port->tcpc->mux)
-		ret = port->tcpc->mux->set(port->tcpc->mux, mode, config,
+		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
 					   port->polarity);
 
 	return ret;
@@ -742,14 +742,15 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
 static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 			  enum typec_role role, enum typec_data_role data)
 {
+	enum usb_role usb_role;
 	int ret;
 
 	if (data == TYPEC_HOST)
-		ret = tcpm_mux_set(port, TYPEC_MUX_USB,
-				   TCPC_USB_SWITCH_CONNECT);
+		usb_role = USB_ROLE_HOST;
 	else
-		ret = tcpm_mux_set(port, TYPEC_MUX_NONE,
-				   TCPC_USB_SWITCH_DISCONNECT);
+		usb_role = USB_ROLE_DEVICE;
+
+	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
 	if (ret < 0)
 		return ret;
 
@@ -2096,7 +2097,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, TCPC_USB_SWITCH_DISCONNECT);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	return ret;
 }
 
@@ -2140,6 +2141,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
+	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
@@ -2190,8 +2192,6 @@ static int tcpm_snk_attach(struct tcpm_port *port)
 static void tcpm_snk_detach(struct tcpm_port *port)
 {
 	tcpm_detach(port);
-
-	/* XXX: (Dis)connect SuperSpeed mux? */
 }
 
 static int tcpm_acc_attach(struct tcpm_port *port)
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index ca1c0b57f03f..268721bff2c1 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -16,6 +16,7 @@
 #define __LINUX_USB_TCPM_H
 
 #include <linux/bitops.h>
+#include <linux/usb/role.h>
 #include <linux/usb/typec.h>
 #include "pd.h"
 
@@ -97,11 +98,6 @@ struct tcpc_config {
 	const struct typec_altmode_desc *alt_modes;
 };
 
-enum tcpc_usb_switch {
-	TCPC_USB_SWITCH_CONNECT,
-	TCPC_USB_SWITCH_DISCONNECT,
-};
-
 /* Mux state attributes */
 #define TCPC_MUX_USB_ENABLED		BIT(0)	/* USB enabled */
 #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
@@ -118,7 +114,7 @@ enum tcpc_mux_mode {
 
 struct tcpc_mux_dev {
 	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
-		   enum tcpc_usb_switch usb_config,
+		   enum usb_role usb_role,
 		   enum typec_cc_polarity polarity);
 	bool dfp_only;
 	void *priv_data;
-- 
2.14.3

