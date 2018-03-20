Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1584206-1521556492-5-14002364805880274253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.499, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES roen, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521556491; b=njLkFwm2VN7acjo/pvWmRonR4jA9rmiI7+biB+3Sq6Waqqh
    Dh/M7By5Mu3WZMdczlFZmarA9KijIuVMPqY3TtKPUTBVY29RftQvQrn7Vcir3Irc
    JWEghRhUJolmi+rbeaaSmy0EP2WJDXFvDOYB3Cc6NMTDQiT265pV0UAEGMW8BuUD
    Uf6num/bOzZoIGJsx8HiTwhvmuFtGkKhcYWCzvf91Q/+P8ekuhH+ce4EIQvZrVuI
    m55cNqajj/I1fHqlzCjFChySjBy6x2DwjZAqLu8R5NAXXxa7ZlCvj8pFXXorjIyD
    xstgYOCZy3jrxiNJgcHXoaH3W0oiE/FGS1u5e8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    arctest; t=1521556491; bh=WmIPQTqvLRhL6gNaXanzFpVrtK4+RkaySokYC0
    3oDi0=; b=uJwgjpJAihjLGWyOkMoemigKtz1yP6BZVslZgokpYUdEpdpmh+jMsK
    DbiZG/W96MXLM6lER40ty/+BtFzvBbBJpVz75f4dPaVti6zAy7O2CTNvP6wkuQUj
    rKi0amRbpg2ktoCc8QOmIobWcP5OYA2Iv5qnAoIsQ3VyWhQhAGJrQUQqRqRx9T1b
    x6zidCMXx3mOPiu/1WwZc1l7QJ0bI16IMaed1sH3QejpmxVzj/iWc0rxRBbmwYH8
    jTbh+lSyM38Iek/2kFV+0T1+WYH/ak94fRRdLdLaASACUFF59JqSyBDt/aCmJG+G
    2QfmA5YZJPkuLgRPeKxdGOubrb9vgPMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCTOeA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 10:34:00 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.8]:30763 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750828AbeCTOdy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Mar 2018 10:33:54 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRWlGSWpSXmKPExsUSt3Opse4Z6Y1
  RBjNWs1s0L17PZvHm+HQmi67VO1ksrh3rZbK4vGsOm8Xn3iOMFouWtTJbPFl4hsni9O4SB06P
  Tas62TzmnQz02D93DbvHxnc7mDze77vK5rHzewO7x+dNcgHsUayZeUn5FQmsGRfmtzEW3LCq+
  PlZqYFxl2EXIxeHkMB6Rok/2/6xdjFyAjkVEoc/nWUEsXkFMiV+LD7MBGJzCrhLvPn5gx2ixk
  3iwKwjbCA2m4CFxOQTD8BsFgFViaUN38HmCAv4SVxbuYAdZIGIwHtGiU+PP7CAJJgF6iR6f79
  lgVggKHFy5hOouITEwRcvmCEWGEicXtAIFpcQsJeY/v4qUJwDyNaXaDwWCxE2lPg+6xtUibnE
  wlUrmSYwCs5CMnUWkqkLGJlWMVomFWWmZ5TkJmbm6BoaGOgaGhrrGusaGVvqJVbpJuqlluomp
  +aVFCUCZfUSy4v1iitzk3NS9PJSSzYxAqOIAQh2ME45lHiIUZKDSUmUt/PXhighvqT8lMqMxO
  KM+KLSnNTiQ4wyHBxKErynpDZGCQkWpaanVqRl5gDjGSYtwcGjJMJbDJLmLS5IzC3OTIdInWI
  05rjx4nUbM0fDplXdzEIsefl5qVLivOkgpQIgpRmleXCDYGnmEqOslDAvI9BpQjwFqUW5mSWo
  8q8YxTkYlYR5b4FM4cnMK4Hb9wroFCagU7JnbgA5pSQRISXVwLh4dkuVzJf8n2XFLF3O/gm2x
  eXd0x5ni5jJ15nNv1u5rOaggWjAp4IPLl9O7xaWbTh5M3Tjkohtp5tSenKf/4hlTPXYKmu0RC
  r2e/7k406xfD+qTu3JUD5jcYh9s3nj9ff/Yw/x3mrQaZ9bvFpcVEn11GcbUfsAuRe/vERPFwv
  Meyi0QW7WTyWW4oxEQy3mouJEACf12c4uAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-31.tower-223.messagelabs.com!1521556427!509073!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <cb45050153fa8304584441a7a7401a138514ddc1.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1521552959.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 20 Mar 2018 14:33:47 +0000
