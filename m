Return-Path: <groeck7@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-2591080-1519251323-2-8375489199776415288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES ro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.66', Host='mail-pg0-f66.google.com', Country='US',
  FromHeader='net', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: groeck7@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519251322; b=GH55uTNfvy+ydLq+wZiOdev93Jiw91jDm5CW+1PwpzHC20C
    rxbNjA2G/JQ+hnx6C7V1ArU5U39LpU1D3zWkwHQ0cV4SI+z2rxQjfJDw8XHllliP
    n+Jn5ZZIKabhZ9hA0CaU2yrRo0fKPuucUiXBOY8LwGNcnBLYhu6TTOALqP3xt8OY
    MVctZ4Eq/lHE1i6fxMW2aXd7Vj7wXsQdA3rHOaTPKp1+jSFKqQsobjVbMBl5tXGR
    c/vZRTpEpWR+OpVgxpBDzJE+YwUqGDk37noIok+rfffe9KHRqbf1bm4knXvp/6Pa
    iemcQQDCT81I/et7+DA0dNkgQkX3PhiZK9+qupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1519251322; bh=zpg4o6v4zyQVPRK9XeEbPMbb80rNZIiI2a84VHgjuZQ=; b=h
    ald8RTwt9O5VVSP7j084J/2KhBB5uYJGKiX5Wbu1zkO2degKE2WeY7YM61nLRX7Y
    PG1doX7b2LVJn3wJKr2aEe3tZkpPAu+8fUmjh3q697WIfVqbCkwyxgyyPpcf9/S+
    JK0yd9H8SruslIElf5HovHxFlz6zY+OH5g2ZYBUXvrAPmD4ZVjxOVII4KdIZ6a67
    i8WNOUauKIi7Ob7UfQEc9XSLMr/v9eaWKGfCQduFIJdLqK7uzRnx2sdPkvxKLbs7
    pdK80Dfo2cosZQ8M4HvWZp6VCS51DiMHA33lVaf1vRuYmBw7ubtKoe8B+zYBE+Ts
    +Z5cQnZfO0Tn4TS6t637A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IniMLkR/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EA/pt0P5;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IniMLkR/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=74.125.83.66 (mail-pg0-f66.google.com);
    spf=pass smtp.mailfrom=groeck7@gmail.com smtp.helo=mail-pg0-f66.google.com;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EA/pt0P5;
    x-ptr=pass x-ptr-helo=mail-pg0-f66.google.com x-ptr-lookup=mail-pg0-f66.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x224pkPyEwE3dj5DU7BJgIFOG8wTYlfwPB+eeg/2/kiI1OSIjobTFB+UablvqG+XFrzb1NRyYLw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 21 Feb 2018 14:15:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: ShuFanLee <leechu729@gmail.com>
Cc: heikki.krogerus@linux.intel.com, greg@kroah.com, shufan_lee@richtek.com,
	cy_huang@richtek.com, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] staging: typec: handle vendor defined part and modify
 drp toggling flow
Message-ID: <20180221221514.GA31916@roeck-us.net>
References: <1519225343-2929-1-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519225343-2929-1-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 11:02:23PM +0800, ShuFanLee wrote:
> From: ShuFanLee <shufan_lee@richtek.com>
> 
> Handle vendor defined behavior in tcpci_init, tcpci_set_vconn and export tcpci_irq.
> More operations can be extended in tcpci_data if needed.
> According to TCPCI specification, 4.4.5.2 ROLE_CONTROL,
> TCPC shall not start DRP toggling until subsequently the TCPM
> writes to the COMMAND register to start DRP toggling.
> DRP toggling flow is chagned as following:
>   - Write DRP = 0 & Rd/Rd
>   - Write DRP = 1
>   - Set LOOK4CONNECTION command
> 
> Signed-off-by: ShuFanLee <shufan_lee@richtek.com>

Mostly loooks good to me. Couple of nitpicks below.

Guenter

