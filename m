Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5829B222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bvYvcIzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437850AbfBNJev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:34:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37657 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfBNJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:34:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so5289295wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mQSa5nPCth9ow0IsxDg1VQZpyiN18/fNKNBsWXWgvXA=;
        b=bvYvcIzgx3vclpHvFE17tdevPq+BkzSNwEDbVJTCK0F9lV7FvBcq45SIs4b7pOHjQK
         0mpcAG1XBbZXRRgDl6/Jabe/m23kEovAskOGyrYr4LnLw6IW4AWKz5WwurlhEWGezE7v
         ZqRoK73NlKDoZGmu/cQUjeeem5+Kif3JP4oHaYrrT0404Nyyw/AxG5ZbAVRazonVuXQD
         kDkMNHSYab64JZ0UAu3nCnLoS2sBdfjUdP1wemFqEmihGrBDUHa7gIl8FfR/8hIisIBe
         sAQB+TeCWvfy2dFuJIpi/qm5T9YkcO1dqteV2qD72cTfZpTJ3Bcxx3kNwvyKZi4ymMjL
         8Buw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mQSa5nPCth9ow0IsxDg1VQZpyiN18/fNKNBsWXWgvXA=;
        b=KvGyDoKqP5+ujNS5/SHOSe42XeO40ZB/B0t/nz56CSyiSwMEh6qfEgsBQuOFwHG9m7
         uIjohNX29S2G620ylFJJIPPY9XFOvzWxdN4rWI1BK0eJJ+U4ObPIVTVZQ+XgzyCdUnGp
         lHWS7j2INwE6Sx3EJ4LzVxxDlxg/layF446AT8Bop+D8TiSdUtPKbTmKAbNbpP+PyFTT
         Qo7DY5HP8Ct+9AMJIefsqqeMja2oyw+uDiQb/y4eW8PpD1JpIf9Meyt6BKmIwmilhH0N
         4ika/nrE+TsiWLqcXQjdIT4JJ+EIo67wgZYmyah1/VWSmYe59zZH1vIk7T6b8Hsg8N5U
         +9qQ==
X-Gm-Message-State: AHQUAuYsHsPyVXxFpzymgbJ5VQyNqfGtswO5ktuWxnPJqxVQf116L0IL
        7HktmmlgAUvA180qSSGfbm/hAA==
X-Google-Smtp-Source: AHgI3IZrvhLNwSGMSqcyFFhuHqzDTVbtN135XbvF3T3Hif+cQA+tuLOeEcE9rSLALBSgw3O7y7RWFw==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr1973896wmd.36.1550136887913;
        Thu, 14 Feb 2019 01:34:47 -0800 (PST)
Received: from dell ([2a01:4c8:c:28c9:4c60:37da:d7a:230])
        by smtp.gmail.com with ESMTPSA id z16sm781188wrr.66.2019.02.14.01.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:34:47 -0800 (PST)
Date:   Thu, 14 Feb 2019 09:34:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Virendra Kakade <virendra.kakade@ni.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        sre@kernel.org, moritz.fischer@ettus.com
Subject: Re: [RFC 2/6] mfd: Support for Ettus Research E31x devices PMU
Message-ID: <20190214093445.GF13737@dell>
References: <20190212010143.3729-1-virendra.kakade@ni.com>
 <20190212010143.3729-3-virendra.kakade@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190212010143.3729-3-virendra.kakade@ni.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019, Virendra Kakade wrote:

> Signed-off-by: Virendra Kakade <virendra.kakade@ni.com>
> ---
>  drivers/mfd/Kconfig          |  7 +++
>  drivers/mfd/Makefile         |  2 +-
>  drivers/mfd/e31x-pmu.c       | 89 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/e31x-pmu.h | 20 ++++++++
>  4 files changed, 117 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mfd/e31x-pmu.c
>  create mode 100644 include/linux/mfd/e31x-pmu.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8c5dfdce4326..6c4c0747f2a5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1916,4 +1916,11 @@ config RAVE_SP_CORE
>  	  device found on several devices in RAVE line of hardware.
>  
>  endmenu
> +
> +config MFD_E31X_PMU
> +	tristate "E31X PMU driver"
> +	select MFD_SYSCON
> +	help
> +	 Select this to get support for the Ettus Research E31x devices.
> +
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 12980a4ad460..e37c2057134b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -241,4 +241,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
>  obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
>  obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
>  obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
> -
> +obj-$(CONFIG_MFD_E31X_PMU)      += e31x-pmu.o
> diff --git a/drivers/mfd/e31x-pmu.c b/drivers/mfd/e31x-pmu.c
> new file mode 100644
> index 000000000000..383df68a538f
> --- /dev/null
> +++ b/drivers/mfd/e31x-pmu.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 National Instruments Corp

