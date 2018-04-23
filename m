Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1286548-1524492785-2-16499339986341273
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_WORDY 2.5, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES roensk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='GB'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524492784; b=VbKVA5Ou4koaw0Vlsu3046ESpKSKwOIuBSIdi3lcp8Zcy6zYU7
    7cn2TTw976g9Injfsb5pyC6b0VOPXK6dWEHUcROsF02603PDjmGAfevkaBhmh+sZ
    YtAElfe1sz2JsHVewAeDz1tsg/V/Sw9Z48Olr5eUNcIKnMJWqC5Eon7RwK/QykUj
    IIoV1V6SQjVraaJA7atcz3wkjOr5soXeGHCOSnA9B6UDeEEOSrFI2QcKB0Ckwpea
    l45GMB1FXWWgpMSWSE9r40tm8l7mLlDDvhwLBZ2yULQ9+xt6RRdM2l/+A+NmIgcC
    bC37tWaHVOrEJ/o00Lz6ViSW9b72taigX63Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:in-reply-to:references:from
    :date:subject:to:cc:mime-version:content-type:sender:list-id; s=
    fm2; t=1524492784; bh=RtA4WvprojRa0jowVfcWen+om8axqCMBLm/9SaSwMP
    Y=; b=qjVEg8w9iONIHld9P/9nYUWWUf3VAOwSG0LEEc4EggOfzZjRa1GqRs5e7w
    Sl7bd0JDwvT9a//+etYJ0Vunv0u0N8GZmejrjh8liuE8/6oYES/y8oddTcqR4fKy
    /jdLPykt/SRu/Pw4kir3iwkL6I9UtT+MHBHOZ+bkvTb0qGkoWCxtr0C5kEOsbONb
    1T6acODo7IhHwFY9Ij70EH4ObfbolmVSA7poykqbwdeSjJKBMEzDoa1tFW0B/v3x
    U4AzLo+6lAmHgX5jCpXD2z56SPv1KKr0xNZuUw/KHQm+M/U05LfeyZjZWhYUYwQz
    AFFSZcJT1/4gJmmXcvpZaDuqG95Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=diasemi.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=diasemi.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKoVSaXIb0d4aHN5RW07kYk2kfh/GbfylQLyY1OiuZJuXcWv6JU5aPOeenV0faEls7XBMq8DuL+XfbzIyR6nHQe4wfAu4aqkaPfMTJ6+HEyu+m20HhKK
    B+L+G6aERRfqNDgI2EqTmqQm5T3mmbXlqYS2lKxeKOKceE4zL6EmiILHBwOtc6bPF/O2iadDB3sHzuqe17wV8HtDlPYkAndsfYbRWVd9011UNOuyuDB7/mIZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=QRjQRLzp78EA:10 a=Kd1tUaAdevIA:10
    a=X3a0BiUdAAAA:8 a=QyXUC8HyAAAA:8 a=_jlGtV7tAAAA:8 a=VwQbUJbxAAAA:8
    a=0YxI6ZFVX9mkkzgxLIQA:9 a=x8gzFH9gYPwA:10 a=aWu3muFgq6otJbhCXpL5:22
    a=nlm17XC03S6CtCLSeiRr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755543AbeDWOLO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:11:14 -0400
