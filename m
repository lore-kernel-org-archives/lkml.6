Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071678-1518619959-2-4116362997624348471
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518619958; b=ZjGqqGetoh0MOXpsE2Iq4dWin3PPwIdctIfInvcrClTkHXR
    C5sF2mJPxGuQvIAg8CcsuO2UkAMkrNjhSx/91nALyt5vILkhcethEK9LzvWoapFH
    gqF8f0WWSEnv2M6OnwaYj0J++lh+ZChdVVToXK/TV7IbLZz+gGLfuhTShpf2aQz/
    2nR67q8gHYHX7zHT+ig7U2BC6QHxIn0YhxqUYFmRO2NhAWm/a8RVhRudIh0TkK91
    MHVC/zV9kFnGd2lUmtgpxMPw03BTPaihh8S8CiSBzvIKwOa5dif+RRwhnrjVg5AP
    QXiztrWJmDTO5jKG42e4ClsFZTD44C8oEcE4pEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518619958; bh=SiXAI2horxYBmhQnRSaFSDCmRr/ml+xGK29UdOVP0RA=; b=S
    z9hOY+LLmmvZ4tTpTrMAb8nzxE0Qognq62XsA9NLpOSPfHD+vds8H2owi8wr/uw9
    UmZxNvP1pk/81wm3xOnQ2v1D2OrokFKhf2HCpG8FTN5IOYUTLDnKc43heohfePDG
    Y+D8qBJoUdhTwZGtMWFJ+SVv7XgBpbezLsZBnCaOPLRLBRwdpKlKdae45cJPrBpe
    9aPqoL8m+XDsVP1SKKrr0Iqo6n9ug2gvDdtdpc3QWbpwtb8XQq0aKywOP/kasH5u
    BccvO9KyhU5T2dzA1xnYNJXMp3jQYVCFXTw8OnUVuhAfo4p+FYhFUYBNJyuggb2i
    TYXVEb7jDwxVFQ0tvT2KQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FyCDD4or x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3bR6CRK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=FyCDD4or x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3bR6CRK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030986AbeBNOw0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 09:52:26 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36892 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030822AbeBNOqk (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Feb 2018 09:46:40 -0500
X-Google-Smtp-Source: AH8x2240b1mgR1AeKemA13WmQyawVDj9yP7z77xIJQo4Uq/nsCMyWnlgVvUrVgHf4GZdildG5UqI5w==
Subject: Re: [PATCH v2] staging: typec: handle vendor defined part and modify
 drp toggling flow
To: ShuFanLee <leechu729@gmail.com>, heikki.krogerus@linux.intel.com
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        cy_huang@richtek.com, shufan_lee@richtek.com
References: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <71b01ca3-99ce-8af4-0967-0aaca4ea6fcf@roeck-us.net>
Date: Wed, 14 Feb 2018 06:46:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518612334-24140-1-git-send-email-leechu729@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 04:45 AM, ShuFanLee wrote:
> From: ShuFanLee <shufan_lee@richtek.com>
> 
> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tcpci_irq.
> More operations can be extended in tcpci_data if needed.
> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> TCPC shall not start DRP toggling until subsequently the TCPM
> writes to the COMMAND register to start DRP toggling.
> DRP toggling flow is chagned as following:
>    - Write DRP = 0 & Rd/Rd
>    - Write DRP = 1
>    - Set LOOK4CONNECTION command
> 
> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
> ---
>   drivers/staging/typec/tcpci.c | 111 ++++++++++++++++++++++++++++++++++--------
>   drivers/staging/typec/tcpci.h |  13 +++++
>   2 files changed, 103 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
> index 9bd4412..461fbd48 100644
> --- a/drivers/staging/typec/tcpci.c
> +++ b/drivers/staging/typec/tcpci.c
> @@ -21,7 +21,6 @@
>   
>   struct tcpci {
>   	struct device *dev;
> -	struct i2c_client *client;
>   
>   	struct tcpm_port *port;
>   
> @@ -30,6 +29,7 @@ struct tcpci {
>   	bool controls_vbus;
>   
>   	struct tcpc_dev tcpc;
> +	struct tcpci_data *data;
>   };
>   
>   static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
> @@ -98,8 +98,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>   static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>   				    enum typec_cc_status cc)
>   {
> +	int ret;
>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> -	unsigned int reg = TCPC_ROLE_CTRL_DRP;
> +	unsigned int reg = (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
>   
>   	switch (cc) {
>   	default:
> @@ -116,8 +118,19 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>   			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>   		break;
>   	}
> -
> -	return regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> +	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> +	if (ret < 0)
> +		return ret;
> +	usleep_range(500, 1000);
> +	reg |= TCPC_ROLE_CTRL_DRP;
> +	ret = regmap_write(tcpci->regmap, TCPC_ROLE_CTRL, reg);
> +	if (ret < 0)
> +		return ret;
> +	ret = regmap_write(tcpci->regmap, TCPC_COMMAND,
> +			   TCPC_CMD_LOOK4CONNECTION);
> +	if (ret < 0)
> +		return ret;
> +	return 0;
>   }
>   
>   static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> @@ -178,6 +191,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>   	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>   	int ret;
>   
> +	/* Handle vendor set vconn */
> +	if (tcpci->data) {
> +		if (tcpci->data->set_vconn) {
> +			ret = tcpci->data->set_vconn(tcpci, tcpci->data,
> +						     enable);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
>   	ret = regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
>   			   enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>   	if (ret < 0)
> @@ -323,6 +346,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>   	if (time_after(jiffies, timeout))
>   		return -ETIMEDOUT;
>   
> +	/* Handle vendor init */
> +	if (tcpci->data) {
> +		if (tcpci->data->init) {
> +			ret = tcpci->data->init(tcpci, tcpci->data);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
>   	/* Clear all events */
>   	ret = tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
>   	if (ret < 0)
> @@ -344,9 +376,16 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>   	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>   }
>   
> -static irqreturn_t tcpci_irq(int irq, void *dev_id)
> +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
>   {
>   	struct tcpci *tcpci = dev_id;
> +
> +	tcpci_irq(tcpci);
> +	return IRQ_HANDLED;

This should probably be
	return tcpci_irq(tcpci);

> +}
> +
> +int tcpci_irq(struct tcpci *tcpci)

and this should be

irqreturn_t tcpci_irq(struct tcpci *tcpci)

Otherwise it doesn't add value to have tcpci_irq() return anything.
Alternative would be to make it

void tcpci_irq(struct tcpci *tcpci)

if it will always only return IRQ_HANDLED.

Guenter

> +{
>   	u16 status;
>   
>   	tcpci_read16(tcpci, TCPC_ALERT, &status);
> @@ -412,6 +451,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>   
>   	return IRQ_HANDLED;
>   }
> +EXPORT_SYMBOL_GPL(tcpci_irq);
>   
>   static const struct regmap_config tcpci_regmap_config = {
>   	.reg_bits = 8,
> @@ -435,22 +475,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
>   	return 0;
>   }
>   
> -static int tcpci_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *i2c_id)
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>   {
>   	struct tcpci *tcpci;
>   	int err;
>   
> -	tcpci = devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
> +	tcpci = devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
>   	if (!tcpci)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>   
> -	tcpci->client = client;
> -	tcpci->dev = &client->dev;
> -	i2c_set_clientdata(client, tcpci);
> -	tcpci->regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
> -	if (IS_ERR(tcpci->regmap))
> -		return PTR_ERR(tcpci->regmap);
> +	tcpci->dev = dev;
> +	tcpci->data = data;
> +	tcpci->regmap = data->regmap;
>   
>   	tcpci->tcpc.init = tcpci_init;
>   	tcpci->tcpc.get_vbus = tcpci_get_vbus;
> @@ -467,27 +503,60 @@ static int tcpci_probe(struct i2c_client *client,
>   
>   	err = tcpci_parse_config(tcpci);
>   	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
>   
>   	/* Disable chip interrupts */
>   	tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
>   
> -	err = devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
> -					tcpci_irq,
> +	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> +	if (PTR_ERR_OR_ZERO(tcpci->port))
> +		return ERR_CAST(tcpci->port);
> +
> +	return tcpci;
> +}
> +EXPORT_SYMBOL_GPL(tcpci_register_port);
> +
> +void tcpci_unregister_port(struct tcpci *tcpci)
> +{
> +	tcpm_unregister_port(tcpci->port);
> +}
> +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
> +
> +static int tcpci_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *i2c_id)
> +{
> +	struct tcpci *tcpci;
> +	struct tcpci_data *data;
> +	int err;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	tcpci = tcpci_register_port(&client->dev, data);
> +	if (PTR_ERR_OR_ZERO(tcpci))
> +		return PTR_ERR(tcpci);
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					_tcpci_irq,
>   					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>   					dev_name(tcpci->dev), tcpci);

I am a bit concerned that this may cause problems, since tcpm_register_port()
will send messages to the driver, which may trigger interrupts. It may be
necessary to register interrupts early, prior to calling tcpci_register_port().

>   	if (err < 0)
>   		return err;

You'll need to call tcpm_unregister_port() here (or register the interrupt first).

Guenter

>   
> -	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> -	return PTR_ERR_OR_ZERO(tcpci->port);
> +	i2c_set_clientdata(client, tcpci);
> +	return 0;
>   }
>   
>   static int tcpci_remove(struct i2c_client *client)
>   {
>   	struct tcpci *tcpci = i2c_get_clientdata(client);
>   
> -	tcpm_unregister_port(tcpci->port);
> +	tcpci_unregister_port(tcpci);
>   
>   	return 0;
>   }
> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
> index fdfb06c..c838723 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>   #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>   
>   #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_DRPRST		BIT(5)
>   #define TCPC_CC_STATUS_TERM		BIT(4)
>   #define TCPC_CC_STATUS_CC2_SHIFT	2
>   #define TCPC_CC_STATUS_CC2_MASK		0x3
> @@ -121,4 +122,16 @@
>   #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>   #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
>   
> +struct tcpci;
> +struct tcpci_data {
> +	struct regmap *regmap;
> +	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
> +	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
> +			 bool enable);
> +};
> +
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> +void tcpci_unregister_port(struct tcpci *tcpci);
> +int tcpci_irq(struct tcpci *tcpci);
> +
>   #endif /* __LINUX_USB_TCPCI_H */
> 

