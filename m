Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C349AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AACF2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 23:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUu4Keqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AACF2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbeKCIpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 04:45:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34575 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeKCIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 04:45:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id f78-v6so1703791pfe.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Nov 2018 16:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2WfvGzbrhgQTRcRFfsCjyfCLP8HZTdCpCbcYB7JfAE=;
        b=MUu4KeqepfKTdfbYtFEKQpeOn9+6AQOsXtxn2fVVrXSjrVv6+eEiUe/AU1RcIaZkiF
         IZYQ5Y/e3qYlW3/qeAi3kBNVipFdHU5LTC+YJ1ZPNkSXGj4p1LJCB3qRgJNY6gg78brL
         oRLd4PkUdmnkLOaRv6cLpx/2OzNOCVV0Rz3xN534Z7dNagiupBz0gA2wFpsweDkwjZIO
         +0fx0BDkqBTNaknpq7azT6puvQduf8vHJ/h5qyGFlj8t4vW/Ts6YMeQACozOmganlUu6
         WLu1JEvmzlrB9yqaX80eUzqGKjGfcdQKaR42ZijfyXN/WoAzzgtulJWhOBd5pIxKaxSO
         4CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2WfvGzbrhgQTRcRFfsCjyfCLP8HZTdCpCbcYB7JfAE=;
        b=DScv3xhQW5V0k+Ter9icEooqXYQ3G92p7p6dZh5dqFudaojTOuIAf/C71h+BNCAgsD
         dwuLLT0jBYPN+YdFA2MArLyfrSH2d3G0p8Dxbytrp0A3hwx8jq6NnUZb1Y+AffUI08/S
         KbnnKTRRIHn71ygVTFJUzdarSRqYae4+zyODHQLtBHiwO5+TBgGuRLnPp13e3cXg8VwI
         i1QUyD88Pj8VQFcENniceRvUmuQMnL3OS9wn2g2+jlX6GiyksivuDAdoZ0sI+A3KMfgD
         aV6o6dOtnJI9FZ/1FvuUuakbXrDTy27LIjgbYM2tP2fO+kVjVgAGsAcwfyX8M8uAChh1
         ZEGQ==
X-Gm-Message-State: AGRZ1gLIdvzV6d9RX7M4XxPPPxHspKn7rFgNYTHh+V7MQOcno6WmQ1M2
        hW5XiivoZ3Ck/pYUIIjxvhw=
X-Google-Smtp-Source: AJdET5cBdvTPxFKa8zCEQR6PX4WtxakXjo2Z8X4GBmyOHOxqv6J/IDAnZVWRo51aj+g2dmdx7HXB6Q==
X-Received: by 2002:a63:d444:: with SMTP id i4-v6mr12465814pgj.194.1541201778255;
        Fri, 02 Nov 2018 16:36:18 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e81-v6sm60629744pfb.153.2018.11.02.16.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 16:36:18 -0700 (PDT)
Date:   Fri, 2 Nov 2018 16:36:13 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:54:07PM +0000, Robin Murphy wrote:
> On 01/11/2018 21:35, Nicolin Chen wrote:
> > The __GFP_ZERO will be passed down to the generic page allocation
> > routine which zeros everything page by page. This is safe to be a
> > generic way but not efficient for iommu allocation that organizes
> > contiguous pages using scatterlist.
> > 
> > So this changes drops __GFP_ZERO from the flag, and adds a manual
> > memset after page/sg allocations, using the length of scatterlist.
> > 
> > My test result of a 2.5MB size allocation shows iommu_dma_alloc()
> > takes 46% less time, reduced from averagely 925 usec to 500 usec.
> 
> Assuming this is for arm64, I'm somewhat surprised that memset() could be
> that much faster than clear_page(), since they should effectively amount to
> the same thing (a DC ZVA loop). What hardware is this on? Profiling to try

I am running with tegra186-p2771-0000.dtb so it's arm64 yes.

> and see exactly where the extra time goes would be interesting too.

I re-ran the test to get some accuracy within the function and got:
1) pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
   // reduced from 422 usec to 56 usec == 366 usec less
2) if (!(prot & IOMMU_CACHE)) {...}	//flush routine
   // reduced from 439 usec to 236 usec == 203 usec less
Note: new memset takes about 164 usec, resulting in 400 usec diff
      for the entire iommu_dma_alloc() function call.

It looks like this might be more than the diff between clear_page
and memset, and might be related to mapping and cache. Any idea?

> > @@ -568,6 +571,15 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   	if (attrs & DMA_ATTR_ALLOC_SINGLE_PAGES)
> >   		alloc_sizes = min_size;
> > +	/*
> > +	 * The generic zeroing in a length of one page size is slow,
> > +	 * so do it manually in a length of scatterlist size instead
> > +	 */
> > +	if (gfp & __GFP_ZERO) {
> > +		gfp &= ~__GFP_ZERO;
> > +		gfp_zero = true;
> > +	}
> 
> Or just mask it out in __iommu_dma_alloc_pages()?

Yea, the change here would be neater then.

> > @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> >   	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> >   		goto out_free_iova;
> > +	if (gfp_zero) {
> > +		/* Now zero all the pages in the scatterlist */
> > +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
> > +			memset(sg_virt(s), 0, s->length);
> 
> What if the pages came from highmem? I know that doesn't happen on arm64
> today, but the point of this code *is* to be generic, and other users will
> arrive eventually.

Hmm, so it probably should use sg_miter_start/stop() too? Looking
at the flush routine doing in PAGE_SIZE for each iteration, would
be possible to map and memset contiguous pages together? Actually
the flush routine might be also optimized if we can map contiguous
pages.

Thank you
Nicolin
