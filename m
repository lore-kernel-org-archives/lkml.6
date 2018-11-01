Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D43C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCAF205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryhIDcKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCAF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbeKBF0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:26:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36780 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKBF0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:26:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so9549368pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gSurDRYkvdTCg5swseyrJHrzViD1QpozUgc/rwT7xfI=;
        b=ryhIDcKKer3hQ54CA97/JEjKZ01e5rnpI4Le5IaQUPjeUg0EY4sSshaYTtoYQcVEpM
         36CvZiN4W3FaMelzYdPLs9Tk4UWdvuUh7nrs08sXmpnis9/msIHemKu2RAHfnKaNsBe1
         vbFnXVAnBEFJmSCTawSJI4mWxvTmOMjSLrhpLRTATHl4khFusB2AS3KTYpzK30P0Wmca
         Qvv+r4GMlpaTIT+Tj5R/tvsCAoSJDCgAt3dM7WtGyojRxnsc/MHFo+ubTjFfL3n5e+aN
         3x8m0LCIG1hkyX234S0AjM3f7YvKiS/0jm/kvSTSX8oFI/9Dk+Qhrkjohsaohvi+nI52
         5yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gSurDRYkvdTCg5swseyrJHrzViD1QpozUgc/rwT7xfI=;
        b=cKThM9Q30ylFltj737zxABJNl3y03iPZVOM5XqVbxA0nGiiiokHREuN8Zd8liOdSwA
         rz35MA3BEeNicItBIAyaqq4hAxa39+927Zhm4FUh35WcaCTs93fVgk0Cqa1ligQMfg5L
         G+U7YkSaqjmiiudfy0CjoVzg8XaCd/ErPWHW6/8izMMZn/hMUVUX7TamunABpSXLbnif
         43tyexUmpkaz4oXY8r6Wdz0DQtHsy8FNwIIDQb8z2cGzHLPSq/YryZoIv7O+568jApzY
         O5GE0scsHq9L/IUjxAY1RcMDWOx4QdyVdWZE1bSoZxPS4ZCWERzib9uFvGbusPnsb27F
         fA6w==
X-Gm-Message-State: AGRZ1gKmOi1pcI3sAG5/3DaSA9/14dG25GvC8HqMvsF+IeyKzGShS94Z
        B3ropg5XXtB7OcW0I4kTPnINoVwt
X-Google-Smtp-Source: AJdET5f/xoh5xAQg4urIgJivhdKsYRsBur58CDqn78PbgBGpjHFkq9AxrJCMpzYf/jaDXcUwfKstpg==
X-Received: by 2002:a62:250:: with SMTP id 77-v6mr9350243pfc.16.1541103725655;
        Thu, 01 Nov 2018 13:22:05 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w2-v6sm30230620pfw.26.2018.11.01.13.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 13:22:05 -0700 (PDT)
Date:   Thu, 1 Nov 2018 13:22:01 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181101202200.GA30950@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181101180439.GA4746@Asurada-Nvidia.nvidia.com>
 <58e3d16e-837c-0610-9e1c-0562babcdd82@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e3d16e-837c-0610-9e1c-0562babcdd82@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 07:32:39PM +0000, Robin Murphy wrote:

> > On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> > > On 31/10/2018 20:03, Nicolin Chen wrote:
> > > > The addresses within a single page are always contiguous, so it's
> > > > not so necessary to allocate one single page from CMA area. Since
> > > > the CMA area has a limited predefined size of space, it might run
> > > > out of space in some heavy use case, where there might be quite a
> > > > lot CMA pages being allocated for single pages.
> > > > 
> > > > This patch tries to skip CMA allocations of single pages and lets
> > > > them go through normal page allocations. This would save resource
> > > > in the CMA area for further more CMA allocations.
> > > 
> > > In general, this seems to make sense to me. It does represent a theoretical
> > > change in behaviour for devices which have their own CMA area somewhere
> > > other than kernel memory, and only ever make non-atomic allocations, but I'm
> > > not sure whether that's a realistic or common enough case to really worry
> > > about.
> > 
> > Hmm..I don't quite understand the part of worrying its realisticness.
> > Would you mind elaborating a bit?
> 
> I only mean the case where a driver previously happened to get single pages
> allocated from a per-device CMA area, would now always get them fulfilled
> from regular kernel memory instead, and actually cares about the difference.

