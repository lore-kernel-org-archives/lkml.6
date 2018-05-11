Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4027354-1526047001-2-4020425899973495661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526047001; b=i4O/a8xqU5lLMNmtT54nHHRH030crfRySLWpB7NPtTOe591LfI
    6j1eJVYUyt7NgI42KXlQ+21eS9scCNzvyeJ1XM4Jp0QYpMr8dsy4DCVyhwqXzQG3
    JG+uPjcDbxSoAH9nvO3i+z/0BzyQlqfbu+axZC7uudFH3zcZHXVT/eF3+XMdDvCB
    kqj6hTi7vCqVuGYRti+59z4o5ykhc1h1ra7WZYzez55WSn5msAvMKN6F5ltEP4/Q
    r030/LRFlnbC9Or2XjXruK1l1HCFj2bAL4YxHcR8Iu1sZOLfGIwkgqFwGnZRkQ4o
    a2a7RcTeahZpQlr7YlAjv0JLcf/Gj8pVGNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526047001;
    bh=UT/Qy7g5ZeS3x10lsPbhQyLGzSsp+OPI6ReSw/GZGxU=; b=ky4mmbzgAaJ8
    5Xh4yLKUVVXhG2hINe6VKmr/9ordRIWVd6a5zepoqcD8FdU401rzJweXg8uBuTPd
    YOU//50VeHBTu/GntEVblF7miVlwLHVc1hNnh/ODKw+QTL0iDYsU5EQwSqzSRZ45
    CdStPE07b6qBqBdfoG0+zAhIRKzupFYmnYzWdPFUoAGPfQn/XJ8SBKWNrKOu0VSz
    170htoHobYnWnj1DrrWE3CXtbJHoxWazugvYHO/sRV06j2EMJOJ96toRAn16z3dF
    qiOgf/m8JAd/t+xf5TIvHk4JBgr0zqAcrX2mVRwYZCbWhk5Ougq72Mr0YsgOK9wv
    pH2bFLudIQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=huawei.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKJWpWvQe+N+RDUAG9DAHjFJm36FSoSaz87jjTpbZ78W0lTEMP/UDMCj/ZiR9c8NerdlizHedhgmVlQUnoaheee3CaKnljfXjpNqu+aiBHWX/zajyu9t
    ARYtyCPR9kbf3RmT2y6BWQXh6/LzVSIutw2GWHRsDbheHa/pY+DEYv+bhjzBmdwZ/GAlL/lJFx7RKdUqx0NZ4hZDlx5mSpMIFBEdtWHSJH62RhpOfko1Ktbh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=fnsVjXYF8_4A:10 a=N659UExz7-8A:10
    a=VUJBJC2UJ8kA:10 a=IDgwzHRtDfHMOwfLCEIA:9 a=pILNOxqGKmIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeEKN4h (ORCPT <rfc822;linux@kroah.com>);
        Fri, 11 May 2018 09:56:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56793 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752974AbeEKN4g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 May 2018 09:56:36 -0400
Subject: Re: [PATCH 04/20] arm-nommu: use generic dma_noncoherent_ops
To: Christoph Hellwig <hch@lst.de>, <iommu@lists.linux-foundation.org>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-5-hch@lst.de>
CC: <linux-arch@vger.kernel.org>, <linux-xtensa@linux-xtensa.org>,
        "Michal Simek" <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>,
        <linux-c6x-dev@linux-c6x.org>, <linux-parisc@vger.kernel.org>,
        <linux-sh@vger.kernel.org>, <linux-hexagon@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <openrisc@lists.librecores.org>, Greentime Hu <green.hu@gmail.com>,
        <linux-alpha@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <nios2-dev@lists.rocketboards.org>,
        <linux-snps-arc@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <73603c68-da05-22bd-efab-d0387a98225d@huawei.com>
Date: Fri, 11 May 2018 14:56:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180511075945.16548-5-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.90.114]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 11/05/2018 08:59, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation for
> the nommu dma map implementation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig                |   1 +
>  arch/arm/Kconfig                |   4 +
>  arch/arm/mm/dma-mapping-nommu.c | 139 +++++---------------------------
>  3 files changed, 23 insertions(+), 121 deletions(-)
>
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index 89d47eac18b2..3a492a9aeaad 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -9,6 +9,7 @@
>  config ARC
>  	def_bool y
>  	select ARC_TIMERS
> +	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select ARCH_HAS_SYNC_DMA_FOR_CPU
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE

I guess that this arc change is here by accident, no? And isn't 
ARCH_HAS_SYNC_DMA_FOR_DEVICE already selected (by 3/20)?

>  	select ARCH_HAS_SG_CHAIN
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c43f5bb55ac8..76ddd0064f87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
