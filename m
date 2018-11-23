Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119ACC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8D20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 11:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qQ3vV4k3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC8D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503901AbeKWWhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:37:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48294 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387885AbeKWWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:37:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wANBqj3S009796;
        Fri, 23 Nov 2018 05:52:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542973966;
        bh=+flqnLWy7nfXl+oPBQxmkH1Jke7kdl18SuY/BfUKJ+4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qQ3vV4k3hYdVchCSbjbS/EDV0WavGdxOcd1InmWKZfFjLhJx+hlOkBXaDz0zheu93
         M04leSvXNg5B1+GWVB7xUF+extvuGNYiC0YsY3nTpGCjQSdg3tWgkFLiCIzmBeTEdW
         i3nSVUedg6C66Wd99LiV5ItF+3OHUI14J+9bjRKM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wANBqjog032633
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Nov 2018 05:52:45 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 23
 Nov 2018 05:52:44 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 23 Nov 2018 05:52:44 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wANBqgI5011299;
        Fri, 23 Nov 2018 05:52:42 -0600
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
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
 <20181123002549.GO6920@n2100.armlinux.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <cca7279a-2f93-ee43-0f1a-8f04d2e7b694@ti.com>
Date:   Fri, 23 Nov 2018 13:54:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181123002549.GO6920@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2018 2.25, Russell King - ARM Linux wrote:
> On Fri, Nov 23, 2018 at 12:24:26AM +0200, Aaro Koskinen wrote:
>> Hi,
>>
>> On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
>>> On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
>>>> On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
>>>>> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
>>>>> API were too annoying and flooding the console. And now that I tried
>>>>> using DMA again with g_ether, it doesn't work anymore. The device get's
>>>>> recognized on host side, but no traffic goes through. Switching back to
>>>>> PIO makes it to work again.
>>>>
>>>> A solution to that would be to do what the warning message says, and
>>>> update the driver to the DMAengine API.
>>
>> Fully agreed, but I was busy debugging other more serious issues, and
>> just wanted to get a reliable ssh or USB serial access to the device
>> without any extra noise, so switching to PIO using a module parameter
>> is probably what most users do in such situations.
>>
>>> Here's a partial conversion (not even build tested) - it only supports
>>> OUT transfers with dmaengine at the moment.
>>
>> Thanks, I'll take a closer look and try to do some testing hopefully
>> during the weekend.
> 
> The patch was more for Peter to take a peek at - there's definitely
> some bits missing in the dmaengine driver (like the write to the
> LCH_CTRL register) that would need to be fixed somehow.
> 
> However, it's worth noting that there is exactly one user of
> omap_set_dma_channel_mode(), which is omap-udc, which means any DMA
> channel made use of by omap-udc will have the LCH_CTRL register
> modified to LCH_P, and it will remain that way even if someone else
> subsequently makes use of the same channel.  That's rather suspicious
> to me... maybe we can just initialise all LCH_CTRL registers to LCH_P
> in the dmaengine driver in that case!  If not, then there's a bug
> right there.

Hrm, right. memcpy will break if we take a channel which was used by
omap_udc at some point as LCH_P is not capable of dealing with it.

With this patch it should be fine as we configure the LCH_CTRL to P or
2D depending on the transfer type (slave vs non-slave).
But, we might just set the lch to 2D regardless as it works for slave
and memcpy channels fine.

> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
