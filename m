Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9833FC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5720844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxKBNGOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfBEXFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:05:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40871 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfBEXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:05:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so2201218pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 15:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bshcj/0aop620Esry/+5mJnI36SaGTnpPPHRK5JdXfI=;
        b=GxKBNGOhMUxtC1/6wwa2jJSLIlUXaLjgWkHj7KlRZFHb/SW6AkiPbgZPaNY9eDokek
         af80UkaMjlSHl/E+h6EhNLEe76fm0LSiZUUDwjLwXY4AiujUdqznYeM+vEdn6aWzLAE4
         /fNQgfK6V6d67Zbx8JFyNCenHBQYS0JU8gZMWYwf7lRTl1VQuohdGYi1lo3Rd0dTnFH5
         0gbMg2d+WPrCAqMcicnBUKDE61dx3QMBR0Zmw4mD1wVewmIJGltxGrR0kqvMEaZOiqxD
         2+mZpveNufQGEKdiTxbPs7S8kygee2fiH8Ski6b3/xsX9B4fPg6FrJQOr57ekqrxbPm9
         5oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bshcj/0aop620Esry/+5mJnI36SaGTnpPPHRK5JdXfI=;
        b=AtpVJkaMtqTPl+r7YpzHyN3zs6eWV4GF/wRJ+98cL5fPLzqIvEzIHve/y1HMUakfFA
         M1gwDznnVSrVZaAhw4M2CdwS6fquEEVJMkyXyeX7qFxDY3LwDVAfWI4lO5FHbv95bbpb
         jazc8rnkJc08MTfH43rLor3bdw00a/3hNMlsASqy7miZLQkXXTfOM1ew5xKWJR7Co4CZ
         p4RK8hNdJe7uXMB8Ac+RhzI9OWYldIHxJ8KSIc68YViO2VeZFKXetKzklYscgrP2Rm13
         jQTdkJJwvBStitTTyRW5lOOh1+qZKF65zqm17aKLJ7Oa2/QixrEtPKcJGOgDpJSND1fI
         b4Yg==
X-Gm-Message-State: AHQUAuZXln8j4Gwz6PPmdut1aZw/aRsWUOXsbhaKfWgL/QaE3shmY86U
        ONCtplIDcASpAw1uVHu4t44=
X-Google-Smtp-Source: AHgI3IYn1wSwjRIYsaW9yYtIdPW2sGlUMFFRfTRqzZj37i2nFTcGG9+bCvydyLML8+LZ5nK5WhyBzg==
X-Received: by 2002:a65:6110:: with SMTP id z16mr6834607pgu.330.1549407935232;
        Tue, 05 Feb 2019 15:05:35 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w185sm5917312pfb.135.2019.02.05.15.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 15:05:35 -0800 (PST)
Date:   Tue, 5 Feb 2019 15:05:30 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     m.szyprowski@samsung.com, robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20190205230514.GA21515@Asurada-Nvidia.nvidia.com>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com>
 <20190204082307.GA5916@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204082307.GA5916@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Mon, Feb 04, 2019 at 09:23:07AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 15, 2019 at 01:51:40PM -0800, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to allocate one single page from CMA area. Since
> > the CMA area has a limited predefined size of space, it might run
> > out of space in some heavy use case, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > This patch tries to skip CMA allocations of single pages and lets
> > them go through normal page allocations unless the allocation has
> > a DMA_ATTR_FORCE_CONTIGUOUS attribute. This'd save some resources
> > in the CMA area for further more CMA allocations, and it can also
> > reduce CMA fragmentations resulted from trivial allocations.
> 
> That DMA_ATTR_FORCE_CONTIGUOUS flag does not make sense.  A single
> page allocation is per defintion always contigous.
> 
> >  again:
> > -	/* CMA can be used only in the context which permits sleeping */
> > -	if (gfpflags_allow_blocking(gfp)) {
> > +	/*
> > +	 * CMA can be used only in the context which permits sleeping.
> > +	 * Since addresses within one PAGE are always contiguous, skip
> > +	 * CMA allocation for a single page to save CMA reserved space
> > +	 * unless DMA_ATTR_FORCE_CONTIGUOUS is flagged.
> > +	 */
> > +	if (gfpflags_allow_blocking(gfp) &&
> > +	    (count > 1 || attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {
> 
> And my other concern is that this skips allocating from the per-device
> pool, which drivers might rely on.

Actually Robin had the same concern at v1 and suggested that we could
always use DMA_ATTR_FORCE_CONTIGUOUS to enforce into per-device pool.

> To be honest I'm not sure there is
> much of a point in the per-device CMA pool vs the traditional per-device
> coherent pool, but I'd rather change that behavior in a clearly documented
> commit with intentions rather as a side effect from a random optimization.

Hmm..sorry, I don't really follow this suggestion. Is it possible for
you to make it clear that what should I do for the change?

Thanks
Nicolin
