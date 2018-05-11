Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044742-2-4479885884289573743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES roenca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044741; b=Af0Y44aluSSBpzq3gzJMzQbKV/OJouiDB0W4LL57+lrH5FLPF6
    GfWOVRE9rMCSt9mjcYBBj/E5/P4hQOEkFEJCngLjNR3agBrMpI5K+sv7Ae1tVOfP
    GWb6jrEYoyGp97YGpFbm1ttL2n4w5E93laq+mPVYTNd+lJWw44cUzGsz2z6V0GY8
    SCdQsyLXll1+qQ1kBpOag+PYsyWbDCMp2CvZWlHXLkeS70S9NWodX6n2xsjRURJ+
    A4FI1IWQXQh3opX8hyRt5PhXN2woxID68XGUQeeJA6abVY+beIVw9lLhsTfvDiQk
    6mRWWzfTsD9/FOAz8VmhcyjkQ4xBsak4tyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1526044741; bh=
    AO1E8tubx1Zx8xIeFqruECG2Lp2/bJOxb+ZLQGBlSS4=; b=CB23oZF/U/L4BeA5
    XSrYLmMV4coKrs0N6cp0RtILEzi4Fl83TARjC7+yImqOV3+gFGrAOZvMNRiE4e7R
    mjx8BIDrrO+vy3fVWA56JLFcMYeCiH/80Qvze8T/uQkKbitInU4mqR64mBoHFbm3
    PVqQ9o92a1uo/z4RClh1vZDb3DP3QldAvFFoXn2b6mZtn4OOglp4fG/PCDS1W11C
    80Y67QvEcEfyiY2sJiMFXHQy5W8izWBjK5s6WxmHnJ8G+WmySQWLztmmt4CbbWCw
    R13ADi1tcHRFOz6IhzTrrfh/16eFe8FatFCoK2UogglaVU1JUsXY1dPtuN0A28JO
    DUw57g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNp36Ro2qOIZ9cAO8Q04gquhD6je9XhJ2U/5LE7IjcMP526aHWGzHWzuji9aRrNivFdKhme+zNk8QVe7OcT/0bHCQISCOU80YbiH5ToKGjLw5+pexqfz
    RuYXwmRHTKmk0mcZ/vf3R7malmiBxpgvhfS6KRhAvWjQQssGWleOb5L5ckI49kdmmLFT59bWfoI+9KNmpFqmYtM6CR0kIpitV6wD+rUZbDoMJ+toMWIChnw1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=17ScjJ5uj_PSez4jstcA:9 a=eK7QmAa5amsRGPdc:21
    a=aU_eJ-IqpaJfWRlx:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeEKNSz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:18:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:43629 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750758AbeEKNSy (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 11 May 2018 09:18:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="54341765"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jun Li <jun.li@nxp.com>, Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 5/5] usb: typec: tcpm: Support for Alternate Modes
Date: Fri, 11 May 2018 16:18:38 +0300
Message-Id: <20180511131838.62064-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds more complete handling of VDMs and registration of
partner alternate modes, and introduces callbacks for
alternate mode operations.

