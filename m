Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +BQHBlkYG1s6OQAAmS7hNA
	; Fri, 08 Jun 2018 23:59:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EEA6E607DC; Fri,  8 Jun 2018 23:59:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9tEWtqp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 060C3601B4;
	Fri,  8 Jun 2018 23:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 060C3601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753212AbeFHX7R (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:59:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeFHX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4HtUxJIzkobmSvFkiCu7Pmp/qQw4kbA9KDKL1c8qj0U=; b=t9tEWtqp+NYr8FuumrdrhZQTV
        NbdYr+PR1AQPYttdKrACLGHNVQfNGXKLuTV6pF/CXBZsEaTiYmgQ8r2FXNmqptqLciWT4WkDdKIqL
        ASoIZ+Y9ODX0N5tarUae7B/3KYtRaw+DM5mRtL+aG2+SMmpQBfJcErtwXFJ0gwrYNM9urdv4CLBi0
        45se+rSrAoUxhAVEoE1AQkbdDNqAUIPeiBYjdMjcVgUsiAgOddaofD54JSMjc21ui6eBkGI6Sdg9k
        iipKaZrK5CJMUFcfmKGOv9VbGJYVmJ8DCqgYDzUJH2McNSF22XtyLjul2eCHU6CKyuFwznI+nF3EX
        /ifJLsSKg==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fRRHl-0000Kp-UR; Fri, 08 Jun 2018 23:59:13 +0000
Date: Fri, 8 Jun 2018 16:59:11 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v5 6/8] platform/mellanox: Introduce support for Mellanox
 register access driver
Message-ID: <20180608235911.GB111314@localhost.localdomain>
References: <1528203501-129092-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528203501-129092-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:58:19PM +0000, Vadim Pasternak wrote:
> Introduce new Mellanox platform driver to allow access to Mellanox
> programmable device register space trough sysfs interface.
> The driver purpose is to provide sysfs interface for user space for the
> registers essential for system control and monitoring.
> The sets of registers for sysfs access are supposed to be defined per
> system type bases and include the registers related to system resets
> operation, system reset causes monitoring and some kinds of mux selection.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>

Hi Vadim,

