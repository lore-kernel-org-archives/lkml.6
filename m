Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F353EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE56621773
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="heKFGZ0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfAJLrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:47:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36429 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfAJLrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:47:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so9435043ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qXkOqTnBKSOzxBijAL8L2hMMKEeLSzTv8+NcatDO6s=;
        b=heKFGZ0dHc9drtpVWDCyKfCccI3cR2LapDVPQM5fKcQR9ZeVI/gAEDrUpj0YuugaSt
         T3OZ8Bi3W5/Yk8/h5yuv+q67dU5dXlR4QQNyuEYflvu+LShhI5chbNWQpZdK6xRK2wWz
         33fQoABuYZAPNriQ+jXXBAbmJLXJslnaTLn08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qXkOqTnBKSOzxBijAL8L2hMMKEeLSzTv8+NcatDO6s=;
        b=BL9bXjmGT1PEXV8SD6sAzcJtAMwkKXBPEz/M//bb1d9dLrvypu1k0NuQgyLMiQyDJc
         6XNBFW2VsGz5DfYkWBMOH/JX3NQY/kjt7vCFh8irc7bvsLD5VtTo/awrb8uJ60HSNowt
         v/9M5E+KmiW+3jksgd57ENKKBSTEbfpzY72UGnzewkWRLACOnSa4uLC4iobfgNNlo6sR
         BUfyegG6NXSqZdL9Q1IZ5F+G0fBmsYp2OeG7bAMzycELimuVK04IQoXzq9ft/ybqbLx3
         LLUHktxB+Y61G5X6y39XiLyoxZvafA4Jub+1bEl0xARA5TOn21PotrRHt/z4EPJfmWEt
         P4+Q==
X-Gm-Message-State: AJcUuke3idcjgLYGR8i94kOKkkgIzNVZNYGwD1gFNnyG/ZVgn+fy+ooI
        zsf9NXYdRLi+FZ+0w1xUu7n6/JIGqVI=
X-Google-Smtp-Source: ALg8bN7puk5xoWviI+RATIQSzOhlhoUyh1/ziOyqCxXLVaI/0bg3OWvD2CuyfYNjAh+HYTIIKRlpfQ==
X-Received: by 2002:a2e:2b11:: with SMTP id q17-v6mr5629258lje.25.1547120838771;
        Thu, 10 Jan 2019 03:47:18 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id p21sm14186625lfj.10.2019.01.10.03.47.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 03:47:17 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id v15-v6so9395817ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 03:47:17 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr5799378ljs.118.1547120836837;
 Thu, 10 Jan 2019 03:47:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
 <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard>
In-Reply-To: <20190110070355.GJ27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 03:47:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
Message-ID: <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
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

On Wed, Jan 9, 2019 at 11:04 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Sorry, what hacks did I just admit to making? This O_DIRECT
> behaviour long predates me - I'm just the messenger and you are
> shooting from the hip.

Sure, sorry. I find this whole thing annoying.

> Linus, the point I was making is that there are many, many ways to
> control page cache invalidation and measure page cache residency,
> and that trying to address them one-by-one is just a game of
> whack-a-mole.

.. and I agree. But let's a step back.Because there are different issues.

First off, the whole page cache attack is not necessarily something
many people will care about. As has been pointed out, it's often a
matter of convenience and (relative) portability.

And no, we're *never* going to stop all side channel leaks. Some parts
of caching (notably the timing effects of it) are pretty fundamental.

So at no point is this going to be some kind of absolute line in the
sand _anyway_. There is no black-and-white "you're protected", there's
only levels of convenience.

A remote attacker is hopefully going to be limited by the interfaces
to just timing attacks, although who knows what something like JS
might expose. Presumably neither mincore() nor arbitrary O_DIRECT or
pread2() flags.

Anyway, the reason I was trying to plug mincore() is largely that that
code didn't make much sense to begin with, and simply this:

 mm/mincore.c | 94 +++++++++---------------------------------------------------
 1 file changed, 13 insertions(+), 81 deletions(-)

if we can make people happier by removing lines of code and making the
semantics more clear anyway, it's worth trying.

No?

Is that everything? No. As mentioned, you'll never get to that "ok, we
plugged everything" point anyway. But removing a fairly easy way to
probe the cache that has no real upsides should be fairly
non-controversial.

But I do have to say that in many ways the page cache is *not* a great
attack vector because there's often lots of it, and it's fairly hard
to control. Once something is in the page cache for whatever reason,
it tends to be pretty sticky, and flushing it tends to be fairly hard
to predict.

And a cheap and residency (whether a simple probe like mincore of or a
NOWAIT flag) check is actually important just to try to control the
flushing part. Brute-forcing the flushing is generally very expensive,
but if you can't even see if you flushed it, it's way more so.

If there's a way to control the cache residency directly, that's
actually a much bigger hole than any residency check ever were.

Because once you can flush caches by reading, at that point you can
just flush a particular page and look at the IO stats for the root
partition or something. No residency check even needed.

So I do think that yes, as long as you can do a directed cache flush,
mincore is *entirely* immaterial.

Still, giving mincore clearer semantics and simpler code? Win-win.

(Except, of course, if somebody actually notices outside of tests.
Which may well happen and just force us to revert that commit. But
that's a separate issue entirely).

But I do think that we should strive to *never* invalidate caches on
read accesses. I don't actually see where you are doing that,
honestly: at least dio_complete() only does it for writes.

So I'm actually hoping that you are mis-remembering this and it turns
out that O_DIRECT reads don't invalidate caches.

                Linus