Only DFP role is supported for now.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm.c | 156 +++++++++++++++++++++++++++++++--------
 include/linux/usb/tcpm.h |   9 ---
 2 files changed, 127 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index c13b986f9d7b..a08c87c21c33 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -168,13 +168,14 @@ enum pd_msg_request {
 /* Alternate mode support */
 
 #define SVID_DISCOVERY_MAX	16
+#define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
 
 struct pd_mode_data {
 	int svid_index;		/* current SVID index		*/
 	int nsvids;
 	u16 svids[SVID_DISCOVERY_MAX];
 	int altmodes;		/* number of alternate modes	*/
-	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
+	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
 };
 
 struct pd_pps_data {
@@ -309,8 +310,8 @@ struct tcpm_port {
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
-	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
-	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
+	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
+	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
 
 	/* Deadline in jiffies to exit src_try_wait state */
 	unsigned long max_wait;
@@ -644,14 +645,14 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 }
 EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
 
-static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
+static int tcpm_mux_set(struct tcpm_port *port, int state,
 			enum usb_role usb_role,
 			enum typec_orientation orientation)
 {
 	int ret;
 
-	tcpm_log(port, "Requesting mux mode %d, usb-role %d, orientation %d",
-		 mode, usb_role, orientation);
+	tcpm_log(port, "Requesting mux state %d, usb-role %d, orientation %d",
+		 state, usb_role, orientation);
 
 	ret = typec_set_orientation(port->typec_port, orientation);
 	if (ret)
@@ -663,7 +664,7 @@ static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
 			return ret;
 	}
 
-	return typec_set_mode(port->typec_port, mode);
+	return typec_set_mode(port->typec_port, state);
 }
 
 static int tcpm_set_polarity(struct tcpm_port *port,
@@ -790,7 +791,7 @@ static int tcpm_set_roles(struct tcpm_port *port, bool attached,
 	else
 		usb_role = USB_ROLE_DEVICE;
 
-	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role, orientation);
+	ret = tcpm_mux_set(port, TYPEC_STATE_USB, usb_role, orientation);
 	if (ret < 0)
 		return ret;
 
@@ -1017,36 +1018,57 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
 			 pmdata->altmodes, paltmode->svid,
 			 paltmode->mode, paltmode->vdo);
 
-		port->partner_altmode[pmdata->altmodes] =
-			typec_partner_register_altmode(port->partner, paltmode);
-		if (!port->partner_altmode[pmdata->altmodes]) {
-			tcpm_log(port,
-				 "Failed to register modes for SVID 0x%04x",
-				 paltmode->svid);
-			return;
-		}
 		pmdata->altmodes++;
 	}
 }
 
+static void tcpm_register_partner_altmodes(struct tcpm_port *port)
+{
+	struct pd_mode_data *modep = &port->mode_data;
+	struct typec_altmode *altmode;
+	int i;
+
+	for (i = 0; i < modep->altmodes; i++) {
+		altmode = typec_partner_register_altmode(port->partner,
+						&modep->altmode_desc[i]);
+		if (!altmode)
+			tcpm_log(port, "Failed to register partner SVID 0x%04x",
+				 modep->altmode_desc[i].svid);
+		port->partner_altmode[i] = altmode;
+	}
+}
+
 #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
 
 static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			u32 *response)
 {
-	u32 p0 = le32_to_cpu(payload[0]);
-	int cmd_type = PD_VDO_CMDT(p0);
-	int cmd = PD_VDO_CMD(p0);
+	struct typec_altmode *adev;
+	struct typec_altmode *pdev;
 	struct pd_mode_data *modep;
+	u32 p[PD_MAX_PAYLOAD];
 	int rlen = 0;
-	u16 svid;
+	int cmd_type;
+	int cmd;
 	int i;
 
+	for (i = 0; i < cnt; i++)
+		p[i] = le32_to_cpu(payload[i]);
+
+	cmd_type = PD_VDO_CMDT(p[0]);
+	cmd = PD_VDO_CMD(p[0]);
+
 	tcpm_log(port, "Rx VDM cmd 0x%x type %d cmd %d len %d",
-		 p0, cmd_type, cmd, cnt);
+		 p[0], cmd_type, cmd, cnt);
 
 	modep = &port->mode_data;
 
+	adev = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
+				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
+	pdev = typec_match_altmode(port->partner_altmode, ALTMODE_DISCOVERY_MAX,
+				   PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
+
 	switch (cmd_type) {
 	case CMDT_INIT:
 		switch (cmd) {
@@ -1068,17 +1090,19 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		case CMD_EXIT_MODE:
 			break;
 		case CMD_ATTENTION:
-			break;
+			/* Attention command does not have response */
+			typec_altmode_attention(adev, p[1]);
+			return 0;
 		default:
 			break;
 		}
 		if (rlen >= 1) {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_ACK);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_ACK);
 		} else if (rlen == 0) {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_NAK);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
 			rlen = 1;
 		} else {
-			response[0] = p0 | VDO_CMDT(CMDT_RSP_BUSY);
+			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
 			rlen = 1;
 		}
 		break;
