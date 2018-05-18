Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-77256-1526664511-2-8971671894719459761
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526664511; b=MlwyvMtklkM9x9xIfBG3nkdo6fQeYU5Doul2mMyfL3kVFNtVrZ
    Chjigk4ZhMZZDIAJSmcOj4WKplQ7QGS7tbgefMkx2lJuPh3vrpENKHW5NgF5tUWN
    oUQU3MCPdpKKfacy5isERoRWisQYyWcUm6pn69IpEWtiPKTPMUNuFfCokm1Kox30
    Ugbq+7xO/+IqQ6uaUINTm56Xt3HK/Q7jEDEynZSCdTcLsFStTcm448SXwPvktnml
    /ExAsZw5dh8vPLDd7jcVquEt2XZjDl17ydejSy1yRDXQGbYwGV2JZM+PhCQNLXrB
    t/oiUtRqtU475nMqfhvrr+Cqj3atMpUnZCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526664511;
    bh=DFyV7rMfRTKjhovBpXokiICtcd2uTqVwcDHrzRiyZrY=; b=Xx9b+kINjJPL
    ZT2fvW+TnmaZYhH1+ckpmbdQK2MOHW+sr2Lm0zc+6MHPM4He6mk0tRyDjnQl7ni5
    mIqGjui1dbgD6YXpDVUKbxqlOY9chyMOG7tqtrLuNyvyIZ8ewBrto2YCoJwXFTzP
    CDjLhAIE2OgWmDLeG994k2ev7XJAen/lICjodd7vpAqg/bnmBXoLc+Pay6xXCoQ4
    FZTO0GayGg4cPpF3u9/So0BG7hPyqAt2IHaZeUTHb7uluTpIQzxRALyqfDi5EWmQ
    WVQ9xBo870qW3pLKTgF1G5f8blFJORldhb/M113aF7nlopfu7IPUzQu9n6Vnh0sA
    xZRDIP28Mg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
    header.i=@synopsys.com header.b=kpCn2I81 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=synopsys.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=synopsys.com
      header.i=@synopsys.com header.b=kpCn2I81 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=mail;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=synopsys.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPqYQSdmUMMFpY3++S7aBikeHuNiNe0w5QCcDsuowbo6m0h1a8BR9q3dGlJKMgKjEEOUslh1Lqs0oEhFfhHsah0Rf9saPadSSIw1kj0ulgdn9opai/ZM
    0FcnW45ACoB3nHKZhk3nE7XE3azforkD0wSnPgKB2YnWM5LyX60HsToZvN2UqPQu/bSLLr4VzT2Tm8mo0xUHhBYwEXknvli3Vzk/O6W0jUkLS3yqwAF1mjes
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=1diNBeniFdIA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=Q6R23yxVAHhKJkGohtAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeERR22 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:28:28 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:58524 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbeERR2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 13:28:25 -0400
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
To: "hch@lst.de" <hch@lst.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <20180518132731.GA31125@lst.de>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <482e343c-bc87-9c0e-b6a8-bb69bcbeecda@synopsys.com>
Date: Fri, 18 May 2018 10:28:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518132731.GA31125@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.52]
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/18/2018 06:23 AM, hch@lst.de wrote:
>   Fri, May 18, 2018 at 01:03:46PM +0000, Alexey Brodkin wrote:
>> Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
>> I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
>> is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
>> DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
>>
>> I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
>> in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.
> arc overrides the dir paramter of the dma_sync_single_for_device/
> dma_sync_single_for_cpu calls.  My patches dropped that, and I have
> restored that, and audit for the other architectures is pending.

Right, for now lets retain that and do a sweeping audit of @direction - to me it 
seems extraneous (as it did 10 years ago), but I'm not an expert in this are so 
perhaps it is needed for some device / arches and it would be good to understand 
that finally.

> That being said the existing arc code still looks rather odd as it
> didn't do the same thing for the scatterlist versions of the calls.
> I've thrown in a few patches into my new tree to make the sg versions
> make the normal calls, and to clean up the area a bit.

Not calling names or anything here, but it doesn't exist for sg variants, because 
I didn't write that code :-)
It was introduced by your commi:

2016-01-20 052c96dbe33b arc: convert to dma_map_ops
