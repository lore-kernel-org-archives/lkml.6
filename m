Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF76BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD0C20863
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 04:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HxhgBV4w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfBLEHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 23:07:07 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:55281 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfBLEHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 23:07:06 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212040659epoutp027b0ac2075e5d18756a308597b1168b3e~CgjzU3LsB3084430844epoutp02h
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 04:06:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212040659epoutp027b0ac2075e5d18756a308597b1168b3e~CgjzU3LsB3084430844epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549944419;
        bh=TaBpzeNmiBBwzeCa7ikIQffbWfDHM3PYmGC41jgV6SU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HxhgBV4wyx7RGRatDmuqO8lYQIFFdJ0p1ZitGoEa1dtwoKFDsX/XvaMC5mW+kME79
         4pSo647cCV78XJC/C4HrsYHyiUJZUioKQgzdOg2YU/GsUHc7Y9fiGYAhPZq+DMg6BD
         3RWqc+Xr8cq0+vAmLrNhXHnSdFGTDBZzQ3lq2bmA=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190212040656epcas1p30d45f572f73052faa3a6bfaff78421f4~CgjwvyBfp0997709977epcas1p32;
        Tue, 12 Feb 2019 04:06:56 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        31.B3.04069.066426C5; Tue, 12 Feb 2019 13:06:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190212040655epcas1p3b52711af07b61f63a8781e88d41d3aac~CgjwAsvdj0065400654epcas1p3t;
        Tue, 12 Feb 2019 04:06:55 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190212040655epsmtrp2af8604ec6c49114bc5867af6e7dc4ec2~Cgjv-Llzv1119511195epsmtrp2g;
        Tue, 12 Feb 2019 04:06:55 +0000 (GMT)
X-AuditID: b6c32a37-989ff70000000fe5-11-5c624660a4e1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.F4.03601.F56426C5; Tue, 12 Feb 2019 13:06:55 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190212040655epsmtip194ca9546c93ae518d9e9198ebca89d4e~CgjvnzCwX0589305893epsmtip1Q;
        Tue, 12 Feb 2019 04:06:55 +0000 (GMT)
