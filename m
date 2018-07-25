Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA21C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDA620895
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rvQ6b625"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDA620895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbeGYD4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:56:19 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53375 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388532AbeGYD4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:56:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so4415978wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 19:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XPdg6EdbhQLlVnMYDVE5onGBieRYW70elpC+npD4pcc=;
        b=rvQ6b625TFQuCtYWDlcyLkKPuV96IIBbplDdDlInwSTGwylL5pB448OrApP7VmMBK3
         ngbhHFDkSjr8ctAT3+lDUm3iqCMcqI42JjlnNmX5rTcvohTNfyfi29tuhonwGGQsVjhf
         /8WtuXJnVMu+n5F+lgtgzVtPOVpiVgQWaJKzpBbve3veXMA8q8NfUu61uCzAl26EVbAC
         HXRxiWFiEq9P/Ylb9DWoQLs6KZN7NU7ha3vNnBmyMFwgCgPnDcl14pgV5g+cy6+SaW88
         ll4y1IxKGiUDCWVRkg0GEW8dnvYrGIVPAjAM0MbYZVbwFB9FrmICajkt3Y2gIwevscNA
         a3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPdg6EdbhQLlVnMYDVE5onGBieRYW70elpC+npD4pcc=;
        b=KydPVUHQIsIxMInipD+Ibu3Lb2D3zF7zJAOcszE7M8y8LkE66c/GcpQ8zGGPcNmah/
         14z91DNoCW4367aBhLsWPU9iTTgmK3HuZT/oJZfahhaOzPjINaoSFVNKJrS+m8+VuSSw
         InKIEeYuBa1zoAHrYhSETaDaNne2EqkAwQa3Pplg/8swbKD9qkL8VJTitkR1NtXVjV5i
         yFxBBJQRKvL00nf9xlT245US8NUqYovDD4KWSdIQaFGX836a0RQL8FYboTtajjEBCjt2
         8q0wyyA/MjyiqqyvK+XQQ7A5rf8XTS1HZm2B+kEdpBsg4hC1TsJqBpLoFtwOLCWy6gcF
         M0Rg==
X-Gm-Message-State: AOUpUlHnRAhuOfs+2pmCjfqo0ap++nDfwdr+iuVnxX9Ew4h7YmB+YDHQ
        d64/jY0Dz7gKXsrJJPVs4jtIGtrRNKdmBBomG6jdNA==
X-Google-Smtp-Source: AAOMgpc3pp3thOQxdo5Qw4Abu5hurj2J0sF3bfCI7Af8P82DV8zuCKyluPvqcN1TWHdZvS6CTGLZ3x1i8m2xyxPqbd4=
X-Received: by 2002:a1c:b584:: with SMTP id e126-v6mr3779521wmf.136.1532486807462;
 Tue, 24 Jul 2018 19:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180724204639.26934-1-cannonmatthews@google.com> <20180724210923.GA20168@bombadil.infradead.org>
In-Reply-To: <20180724210923.GA20168@bombadil.infradead.org>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Tue, 24 Jul 2018 19:46:36 -0700
Message-ID: <CAJfu=Uf5AgpM9=-+kdk6Cn=kRCUtqMjc38+K0NUSDo-QAS8=jg@mail.gmail.com>
Subject: Re: [PATCH] RFC: clear 1G pages with streaming stores on x86
To:     willy@infradead.org
Cc:     mhocko@kernel.org, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andres Lagar-Cavilla <andreslc@google.com>, sqazi@google.com,
        Paul Turner <pjt@google.com>,
        David Matlack <dmatlack@google.com>,
        Peter Feiner <pfeiner@google.com>, nullptr@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 2:09 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Jul 24, 2018 at 01:46:39PM -0700, Cannon Matthews wrote:
> > Reimplement clear_gigantic_page() to clear gigabytes pages using the
> > non-temporal streaming store instructions that bypass the cache
> > (movnti), since an entire 1GiB region will not fit in the cache anyway.
> >
> > Doing an mlock() on a 512GiB 1G-hugetlb region previously would take on
> > average 134 seconds, about 260ms/GiB which is quite slow. Using `movnti`
> > and optimizing the control flow over the constituent small pages, this
> > can be improved roughly by a factor of 3-4x, with the 512GiB mlock()
> > taking only 34 seconds on average, or 67ms/GiB.
>
> This is great data ...
Thanks!
>
> > - The calls to cond_resched() have been reduced from between every 4k
> > page to every 64, as between all of the 256K page seemed overly
> > frequent.  Does this seem like an appropriate frequency? On an idle
> > system with many spare CPUs it get's rescheduled typically once or twice
> > out of the 4096 times it calls cond_resched(), which seems like it is
> > maybe the right amount, but more insight from a scheduling/latency point
> > of view would be helpful.
>
> ... which makes the lack of data here disappointing -- what're the
> comparable timings if you do check every 4kB or every 64kB instead of
> every 256kB?

Fair enough, my data was lacking in that axis. I ran a bunch of trials
with different
sizes and included that in the v2 patch description.

TL;DR: It doesn't seem to make a significant difference in
performance, but might
need more trials to know with more confidence.

>
> > The assembly code for the __clear_page_nt routine is more or less
> > taken directly from the output of gcc with -O3 for this function with
> > some tweaks to support arbitrary sizes and moving memory barriers:
> >
> > void clear_page_nt_64i (void *page)
> > {
> >   for (int i = 0; i < GiB /sizeof(long long int); ++i)
> >     {
> >       _mm_stream_si64 (((long long int*)page) + i, 0);
> >     }
> >   sfence();
> > }
> >
> > In general I would love to hear any thoughts and feedback on this
> > approach and any ways it could be improved.
> >
> > Some specific questions:
> >
> > - What is the appropriate method for defining an arch specific
> > implementation like this, is the #ifndef code sufficient, and did stuff
> > land in appropriate files?
> >
> > - Are there any obvious pitfalls or caveats that have not been
> > considered? In particular the iterator over mem_map_next() seemed like a
> > no-op on x86, but looked like it could be important in certain
> > configurations or architectures I am not familiar with.
> >
> > - Are there any x86_64 implementations that do not support SSE2
> > instructions like `movnti` ? What is the appropriate way to detect and
> > code around that if so?
>
> No.  SSE2 was introduced with the Pentium 4, before x86-64.  The XMM
> registers are used as part of the x86-64 calling conventions, so SSE2
> is mandatory for x86-64 implementations.

Awesome, good to know.

>
> > - Is there anything that could be improved about the assembly code? I
> > originally wrote it in C and don't have much experience hand writing x86
> > asm, which seems riddled with optimization pitfalls.
>
> I suspect it might be slightly faster if implemented as inline asm in the
> x86 clear_gigantic_page() implementation instead of a function call.
> Might not affect performance a lot though.

I can try to experiment with that tomorrow. Since the performance doesn't vary
much on an idle machine when you make one function call for the whole GiB
or 256K of them for each 4K page I would suspect it won't matter much.

>
> > - Is the highmem codepath really necessary? would 1GiB pages really be
> > of much use on a highmem system? We recently removed some other parts of
> > the code that support HIGHMEM for gigantic pages (see:
> > http://lkml.kernel.org/r/20180711195913.1294-1-mike.kravetz@oracle.com)
> > so this seems like a logical continuation.
>
> PAE paging doesn't support 1GB pages, so there's no need for it on x86.

Excellent. Do you happen to know if/when it is necessary on any other
architectures?

>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7206a634270b..2515cae4af4e 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -70,6 +70,7 @@
> >  #include <linux/dax.h>
> >  #include <linux/oom.h>
> >
> > +
> >  #include <asm/io.h>
> >  #include <asm/mmu_context.h>
> >  #include <asm/pgalloc.h>
>
> Spurious.
>
Thanks for catching that, removed.
