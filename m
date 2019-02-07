Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E8EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED9D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="De/Wx94T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBGKYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:24:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39269 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:24:02 -0500
Received: by mail-wm1-f67.google.com with SMTP id f16so1231196wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NAX/kTSasODCS328z4NFu0Hq04jxiYUIgr5maNTMXd8=;
        b=De/Wx94TvmYp+IMm5Yt913LQ8NHDoANfeDH+2jC896xa+3lk2JAB4Rh2UrhFt9j+rO
         Bj9PbJPXZ7JiV3nn6/17H8pOuwPD915CMSlkMWveVgpYl+DyIGi1uWBJaPfLqFGFPAQG
         bRuZkdoVQsEjXJG3jCICPsD0WIoemiOFDRLq+9loPP8oImGBYBJVF5gcQgp2U3QTyK0u
         leY3UXXyuc+Pb1nT/ZC4HbIUTg4mYEhchDjKE6hzAlqlfvJ1FmOe360qeynJcrgW+eri
         6kpd2+i6eBeP42YoEfSTsCfPIULhFzy4AIhp3p4zk0D+g6N79gpLZHqmtqxa0EC19cjF
         i/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NAX/kTSasODCS328z4NFu0Hq04jxiYUIgr5maNTMXd8=;
        b=JcPrKZgbKHE2pm85TSlfT2GWohbwv3wTRRM0yfNpd+ZyU21hEKiFR+VzTvCS9hhfrk
         IA8aneLdFUkpPY98rNre/bFkCxeGGpO92wpKHufTTj9yn6Rm1A/JhdrAFWXZE+60DcuC
         69jCKDOlin394azL7mTko0B+hQcopQA/Ad1V8ojO7AjSMQQHgpilUTm4+FNhEF4cWKjg
         tMqrjdQzolhi+w11e9zInnCtrbdX/py+iiUWrLtXUp+uT4DZvSOmDlGIh1IaPds29t1o
         9z7LIizUzbaIlctpNURKljG1Ck3CCxn7300UoQwsiKkp9QVwRuvcx6kg1u35J6L40nTv
         89Kg==
X-Gm-Message-State: AHQUAua79DzQtr9do6WLcy6v8Qd2l53rk9nCwYQwbbnAoYDuLdzRUmbX
        YmsQIjUOzyTD7FmLW4JxSH0AdQ==
X-Google-Smtp-Source: AHgI3IbsIZP0TJhfWxp2FfliefOSIz8/rvShW38i9EJbmAxdwHZJELW11FRpo/ldS7Nq8NbT7qh4SQ==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr6797412wmb.23.1549535038898;
        Thu, 07 Feb 2019 02:23:58 -0800 (PST)
Received: from dell ([2.27.35.171])
        by smtp.gmail.com with ESMTPSA id c7sm8898329wrn.71.2019.02.07.02.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 02:23:58 -0800 (PST)
Date:   Thu, 7 Feb 2019 10:23:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v5] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190207102356.GB20638@dell>
References: <20190207023731.13259-1-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190207023731.13259-1-andrew@lunn.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Feb 2019, Andrew Lunn wrote:

