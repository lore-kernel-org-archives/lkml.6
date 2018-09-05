Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A484A2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A484A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeIEHZ6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:25:58 -0400
Received: from mx01.hxt-semitech.com ([223.203.96.7]:53064 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbeIEHZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:25:58 -0400
X-ASG-Debug-ID: 1536116274-093b7e636b126900001-xx1T2L
Received: from HXTBJIDCEMVIW01.hxtcorp.net ([10.128.0.14]) by barracuda.hxt-semitech.com with ESMTP id U8Fb2bYYR6ttDRBv (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 05 Sep 2018 10:57:54 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) by
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 5 Sep 2018 10:57:59 +0800
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6]) by
 HXTBJIDCEMVIW02.hxtcorp.net ([fe80::3e:f4ff:7927:a6f6%12]) with mapi id
 15.00.1395.000; Wed, 5 Sep 2018 10:57:59 +0800
From:   "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To:     Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] soc: fsl: add RCPM driver
Thread-Topic: [PATCH 3/3] soc: fsl: add RCPM driver
X-ASG-Orig-Subj: Re: [PATCH 3/3] soc: fsl: add RCPM driver
Thread-Index: AQHUQN6q4zr6XBl1OE6inyBTrUDhTQ==
Date:   Wed, 5 Sep 2018 02:57:58 +0000
Message-ID: <be39f5ea8c9046b0bf1f6bbfe935fae4@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-3-ran.wang_1@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.64.6.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1536116274
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0100
X-Barracuda-Spam-Score: 0.51
X-Barracuda-Spam-Status: No, SCORE=0.51 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_RULE7568M, ISO2022JP_CHARSET
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.56899
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        -0.00 ISO2022JP_CHARSET      ISO-2022-JP message
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please change your comments style.

