Return-Path: <heikki.krogerus@linux.intel.com>
X-Cyrus-Session-Id: sloti22d1t05-2643090-1521458458-2-6257756705322032094
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='192.55.52.88', Host='mga01.intel.com', Country='US', FromHeader='com',
  MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: heikki.krogerus@linux.intel.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521458457; b=cAD+qXUjJy8+gWBJQAs81tOPHXvI01N12t101AGSylPZUVI
    xFg/Y//ZEWQ07A5NoY0zhdx6ZBgv1n/HKS7fmSjVGekYV4lanrHRLLmyKQjFL5vO
    zPDP7qGMaK7YE63+DzBsWkyRLpcbspVUrAYmn6+kf/vZe+qOd+r56sWa4FpAuIWG
    77W4/65QfZ9pIqH4O3fm6gnNcfePmp7n6UiF3ETH2MZCJQ0Ope3FSZRWr8M4rf7j
    4rt1tNQHzoUV7jKIr+V4SYIWWH8nz1bcWDCSOa2wvVHksbRHJprPbq0Xvq++38pW
    qxEmqe7RdRXcqIqAk6PPCDV4kYstHJT2v3cYGRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=arctest; t=
    1521458457; bh=nfyVONo7loCRkuGdumVPWFHYxvY0lbMMozrweHloLhI=; b=N
    VfgTV8AL8sfhKoaUlswL8bHEtarCwWPfpkvEKCypQ1MG126l0aoilw0zAI/8UEMz
    uSYxc5eseub+/h8tdSea1IsewlQ8TK3mF+TEqa/zu0FNlWP+trZUFoqkJKiUCIEi
    Aa9cNn5V3OYv9GyhuoRns2Ju06Vu6/VTB0DnDgDYxKDpsfWFnUMQKV3TA1Of69p3
    8DQ50oS/5AhPpmtOcWK8tbl1BOGhaY291/ydasvSc9hGVXjLQa4Z++MR6B/OcJ75
    z7wNdi6MlHrR/PpVQiuzOJ7J/6aK9CUd+CkfyQj2gpEJFp3By/YOWNK5LG5rdctr
    EcILHLaWHDyoUlBSPcJRw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.88 (mga01.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com smtp.helo=mga01.intel.com;
    x-aligned-from=pass (Address match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecukfhppeduledvrdehhedrhedvrdekkeenucfrrghrrghmpehinhgvthepudelvddrheehrdehvddrkeekpdhhvghlohepmhhgrgdtuddrihhnthgvlhdrtghomhdpmhgrihhlfhhrohhmpeeohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhequcfukfgkgfepuddvleekleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=mga01.intel.com x-ptr-lookup=mga01.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=192.55.52.88 (mga01.intel.com);
    spf=none smtp.mailfrom=heikki.krogerus@linux.intel.com smtp.helo=mga01.intel.com;
    x-aligned-from=pass (Address match);
    x-category=clean score=0 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddvheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecukfhppeduledvrdehhedrhedvrdekkeenucfrrghrrghmpehinhgvthepudelvddrheehrdehvddrkeekpdhhvghlohepmhhgrgdtuddrihhnthgvlhdrtghomhdpmhgrihhlfhhrohhmpeeohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomhequcfukfgkgfepuddvleekleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=mga01.intel.com x-ptr-lookup=mga01.intel.com;
    x-return-mx=pass smtp.domain=linux.intel.com smtp.result=pass smtp_org.domain=intel.com smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="39212707"
Date: Mon, 19 Mar 2018 13:20:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, linux@roeck-us.net, shufan_lee@richtek.com,
	cy_huang@richtek.com, jun.li@nxp.com, mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: typec: rt1711h typec chip driver
Message-ID: <20180319112046.GF11689@kuha.fi.intel.com>
References: <1521431375-23207-1-git-send-email-leechu729@gmail.com>
 <1521431375-23207-2-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521431375-23207-2-git-send-email-leechu729@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 11:49:34AM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Richtek RT1711H Type-C chip driver that works with
> Type-C Port Controller Manager to provide USB PD and
> USB Type-C functionalities.
> Add definition of TCPC_CC_STATUS_TOGGLING.
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>

Looks OK to me. I'll put a few nitpics below in case you make one more
version for some other reason. In any case:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/staging/typec/Kconfig         |   8 +
>  drivers/staging/typec/Makefile        |   1 +
>  drivers/staging/typec/tcpci.h         |   1 +
>  drivers/staging/typec/tcpci_rt1711h.c | 329 ++++++++++++++++++++++++++++++++++
>  4 files changed, 339 insertions(+)
>  create mode 100644 drivers/staging/typec/tcpci_rt1711h.c
> 
>  changelogs between v1 and v2
>  - use gpiod_* instead of gpio_*
> 
> diff --git a/drivers/staging/typec/Kconfig b/drivers/staging/typec/Kconfig
> index 5359f556d203..3aa981fbc8f5 100644
> --- a/drivers/staging/typec/Kconfig
> +++ b/drivers/staging/typec/Kconfig
> @@ -9,6 +9,14 @@ config TYPEC_TCPCI
>  	help
>  	  Type-C Port Controller driver for TCPCI-compliant controller.
>  
> +config TYPEC_RT1711H
> +	tristate "Richtek RT1711H Type-C chip driver"
> +	select TYPEC_TCPCI
> +	help
> +	  Richtek RT1711H Type-C chip driver that works with
> +	  Type-C Port Controller Manager to provide USB PD and USB
> +	  Type-C functionalities.
> +
>  endif
>  
>  endmenu
> diff --git a/drivers/staging/typec/Makefile b/drivers/staging/typec/Makefile
> index 53d649abcb53..7803d485e1b3 100644
> --- a/drivers/staging/typec/Makefile
> +++ b/drivers/staging/typec/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
> +obj-$(CONFIG_TYPEC_RT1711H)	+= tcpci_rt1711h.o
> diff --git a/drivers/staging/typec/tcpci.h b/drivers/staging/typec/tcpci.h
> index 34c865f0dcf6..303ebde26546 100644
> --- a/drivers/staging/typec/tcpci.h
> +++ b/drivers/staging/typec/tcpci.h
> @@ -59,6 +59,7 @@
>  #define TCPC_POWER_CTRL_VCONN_ENABLE	BIT(0)
>  
>  #define TCPC_CC_STATUS			0x1d
> +#define TCPC_CC_STATUS_TOGGLING		BIT(5)
>  #define TCPC_CC_STATUS_TERM		BIT(4)
>  #define TCPC_CC_STATUS_CC2_SHIFT	2
>  #define TCPC_CC_STATUS_CC2_MASK		0x3
> diff --git a/drivers/staging/typec/tcpci_rt1711h.c b/drivers/staging/typec/tcpci_rt1711h.c
> new file mode 100644
> index 000000000000..12afac363d6d
> --- /dev/null
> +++ b/drivers/staging/typec/tcpci_rt1711h.c
> @@ -0,0 +1,329 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2018, Richtek Technology Corporation
> + *
> + * Richtek RT1711H Type-C Chip Driver
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/usb/tcpm.h>
> +#include <linux/regmap.h>
> +#include "tcpci.h"
> +
> +#define RT1711H_RTCTRL8		0x9B
> +
> +/* Autoidle timeout = (tout * 2 + 1) * 6.4ms */
> +#define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
> +			    (((ck300) << 7) | ((ship_off) << 5) | \
> +			    ((auto_idle) << 3) | ((tout) & 0x07))
> +
> +#define RT1711H_RTCTRL11	0x9E
> +
> +/* I2C timeout = (tout + 1) * 12.5ms */
> +#define RT1711H_RTCTRL11_SET(en, tout) \
> +			     (((en) << 7) | ((tout) & 0x0F))
> +
> +#define RT1711H_RTCTRL13	0xA0
> +#define RT1711H_RTCTRL14	0xA1
> +#define RT1711H_RTCTRL15	0xA2
> +#define RT1711H_RTCTRL16	0xA3
> +
> +struct rt1711h_chip {
> +	struct tcpci_data data;
> +	struct tcpci *tcpci;
> +	struct device *dev;
> +	int irq;
> +};
> +
> +static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> +{
> +	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u16));
> +}
> +
> +static int rt1711h_write16(struct rt1711h_chip *chip, unsigned int reg, u16 val)
> +{
> +	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u16));
> +}
> +
> +static int rt1711h_read8(struct rt1711h_chip *chip, unsigned int reg, u8 *val)
> +{
> +	return regmap_raw_read(chip->data.regmap, reg, val, sizeof(u8));
> +}
> +
> +static int rt1711h_write8(struct rt1711h_chip *chip, unsigned int reg, u8 val)
> +{
> +	return regmap_raw_write(chip->data.regmap, reg, &val, sizeof(u8));
> +}
> +
> +static const struct regmap_config rt1711h_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = 0xFF, /* 0x80 .. 0xFF are vendor defined */
> +};
> +
> +static struct rt1711h_chip *tdata_to_rt1711h(struct tcpci_data *tdata)
> +{
> +	return container_of(tdata, struct rt1711h_chip, data);
> +}
> +
> +static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
> +{
> +	int ret;
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +
> +	/* CK 300K from 320K, shipping off, auto_idle enable, tout = 32ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL8,
> +			     RT1711H_RTCTRL8_SET(0, 1, 1, 2));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* I2C reset : (val + 1) * 12.5ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL11,
> +			     RT1711H_RTCTRL11_SET(1, 0x0F));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* tTCPCfilter : (26.7 * val) us */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL14, 0x0F);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*  tDRP : (51.2 + 6.4 * val) ms */
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL15, 0x04);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* dcSRC.DRP : 33% */
> +	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +}
> +
> +static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			     bool enable)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +
> +	return rt1711h_write8(chip, RT1711H_RTCTRL8,
> +			      RT1711H_RTCTRL8_SET(0, 1, enable ? 0 : 1, 2));

