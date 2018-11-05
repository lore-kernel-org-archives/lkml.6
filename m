Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9562081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A38MavTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9562081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbeKFILK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:11:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34947 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbeKFILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:11:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so2828389pff.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yBiEuib7sogivvLsa2U/l+lw9r7xdDHBtTHlME9ikow=;
        b=A38MavTAPXQtIUoTnZecI5coX0ekFG/3ZDTdhuVaPy6WlnGd6Byu3+eeiNJB00tMp/
         +dNBDcGOzZP/0YJA9ZZhiAoQ4Sy0tFcoTTJuEEtSzgOFmmRvpda54HswGYRKIkLSf2g/
         jurj6n6PPPDHIZqRGOT8egg1eaeaCoHbdQj/e+a34rjzEXFsr7DOmqUlBlbv7iz13IFC
         DAq46TCiC1Z6w9crj8E4fczvLa5czfeJBiA2+mcB0t4LKnVvUVFuRTUHfywlBJukgpMy
         gGga7TIA7ctAfiVjtSW8PJJ0ZYGBzyFps4/JgM46RBWH+ZCuDhZXplUmRVewhji2Krns
         Z9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yBiEuib7sogivvLsa2U/l+lw9r7xdDHBtTHlME9ikow=;
        b=H2ZxjtUKl5SaOewN+FkUD9cx63oVjShFWKHKDHKXsB3KSronqVejJ8c/ttVDilccH9
         TMM50XXk2Zo+ZlLZoViBDa2xLbEQLAq8KXv/GRuUti13y1epMuP3t3fkk4aJ+dfPB0Ju
         Ct+b2XsHOVETxicFTaYURmkmPbxNCaLBF8eHIoROFvRpyoR2zUjQGOeJPQpCPUrK1geS
         IrWTBu6oNc7rqZjyyFlAx2iTEs5kEHdeIU6AIgNuN3rOsZ+INBeY5GWhOWRv88h4cY/P
         cEF2IcJHbeaBZegu/UK5fOS26FzF/3yZJ2si+jqtwtiR8rsd1noRdeyDFZOu4Y6kybqW
         w9Pg==
X-Gm-Message-State: AGRZ1gKU2Yyk9PP041rxvL9EWA18ydv7eDLd4ug4ggB0+LrwTK4EcQIB
        tYqQnqMQF7r9bKCoKGN+XtE=
X-Google-Smtp-Source: AJdET5fW8yMom71WKsSAp0en/+h1r4Q0euEWlt4cSJemilYouVFr1+GKUXKgwooEGwXX7MM/izQqtA==
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr23464999pfq.227.1541457656159;
        Mon, 05 Nov 2018 14:40:56 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 64-v6sm53777865pgb.74.2018.11.05.14.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:40:55 -0800 (PST)
Date:   Mon, 5 Nov 2018 14:40:51 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com>
 <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com>
 <20181102063542.GA17073@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102063542.GA17073@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 07:35:42AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 01, 2018 at 02:07:55PM +0000, Robin Murphy wrote:
> > On 31/10/2018 20:03, Nicolin Chen wrote:
> >> The addresses within a single page are always contiguous, so it's
> >> not so necessary to allocate one single page from CMA area. Since
> >> the CMA area has a limited predefined size of space, it might run
> >> out of space in some heavy use case, where there might be quite a
> >> lot CMA pages being allocated for single pages.
> >>
> >> This patch tries to skip CMA allocations of single pages and lets
> >> them go through normal page allocations. This would save resource
> >> in the CMA area for further more CMA allocations.
> >
> > In general, this seems to make sense to me. It does represent a theoretical 
> > change in behaviour for devices which have their own CMA area somewhere 
> > other than kernel memory, and only ever make non-atomic allocations, but 
> > I'm not sure whether that's a realistic or common enough case to really 
> > worry about.
> 
> Yes, I think we should make the decision in dma_alloc_from_contiguous
> based on having a per-dev CMA area or not.  There is a lot of cruft in

It seems that cma_alloc() already has a CMA area check? Would it
be duplicated to have a similar one in dma_alloc_from_contiguous?

> this area that should be cleaned up while we're at it, like always
> falling back to the normal page allocator if there is no CMA area or
> nothing suitable found in dma_alloc_from_contiguous instead of
> having to duplicate all that in the caller.

Am I supposed to clean up things that's mentioned above by moving
the fallback allocator into dma_alloc_from_contiguous, or to just
move my change (the count check) into dma_alloc_from_contiguous?

I understand that'd be great to have a cleanup, yet feel it could
be done separately as this patch isn't really a cleanup change.

Thanks
Nicolin
