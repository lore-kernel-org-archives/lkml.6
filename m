Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9D7C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20DA2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 12:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvMrjOsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20DA2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=darnok.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbeLBMmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 07:42:50 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39846 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbeLBMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 07:42:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id n21so10861560qtl.6;
        Sun, 02 Dec 2018 04:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lEtZ8HUr5ta3aKPraRuQaLc/uiyvX7GFrTe4WWXumQI=;
        b=nvMrjOsPdkPMzQLlt1gunKPVHCAajsFxx0tWR6GaGF7HBlewscy+eiPaX1SQpZP/nS
         vnhJr27IuE7V4isA7367vYd3vuhRTsll1+3rA5gg8VyHUOcAEUjtBSRVEQw+hZYzgP1t
         UxYBtIpAA5c8k4TEigeoDoqu5fnoWxGrPrm603hx3H2+5NAdttbjdDWgbZsI7ovMhLSR
         l5IbUKsCuCwlMtSDiP4/QAo6BjTwdjHw5Bo8lY5GWkQaBUVmNu1yqTu1S4YXUes+ZsU+
         JE0JiR3PKDnT7okU4ZU17FJmEdzcM2mJAs3I7t5mM82Vcjz1779tMprJlSleWYPdf9xD
         l9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lEtZ8HUr5ta3aKPraRuQaLc/uiyvX7GFrTe4WWXumQI=;
        b=m4wuYQ4DxcbOWGuZBMpEp51P8M5lBnP1GK0CK+0o7XpzGaoT3HuWcUOk3Ww7GG+6PX
         gx8qVkOqIdAPoSqyYcUXhg0NPnIBGwe0guJ0okWZ9QAME7VNQkPrEwkJvceD8Z2XLwly
         Tw1k6U6iPfd7vJ4wLPWv+ea69RWOMr5ggA9Y4jhYWk+VBzHCdaKRFPEGLuSSHaw7VTs7
         N49yaa+IAdRQ3601IDPnSTxYe1Zb5H1UBruNWlq1UJ9pR0miqfqqmXTz8xch2H9Df1Bp
         XK3GW25jOGl4Dbp4Km1IlMXnyNQrgCvUZzyzPNfwt1cWQBhk1HeH5PEGvgmlgodkGO/r
         GQzA==
X-Gm-Message-State: AA+aEWa6DeE/4ZcVlTAjAZKPukCcHZWuNW5h52O/Pf5lWN2AFH3Nx7A8
        cnjnUIYjs18pAfgZsmAccS8=
X-Google-Smtp-Source: AFSGD/XJoGLFFla/kAziyV6siowbKNDg2u87EjOALppmCId+LntOL79e/BjjXr0SoIlJXgIs/OJ+yA==
X-Received: by 2002:a05:6214:c7:: with SMTP id f7mr12527886qvs.44.1543754566450;
        Sun, 02 Dec 2018 04:42:46 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id s46sm6666795qtc.63.2018.12.02.04.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 04:42:45 -0800 (PST)
Date:   Sun, 2 Dec 2018 07:42:42 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/23] xen-swiotlb: remove the mapping_error dma_map_ops
 method
Message-ID: <20181202124241.GB3166@localhost.localdomain>
References: <20181130132231.16512-1-hch@lst.de>
 <20181130132231.16512-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130132231.16512-22-hch@lst.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 02:22:29PM +0100, Christoph Hellwig wrote:
> Return DMA_MAPPING_ERROR instead of 0 on a dma mapping failure and let
> the core dma-mapping code handle the rest.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Konrad Rzeszutek Wilk <konrad@darnok.org>
> ---
>  drivers/xen/swiotlb-xen.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 2a7f545bd0b5..6dc969d5ea2f 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -53,8 +53,6 @@
>   * API.
>   */
>  
> -#define XEN_SWIOTLB_ERROR_CODE	(~(dma_addr_t)0x0)
> -
>  static char *xen_io_tlb_start, *xen_io_tlb_end;
>  static unsigned long xen_io_tlb_nslabs;
>  /*
> @@ -406,7 +404,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
>  				     attrs);
>  	if (map == SWIOTLB_MAP_ERROR)
> -		return XEN_SWIOTLB_ERROR_CODE;
> +		return DMA_MAPPING_ERROR;
>  
>  	dev_addr = xen_phys_to_bus(map);
>  	xen_dma_map_page(dev, pfn_to_page(map >> PAGE_SHIFT),
> @@ -421,7 +419,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
>  	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
>  
> -	return XEN_SWIOTLB_ERROR_CODE;
> +	return DMA_MAPPING_ERROR;
>  }
>  
>  /*
> @@ -700,11 +698,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
>  	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
>  }
>  
> -static int xen_swiotlb_mapping_error(struct device *dev, dma_addr_t dma_addr)
> -{
> -	return dma_addr == XEN_SWIOTLB_ERROR_CODE;
> -}
> -
>  const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.alloc = xen_swiotlb_alloc_coherent,
>  	.free = xen_swiotlb_free_coherent,
> @@ -719,5 +712,4 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
>  	.dma_supported = xen_swiotlb_dma_supported,
>  	.mmap = xen_swiotlb_dma_mmap,
>  	.get_sgtable = xen_swiotlb_get_sgtable,
> -	.mapping_error	= xen_swiotlb_mapping_error,
>  };
> -- 
> 2.19.1
> 
