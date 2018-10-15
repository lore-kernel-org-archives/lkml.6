Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F72C65BD5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E102083C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bh96BVMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E102083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJORtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:49:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36140 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeJORtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:49:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9FA4euT088351;
        Mon, 15 Oct 2018 05:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539597880;
        bh=MnqsfFIHHCnRbK2Ax7mGfMzRJ/5at9WNpsOQbrgc6Jk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Bh96BVMzg6pSr6a2VPiWJPEot7P1O2/FwxZ3DJLCgyzaKEkmeRWve5hhcP6QVfgc8
         9p/Ocyk6WYhjf1ueYMu67Wl5z+v8T1LLdWLWlfaDNl9Akump9RkhVpox14NLeqlq1X
         joOrjua4SXAguz90BBiIVpwO9hLSspkxoB/r4IAM=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FA4euS029939;
        Mon, 15 Oct 2018 05:04:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 05:04:39 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 05:04:39 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9FA4bSl002262;
        Mon, 15 Oct 2018 05:04:38 -0500
Subject: Re: [PATCH 3/3] spi: omap2-mcspi: Add slave mode support
To:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20181015063829.26978-1-vigneshr@ti.com>
 <20181015063829.26978-4-vigneshr@ti.com>
 <2bef1218-ef43-cdc1-303f-b85863887a6b@ti.com>
 <28333ef8-22ca-e95f-b9d5-c0aeece20603@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <87459424-1083-0716-0481-89d7b7e3f08c@ti.com>
Date:   Mon, 15 Oct 2018 15:34:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <28333ef8-22ca-e95f-b9d5-c0aeece20603@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 October 2018 03:12 PM, Vignesh R wrote:
> Hi Sekhar,
> 
> On Monday 15 October 2018 01:53 PM, Sekhar Nori wrote:
> 
> [...]
>>>  
>>> +static irqreturn_t omap2_mcspi_irq_handler(int irq, void *data)
>>> +{
>>> +	struct omap2_mcspi *mcspi = data;
>>> +	u32 irqstat;
>>> +
>>> +	irqstat	= mcspi_read_reg(mcspi->master, OMAP2_MCSPI_IRQSTATUS);
>>> +	if (!irqstat)
>>> +		return IRQ_NONE;
>>> +
>>> +	/* Disable IRQ and wakeup slave xfer task */
>>> +	mcspi_write_reg(mcspi->master, OMAP2_MCSPI_IRQENABLE, 0);
>>> +	if (irqstat & OMAP2_MCSPI_IRQSTATUS_EOW)
>>> +		complete(&mcspi->txdone);
>>> +
>>> +	return IRQ_HANDLED;
>>
>> You need to have the:
>>
>> pm_runtime_get_sync();
>>
>> /* access registers */
>>
>> pm_runtime_mark_last_busy();
>> pm_runtime_put_autosuspend();
>>
>> sequence here. I think thats also missing from the dma callbacks.
>> Probably working by chance today.
>>
> 
> This is taken care of by the SPI core as part of __spi_pump_messages():
> pm_runtime_get_sync()
> ...
> spi_transfer_one_message
> ...
> 	omap2_mcspi_transfer_one
> 	...
> 		omap2_mcspi_txrx_dma
> 
> So, both in dma callbacks and in IRQ handler, SPI controller is in
> active state.

Ah, okay then. False alarm :)

Regards,
Sekhar