RT1711H_RTCTRL8_SET(0, 1, !enable, 2)

> +}
> +
> +static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
> +				      struct tcpci_data *tdata,
> +				      enum typec_cc_status cc)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	int ret;
> +	unsigned int reg = 0;
> +
> +	switch (cc) {
> +	default:
> +	case TYPEC_CC_RP_DEF:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_DEF <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	case TYPEC_CC_RP_1_5:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_1_5 <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	case TYPEC_CC_RP_3_0:
> +		reg |= (TCPC_ROLE_CTRL_RP_VAL_3_0 <<
> +			TCPC_ROLE_CTRL_RP_VAL_SHIFT);
> +		break;
> +	}
> +
> +	if (cc == TYPEC_CC_RD)
> +		reg |= (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RD << TCPC_ROLE_CTRL_CC2_SHIFT);
> +	else
> +		reg |= (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC1_SHIFT) |
> +			   (TCPC_ROLE_CTRL_CC_RP << TCPC_ROLE_CTRL_CC2_SHIFT);
> +
> +	ret = rt1711h_write8(chip, TCPC_ROLE_CTRL, reg);
> +	if (ret < 0)
> +		return ret;
> +	usleep_range(500, 1000);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t rt1711h_irq(int irq, void *dev_id)
> +{
> +	int ret;
> +	u16 alert;
> +	u8 status;
> +	struct rt1711h_chip *chip = dev_id;
> +
> +	if (!chip->tcpci)
> +		return IRQ_HANDLED;
> +
> +	ret = rt1711h_read16(chip, TCPC_ALERT, &alert);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (alert & TCPC_ALERT_CC_STATUS) {
> +		ret = rt1711h_read8(chip, TCPC_CC_STATUS, &status);
> +		if (ret < 0)
> +			goto out;
> +		/* Clear cc change event triggered by starting toggling */
> +		if (status & TCPC_CC_STATUS_TOGGLING)
> +			rt1711h_write8(chip, TCPC_ALERT, TCPC_ALERT_CC_STATUS);
> +	}
> +
> +out:
> +	return tcpci_irq(chip->tcpci);
> +}
> +
> +static int rt1711h_init_gpio(struct rt1711h_chip *chip)
> +{
> +	struct gpio_desc *gpio;
> +
> +	gpio = devm_gpiod_get(chip->dev, "rt,intr", GPIOD_IN);
> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
> +	chip->irq = gpiod_to_irq(gpio);
> +	if (chip->irq < 0)
> +		return chip->irq;
> +	return 0;
> +}
> +
> +static int rt1711h_init_alert(struct rt1711h_chip *chip)
> +{
> +	int ret;
> +
> +	/* Disable chip interrupts before requesting irq */
> +	ret = rt1711h_write16(chip, TCPC_ALERT_MASK, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!chip->irq) {
> +		ret = rt1711h_init_gpio(chip);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	ret = devm_request_threaded_irq(chip->dev, chip->irq, NULL,
> +					rt1711h_irq,
> +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +					dev_name(chip->dev), chip);
> +	if (ret < 0)
> +		return ret;
> +	enable_irq_wake(chip->irq);
> +	return 0;
> +}
> +
> +static int rt1711h_sw_reset(struct rt1711h_chip *chip)
> +{
> +	int ret;
> +
> +	ret = rt1711h_write8(chip, RT1711H_RTCTRL13, 0x01);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +	return 0;
> +}
> +
> +static int rt1711h_check_revision(struct i2c_client *i2c)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_VENDOR_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 0x29cf) {

Ideally the vendor ID had a definition.

> +		dev_err(&i2c->dev, "vid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	ret = i2c_smbus_read_word_data(i2c, TCPC_PRODUCT_ID);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 0x1711) {

Ditto.

> +		dev_err(&i2c->dev, "pid is not correct, 0x%04x\n", ret);
> +		return -ENODEV;
> +	}
> +	return 0;
> +}
> +
> +static int rt1711h_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *i2c_id)
> +{
> +	int ret;
> +	struct rt1711h_chip *chip;
> +
> +	ret = rt1711h_check_revision(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "check vid/pid fail\n");
> +		return ret;
> +	}
> +
> +	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->data.regmap = devm_regmap_init_i2c(client,
> +						 &rt1711h_regmap_config);
> +	if (IS_ERR(chip->data.regmap))
> +		return PTR_ERR(chip->data.regmap);
> +
> +	chip->irq = client->irq;
> +	chip->dev = &client->dev;
> +	i2c_set_clientdata(client, chip);
> +
> +	ret = rt1711h_sw_reset(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = rt1711h_init_alert(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	chip->data.init = rt1711h_init;
> +	chip->data.set_vconn = rt1711h_set_vconn;
> +	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
> +	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);
> +	if (IS_ERR_OR_NULL(chip->tcpci))
> +		return PTR_ERR(chip->tcpci);
> +
> +	return 0;
> +}
> +
> +static int rt1711h_remove(struct i2c_client *client)
> +{
> +	struct rt1711h_chip *chip = i2c_get_clientdata(client);
> +
> +	tcpci_unregister_port(chip->tcpci);
> +	return 0;
> +}
> +
> +static const struct i2c_device_id rt1711h_id[] = {
> +	{ "rt1711h", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rt1711h_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id rt1711h_of_match[] = {
> +	{ .compatible = "richtek,rt1711h", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt1711h_of_match);
> +#endif
> +
> +static struct i2c_driver rt1711h_i2c_driver = {
> +	.driver = {
> +		.name = "rt1711h",
> +		.of_match_table = of_match_ptr(rt1711h_of_match),
> +	},
> +	.probe = rt1711h_probe,
> +	.remove = rt1711h_remove,
> +	.id_table = rt1711h_id,
> +};
> +module_i2c_driver(rt1711h_i2c_driver);
> +
> +MODULE_AUTHOR("ShuFan Lee <shufan_lee@richtek.com>");
> +MODULE_DESCRIPTION("RT1711H USB Type-C Port Controller Interface Driver");
> +MODULE_LICENSE("GPL");

Thanks,

-- 
heikki
