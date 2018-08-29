Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20434C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3540205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="InK2OKBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3540205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbeH2UOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:14:21 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37448 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbeH2UOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:14:21 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7TGGHJo110838;
        Wed, 29 Aug 2018 11:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535559377;
        bh=qNXcdR+TIXjgW1E4AfAQwWo+5s8zWbh5kcD4/tu2lyI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=InK2OKBleXrgRf7Ajh9xUMLzFMacM3x6L5vmbDgjKMZXN+cgKHiIe+UIsZWs5eX5U
         p+ipHi8IIjoJHJDRe55ruwpEsBw8WUdwXzF1dKO2gZKN8y0/dqQtt37Vd/1ehJ96Zw
         ypkw7tITFBQ+rcEhDHuuGjZGzmtJVh0/7gFrS2+Q=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TGGHnA002269;
        Wed, 29 Aug 2018 11:16:17 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 29
 Aug 2018 11:16:17 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 29 Aug 2018 11:16:17 -0500
Received: from [172.22.5.0] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7TGGAig024247;
        Wed, 29 Aug 2018 11:16:11 -0500
Subject: Re: [PATCH] dmaengine: Add metadata_ops for dma_async_tx_descriptor
To:     Vinod <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
        <radheys@xilinx.com>
References: <20180823130728.20506-1-peter.ujfalusi@ti.com>
 <20180829155212.GG2388@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ae790f49-40f6-8b89-6ec5-c3f3aeb09067@ti.com>
Date:   Wed, 29 Aug 2018 19:14:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180829155212.GG2388@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vinod,

On 08/29/2018 06:52 PM, Vinod wrote:
> On 23-08-18, 16:07, Peter Ujfalusi wrote:
>> The metadata is best described as side band data or parameters traveling
>> alongside the data DMAd by the DMA engine. It is data
>> which is understood by the peripheral and the peripheral driver only, the
>> DMA engine see it only as data block and it is not interpreting it in any
>> way.
>>
>> The metadata can be different per descriptor as it is a parameter for the
>> data being transferred.
>>
>> If the DMA supports per descriptor metadata it can implement the attach,
>> get_ptr/set_len callbacks.
>>
>> Client drivers must only use either attach or get_ptr/set_len to avoid
>> miss configuration.
> 
> misconfiguration?

Sorry for the typos, I'll got through them again.

