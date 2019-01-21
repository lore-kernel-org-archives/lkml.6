Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D6AC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F5720855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T5aexcgo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbfAUIaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:30:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:36180 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbfAUIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:30:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L5vkqg106309;
        Sun, 20 Jan 2019 23:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548050266;
        bh=lzqQLpS/P25NCb7i+MtaLYfVAV05RMu1f8HW1xXwa2s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=T5aexcgouMoSzguDqm7Lm+DU+nsP8jtHamonafApRHCx5mJqFCLiB5bOxMFF6woTo
         pgbPjFERBvpY52klmmeO8ktCz6yJA8HEFlLpnOn/1TbAAnCyyxsJF5J4lFkizb/7Bl
         endhyKpmKxDTf0bmPXOrAnIuRgvM82VGz2Hs9mLw=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L5vkup043839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 23:57:46 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 20
 Jan 2019 23:57:46 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 20 Jan 2019 23:57:46 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L5vfUG032183;
        Sun, 20 Jan 2019 23:57:44 -0600
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: cadence-quadspi: Add support for
 Octal SPI controller
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190116103027.22657-1-vigneshr@ti.com>
 <20190116103027.22657-3-vigneshr@ti.com>
 <6e6f7c3a-4772-1a17-0f5f-547ea9809283@microchip.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <1fc56694-fdac-ea99-79d3-cd0fad196c3c@ti.com>
Date:   Mon, 21 Jan 2019 11:28:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6e6f7c3a-4772-1a17-0f5f-547ea9809283@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tudor,

On 20/01/19 8:26 PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Vignesh,
> 
> On 01/16/2019 12:30 PM, Vignesh R wrote:
>> Cadence OSPI controller IP supports Octal IO (x8 IO lines),
>> It also has an integrated PHY. IP register layout is very
>> similar to existing QSPI IP except for additional bits to support Octal
>> and Octal DDR mode. Therefore, extend current driver to support Octal
>> mode.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>> v3: No changes
>>
>> v2:
>> Declare Octal mode capability based on compatible.
>>
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 54 +++++++++++++++++++++------
>>  1 file changed, 42 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 04cedd3a2bf6..31ed50f78972 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -93,6 +93,11 @@ struct cqspi_st {
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
>> @@ -101,6 +106,7 @@ struct cqspi_st {
>>  #define CQSPI_INST_TYPE_SINGLE			0
>>  #define CQSPI_INST_TYPE_DUAL			1
>>  #define CQSPI_INST_TYPE_QUAD			2
>> +#define CQSPI_INST_TYPE_OCTAL			3
>>  
>>  #define CQSPI_DUMMY_CLKS_PER_BYTE		8
>>  #define CQSPI_DUMMY_BYTES_MAX			4
>> @@ -911,6 +917,9 @@ static int cqspi_set_protocol(struct spi_nor *nor, const int read)
>>  		case SNOR_PROTO_1_1_4:
>>  			f_pdata->data_width = CQSPI_INST_TYPE_QUAD;
>>  			break;
>> +		case SNOR_PROTO_1_1_8:
>> +			f_pdata->data_width = CQSPI_INST_TYPE_OCTAL;
>> +			break;
>>  		default:
>>  			return -EINVAL;
>>  		}
>> @@ -1213,21 +1222,19 @@ static void cqspi_request_mmap_dma(struct cqspi_st *cqspi)
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
>> +	struct cqspi_driver_platdata *ddata;
> 
> const struct cqspi_driver_platdata *ddata;
> 
>> +	struct spi_nor_hwcaps hwcaps;
>>  	struct cqspi_flash_pdata *f_pdata;
>>  	struct spi_nor *nor;
>>  	struct mtd_info *mtd;
>>  	unsigned int cs;
>>  	int i, ret;
>>  
>> +	ddata = (struct cqspi_driver_platdata *)of_device_get_match_data(dev);
> 
> You forgot to check for NULL. Also, I would expect an implicit type cast, you
> can drop the explicit cast.
> 
>> +	hwcaps.mask = ddata->hwcaps_mask;
>> +
>>  	/* Get flash device data */
>>  	for_each_available_child_of_node(dev->of_node, np) {
>>  		ret = of_property_read_u32(np, "reg", &cs);
>> @@ -1310,7 +1317,7 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	struct cqspi_st *cqspi;
>>  	struct resource *res;
>>  	struct resource *res_ahb;
>> -	unsigned long data;
>> +	struct cqspi_driver_platdata *ddata;
> 
> const struct cqspi_driver_platdata *ddata;
> 
>>  	int ret;
>>  	int irq;
>>  
>> @@ -1377,8 +1384,8 @@ static int cqspi_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	cqspi->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> -	data  = (unsigned long)of_device_get_match_data(dev);
>> -	if (data & CQSPI_NEEDS_WR_DELAY)
>> +	ddata  = (struct cqspi_driver_platdata *)of_device_get_match_data(dev);
> 
> I would expect an implicit type cast, you can drop the explicit cast.
> 
>> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
>>  		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>>  						   cqspi->master_ref_clk_hz);
>>  
>> @@ -1460,14 +1467,37 @@ static const struct dev_pm_ops cqspi__dev_pm_ops = {
>>  #define CQSPI_DEV_PM_OPS	NULL
>>  #endif
>>  
>> +#define cqspi_base_hwcaps_mask					\
>> +	(SNOR_HWCAPS_READ | SNOR_HWCAPS_READ_FAST |		\
>> +	SNOR_HWCAPS_READ_1_1_2 | SNOR_HWCAPS_READ_1_1_4 |	\
>> +	SNOR_HWCAPS_PP)
>> +
>> +static const struct cqspi_driver_platdata cdns_qspi = {
>> +	.hwcaps_mask = cqspi_base_hwcaps_mask,
>> +};
>> +
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
>> +		.data = (void *)&cdns_qspi,
> 
> You can drop the (void *) cast.
> 
> Looks good. Did you test the octal mode with mt35xu512aba? If yes, it would be
> nice to specify this in the commit message.
> 

Yes, octal mode was tested with mt35xu512aba flash. I will address all
the comments in v4. Thanks for the review!


-- 
Regards
Vignesh
