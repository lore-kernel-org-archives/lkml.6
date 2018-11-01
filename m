Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69628C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323122064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmOvKuNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 323122064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbeKBDIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:08:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44043 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeKBDIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:08:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so7625774plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L+sb9eWuy7tjdMyPMkxoJGa1rM46uiI7uXbqd4fxzRQ=;
        b=FmOvKuNLwyTAZ22gqBEXCl5n0gwVS8lhp6yxYlOrEewGrbCtJakVRyuEqdLzze3m2U
         dTchYj7S30vPaEzoEiny9KBz26cMOOMzitlPGI4Tkky5iJQX7I3gGhpjqt+MLGsBUphD
         uP197oGImKDqPpfHbmIgFI4asXBc7nGxRmmXYTqrKc8PDbr7t3sBTxp7O4Sq+glxZBEm
         ITPCOXSgfsYZw7nkH6mzWcVtVs7kp7UkP7vpP0xjmtaY5r00EWcBIiPpnJpWAmUdqSVd
         1QS0LYTZQ4CrJri2EnCPfEdPg3nq8OPGZVzUW20AfmEk11TdBB2E32dcfG3aSwBGmCBl
         jhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+sb9eWuy7tjdMyPMkxoJGa1rM46uiI7uXbqd4fxzRQ=;
        b=AbzSBRw+CSWMzN4jnH68idXlQiz1/J8mFSyQWiR6rkHSRt0j/h5K1Yj4+wSXzdNfKw
         Xk3zU1+ZPmcdVDwxGBjFQFSlp9Je4VYHUYhe/SEUXkKx7MbeWDxt2MdUvf4L/isYE5PN
         2G4sJTDDOgqGxrHoZq6qns7qpG6WbKRkx/Vz2SJdf4WH1QzZ31HGp8mYXjJxJ61iPZDz
         paw+Htf/0+Pa6MOyEShhszL24/8SxUf5oE/vLvZHm2JrPZ6jfCeIwAFKEohOT4lbPxQQ
         QSdob0cete5LFB2P/zWkFVsWoUzGnd/8BoIBcshl8gmU+9qTmX4yyIYlEi+RarO8Lwtg
         31sg==
X-Gm-Message-State: AGRZ1gJ2WBrLocrVr4talf2J6zf6GeaGtIQnDyV2Ya4tmDZfsSwnx1lA
        UNLwPWa5EeFeEfUZo2URTxE=
X-Google-Smtp-Source: AJdET5emNcCT+kiwInxtYlA2fDZ3XHatGTsYPKyLsPlBjamTic8RwECvWVfqGqqIo1JcIm4q/n2V1w==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr8500114plk.177.1541095485384;
        Thu, 01 Nov 2018 11:04:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f193-v6sm38025289pfc.74.2018.11.01.11.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 11:04:44 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:04:40 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181101180439.GA4746@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for the comments.

On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> On 31/10/2018 20:03, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to allocate one single page from CMA area. Since
> > the CMA area has a limited predefined size of space, it might run
> > out of space in some heavy use case, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > This patch tries to skip CMA allocations of single pages and lets
> > them go through normal page allocations. This would save resource
> > in the CMA area for further more CMA allocations.
> 
> In general, this seems to make sense to me. It does represent a theoretical
> change in behaviour for devices which have their own CMA area somewhere
> other than kernel memory, and only ever make non-atomic allocations, but I'm
> not sure whether that's a realistic or common enough case to really worry
> about.

Hmm..I don't quite understand the part of worrying its realisticness.
Would you mind elaborating a bit? As I tested this change on Tegra186
board, and saw some single-page allocations have been directed to the
normal allocation; and the "CmaFree" size reported from /proc/meminfo
is also increased. Does this mean it's realistic?

Thank you
Nicolin

-----

> 
> Robin.
> 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >   kernel/dma/direct.c | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 22a12ab5a5e9..14c5d49eded2 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -120,8 +120,12 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
> >   	gfp |= __dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> >   			&phys_mask);
> >   again:
> > -	/* CMA can be used only in the context which permits sleeping */
> > -	if (gfpflags_allow_blocking(gfp)) {
> > +	/*
> > +	 * CMA can be used only in the context which permits sleeping.
> > +	 * Since addresses within one PAGE are always contiguous, skip
> > +	 * CMA allocation for a single page to save CMA reserved space
> > +	 */
> > +	if (gfpflags_allow_blocking(gfp) && count > 1) {
> >   		page = dma_alloc_from_contiguous(dev, count, page_order,
> >   						 gfp & __GFP_NOWARN);
> >   		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
> > 
