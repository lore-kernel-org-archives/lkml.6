Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68306C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C5E20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjlGccw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C5E20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbeKGJjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:39:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41297 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbeKGJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:39:42 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so967880pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cJCu+7aUf0R/Rv0CKQYOpWyS4v76zOkUkD/Ri1hUY3I=;
        b=fjlGccw5DvIZYAVAMXqzitItrIt4fULoX+E6RLf+YBOw/t+zJ1dIHNce9B5eW3aKLI
         eIKXoQkeyH8mqdpZ6MwRcKr/82KgPJhlhqh0CAync32QSnOmxFQ3uEniD3TCqNoUP3F7
         yAp2ph1FaRMqMjdK2IYWRzwcbdedJNTo0ybKQ8alcV3UIwN2MpVXFre0xQSWeqzkdFfw
         NW/7jb75maE7FF/9XtZTVk6Ns58e9higAoNzCsFOqXhsmXI5XGl3lo+myebQQNb4ACCW
         /3RiKePxMacuX7q7DQx66YYHNBPjFFKSM0AqRJdPZjWDWfk9v64I9SAqMCuyBABpN/L5
         HIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cJCu+7aUf0R/Rv0CKQYOpWyS4v76zOkUkD/Ri1hUY3I=;
        b=tLEKHNK7I8q0yU1FKD/WEWZ9jmnLcxyF8rh5BtZwZ756iT1bf2hChYY6u2vguyPWbw
         Zbh/cdC7zLN0Y7MVOK/Vr7VSrO2jOCX+ICwYxM1AV9BiCNOAyvsz/MOshHnF0K8OiF3y
         znv7FdR2grw90c1DyBl97JreHbakamY7JGJSAOpVNNtvbqYu+qo/xr8YzEfVj6uQfLx0
         l8IVDAkn4SY8jY8dVjfA7j0F6NCZy7xM1BDgny4LXs6x2tK4VuLnYURPh2blJvwUo1+z
         DqysCMXRc8YWCMZWCSc2mxax7Pg6ti3x8t6yGtb6BAiQBZkFuynO+B36Vsf/MB8qfnD5
         YYuw==
X-Gm-Message-State: AGRZ1gKfGuYt28jWjJzWMB121/Lj41AxAEIEKdAtI2sWrMXIxxNL3Elw
        X+h+pnllhEYYtFVjDbpkmGZlzoLQ
X-Google-Smtp-Source: AJdET5ciL/4adM/vQDA/GcYlVEUWzPnCAzevAjpMnZb7fPISeFZqWdMj0qQCvbDifflw+ObyOCNrZQ==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr25943710pgj.410.1541549511958;
        Tue, 06 Nov 2018 16:11:51 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id m5-v6sm59093996pfc.188.2018.11.06.16.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:11:51 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:11:49 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Zero pages manually in a length of scatterlist
Message-ID: <20181107001148.GB11429@Asurada-Nvidia.nvidia.com>
References: <20181101213500.21800-1-nicoleotsuka@gmail.com>
 <63184c22-4587-be2b-8089-d2e4e0b5482d@arm.com>
 <20181102233613.GA26856@Asurada-Nvidia.nvidia.com>
 <d232ee7a-40de-5b32-39ab-222b773e9bb2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d232ee7a-40de-5b32-39ab-222b773e9bb2@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, Nov 06, 2018 at 06:27:39PM +0000, Robin Murphy wrote:
> > I re-ran the test to get some accuracy within the function and got:
> > 1) pages = __iommu_dma_alloc_pages(count, alloc_sizes >> PAGE_SHIFT, gfp);
> >     // reduced from 422 usec to 56 usec == 366 usec less
> > 2) if (!(prot & IOMMU_CACHE)) {...}	//flush routine
> >     // reduced from 439 usec to 236 usec == 203 usec less
> > Note: new memset takes about 164 usec, resulting in 400 usec diff
> >        for the entire iommu_dma_alloc() function call.
> > 
> > It looks like this might be more than the diff between clear_page
> > and memset, and might be related to mapping and cache. Any idea?
> 
> Hmm, I guess it might not be so much clear_page() itself as all the gubbins
> involved in getting there from prep_new_page(). I could perhaps make some
> vague guesses about how the A57 cores might get tickled by the different
> code patterns, but the Denver cores are well beyond my ability to reason
> about. Out of even further curiosity, how does the quick hack below compare?

I tried out that change. And the results are as followings:
a. Routine (1) reduced from 422 usec to 55 usec
b. Routine (2) increased from 441 usec to 833 usec
c. Overall, it seems to remain the same: 900+ usec

> > > > @@ -581,6 +593,12 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
> > > >    	if (sg_alloc_table_from_pages(&sgt, pages, count, 0, size, GFP_KERNEL))
> > > >    		goto out_free_iova;
> > > > +	if (gfp_zero) {
> > > > +		/* Now zero all the pages in the scatterlist */
> > > > +		for_each_sg(sgt.sgl, s, sgt.orig_nents, i)
> > > > +			memset(sg_virt(s), 0, s->length);
> > > 
> > > What if the pages came from highmem? I know that doesn't happen on arm64
> > > today, but the point of this code *is* to be generic, and other users will
> > > arrive eventually.
> > 
> > Hmm, so it probably should use sg_miter_start/stop() too? Looking
> > at the flush routine doing in PAGE_SIZE for each iteration, would
> > be possible to map and memset contiguous pages together? Actually
> > the flush routine might be also optimized if we can map contiguous
> > pages.
> 
> I suppose the ideal point at which to do it would be after the remapping
> when we have the entire buffer contiguous in vmalloc space and can make best
> use of prefetchers etc. - DMA_ATTR_NO_KERNEL_MAPPING is a bit of a spanner
> in the works, but we could probably accommodate a special case for that. As
> Christoph points out, this isn't really the place to be looking for
> performance anyway (unless it's pathologically bad as per the

I would understand the point. So probably it'd be more plausible
to have the change if it reflects on some practical benchmark. I
might need to re-run some tests with heavier use cases.

> DMA_ATTR_ALLOC_SINGLE_PAGES fun), but if we're looking at pulling the
> remapping out of the arch code, maybe we could aim to rework the zeroing
> completely as part of that.

That'd be nice. I believe it'd be good to have.

Thanks
Nicolin
