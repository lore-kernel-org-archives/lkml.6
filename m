Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C10C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AC8217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 10:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s+h3E0Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbeLRKKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 05:10:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60614 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbeLRKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 05:10:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBIA9NGN033629;
        Tue, 18 Dec 2018 04:09:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545127763;
        bh=3HqKMTzrhsnO+QFb08lasonXQUmMnOYXHt6JF7xQBoE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s+h3E0UaVsngNx1cu5oWVh9dThxqrh/2QUnIZRAipwU8k4Igomkm+N0L6AnPS9QzK
         yKxmwmin1x125rtcCjlPxkHaZZ0VM9AAXZPNlOQf2bmNz8H8tvt3fd44jiJ8CW0j0w
         gz1xADs4eDojk+n98i9MSEihN845C/Ob2EfzgNUE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBIA9NRB063017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Dec 2018 04:09:23 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 18
 Dec 2018 04:09:22 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 18 Dec 2018 04:09:22 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBIA9Kc4007714;
        Tue, 18 Dec 2018 04:09:21 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tony@atomide.com>, <linux-omap@vger.kernel.org>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <20181217191657.GB7288@darkstar.musicnaut.iki.fi>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <36444432-a34c-826f-6efa-109921da69b7@ti.com>
Date:   Tue, 18 Dec 2018 12:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181217191657.GB7288@darkstar.musicnaut.iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/12/2018 21.16, Aaro Koskinen wrote:
> On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
>> Also we can't deal with the omap_set_dma_dest_burst_mode() setting -
>> DMAengine always uses a 64 byte burst, but udc wants a smaller burst
>> setting.  Does this matter?
> 
> Looking at OMAP1 docs, it seems it supports only 16 bytes. Then checking
> DMAengine code, I don't think these CSDP bit values are not valid
> for OMAP1:
> 
>         CSDP_SRC_BURST_1        = 0 << 7,
>         CSDP_SRC_BURST_16       = 1 << 7,
>         CSDP_SRC_BURST_32       = 2 << 7,
>         CSDP_SRC_BURST_64       = 3 << 7,
> 
> From TI SPRU674 document, pages 50-51:
> 
> 	0	single access (no burst)
> 	1	single access (no burst)
> 	2	burst 4

In omap1510 it is 4 x data_type
In omap1610/1710 it is 4 x data_type (only data_type == 32bit is supported)
From omap2420+ 32 bytes (8x32bit/4x64bit)

So for OMAP1 we need to have different handling of the burst:
only enable if data_type is 32bit.

> 	3	reserved (do not use this setting)
> 
> So if CSDP_SRC_BURST_64 (3) gets programmed OMAP1, I wonder what is the
> end result, no burst or burst 4...
> 
> A.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
