Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A4FECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17950204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ga10Hf5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17950204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbeGTObW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:31:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36736 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeGTObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:31:21 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6KDgLYa097955;
        Fri, 20 Jul 2018 08:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532094141;
        bh=K9YHEwcvdY39Ml7kx8xNf/+k0L44tHGMpPAdxzxcHZA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Ga10Hf5C7y8So3af6jBAP6ax6hHJhibf384TZOm+T1DkWiEVzLoeQOXcIcfLiD7IE
         NOwn14SwrGFt9gAWhMVUFGgwRkKBjgLuqn+qGMdxcly6/x/Z/0sk8prMMtDdId9NK2
         7J0BI32wfvsRASyc0i2hqX8vq4cnrPiowhrO/NMM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6KDgLKP014518;
        Fri, 20 Jul 2018 08:42:21 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 20
 Jul 2018 08:42:21 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 20 Jul 2018 08:42:21 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6KDgIeP024075;
        Fri, 20 Jul 2018 08:42:19 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <eb5acd10-e255-774b-e8bc-f88eb2af172a@ti.com>
Date:   Fri, 20 Jul 2018 16:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180719092224.GK3219@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-19 12:22, Vinod wrote:
> Hi Peter,
> 
> On 18-07-18, 13:06, Peter Ujfalusi wrote:
> 
>>>> +struct dma_async_tx_descriptor;
>>>> +
>>>> +struct dma_descriptor_metadata_ops {
>>>> +	int (*attach)(struct dma_async_tx_descriptor *desc, void *data,
>>>> +		      size_t len);
>>>
>>> How does one detach?
>>
>> I have not thought about detach, but clients can just attach NULL I guess.
> 
> So what are the implication of attach and detach here, should the data
> be deref by dmaengine driver and drop the ref.

It largely depends on the DMA driver, but I think we must have clear
definition on how clients (and thus DMA drivers) must handle the metadata.

I think the simpler rule would be that clients _must_ attach the
metadata buffer after _prepare() and before issue_pending() and they
must make sure that the buffer is valid (not freed up) before the
completion callback is called for the given descriptor.

About the detach: If clients detaches the metadata buffer then on
completion it is not going to receive back any metadata and I think the
DMA drivers should clean and disable the metadata sending as well if the
detach happens before issue_pending().

> Should anyone do refcounting?

Need to think about that.

>>
>>> When should the client free up the memory, IOW when
>>> does dma driver drop ref to data.
>>
>> The metadata is for the descriptor so the DMA driver might want to
>> access to it while the descriptor is valid.
>>
>> Typically clients can free up their metadata storage after the dma
>> completion callback. On DEV_TO_MEM the metadata is going to be placed in
>> the provided buffer when the transfer is completed.
> 
> That sounds okay to me
> 
>>>> +	void *(*get_ptr)(struct dma_async_tx_descriptor *desc,
>>>> +			 size_t *payload_len, size_t *max_len);
>>>
>>> so what is this supposed to do..?
>>
>> My issue with the attach in general is that it will need additional
>> memcpy to move the metadata from/to the client buffer to it's place.
>>
>> With get_ptr the client can get the pointer to the actual place where
>> the metadata resides and modify/read it in place w/o memcpy.
>>
>> I know, I know... We need to trust the clients, but with high throughput
>> peripherals the memcpy is taxing.
> 
> Okay I am not sure I have understood fully, so with attach you set
> a pointer (containing metdata?) so why do you need additional one..
> 
>>
>>>
>>>> +	int (*set_len)(struct dma_async_tx_descriptor *desc,
>>>> +		       size_t payload_len);
>>>
>>> attach already has length, so how does this help?
>>
>> So, DMA drivers can implement either or both:
>> 1. attach()
>> 2. get_ptr() / set_len()
> 
> Ah okay, what are the reasons for providing two methods and not a single
> one

For the HW I have it would be more efficient to grab pointer and do
in-place modification to metadata section (the part of the CPPI5
descriptor which is owned by the client driver).

Other vendors might have the metadata scattered, or in different way
which does not fit with the ptr mode for security or sanity point of
view - I don't want to give the whole descriptor to the client. I don't
trust ;)

>>
>> Clients must not mix the two way of handling the metadata.
>> The set_len() is intended to tell the DMA driver the client provided
>> metadata size (in MEM_TO_DEV case mostly).
>>
>> MEM_TO_DEV flow on client side:
>> get_ptr()
>> fill in the metadata to the pointer (not exceeding max_len)
>> set_len() to tell the DMA driver the amount of valid bytes written
>>
>> DEV_TO_MEM flow on client side:
>> In the completion callback, get_ptr()
>> the metadata is payload_len bytes and can be accessed in the return pointer.
> 
> I would think to unify this..

I have tried it, but the attach mode and the pointer mode is hard to
handle with a generic API.
I will try to find a way to unify things in a sane way.

I have moved the metadata_ops to dma_async_tx_descriptor to emphasize
that it is per descriptor setting:
https://github.com/omap-audio/linux-audio/commit/02e095d1320a4bb3ae281ddb208ce82ead746f00#diff-92c0a79f414dc3be9dfc67a969c0dd71


>> BTW: The driver which is going to need this is now accessible in public:
>> https://git.ti.com/ti-linux-kernel/ti-linux-kernel/trees/ti-linux-4.14.y/drivers/dma/ti
>>
>> or in my wip tree:
>> https://github.com/omap-audio/linux-audio/tree/peter/ti-linux-4.14.y/wip/drivers/dma/ti
>>
>> prefixed with k3-*
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
