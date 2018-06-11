Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48FD5C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8642208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y+z1IOsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8642208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933897AbeFKQvT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 12:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeFKQvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:51:18 -0400
Received: from sstabellini-thinkpad-x260.xlnx.xilinx.com (unknown [149.199.62.254])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 882B6208BA;
        Mon, 11 Jun 2018 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528735877;
        bh=0dDIinIl6hUOug5XyDgYLAMb3+wKf+NLbRvD5YfJD4U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=y+z1IOsn6iUOe6GlF+6ByxdZ279pk2wJx7rAMQ2a8ZhwUz4gP5go8gTjfD0GlTQZx
         uB+bLJon3bu2+eWV+jXFnVI001V4BwMe7xpkUauajukMT2gFRVHXZaduAhMjrN4Wwj
         qYIBZ1ZWhOWRuA7ltYI/MmBwwBRUdHOeMBJQHypE=
Date:   Mon, 11 Jun 2018 09:51:13 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To:     Oleksandr Andrushchenko <andr2000@gmail.com>
cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com, daniel.vetter@intel.com,
        matthew.d.roper@intel.com, dongwon.kim@intel.com,
        julien.grall@arm.com
Subject: Re: [Xen-devel] [PATCH v2 5/9] xen/gntdev: Allow mappings for DMA
 buffers
In-Reply-To: <06eff3fe-3ffc-47f6-6bd6-d8f2f823b382@gmail.com>
Message-ID: <alpine.DEB.2.10.1806110949050.14695@sstabellini-ThinkPad-X260>
References: <20180601114132.22596-1-andr2000@gmail.com> <20180601114132.22596-6-andr2000@gmail.com> <64facf05-0a51-c3d9-9d3b-780893248628@oracle.com> <84217eac-b83b-710f-39ab-c93cad65bf9a@gmail.com> <a172746d-7a97-159f-71a7-511b2d239089@oracle.com>
 <30fa03c0-1b75-c0b1-b14f-8b52ea584e20@gmail.com> <78dc2fc4-cdac-05b7-2c34-22b69e7e009c@oracle.com> <4be24882-185d-01e3-6aa1-751e341433c7@gmail.com> <alpine.DEB.2.10.1806081025030.14699@sstabellini-ThinkPad-X260> <c6e1820a-fb57-b213-aa2f-05787dae06ad@oracle.com>
 <06eff3fe-3ffc-47f6-6bd6-d8f2f823b382@gmail.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-656447964-1528735873=:14695"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-656447964-1528735873=:14695
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 Jun 2018, Oleksandr Andrushchenko wrote:
> On 06/08/2018 10:21 PM, Boris Ostrovsky wrote:
> > On 06/08/2018 01:59 PM, Stefano Stabellini wrote:
> > > > > > > > > >      @@ -325,6 +401,14 @@ static int map_grant_pages(struct
> > > > > > > > > > grant_map
> > > > > > > > > > *map)
> > > > > > > > > >              map->unmap_ops[i].handle =
> > > > > > > > > > map->map_ops[i].handle;
> > > > > > > > > >              if (use_ptemod)
> > > > > > > > > >                  map->kunmap_ops[i].handle =
> > > > > > > > > > map->kmap_ops[i].handle;
> > > > > > > > > > +#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
> > > > > > > > > > +        else if (map->dma_vaddr) {
> > > > > > > > > > +            unsigned long mfn;
> > > > > > > > > > +
> > > > > > > > > > +            mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
> > > > > > > > > Not pfn_to_mfn()?
> > > > > > > > I'd love to, but pfn_to_mfn is only defined for x86, not ARM:
> > > > > > > > [1]
> > > > > > > > and [2]
> > > > > > > > Thus,
> > > > > > > > 
> > > > > > > > drivers/xen/gntdev.c:408:10: error: implicit declaration of
> > > > > > > > function
> > > > > > > > ‘pfn_to_mfn’ [-Werror=implicit-function-declaration]
> > > > > > > >        mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
> > > > > > > > 
> > > > > > > > So, I'll keep __pfn_to_mfn
> > > > > > > How will this work on non-PV x86?
> > > > > > So, you mean I need:
> > > > > > #ifdef CONFIG_X86
> > > > > > mfn = pfn_to_mfn(page_to_pfn(map->pages[i]));
> > > > > > #else
> > > > > > mfn = __pfn_to_mfn(page_to_pfn(map->pages[i]));
> > > > > > #endif
> > > > > > 
> > > > > I'd rather fix it in ARM code. Stefano, why does ARM uses the
> > > > > underscored version?
> > > > Do you want me to add one more patch for ARM to wrap __pfn_to_mfn
> > > > with static inline for ARM? e.g.
> > > > static inline ...pfn_to_mfn(...)
> > > > {
> > > >      __pfn_to_mfn();
> > > > }
> > > A Xen on ARM guest doesn't actually know the mfns behind its own
> > > pseudo-physical pages. This is why we stopped using pfn_to_mfn and
> > > started using pfn_to_bfn instead, which will generally return "pfn",
> > > unless the page is a foreign grant. See include/xen/arm/page.h.
> > > pfn_to_bfn was also introduced on x86. For example, see the usage of
> > > pfn_to_bfn in drivers/xen/swiotlb-xen.c. Otherwise, if you don't care
> > > about other mapped grants, you can just use pfn_to_gfn, that always
> > > returns pfn.
> > 
> > I think then this code needs to use pfn_to_bfn().
> Ok
> > 
> > 
> > > Also, for your information, we support different page granularities in
> > > Linux as a Xen guest, see the comment at include/xen/arm/page.h:
> > > 
> > >    /*
> > >     * The pseudo-physical frame (pfn) used in all the helpers is always
> > > based
> > >     * on Xen page granularity (i.e 4KB).
> > >     *
> > >     * A Linux page may be split across multiple non-contiguous Xen page so
> > > we
> > >     * have to keep track with frame based on 4KB page granularity.
> > >     *
> > >     * PV drivers should never make a direct usage of those helpers
> > > (particularly
> > >     * pfn_to_gfn and gfn_to_pfn).
> > >     */
> > > 
> > > A Linux page could be 64K, but a Xen page is always 4K. A granted page
> > > is also 4K. We have helpers to take into account the offsets to map
> > > multiple Xen grants in a single Linux page, see for example
> > > drivers/xen/grant-table.c:gnttab_foreach_grant. Most PV drivers have
> > > been converted to be able to work with 64K pages correctly, but if I
> > > remember correctly gntdev.c is the only remaining driver that doesn't
> > > support 64K pages yet, so you don't have to deal with it if you don't
> > > want to.
> > 
> > I believe somewhere in this series there is a test for PAGE_SIZE vs.
> > XEN_PAGE_SIZE. Right, Oleksandr?
> Not in gntdev. You might have seen this in xen-drmfront/xen-sndfront,
> but I didn't touch gntdev for that. Do you want me to add yet another patch
> in the series to check for that?

gntdev.c is already not capable of handling PAGE_SIZE != XEN_PAGE_SIZE,
so you are not going to break anything that is not already broken :-) If
your new gntdev.c code relies on PAGE_SIZE == XEN_PAGE_SIZE, it might be
good to add an in-code comment about it, just to make it easier to fix
the whole of gntdev.c in the future.



> > Thanks for the explanation.

--8323329-656447964-1528735873=:14695--
