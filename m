Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9452AC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6007C2147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 02:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7STcRyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfBGC2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 21:28:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38291 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfBGC2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 21:28:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so4075867plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 18:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h32GDro9lZ6guonD1IJq6TP1NK4GW6mkOkPyNLpNVos=;
        b=u7STcRyN25ve0CVT5EAHWtAgMekWjXDGm7rjJeoQJ1rIDOdbEsOgRzQWXzctyxq8BF
         JcWJV9032OBxUUrmEoRC0K7/b0O4mcWseycRBLEIZJV+mhnZeCvmdKoAZzH6cZ7R2KGR
         tj81s61rvzmZwQgUoSWozr9DVdkddcNZ+OOcJTbsk6FF5y56nGR80E6IIfqMeaJ+/jiD
         9OQ8GCbMv2jTrwaEMEh7wERgS6fCh4bmIeVMRJ+uQKPFfK2zXNVRclaokVGki+tqkkma
         lSVRgXenEiKPzE5A5/s9tpf888NuyXD4Q1TF3eltoCba+EGH72NTOQu5nXI49W6c/wBt
         FzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h32GDro9lZ6guonD1IJq6TP1NK4GW6mkOkPyNLpNVos=;
        b=Kf3AU5z3rS1KqQZfcU7yqqEAYWTEeaOxZXolWjy+x7dNu8yBKk827BiDvUwP5adkLB
         7XFqKFb+eXPiGPf+Da9iEEeUg8TdUBHRXiWxFBuD6wVlxtPaZWT8KqiNmTNehufVFiLq
         RXb4k7h6pCqXhOkKwTX/4ovCv4KEjEAHZGbn0qJeoKFWNSA+yYDSLHVND3hLHGafDFjO
         2EPdmi+ODqxHCcgpvx2Z4Nazqx6YEnYa5WTaXsUjTovCtND2ph4n/qxcZMOqi0AzvsqI
         W6C3bMNzHa0E2C1pE33xRZN7scSSIabZOyTm1WZ56b3sOXfx6io8aL97k8fLD8lqUxSc
         X/HA==
X-Gm-Message-State: AHQUAubRYNeppaud6+5ejE4WFFljJx+MkD1v89Ol/DftePpygClwEz4g
        Ei3yF/50GxUIjXBox0/V2y5A2e5h
X-Google-Smtp-Source: AHgI3IaBvJIcLt1J6+tMAUVbJReppXD+xESCdrvHhGADXzXAmIKJXKJn83pY7dCL1fZK0FwwrA3Zfw==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr6049358plb.10.1549506533544;
        Wed, 06 Feb 2019 18:28:53 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u123sm10641854pfb.1.2019.02.06.18.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 18:28:53 -0800 (PST)
Date:   Wed, 6 Feb 2019 18:28:49 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20190207022848.GA5581@Asurada-Nvidia.nvidia.com>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com>
 <20190204082307.GA5916@lst.de>
 <20190205230514.GA21515@Asurada-Nvidia.nvidia.com>
 <20190206070726.GE23392@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206070726.GE23392@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Feb 06, 2019 at 08:07:26AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 05, 2019 at 03:05:30PM -0800, Nicolin Chen wrote:
> > > And my other concern is that this skips allocating from the per-device
> > > pool, which drivers might rely on.
> > 
> > Actually Robin had the same concern at v1 and suggested that we could
> > always use DMA_ATTR_FORCE_CONTIGUOUS to enforce into per-device pool.
> 
> That is both against the documented behavior of DMA_ATTR_FORCE_CONTIGUOUS
> and doesn't help existing drivers that specify their CMA area in DT.

OK. I will drop it.

> > > To be honest I'm not sure there is
> > > much of a point in the per-device CMA pool vs the traditional per-device
> > > coherent pool, but I'd rather change that behavior in a clearly documented
> > > commit with intentions rather as a side effect from a random optimization.
> > 
> > Hmm..sorry, I don't really follow this suggestion. Is it possible for
> > you to make it clear that what should I do for the change?
> 
> Something like this (plus proper comments):
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..789d734f0f77 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -192,10 +192,19 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>  				       unsigned int align, bool no_warn)
>  {
> +	struct cma *cma;
> +
>  	if (align > CONFIG_CMA_ALIGNMENT)
>  		align = CONFIG_CMA_ALIGNMENT;
>  
> -	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
> +	if (dev && dev->cma_area)
> +		cma = dev->cma_area;
> +	else if (count > PAGE_SIZE)
> +		cma = dma_contiguous_default_area;
> +	else
> +		return NULL;

So we will keep allocating single pages in dev->cma_area if it's
present, in order to address your previous concern?

Thanks
Nicolin
