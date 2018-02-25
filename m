Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-914463-1519594517-2-1629256388887350793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519594516; b=SBZb38X2PbByxiol8Mx2KWA29Pv7hJ1zFI1/jpnKyIHr2C5
    qxt/mkldous7/Jj9OuRve+H5jAN3ntKLz+Vtsq1gLLJqjy6UyYlUUoTd1nS280z1
    b2s1EeqM6swytRjTN/3rGsUYLPoksRIsboX16zxyjktBxabaiBbWvv9pHzhZsQNT
    tJGV71sPynwv95q093bd18SVubVhN67ahLtlueE0LWpKB73HeZSUt9soYE5q4MDw
    VVB02ZDlRQmSit9pcEhbptDhzeQ2ipk1nkGYPoSO5jzcJFZcD1Q0eqnz0xKjGw6R
    qMGE1883e5XHhMmXthx1uQVqLHkO10SHAWWGS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519594516; bh=BjRrppemlNUCgf38iNS7kPc4k70actalCsfLnoOcasE=; b=D
    BeMEjIDoj759OrvKqNJgi72Qkwiq7Yz0T7Z0ih/sbXwEyiJVs5cRLT8go9Qlln+5
    S5xu5F3JfsnI/zGpWY/lxQHA5GJFCxA2sD5pDDD2Hb+H5/6A7BEHJxe4JP+aTAgn
    Q6e8NTfxnAnVe2ES8ls4tGjORtAFLAJlycnv1RUow9yT3+NEuL0jXdbqBo9FCz1G
    95MQc52Yzg37e3t7SZ9O24fWGohUk0uqiHdXlD2GZDbFHpx3S7HpYeX6/iDxEQJK
    skXZQCmKxgbwhPFkBDC0GXvB/rWxCB3rnIb3tV/21Znh6sbzfwfiX1MKUgODwXS9
    tv4bOBUx/aHiifMA8ZgJg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qMFHR6Lq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aoR7dbdS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qMFHR6Lq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aoR7dbdS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeBYVd2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 16:33:28 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34162 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeBYVd0 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 25 Feb 2018 16:33:26 -0500
X-Google-Smtp-Source: AH8x227unm28Ve7qMT0sj//H5hC/2LJqkKlJt8x1JJi9VewH0fG8fNp5nn/d/kUYD7Mar5bnNwCgAA==
Subject: Re: [PATCH v2 05/12] usb: typec: tcpm: Set USB role switch to device
 mode when configured as such
To: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20180225152510.10159-1-hdegoede@redhat.com>
 <20180225152510.10159-6-hdegoede@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <fda5b338-7472-4429-8752-9bd6debf331c@roeck-us.net>
