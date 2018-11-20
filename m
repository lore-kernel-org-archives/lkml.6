Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA61C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E59920831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E59920831
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbeKTRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:55:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42150 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeKTRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:55:42 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK7RCGu048633;
        Tue, 20 Nov 2018 01:27:12 -0600
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK7RCSE002249
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Nov 2018 01:27:12 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 20
 Nov 2018 01:27:11 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 20 Nov 2018 01:27:11 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK7R8Nw004192;
        Tue, 20 Nov 2018 01:27:09 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <rmk+kernel@armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
Date:   Tue, 20 Nov 2018 09:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aaro,

On 19/11/2018 20.46, Aaro Koskinen wrote:
> Hi,
> 
> On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
>> When the channel is configured for slave operation the LCH_TYPE needs to be
>> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> I don't have the documentation, but based on what omap_udc driver (still
> using the legacy OMAP DMA API) does this seems to be correct.

They are hard to fine, true. From the omap1710 TRM:

Logical channel types (LCh types) supported are:
- LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
- LCh-P for synchronized transfers (mostly peripheral transfers)
- LCh-PD similar to LCh-P but runs on a dedicated physical channel
- LCh-G for graphical transfers/operations
- LCh-D for display transfers

Looking at other part it looks like hat LCH-2D channel mode can happily
service a peripheral. LCH-P supports the same features as LCH-2D, but it
lacks support for Single/Double-indexed addressing mode on the
peripheral port side.

So, this patch might not be needed at all. Can you test the omap_udc
with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D

If USB works, then we can just drop this patch.

Note: if we ever need the port_window support in OMAP1 then we need
double indexing on the peripheral side.

> I tested the patch on Nokia 770 with MMC and couldn't see any negative
> impact.
> 
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> A.
> 
>> ---
>>  drivers/dma/ti/omap-dma.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
>> index a4a931ddf6f6..a18cfd497f04 100644
>> --- a/drivers/dma/ti/omap-dma.c
>> +++ b/drivers/dma/ti/omap-dma.c
>> @@ -185,6 +185,10 @@ enum {
>>  
>>  	CLNK_CTRL_ENABLE_LNK	= BIT(15),
>>  
>> +	/* OMAP1 only */
>> +	LCH_CTRL_LCH_2D		= 0,
>> +	LCH_CTRL_LCH_P		= 2,
>> +
>>  	CDP_DST_VALID_INC	= 0 << 0,
>>  	CDP_DST_VALID_RELOAD	= 1 << 0,
>>  	CDP_DST_VALID_REUSE	= 2 << 0,
>> @@ -529,6 +533,7 @@ static void omap_dma_start_sg(struct omap_chan *c, struct omap_desc *d)
>>  
>>  static void omap_dma_start_desc(struct omap_chan *c)
>>  {
>> +	struct omap_dmadev *od = to_omap_dma_dev(c->vc.chan.device);
>>  	struct virt_dma_desc *vd = vchan_next_desc(&c->vc);
>>  	struct omap_desc *d;
>>  	unsigned cxsa, cxei, cxfi;
>> @@ -570,6 +575,12 @@ static void omap_dma_start_desc(struct omap_chan *c)
>>  	omap_dma_chan_write(c, CSDP, d->csdp);
>>  	omap_dma_chan_write(c, CLNK_CTRL, d->clnk_ctrl);
>>  
>> +	if (dma_omap1() && !__dma_omap15xx(od->plat->dma_attr)) {
>> +		if (is_slave_direction(d->dir))
>> +			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_P);
>> +		else
>> +			omap_dma_chan_write(c, LCH_CTRL, LCH_CTRL_LCH_2D);
>> +	}
>>  	omap_dma_start_sg(c, d);
>>  }
>>  
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