I see. I think that's a good question.

> As I say, that's a contrived case that I doubt is honestly a significant
> concern, but it's not *entirely* inconceivable. I've just been bitten before
> by drivers relying on specific DMA API implementation behaviour which was
> never guaranteed or even necessarily correct by the terms of the API itself,
> so I'm naturally wary of the corner cases ;)

I also have a vague concern that CMA pages might turn out to be
special so this change would make some differences in stability
or performance for those who actually rely on actual CMA pages,
though I ain't sure if it can be true or realistic as you said.

> On second thought, however, I suppose we could always key this off
> DMA_ATTR_FORCE_CONTIGUOUS as well if we really want - technically it has a
> more general meaning than "only ever allocate from CMA", but in practice if
> that's the behaviour a driver wants, then that flag is already the only way
> it can even hope to get dma_alloc_coherent() to comply anywhere near
> reliably.

That is a good input. Would you prefer to have it in condition
check now with this patch?

> > As I tested this change on Tegra186
> > board, and saw some single-page allocations have been directed to the
> > normal allocation; and the "CmaFree" size reported from /proc/meminfo
> > is also increased. Does this mean it's realistic?
> 
> Indeed - I happen to have CMA debug enabled for no good reason in my current
> development config, and on my relatively unexciting Juno board single-page
> allocations turn out to be the majority by number, even if not by total
> consumption:
> 
> [    0.519663] cma: cma_alloc(cma (____ptrval____), count 64, align 6)
> [    0.527508] cma: cma_alloc(): returned (____ptrval____)
> [    3.768066] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    3.774566] cma: cma_alloc(): returned (____ptrval____)
> [    3.860097] cma: cma_alloc(cma (____ptrval____), count 1875, align 8)
> [    3.867150] cma: cma_alloc(): returned (____ptrval____)
> [    3.920796] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
> [    3.927093] cma: cma_alloc(): returned (____ptrval____)
> [    3.932326] cma: cma_alloc(cma (____ptrval____), count 31, align 5)
> [    3.938643] cma: cma_alloc(): returned (____ptrval____)
> [    4.022188] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.028415] cma: cma_alloc(): returned (____ptrval____)
> [    4.033600] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.039786] cma: cma_alloc(): returned (____ptrval____)
> [    4.044968] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.051150] cma: cma_alloc(): returned (____ptrval____)
> [    4.113556] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    4.119785] cma: cma_alloc(): returned (____ptrval____)
> [    5.012654] cma: cma_alloc(cma (____ptrval____), count 1, align 0)
> [    5.019047] cma: cma_alloc(): returned (____ptrval____)
> [   11.485179] cma: cma_alloc(cma 000000009dd074ee, count 1, align 0)
> [   11.492096] cma: cma_alloc(): returned 000000009264a86c
> [   12.269355] cma: cma_alloc(cma 000000009dd074ee, count 1875, align 8)
> [   12.277535] cma: cma_alloc(): returned 00000000d7bb9ae5
> [   12.286110] cma: cma_alloc(cma 000000009dd074ee, count 4, align 2)
> [   12.292507] cma: cma_alloc(): returned 0000000007ba7a39
> 
> I don't have any exciting peripherals to really exercise the coherent
> allocator, but I imagine that fragmentation is probably just as good a
> reason as total CMA usage for avoiding trivial allocations by default.

I will also add to the commit message fragmentation reduction.

Thanks
Nicolin
