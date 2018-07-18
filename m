Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457E20852
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n1M98AAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D457E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeGRKnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:43:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44512 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeGRKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:43:08 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6IA5JMk055355;
        Wed, 18 Jul 2018 05:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531908319;
        bh=BZ6nJbZcFrLu0yaoJov2VSCSb8ZXWnzLEiewxzABPxU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=n1M98AANkpvzRA5myEw9WJnxgY93tveGd9sBPUlOUNJwj2yf3CmyELY3X/0nS1fRZ
         SL8BKDDBHdb4XW8bKnnzqzrRaQIA9BE54lE5uickuY0gMHi3DCTiVbGQFDUzNWF8jK
         qHzge5w5lQnQ3+N01sro/aTzEyWIFL/2x+VZTaek=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6IA5JBp024876;
        Wed, 18 Jul 2018 05:05:19 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 18
 Jul 2018 05:05:18 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 18 Jul 2018 05:05:18 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6IA5Gk8029927;
        Wed, 18 Jul 2018 05:05:16 -0500
Subject: Re: [RFC] dmaengine: Add metadat_ops for dma_async_tx_descriptor
To:     Vinod <vkoul@kernel.org>
CC:     <radheys@xilinx.com>, <vinod.koul@intel.com>, <lars@metafoo.de>,
        <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>,
        <appanad@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
References: <32208a9c-2b15-d345-1432-f1e387531f9b@ti.com>
 <20180601102429.16429-1-peter.ujfalusi@ti.com>
 <20180710055230.GB3219@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <052ebdd9-7e68-5b78-52c3-304376f48777@ti.com>
Date:   Wed, 18 Jul 2018 13:06:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180710055230.GB3219@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 2018-07-10 08:52, Vinod wrote:
> 
> Hey Peter,
> 
> Sorry for late response on this..

No problem, I was away myself also...

> On 01-06-18, 13:24, Peter Ujfalusi wrote:
>> If the DMA supports per descriptor metadata it can implement the attach,
>> get_ptr/set_len callbacks.
>>
>> Client drivers must only use either attach or get_ptr/set_len to avoid
>> miss configuration.
>>
>> Wrappers are also added for the metadata_ops:
>> dmaengine_desc_attach_metadata()
>> dmaengine_desc_get_metadata_ptr()
>> dmaengine_desc_set_metadata_len()
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> since attachments are bouncing back, I send the patch separately
>>
>> Regards,
>> Peter
>>
>>  include/linux/dmaengine.h | 50 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 51fbb861e84b..ac42ace36aa3 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -491,6 +491,18 @@ struct dmaengine_unmap_data {
>>  	dma_addr_t addr[0];
>>  };
>>  
>> +struct dma_async_tx_descriptor;
>> +
>> +struct dma_descriptor_metadata_ops {
>> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
>> +		      size_t len);
> 
> How does one detach?

I have not thought about detach, but clients can just attach NULL I guess.

> When should the client free up the memory, IOW when
> does dma driver drop ref to data.

The metadata is for the descriptor so the DMA driver might want to
access to it while the descriptor is valid.

Typically clients can free up their metadata storage after the dma
completion callback. On DEV_TO_MEM the metadata is going to be placed in
the provided buffer when the transfer is completed.

> 
>> +
>> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
>> +			 size_t *payload_len, size_t *max_len);
> 
> so what is this supposed to do..?

My issue with the attach in general is that it will need additional
memcpy to move the metadata from/to the client buffer to it's place.

With get_ptr the client can get the pointer to the actual place where
the metadata resides and modify/read it in place w/o memcpy.

I know, I know... We need to trust the clients, but with high throughput
peripherals the memcpy is taxing.

> 
>> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
>> +		       size_t payload_len);
> 
> attach already has length, so how does this help?

So, DMA drivers can implement either or both:
1. attach()
2. get_ptr() / set_len()

Clients must not mix the two way of handling the metadata.
The set_len() is intended to tell the DMA driver the client provided
metadata size (in MEM_TO_DEV case mostly).

MEM_TO_DEV flow on client side:
get_ptr()
fill in the metadata to the pointer (not exceeding max_len)
set_len() to tell the DMA driver the amount of valid bytes written

DEV_TO_MEM flow on client side:
In the completion callback, get_ptr()
the metadata is payload_len bytes and can be accessed in the return pointer.


BTW: The driver which is going to need this is now accessible in public:
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti

or in my wip tree:
https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti

prefixed with k3-*

> 
>> +};
>> +
>>  /**
>>   * struct dma_async_tx_descriptor - async transaction descriptor
>>   * ---dma generic offload fields---
>> @@ -520,6 +532,7 @@ struct dma_async_tx_descriptor {
>>  	dma_async_tx_callback_result callback_result;
>>  	void *callback_param;
>>  	struct dmaengine_unmap_data *unmap;
>> +	struct dma_descriptor_metadata_ops *metadata_ops;
>>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>  	struct dma_async_tx_descriptor *next;
>>  	struct dma_async_tx_descriptor *parent;
>> @@ -932,6 +945,43 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>>  						    len, flags);
>>  }
>>  
>> +static inline int dmaengine_desc_attach_metadata(
>> +		struct dma_async_tx_descriptor *desc, void *data, size_t len)
>> +{
>> +	if (!desc)
>> +		return 0;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->attach)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->attach(desc, data, len);
>> +}
>> +
>> +static inline void *dmaengine_desc_get_metadata_ptr(
>> +		struct dma_async_tx_descriptor *desc, size_t *payload_len,
>> +		size_t *max_len)
>> +{
>> +	if (!desc)
>> +		return NULL;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->get_ptr)
>> +		return ERR_PTR(-ENOTSUPP);
>> +
>> +	return desc->metadata_ops->get_ptr(desc, payload_len, max_len);
>> +}
>> +
>> +static inline int dmaengine_desc_set_metadata_len(
>> +		struct dma_async_tx_descriptor *desc, size_t payload_len)
>> +{
>> +	if (!desc)
>> +		return 0;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->set_len(desc, payload_len);
>> +}
>> +
>>  /**
>>   * dmaengine_terminate_all() - Terminate all active DMA transfers
>>   * @chan: The channel for which to terminate the transfers
>> -- 
>> Peter
>>
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