> The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> MFD which will instantiate the individual drivers.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v2:
> 
> Drop setting i2c bus speed, which removes the build dependencies on
> the i2c ocores patches. This can be added back later.
> 
> v3
> 
> Fix indentation of help
> Fix SPDX to match MODULE_LICENSE
> Remove warranty text
> Add my Copyright
> Sort include files
> Add _REG_ to register defines
> Add #defines for all resources
> Replace magic numbers with #defines
> Rename pld_clock to pld_clock_rate
> Remove wrapper around ioread8()/iowrite8()
> Scatter const keyword in a few places
> Remove enum for calls
> Implement lookup for board in tq_board_if
> Rename ioeic to io_ext_int_val to make is more readable
> Handle optional calls in a different way
> Better group code and structures
> Kill all the sysfs attributes
> Use devm_mfd_add_devices()
> Don't exist silently for unknown board ID
> 
> Not addressed, waiting for answers:
> MODULE_PARM for GPIO interrupts
> Not using regmap, intel IO not supported by regmap
> Setting GPIO irq on resource structure
> Global tqmx86_pdev
> Jumping through hoops
> 
> v4
> 
> Remove -- to avoid broken mailer
> 
> v5
> 
> Remove device data since it is only used in the probe function
> Remove platform data, since it only contains well know values
> Move GPIO IRQ resource first and comment about this assumption
> Fixup platform data naming
> Use true for ignore_resource_conflicts
> Use ARRAY_SIZE for num_resources
> Replace tq_board_info with two functions using switch
> Error out for invalid GPIO IRQ configuration
> Error out if GPIO IRQ cannot be configured in the hardware
> Split registering cells into two calls
> Validate GPIO IRQ using a switch statement, and derive the HW configuration
> ---
>  drivers/mfd/Kconfig  |   8 ++
>  drivers/mfd/Makefile |   1 +
>  drivers/mfd/tqmx86.c | 289 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 298 insertions(+)
>  create mode 100644 drivers/mfd/tqmx86.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index f461460a2aeb..226f7eeb2093 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1677,6 +1677,14 @@ config MFD_TC6393XB
>  	help
>  	  Support for Toshiba Mobile IO Controller TC6393XB
>  
> +config MFD_TQMX86
> +	tristate "TQ-Systems IO controller TQMX86"
> +	select MFD_CORE
> +	help
> +	  Say yes here to enable support for various functions of the
> +	  TQ-Systems IO controller and watchdog device, found on their
> +	  ComExpress CPU modules.
> +
>  config MFD_VX855
>  	tristate "VIA VX855/VX875 integrated south bridge"
>  	depends on PCI
[...]