Subject: [PATCH v5 5/5] typec: tcpm: Add support for sink PPS related messages
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>
CC: <linux-usb@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20/03/2018 12:34:00
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds sink side support for Get_Status, Status,
Get_PPS_Status and PPS_Status handling. As there's the
potential for a partner to respond with Not_Supported,
handling of this message is also added. Sending of
Not_Supported is added to handle messagescreceived but not
yet handled.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm.c | 152 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 143 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 18ab36f..148db99 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -19,7 +19,9 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/pd_ado.h>
 #include <linux/usb/pd_bdo.h>
+#include <linux/usb/pd_ext_sdb.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec.h>
@@ -113,6 +115,11 @@
 	S(SNK_TRYWAIT_VBUS),			\
 	S(BIST_RX),				\
 						\
+	S(GET_STATUS_SEND),			\
+	S(GET_STATUS_SEND_TIMEOUT),		\
+	S(GET_PPS_STATUS_SEND),			\
+	S(GET_PPS_STATUS_SEND_TIMEOUT),		\
+						\
 	S(ERROR_RECOVERY),			\
 	S(PORT_RESET),				\
 	S(PORT_RESET_WAIT_OFF)
@@ -143,6 +150,7 @@ enum pd_msg_request {
 	PD_MSG_NONE = 0,
 	PD_MSG_CTRL_REJECT,
 	PD_MSG_CTRL_WAIT,
+	PD_MSG_CTRL_NOT_SUPP,
 	PD_MSG_DATA_SINK_CAP,
 	PD_MSG_DATA_SOURCE_CAP,
 };
@@ -1398,10 +1406,42 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
 /*
  * PD (data, control) command handling functions
  */
+static inline enum tcpm_state ready_state(struct tcpm_port *port)
+{
+	if (port->pwr_role == TYPEC_SOURCE)
+		return SRC_READY;
+	else
+		return SNK_READY;
+}
 
 static int tcpm_pd_send_control(struct tcpm_port *port,
 				enum pd_ctrl_msg_type type);
 
+static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
+			      int cnt)
+{
+	u32 p0 = le32_to_cpu(payload[0]);
+	unsigned int type = usb_pd_ado_type(p0);
+
+	if (!type) {
+		tcpm_log(port, "Alert message received with no type");
+		return;
+	}
+
+	/* Just handling non-battery alerts for now */
+	if (!(type & USB_PD_ADO_TYPE_BATT_STATUS_CHANGE)) {
+		switch (port->state) {
+		case SRC_READY:
+		case SNK_READY:
+			tcpm_set_state(port, GET_STATUS_SEND, 0);
+			break;
+		default:
+			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
+			break;
+		}
+	}
+}
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1487,6 +1527,14 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			tcpm_set_state(port, BIST_RX, 0);
 		}
 		break;
+	case PD_DATA_ALERT:
+		tcpm_handle_alert(port, msg->payload, cnt);
+		break;
+	case PD_DATA_BATT_STATUS:
+	case PD_DATA_GET_COUNTRY_INFO:
+		/* Currently unsupported */
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
 	default:
 		tcpm_log(port, "Unhandled data message type %#x", type);
 		break;
@@ -1569,6 +1617,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		break;
 	case PD_CTRL_REJECT:
 	case PD_CTRL_WAIT:
+	case PD_CTRL_NOT_SUPP:
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			/* USB PD specification, Figure 8-43 */
@@ -1688,12 +1737,84 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			break;
 		}
 		break;
+	case PD_CTRL_GET_SOURCE_CAP_EXT:
+	case PD_CTRL_GET_STATUS:
+	case PD_CTRL_FR_SWAP:
+	case PD_CTRL_GET_PPS_STATUS:
+	case PD_CTRL_GET_COUNTRY_CODES:
+		/* Currently not supported */
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
 	default:
 		tcpm_log(port, "Unhandled ctrl message type %#x", type);
 		break;
 	}
 }
 
