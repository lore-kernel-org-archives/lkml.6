Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAB3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A092B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JvcPMQI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfAVPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:43:14 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37146 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbfAVPnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:43:14 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0MFgvsS092307;
        Tue, 22 Jan 2019 09:42:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548171777;
        bh=lxilm8EsK1H6eNUyz/uDSJciuNUn6e2uQFnq+YD6tIw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JvcPMQI4M3oc/INR5LFoRcR7+/upuf8zjIAnmufezdPs0ZwV7yiXTIE9v3zrKgNOL
         mJqojAnOiNtwpXo0DHVas5cw+gkJe2rcUWOukZ/3H5JnlHqj450nMRnxegEO57I2Kb
         Q2WSgEkmw/LrdS5cdNWDp+h6cohwKLyAPobBMKA0=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0MFgvDQ077709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Jan 2019 09:42:57 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 22
 Jan 2019 09:42:56 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 22 Jan 2019 09:42:56 -0600
Received: from [172.22.102.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0MFguPg004886;
        Tue, 22 Jan 2019 09:42:56 -0600
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
To:     Liam Mark <lmark@codeaurora.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Laura Abbott <labbott@redhat.com>, <sumit.semwal@linaro.org>,
        <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
 <20190121083046.GD12420@infradead.org>
 <alpine.DEB.2.10.1901211142560.9631@lmark-linux.qualcomm.com>
 <0ed7875f-15e9-184f-5b99-9a53df7c8d14@ti.com>
 <alpine.DEB.2.10.1901211214570.11004@lmark-linux.qualcomm.com>
 <4925c9db-fc73-1ccb-1766-ef68d014d55a@ti.com>
 <alpine.DEB.2.10.1901211415140.11004@lmark-linux.qualcomm.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <cc2018fb-5381-da7b-4e92-0e90086ae132@ti.com>
Date:   Tue, 22 Jan 2019 09:42:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1901211415140.11004@lmark-linux.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 4:18 PM, Liam Mark wrote:
> On Mon, 21 Jan 2019, Andrew F. Davis wrote:
> 
>> On 1/21/19 2:20 PM, Liam Mark wrote:
>>> On Mon, 21 Jan 2019, Andrew F. Davis wrote:
>>>
>>>> On 1/21/19 1:44 PM, Liam Mark wrote:
>>>>> On Mon, 21 Jan 2019, Christoph Hellwig wrote:
>>>>>
>>>>>> On Sat, Jan 19, 2019 at 08:50:41AM -0800, Laura Abbott wrote:
>>>>>>>> And who is going to decide which ones to pass?  And who documents
>>>>>>>> which ones are safe?
>>>>>>>>
>>>>>>>> I'd much rather have explicit, well documented dma-buf flags that
>>>>>>>> might get translated to the DMA API flags, which are not error checked,
>>>>>>>> not very well documented and way to easy to get wrong.
>>>>>>>>
>>>>>>>
>>>>>>> I'm not sure having flags in dma-buf really solves anything
>>>>>>> given drivers can use the attributes directly with dma_map
>>>>>>> anyway, which is what we're looking to do. The intention
>>>>>>> is for the driver creating the dma_buf attachment to have
>>>>>>> the knowledge of which flags to use.
>>>>>>
>>>>>> Well, there are very few flags that you can simply use for all calls of
>>>>>> dma_map*.  And given how badly these flags are defined I just don't want
>>>>>> people to add more places where they indirectly use these flags, as
>>>>>> it will be more than enough work to clean up the current mess.
>>>>>>
>>>>>> What flag(s) do you want to pass this way, btw?  Maybe that is where
>>>>>> the problem is.
>>>>>>
>>>>>
>>>>> The main use case is for allowing clients to pass in 
>>>>> DMA_ATTR_SKIP_CPU_SYNC in order to skip the default cache maintenance 
>>>>> which happens in dma_buf_map_attachment and dma_buf_unmap_attachment. In 
>>>>> ION the buffers aren't usually accessed from the CPU so this allows 
>>>>> clients to often avoid doing unnecessary cache maintenance.
>>>>>
>>>>
>>>> How can a client know that no CPU access has occurred that needs to be
>>>> flushed out?
>>>>
>>>
>>> I have left this to clients, but if they own the buffer they can have the 
>>> knowledge as to whether CPU access is needed in that use case (example for 
>>> post-processing).
>>>
>>> For example with the previous version of ION we left all decisions of 
>>> whether cache maintenance was required up to the client, they would use 
>>> the ION cache maintenance IOCTL to force cache maintenance only when it 
>>> was required.
>>> In these cases almost all of the access was being done by the device and 
>>> in the rare cases CPU access was required clients would initiate the 
>>> required cache maintenance before and after the CPU access.
>>>
>>
>> I think we have different definitions of "client", I'm talking about the
>> DMA-BUF client (the importer), that is who can set this flag. It seems
>> you mean the userspace application, which has no control over this flag.
>>
> 
> I am also talking about dma-buf clients, I am referring to both the 
> userspace and kernel component of the client. For example our Camera ION 
> client has both a usersapce and kernel component and they have ION 
> buffers, which they control the access to, which may or may not be 
> accessed by the CPU in certain uses cases.
> 

I know they often work together, but for this discussion it would be
good to keep kernel clients and usperspace clients separate. There are
three types of actors at play here, userspace clients, kernel clients,
and exporters.

DMA-BUF only provides the basic sync primitive + mmap directly to
userspace, both operations are fulfilled by the exporter. This patch is
about adding more control to the kernel side clients. The kernel side
clients cannot know what userspace or other kernel side clients have
done with the buffer, *only* the exporter has the whole picture.

Therefor neither type of client should be deciding if the CPU needs
flushed or not, only the exporter, based on the type of buffer, the
current set attachments, and previous actions (is this first attachment,
CPU get access in-between, etc...) can make this decision.

You goal seems to be to avoid unneeded CPU side CMOs when a device
detaches and another attaches with no CPU access in-between, right?
That's reasonable to me, but it must be the exporter who keeps track and
skips the CMO. This patch allows the client to tell the exporter the CMO
is not needed and that is not safe.

Andrew

> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
