Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAD4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3EE20864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olgZ1gH6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3EE20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393073AbeKVTJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:09:24 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40798 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeKVTJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:09:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAM8U7ww089247;
        Thu, 22 Nov 2018 02:30:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542875407;
        bh=jo8CZI7dGLRY3QRAxcrwmEkyTYBRbkmwbcy5JwbBnmA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=olgZ1gH6MnifTqhl/FpdX4dh2j1PlQUpQpsd7+F/t2bgy6o9531up0pWtIa/ILPq1
         aYDtgPOXFKfG0HhyRPXHO3nFp3YfCGLbI3OK0xEyA7CrvNsndiAn3R1KWMJ2TCISpM
         aRWKuhRtaTWxLolAUmcM+7otTzPO6NpEfVytVjx4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAM8U7WZ093369
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Nov 2018 02:30:07 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 22
 Nov 2018 02:30:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 22 Nov 2018 02:30:04 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAM8U2ex009701;
        Thu, 22 Nov 2018 02:30:02 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tony@atomide.com>, <linux-omap@vger.kernel.org>,
        <rmk+kernel@armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
Date:   Thu, 22 Nov 2018 10:31:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/11/2018 23.04, Aaro Koskinen wrote:
> Hi,
> 
> On Tue, Nov 20, 2018 at 09:28:37AM +0200, Peter Ujfalusi wrote:
>> On 19/11/2018 20.46, Aaro Koskinen wrote:
>>> On Mon, Nov 19, 2018 at 12:40:40PM +0200, Peter Ujfalusi wrote:
>>>> When the channel is configured for slave operation the LCH_TYPE needs to be
>>>> set to LCh-P. For memcpy channels the LCH_TYPE must be set to LCh-2D.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>
>>> I don't have the documentation, but based on what omap_udc driver (still
>>> using the legacy OMAP DMA API) does this seems to be correct.
>>
>> They are hard to fine, true. From the omap1710 TRM:
>>
>> Logical channel types (LCh types) supported are:
>> - LCh-2D for nonsynchronized transfers (memory transfers, 1D and 2D)
>> - LCh-P for synchronized transfers (mostly peripheral transfers)
>> - LCh-PD similar to LCh-P but runs on a dedicated physical channel
>> - LCh-G for graphical transfers/operations
>> - LCh-D for display transfers
> 
> (I found a public document "OMAP5912 Multimedia Processor Direct
> Memory Access (DMA) Support Reference Guide", documenting these; easy
> to confuse with "OMAP5910 Dual-Core Processor System DMA Controller
> Reference Guide".)
> 
>> Looking at other part it looks like hat LCH-2D channel mode can happily
>> service a peripheral. LCH-P supports the same features as LCH-2D, but it
>> lacks support for Single/Double-indexed addressing mode on the
>> peripheral port side.
>>
>> So, this patch might not be needed at all. Can you test the omap_udc
>> with s/OMAP_DMA_LCH_P/OMAP_DMA_LCH_2D
>>
>> If USB works, then we can just drop this patch.
> 
> Unfortunately omap_udc does not seem to work at all anymore with DMA on
> my 770 setup. :-(
> 
> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> API were too annoying and flooding the console. And now that I tried
> using DMA again with g_ether, it doesn't work anymore. The device get's
> recognized on host side, but no traffic goes through. Switching back to
> PIO makes it to work again.

After some tinkering I got omap_udc working with DMA (not DMAengine,
yet) on 770 - using nfsroot. Configuring the channels to OMAP_DMA_LCH_2D
works as expected.

This patch can be dropped.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