> ---
> v1->v2:
>  Change added by Vadim:
>  - Change ---help--- to help in Kconfig, according to new requirements;
> v2->v3:
>  Comments pointed out by Darren:
>  - Remove conditional assignment per attribute mode type, because mode
>    will guard against not permitted access.
>    Verified by Vadim.
> v4-v5:
>  Comments pointed out by Darren:
>  - Add more comments.
>  - Add validation for the buffer length in attribute store method.
>  - Remove unnecessary check for input value in attribute store method.
>  - Change name val to input_value in order to improve code readability.
>  Changes added by Vadim:
>  - Extend logic in attribute show and store methods to cover all
>    configurations.
> ---
>  drivers/platform/mellanox/Kconfig     |  11 ++
>  drivers/platform/mellanox/Makefile    |   1 +
>  drivers/platform/mellanox/mlxreg-io.c | 227 ++++++++++++++++++++++++++++++++++
>  3 files changed, 239 insertions(+)
>  create mode 100644 drivers/platform/mellanox/mlxreg-io.c
> 
> diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
> index 7c8385e..57074d9c 100644
> --- a/drivers/platform/mellanox/Makefile
> +++ b/drivers/platform/mellanox/Makefile
...
> +static ssize_t
> +mlxreg_io_attr_show(struct device *dev, struct device_attribute *attr,
> +		    char *buf)
> +{
> +	struct mlxreg_io_priv_data *priv = dev_get_drvdata(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
> +	struct mlxreg_core_data *data = priv->pdata->data + index;
> +	u32 regval = 0;
> +	int ret;
> +
> +	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
> +	if (ret)
> +		goto access_error;
> +
> +	/*
> +	 * There are three kinds of attributes: single bit, full register's
> +	 * bits and bit sequence. For the first kind field mask indicates which
> +	 * bits are not related and filed bit is set zero. For the second kind
> +	 * field mask is set to zero and field bit is set with all bits one.

Is it "all bits one" or "all bits representing the length of the
register set to one" ? e.g. is it always 0xFFFFFFFF or can it be
0x0000000F for a 4 bit register?

> +	 * For the third kind, filed mask indicates which bits are related and
> +	 * field bit is set to the first bit number (from 1 to 32) is the bit
> +	 * sequence.
> +	 */

This is really useful for review - thank you for adding it. I presume
all instances of "filed" were intended to be "field" ?

> +	if (!data->bit)
> +		regval = !!(regval & ~data->mask);
> +	else if (!data->mask)
> +		regval &= data->bit;

If this is the second type (the full register).... and data->bit is all
1s. Why do the &=?  Why test for this at all? Isn't regval already what
you need?

> +	else
> +		regval = ror32(regval & data->mask, (data->bit - 1));
> +

So I think this can be rewritten as:

if (!data->bit)
	regval = !!(regval & ~data->mask
else if (data->mask)
	regval = ror32(regval & data->mask, (data->bit - 1));
/* Without bit or mask, the entire regval is used as is */

Am I missing something?

> +	return sprintf(buf, "%u\n", regval);
> +
> +access_error:
> +	return ret;
> +}
> +
> +static ssize_t
> +mlxreg_io_attr_store(struct device *dev, struct device_attribute *attr,
> +		     const char *buf, size_t len)
> +{
> +	struct mlxreg_io_priv_data *priv = dev_get_drvdata(dev);
> +	int index = to_sensor_dev_attr(attr)->index;
> +	struct mlxreg_core_data *data = priv->pdata->data + index;
> +	u32 input_val, regval;
> +	int ret;
> +
> +	if (len > MLXREG_IO_ATT_SIZE)
> +		return -EINVAL;

The bigger problem would be len < MLXREG_IO_ATT_SIZE right? Because next
we'll try to read beyond the end of buf. Right?

> +
> +	ret = kstrtou32(buf, MLXREG_IO_ATT_SIZE, &input_val);
> +	if (ret)
> +		return ret;
> +
> +	/* Convert buffer to input value. */
I think this comment describes the previous lines, right?

This line is reading the register into regval...

> +	ret = regmap_read(priv->pdata->regmap, data->reg, &regval);
> +	if (ret)
> +		goto access_error;
> +
> +	if (!data->bit) {
> +		/* Single bit, set or clear it according to the input value. */
> +		regval &= data->mask;
> +		if (input_val)
> +			regval |= ~data->mask;
> +	} else if (!data->mask) {
> +		/* All bits, clear out of range bits form the input value. */

                                                     from

> +		regval = input_val & data->bit;

Per the comments above - is this step necessary? Is data->bit all 1s? Or
is this just "all 1s for the length of the register, which is <=32 ? If
so, that wasn't clear from the above comments.

> +	} else {
> +		/* Bit sequence: shift to relevant position and mask. */
> +		input_val = rol32(input_val, data->bit - 1) & data->mask;
> +		/* Clear relevant bits and set them to new value. */
> +		regval = (regval & ~data->mask) | input_val;
> +	}

It seems to me we have a complex register value reading operation here
which we are now performing in two places. This often leads to errors
where only one gets updated if there is a bug in the logic. Can we pull
out the regval reading operation into a static local function?

> +
> +	ret = regmap_write(priv->pdata->regmap, data->reg, regval);
> +	if (ret)
> +		goto access_error;
> +
> +	return len;
> +
> +access_error:
> +	dev_err(&priv->pdev->dev, "Bus access error\n");
> +	return ret;
> +}
> +
> +static struct device_attribute mlxreg_io_devattr_rw = {
> +	.show	= mlxreg_io_attr_show,
> +	.store	= mlxreg_io_attr_store,
> +};
> +
> +static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv)
> +{
> +	int i;
> +
> +	priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
> +					 priv->pdata->counter *
> +					 sizeof(struct attribute *),
> +					 GFP_KERNEL);
> +	if (!priv->group.attrs)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->pdata->counter; i++) {
> +		priv->mlxreg_io_attr[i] =
> +				&priv->mlxreg_io_dev_attr[i].dev_attr.attr;
> +		memcpy(&priv->mlxreg_io_dev_attr[i].dev_attr,
> +		       &mlxreg_io_devattr_rw, sizeof(struct device_attribute));
> +
> +		/* Set attribute name as a label. */
> +		priv->mlxreg_io_attr[i]->name =
> +				devm_kasprintf(&priv->pdev->dev, GFP_KERNEL,
> +					       priv->pdata->data[i].label);
> +
> +		if (!priv->mlxreg_io_attr[i]->name) {
> +			dev_err(&priv->pdev->dev, "Memory allocation failed for sysfs attribute %d.\n",
> +				i + 1);
> +			return -ENOMEM;
> +		}
> +
> +		priv->mlxreg_io_dev_attr[i].dev_attr.attr.mode =
> +						priv->pdata->data[i].mode;
> +		priv->mlxreg_io_dev_attr[i].dev_attr.attr.name =
> +					priv->mlxreg_io_attr[i]->name;
> +		priv->mlxreg_io_dev_attr[i].index = i;
> +		sysfs_attr_init(&priv->mlxreg_io_dev_attr[i].dev_attr.attr);
> +	}
> +
> +	priv->group.attrs = priv->mlxreg_io_attr;
> +	priv->groups[0] = &priv->group;
> +	priv->groups[1] = NULL;
> +
> +	return 0;
> +}
> +
> +static int mlxreg_io_probe(struct platform_device *pdev)
> +{
> +	struct mlxreg_io_priv_data *priv;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdata = dev_get_platdata(&pdev->dev);
> +	if (!priv->pdata) {
> +		dev_err(&pdev->dev, "Failed to get platform data.\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->pdev = pdev;
> +
> +	err = mlxreg_io_attr_init(priv);
> +	if (err) {
> +		dev_err(&priv->pdev->dev, "Failed to allocate attributes: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	priv->hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
> +							     "mlxreg_io",
> +							      priv,
> +							      priv->groups);
> +	if (IS_ERR(priv->hwmon)) {
> +		dev_err(&pdev->dev, "Failed to register hwmon device %ld\n",
> +			PTR_ERR(priv->hwmon));
> +		return PTR_ERR(priv->hwmon);
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver mlxreg_io_driver = {
> +	.driver = {
> +	    .name = "mlxreg-io",
> +	},
> +	.probe = mlxreg_io_probe,
> +};
> +
> +module_platform_driver(mlxreg_io_driver);
> +
> +MODULE_AUTHOR("Vadim Pasternak <vadimp@mellanox.com>");
> +MODULE_DESCRIPTION("Mellanox regmap I/O access driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mlxreg-io");
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
