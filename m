Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2578571-1518605822-2-18142111051925147140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518605821; b=pwLWZClStkIHdDWsajGvVsfpsLMtPVhQLGNsQz+0zodJUcZ
    orBM4vTOlDui7Zx+krQVj1T4bh9C1slDPD5F/oZh3qF+hwU78yLYmjQ0avyN/KUu
    htSRK19136NwnHO2b659rAP9pO7otifXNADkS7uyJsBlaJrH2DUDOVXnNYd9isBL
    IUXsw8Zyu3ZOGq0DxK2ZtmWvllJDHal84hSam/6dXEHaZUjqUGY7iDr1VwDllVT1
    UypykPjHUETgRc2fjzp7lNjqV78IxJo4bajTZ9Je6Vbb0PpUAb8gquKplViDhrZL
    jeOq13Pw7h+irGMq8JNdGgyATGwat0aWr15Ti9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518605821; bh=Tz1fjeNJjRDcJFVxPWRjrjpT34
    cEgs443+tB888Zyhw=; b=vmjckvhRhVzGscQ3rhJoLh4XaHuadj6zMesQIWmH8Z
    5v9I/bnXYSSraXh7hwSk7E9Y04MSgLKKs5GVHPQ+MTD0tbmvDyNJyTBHUwChMkQN
    DU12ierwkYSXgzQwH+pJ2gYj64Olqm7T8YHFbOY50whrluerCWIMKSrI2gXz54Xx
    VnKCqceLw29Ms+W0YYPS6JKNSGnOL1q8qrto702RrjodrN87USISwZOmj9nCYhhj
    gKcgXFSd/6bqT4Nlo3VUsrO9v7SVqD4z7t6oJK7h2IucfzeH6RoW6npSChdfzp5s
    ytLjJ0rq8Nk26q09+9rsyoI5JkXjryj3Jok5qnoQZ0zA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967247AbeBNK4r (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 05:56:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:3802 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967159AbeBNK4q (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Feb 2018 05:56:46 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="30662227"
Date: Wed, 14 Feb 2018 12:56:41 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: ShuFanLee <leechu729@gmail.com>
Cc: linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, cy_huang@richtek.com,
        shufan_lee@richtek.com
Subject: Re: [PATCH] staging: typec: handle vendor defined part and modify
 drp toggling flow
Message-ID: <20180214105641.GE1480@kuha.fi.intel.com>
References: <1518600244-29949-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518600244-29949-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 05:24:04PM +0800, ShuFanLee wrote:
> From: ShuFanLee <shufan_lee@richtek.com>
> 
> Handle vendor defined behavior in tcpci_init and tcpci_irq.
> More operations can be extended in tcpci_vendor_data if needed.
> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> TCPC shall not start DRP toggling until subsequently the TCPM
> writes to the COMMAND register to start DRP toggling.
> DRP toggling flow is chagned as following:
>   - Write DRP = 0 & Rd/Rd
>   - Write DRP = 1
>   - Set LOOK4CONNECTION command
> 
> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>
> ---
>  drivers/staging/typec/tcpci.c | 98 ++++++++++++++++++++++++++++++++++++-------
>  drivers/staging/typec/tcpci.h | 15 +++++++
>  2 files changed, 97 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
> index 9bd4412..b3a97b3 100644
> --- a/drivers/staging/typec/tcpci.c
> +++ b/drivers/staging/typec/tcpci.c
> @@ -30,6 +30,7 @@ struct tcpci {
>  	bool controls_vbus;
>  
>  	struct tcpc_dev tcpc;
> +	struct tcpci_vendor_data *vdata;
>  };
>  
>  static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
> @@ -37,16 +38,29 @@ static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>  	return container_of(tcpc, struct tcpci, tcpc);
>  }
>  
> -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
> -			u16 *val)
> +int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val)
>  {
>  	return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
>  }
> +EXPORT_SYMBOL_GPL(tcpci_read16);
>  
> -static int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
> +int tcpci_write16(struct tcpci *tcpci, unsigned int reg, u16 val)
>  {
>  	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u16));
>  }
> +EXPORT_SYMBOL_GPL(tcpci_write16);
> +
> +int tcpci_read8(struct tcpci *tcpci, unsigned int reg, u8 *val)
> +{
> +	return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u8));
> +}
> +EXPORT_SYMBOL_GPL(tcpci_read8);
> +
> +int tcpci_write8(struct tcpci *tcpci, unsigned int reg, u8 val)
> +{
> +	return regmap_raw_write(tcpci->regmap, reg, &val, sizeof(u8));
> +}
> +EXPORT_SYMBOL_GPL(tcpci_write8);