Date: Sun, 25 Feb 2018 13:33:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180225152510.10159-6-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/25/2018 07:25 AM, Hans de Goede wrote:
> Setting the mux to MUX_NONE and the switch to USB_SWITCH_DISCONNECT when
> the data-role is device is not correct. Plenty of devices support
> operating as USB device through a (separate) USB device controller.
> 
> We really need 2 different versions of USB_SWITCH_CONNECT,
> USB_SWITCH_CONNECT_HOST and USB_SWITCH_DEVICE. Rather then modifying the
> tcpc_usb_switch enum for this, simply remove it and switch to the
> usb_role enum which provides exactly this, this will save use needing to
> convert betweent the 2 enums when calling an usb-role-switch driver later.
> 
> Besides switching to the usb_role type, this commit also actually sets the
> mux to TYPEC_MUX_USB and the switch to USB_ROLE_DEVICE instead of setting
> both to none when the data-role is device.
> 
> This commit also makes tcpm_reset_port() call tcpm_mux_set(port,
> TYPEC_MUX_NONE, USB_ROLE_NONE) so that the mux and switch
> do _not_ stay in their last mode after a detach.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> -Added Heikki's Reviewed-by
> ---
>   drivers/usb/typec/tcpm.c | 22 +++++++++++-----------
>   include/linux/usb/tcpm.h |  8 ++------
>   2 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> index 7cd28b700a7f..00ca2822432f 100644
> --- a/drivers/usb/typec/tcpm.c
> +++ b/drivers/usb/typec/tcpm.c
> @@ -618,15 +618,15 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
>   EXPORT_SYMBOL_GPL(tcpm_pd_transmit_complete);
>   
>   static int tcpm_mux_set(struct tcpm_port *port, enum tcpc_mux_mode mode,
> -			enum tcpc_usb_switch config)
> +			enum usb_role usb_role)
>   {
>   	int ret = 0;
>   
> -	tcpm_log(port, "Requesting mux mode %d, config %d, polarity %d",
> -		 mode, config, port->polarity);
> +	tcpm_log(port, "Requesting mux mode %d, usb-role %d, polarity %d",
> +		 mode, usb_role, port->polarity);
>   
>   	if (port->tcpc->mux)
> -		ret = port->tcpc->mux->set(port->tcpc->mux, mode, config,
> +		ret = port->tcpc->mux->set(port->tcpc->mux, mode, usb_role,
>   					   port->polarity);
>   
>   	return ret;
> @@ -742,14 +742,15 @@ static int tcpm_set_attached_state(struct tcpm_port *port, bool attached)
>   static int tcpm_set_roles(struct tcpm_port *port, bool attached,
>   			  enum typec_role role, enum typec_data_role data)
>   {
> +	enum usb_role usb_role;
>   	int ret;
>   
>   	if (data == TYPEC_HOST)
> -		ret = tcpm_mux_set(port, TYPEC_MUX_USB,
> -				   TCPC_USB_SWITCH_CONNECT);
> +		usb_role = USB_ROLE_HOST;
>   	else
> -		ret = tcpm_mux_set(port, TYPEC_MUX_NONE,
> -				   TCPC_USB_SWITCH_DISCONNECT);
> +		usb_role = USB_ROLE_DEVICE;
> +
> +	ret = tcpm_mux_set(port, TYPEC_MUX_USB, usb_role);
>   	if (ret < 0)
>   		return ret;
>   
> @@ -2096,7 +2097,7 @@ static int tcpm_src_attach(struct tcpm_port *port)
>   out_disable_pd:
>   	port->tcpc->set_pd_rx(port->tcpc, false);
>   out_disable_mux:
> -	tcpm_mux_set(port, TYPEC_MUX_NONE, TCPC_USB_SWITCH_DISCONNECT);
> +	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
>   	return ret;
>   }
>   
> @@ -2140,6 +2141,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
>   	tcpm_init_vconn(port);
>   	tcpm_set_current_limit(port, 0, 0);
>   	tcpm_set_polarity(port, TYPEC_POLARITY_CC1);
> +	tcpm_mux_set(port, TYPEC_MUX_NONE, USB_ROLE_NONE);
>   	tcpm_set_attached_state(port, false);
>   	port->try_src_count = 0;
>   	port->try_snk_count = 0;
> @@ -2190,8 +2192,6 @@ static int tcpm_snk_attach(struct tcpm_port *port)
>   static void tcpm_snk_detach(struct tcpm_port *port)
>   {
>   	tcpm_detach(port);
> -
> -	/* XXX: (Dis)connect SuperSpeed mux? */
>   }
>   
>   static int tcpm_acc_attach(struct tcpm_port *port)
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index ca1c0b57f03f..268721bff2c1 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -16,6 +16,7 @@
>   #define __LINUX_USB_TCPM_H
>   
>   #include <linux/bitops.h>
> +#include <linux/usb/role.h>
>   #include <linux/usb/typec.h>
>   #include "pd.h"
>   
> @@ -97,11 +98,6 @@ struct tcpc_config {
>   	const struct typec_altmode_desc *alt_modes;
>   };
>   
> -enum tcpc_usb_switch {
> -	TCPC_USB_SWITCH_CONNECT,
> -	TCPC_USB_SWITCH_DISCONNECT,
> -};
> -
>   /* Mux state attributes */
>   #define TCPC_MUX_USB_ENABLED		BIT(0)	/* USB enabled */
>   #define TCPC_MUX_DP_ENABLED		BIT(1)	/* DP enabled */
> @@ -118,7 +114,7 @@ enum tcpc_mux_mode {
>   
>   struct tcpc_mux_dev {
>   	int (*set)(struct tcpc_mux_dev *dev, enum tcpc_mux_mode mux_mode,
> -		   enum tcpc_usb_switch usb_config,
> +		   enum usb_role usb_role,
>   		   enum typec_cc_polarity polarity);
>   	bool dfp_only;
>   	void *priv_data;
> 

