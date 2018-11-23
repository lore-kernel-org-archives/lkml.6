Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC04C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0C520685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nifp6Emc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0C520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405430AbeKWWck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:32:40 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54972 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387945AbeKWWck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:32:40 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANBlwFH024508;
        Fri, 23 Nov 2018 05:47:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542973678;
        bh=77axZYukm1rwXy9LqCTnhYduGHEZ/BUpu6p1xVF9b5Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nifp6EmcVckRU7kvNR6M65cLs5x0WQAJEReonrLimF6GZ4ADlkIOAeSVVhZml71Ea
         3MpELydltqsU0teRrgssKDyYDQ4/SMNsyLyPQJMU8Jd+brN61YM/fmI1sHDdKKI4/r
         Sbdw76ETF/QvYo4/GfbGZNDyc65kQyO6IrAms1po=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANBlwa1068282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 05:47:58 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 05:47:58 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 05:47:58 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANBltg4030483;
        Fri, 23 Nov 2018 05:47:56 -0600
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tony@atomide.com>, <linux-omap@vger.kernel.org>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6dbb56e9-f76b-5343-1c40-87f326fe06a7@ti.com>
Date:   Fri, 23 Nov 2018 13:49:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181122102948.GN6920@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/11/2018 12.29, Russell King - ARM Linux wrote:
> On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
>> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
>> API were too annoying and flooding the console. And now that I tried
>> using DMA again with g_ether, it doesn't work anymore. The device get's
>> recognized on host side, but no traffic goes through. Switching back to
>> PIO makes it to work again.
> 
> A solution to that would be to do what the warning message says, and
> update the driver to the DMAengine API.

Yep, omap_udc is the last user of legacy omap_dma API. It is a slow
progress as I do the conversion in my free time, onenand/omap2 and tusb
was converted not too long ago, let's see how the omap_udc is going to go.

> The reason it didn't get updated when the DMAengine conversion happened
> is because I don't have hardware for it, so had no way to test, and no
> one seemed to know that anyone was using it.  Eventually, the WARN_ON()
> was added to try and root out any users and generate interest in
> updating the drivers.  Obviously that didn't happen, because people
> just worked around the warning rather than saying anything.
> 
> I'm afraid we're long past the time that I'd be willing to update the
> omap_udc driver now as I've dropped most of my knowledge on that as
> it's been four years, and Peter has been looking after OMAP DMAengine
> issues since.
> 
> Sorry.
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
