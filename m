Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B81FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7C3214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="DpcFu3fP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbeLQT4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:56:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45107 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387549AbeLQT4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:56:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so13333917ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rY3JHuP97CIYyZS4kuijAocWK9rgl4HZoG3hE9ljoy4=;
        b=DpcFu3fPFYCoR7KCeCGkEDXgKx/sFQOT3oo7iCWH/D9Ax2/dYvX4Gl4bX59DFfC8/k
         s/oRNparh/q0PB/2u+148NRtj+6SWogSEShn6LhLy1DIxXBTKZxwakUMynosV5srjQGe
         2gucRtGN9tkflEBHQtByPfsP2wZNSzSWE795axNwlam/LKyJyFR3Fq1QwNeFGJEFaQdK
         cmv5qpz96tYVmbNR4sgystRwThHyB/5V6uRqz8aeXro3j7htNNRoIiKbpyU31ek0AGzl
         tD3DFTulA/5QIKgavwAEFtpp0wnJsCq6+flx2rxZyFFiwyD/Uas/kOIZ0E5c9sRLw8yg
         GY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rY3JHuP97CIYyZS4kuijAocWK9rgl4HZoG3hE9ljoy4=;
        b=rdQ4kxci9Cl+muiDowCojxUMbrPm/RvWuC2G4x7a+Sm+ZLXb9+XIZOhlp5pCR9ORT8
         nlhqqx+HHbGM7i1qW5RVam5tBLGPeJrbSG75iBBbvasetgYc9r2fzJwb25eFMDVIpFmP
         rRIjSVAGeV6zLms4SiJF0B532aOcFyfKtohhKBHfKvy1X4kqxZBmCcfBpfTjxT7lu72f
         Ore9bKDtvuhJlwRGP5U5U0AzmwnlqUOc5EqYqs4DMDLKAWPAw+1seH1GalwYNabtABWt
         jFHEDpyHoGVcoO9YjaBBn30DJffdnXXvT3G16QFYyfNfhPEp5Xnm6UbwNnmeYChkGJU+
         vA+A==
X-Gm-Message-State: AA+aEWYI71O0WykVKXXCGEPPISFTXnx2uo+NML40S60ApZwlHEpa2jmc
        5LnMy12D1pLNLa0Dm7SQPh0AdhowctanG9WUhL3qtQ==
X-Google-Smtp-Source: AFSGD/U9/klKnGqvw8nEuWdud3OYFFCP6X9Z/L/sDYP/J0IaHgQC7IsQSZaTSGAdXUqaFTBo/bnSkQP6icO07BLF7rM=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr10562963oti.367.1545076608698;
 Mon, 17 Dec 2018 11:56:48 -0800 (PST)
MIME-Version: 1.0
References: <154483851047.1672629.15001135860756738866.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154483852617.1672629.2068988045031389440.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181216124335.GB30212@rapoport-lnx>
In-Reply-To: <20181216124335.GB30212@rapoport-lnx>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Dec 2018 11:56:36 -0800
Message-ID: <CAPcyv4hXPm4GnBheTZ5WN6s5Kiw02MW1aWA-s2qC8BqfthT3Yg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 4:43 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> On Fri, Dec 14, 2018 at 05:48:46PM -0800, Dan Williams wrote:
> > Randomization of the page allocator improves the average utilization of
> > a direct-mapped memory-side-cache. Memory side caching is a platform
> > capability that Linux has been previously exposed to in HPC
> > (high-performance computing) environments on specialty platforms. In
> > that instance it was a smaller pool of high-bandwidth-memory relative to
> > higher-capacity / lower-bandwidth DRAM. Now, this capability is going to
> > be found on general purpose server platforms where DRAM is a cache in
> > front of higher latency persistent memory [1].
[..]
> > diff --git a/mm/memblock.c b/mm/memblock.c
> > index 185bfd4e87bb..fd617928ccc1 100644
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -834,8 +834,16 @@ int __init_memblock memblock_set_sidecache(phys_addr_t base, phys_addr_t size,
> >               return ret;
> >
> >       for (i = start_rgn; i < end_rgn; i++) {
> > -             type->regions[i].cache_size = cache_size;
> > -             type->regions[i].direct_mapped = direct_mapped;
> > +             struct memblock_region *r = &type->regions[i];
> > +
> > +             r->cache_size = cache_size;
> > +             r->direct_mapped = direct_mapped;
>
> I think this change can be merged into the previous patch

Ok, will do.

> > +             /*
> > +              * Enable randomization for amortizing direct-mapped
> > +              * memory-side-cache conflicts.
> > +              */
> > +             if (r->size > r->cache_size && r->direct_mapped)
> > +                     page_alloc_shuffle_enable();
>
> It seems that this is the only use for ->direct_mapped in the memblock
> code. Wouldn't cache_size != 0 suffice? I.e., in the code that sets the
> memblock region attributes, the cache_size can be set to 0 for the non
> direct mapped caches, isn't it?
>

The HMAT specification allows for other cache-topologies, so it's not
sufficient to just look for non-zero size when a platform implements a
set-associative cache. The expectation is that a set-associative cache
would not need the kernel to perform memory randomization to improve
the cache utilization.

The check for memory size > cache-size is a sanity check for a
platform BIOS or system configuration that mis-reports or mis-sizes
the cache.