I don't think there is any need to export those wrappers. You can
always expect the glue driver to supply the regmap as member of that
struct tcpci_vendor_data. See below..

>  static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  {
> @@ -98,8 +112,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
>  static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>  				    enum typec_cc_status cc)
>  {
> +	int ret;
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> -	unsigned int reg = TCPC_ROLE_CTRL_DRP;
> +	unsigned int reg = (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
>  
>  	switch (cc) {
>  	default:
> @@ -116,8 +132,19 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>  			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
>  		break;
>  	}
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
>  }
>  
>  static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> @@ -323,6 +350,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	if (time_after(jiffies, timeout))
>  		return -ETIMEDOUT;
>  
> +	/* Handle vendor init */
> +	if (tcpci->vdata) {
> +		if (tcpci->vdata->init) {
> +			ret = (*tcpci->vdata->init)(tcpci, tcpci->vdata);

ret = tcpci->vdata->init(...

> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
>  	/* Clear all events */
>  	ret = tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
>  	if (ret < 0)
> @@ -351,6 +387,13 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
>  
> +	/* Handle vendor defined interrupt */
> +	if (tcpci->vdata) {
> +		if (tcpci->vdata->irq_handler)
> +			(*tcpci->vdata->irq_handler)(tcpci, tcpci->vdata,
> +						     &status);

Ditto.

> +	}
> +
>  	/*
>  	 * Clear alert status for everything except RX_STATUS, which shouldn't
>  	 * be cleared until we have successfully retrieved message.
> @@ -417,7 +460,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>  	.reg_bits = 8,
>  	.val_bits = 8,
>  
> -	.max_register = 0x7F, /* 0x80 .. 0xFF are vendor defined */
> +	.max_register = 0xFF, /* 0x80 .. 0xFF are vendor defined */
>  };
>  
>  static const struct tcpc_config tcpci_tcpc_config = {
> @@ -435,22 +478,22 @@ static int tcpci_parse_config(struct tcpci *tcpci)
>  	return 0;
>  }
>  
> -static int tcpci_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *i2c_id)
> +struct tcpci *tcpci_register_port(struct i2c_client *client,
> +				  struct tcpci_vendor_data *vdata)

struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_...)
{
...

>  {
>  	struct tcpci *tcpci;
>  	int err;
>  
>  	tcpci = devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
>  	if (!tcpci)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	tcpci->client = client;

struct tcpci does not need that "client" member.

>  	tcpci->dev = &client->dev;

tcpci->dev = dev;

> -	i2c_set_clientdata(client, tcpci);
> +	tcpci->vdata = vdata;
>  	tcpci->regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);

You would now do that in your glue driver, and here just:

tcpci->regmap = data->regmap;

>  	tcpci->tcpc.init = tcpci_init;
>  	tcpci->tcpc.get_vbus = tcpci_get_vbus;
> @@ -467,7 +510,7 @@ static int tcpci_probe(struct i2c_client *client,
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
>  
>  	/* Disable chip interrupts */
>  	tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
> @@ -477,17 +520,40 @@ static int tcpci_probe(struct i2c_client *client,
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>  					dev_name(tcpci->dev), tcpci);

The interrupt could also be requested in the glue driver. Then from
the irq routine in your glue driver, you call tcpci_irq(). That would
mean you export tcpci_irq() of course.

>  	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
>  
>  	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> -	return PTR_ERR_OR_ZERO(tcpci->port);
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
> +
> +	tcpci = tcpci_register_port(client, NULL);
> +	if (PTR_ERR_OR_ZERO(tcpci))
> +		return PTR_ERR(tcpci);
> +
> +	i2c_set_clientdata(client, tcpci);
> +	return 0;
>  }

That would then look something like this:

static int tcpci_probe(struct i2c_client *client...
{
        struct tcpci_data data; /* s/tcpci_vendor_data/tcpci_data/ */
        struct tcpci *tcpci;

        data.regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
        if (IS_ERR(tcpci->regmap))
                return PTR_ERR(tcpci->regmap);

        /*
         * NOTE: everything in struct tcpci_data should be copied in
         * tcpci_register_port().
         */
        tcpci = tcpci_register_port(&client->dev, &data);
        if (IS_ERR(tcpci))
                return PTR_ERR(tcpci);

        devm_request_threaded_irq(&client->dev, client->irq, NULL,
                                  tcpci_irq,
                                  ...

        i2c_set_clientdata(client, tcpci);

        return 0;
}


Br,

-- 
heikki