This is out of date.

'\n' here.

> + * Author: Virendra Kakade<virendra.kakade@ni.com>

You need a space after your name.

> + * Ettus Research E31x PMU MFD driver

Please expand PMU.

> + */
> +
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/of_device.h>
> +#include <linux/mfd/e31x-pmu.h>
> +#include <linux/platform_device.h>

Alphabetical.

> +#define E31X_PMU_MISC_IRQ_MASK		BIT(8)
> +#define E31X_PMU_MISC_IRQ_SHIFT		8
> +#define E31X_PMU_MISC_VERSION_MIN_MASK	GENMASK(3, 0)
> +#define E31X_PMU_MISC_VERSION_MIN_SHIFT	0
> +#define E31X_PMU_MISC_VERSION_MAJ_MASK	GENMASK(7, 4)
> +#define E31X_PMU_MISC_VERSION_MAJ_SHIFT	4
> +
> +struct e31x_pmu {
> +	struct regmap *regmap;
> +};

A whole struct for one attribute?

> +static int e31x_pmu_check_version(struct e31x_pmu *pmu)
> +{
> +	int timeout = 100;

Where does 100 come from?

> +	u32 misc, maj;
> +	int err;

'ret' is more common.

> +	/* we need to wait a bit for firmware to populate the fields */

"a bit" ?

What does the datasheet say?

Please use proper grammar.  Capital letters.

> +	while (timeout--) {
> +		err = regmap_read(pmu->regmap, E31X_PMU_REG_MISC, &misc);
> +		if (err)
> +			return err;
> +		if (misc)
> +			break;
> +
> +	usleep_range(2500, 5000);

Formatting.

> +	}
> +
> +	/* only firmware versions above 2.0 are supported */

"Only supports firmware version 2.0 and above"

> +	maj = E31X_PMU_GET_FIELD(MISC_VERSION_MAJ, misc);
> +	if (maj < 2)
> +		return -ENOTSUPP;

'\n' here.

> +	return 0;
> +}
> +
> +static int e31x_pmu_probe(struct platform_device *pdev)
> +{
> +	struct e31x_pmu *pmu;
> +
> +	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
> +	if (!pmu)
> +		return -ENOMEM;

'\n' here.

> +	pmu->regmap = syscon_regmap_lookup_by_phandle(\

Why are you storing regmap?

Just pass it directly to e31x_pmu_check_version().

> +			pdev->dev.of_node, "regmap");
> +

Remove this line.

> +	if (IS_ERR(pmu->regmap))
> +		return PTR_ERR(pmu->regmap);

'\n' here.

> +	if (e31x_pmu_check_version(pmu))

Please split out the function from the if.

Use a variable 'ret' to feed into and check that.

> +		return -ENOTSUPP;

'\n' here.

> +	return devm_of_platform_populate(&pdev->dev);
> +}
> +
> +static const struct of_device_id e31x_pmu_id[] = {
> +	{ .compatible = "ni,e31x-pmu" },
> +	{},
> +};
> +
> +static struct platform_driver e31x_pmu_driver = {
> +	.driver = {
> +	.name = "e31x-pmu",
> +	.of_match_table = e31x_pmu_id,

These 2 lines need indenting.

> +	},
> +	.probe = e31x_pmu_probe,
> +};
> +module_platform_driver(e31x_pmu_driver);
> +
> +MODULE_DESCRIPTION("E31x PMU driver");
> +MODULE_AUTHOR("Virendra Kakade <virendra.kakade@ni.com>");
> +MODULE_LICENSE("GPL");

So the whole purpose of this driver is to do a version check.

Seems like over-kill!

Probably better to do the version check in an inline function stored
in a header file, then call it from each of the children's .probe()
function.

> diff --git a/include/linux/mfd/e31x-pmu.h b/include/linux/mfd/e31x-pmu.h
> new file mode 100644
> index 000000000000..c57d5a8c1aad
> --- /dev/null
> +++ b/include/linux/mfd/e31x-pmu.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 National Instruments Corp

Out of date.

'\n' here.

> + * Author: Virendra Kakade <virendra.kakade@ni.com>
> + *
> + * Ettus Research E31x PMU constants
> + */
> +
> +#ifndef MFD_E31X_PMU_H
> +#define MFD_E31X_PMU_H
> +
> +#include <linux/bitops.h>
> +
> +#define E31X_PMU_REG_MISC      0x04
> +
> +#define E31X_PMU_GET_FIELD(name, reg) \
> +	(((reg) & E31X_PMU_## name ##_MASK) >> \
> +	E31X_PMU_## name ##_SHIFT)
> +
> +#endif /* MFD_E31X_PMU_H */

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