On 2018/8/31 11:56, Ran Wang wrote:
> The NXP's QorIQ Processors based on ARM Core have RCPM module (Run
> Control and Power Management), which performs all device-level
> tasks associated with power management such as wakeup source control.
>
> This driver depends on FSL platform PM driver framework which help to
> isolate user and PM service provider (such as RCPM driver).
>
> Signed-off-by: Chenhui Zhao <chenhui.zhao@nxp.com>
> Signed-off-by: Ying Zhang <ying.zhang22455@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/soc/fsl/Kconfig   |    6 ++
>  drivers/soc/fsl/Makefile  |    1 +
>  drivers/soc/fsl/ls-rcpm.c |  153 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/soc/fsl/ls-rcpm.c
>
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> index 6517412..882330d 100644
> --- a/drivers/soc/fsl/Kconfig
> +++ b/drivers/soc/fsl/Kconfig
> @@ -30,3 +30,9 @@ config FSL_PLAT_PM
>  	  have to know the implement details of wakeup function it require.
>  	  Besides, it is also easy for service side to upgrade its logic when
>  	  design changed and remain user side unchanged.
> +
> +config LS_RCPM
> +	bool "Freescale RCPM support"
> +	depends on (FSL_PLAT_PM)
> +	help
> +	  This feature is to enable specified wakeup source for system sleep.
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> index 8f9db23..43ff71a 100644
> --- a/drivers/soc/fsl/Makefile
> +++ b/drivers/soc/fsl/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_QUICC_ENGINE)		+= qe/
>  obj-$(CONFIG_CPM)			+= qe/
>  obj-$(CONFIG_FSL_GUTS)			+= guts.o
>  obj-$(CONFIG_FSL_PLAT_PM)	+= plat_pm.o
> +obj-$(CONFIG_LS_RCPM)		+= ls-rcpm.o
> diff --git a/drivers/soc/fsl/ls-rcpm.c b/drivers/soc/fsl/ls-rcpm.c
> new file mode 100644
> index 0000000..b0feb88
> --- /dev/null
> +++ b/drivers/soc/fsl/ls-rcpm.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// plat_pm.c - Freescale Layerscape RCPM driver
> +//
> +// Copyright 2018 NXP
> +//
> +// Author: Ran Wang <ran.wang_1@nxp.com>,
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_address.h>
> +#include <linux/slab.h>
> +#include <soc/fsl/plat_pm.h>
> +
> +#define MAX_COMPATIBLE_NUM	10
> +
> +struct rcpm_t {
> +	struct device *dev;
> +	void __iomem *ippdexpcr_addr;
> +	bool big_endian;	/* Big/Little endian of RCPM module */
> +};
> +
> +// rcpm_handle - Configure RCPM reg according to wake up source request
> +// @user_dev: pointer to user's device struct
> +// @flag: to enable(true) or disable(false) wakeup source
> +// @handle_priv: pointer to struct rcpm_t instance
> +//
> +// Return 0 on success other negative errno
> +static int rcpm_handle(struct device *user_dev, bool flag, void *handle_priv)
> +{
> +	struct rcpm_t *rcpm;
> +	bool big_endian;
> +	const char  *dev_compatible_array[MAX_COMPATIBLE_NUM];
> +	void __iomem *ippdexpcr_addr;
> +	u32 ippdexpcr;
> +	u32 set_bit;
> +	int ret, num, i;
> +
> +	rcpm = handle_priv;
> +	big_endian = rcpm->big_endian;
> +	ippdexpcr_addr = rcpm->ippdexpcr_addr;
> +
> +	num = device_property_read_string_array(user_dev, "compatible",
> +			dev_compatible_array, MAX_COMPATIBLE_NUM);
> +	if (num < 0)
> +		return num;
> +
> +	for (i = 0; i < num; i++) {
> +		if (!device_property_present(rcpm->dev,
> +					dev_compatible_array[i]))
> +			continue;
> +		else {
Remove this else.
> +			ret = device_property_read_u32(rcpm->dev,
> +					dev_compatible_array[i], &set_bit);
> +			if (ret)
> +				return ret;
> +
> +			if (!device_property_present(rcpm->dev,
> +						dev_compatible_array[i]))
This has been checked. Continue ? or return ENODEV？
> +				return -ENODEV;
> +			else {
Remove this else.
> +				ret = device_property_read_u32(rcpm->dev,
> +						dev_compatible_array[i], &set_bit);
> +				if (ret)
> +					return ret;
> +
> +				if (big_endian)
> +					ippdexpcr = ioread32be(ippdexpcr_addr);
> +				else
> +					ippdexpcr = ioread32(ippdexpcr_addr);
> +
> +				if (flag)
> +					ippdexpcr |= set_bit;
> +				else
> +					ippdexpcr &= ~set_bit;
> +
> +				if (big_endian) {
> +					iowrite32be(ippdexpcr, ippdexpcr_addr);
> +					ippdexpcr = ioread32be(ippdexpcr_addr);
> +				} else
if (x) {
...
...
}  else {

}
> +					iowrite32(ippdexpcr, ippdexpcr_addr);
> +
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int ls_rcpm_probe(struct platform_device *pdev)
> +{
> +	struct resource *r;
> +	struct rcpm_t *rcpm;
> +
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r)
> +		return -ENODEV;
> +
> +	rcpm = kmalloc(sizeof(*rcpm), GFP_KERNEL);
kzalloc is better.
> +	if (!rcpm)
> +		return -ENOMEM;
> +
> +	rcpm->big_endian = device_property_read_bool(&pdev->dev, "big-endian");
> +
> +	rcpm->ippdexpcr_addr = devm_ioremap_resource(&pdev->dev, r);
> +	if (IS_ERR(rcpm->ippdexpcr_addr))
> +		return PTR_ERR(rcpm->ippdexpcr_addr);
> +
> +	rcpm->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, rcpm);
> +
> +	return register_fsl_platform_wakeup_source(rcpm_handle, rcpm);
> +}
> +
> +static int ls_rcpm_remove(struct platform_device *pdev)
> +{
> +	struct rcpm_t	*rcpm;
Not need a table.

Cheers,
-Dongsheng

> +
> +	rcpm = platform_get_drvdata(pdev);
> +	deregister_fsl_platform_wakeup_source(rcpm);
> +	kfree(rcpm);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ls_rcpm_of_match[] = {
> +	{ .compatible = "fsl,qoriq-rcpm-2.1", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ls_rcpm_of_match);
> +
> +static struct platform_driver ls_rcpm_driver = {
> +	.driver = {
> +		.name = "ls-rcpm",
> +		.of_match_table = ls_rcpm_of_match,
> +	},
> +	.probe = ls_rcpm_probe,
> +	.remove = ls_rcpm_remove,
> +};
> +
> +static int __init ls_rcpm_init(void)
> +{
> +	return platform_driver_register(&ls_rcpm_driver);
> +}
> +subsys_initcall(ls_rcpm_init);
> +
> +static void __exit ls_rcpm_exit(void)
> +{
> +	platform_driver_unregister(&ls_rcpm_driver);
> +}
> +module_exit(ls_rcpm_exit);


