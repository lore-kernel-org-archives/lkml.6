Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A40FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3093420817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="o+2CxZJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3093420817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeK0IKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:10:36 -0500
Received: from vern.gendns.com ([98.142.107.122]:43820 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeK0IKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PTY5HB7fVTFFAAZeV+GiHcPg/H9ZlU87Svhs4IutOlU=; b=o+2CxZJVi0xHDYJSxVYhDhlTml
        RNwPCEtufiUCMwcojxoBjFuXuZiopDp+7e2BrdFx907Mt2Tm14em3bY3kZ9rfpzGjXwwfKRsHwWVN
        DDHhmTx2jRmkw+WVEejSi4OICcKp4qWPsPQtucYoL52M7qnva0fG0d/fVET6BzD9L7MUaPPYFZBLS
        uPq2daZdFw3mdGCAM25FMCLzJDO3pKKvtmq8YPpdtAXwxVuwlzzpB4CHd0E0hJmvbT8NMmvG0Qfu8
        7ax7ULZQ214yP3peMVjJRQ9cHd8e2YsEAApq/V7pKWWXPZABmZfJopUPet+d5aVfvpH+lSvygWVAN
        DIsPql8w==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44794 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gROCu-00024q-W4; Mon, 26 Nov 2018 16:14:17 -0500
Subject: Re: [PATCH 06/17] soc: ti: pruss: Add a platform driver for PRUSS in
 TI SoCs
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-7-git-send-email-rogerq@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <1608af03-35b5-79ce-4995-84e85e740687@lechnology.com>
Date:   Mon, 26 Nov 2018 15:15:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542886753-17625-7-git-send-email-rogerq@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/18 5:39 AM, Roger Quadros wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> The PRUSS platform driver deals with the overall PRUSS and is
> used for managing the subsystem level resources like various
> memories. It is responsible for the creation and deletion of
> the platform devices for the child PRU devices and other child
> devices (Interrupt Controller or MDIO node or some syscon nodes)
> so that they can be managed by specific platform drivers.
> 
> This design provides flexibility in representing the different
> modules of PRUSS accordingly, and at the same time allowing the
> PRUSS driver to add some instance specific configuration within
> an SoC.
> 
> The driver currently supports the AM335x SoC.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   drivers/soc/ti/Makefile |   2 +-
>   drivers/soc/ti/pruss.c  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/soc/ti/pruss.h  |  44 ++++++++++++++++++
>   3 files changed, 161 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/soc/ti/pruss.c
>   create mode 100644 drivers/soc/ti/pruss.h
> 

...

> diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
> new file mode 100644
> index 0000000..0840b59
> --- /dev/null
> +++ b/drivers/soc/ti/pruss.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PRU-ICSS platform driver for various TI SoCs
> + *
> + * Copyright (C) 2014-2018 Texas Instruments Incorporated - http://www.ti.com/
> + *	Suman Anna <s-anna@ti.com>
> + *	Andrew F. Davis <afd@ti.com>
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>

alphabetical order?

> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +
> +#include "pruss.h"
> +
> +static int pruss_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *np;
> +	struct pruss *pruss;
> +	struct resource res;
> +	int ret, i, index;
> +	const char *mem_names[PRUSS_MEM_MAX] = { "dram0", "dram1", "shrdram2" };
> +
> +	if (!node) {
> +		dev_err(dev, "Non-DT platform device not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(dev, "dma_set_coherent_mask: %d\n", ret);
> +		return ret;
> +	}
> +
> +	pruss = devm_kzalloc(dev, sizeof(*pruss), GFP_KERNEL);
> +	if (!pruss)
> +		return -ENOMEM;
> +
> +	pruss->dev = dev;
> +
> +	np = of_get_child_by_name(node, "memories");
> +	if (!np)

error message?

> +		return -ENODEV;
> +
> +	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> +		index = of_property_match_string(np, "reg-names", mem_names[i]);
> +		if (index < 0) {
> +			of_node_put(np);
> +			return index;
> +		}
> +
> +		if (of_address_to_resource(np, index, &res)) {
> +			of_node_put(np);
> +			return -EINVAL;
> +		}
> +
> +		pruss->mem_regions[i].va = devm_ioremap(dev, res.start,
> +							resource_size(&res));
> +		if (!pruss->mem_regions[i].va) {
> +			dev_err(dev, "failed to parse and map memory resource %d %s\n",
> +				i, mem_names[i]);
> +			of_node_put(np);
> +			return -ENOMEM;
> +		}
> +		pruss->mem_regions[i].pa = res.start;
> +		pruss->mem_regions[i].size = resource_size(&res);
> +
> +		dev_dbg(dev, "memory %8s: pa %pa size 0x%zx va %p\n",
> +			mem_names[i], &pruss->mem_regions[i].pa,
> +			pruss->mem_regions[i].size, pruss->mem_regions[i].va);
> +	}
> +	of_node_put(np);
> +
> +	platform_set_drvdata(pdev, pruss);
> +
> +	dev_info(&pdev->dev, "creating PRU cores and other child platform devices\n");

Is this really needed? Or dev_dbg instead?

> +	ret = of_platform_populate(node, NULL, NULL, &pdev->dev);
> +	if (ret)
> +		dev_err(dev, "of_platform_populate failed\n");
> +
> +	return ret;
> +}
> +
> +static int pruss_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	dev_info(dev, "remove PRU cores and other child platform devices\n");

same here... looks like debug message

> +	of_platform_depopulate(dev);
> +
> +	return 0;
> +}
> +