> ---
>  drivers/staging/typec/tcpci.c | 128 +++++++++++++++++++++++++++++++++---------
>  drivers/staging/typec/tcpci.h |  13 +++++
>  2 files changed, 115 insertions(+), 26 deletions(-)
> 
>  patch changelogs between v1 & v2
>  - Remove unnecessary i2c_client in the structure of tcpci
>  - Rename structure of tcpci_vendor_data to tcpci_data
>  - Not exporting tcpci read/write wrappers but register i2c regmap in glue driver
>  - Add set_vconn ops in tcpci_data
>    (It is necessary for RT1711H to enable/disable idle mode before disabling/enabling vconn)
>  - Export tcpci_irq so that vendor can call it in their own IRQ handler
> 
>  patch changelogs between v2 & v3
>  - Change the return type of tcpci_irq from int to irqreturn_t
> 
> diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
> index 9bd4412..4959c69 100644
> --- a/drivers/staging/typec/tcpci.c
> +++ b/drivers/staging/typec/tcpci.c
> @@ -21,7 +21,6 @@
>  
>  struct tcpci {
>  	struct device *dev;
> -	struct i2c_client *client;
>  
>  	struct tcpm_port *port;
>  
> @@ -30,6 +29,12 @@ struct tcpci {
>  	bool controls_vbus;
>  
>  	struct tcpc_dev tcpc;
> +	struct tcpci_data *data;
> +};
> +
> +struct tcpci_chip {
> +	struct tcpci *tcpci;
> +	struct tcpci_data data;
>  };
>  
>  static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
> @@ -37,8 +42,7 @@ static inline struct tcpci *tcpc_to_tcpci(struct tcpc_dev *tcpc)
>  	return container_of(tcpc, struct tcpci, tcpc);
>  }
>  
> -static int tcpci_read16(struct tcpci *tcpci, unsigned int reg,
> -			u16 *val)
> +static int tcpci_read16(struct tcpci *tcpci, unsigned int reg, u16 *val)
>  {
>  	return regmap_raw_read(tcpci->regmap, reg, val, sizeof(u16));
>  }
> @@ -98,8 +102,10 @@ static int tcpci_set_cc(struct tcpc_dev *tcpc, enum typec_cc_status cc)
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
> @@ -117,7 +123,19 @@ static int tcpci_start_drp_toggling(struct tcpc_dev *tcpc,
>  		break;
>  	}
>  
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

regmap_write returns a negative return code or 0, thus this can be
simplified to
	return regmap_write(...);

>  }
>  
>  static enum typec_cc_status tcpci_to_typec_cc(unsigned int cc, bool sink)
> @@ -178,6 +196,16 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
>  	int ret;
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
>  	ret = regmap_write(tcpci->regmap, TCPC_POWER_CTRL,
>  			   enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  	if (ret < 0)
> @@ -323,6 +351,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	if (time_after(jiffies, timeout))
>  		return -ETIMEDOUT;
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
>  	/* Clear all events */
>  	ret = tcpci_write16(tcpci, TCPC_ALERT, 0xffff);
>  	if (ret < 0)
> @@ -344,9 +381,15 @@ static int tcpci_init(struct tcpc_dev *tcpc)
>  	return tcpci_write16(tcpci, TCPC_ALERT_MASK, reg);
>  }
>  
> -static irqreturn_t tcpci_irq(int irq, void *dev_id)
> +static irqreturn_t _tcpci_irq(int irq, void *dev_id)
>  {
>  	struct tcpci *tcpci = dev_id;
> +
> +	return tcpci_irq(tcpci);
> +}

Hmm, normally I'd expect this function _after_ the function it calls.
Guess that doesn't matter much here, so I am fine with it as long
as Greg is ok with it as well.