@@ -1111,14 +1135,36 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			svdm_consume_modes(port, payload, cnt);
 			modep->svid_index++;
 			if (modep->svid_index < modep->nsvids) {
-				svid = modep->svids[modep->svid_index];
+				u16 svid = modep->svids[modep->svid_index];
 				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
 				rlen = 1;
 			} else {
-				/* enter alternate mode if/when implemented */
+				tcpm_register_partner_altmodes(port);
 			}
 			break;
 		case CMD_ENTER_MODE:
+			typec_altmode_update_active(pdev, true);
+
+			if (typec_altmode_vdm(adev, p[0], &p[1], cnt))
+				WARN_ON(typec_altmode_exit(pdev));
+			return 0;
+		case CMD_EXIT_MODE:
+			typec_altmode_update_active(pdev, false);
+
+			/* Back to USB Operation */
+			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
+						     NULL));
+			break;
+		default:
+			break;
+		}
+		break;
+	case CMDT_RSP_NAK:
+		switch (cmd) {
+		case CMD_ENTER_MODE:
+			/* Back to USB Operation */
+			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
+						     NULL));
 			break;
 		default:
 			break;
@@ -1128,6 +1174,9 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		break;
 	}
 
+	/* Informing the alternate mode drivers about everything */
+	typec_altmode_vdm(adev, p[0], &p[1], cnt);
+
 	return rlen;
 }
 
@@ -1411,6 +1460,53 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 	return 0;
 }
 
+static void tcpm_altmode_enter(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	mutex_lock(&port->lock);
+	header = VDO(altmode->svid, 1, CMD_ENTER_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+}
+
+static void tcpm_altmode_exit(struct typec_altmode *altmode)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+	u32 header;
+
+	mutex_lock(&port->lock);
+	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
+	header |= VDO_OPOS(altmode->mode);
+
+	tcpm_queue_vdm(port, header, NULL, 0);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+}
+
+static int tcpm_altmode_vdm(struct typec_altmode *altmode,
+			    u32 header, const u32 *data, int count)
+{
+	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
+
+	mutex_lock(&port->lock);
+	tcpm_queue_vdm(port, header, data, count - 1);
+	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
+	mutex_unlock(&port->lock);
+
+	return 0;
+}
+
+static const struct typec_altmode_ops tcpm_altmode_ops = {
+	.enter = tcpm_altmode_enter,
+	.exit = tcpm_altmode_exit,
+	.vdm = tcpm_altmode_vdm,
+};
+
 /*
  * PD (data, control) command handling functions
  */
@@ -2542,7 +2638,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
 out_disable_pd:
 	port->tcpc->set_pd_rx(port->tcpc, false);
 out_disable_mux:
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	return ret;
 }
@@ -2588,7 +2684,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_init_vconn(port);
 	tcpm_set_current_limit(port, 0, 0);
 	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
-	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE,
+	tcpm_mux_set(port, TYPEC_STATE_SAFE, USB_ROLE_NONE,
 		     TYPEC_ORIENTATION_NONE);
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
@@ -4619,6 +4715,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 					 dev_name(dev), paltmode->svid);
 				break;
 			}
+			typec_altmode_set_drvdata(alt, port);
+			alt->ops = &tcpm_altmode_ops;
 			port->port_altmode[i] = alt;
 			i++;
 			paltmode++;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index b231b9314240..8c3df3e11801 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -98,15 +98,6 @@ struct tcpc_config {
 #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
 #define TCPC_MUX_POLARITY_INVERTED	BIT(2)	/* Polarity inverted */
 
-/* Mux modes, decoded to attributes */
-enum tcpc_mux_mode {
-	TYPEC_MUX_NONE	= 0,				/* Open switch */
-	TYPEC_MUX_USB	= TCPC_MUX_USB_ENABLED,		/* USB only */
-	TYPEC_MUX_DP	= TCPC_MUX_DP_ENABLED,		/* DP only */
-	TYPEC_MUX_DOCK	= TCPC_MUX_USB_ENABLED |	/* Both USB and DP */
-			  TCPC_MUX_DP_ENABLED,
-};
-
 /**
  * struct tcpc_dev - Port configuration and callback functions
  * @config:	Pointer to port configuration
-- 
2.17.0

