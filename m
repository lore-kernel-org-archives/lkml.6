Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEA2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818D3214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 05:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547098017;
	bh=wLCgdOnFpGnaabfvxmw/GIzvBYL8EOsxdXCRQtu+b6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KH4g0Wj3lu9JAuCHYmROWMLbwWYh6I8skA3gCqTlBUPh6INMgyQAZolZYBp62v9QU
	 KAl2vam8OCbfxoJ/WcYUi5b1Msf3ijbhP2yvj1+gkEDrpJpT7O0366XNgdOfzOAZlh
	 gp1TPPfb+YT8MFYUi+JdfddrWrqGqT06XqcVy/zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfAJF04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 00:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfAJF04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 00:26:56 -0500
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D291214DA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 05:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547098014;
        bh=wLCgdOnFpGnaabfvxmw/GIzvBYL8EOsxdXCRQtu+b6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jD/02zRqVYSLcRrm0k2aZShqQUWWW+GD3v9RvxvyhPy6GmZ0TU1ixnEOsH+MLsHq9
         o/vzoNGEdLYBQaDc6ZfcDAodXLaP1QD4Bfr3XjPvXw8yRkwWpWDIbSBiZZiORkJYh5
         NXMLOhIPnKggXexhrPZmXTupic4JfR08yVnP/9YE=
Received: by mail-wr1-f52.google.com with SMTP id x10so9860652wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 21:26:54 -0800 (PST)
X-Gm-Message-State: AJcUukeOfhAgD1e4UTfvyM4mr3/uVcAY5YMZT6AyX6aiQWyjm6sEPeY0
        UD78EXO4g8n/nbfDnDKwbZ5zHXItaGsNDj5++3jlYg==
X-Google-Smtp-Source: ALg8bN6LhGnurv6wFwHvHDJx0VuLw+UrCW7614drjNYkrtYVHaYXXowc1pQnFcDw+spFlMrjhNFdHi7kLFicrPfuKcM=
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr7264313wro.77.1547098013084;
 Wed, 09 Jan 2019 21:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
In-Reply-To: <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 9 Jan 2019 21:26:41 -0800
X-Gmail-Original-Message-ID: <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
Message-ID: <CALCETrWxwaBUYMg=aLySJByMgXzuzV4gHS0n6O6Oet2Jm6SAbw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jiri Kosina <jikos@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 5:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jan 9, 2019 at 4:44 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I wouldn't look at ext4 as an example of a reliable, problem free
> > direct IO implementation because, historically speaking, it's been a
> > series of nasty hacks (*cough* mount -o dioread_nolock *cough*) and
> > been far worse than XFS from data integrity, performance and
> > reliability perspectives.
>
> That's some big words from somebody who just admitted to much worse hacks.
>
> Seriously. XFS is buggy in this regard, ext4 apparently isn't.
>
> Thinking that it's better to just invalidate the cache  for direct IO
> reads is all kinds of odd.
>

This whole discussion seems to have gone a little bit off the rails...

Linus, I think I agree with Dave's overall sentiment, though, and I
think you should consider reverting your patch.  Here's why.  The
basic idea behind the attack is that the authors found efficient ways
to do two things: evict a page from page cache and detect, *without
filling the cache*, whether a page is cached.  The combination lets an
attacker efficiently tell when another process reads a page.  We need
to keep in mind that this attack is a sophisticated attack, and anyone
using it won't have any problem using a nontrivial way to detect
whether a page is in page cache.

So, unless we're going to try for real to make it hard to tell whether
a page is cached without causing that page to become cached, it's not
worth playing whack-a-mole.  And, right now, mincore is whacking a
mole.  RWF_NOWAIT appears to do essentially the same thing at very
little cost.  I haven't really dug in, but I assume that various
prefaulting tricks combined with various pagetable probing tricks can
do similar things, but that's at least a *lot* more complicated.

So unless we're going to lock down RWF_NOWAIT as well, I see no reason
to lock down mincore().  Direct IO is a red herring -- O_DIRECT is
destructive enough that it seems likely to make the attacks a lot less
efficient.


--- begin digression ---

Since direct IO has been brought up, I have a question.  I've wondered
for years why direct IO works the way it does.  If I were implementing
it from scratch, my first inclination would be to use the page cache
instead of fighting it.  To do a single-page direct read, I would look
that page up in the page cache (i.e. i_pages these days).  If the page
is there, I would do a normal buffered read.  If the page is not
there, I would insert a record into i_pages indicating that direct IO
is in progress and then I would do the IO into the destination page.
If any other read, direct or otherwise, sees a record saying "under
direct IO", it would wait.

To do a single-page direct write, I would look it up in i_pages.  If
it's there, I would do a buffered write followed by a sync (because
applications expect a sync).  If it's not there, I would again add a
record saying "under direct IO" and do the IO.

The idea is that this works as much like buffered IO as possible,
except that the pages backing the IO aren't normal sharable page cache
pages.

The multi-page case would be just an optimization on top of the
single-page case.  The idea would be to somehow mark i_pages with
entire extents under direct IO.  It's a radix tree -- this can, at
least in theory, be done efficiently.  As long as all direct IO
operations run in increasing order of offset, there shouldn't be lock
ordering problems.

Other than history and possibly performance, is there any reason that
direct IO doesn't work this way?

P.S. What, if anything, prevents direct writes from causing trouble
when the underlying FS or backing store needs stable pages?
Similarly, what, if anything, prevents direct reads from temporarily
exposing unintended data to user code if the fs or underlying device
transforms the data during the read process (e.g. by decrypting
something)?

--- end digression ---
