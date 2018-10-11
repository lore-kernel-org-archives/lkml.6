Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CECC677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E1A21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E1A21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeJLBW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:22:26 -0400
Received: from foss.arm.com ([217.140.101.70]:41822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJLBW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:22:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE35ED1;
        Thu, 11 Oct 2018 10:54:09 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35BB23F5D3;
        Thu, 11 Oct 2018 10:54:08 -0700 (PDT)
Subject: Re: [PATCH 02/10] swiotlb: mark is_swiotlb_buffer static
To:     Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-3-hch@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bfd45ad6-901d-c9a6-2264-4f93684c0fa1@arm.com>
Date:   Thu, 11 Oct 2018 18:54:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008080246.20543-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/10/18 09:02, Christoph Hellwig wrote:

I agree there isn't really a good reason for external code to ever be 
poking at this, despite it being helpful for arch code trying to hack 
around awful coherency issues ;)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/swiotlb.h | 1 -
>   kernel/dma/swiotlb.c    | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 965be92c33b5..7ef541ce8f34 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
>   #endif
>   
>   extern void swiotlb_print_info(void);
> -extern int is_swiotlb_buffer(phys_addr_t paddr);
>   extern void swiotlb_set_max_segment(unsigned int);
>   
>   extern const struct dma_map_ops swiotlb_dma_ops;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9062b14bc7f4..26d3af52956f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
>   	max_segment = 0;
>   }
>   
> -int is_swiotlb_buffer(phys_addr_t paddr)
> +static int is_swiotlb_buffer(phys_addr_t paddr)
>   {
>   	return paddr >= io_tlb_start && paddr < io_tlb_end;
>   }
> 
