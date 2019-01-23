Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C42DC282C5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6325621726
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wTvNLKQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfAWJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:13:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33628 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:13:47 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0N9Dfpx088876;
        Wed, 23 Jan 2019 03:13:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548234821;
        bh=ME2UghHWm60URYd5XeRPWEMfsgcmQm+/B9KBqqO3z84=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wTvNLKQ9clHTJUDAacR7QM8OXWymQWDRltDgE467fi+EgWT4qF2Tdy4rT2iz4UyJy
         2EusFw8C7cY77V1Vr5F2cUdcqfMCQLDYBCx9K7aYYWKF/NubgXB1CpTuJchfPiqm/X
         3+CZ43TcucDgYxW+7jE6ig+Zmx/gEE6LI+9ex6Zo=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0N9Df41084866
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Jan 2019 03:13:41 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 23
 Jan 2019 03:13:40 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 23 Jan 2019 03:13:40 -0600
Received: from [172.24.223.231] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0N9DbLN015066;
        Wed, 23 Jan 2019 03:13:38 -0600
Subject: Re: [PATCH v4 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     <Tudor.Ambarus@microchip.com>, Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190122064137.17114-1-vigneshr@ti.com>
 <20190122064137.17114-3-vigneshr@ti.com> <20190123094552.57665d2e@bbrezillon>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <99eaa2bf-abc2-5432-31fd-e319fddcf478@ti.com>
Date:   Wed, 23 Jan 2019 14:43:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123094552.57665d2e@bbrezillon>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23-Jan-19 2:15 PM, Boris Brezillon wrote:
> On Tue, 22 Jan 2019 12:11:37 +0530
> Vignesh R <vigneshr@ti.com> wrote:
> 
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
>> It also has an integrated PHY. IP register layout is very
>> similar to existing QSPI IP except for additional bits to support Octal
>> and Octal DDR mode. Therefore, extend current driver to support Octal
>> mode. Only Octal SDR read (1-1-8)mode is supported for now.
>>
>> Tested with mt35xu512aba Octal flash on TI's AM654 EVM.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> v4: Fix comments by Tudor on v3
>> v3: No changes
>> v2: Declare Octal mode capability based on compatible.
>>
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 53 +++++++++++++++++++++------
>>  1 file changed, 41 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 04cedd3a2bf6..2091addc45a3 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -44,6 +44,12 @@
>>  /* Quirks */
>>  #define CQSPI_NEEDS_WR_DELAY		BIT(0)
>>  
>> +/* Capabilities mask */
>> +#define cqspi_base_hwcaps_mask					\
> 
> Nit: we usually use upper cases for such definitions.
> 

Will fix.

>> +	(SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |		\
>> +	SNOR_HWCAPS_READ_1_1_2 | SNOR_HWCAPS_READ_1_1_4 |	\
>> +	SNOR_HWCAPS_PP)
>> +
>>  struct cqspi_st;
>>  
>>  struct cqspi_flash_pdata {
>> @@ -93,6 +99,11 @@ struct cqspi_st {
>>  	struct cqspi_flash_pdata f_pdata[CQSPI_MAX_CHIPSELECT];
>>  };
>>  
>> +struct cqspi_driver_platdata {
>> +	u32 hwcaps_mask;
>> +	u8 quirks;
>> +};
>> +
>>  /* Operation timeout value */
>>  #define CQSPI_TIMEOUT_MS			500
>>  #define CQSPI_READ_TIMEOUT_MS			10
>> @@ -101,6 +112,7 @@ struct cqspi_st {
>>  #define CQSPI_INST_TYPE_SINGLE			0
>>  #define CQSPI_INST_TYPE_DUAL			1
>>  #define CQSPI_INST_TYPE_QUAD			2
>> +#define CQSPI_INST_TYPE_OCTAL			3
>>  
>>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>>  #define CQSPI_DUMMY_BYTES_MAX			4
>> @@ -911,6 +923,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>>  		case SNOR_PROTO_1_1_4:
>>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>>  			break;
>> +		case SNOR_PROTO_1_1_8:
>> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
>> +			break;
>>  		default:
>>  			return -EINVAL;
>>  		}
>> @@ -1213,21 +1228,22 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
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
>> +		hwcaps.mask = cqspi_base_hwcaps_mask;
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
>> @@ -1460,14 +1476,27 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>>  #define CQSPI_DEV_PM_OPS	NULL
>>  #endif
>>  
>> +static const struct cqspi_driver_platdata k2g_qspi = {
>> +	.hwcaps_mask = cqspi_base_hwcaps_mask,
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>> +static const struct cqspi_driver_platdata am654_ospi = {
>> +	.hwcaps_mask = cqspi_base_hwcaps_mask | SNOR_HWCAPS_READ_1_1_8,
>> +	.quirks = CQSPI_NEEDS_WR_DELAY,
>> +};
>> +
>>  static const struct of_device_id cqspi_dt_ids[] = {
>>  	{
>>  		.compatible = "cdns,qspi-nor",
>> -		.data = (void *)0,
> 
> Can't we have a cqspi_driver_platdata instance for that one too?

I had that in v3, will add it back. Thanks for the review!

> 
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
> 

Regards
Vignesh
