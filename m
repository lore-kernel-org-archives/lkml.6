Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1CCC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1982720870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="T9D0RHFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982720870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbeLLQ1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:27:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40138 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQ1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:27:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id t204so15491495oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB2+TJh0pJ/UBt7pYWXtuO/uB7bbdj2hvw8dOBpZM4I=;
        b=T9D0RHFjWPwvNT2p3fo4w1GRWvbv62FaQUc+FY5mVN+eGrMesKTwqX9xllaS2I2bEv
         7bmv3gUwB4VeLcJSatzkxxDxRU8AMtubzRcaHUtqu+G1wPXHGu7ttxFAhj0a8WqnDNcs
         jjZMO+9Or4IZRaX4m04mzAzCWkJnWbMROLHX+3MpfVmKQE2ZCU1xjUSrL2zZxRuj2u7S
         PKXp86HWlWAyb/Aml6h2kTsN6yR4orPwDhoKDWhXfn7GlnccX3PTzt++zZWvRfynGXfn
         QA5ChjG0C0AZL48fHIjkSexcyUco+pw5Tp2+Flh8rnpR2iICf0MM8Md9UEpesx5IhzTu
         KNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB2+TJh0pJ/UBt7pYWXtuO/uB7bbdj2hvw8dOBpZM4I=;
        b=aFLbtas+WAGYR4UJf4zCb4WfjyX2IciPqrinFvvEuJUmNMU34CyvCIExd2ctgGpe5m
         E2EvbIzR8YZYZO/wa3G9AOLQZwKpqdGFOHb8JEI0jO5+chPPStft/l06ezwL0IoV9oKu
         pn9/OocV9DFPg/KxZOoiVG44IZA5yBhwrT8eEUYK7r/ZRqRKkyGvdJuqD+TZ1+XWXKQW
         zVV8bNuqEFVpt4m0qYzTCbKNTPLL6epQq9/Y9NNmwLXuMsUvx5sCkFo0cyzN4AeBUeTD
         +cES3mUaV9aoUcDB9JITy4Xhdky3a/36i1ZKBy74h8gNsgEd3xWYSAjrqsn1ae2P3ldA
         F43g==
X-Gm-Message-State: AA+aEWa8uKZaB0HMIWfH2IFViQUVD9MfATRM1rH2rQVO72A95EaUJBxP
        RVd8oADTVNBcpExYte/2gomwhAZUCec10AjLTJAq3w==
X-Google-Smtp-Source: AFSGD/V8g+Qw3VtQpCx3qaRerDOq2uqe7jEPoeEnHkR0+ZPei6KBH0rYicVuUbnBtWMica76wYcHUxTHsixrTvXpFyc=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr744022oit.235.1544632067228;
 Wed, 12 Dec 2018 08:27:47 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4iNtamDAY9raab=iXhSZByecedBpnGybjLM+PuDMwq7SQ@mail.gmail.com>
 <3c91d335-921c-4704-d159-2975ff3a5f20@nvidia.com> <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com> <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz> <20181212150319.GA3432@redhat.com>
In-Reply-To: <20181212150319.GA3432@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Dec 2018 08:27:35 -0800
Message-ID: <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 7:03 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> > On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> > > Another crazy idea, why not treating GUP as another mapping of the page
> > > and caller of GUP would have to provide either a fake anon_vma struct or
> > > a fake vma struct (or both for PRIVATE mapping of a file where you can
> > > have a mix of both private and file page thus only if it is a read only
> > > GUP) that would get added to the list of existing mapping.
> > >
> > > So the flow would be:
> > >     somefunction_thatuse_gup()
> > >     {
> > >         ...
> > >         GUP(_fast)(vma, ..., fake_anon, fake_vma);
> > >         ...
> > >     }
> > >
> > >     GUP(vma, ..., fake_anon, fake_vma)
> > >     {
> > >         if (vma->flags == ANON) {
> > >             // Add the fake anon vma to the anon vma chain as a child
> > >             // of current vma
> > >         } else {
> > >             // Add the fake vma to the mapping tree
> > >         }
> > >
> > >         // The existing GUP except that now it inc mapcount and not
> > >         // refcount
> > >         GUP_old(..., &nanonymous, &nfiles);
> > >
> > >         atomic_add(&fake_anon->refcount, nanonymous);
> > >         atomic_add(&fake_vma->refcount, nfiles);
> > >
> > >         return nanonymous + nfiles;
> > >     }
> >
> > Thanks for your idea! This is actually something like I was suggesting back
> > at LSF/MM in Deer Valley. There were two downsides to this I remember
> > people pointing out:
> >
> > 1) This cannot really work with __get_user_pages_fast(). You're not allowed
> > to get necessary locks to insert new entry into the VMA tree in that
> > context. So essentially we'd loose get_user_pages_fast() functionality.
> >
> > 2) The overhead e.g. for direct IO may be noticeable. You need to allocate
> > the fake tracking VMA, get VMA interval tree lock, insert into the tree.
> > Then on IO completion you need to queue work to unpin the pages again as you
> > cannot remove the fake VMA directly from interrupt context where the IO is
> > completed.
> >
> > You are right that the cost could be amortized if gup() is called for
> > multiple consecutive pages however for small IOs there's no help...
> >
> > So this approach doesn't look like a win to me over using counter in struct
> > page and I'd rather try looking into squeezing HMM public page usage of
> > struct page so that we can fit that gup counter there as well. I know that
> > it may be easier said than done...
>
> So i want back to the drawing board and first i would like to ascertain
> that we all agree on what the objectives are:
>
>     [O1] Avoid write back from a page still being written by either a
>          device or some direct I/O or any other existing user of GUP.
>          This would avoid possible file system corruption.
>
>     [O2] Avoid crash when set_page_dirty() is call on a page that is
>          considered clean by core mm (buffer head have been remove and
>          with some file system this turns into an ugly mess).
>
>     [O3] DAX and the device block problems, ie with DAX the page map in
>          userspace is the same as the block (persistent memory) and no
>          filesystem nor block device understand page as block or pinned
>          block.
>
> For [O3] i don't think any pin count would help in anyway. I believe
> that the current long term GUP API that does not allow GUP of DAX is
> the only sane solution for now.

No, that's not a sane solution, it's an emergency hack.

> The real fix would be to teach file-
> system about DAX/pinned block so that a pinned block is not reuse
> by filesystem.

We already have taught filesystems about pinned dax pages, see
dax_layout_busy_page(). As much as possible I want to eliminate the
concept of "dax pages" as a special case that gets sprinkled
throughout the mm.

> For [O1] and [O2] i believe a solution with mapcount would work. So
> no new struct, no fake vma, nothing like that. In GUP for file back
> pages

With get_user_pages_fast() we don't know that we have a file-backed
page, because we don't have a vma.
