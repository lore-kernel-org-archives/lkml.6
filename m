Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEBAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31FC206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 14:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sLxiFdFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBXOGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 09:06:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41773 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfBXOGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 09:06:49 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so4948206lfj.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7AyGWsy6lqqt1CMP5klNyO7Se+yGqcYOfqOpxc8ZyY=;
        b=sLxiFdFpGTAsznEby3fF1geo7APwsBaQOD5Qtryj0FV6wz6OTh1jW1/9OvX5oMt5rT
         TKn4WCt5Q+x2EGyQHaZ5l/bSTyH2zfkNTFOttdFbGWBdy5b3OaNRwLOWtvkj4YpOIQuk
         OUw/nU9u3Uh6UgoCV6jXX8Bcm1aTB5s3U3EZ3gLPUVudvvbiRk7pi2jh8HEDATD2aZal
         pzVImyqAkskZRmf7jJ7HaIJTZklEBrnOajrYZs86qQFAui0nJ6+0ZduOSvHlHPsOOKkP
         DqL0JEELpEUALXT4TaDI5dfajiBpza+DZn/3qVioeBS385YS1IFDezEYVZ4IU0rarodM
         p/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7AyGWsy6lqqt1CMP5klNyO7Se+yGqcYOfqOpxc8ZyY=;
        b=ko+BPKknHbMZGpFI1aiRMZ1iaU4sahoJ7pFcqYhHAtz41TZNWt7IV8YVTcK4q0p7/Q
         bTbb/vaq2FOkJNBktQZzAqvTinyRAco4JXWI4zUqnKcm6vp5SAjWxpFQcsnQ9rmoUEL/
         bomqTQXWAYBuS9Zhagyje5R38uv5lQAzIXJsBZxziPG4ZZBz/eT5DrnB6x26jd4MgBo3
         1TDSQo5jt4e4b3vmSOJsIe2l7lblu6obIE9Iar4vdDHRTmAquoopv9n7DGN5TrDlLnFm
         fY5HlaT1KxBsWJx7SkO835EW6LnWZskmeCRPylwYqDewt5gIRTebHq4jvH45pPUxzNFv
         B34A==
X-Gm-Message-State: AHQUAuYQeMOCyj8vBeXS8ZXX5NkmUJk3qwVtMCMssXIG49TXekEtZVDD
        UU74UGMMIkI86/3MF8/tl/wmKw==
X-Google-Smtp-Source: AHgI3IalkRMkO15u/S1T1c9U+qR+uhOu2lPS0TW2/sC74Xcb7Y3gq3zt7QQ/crFfS9sBMFEXKjtJcw==
X-Received: by 2002:a19:5209:: with SMTP id m9mr7437620lfb.51.1551017207080;
        Sun, 24 Feb 2019 06:06:47 -0800 (PST)
Received: from [192.168.0.199] ([31.173.83.141])
        by smtp.gmail.com with ESMTPSA id c22sm2254961lfi.27.2019.02.24.06.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 06:06:46 -0800 (PST)
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To:     "Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>)" 
        <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        tudor.ambarus@microchip.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <61d04389-414a-70d8-ad33-36ed138df38c@cogentembedded.com>
Date:   Sun, 24 Feb 2019 17:06:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190219063607.29949-6-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 19.02.2019 9:36, Vignesh R (by way of Boris Brezillon
<bbrezillon@kernel.org>) wrote:

> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
> IP is pretty simple and provides direct memory mapped access to
> connected Flash devices.
> 
> Add basic support for the IP without DMA. Second ChipSelect is not
> supported for now.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>   drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>   1 file changed, 105 insertions(+)
>   create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
> 
> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
> new file mode 100644
> index 000000000000..1f0d2dc52f9f
> --- /dev/null
> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +// Author: Vignesh R <vigneshr@ti.com>
> +
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mtd/hyperbus.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/types.h>
> +
> +struct am654_hbmc_priv {
> +	struct hb_device hbdev;
> +	void __iomem	*regbase;
> +};
> +
> +static int am654_hbmc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct am654_hbmc_priv *priv;
> +	struct resource *res;
> +	int err;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (IS_ERR(res)) {

     I don't think that function ever returns error ptrs. It should only 
return NULL on error.

> +		dev_err(&pdev->dev, "failed to get memory resource\n");
> +		return -ENOENT;
> +	}
> +
> +	priv->regbase = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->regbase)) {
> +		dev_err(dev, "Cannot remap controller address.\n");

    The above function already prints its error messages.

[...]
> +module_platform_driver(am654_hbmc_platform_driver);
> +
> +MODULE_DESCRIPTION("HBMC driver for AM654 SoC");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:hbmc-am654");
> +MODULE_AUTHOR("Vignesh R <vigneshr@ti.com>");

MBR, Sergei