Subject: Re: [PATCH 3/3] devfreq: add mediatek cci devfreq
To:     Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, fan.chen@mediatek.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3ff7ac1c-6234-1b82-d38d-389906d295e9@samsung.com>
Date:   Tue, 12 Feb 2019 13:06:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDJsWRmVeSWpSXmKPExsWy7bCmvm6CW1KMweN5uhbb179gtZh/5Byr
        xbc7v5kszja9YbfY9Pgaq8XlXXPYLC43X2S0+Nx7hNFi6fWLTBZNLcYWtxtXsFmcOX2J1aJ1
        7xF2i+l3hSw2fvVw4PdYM28No8fOWXfZPTat6mTzuHNtD5vH5iX1Hi0n97N4bLnazuLRt2UV
        o8fnTXIBnFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+Abpu
        mTlA5ysplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCiwL9IoTc4tL89L1kvNzrQwN
        DIxMgQoTsjP+XP7KWPAvqmLCXJ8GxiWeXYycHBICJhLTj9xj7GLk4hAS2MEose5KExOE84lR
        YkvfdDYI5xujRNe9fSwwLW/2/WGGSOxllPj5aAdU/3tGiQ132llBqoQFrCTWzT/ICpIQEbjI
        JLFtyVpmkASzwC1Gidf72UBsNgEtif0vboDZ/AKKEld/PAaaxMHBK2An0bSEByTMIqAqcezy
        UnYQW1QgQuJw7ztGEJtXQFDi5MwnLCDlnAK+Em9WFENMF5e49WQ+E4QtL9G8dTbYoRICp9gl
        Gid2MEF84CKx6t95RghbWOLV8S3sELaUxOd3e9kg7GqJlSePsEE0dwDDYv8FVoiEscT+pZOZ
        QBYzC2hKrN+lD7GMT+Ld1x5WkLCEAK9ER5sQRLWyxOUHd6HWSkosbu+EGu8hsfbrDJYJjIqz
        kHwzC8kLs5C8MAth2QJGllWMYqkFxbnpqcWGBcbIkb2JEZyytcx3MG4453OIUYCDUYmHVyE3
        MUaINbGsuDL3EKMEB7OSCK+zU1KMEG9KYmVValF+fFFpTmrxIUZTYGBPZJYSTc4H5pO8knhD
        UyNjY2MLE0MzU0NDJXHe9Q7OMUIC6YklqdmpqQWpRTB9TBycUg2MxrKGVp/M9ThcLEtsvnOt
        Tq0W32RhceXHP7mf+TJT2Krtt6wIUclYq8rK8f6k2ufnXsaej+f2luXkLvt8qLLgo+S9jDX8
        Ug5mudZxBRyWn5qvdQoGfuotX6vYNeWK5aeSDIVl3+81ztD0r/zj80XyQQ/vs/LWvC2nVQtl
        +A6en7/xymPFaAElluKMREMt5qLiRAA0eQ4O7wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnG68W1KMwfoVJhbb179gtZh/5Byr
        xbc7v5kszja9YbfY9Pgaq8XlXXPYLC43X2S0+Nx7hNFi6fWLTBZNLcYWtxtXsFmcOX2J1aJ1
        7xF2i+l3hSw2fvVw4PdYM28No8fOWXfZPTat6mTzuHNtD5vH5iX1Hi0n97N4bLnazuLRt2UV
        o8fnTXIBnFFcNimpOZllqUX6dglcGX8uf2Us+BdVMWGuTwPjEs8uRk4OCQETiTf7/jB3MXJx
        CAnsZpRYs+49C0RCUmLaxaNACQ4gW1ji8OFiiJq3jBI3rt9gBakRFrCSWDf/ICtIQkTgKpNE
        78Q2FhCHWeAWo8Sm5iPsEC2PGSW+/J4ENpZNQEti/4sbbCA2v4CixNUfjxlBVvAK2Ek0LeEB
        CbMIqEocu7yUHcQWFYiQ+Ph0HxOIzSsgKHFy5hMWkHJOAV+JNyuKQcLMAuoSf+ZdYoawxSVu
        PZnPBGHLSzRvnc08gVF4FpLuWUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjODo1dLawXjiRPwhRgEORiUeXoXcxBgh1sSy4srcQ4wSHMxKIrzOTkkxQrwpiZVV
        qUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhgTDyV2tSbJrPA8oVa2
        Znf2Mp3JtVdaljZvzT3fkBfzsNnuzFPT8nXuR8vXrVp+5PvZb9u/xuz59GZ2wK3jy6MveYU4
        bjYV6dl+g8HVI+6LjF/Mw832Ntf2TuIStQ42Mnvk844z4lBeycbf/46EFV+eulRUknuDq/z5
        pshns89WP3odGMyU0mCmxFKckWioxVxUnAgAFOrpmtoCAAA=
X-CMS-MailID: 20190212040655epcas1p3b52711af07b61f63a8781e88d41d3aac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190129063600epcas2p2e7c1ad6c77c1ffa4ae1b627705b3eb58
References: <1548743704-16821-1-git-send-email-andrew-sh.cheng@mediatek.com>
        <CGME20190129063600epcas2p2e7c1ad6c77c1ffa4ae1b627705b3eb58@epcas2p2.samsung.com>
        <1548743704-16821-4-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew-sh.Cheng,

