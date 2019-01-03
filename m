Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E26CC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1CC217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546538102;
	bh=cx5/aIyE2OjbGfKc9XcMI2kcZJltMo12tCbM1unRiHY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Vn00kjahbAYCgyDcgBHqflZgQo+Q1LFX6iI74f5OB9Ix2PUVAavFVqp86gEIVb2yv
	 wvZvtqAyNhD7hPXo/QlSkeUlkoe0GRSSmdjpS8ex6pjT2O3ohuk6pSK2F45wObWt2/
	 i/gNOCwh3dzOUI0SYiQTgofKSpg5RocA3YYr3ycI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfACRzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 12:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbfACRzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 12:55:00 -0500
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 698D620815;
        Thu,  3 Jan 2019 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546538100;
        bh=cx5/aIyE2OjbGfKc9XcMI2kcZJltMo12tCbM1unRiHY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=1m08ovSSQIXloyX2c8U3SeEdGNaHUFKt7FFxukBWLjeho1DsoEAYseOk00tSk6UAh
         wTSQtgwka4s6sw2bdm+sX9Ia+FOqy3GrxMpUtRc0apsZhGjVGDC8qVNvKISVoRFyMh
         LeeUoOTNV5QLrZVYeuWUhDjIQoIDymxyzDY1SouA=
Date:   Thu, 3 Jan 2019 09:54:58 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Huaisheng Ye <yehs2007@zoho.com>
cc:     hch@lst.de, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org, m.szyprowski@samsung.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        chengnt@lenovo.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux-foundation.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [PATCH] dma-mapping: remove unused attrs parameter to
 dma_common_get_sgtable
In-Reply-To: <20190103082908.9988-1-yehs2007@zoho.com>
Message-ID: <alpine.DEB.2.10.1901030954240.800@sstabellini-ThinkPad-X260>
References: <20190103082908.9988-1-yehs2007@zoho.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jan 2019, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> dma_common_get_sgtable has parameter attrs which is not used at all.
> Remove it.
> 
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>

FYI the patch doesn't apply cleanly to master.


> ---
>  drivers/xen/swiotlb-xen.c   | 2 +-
>  include/linux/dma-mapping.h | 5 ++---
>  kernel/dma/mapping.c        | 3 +--
>  3 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2a7f545..2dc17a5 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -697,7 +697,7 @@ static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
>  							   handle, size, attrs);
>  	}
>  #endif
> -	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
> +	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size);
>  }
>  
>  static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index d327bdd..bbfad44 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -483,7 +483,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  
>  int
>  dma_common_get_sgtable(struct device *dev, struct sg_table *sgt, void *cpu_addr,
> -		dma_addr_t dma_addr, size_t size, unsigned long attrs);
> +		dma_addr_t dma_addr, size_t size);
>  
>  static inline int
>  dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
> @@ -495,8 +495,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
>  	if (ops->get_sgtable)
>  		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
>  					attrs);
> -	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
> -			attrs);
> +	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size);
>  }
>  
>  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 58dec7a..6b33f10 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -202,8 +202,7 @@ void dmam_release_declared_memory(struct device *dev)
>   * Create scatter-list for the already allocated DMA buffer.
>   */
>  int dma_common_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		 void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		 unsigned long attrs)
> +		 void *cpu_addr, dma_addr_t dma_addr, size_t size)
>  {
>  	struct page *page;
>  	int ret;
> -- 
> 1.8.3.1
> 
> 