Received: from mail1.bemta5.messagelabs.com ([195.245.231.149]:14397 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755494AbeDWOLD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 10:11:03 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42KJ27nUWLfs5d0
  og0et4hbNi9ezWbw5Pp3Jomv1ThaLa8d6mSwu75rDZvG59wijxaJlrcwWTxaeYbI4vbvEgdNj
  06pONo95JwM99s9dw+6x8d0OJo/3+66yeez83sDu8XmTXAB7FGtmXlJ+RQJrRv+MFawFRy0r9
  t9ewtrAeNCgi5GLQ0hgPaPEiilnmboYOYGcCokbVyaygdi8ApkSCw9NA4tzCrhLdE/6yAZR4y
  Zxue0NI4jNJmAhMfnEA7A4i4CqxPT9P8HiwgJ+Eu0919lAFogIvGeU+PT4AwtIglmgTqL391s
  WiAWCEidnPoGKS0gcfPGCGWKBgcTpBY1gcQkBe4np768CxTmAbH2JxmOxEGFDie+zvkGVmEvc
  P9zFNoFRcBaSqbOQTF3AyLSKUb04tagstUjXVC+pKDM9oyQ3MTNH19DAVC83tbg4MT01JzGpW
  C85P3cTIzBGGIBgB+OXfudDjJIcTEqivJbn70YJ8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuCteA
  GUEyxKTU+tSMvMAUYrTFqCg0dJhDcOJM1bXJCYW5yZDpE6xWjM8W33zl5mjn839/cyC7Hk5ee
  lSonzuoKUCoCUZpTmwQ2CJZFLjLJSwryMQKcJ8RSkFuVmlqDKv2IU52BUEuYtAZnCk5lXArfv
  FdApTECndEjeATmlJBEhJdXAGCvsn7l15gnznh1/PxtXTC8u25nC+Gx59G1hg5sbiu8e4H3Gw
  ZN+4cAdgecFYo3n28TjdFy3n7y4I2KPjuz5m88SG8RcnA8kmMgWbPnVrKzO4PFIfvKEXYw3fF
  cITX6oozrnt5weT+r6A5xMe/pn7Ux+GhHa17C4zHva2dXrv9y4LHHCWdWgV4mlOCPRUIu5qDg
  RAAdIlJ4dAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-178.messagelabs.com!1524492661!118034431!1
X-Originating-IP: [94.185.165.51]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Message-ID: <53be031004d3178dca11aaba38dbe4de2ac0c0d9.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
In-Reply-To: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Mon, 23 Apr 2018 15:11:01 +0100
Subject: [PATCH v8 6/6] typec: tcpm: Add support for sink PPS related messages
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
X-KSE-Antivirus-Info: Clean, bases: 23/04/2018 11:44:00
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm.c | 143 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 7547097..4483dc4 100644
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
 #include <linux/usb/role.h>
 #include <linux/usb/tcpm.h>
@@ -114,6 +116,11 @@
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
@@ -144,6 +151,7 @@ enum pd_msg_request {
 	PD_MSG_NONE = 0,
 	PD_MSG_CTRL_REJECT,
 	PD_MSG_CTRL_WAIT,
+	PD_MSG_CTRL_NOT_SUPP,
 	PD_MSG_DATA_SINK_CAP,
 	PD_MSG_DATA_SOURCE_CAP,
 };
@@ -1411,10 +1419,42 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
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
@@ -1502,6 +1542,14 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
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
@@ -1584,6 +1632,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		break;
 	case PD_CTRL_REJECT:
 	case PD_CTRL_WAIT:
+	case PD_CTRL_NOT_SUPP:
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			/* USB PD specification, Figure 8-43 */
@@ -1703,12 +1752,75 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
+
+	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
+		tcpm_log(port, "Unchunked extended messages unsupported");
+		return;
+	}
+
+	if (data_size > PD_EXT_MAX_CHUNK_DATA) {
+		tcpm_log(port, "Chunk handling not yet supported");
+		return;
+	}
+
+	switch (type) {
+	case PD_EXT_STATUS:
+		/*
+		 * If PPS related events raised then get PPS status to clear
+		 * (see USB PD 3.0 Spec, 6.5.2.4)
+		 */
+		if (msg->ext_msg.data[USB_PD_EXT_SDB_EVENT_FLAGS] &
+		    USB_PD_EXT_SDB_PPS_EVENTS)
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
+		tcpm_log(port, "Unhandled extended message type %#x", type);
+		break;
+	}
+}
+
 static void tcpm_pd_rx_handler(struct work_struct *work)
 {
 	struct pd_rx_event *event = container_of(work,
@@ -1749,7 +1861,9 @@ static void tcpm_pd_rx_handler(struct work_struct *work)
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
@@ -1810,6 +1924,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 		case PD_MSG_CTRL_REJECT:
 			tcpm_pd_send_control(port, PD_CTRL_REJECT);
 			break;
+		case PD_MSG_CTRL_NOT_SUPP:
+			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
+			break;
 		case PD_MSG_DATA_SINK_CAP:
 			tcpm_pd_send_sink_caps(port);
 			break;
@@ -2572,14 +2689,6 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
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
@@ -3279,6 +3388,22 @@ static void run_state_machine(struct tcpm_port *port)
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

