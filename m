Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F392CFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAD320870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XYa/UVtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAD320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeG3LU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:20:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeG3LU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:20:59 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6U9k9gi007029;
        Mon, 30 Jul 2018 04:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532943969;
        bh=JY4e147qrLIjHXfj4/M2yrotXQxTEl90wjomtXqnbQI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XYa/UVtK+kksIpZ75Thz1mK4pJw9l+GgrfWfKaBTb4piHSLtEkd54wtY03ltZ1Ann
         d0BYTge0Dlzk9TyEf4LfeBFGxlVoM2tHLQOaFYdISXBuuFfXYNW7K5G0EoOcW35hBf
         ktEczb7kwa94xQ6NbjJQWhvHmC+UYZMZSaeGrcKc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6U9k8tD025805;
        Mon, 30 Jul 2018 04:46:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 30
 Jul 2018 04:46:08 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 30 Jul 2018 04:46:08 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6U9k5H1026209;
        Mon, 30 Jul 2018 04:46:06 -0500
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
To:     Vinod <vkoul@kernel.org>
CC:     <radheys@xilinx.com>, <vinod.koul@intel.com>, <lars@metafoo.de>,
        <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <appanad@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
 <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
 <20180719092224.GK3219@vkoul-mobl>
 <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
 <20180724111425.GK3219@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <e5112c28-a010-827b-c1fd-ecf00036412a@ti.com>
Date:   Mon, 30 Jul 2018 12:46:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180724111425.GK3219@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod,

On 2018-07-24 14:14, Vinod wrote:
>>>> Clients must not mix the two way of handling the metadata.
>>>> The set_len() is intended to tell the DMA driver the client provided
>>>> metadata size (in MEM_TO_DEV case mostly).
>>>>
>>>> MEM_TO_DEV flow on client side:
>>>> get_ptr()
>>>> fill in the metadata to the pointer (not exceeding max_len)
>>>> set_len() to tell the DMA driver the amount of valid bytes written
>>>>
>>>> DEV_TO_MEM flow on client side:
>>>> In the completion callback, get_ptr()
>>>> the metadata is payload_len bytes and can be accessed in the return pointer.
>>>
>>> I would think to unify this..
>>
>> I have tried it, but the attach mode and the pointer mode is hard to
>> handle with a generic API.
>> I will try to find a way to unify things in a sane way.
> 
> Hmmm, looking from the description they will be for different methods,
> so lets make them orthogonal and not allow driver to register both.

I would allow DMA drivers to register both, but somehow enforce that
clients are not mixing the two distinct way of dealing with the metadata.

The reason for that is for example the attach mode is the simplest (I
implemented it first and I have a client using it), but if the pointer
mode is found to be more efficient and feasible for the DMA then the DMA
driver can implement that mode and the client can move as well w/o
breaking anything.

> 
>>
>> I have moved the metadata_ops to dma_async_tx_descriptor to emphasize
>> that it is per descriptor setting:
>> https://github.com/omap-audio/linux-audio/commit/02e095d1320a4bb3ae281ddb208ce82ead746f00#diff-92c0a79f414dc3be9dfc67a969c0dd71
>>
>>
>>>> BTW: The driver which is going to need this is now accessible in public:
>>>> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
>>>>
>>>> or in my wip tree:
>>>> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
>>>>
>>>> prefixed with k3-*
>>>>
>>
>> - Péter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
