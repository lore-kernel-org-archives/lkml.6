Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE00BC7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D572087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gNrwerub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D572087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeJOR0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:26:18 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43402 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:26:17 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9F9fllC045994;
        Mon, 15 Oct 2018 04:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539596507;
        bh=C/leBICEtBfrLFpr06jleJn2Xueb5XRDqbKpHIwApZc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gNrwerubodtPt8AtPBQzOK8b45hpebNwHBNBD78pxnvuLGIOzuYGOxPAxKb7O1aNG
         UL1HauvKQZ7rYXdQqG4ESo4wMQbe5fLtH8DjIhOzpC+hiI/h0WU5yTz8vaa8t6cxFs
         jzc5qn3FQwsYhLWgY6VEFtLTndgzb/66NckfG2Ws=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F9fk9D029924;
        Mon, 15 Oct 2018 04:41:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 04:41:47 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 04:41:47 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F9fiHx012154;
        Mon, 15 Oct 2018 04:41:45 -0500
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
To:     Sekhar Nori <nsekhar@ti.com>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
 <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <28333ef8-22ca-e95f-b9d5-c0aeece20603@ti.com>
Date:   Mon, 15 Oct 2018 15:12:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sekhar,

On Monday 15 October 2018 01:53 PM, Sekhar Nori wrote:

[...]
>>  
>> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
>> +{
>> +	struct omap2_mcspi *mcspi = data;
>> +	u32 irqstat;
>> +
>> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
>> +	if (!irqstat)
>> +		return IRQ_NONE;
>> +
>> +	/* Disable IRQ and wakeup slave xfer task */
>> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
>> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
>> +		complete(&mcspi->txdone);
>> +
>> +	return IRQ_HANDLED;
> 
> You need to have the:
> 
> pm_runtime_get_sync();
> 
> /* access registers */
> 
> pm_runtime_mark_last_busy();
> pm_runtime_put_autosuspend();
> 
> sequence here. I think thats also missing from the dma callbacks.
> Probably working by chance today.
> 

This is taken care of by the SPI core as part of __spi_pump_messages():
pm_runtime_get_sync()
...
spi_transfer_one_message
...
	omap2_mcspi_transfer_one
	...
		omap2_mcspi_txrx_dma

So, both in dma callbacks and in IRQ handler, SPI controller is in
active state.


-- 
Regards
Vignesh