> +static int tqmx86_board_id_to_clk_rate(u8 board_id)
> +{
> +	switch (board_id) {
> +	case TQMX86_REG_BOARD_ID_E38M:
> +		return 33000;
> +	case TQMX86_REG_BOARD_ID_50UC:
> +		return 24000;
> +	case TQMX86_REG_BOARD_ID_E38C:
> +		return 33000;
> +	case TQMX86_REG_BOARD_ID_60EB:
> +		return 24000;
> +	case TQMX86_REG_BOARD_ID_E39M:
> +		return 25000;
> +	case TQMX86_REG_BOARD_ID_E39C:
> +		return 25000;
> +	case TQMX86_REG_BOARD_ID_E39x:
> +		return 25000;
> +	case TQMX86_REG_BOARD_ID_70EB:
> +		return 24000;
> +	case TQMX86_REG_BOARD_ID_80UC:
> +		return 24000;
> +	case TQMX86_REG_BOARD_ID_90UC:
> +		return 24000;

Nit: What do you think of:

	switch (board_id) {
	case TQMX86_REG_BOARD_ID_E38M:
	case TQMX86_REG_BOARD_ID_E38C:
		return 33000;
	case TQMX86_REG_BOARD_ID_50UC:
	case TQMX86_REG_BOARD_ID_60EB:
	case TQMX86_REG_BOARD_ID_70EB:
	case TQMX86_REG_BOARD_ID_80UC:
	case TQMX86_REG_BOARD_ID_90UC:
		return 24000;
	case TQMX86_REG_BOARD_ID_E39M:
	case TQMX86_REG_BOARD_ID_E39C:
	case TQMX86_REG_BOARD_ID_E39x:
		return 25000;

> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int tqmx86_probe(struct platform_device *pdev)
> +{
> +	u8 board_id, rev, i2c_det, i2c_ien, io_ext_int_val;
> +	struct device *dev = &pdev->dev;
> +	const char *board_name;
> +	void __iomem *io_base;
> +	int err;
> +
> +	io_base = devm_ioport_map(dev, TQMX86_IOBASE, TQMX86_IOSIZE);
> +	if (!io_base)
> +		return -ENOMEM;
> +
> +	board_id = ioread8(io_base + TQMX86_REG_BOARD_ID);
> +	board_name = tqmx86_board_id_to_name(board_id);
> +	rev = ioread8(io_base + TQMX86_REG_BOARD_REV);
> +
> +	dev_info(dev,
> +		 "Found %s - Board ID %d, PCB Revision %d, PLD Revision %d\n",
> +		 board_name, board_id, rev >> 4, rev & 0xf);
> +
> +	i2c_det = ioread8(io_base + TQMX86_REG_I2C_DETECT);
> +	i2c_ien = ioread8(io_base + TQMX86_REG_I2C_INT_EN);
> +
> +	if (gpio_irq_cfg) {
> +		io_ext_int_val = gpio_irq_cfg <<
> +			TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;

		io_ext_int_val =
			gpio_irq_cfg << TQMX86_REG_IO_EXT_INT_GPIO_SHIFT;

Reads better, don't you think?

> +		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
> +		if (ioread8(io_base + TQMX86_REG_IO_EXT_INT) !=
> +		    io_ext_int_val) {

		iowrite8(io_ext_int_val, io_base + TQMX86_REG_IO_EXT_INT);
		readback = ioread8(io_base + TQMX86_REG_IO_EXT_INT);
		if (readback != io_ext_int_val) {

Never been a fan of function calls inside if statements.

This method also prevents the line break, which makes it slightly
harder to read.

> +			dev_warn(dev, "GPIO interrupts not supported.\n");

Do you know why they wouldn't be supported?

Isn't that the point of the device?

> +			return -EINVAL;
> +		}
> +
> +		/* Assumes the IRQ resource is first. */
> +		tqmx_gpio_resources[0].start = gpio_irq;
> +	}
> +
> +	ocores_platfom_data.clock_khz = tqmx86_board_id_to_clk_rate(board_id);
> +
> +	if (i2c_det == TQMX86_REG_I2C_DETECT_SOFT) {
> +		err = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +					   tqmx86_i2c_soft_dev,
> +					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> +					   NULL, 0, NULL);
> +		if (err)
> +			return err;
> +	}
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> +				    tqmx86_devs,
> +				    ARRAY_SIZE(tqmx86_devs),
> +				    NULL, 0, NULL);

That's better, thanks.

> +}
> +
> +static int tqmx86_create_platform_device(const struct dmi_system_id *id)
> +{
> +	struct platform_device *pdev;
> +	int err;
> +
> +	pdev = platform_device_alloc("tqmx86", -1);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	err = platform_device_add(pdev);
> +	if (err)
> +		platform_device_put(pdev);
> +
> +	return err;
> +}
> +
> +static const struct dmi_system_id tqmx86_dmi_table[] __initconst = {
> +	{
> +		.ident = "TQMX86",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "TQ-Group"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "TQMx"),
> +		},
> +		.callback = tqmx86_create_platform_device,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(dmi, tqmx86_dmi_table);
> +
> +static struct platform_driver tqmx86_driver = {
> +	.driver		= {
> +		.name	= "tqmx86",
> +	},
> +	.probe		= tqmx86_probe,
> +};
> +
> +static int __init tqmx86_init(void)
> +{
> +	switch (gpio_irq) {
> +	case 0:
> +		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_NONE;
> +		break;
> +	case 7:
> +		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_7;
> +		break;
> +	case 9:
> +		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_9;
> +		break;
> +	case 12:
> +		gpio_irq_cfg = TQMX86_REG_IO_EXT_INT_12;
> +		break;
> +	default:
> +		pr_err("tqmx86: Invalid GPIO IRQ (%d)\n", gpio_irq);
> +		return -EINVAL;
> +	}

Is there anything stopping you doing this checking in .probe()?

Then you can drop the gpio_irq_cfg global variable.

> +	if (!dmi_check_system(tqmx86_dmi_table))
> +		return -ENODEV;
> +
> +	return platform_driver_register(&tqmx86_driver);
> +}
> +
> +module_init(tqmx86_init);
> +
> +MODULE_DESCRIPTION("TQx86 PLD Core Driver");
> +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tqmx86");

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
