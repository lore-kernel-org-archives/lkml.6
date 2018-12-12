Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D5DC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D722D2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 17:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LO7vT2Qb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D722D2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbeLLRtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:49:50 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39420 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeLLRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 12:49:50 -0500
Received: by mail-oi1-f196.google.com with SMTP id i6so15737362oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 09:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WvtVpAnppJ2u9cEG8h4QiJ5f3XzoEwl6Mg8MTqXPS7g=;
        b=LO7vT2QbELrh1XYJ5u2ZqZ+e65DeSS0tujGKs/tqU0FyCIwibPM5g2ANJHx9lRkkYR
         WIKq3lb0+s1B7hqNviaKCegsWnwe/puwHUXq3eWVkcco322LPPZvOICJAaAISXep8u6z
         gCqbDK8oy1eMsN6e5jJYJq7K17Q5h1pzPA1G529F9nfbnd2rXyaAIE+7rzYuSltbo33U
         n0cxwxQsViBlcwrbmnSkhwRoEDqVg51ySMpbIpIbrWP9LNSXGIORv6w0UfTWJzsvu0x7
         VWWK3AKxoxmuAx3W8H7VcVTOoFCiffAOMpVAi+kCIUlqEo3UZ6259TX6pyQMr11X/zHj
         JJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WvtVpAnppJ2u9cEG8h4QiJ5f3XzoEwl6Mg8MTqXPS7g=;
        b=XoKpGUtJDS/LI71l9JyLzx0EPwbsHUxZLg7zCqYieJW1DBpPXZ/M0LGlbX1PogE7OO
         sU5NEKGhfcmbNrfxgjhm9xy+AVr5kV2S6mVCe9DmdRlp9qfMYGX/m4/B1gU9T1O9+1Q5
         lQcMYrt5i0UWT9eeRiYK8RSim8mcLy2ACNa42wFAnmrEZm2wRW0hHNiah/juZLaCgW0t
         y7ekLqPJl+2ORY5AMA6bCxATntWjTPzdF0RDh2dhwRfOEzscvzysQwhEXdP6DsL6mBQe
         lldf3Kao/U9r/zvFD+TL518YQivbr4VbxWUufKWlV4FSgbJCPaFN6s7d0CLaeATpjB8d
         6Shw==
X-Gm-Message-State: AA+aEWbEJYRYAcQNFk4lBLcghWY+JAnVnoI7RTW2AGxw/P9U5dEt4K2o
        E1lY7+l7v9FPjPQAcKrOzNhjtpu+mtRnhCQ0H0O4Wg==
X-Google-Smtp-Source: AFSGD/VCzVZhwleiMEX4r1S9OGFe3aaYc+UM7WruWkjPf4GglsDSt2GVw+DY2TOycxQdVLDMuVyqJdEXmsxXgXPXhe8=
X-Received: by 2002:aca:f4c2:: with SMTP id s185mr985697oih.244.1544636988855;
 Wed, 12 Dec 2018 09:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20181205011519.GV10377@bombadil.infradead.org>
 <20181205014441.GA3045@redhat.com> <59ca5c4b-fd5b-1fc6-f891-c7986d91908e@nvidia.com>
 <7b4733be-13d3-c790-ff1b-ac51b505e9a6@nvidia.com> <20181207191620.GD3293@redhat.com>
 <3c4d46c0-aced-f96f-1bf3-725d02f11b60@nvidia.com> <20181208022445.GA7024@redhat.com>
 <20181210102846.GC29289@quack2.suse.cz> <20181212150319.GA3432@redhat.com>
 <CAPcyv4go0Xzhz8rXdfscWuXDu83BO9v8WD4upDUJWb7gKzX5OQ@mail.gmail.com> <20181212170220.GA5037@redhat.com>