>> Client driver can check if a given metadata mode is supported by the
>> channel during probe time with
>> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
>> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);
>>
>> and based on this information can use either mode.
>>
>> Wrappers are also added for the metadata_ops.
>>
>> To be used in DESC_METADATA_CLIENT mode:
>> dmaengine_desc_attach_metadata()
>>
>> To be used in DESC_METADATA_ENGINE mode:
>> dmaengine_desc_get_metadata_ptr()
>> dmaengine_desc_set_metadata_len()
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> Changes since rfc:
>> - DESC_METADATA_EMBEDDED renamed to DESC_METADATA_ENGINE
>> - Use flow is added for both CLIENT and ENGINE metadata modes
>>
>> Regards,
>> Peter
>>
>>  include/linux/dmaengine.h | 144 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 144 insertions(+)
>>
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index 3db833a8c542..f809635cfeaa 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -231,6 +231,57 @@ typedef struct { DECLARE_BITMAP(bits, DMA_TX_TYPE_END); } dma_cap_mask_t;
>>   * @bytes_transferred: byte counter
>>   */
>>  
>> +/**
>> + * enum dma_desc_metadata_mode - per descriptor metadata mode types supported
>> + * @DESC_METADATA_CLIENT - the metadata buffer is allocated/provided by the
>> + *  client driver and it is attached (via the dmaengine_desc_attach_metadata()
>> + *  helper) to the descriptor.
>> + *
>> + * Client drivers interested to use this mode can follow:
>> + * - DMA_MEM_TO_DEV:
>> + *   1. prepare the descriptor (dmaengine_prep_*)
>> + *	construct the metadata in the clinet's buffer
> 
> typo clinet
> 
>> + *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>> + *	descriptor
>> + *   3. submit the transfer
>> + * - DMA_DEV_TO_MEM:
>> + *   1. prepare the descriptor (dmaengine_prep_*)
>> + *   2. use dmaengine_desc_attach_metadata() to attach the buffer to the
>> + *	descriptor
>> + *   3. submit the transfer
>> + *   4. when the transfer is completed, the metadata should be available in the
>> + *	attached buffer
> 
> I guess this is good to be moved into Documentation

Should I create a new file for metadata? I guess it would make sense as the
information is for both clients and engines.

> 
> also we dont allow this for memcpy txn?

I have not thought about that, but if I think about it it should be along the
same lines as MEM_TO_DEV.
I'll add the MEM_TO_MEM as well to the documentation.

>> + *
>> + * @DESC_METADATA_ENGINE - the metadata buffer is allocated/managed by the DMA
>> + *  driver. The client driver can ask for the pointer, maximum size and the
>> + *  currently used size of the metadata and can directly update or read it.
>> + *  dmaengine_desc_get_metadata_ptr() and dmaengine_desc_set_metadata_len() is
>> + *  provided as helper functions.
>> + *
>> + * Client drivers interested to use this mode can follow:
>> + * - DMA_MEM_TO_DEV:
>> + *   1. prepare the descriptor (dmaengine_prep_*)
>> + *   2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the engine's
>> + *	metadata area
>> + *   3. update the metadata at the pointer
>> + *   4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the amount
>> + *	of data the client has placed into the metadata buffer
>> + *   5. submit the transfer
>> + * - DMA_DEV_TO_MEM:
>> + *   1. prepare the descriptor (dmaengine_prep_*)
>> + *   2. submit the transfer
>> + *   3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
>> + *	pointer to the engine's metadata are
>> + *   4. Read out the metadate from the pointer
>> + *
>> + * Note: the two mode is not compatible and clients must use one mode for a
>> + * descriptor.
>> + */
>> +enum dma_desc_metadata_mode {
>> +	DESC_METADATA_CLIENT = (1 << 0),
>> +	DESC_METADATA_ENGINE = (1 << 1),
> 
> BIT(x)

OK, I followed what we have in the header to not mix (1 << x) and BIT(x)

> 
>> +};
>> +
>>  struct dma_chan_percpu {
>>  	/* stats */
>>  	unsigned long memcpy_count;
>> @@ -494,6 +545,18 @@ struct dmaengine_unmap_data {
>>  	dma_addr_t addr[0];
>>  };
>>  
>> +struct dma_async_tx_descriptor;
>> +
>> +struct dma_descriptor_metadata_ops {
>> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
>> +		      size_t len);
>> +
>> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
>> +			 size_t *payload_len, size_t *max_len);
>> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
>> +		       size_t payload_len);
>> +};
>> +
>>  /**
>>   * struct dma_async_tx_descriptor - async transaction descriptor
>>   * ---dma generic offload fields---
>> @@ -523,6 +586,8 @@ struct dma_async_tx_descriptor {
>>  	dma_async_tx_callback_result callback_result;
>>  	void *callback_param;
>>  	struct dmaengine_unmap_data *unmap;
>> +	enum dma_desc_metadata_mode desc_metadata_mode;
>> +	struct dma_descriptor_metadata_ops *metadata_ops;

I forgot to update the comment section for the dma_async_tx_descriptor, I'll
address it in v2.

>>  #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>  	struct dma_async_tx_descriptor *next;
>>  	struct dma_async_tx_descriptor *parent;
>> @@ -685,6 +750,7 @@ struct dma_filter {
>>   * @global_node: list_head for global dma_device_list
>>   * @filter: information for device/slave to filter function/param mapping
>>   * @cap_mask: one or more dma_capability flags
>> + * @desc_metadata_modes: supported metadata modes by the DMA device
>>   * @max_xor: maximum number of xor sources, 0 if no capability
>>   * @max_pq: maximum number of PQ sources and PQ-continue capability
>>   * @copy_align: alignment shift for memcpy operations
>> @@ -749,6 +815,7 @@ struct dma_device {
>>  	struct list_head global_node;
>>  	struct dma_filter filter;
>>  	dma_cap_mask_t  cap_mask;
>> +	enum dma_desc_metadata_mode desc_metadata_modes;
>>  	unsigned short max_xor;
>>  	unsigned short max_pq;
>>  	enum dmaengine_alignment copy_align;
>> @@ -935,6 +1002,83 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
>>  						    len, flags);
>>  }
>>  
>> +static inline bool dmaengine_is_metadata_mode_supported(struct dma_chan *chan,
>> +		enum dma_desc_metadata_mode mode)
>> +{
>> +	return !!(chan->device->desc_metadata_modes & mode);
>> +}
>> +
>> +static inline int _desc_check_and_set_metadata_mode(
> 
> why does this need to start with _ ?

To scare people to use in client code ;)

> 
>> +	struct dma_async_tx_descriptor *desc, enum dma_desc_metadata_mode mode)
>> +{
>> +	/* Make sure that the metadata mode is not mixed */
>> +	if (!desc->desc_metadata_mode) {
>> +		if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
>> +			desc->desc_metadata_mode = mode;
>> +		else
>> +			return -ENOTSUPP;
>> +	} else if (desc->desc_metadata_mode != mode) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static inline int dmaengine_desc_attach_metadata(
>> +		struct dma_async_tx_descriptor *desc, void *data, size_t len)
>> +{
>> +	int ret;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_CLIENT);
>> +	if (ret)
>> +		return ret;
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
>> +	int ret;
>> +
>> +	if (!desc)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_ENGINE);
>> +	if (ret)
>> +		return ERR_PTR(ret);
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
>> +	int ret;
>> +
>> +	if (!desc)
>> +		return -EINVAL;
>> +
>> +	ret = _desc_check_and_set_metadata_mode(desc, DESC_METADATA_ENGINE);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!desc->metadata_ops || !desc->metadata_ops->set_len)
>> +		return -ENOTSUPP;
>> +
>> +	return desc->metadata_ops->set_len(desc, payload_len);
>> +}
> 
> thats bit too much code for a header file :( Lets move it to C file
> please. We can utilize local dmaengine.h and not expose all these and
> possible misuse by clients

OK, I have thought about that as well.

> Also I would like to see a use :-) before further comments.

You mean the DMA driver and at least one client?
I have the DMA driver in my public facing branch [1], but it is not an easy
read with it's close to 4k loc.
The client is not in my branch and it is actually using an older version of
the metadata support.

The problem is that I don't know when I will be able to send the driver for
review as all of this is targeting a brand new SoC (AM654) with completely new
data movement architecture. There are lots of dependencies still need to be
upstreamed before I can send something which at least compiles.

I can offer snippets from the client driver, if that is good enough or a link
to the public tree where it can be accessed, but it is not going to go
upstream before the DMA driver.

[1]
https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti/

https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti

k3-udma.c/h is the DMAengine driver, k3-navss-pricate.c k3-navss-udma.c is
something I try to get rid of (it is wrapper for the networking drivers to use
DMA)

-- 
Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
