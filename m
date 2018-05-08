Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2554686-1525773929-2-619775263286741943
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773929; b=jt1Z6OOLfCDfKM/dX32x5U86oVDjyhcaIZCQQgl15nXqfjVWWo
    ZEL6TCQoxkzNwCftKZHgbiSa/MLzmIt9C6WSthTVXKEZpJKdGHLLdcgpQ+gG6lc9
    KnwOTx4pXD4FJwarC/DbfViSrdej79NSSjfN3BScBvMYgXvsfUTIhJKS+285zSd0
    0J6kiaBKsU8FBBeFMz7+YmwuK69jBT0H7bJshtTWV/GYI9bkNxwloZ4OYCfr5WTl
    kI2aOwA43tAllmblSW96lieH7jH4h63wUSyZVjbt4QwNWcFrjeU5tp79r09VAoDO
    2vItGexLBcN/tkjZbpRE5JxPyftt5g98qLCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525773929;
    bh=n3h6WIw99yjOQcKEaG/ytD602mmOBJTvBjykQSRrksM=; b=LPsONDBflYq2
    XlElm7E0mL+vPPppxf1hmyzDif19ZT7MN0aAUFXtqsVCdhptv7SdBKCrSiWkIARa
    EfsNXZjzc9Vmd3r7EiMGCqMdUyqv/4aQgo8lacqnqKqRvVpyvpHzik0r+bUEuPmD
    6wHgVIWZGq3Us5wvlgcxQSCdG/Y5kGWIwg5H41uq2muJKwVjwyLN+fZ4Yw+0EPr9
    j20VeqFl8xmBi4mtJedM4i5988Q6KLViKEkaNiMMX6fqgNKSP+xew7ZvhcuJVkqd
    eKENznYUP8hceV7dYWHhHYqKvp+d8qr0Io9RFNpvz0yFuSRLHgj0HmXzouJ44kmK
    lswuuxUXMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNOBtrdhGG2Qq0XSDDb/Mev0uUCAVG8DO/RbsCfbN+PTF41C8NK9c5EbfD4DeODg4vjNGSmV6wRE1TgTDQzFnC9XbqE8T+rTfu5dYFMwE96QkB8tAZQN
    Jq7ClxZk6I9WER8rKnVEcVfy34MPzLQyqTCQSp6zctz1GFSnN5MVt1sy2OyGA4XRpqSsnps0qMEbAvSquZJKSHRy72/eINzvhp8YFa53rSFrnZSv0UMNEOCw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7CQSdrXTAAAA:8 a=gKo63Toa8PSyKigJPWQA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754822AbeEHKFZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 06:05:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55336 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754439AbeEHKFZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 May 2018 06:05:25 -0400
Subject: Re: [PATCH 3/3] dma-debug: unexport dma_debug_resize_entries and
 debug_dma_dump_mappings
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Michal Simek <monstr@monstr.eu>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        nios2-dev@lists.rocketboards.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20180424140235.9125-1-hch@lst.de>
 <20180424140235.9125-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <bb5bb25f-24da-9729-a39b-3b88c65ef628@arm.com>
Date: Tue, 8 May 2018 11:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424140235.9125-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24/04/18 15:02, Christoph Hellwig wrote:
> Only used by the AMD GART driver, which must be built in.

FWIW debug_dma_dump_mappings() is also called by the Intel VT-d driver, 
but the same reasoning still applies. This does rather beg the question 
of whether it's right to have bits of low-level dma-debug internals 
*only* called by a couple of IOMMU drivers, but that can wait for 
another day.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   lib/dma-debug.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/lib/dma-debug.c b/lib/dma-debug.c
> index 075253cb613b..6a1ebaa83623 100644
> --- a/lib/dma-debug.c
> +++ b/lib/dma-debug.c
> @@ -444,7 +444,6 @@ void debug_dma_dump_mappings(struct device *dev)
>   		spin_unlock_irqrestore(&bucket->lock, flags);
>   	}
>   }
> -EXPORT_SYMBOL(debug_dma_dump_mappings);
>   
>   /*
>    * For each mapping (initial cacheline in the case of
> @@ -753,7 +752,6 @@ int dma_debug_resize_entries(u32 num_entries)
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(dma_debug_resize_entries);
>   
>   /*
>    * DMA-API debugging init code
> 