In-Reply-To: <20181212170220.GA5037@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Dec 2018 09:49:36 -0800
Message-ID: <CAPcyv4hnQ-4DKwtrJjy9euvJvRf_sDO+1hbxuFCQv5m9qd9Drg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 9:02 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Wed, Dec 12, 2018 at 08:27:35AM -0800, Dan Williams wrote:
> > On Wed, Dec 12, 2018 at 7:03 AM Jerome Glisse <jglisse@redhat.com> wrot=
e:
> > >
> > > On Mon, Dec 10, 2018 at 11:28:46AM +0100, Jan Kara wrote:
> > > > On Fri 07-12-18 21:24:46, Jerome Glisse wrote:
> > > > > Another crazy idea, why not treating GUP as another mapping of th=
e page
> > > > > and caller of GUP would have to provide either a fake anon_vma st=
ruct or
> > > > > a fake vma struct (or both for PRIVATE mapping of a file where yo=
u can
> > > > > have a mix of both private and file page thus only if it is a rea=
d only
> > > > > GUP) that would get added to the list of existing mapping.
> > > > >
> > > > > So the flow would be:
> > > > >     somefunction_thatuse_gup()
> > > > >     {
> > > > >         ...
> > > > >         GUP(_fast)(vma, ..., fake_anon, fake_vma);
> > > > >         ...
> > > > >     }
> > > > >
> > > > >     GUP(vma, ..., fake_anon, fake_vma)
> > > > >     {
> > > > >         if (vma->flags =3D=3D ANON) {
> > > > >             // Add the fake anon vma to the anon vma chain as a c=
hild
> > > > >             // of current vma
> > > > >         } else {
> > > > >             // Add the fake vma to the mapping tree
> > > > >         }
> > > > >
> > > > >         // The existing GUP except that now it inc mapcount and n=
ot
> > > > >         // refcount
> > > > >         GUP_old(..., &nanonymous, &nfiles);
> > > > >
> > > > >         atomic_add(&fake_anon->refcount, nanonymous);
> > > > >         atomic_add(&fake_vma->refcount, nfiles);
> > > > >
> > > > >         return nanonymous + nfiles;
> > > > >     }
> > > >
> > > > Thanks for your idea! This is actually something like I was suggest=
ing back
> > > > at LSF/MM in Deer Valley. There were two downsides to this I rememb=
er
> > > > people pointing out:
> > > >
> > > > 1) This cannot really work with __get_user_pages_fast(). You're not=
 allowed
> > > > to get necessary locks to insert new entry into the VMA tree in tha=
t
> > > > context. So essentially we'd loose get_user_pages_fast() functional=
ity.
> > > >
> > > > 2) The overhead e.g. for direct IO may be noticeable. You need to a=
llocate
> > > > the fake tracking VMA, get VMA interval tree lock, insert into the =
tree.
> > > > Then on IO completion you need to queue work to unpin the pages aga=
in as you
> > > > cannot remove the fake VMA directly from interrupt context where th=
e IO is
> > > > completed.
> > > >
> > > > You are right that the cost could be amortized if gup() is called f=
or
> > > > multiple consecutive pages however for small IOs there's no help...
> > > >
> > > > So this approach doesn't look like a win to me over using counter i=
n struct
> > > > page and I'd rather try looking into squeezing HMM public page usag=
e of
> > > > struct page so that we can fit that gup counter there as well. I kn=
ow that
> > > > it may be easier said than done...
> > >
> > > So i want back to the drawing board and first i would like to ascerta=
in
> > > that we all agree on what the objectives are:
> > >
> > >     [O1] Avoid write back from a page still being written by either a
> > >          device or some direct I/O or any other existing user of GUP.
> > >          This would avoid possible file system corruption.
> > >
> > >     [O2] Avoid crash when set_page_dirty() is call on a page that is
> > >          considered clean by core mm (buffer head have been remove an=
d
> > >          with some file system this turns into an ugly mess).
> > >
> > >     [O3] DAX and the device block problems, ie with DAX the page map =
in
> > >          userspace is the same as the block (persistent memory) and n=
o
> > >          filesystem nor block device understand page as block or pinn=
ed
> > >          block.
> > >
> > > For [O3] i don't think any pin count would help in anyway. I believe
> > > that the current long term GUP API that does not allow GUP of DAX is
> > > the only sane solution for now.
> >
> > No, that's not a sane solution, it's an emergency hack.
>
> Then how do you want to solve it ? Knowing pin count does not help
> you, at least i do not see how that would help and if it does then
> my solution allow you to know pin count it is the difference between
> real mapping and mapcount value.

True, pin count doesn't help, and indefinite waits are intolerable, so
I think we need to make "long term" GUP revokable, but otherwise
hopefully use the put_user_page() scheme to replace the use of the pin
count for dax_layout_busy_page().

> > > The real fix would be to teach file-
> > > system about DAX/pinned block so that a pinned block is not reuse
> > > by filesystem.
> >
> > We already have taught filesystems about pinned dax pages, see
> > dax_layout_busy_page(). As much as possible I want to eliminate the
> > concept of "dax pages" as a special case that gets sprinkled
> > throughout the mm.
> >
> > > For [O1] and [O2] i believe a solution with mapcount would work. So
> > > no new struct, no fake vma, nothing like that. In GUP for file back
> > > pages
> >
> > With get_user_pages_fast() we don't know that we have a file-backed
> > page, because we don't have a vma.
>
> You do not need a vma to know that we have PageAnon() for that so my
> solution is just about adding to core GUP page table walker:
>
>     if (!PageAnon(page))
>         atomic_inc(&page->mapcount);

Ah, ok, would need to add proper mapcount manipulation for dax and
audit that nothing makes page-cache assumptions based on a non-zero
mapcount.

> Then in put_user_page() you add the opposite. In page_mkclean() you
> count the number of real mapping and voil=C3=A0 ... you got an answer for
> [O1]. You could use the same count real mapping to get the pin count
> in other place that cares about it but i fails to see why the actual
> pin count value would matter to any one.

Sounds like a could work... devil is in the details.