On 19. 1. 29. 오후 3:35, Andrew-sh Cheng wrote:
> From: "Andrew-sh.Cheng" <andrew-sh.cheng@mediatek.com>
> 
> For big/little cpu cluster architecture,
> not only CPU frequency, but CCI frequency will also affect performance.
> 
> Little cores and cci share the same buck in Mediatek mt8183 IC,
> so we add a CCI devfreq which will get notification when buck voltage
> is changed, then CCI devfreq can set cci frequency as high as possible.
> 
> Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/devfreq/Kconfig              |   9 ++
>  drivers/devfreq/Makefile             |   1 +
>  drivers/devfreq/mt8183-cci-devfreq.c | 224 +++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/devfreq/mt8183-cci-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 6a172d3..0b14aab 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -113,6 +113,15 @@ config ARM_RK3399_DMC_DEVFREQ
>            It sets the frequency for the memory controller and reads the usage counts
>            from hardware.
>  
> +config ARM_MT8183_CCI_DEVFREQ
> +	tristate "MT8183 CCI DEVFREQ Driver"
> +	depends on ARM_MEDIATEK_CPUFREQ
> +	help
> +		This adds devfreq for cci clock
> +		which is shared the same regulator with cpu cluster.
> +		It can track buck voltage and update a proper cci frequency.
> +		Use notification to get regulator status.
> +

Move ARM_MT8183_CCI_DEVFREQ under ARM_EXYNOS_BUS_DEVFREQ.
On later, I'll change the order between ARM_TEGRA_DEVFREQ and ARM_RK3399_DMC_DEVFREQ
alphabetically. So, you better to keep the order of name.


>  source "drivers/devfreq/event/Kconfig"
>  
>  endif # PM_DEVFREQ
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 32b8d4d..25afe8c 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra-devfreq.o
> +obj-$(CONFIG_ARM_MT8183_CCI_DEVFREQ)	+= mt8183-cci-devfreq.o

Move it under obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ).

>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/mt8183-cci-devfreq.c b/drivers/devfreq/mt8183-cci-devfreq.c
> new file mode 100644
> index 0000000..4837892
> --- /dev/null
> +++ b/drivers/devfreq/mt8183-cci-devfreq.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.

Add blank line and change year 2018 -> 2019.

> +#include <linux/cpu.h>
> +#include <linux/cpufreq.h>

This driver doesn't use any helper function of cpufreq.h/cpu.h.
It depends on devfreq/regulator framework. Please remove them.

> +#include <linux/devfreq.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "governor.h"
> +
> +struct cci_devfreq_data {
> +	struct devfreq		*devfreq;
> +	struct regulator	*proc_reg;
> +	struct clk		*cci_clk;
> +	unsigned long		buck_volt;
> +	int			volt_increasing;
> +	struct notifier_block	nb;
> +};
> +
> +static int mtk_cci_governor_get_target(struct devfreq *devfreq,
> +				       unsigned long *freq)
> +{
> +	struct cci_devfreq_data *cci_devdata;
> +	int	i, opp_count;
> +	struct dev_pm_opp	*opp;
> +	unsigned long	opp_rate, opp_voltage;

Above three definitions use the tab for indentation. Please use space.

> +
> +	cci_devdata = dev_get_drvdata(devfreq->dev.parent);
> +
> +	/* find available frequency */
> +	opp_count = dev_pm_opp_get_opp_count(devfreq->dev.parent);
> +	for (i = 0, opp_rate = ULONG_MAX; i < opp_count; i++, opp_rate--) {
> +		opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent,
> +						 &opp_rate);
> +		opp_voltage = dev_pm_opp_get_voltage(opp);
> +		dev_pm_opp_put(opp);
> +
> +		if (opp_voltage <= cci_devdata->buck_volt)
> +			break;
> +	}
> +	*freq = opp_rate;
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_governor_event_handler(struct devfreq *devfreq,
> +					  unsigned int event, void *data)
> +{
> +	return 0;
> +}

The devfreq core enables the governor with using DEVFREQ_GOV_START.
But, this driver just start after proving the device driver. It break
the previous sequence of governor.

