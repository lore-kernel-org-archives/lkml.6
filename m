Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF5A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="u/yC0v5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388992AbeLQS2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:28:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41003 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeLQS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:28:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so10977998oii.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SsXqXT0kYcjwymwovEksFmKjGIpFl8BBUfL+y5p3vMw=;
        b=u/yC0v5j2MMU3QblcgxnTBiOZCwN9gLYlRBwrsM7KahF1+ZlFEnfrNvF984H8pa6RZ
         J+jzEAOzQUD+rqPfpu263VeEdzYcVmCDCrEo9tArYqGrizkdfuK7dzIYZG2Rd5aWJwrI
         rr+1P8VmqBblEYtayRakWiWq8/4lmzKT1eO9kgaFamZc9UMYiEMoNHH7frLBmhd3Dj0X
         k20WDEYf9lkjE8PosuEG1VxgSILY6GGMRIgKyDrw3bqZ53CJSnyOJoNwEtmilTwMmqiJ
         Em798cOmnoOw0wN9m+sPHWi9PIDLEzb8iVsdO/JgndjWEIVuSr6+VtCwP/gCCdBlxj+8
         Lm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsXqXT0kYcjwymwovEksFmKjGIpFl8BBUfL+y5p3vMw=;
        b=GHCMm/VMrLvEtMMfTR3vT6DvoF1kCui+xlV77t8NB3oHFwGy3JCV/csLTKDEmun+a8
         l9qz5ucXvmDQeH13vZz/g5/T/aLtWZ7way2507q1HC8s/U+cO6bKO4GHWfHWk7e7zk8b
         HdGFl0JrcGOFvT2sRv5zZN9TXO94lYwTZbHPMPXY/YWFVQqX2jwaf+y91q1P9Khc9dNg
         OxulmRiSQwueaW0i1CEE/mWjrV3ss0pokpfppSkpXAnpwVTCp9j+EQEk0huP7ekAeQGt
         QezDD1Wcjbs9Xw+7iaYAOMrTG/UaN4kHgQ6bu8CCIAnryy8swqabWKgwiQU7gAlx6A44
         lOUg==
X-Gm-Message-State: AA+aEWavJSO63+kHCyNT2HqJIlCGByXfawv1/8OuRUMzrj17AoSRwVah
        RAjszPK//ZCXHeIKWUkVdj+qkzYxCbOi/89P3d+KkA==
X-Google-Smtp-Source: AFSGD/XsqYy8sdukNmzV3NZhNOS+IIlNUuFlnc9F8RQILil+ON4vayGwxahXq1Q9e9RtOF9t2TLuDAbJnpqwN6Ae7r0=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr6284165oih.244.1545071295329;
 Mon, 17 Dec 2018 10:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20181208022445.GA7024@redhat.com> <20181210102846.GC29289@quack2.suse.cz>
 <20181212150319.GA3432@redhat.com> <20181212214641.GB29416@dastard>
 <20181212215931.GG5037@redhat.com> <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com> <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com> <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
 <20181217085653.GB28270@quack2.suse.cz>
In-Reply-To: <20181217085653.GB28270@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Dec 2018 10:28:03 -0800
Message-ID: <CAPcyv4jmg46s=7OJbR7iEpc0jxv+JG8vdS==yQeUgvjQm+_f4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>, david <david@fromorbit.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, tom@talpey.com,
        Al Viro <viro@zeniv.linux.org.uk>, benve@cisco.com,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        rcampbell@nvidia.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:57 AM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 14-12-18 11:38:59, Dan Williams wrote:
> > On Thu, Dec 13, 2018 at 10:11 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > >
> > > On 12/13/18 9:21 PM, Dan Williams wrote:
> > > > On Thu, Dec 13, 2018 at 7:53 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > > >>
> > > >> On 12/12/18 4:51 PM, Dave Chinner wrote:
> > > >>> On Wed, Dec 12, 2018 at 04:59:31PM -0500, Jerome Glisse wrote:
> > > >>>> On Thu, Dec 13, 2018 at 08:46:41AM +1100, Dave Chinner wrote:
> > > >>>>> On Wed, Dec 12, 2018 at 10:03:20AM -0500, Jerome Glisse wrote:
> > > >>>>>> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> > > >>>>>>> On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> > > >>>>>>> So this approach doesn't look like a win to me over using counter in struct
> > > >>>>>>> page and I'd rather try looking into squeezing HMM public page usage of
> > > >>>>>>> struct page so that we can fit that gup counter there as well. I know that
> > > >>>>>>> it may be easier said than done...
> > > >>>>>>
> > > >>
> > > >> Agreed. After all the discussion this week, I'm thinking that the original idea
> > > >> of a per-struct-page counter is better. Fortunately, we can do the moral equivalent
> > > >> of that, unless I'm overlooking something: Jerome had another proposal that he
> > > >> described, off-list, for doing that counting, and his idea avoids the problem of
> > > >> finding space in struct page. (And in fact, when I responded yesterday, I initially
> > > >> thought that's where he was going with this.)
> > > >>
> > > >> So how about this hybrid solution:
> > > >>
> > > >> 1. Stay with the basic RFC approach of using a per-page counter, but actually
> > > >> store the counter(s) in the mappings instead of the struct page. We can use
> > > >> !PageAnon and page_mapping to look up all the mappings, stash the dma_pinned_count
> > > >> there. So the total pinned count is scattered across mappings. Probably still need
> > > >> a PageDmaPinned bit.
> > > >
> > > > How do you safely look at page->mapping from the get_user_pages_fast()
> > > > path? You'll be racing invalidation disconnecting the page from the
> > > > mapping.
> > > >
> > >
> > > I don't have an answer for that, so maybe the page->mapping idea is dead already.
> > >
> > > So in that case, there is still one more way to do all of this, which is to
> > > combine ZONE_DEVICE, HMM, and gup/dma information in a per-page struct, and get
> > > there via basically page->private, more or less like this:
> >
> > If we're going to allocate something new out-of-line then maybe we
> > should go even further to allow for a page "proxy" object to front a
> > real struct page. This idea arose from Dave Hansen as I explained to
> > him the dax-reflink problem, and dovetails with Dave Chinner's
> > suggestion earlier in this thread for dax-reflink.
> >
> > Have get_user_pages() allocate a proxy object that gets passed around
> > to drivers. Something like a struct page pointer with bit 0 set. This
> > would add a conditional branch and pointer chase to many page
> > operations, like page_to_pfn(), I thought something like it would be
> > unacceptable a few years ago, but then HMM went and added similar
> > overhead to put_page() and nobody balked.
> >
> > This has the additional benefit of catching cases that might be doing
> > a get_page() on a get_user_pages() result and should instead switch to
> > a "ref_user_page()" (opposite of put_user_page()) as the API to take
> > additional references on a get_user_pages() result.
> >
> > page->index and page->mapping could be overridden by similar
> > attributes in the proxy, and allow an N:1 relationship of proxy
> > instances to actual pages. Filesystems could generate dynamic proxies
> > as well.
> >
> > The auxiliary information (dev_pagemap, hmm_data, etc...) moves to the
> > proxy and stops polluting the base struct page which remains the
> > canonical location for dirty-tracking and dma operations.
> >
> > The difficulties are reconciling the source of the proxies as both
> > get_user_pages() and filesystem may want to be the source of the
> > allocation. In the get_user_pages_fast() path we may not be able to
> > ask the filesystem for the proxy, at least not without destroying the
> > performance expectations of get_user_pages_fast().
>
> What you describe here sounds almost like page_ext mechanism we already
> have? Or do you really aim at per-pin allocated structure?

Per-pin or dynamically allocated by the filesystem. The existing
page_ext seems to suffer from the expectation that a page_ext exists
for all pfns. The 'struct page' per pfn requirement is already painful
as memory capacities grow into the terabytes, page_ext seems to just
make that worse.
