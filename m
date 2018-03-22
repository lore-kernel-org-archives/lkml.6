Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3613467-1521750746-2-14234864618775660098
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521750746; b=g75aQmZCTgtgZcOrkBQV/znlDtKUVoElM9LZz0efZeH/4Gy
    hohxmt0RpWnoe6U3qGI8ckTkIbGZSiAL4YBVZD4g5QpglE7TjOafgy3rMgirq39U
    2GHJT7cXFMaCLBnDKyhdDsmYlh51A66bEK2Y/KKfhU381ZkJjWRHOgSpgAYtJBKB
    f5g7aW41gOoAppoGR8xLtbID63kPE3qB5fKscRI/y20f3bEi58zewcjRiCantpmj
    GpK042qnmBjWP4X5LnuL4rKLg797peCH+f3CsjS+mWHxKvKcklWc6f4xAEn/fPgb
    RbLz+tShMnuabK37yQwqLKy1DC6EkO0ktOLstdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521750746; bh=h0CUcTrLA+V03iobR5SqMMx8w5
    jIBEP75samJryiP7I=; b=b2Mc3e5aMKvMZ6BiFr0xhmuhRPuDVd3cxz9iE+kqO2
    A1vGVbQhiY0Y3xpkzMWLENhEJHsqIITGWPS6pBgXzVg5GCCjzbRRN0o9LntgJPaa
    9gBsEluagjv5UeRefCdk5Nrgsjy4aDrHzp+WThCPw5HdwGnlL5G2ciYPlCj+CmdD
    PcDKP1jvCqmKIGTkpL0bYboerB2jPr7HWbs03sb3jIuGxcAwnR3IZitrP+2G3n1i
    bMr0Nfk2/Zb7td/V/Cf9bgEuWPGSMkUapi2Sng/wzUySPoXzDV2vw5cdQ0UToY2/
    SMCvhMfLWyhr6NOMKDtA+emJpyOz5plukdagYt+sp8uQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nBDzMmnw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6nRwZnR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=nBDzMmnw x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=t6nRwZnR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751966AbeCVUcP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 16:32:15 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43962 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751901AbeCVUcN (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 16:32:13 -0400
X-Google-Smtp-Source: AG47ELsKQA3p+uP+eklxCoOdv8w2UMzpiBuMgBj5/v7gZVmDLi7L+d/iEUW/l9CI16V16Uq7n4KiSw==
Date: Thu, 22 Mar 2018 13:32:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, support.opensource@diasemi.com
Subject: Re: [PATCH v6 6/6] typec: tcpm: Add support for sink PPS related
 messages
Message-ID: <20180322203211.GC8509@roeck-us.net>
References: <cover.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
 <f5c0fb8a751eb2fbf627a7633669fea6f927b0c6.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c0fb8a751eb2fbf627a7633669fea6f927b0c6.1521732966.git.Adam.Thomson.Opensource@diasemi.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 22, 2018 at 03:52:07PM +0000, Adam Thomson wrote:
> This commit adds sink side support for Get_Status, Status,
> Get_PPS_Status and PPS_Status handling. As there's the
> potential for a partner to respond with Not_Supported,
> handling of this message is also added. Sending of
> Not_Supported is added to handle messagescreceived but not
> yet handled.
> 
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/usb/typec/tcpm.c | 143 ++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 134 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index c859cba..fffe97d 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -19,7 +19,9 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/usb/pd.h>
> +#include <linux/usb/pd_ado.h>
>  #include <linux/usb/pd_bdo.h>
> +#include <linux/usb/pd_ext_sdb.h>
>  #include <linux/usb/pd_vdo.h>
>  #include <linux/usb/tcpm.h>
>  #include <linux/usb/typec.h>
> @@ -113,6 +115,11 @@
>  	S(SNK_TRYWAIT_VBUS),			\
>  	S(BIST_RX),				\
>  						\
> +	S(GET_STATUS_SEND),			\
> +	S(GET_STATUS_SEND_TIMEOUT),		\
> +	S(GET_PPS_STATUS_SEND),			\
> +	S(GET_PPS_STATUS_SEND_TIMEOUT),		\
> +						\
>  	S(ERROR_RECOVERY),			\
>  	S(PORT_RESET),				\
>  	S(PORT_RESET_WAIT_OFF)
> @@ -143,6 +150,7 @@ enum pd_msg_request {
>  	PD_MSG_NONE = 0,
>  	PD_MSG_CTRL_REJECT,
>  	PD_MSG_CTRL_WAIT,
> +	PD_MSG_CTRL_NOT_SUPP,
>  	PD_MSG_DATA_SINK_CAP,
>  	PD_MSG_DATA_SOURCE_CAP,
>  };
> @@ -1398,10 +1406,42 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>  /*
>   * PD (data, control) command handling functions
>   */
> +static inline enum tcpm_state ready_state(struct tcpm_port *port)
> +{
> +	if (port->pwr_role == TYPEC_SOURCE)
> +		return SRC_READY;
> +	else
> +		return SNK_READY;
> +}
>  
>  static int tcpm_pd_send_control(struct tcpm_port *port,
>  				enum pd_ctrl_msg_type type);
>  
> +static void tcpm_handle_alert(struct tcpm_port *port, const __le32 *payload,
> +			      int cnt)
> +{
> +	u32 p0 = le32_to_cpu(payload[0]);
> +	unsigned int type = usb_pd_ado_type(p0);
> +
> +	if (!type) {
> +		tcpm_log(port, "Alert message received with no type");
> +		return;
> +	}
> +
> +	/* Just handling non-battery alerts for now */
> +	if (!(type & USB_PD_ADO_TYPE_BATT_STATUS_CHANGE)) {
> +		switch (port->state) {
> +		case SRC_READY:
> +		case SNK_READY:
> +			tcpm_set_state(port, GET_STATUS_SEND, 0);
> +			break;
> +		default:
> +			tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
> +			break;
> +		}
> +	}
> +}
> +
>  static void tcpm_pd_data_request(struct tcpm_port *port,
>  				 const struct pd_message *msg)
>  {
> @@ -1487,6 +1527,14 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  			tcpm_set_state(port, BIST_RX, 0);
>  		}
>  		break;
> +	case PD_DATA_ALERT:
> +		tcpm_handle_alert(port, msg->payload, cnt);
> +		break;
> +	case PD_DATA_BATT_STATUS:
> +	case PD_DATA_GET_COUNTRY_INFO:
> +		/* Currently unsupported */
> +		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
> +		break;
>  	default:
>  		tcpm_log(port, "Unhandled data message type %#x", type);
>  		break;
> @@ -1569,6 +1617,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  		break;
>  	case PD_CTRL_REJECT:
>  	case PD_CTRL_WAIT:
> +	case PD_CTRL_NOT_SUPP:
>  		switch (port->state) {
>  		case SNK_NEGOTIATE_CAPABILITIES:
>  			/* USB PD specification, Figure 8-43 */
> @@ -1688,12 +1737,75 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>  			break;
>  		}
>  		break;
> +	case PD_CTRL_GET_SOURCE_CAP_EXT:
> +	case PD_CTRL_GET_STATUS:
> +	case PD_CTRL_FR_SWAP:
> +	case PD_CTRL_GET_PPS_STATUS:
> +	case PD_CTRL_GET_COUNTRY_CODES:
> +		/* Currently not supported */
> +		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
> +		break;
>  	default:
>  		tcpm_log(port, "Unhandled ctrl message type %#x", type);
>  		break;
>  	}
>  }
>  
> +static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
> +				    const struct pd_message *msg)
> +{
> +	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
> +	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
> +
> +	if (!(msg->ext_msg.header && PD_EXT_HDR_CHUNKED)) {
> +		tcpm_log(port, "Unchunked extended messages unsupported");
> +		return;
> +	}
> +
> +	if (data_size > (PD_EXT_MAX_CHUNK_DATA)) {

I really think you can trust that the compiler understands that it is supposed
to compare against PD_EXT_MAX_CHUNK_DATA.

> +		tcpm_log(port, "Chunk handling not yet supported");
> +		return;
> +	}
> +
> +	switch (type) {
> +	case PD_EXT_STATUS:
> +		/*
> +		 * If PPS related events raised then get PPS status to clear
> +		 * (see USB PD 3.0 Spec, 6.5.2.4)
> +		 */
> +		if (msg->ext_msg.data[USB_PD_EXT_SDB_EVENT_FLAGS] &
> +		    USB_PD_EXT_SDB_PPS_EVENTS)
> +			tcpm_set_state(port, GET_PPS_STATUS_SEND, 0);
> +		else
> +			tcpm_set_state(port, ready_state(port), 0);
> +		break;
> +	case PD_EXT_PPS_STATUS:
> +		/*
> +		 * For now the PPS status message is used to clear events
> +		 * and nothing more.
> +		 */
> +		tcpm_set_state(port, ready_state(port), 0);
> +		break;
> +	case PD_EXT_SOURCE_CAP_EXT:
> +	case PD_EXT_GET_BATT_CAP:
> +	case PD_EXT_GET_BATT_STATUS:
> +	case PD_EXT_BATT_CAP:
> +	case PD_EXT_GET_MANUFACTURER_INFO:
> +	case PD_EXT_MANUFACTURER_INFO:
> +	case PD_EXT_SECURITY_REQUEST:
> +	case PD_EXT_SECURITY_RESPONSE:
> +	case PD_EXT_FW_UPDATE_REQUEST:
> +	case PD_EXT_FW_UPDATE_RESPONSE:
> +	case PD_EXT_COUNTRY_INFO:
> +	case PD_EXT_COUNTRY_CODES:
> +		tcpm_queue_message(port, PD_MSG_CTRL_NOT_SUPP);
> +		break;
> +	default:
> +		tcpm_log(port, "Unhandle extended message type %#x", type);

s/Unhandle/Unhandled/

> +		break;
> +	}
> +}
> +
>  static void tcpm_pd_rx_handler(struct work_struct *work)
>  {
>  	struct pd_rx_event *event = container_of(work,
> @@ -1734,7 +1846,9 @@ static void tcpm_pd_rx_handler(struct work_struct *work)
>  				 "Data role mismatch, initiating error recovery");
>  			tcpm_set_state(port, ERROR_RECOVERY, 0);
>  		} else {
> -			if (cnt)
> +			if (msg->header & PD_HEADER_EXT_HDR)
> +				tcpm_pd_ext_msg_request(port, msg);
> +			else if (cnt)
>  				tcpm_pd_data_request(port, msg);
>  			else
>  				tcpm_pd_ctrl_request(port, msg);
> @@ -1795,6 +1909,9 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  		case PD_MSG_CTRL_REJECT:
>  			tcpm_pd_send_control(port, PD_CTRL_REJECT);
>  			break;
> +		case PD_MSG_CTRL_NOT_SUPP:
> +			tcpm_pd_send_control(port, PD_CTRL_NOT_SUPP);
> +			break;
>  		case PD_MSG_DATA_SINK_CAP:
>  			tcpm_pd_send_sink_caps(port);
>  			break;
> @@ -2481,14 +2598,6 @@ static inline enum tcpm_state hard_reset_state(struct tcpm_port *port)
>  	return SNK_UNATTACHED;
>  }
>  
> -static inline enum tcpm_state ready_state(struct tcpm_port *port)
> -{
> -	if (port->pwr_role == TYPEC_SOURCE)
> -		return SRC_READY;
> -	else
> -		return SNK_READY;
> -}
> -
>  static inline enum tcpm_state unattached_state(struct tcpm_port *port)
>  {
>  	if (port->port_type == TYPEC_PORT_DRP) {
> @@ -3191,6 +3300,22 @@ static void run_state_machine(struct tcpm_port *port)
>  		/* Always switch to unattached state */
>  		tcpm_set_state(port, unattached_state(port), 0);
>  		break;
> +	case GET_STATUS_SEND:
> +		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
> +		tcpm_set_state(port, GET_STATUS_SEND_TIMEOUT,
> +			       PD_T_SENDER_RESPONSE);
> +		break;
> +	case GET_STATUS_SEND_TIMEOUT:
> +		tcpm_set_state(port, ready_state(port), 0);
> +		break;
> +	case GET_PPS_STATUS_SEND:
> +		tcpm_pd_send_control(port, PD_CTRL_GET_PPS_STATUS);
> +		tcpm_set_state(port, GET_PPS_STATUS_SEND_TIMEOUT,
> +			       PD_T_SENDER_RESPONSE);
> +		break;
> +	case GET_PPS_STATUS_SEND_TIMEOUT:
> +		tcpm_set_state(port, ready_state(port), 0);
> +		break;
>  	case ERROR_RECOVERY:
>  		tcpm_swap_complete(port, -EPROTO);
>  		tcpm_pps_complete(port, -EPROTO);
> -- 
> 1.9.1
> 
