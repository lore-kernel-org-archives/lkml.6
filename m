Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F781C4151A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14DF2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qlsgVb4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfBEGMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:12:54 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43394 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfBEGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:12:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x156CmP0012807;
        Tue, 5 Feb 2019 00:12:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549347168;
        bh=9v+CvJHNEejPdkPT+bew0mG1fE0HjBsVYX6dhp5IiAA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qlsgVb4jhOF5uEsNWAyA2cmjXFsLKzJgfjIrdhISN0Q+COTwY7y+LEMbvqVG0ZAGG
         68yRC7UrYOeLnqyYXUh9A0z9r2fy0KV7iN3D/A0zxxgIryG26NeHLDJ1ZoWsjG3iND
         XWtU1K/aB9xb4sGj0F91BzKFZEbNfcULG9oaYYVE=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x156CmJX118534
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 00:12:48 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 00:12:48 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 00:12:48 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x156CjGV024616;
        Tue, 5 Feb 2019 00:12:46 -0600
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190128054935.4972-1-vigneshr@ti.com>
 <20190128054935.4972-3-vigneshr@ti.com>
 <2efbca08-c4ab-34ea-0e34-05aed7168df8@microchip.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <daa35c21-195e-eeb5-8aa2-cf42eff6a554@ti.com>
Date:   Tue, 5 Feb 2019 11:43:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <2efbca08-c4ab-34ea-0e34-05aed7168df8@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/01/19 9:02 PM, Tudor.Ambarus@microchip.com wrote:
> 
> 
> On 01/28/2019 07:49 AM, Vignesh R wrote:
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
>> It also has an integrated PHY. IP register layout is very
>> similar to existing QSPI IP except for additional bits to support Octal
>> and Octal DDR mode. Therefore, extend current driver to support Octal
>> mode. Only Octal SDR read (1-1-8)mode is supported for now.
>>
>> Tested with mt35xu512aba Octal flash on TI's AM654 EVM.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>> ---
>>
>> v5:
>> s/cqsi_base_hwcaps_mask/CQSPI_BASE_HWCAPS_MASK/g
>> Add back cqspi_driver_platdata definition for base compatible.
>>
>> v4: Fix comments by Tudor on v3
>> v3: No changes
>> v2: Declare Octal mode capability based on compatible.
>>
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 58 +++++++++++++++++++++------
>>  1 file changed, 46 insertions(+), 12 deletions(-)
[...]
>>  
>>  static int cqspi_setup_flash(struct cqspi_st *cqspi, struct device_node *np)
>>  {
>> -	const struct spi_nor_hwcaps hwcaps = {
>> -		.mask = SNOR_HWCAPS_READ |
>> -			SNOR_HWCAPS_READ_FAST |
>> -			SNOR_HWCAPS_READ_1_1_2 |
>> -			SNOR_HWCAPS_READ_1_1_4 |
>> -			SNOR_HWCAPS_PP,
>> -	};
>>  	struct platform_device *pdev = cqspi->pdev;
>>  	struct device *dev = &pdev->dev;
>> +	const struct cqspi_driver_platdata *ddata;
>> +	struct spi_nor_hwcaps hwcaps;
>>  	struct cqspi_flash_pdata *f_pdata;
>>  	struct spi_nor *nor;
>>  	struct mtd_info *mtd;
>>  	unsigned int cs;
>>  	int i, ret;
>>  
>> +	ddata = of_device_get_match_data(dev);
>> +	if (!ddata)
>> +		hwcaps.mask = CQSPI_BASE_HWCAPS_MASK;
> 
> Now that .data is set in all cqspi_dt_ids[], maybe it's better to print a
> message and return an error here. But I guess it's a matter of taste, so not a
> show stopper.

Since, driver data is kernel internal field, I guess there is little
help in printing out the error to the user when its missing. I prefer to
keep this as is, as basic Quad mode is supported by all versions of the IP.

Regards
Vignesh

> 
>> +	else
>> +		hwcaps.mask = ddata->hwcaps_mask;
>> +
>>  	/* Get flash device data */
>>  	for_each_available_child_of_node(dev->of_node, np) {
>>  		ret = of_property_read_u32(np, "reg", &cs);
>> @@ -1310,7 +1326,7 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	struct cqspi_st *cqspi;
>>  	struct resource *res;
>>  	struct resource *res_ahb;
>> -	unsigned long data;
>> +	const struct cqspi_driver_platdata *ddata;
>>  	int ret;
>>  	int irq;
>>  
>> @@ -1377,8 +1393,8 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> -	data  = (unsigned long)of_device_get_match_data(dev);
>> -	if (data & CQSPI_NEEDS_WR_DELAY)
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
>>  		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>>  						   cqspi->master_ref_clk_hz);
>>  
>> @@ -1460,14 +1476,32 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>>  #define CQSPI_DEV_PM_OPS	NULL
>>  #endif
>>  
>> +static const struct cqspi_driver_platdata cdns_qspi = {
>> +	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
>> +};
>> +
>> +static const struct cqspi_driver_platdata k2g_qspi = {
>> +	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK,
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata am654_ospi = {
>> +	.hwcaps_mask = CQSPI_BASE_HWCAPS_MASK | SNOR_HWCAPS_READ_1_1_8,
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>>  static const struct of_device_id cqspi_dt_ids[] = {
>>  	{
>>  		.compatible = "cdns,qspi-nor",
>> -		.data = (void *)0,
>> +		.data = &cdns_qspi,
>>  	},
>>  	{
>>  		.compatible = "ti,k2g-qspi",
>> -		.data = (void *)CQSPI_NEEDS_WR_DELAY,
>> +		.data = &k2g_qspi,
>> +	},
>> +	{
>> +		.compatible = "ti,am654-ospi",
>> +		.data = &am654_ospi,
>>  	},
>>  	{ /* end of table */ }
>>  };
>>

-- 
Regards
Vignesh
