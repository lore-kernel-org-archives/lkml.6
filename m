Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081E5222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzBHlyYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395482AbfBNPhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:37:34 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55866 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbfBNPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:37:34 -0500
Received: by mail-it1-f194.google.com with SMTP id z131so5581987itf.5;
        Thu, 14 Feb 2019 07:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+/VBdnNZSL+dtF784MTuvLnHvY3T/rWFSZ46f+0SO8=;
        b=GzBHlyYG+AOJ+gbIGyLgf8XMFJTAVzqZOf/6sDAinnVQnsd9DVqJ/D71AUMNuM+qq0
         c1VOmwYHlxtl89Ox+4Yw4zQ5kQKT2m5Sj9+z37qcArbBM5+Eqelqal8DkB7V0EuE+5Yw
         pBGZIeBpnJQb6Tu0GI++AtBcNvZtzg60HmnVSoTRSCdbPDy/KZIKfERYYYgt9p0B4782
         fkVQsVd5HeaXI+6nICGCiAZHTqmGgZDUIcbxS/ev7zKXvqTzK1KQ2bxnwxSt04o3i9aP
         uPqanevtj3bG7BT6jzk8kfOBr+7ZKlJfn9xAL2kse7mcHfA5XVlHnZsHyWp5iUKvFYx5
         1gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+/VBdnNZSL+dtF784MTuvLnHvY3T/rWFSZ46f+0SO8=;
        b=Fx6iPFabCwTR1/dYrHz3LINdskqwF+uQQSbM1Ts04NlBJii9yDEbiLdcEuzgWqaAIm
         ELnp5P2UTIqWgQ4u23NVj2zl2YGVxnPk8dh5zOuexYtEF6LnHTOIGWha3NmPv5bgE9YG
         ePDENTuJ9RC4TcgeT6m95uuGkBfQ5eHVal07ks5BqF1wNOXWQLjpJOWXT76n/BYYo3/A
         RTB3hgSGNPi45tKzDmAw+bAoQvanIm7/C78T5j1NQAqUYwOPjFQMaYYV8xmZAd7GQp+O
         OR8QYUecJLQ1O7COazmL9hvvm5AKmtch4rleH69JdJP1TiRjoEI2CeKefMtzlDvhv5of
         Du1g==
X-Gm-Message-State: AHQUAuadt4F3qm0ueeKnAo/LMIwR7PBDN9wlgSH9b33QPVsKc1MydpQ3
        zkZJS3vo611gl9aQVgMK2gA6EyrjcOhXtfuwHAM=
X-Google-Smtp-Source: AHgI3IaIEW57zI7tgCujKKMaaoc2liycZ5BjW1rEDjlu6jRy0Zlc9g6mTM0kJK81e2UL4o7VxaPRUAIkegYnPw/nsvg=
X-Received: by 2002:a6b:f70a:: with SMTP id k10mr2898317iog.68.1550158653095;
 Thu, 14 Feb 2019 07:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20190213204157.12570-1-jannh@google.com> <CAKgT0Uc7wheUjStv5a4BSNv_=-iu1Ttdj9f_10CdR_oc2BhVig@mail.gmail.com>
 <CAG48ez0v7QwtCKDs5vgRJht8yfZR5nudEpkMOLaDX-=47WeFqA@mail.gmail.com>
In-Reply-To: <CAG48ez0v7QwtCKDs5vgRJht8yfZR5nudEpkMOLaDX-=47WeFqA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 14 Feb 2019 07:37:21 -0800
Message-ID: <CAKgT0Ue99Zj88m_mfvnaj3_WspkzfABFsH==B_0X0s85z9Xvaw@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
To:     Jann Horn <jannh@google.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>, Netdev <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 7:13 AM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Feb 13, 2019 at 11:42 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> > On Wed, Feb 13, 2019 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> > > number of references that we might need to create in the fastpath later,
> > > the bump-allocation fastpath only has to modify the non-atomic bias value
> > > that tracks the number of extra references we hold instead of the atomic
> > > refcount. The maximum number of allocations we can serve (under the
> > > assumption that no allocation is made with size 0) is nc->size, so that's
> > > the bias used.
> > >
> > > However, even when all memory in the allocation has been given away, a
> > > reference to the page is still held; and in the `offset < 0` slowpath, the
> > > page may be reused if everyone else has dropped their references.
> > > This means that the necessary number of references is actually
> > > `nc->size+1`.
> > >
> > > Luckily, from a quick grep, it looks like the only path that can call
> > > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> > > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> > > used for kernel testing and fuzzing.
> >
> > Actually that has me somewhat concerned. I wouldn't be surprised if
> > most drivers expect the netdev_alloc_frags call to at least output an
> > SKB_DATA_ALIGN sized value.
> >
> > We probably should update __netdev_alloc_frag and __napi_alloc_frag so
> > that they will pass fragsz through SKB_DATA_ALIGN.
>
> Do you want to do a separate patch for that? I'd like to not mix
> logically separate changes in a single patch, and I also don't have a
> good understanding of the alignment concerns here.

You could just include it as a separate patch with your work.
Otherwise I will get to it when I have time.

The point is the issue you pointed out will actually cause other
issues if the behavior is maintained since you shouldn't be getting
unaligned blocks out of the frags API anyway.

> > > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> > > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> > > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> > > with a vector consisting of 15 elements containing 1 byte each.
> > >
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > ---
> > >  mm/page_alloc.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 35fdde041f5c..46285d28e43b 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
> > >                 /* Even if we own the page, we do not use atomic_set().
> > >                  * This would break get_page_unless_zero() users.
> > >                  */
> > > -               page_ref_add(page, size - 1);
> > > +               page_ref_add(page, size);
> > >
> > >                 /* reset page count bias and offset to start of new frag */
> > >                 nc->pfmemalloc = page_is_pfmemalloc(page);
> > > -               nc->pagecnt_bias = size;
> > > +               nc->pagecnt_bias = size + 1;
> > >                 nc->offset = size;
> > >         }
> > >
> > > @@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
> > >                 size = nc->size;
> > >  #endif
> > >                 /* OK, page count is 0, we can safely set it */
> > > -               set_page_count(page, size);
> > > +               set_page_count(page, size + 1);
> > >
> > >                 /* reset page count bias and offset to start of new frag */
> > > -               nc->pagecnt_bias = size;
> > > +               nc->pagecnt_bias = size + 1;
> > >                 offset = size - fragsz;
> > >         }
> >
> > If we already have to add a constant it might be better to just use
> > PAGE_FRAG_CACHE_MAX_SIZE + 1 in all these spots where you are having
> > to use "size + 1" instead of "size". That way we can avoid having to
> > add a constant to a register value and then program that value.
> > instead we can just assign the constant value right from the start.
>
> I doubt that these few instructions make a difference, but sure, I can
> send a v2 with that changed.

You would be surprised. They all end up adding up over time.
