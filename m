Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55940C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E972080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7M6xUjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E972080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbeKTNGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:06:01 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46831 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbeKTNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:06:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so190409pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QSg6wIL/+JUnvPO7f6t5QZS9u3YWUSObzoGbeHxdaTM=;
        b=k7M6xUjl96jrPdipm+rrRtJgVEDVfNXO2eGazSdQZ/B3hxLwxDWVGIFqAp47D73oz5
         et8FEAtfkCnTT+H4W2xagDk+JP9wx9k8AxcDrsguke/0prgTGzUgXtApUb6jQoolmIWH
         WnaVr8m7anEEFBuZoXSk6NWlQZNAM7RsboPrHGY+Y6O0/8gYduCCHXGzqOt7H/hINhh9
         ZWmWfItYprzC87zxs4U+Nq3tcQ+poTJk7Gjktu6f2Uf7CID7b8tn1bI59m4hxxNSE6Qh
         yoFeoDcwi7uKzRqjZefsiKr6OMEjiFTbYw0hfpI97rBd3/D9h1gxeIOM8Dp+A7SDbOIo
         PouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QSg6wIL/+JUnvPO7f6t5QZS9u3YWUSObzoGbeHxdaTM=;
        b=LxiVa7HrBjzm70U4Cn8hpI4eD4iNP0Agc6L7vvT/nqrkKWusfXRbINOpiq+GtQ5HZf
         egYopC5krNuMbWdZgAHyPPp5H+jJEG582NUpBNHycnyO/6ofU4BCzf1BfULXsTlgJrSf
         p3GcUrBIRP5HCbC+1GxedgoVF4NXbrGosweISeXbbYVw3jrMVb4BX3ITyJapb2jBgDrb
         3hVZpZgmHe3Xu5kZaKL1c8K8PcR9oWE4mUhlcSZqXUsVddK/3/14NrAkBj6OcTXsCDfF
         7jTHZy0yzZqw+RXMm0z0IIPilleEEi/Jkdrvh7TapIYB+iTHvdbwCIyGmv49JDM7X6lY
         Lf9g==
X-Gm-Message-State: AA+aEWb8YTz8TSQu3mskyIobB4QmmUKOwuyVZ02yEDx99EzDOt8cuwBB
        b25C1bT+ohn8pLwU3f2Fxr4=
X-Google-Smtp-Source: AFSGD/WsVkjhpF5bYqZz1EwIwnzU4dDSx6kWwu5X7Dq97MmXjV9+E9zPS0k3ekv4dg3cwdiUhc2d1A==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr205430pgl.127.1542681552937;
        Mon, 19 Nov 2018 18:39:12 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f64sm83664046pfh.0.2018.11.19.18.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 18:39:12 -0800 (PST)
Date:   Mon, 19 Nov 2018 18:39:08 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181120023907.GA27021@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181102063542.GA17073@lst.de>
 <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin? Christ?

On Mon, Nov 05, 2018 at 02:40:50PM -0800, Nicolin Chen wrote:
> On Fri, Nov 02, 2018 at 07:35:42AM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> > > On 31/10/2018 20:03, Nicolin Chen wrote:
> > >> The addresses within a single page are always contiguous, so it's
> > >> not so necessary to allocate one single page from CMA area. Since
> > >> the CMA area has a limited predefined size of space, it might run
> > >> out of space in some heavy use case, where there might be quite a
> > >> lot CMA pages being allocated for single pages.
> > >>
> > >> This patch tries to skip CMA allocations of single pages and lets
> > >> them go through normal page allocations. This would save resource
> > >> in the CMA area for further more CMA allocations.
> > >
> > > In general, this seems to make sense to me. It does represent a theoretical 
> > > change in behaviour for devices which have their own CMA area somewhere 
> > > other than kernel memory, and only ever make non-atomic allocations, but 
> > > I'm not sure whether that's a realistic or common enough case to really 
> > > worry about.
> > 
> > Yes, I think we should make the decision in dma_alloc_from_contiguous
> > based on having a per-dev CMA area or not.  There is a lot of cruft in
> 
> It seems that cma_alloc() already has a CMA area check? Would it
> be duplicated to have a similar one in dma_alloc_from_contiguous?
> 
> > this area that should be cleaned up while we're at it, like always
> > falling back to the normal page allocator if there is no CMA area or
> > nothing suitable found in dma_alloc_from_contiguous instead of
> > having to duplicate all that in the caller.
> 
> Am I supposed to clean up things that's mentioned above by moving
> the fallback allocator into dma_alloc_from_contiguous, or to just
> move my change (the count check) into dma_alloc_from_contiguous?
> 
> I understand that'd be great to have a cleanup, yet feel it could
> be done separately as this patch isn't really a cleanup change.
> 
> Thanks
> Nicolin