> +
> +irqreturn_t tcpci_irq(struct tcpci *tcpci)
> +{
>  	u16 status;
>  
>  	tcpci_read16(tcpci, TCPC_ALERT, &status);
> @@ -412,6 +455,7 @@ static irqreturn_t tcpci_irq(int irq, void *dev_id)
>  
>  	return IRQ_HANDLED;
>  }
> +EXPORT_SYMBOL_GPL(tcpci_irq);
>  
>  static const struct regmap_config tcpci_regmap_config = {
>  	.reg_bits = 8,
> @@ -435,22 +479,18 @@ static int tcpci_parse_config(struct tcpci *tcpci)
>  	return 0;
>  }
>  
> -static int tcpci_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *i2c_id)
> +struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  {
>  	struct tcpci *tcpci;
>  	int err;
>  
> -	tcpci = devm_kzalloc(&client->dev, sizeof(*tcpci), GFP_KERNEL);
> +	tcpci = devm_kzalloc(dev, sizeof(*tcpci), GFP_KERNEL);
>  	if (!tcpci)
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
>  	tcpci->tcpc.init = tcpci_init;
>  	tcpci->tcpc.get_vbus = tcpci_get_vbus;
> @@ -467,27 +507,63 @@ static int tcpci_probe(struct i2c_client *client,
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> -		return err;
> +		return ERR_PTR(err);
> +
> +	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> +	if (PTR_ERR_OR_ZERO(tcpci->port))
> +		return ERR_CAST(tcpci->port);
>  
> -	/* Disable chip interrupts */
> -	tcpci_write16(tcpci, TCPC_ALERT_MASK, 0);
> +	return tcpci;
> +}
> +EXPORT_SYMBOL_GPL(tcpci_register_port);
> +
> +void tcpci_unregister_port(struct tcpci *tcpci)
> +{
> +	tcpm_unregister_port(tcpci->port);
> +}
> +EXPORT_SYMBOL_GPL(tcpci_unregister_port);
>  
> -	err = devm_request_threaded_irq(tcpci->dev, client->irq, NULL,
> -					tcpci_irq,
> +static int tcpci_probe(struct i2c_client *client,
> +		       const struct i2c_device_id *i2c_id)
> +{
> +	struct tcpci_chip *chip;
> +	int err;
> +	u16 val = 0;
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->data.regmap = devm_regmap_init_i2c(client, &tcpci_regmap_config);
> +	if (IS_ERR(chip->data.regmap))
> +		return PTR_ERR(chip->data.regmap);
> +
> +	/* Disable chip interrupts before requesting irq */
> +	err = regmap_raw_write(chip->data.regmap, TCPC_ALERT_MASK, &val,
> +			       sizeof(u16));
> +	if (err < 0)
> +		return err;
> +
> +	err = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					_tcpci_irq,
>  					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> -					dev_name(tcpci->dev), tcpci);
> +					dev_name(&client->dev), chip);
>  	if (err < 0)
>  		return err;
>  
> -	tcpci->port = tcpm_register_port(tcpci->dev, &tcpci->tcpc);
> -	return PTR_ERR_OR_ZERO(tcpci->port);
> +	chip->tcpci = tcpci_register_port(&client->dev, &chip->data);
> +	if (PTR_ERR_OR_ZERO(chip->tcpci))
> +		return PTR_ERR(chip->tcpci);
> +
> +	i2c_set_clientdata(client, chip);
> +	return 0;
>  }
>  
>  static int tcpci_remove(struct i2c_client *client)
>  {
> -	struct tcpci *tcpci = i2c_get_clientdata(client);
> +	struct tcpci_chip *chip = i2c_get_clientdata(client);
>  
> -	tcpm_unregister_port(tcpci->port);
> +	tcpci_unregister_port(chip->tcpci);
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
> index fdfb06c..40025b2 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  
>  #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_DRPRST		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
> @@ -121,4 +122,16 @@
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
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
> +irqreturn_t tcpci_irq(struct tcpci *tcpci);
> +
>  #endif /* __LINUX_USB_TCPCI_H */
> -- 
> 1.9.1
> 
