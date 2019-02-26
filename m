Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E428217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lqa0Vgu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfBZKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:17:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51842 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfBZKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:17:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QAH4iJ117079;
        Tue, 26 Feb 2019 04:17:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551176224;
        bh=WA/f8ss2biY7S1l6fEMwhLw3XtRQh3PtpW9p8svW6C4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lqa0Vgu1Eo6UUx+ha4mwXvJaE76MvI1F5gCeVIFfew6xnwE5I0z9rcQ0kBiE90tsw
         M579QnuhehevAbsA93TvXqMcyTFNLqi6I02yV5bMb3YMHok4FYPvTGjBTXGLhNfr8o
         zIQ6NXF0sF/zQi8NKQ+KBbNjBg6eYiEeUZf+dKlI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QAH3gT103790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 04:17:03 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 04:17:03 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 04:17:03 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QAGwMX006788;
        Tue, 26 Feb 2019 04:16:59 -0600
Subject: Re: [RFC PATCH 5/5] mtd: hyperbus: Add driver for TI's Hyperbus
 memory controller
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        <tudor.ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190219063607.29949-1-vigneshr@ti.com>
 <20190219063607.29949-6-vigneshr@ti.com>
 <907041d1-8412-22ca-3716-109a56251850@cogentembedded.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <24b7c553-44c9-4800-a455-31b9b2c1f8c5@ti.com>
Date:   Tue, 26 Feb 2019 15:48:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <907041d1-8412-22ca-3716-109a56251850@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/19 9:59 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 02/19/2019 09:36 AM, Vignesh R (by way of Boris Brezillon <bbrezillon@kernel.org>) wrote:
> 
>> Add driver for Hyperbus memory controller on TI's AM654 SoC. Programming
>> IP is pretty simple and provides direct memory mapped access to
>> connected Flash devices.
> 
>    Are you sure you posted the _complete_ driver?
> 


Yes, it is... You can find controller doc here[1]. Default values in the
MCR/MTR registers are good enough to simple Hyperflash access.
More perf optimization and timing optimizations will come incrementally

[1] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf 12.3.3 Hyperbus Interface

>> Add basic support for the IP without DMA. Second ChipSelect is not
>> supported for now.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  drivers/mtd/hyperbus/hbmc_am654.c | 105 ++++++++++++++++++++++++++++++
>>  1 file changed, 105 insertions(+)
>>  create mode 100644 drivers/mtd/hyperbus/hbmc_am654.c
>>
>> diff --git a/drivers/mtd/hyperbus/hbmc_am654.c b/drivers/mtd/hyperbus/hbmc_am654.c
>> new file mode 100644
>> index 000000000000..1f0d2dc52f9f
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/hbmc_am654.c
>> @@ -0,0 +1,105 @@
> [...]
>> +static int am654_hbmc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct am654_hbmc_priv *priv;
>> +	struct resource *res;
>> +	int err;
>> +
>> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, priv);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (IS_ERR(res)) {
>> +		dev_err(&pdev->dev, "failed to get memory resource\n");
>> +		return -ENOENT;
>> +	}
>> +
>> +	priv->regbase = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(priv->regbase)) {
>> +		dev_err(dev, "Cannot remap controller address.\n");
>> +		return PTR_ERR(priv->regbase);
>> +	}
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +	err = pm_runtime_get_sync(&pdev->dev);
> 
>    That's all nice but where's the code that accesses the actual registers?

Interface and functional clk needs to be enabled even to access MMIO
space to read/write data to flash (done by the map framework). So driver
currently just enables everything during probe and disables on remove

> 
>> +	if (err < 0) {
>> +		pm_runtime_put_noidle(&pdev->dev);
> 
>    Calling "put" with previously failed "get" sees strange...
> 

Basically pm_runtime_get_sync() increments usage_count even in case of
failure and pm_runtime_put_noidle() puts it back. You can find many
examples of above piece of code in kernel.

>> +		return err;
>> +	}
>> +
>> +	priv->hbdev.needs_calib = true;
>> +	priv->hbdev.dev = &pdev->dev;
>> +	priv->hbdev.np = of_get_next_child(dev->of_node, NULL);
>> +	err = hb_register_device(&priv->hbdev);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to register controller\n");
>> +		goto err_destroy;
>> +	}
>> +
>> +	return 0;
>> +
>> +err_destroy:
>> +	hb_unregister_device(&priv->hbdev);
> 
>    Calling "unregister" with "register" previously failed also looks strange...
> 

Agree, this is unneeded as hb_register_device() takes care of all
cleanups in err path.

>> +	pm_runtime_put_sync(&pdev->dev);
> 
>    Why the sync() version?
> 

Why not? Since the device is going away, I think its safer to ensure
device has definitely been put to idle state. I see its a common
practice in driver code.

>> +	return err;
>> +}
> [...]
> 
> MBR, Sergei
> 

-- 
Regards
Vignesh
