Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D951AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAEA222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xa+qZY+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407412AbfBNPNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:13:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45744 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfBNPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:13:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id 32so10950023ota.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJI/pk5H55mfRvQVlZ1QB6KQyS4XiuvbQpyQ9QHp3cg=;
        b=Xa+qZY+mcalye0fRh8JiCRY2VzHP4nXzMty8/xvOdxDYelcPykB9tFfdPE2TQXzifQ
         d3q5UWieKFooAx/BcbMsO8mIiEEBlmGfD6vEc3FePMF37o0MFEFF6XTrvBCT2PWLCr3P
         ZTDBf3WNDv/5KaCBZsKtp4yWNI+kAFIj9svQHfSod0HLzTZzvD4T/1JS6tzh8iWhw/64
         I1cfcI5j52B0PjiRHT3td0/QJUlo9DfcivVEpp7fbtjeiZCOb5nQMkcDfVaa6oV43eyQ
         mkjlnJPHB5EH2nEXv9FEZSjIdlSUx1ebc+YfXKVLUhJH303K6d4Yuvpz4rQ2+7PwwFeB
         xOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJI/pk5H55mfRvQVlZ1QB6KQyS4XiuvbQpyQ9QHp3cg=;
        b=QiBfKb2h5mCC/BcPZaMPjnxGzLnRjNyER/pxujTMHD7XRV3vP4xATWtz4pp1aWSS+g
         qQULFCDZfRIyP/Bg1IVtkO26FIMKIOwxh2YZVTSjh4KTZtTICxi+m1DnwCnlWD1IHoph
         AdMZVTj6XWjX1gBHn6iYrUl5rZci1IGMpmzGrGp6KaJ39uogTqsC1CB062rbUdOtVBxr
         e8g+U6TCMSGRCWkmvjtEIAxZpY2Y4n1ga5ZqDfJz5R97JWxKcTQQsep9YtqWOjfaiqeU
         7G2hw0okVwh0uoyhCt1Arxa1EqoJ9MAr+DY1alpg/r41zm/HGAw+CqwBI1DC5X3CB+gt
         ZAww==
X-Gm-Message-State: AHQUAuapxvd9q6ekaTzZVqilb34YRVpR5ax+LrDE2ZVWT6ehCKlh8is7
        KAJ32VGi1o96KLVaObJhu2g8rp9fyulDzk7quBk+2Q==
X-Google-Smtp-Source: AHgI3IYtH6Br7+jtnzndSJDWGG8uEAmaoG1A+RjcD/4JuI2o3aAA0GTtYjkIUK8162ciwLyeee9wolUaXeFMqrH29Ko=
X-Received: by 2002:aca:3806:: with SMTP id f6mr1973512oia.47.1550157220765;
 Thu, 14 Feb 2019 07:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20190213204157.12570-1-jannh@google.com> <CAKgT0Uc7wheUjStv5a4BSNv_=-iu1Ttdj9f_10CdR_oc2BhVig@mail.gmail.com>
In-Reply-To: <CAKgT0Uc7wheUjStv5a4BSNv_=-iu1Ttdj9f_10CdR_oc2BhVig@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 14 Feb 2019 16:13:14 +0100
Message-ID: <CAG48ez0v7QwtCKDs5vgRJht8yfZR5nudEpkMOLaDX-=47WeFqA@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
To:     Alexander Duyck <alexander.duyck@gmail.com>
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

On Wed, Feb 13, 2019 at 11:42 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Wed, Feb 13, 2019 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > The basic idea behind ->pagecnt_bias is: If we pre-allocate the maximum
> > number of references that we might need to create in the fastpath later,
> > the bump-allocation fastpath only has to modify the non-atomic bias value
> > that tracks the number of extra references we hold instead of the atomic
> > refcount. The maximum number of allocations we can serve (under the
> > assumption that no allocation is made with size 0) is nc->size, so that's
> > the bias used.
> >
> > However, even when all memory in the allocation has been given away, a
> > reference to the page is still held; and in the `offset < 0` slowpath, the
> > page may be reused if everyone else has dropped their references.
> > This means that the necessary number of references is actually
> > `nc->size+1`.
> >
> > Luckily, from a quick grep, it looks like the only path that can call
> > page_frag_alloc(fragsz=1) is TAP with the IFF_NAPI_FRAGS flag, which
> > requires CAP_NET_ADMIN in the init namespace and is only intended to be
> > used for kernel testing and fuzzing.
>
> Actually that has me somewhat concerned. I wouldn't be surprised if
> most drivers expect the netdev_alloc_frags call to at least output an
> SKB_DATA_ALIGN sized value.
>
> We probably should update __netdev_alloc_frag and __napi_alloc_frag so
> that they will pass fragsz through SKB_DATA_ALIGN.

Do you want to do a separate patch for that? I'd like to not mix
logically separate changes in a single patch, and I also don't have a
good understanding of the alignment concerns here.

> > To test for this issue, put a `WARN_ON(page_ref_count(page) == 0)` in the
> > `offset < 0` path, below the virt_to_page() call, and then repeatedly call
> > writev() on a TAP device with IFF_TAP|IFF_NO_PI|IFF_NAPI_FRAGS|IFF_NAPI,
> > with a vector consisting of 15 elements containing 1 byte each.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  mm/page_alloc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 35fdde041f5c..46285d28e43b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4675,11 +4675,11 @@ void *page_frag_alloc(struct page_frag_cache *nc,
> >                 /* Even if we own the page, we do not use atomic_set().
> >                  * This would break get_page_unless_zero() users.
> >                  */
> > -               page_ref_add(page, size - 1);
> > +               page_ref_add(page, size);
> >
> >                 /* reset page count bias and offset to start of new frag */
> >                 nc->pfmemalloc = page_is_pfmemalloc(page);
> > -               nc->pagecnt_bias = size;
> > +               nc->pagecnt_bias = size + 1;
> >                 nc->offset = size;
> >         }
> >
> > @@ -4695,10 +4695,10 @@ void *page_frag_alloc(struct page_frag_cache *nc,
> >                 size = nc->size;
> >  #endif
> >                 /* OK, page count is 0, we can safely set it */
> > -               set_page_count(page, size);
> > +               set_page_count(page, size + 1);
> >
> >                 /* reset page count bias and offset to start of new frag */
> > -               nc->pagecnt_bias = size;
> > +               nc->pagecnt_bias = size + 1;
> >                 offset = size - fragsz;
> >         }
>
> If we already have to add a constant it might be better to just use
> PAGE_FRAG_CACHE_MAX_SIZE + 1 in all these spots where you are having
> to use "size + 1" instead of "size". That way we can avoid having to
> add a constant to a register value and then program that value.
> instead we can just assign the constant value right from the start.

I doubt that these few instructions make a difference, but sure, I can
send a v2 with that changed.