So, if you register/unregister the regulator as following,
it can keep the existing sequence for governor starting.

	case DEVFREQ_GOV_START:
	case DEVFREQ_GOV_RESUME:
		regulator_register_notifier(...);

	case DEVFREQ_GOV_STOP:
	case DEVFREQ_GOV_SUSPEND:
		regulator_unregister_notifier(...);
		break;

> +
> +static struct devfreq_governor mtk_cci_devfreq_governor = {
> +	.name = "voltage_monitor",
> +	.get_target_freq = mtk_cci_governor_get_target,
> +	.event_handler = mtk_cci_governor_event_handler,
> +};
> +
> +static int mtk_cci_devfreq_target(struct device *dev, unsigned long *freq,
> +				  u32 flags)
> +{
> +	struct cci_devfreq_data *cci_devdata;
> +
> +	cci_devdata = dev_get_drvdata(dev);

You better to modify it as following:

	struct cci_devfreq_data *cci_devdata = dev_get_drvdata(dev);
	
	if (!cci_devdata)
		return -EINVAL;

> +
> +	clk_set_rate(cci_devdata->cci_clk, *freq);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile cci_devfreq_profile = {
> +	.polling_ms	= 0,

Dont' need to initialize it as zero. just remove this line.

> +	.target		= mtk_cci_devfreq_target,
> +};
> +
> +static int cci_devfreq_regulator_notifier(struct notifier_block *nb,
> +					  unsigned long val, void *data)
> +{
> +	struct cci_devfreq_data *cci_devdata =
> +		container_of(nb, struct cci_devfreq_data, nb);
> +
> +	/* deal with reduce frequency */
> +	if (val & REGULATOR_EVENT_PRE_VOLTAGE_CHANGE) {
> +		struct pre_voltage_change_data *pvc_data = data;
> +
> +		if (pvc_data->old_uV > pvc_data->min_uV) {
> +			cci_devdata->volt_increasing = 0;

IMO, 'volt_increasing' is not clear. Instead, cci_devdata
could have the 'previous_voltage' variable instead of volt_increasing.
And you could use 'previous_voltage' for comparision.

> +			cci_devdata->buck_volt =
> +				(unsigned long)(pvc_data->min_uV);
> +			mutex_lock(&cci_devdata->devfreq->lock);
> +			update_devfreq(cci_devdata->devfreq);
> +			mutex_unlock(&cci_devdata->devfreq->lock);
> +		} else {
> +			cci_devdata->volt_increasing = 1;
> +		}
> +	}
> +	/* deal with abort reduce frequency */
> +	if ((val & REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE) ||

if -> else if

At the same time, receives only one notification.
It is not necessary to check the two if statement always, .



> +	    /* deal with increase frequency */
> +	    ((val & REGULATOR_EVENT_VOLTAGE_CHANGE) &&
> +	     cci_devdata->volt_increasing == 1)) {
> +		cci_devdata->buck_volt = (unsigned long)data;
> +		mutex_lock(&cci_devdata->devfreq->lock);
> +		update_devfreq(cci_devdata->devfreq);
> +		mutex_unlock(&cci_devdata->devfreq->lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cci_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *cci_dev = &pdev->dev;
> +	struct cci_devfreq_data *cci_devdata;
> +	struct notifier_block *nb;
> +	int ret;
> +
> +	dev_pm_opp_of_add_table(&pdev->dev);

Move it after getting clock/regulator. After checking that all resourcess are available,
and then you better to get the opp table. And check the return value  of dev_pm_opp...()

> +
> +	cci_devdata = devm_kzalloc(cci_dev, sizeof(*cci_devdata), GFP_KERNEL);
> +	if (!cci_devdata)
> +		return -ENOMEM;
> +	nb = &cci_devdata->nb;
> +	cci_devdata->cci_clk = ERR_PTR(-ENODEV);

It should be handled when error happen. It is not good for readability.

> +	cci_devdata->proc_reg = ERR_PTR(-ENODEV);

ditto.

> +
> +	cci_devdata->cci_clk = clk_get(cci_dev, "cci_clock");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->cci_clk);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci clock not ready, retry\n");

You should use 'dev_err' instead of pr_err on this driver.

I think that don't show the error when EPROBE_DEFER. you better to just return.

> +		else
> +			pr_err("no clock for cci: %d\n", ret);

How about changing the log like below?
"failed to get clock for CCI"

pr_err -> dev_err

> +
> +		goto out_free_resources;
> +	}
> +
> +	cci_devdata->proc_reg = regulator_get_optional(cci_dev, "proc");
> +	ret = PTR_ERR_OR_ZERO(cci_devdata->proc_reg);
> +	if (ret) {
> +		if (ret == -EPROBE_DEFER)
> +			pr_err("cci regulator not ready, retry\n");

ditto.

> +		else
> +			pr_err("no regulator for cci: %d\n", ret);

How about changing the log like below?
"failed to get regulator for CCI"

> +
> +		goto out_free_resources;
> +	}
> +
> +	platform_set_drvdata(pdev, cci_devdata);
> +
> +	/* create cci_devfreq and add to cci device.
> +	 * governor is voltage_monitor.
> +	 * governor will get platform_device data to make decision.
> +	 */

I think that you don't need to explain the kind of governor and how to
decide the next frequency by governor. It is enough to call the devm_devfreq_add_device.

> +	cci_devdata->devfreq = devm_devfreq_add_device(cci_dev,
> +						       &cci_devfreq_profile,
> +						       "voltage_monitor",
> +						       NULL);
> +
> +	nb->notifier_call = cci_devfreq_regulator_notifier;
> +	regulator_register_notifier(cci_devdata->proc_reg,
> +				    nb);

As I commented, regulator_register_notifier() should be handled in event_handler function.

> +
> +	return 0;
> +
> +out_free_resources:
> +	if (!IS_ERR(cci_devdata->cci_clk))
> +		clk_put(cci_devdata->cci_clk);
> +	if (!IS_ERR(cci_devdata->proc_reg))
> +		regulator_put(cci_devdata->proc_reg);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id mediatek_cci_devfreq_of_match[] = {
> +	{ .compatible = "mediatek,mt8183-cci" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, mediatek_cci_devfreq_of_match);
> +
> +static struct platform_driver cci_devfreq_driver = {
> +	.probe	= mtk_cci_devfreq_probe,
> +	.driver = {
> +		.name = "mediatek-cci-devfreq",
> +		.of_match_table = mediatek_cci_devfreq_of_match,
> +	},
> +};
> +
> +static int __init mtk_cci_devfreq_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = devfreq_add_governor(&mtk_cci_devfreq_governor);
> +	if (ret) {
> +		pr_err("%s: failed to add governor: %d\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	ret = platform_driver_register(&cci_devfreq_driver);
> +	if (ret)
> +		devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +
> +	return ret;
> +}
> +module_init(mtk_cci_devfreq_init)
> +
> +static void __exit mtk_cci_devfreq_exit(void)
> +{
> +	int ret = 0;
> +
> +	platform_driver_unregister(&cci_devfreq_driver);
> +
> +	ret = devfreq_remove_governor(&mtk_cci_devfreq_governor);
> +	if (ret)
> +		pr_err("%s: failed to remove governor: %d\n", __func__, ret);
> +}
> +module_exit(mtk_cci_devfreq_exit)
> +
> +MODULE_LICENSE("GPL v2");

nitpick. better to move it under MODULE_AUTHOR("")

> +MODULE_DESCRIPTION("Mediatek CCI devfreq driver");
> +MODULE_AUTHOR("andrew-sh.cheng");

Add full name and email as following:
- MODULE_AUTHOR("Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>"


> +
> 

Remove unneeded blank line.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
