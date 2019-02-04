Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79CAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A095E2081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 13:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h0S4eQOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfBDNhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 08:37:10 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35530 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBDNhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 08:37:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14DagvC018742;
        Mon, 4 Feb 2019 07:36:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549287402;
        bh=0dZV2LPBpf9V2dXA9x6CDk+8Z/0Zdr73i3entX2Me+I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=h0S4eQOUY1ukwvUHyxcmeQnfLlIKOUQvyw+saykk1V6vgNMpGSSLSi4RzkjZZTyst
         OACiktF7VGEmLhZVb99bfhYMCOEWCersCYJA73omV5ghfpArh0NUST+Kv0EP/QINgi
         /utidKWye3Lt+1yXOBXJ57vhKVPGZyLnZRFxFRE4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14Dagcp127560
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 07:36:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 07:36:41 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 07:36:41 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14DacNf020419;
        Mon, 4 Feb 2019 07:36:39 -0600
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in
 STIG mode
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "purna.chandra.mandal@intel.com" <purna.chandra.mandal@intel.com>,
        "f.blogs@napier.co.nz" <f.blogs@napier.co.nz>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
 <82eafaf8-803e-36a9-49ca-83d84c55537a@microchip.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <7655324a-9cd2-7ffe-56bb-83c44740265c@ti.com>
Date:   Mon, 4 Feb 2019 19:07:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <82eafaf8-803e-36a9-49ca-83d84c55537a@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/02/19 5:50 PM, Tudor.Ambarus@microchip.com wrote:
> + Vignesh
> 

Thanks for looping in.

> On 01/28/2019 07:02 AM, Purna Chandra Mandal wrote:
>> cadence-quadspi controller allows upto eight bytes of data to
>> be written in software Triggered Instruction generator (STIG) mode
>> of operation. Lower 4 bytes are written through writedatalower and
>> upper 4 bytes by writedataupper register.
>>
>> This patch allows all the 8 bytes to be written.
>>

Code as such looks fine. But, how was this tested? How can I trigger
this new code path with current linux-next? AFAICS, STIG mode write is
used to in nor->write_reg() path, and I dont see any nor->write_reg()
call with >4bytes len.

>> Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
> 
> Looks good for me:
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Vignesh, can we have your R-b or T-b tag?
> 
> Cheers,
> ta
> 
>> ---
>>
>>  drivers/mtd/spi-nor/cadence-quadspi.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 04cedd3a2bf6..7f78f9409ddd 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -418,9 +418,10 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>  	void __iomem *reg_base = cqspi->iobase;
>>  	unsigned int reg;
>>  	unsigned int data;
>> +	u32 write_len;
>>  	int ret;
>>  
>> -	if (n_tx > 4 || (n_tx && !txbuf)) {
>> +	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
>>  		dev_err(nor->dev,
>>  			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
>>  			n_tx, txbuf);
>> @@ -433,10 +434,18 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>  		reg |= ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
>>  			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
>>  		data = 0;
>> -		memcpy(&data, txbuf, n_tx);
>> +		write_len = (n_tx > 4) ? 4 : n_tx;
>> +		memcpy(&data, txbuf, write_len);
>> +		txbuf += write_len;
>>  		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
>> -	}
>>  
>> +		if (n_tx > 4) {
>> +			data = 0;
>> +			write_len = n_tx - 4;
>> +			memcpy(&data, txbuf, write_len);
>> +			writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
>> +		}
>> +	}
>>  	ret = cqspi_exec_flash_cmd(cqspi, reg);
>>  	return ret;
>>  }
>>

-- 
Regards
Vignesh