+static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
+				    const struct pd_message *msg)
+{
+	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
+	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
+	u8 *data;
+
+	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
+		tcpm_log(port, "Unchunked extended messages unsupported");
+		return;
+	}
+
+	if (data_size > (PD_EXT_MAX_CHUNK_DATA)) {
+		tcpm_log(port, "Chunk handling not yet supported");
+		return;
+	}
+
+	data = kzalloc(data_size, GFP_KERNEL);
+	if (!data) {
+		tcpm_log(port, "Failed to allocate memory for ext msg data");
+		return;
+	}
+	memcpy(data, msg->ext_msg.data, data_size);
+
+	switch (type) {
+	case PD_EXT_STATUS:
+		/*
+		 * If PPS related events raised then get PPS status to clear
+		 * (see USB PD 3.0 Spec, 6.5.2.4)
+		 */
+		if (data[USB_PD_EXT_SDB_EVENT_FLAGS] & USB_PD_EXT_SDB_PPS_EVENTS)
+			tcpm_set_state(port, GET_PPS_STATUS_SEND, 0);
+		else
+			tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case PD_EXT_PPS_STATUS:
+		/*
+		 * For now the PPS status message is used to clear events
+		 * and nothing more.
+		 */
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case PD_EXT_SOURCE_CAP_EXT:
+	case PD_EXT_GET_BATT_CAP:
+	case PD_EXT_GET_BATT_STATUS:
+	case PD_EXT_BATT_CAP:
+	case PD_EXT_GET_MANUFACTURER_INFO:
+	case PD_EXT_MANUFACTURER_INFO:
+	case PD_EXT_SECURITY_REQUEST:
+	case PD_EXT_SECURITY_RESPONSE:
+	case PD_EXT_FW_UPDATE_REQUEST:
+	case PD_EXT_FW_UPDATE_RESPONSE:
+	case PD_EXT_COUNTRY_INFO:
+	case PD_EXT_COUNTRY_CODES:
+		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
+		break;
+	default:
+		tcpm_log(port, "Unhandle extended message type %#x", type);
+		break;
+	}
+
+	kfree(data);
+}
+
 static void tcpm_pd_rx_handler(struct work_struct *work)
 {
 	struct pd_rx_event *event = container_of(work,
@@ -1734,7 +1855,9 @@ static void tcpm_pd_rx_handler(struct work_struct *work)
 				 "Data role mismatch, initiating error recovery");
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 		} else {
-			if (cnt)
+			if (msg->header & PD_HEADER_EXT_HDR)
+				tcpm_pd_ext_msg_request(port, msg);
+			else if (cnt)
 				tcpm_pd_data_request(port, msg);
 			else
 				tcpm_pd_ctrl_request(port, msg);
@@ -1795,6 +1918,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 		case PD_MSG_CTRL_REJECT:
 			tcpm_pd_send_control(port, PD_CTRL_REJECT);
 			break;
+		case PD_MSG_CTRL_NOT_SUPP:
+			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+			break;
 		case PD_MSG_DATA_SINK_CAP:
 			tcpm_pd_send_sink_caps(port);
 			break;
@@ -2481,14 +2607,6 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
 	return SNK_UNATTACHED;
 }
 
-static inline enum tcpm_state ready_state(struct tcpm_port *port)
-{
-	if (port->pwr_role == TYPEC_SOURCE)
-		return SRC_READY;
-	else
-		return SNK_READY;
-}
-
 static inline enum tcpm_state unattached_state(struct tcpm_port *port)
 {
 	if (port->port_type == TYPEC_PORT_DRP) {
@@ -3191,6 +3309,22 @@ static void run_state_machine(struct tcpm_port *port)
 		/* Always switch to unattached state */
 		tcpm_set_state(port, unattached_state(port), 0);
 		break;
+	case GET_STATUS_SEND:
+		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
+		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
+			       PD_T_SENDER_RESPONSE);
+		break;
+	case GET_STATUS_SEND_TIMEOUT:
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
+	case GET_PPS_STATUS_SEND:
+		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
+		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
+			       PD_T_SENDER_RESPONSE);
+		break;
+	case GET_PPS_STATUS_SEND_TIMEOUT:
+		tcpm_set_state(port, ready_state(port), 0);
+		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
 		tcpm_pps_complete(port, -EPROTO);
-- 
1.9.1

