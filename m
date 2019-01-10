Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF0EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660532184A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KhRR3r7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfAJWLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:11:23 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46018 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfAJWLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:11:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so11112800ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdjYJOzVCfeCe7Ioc9Rew5+ItUP7VYboNciWI+K3Sds=;
        b=KhRR3r7/IU4vwsMRTlx7/FpGeUnljFFYP0hYBTUz4QVWaHAdSdKTw/lQbXmof0EGEj
         TayS4DnDVo3jFmlWfOFpykaa1rI/WTHvLiz+ec/+b21DRII6dRWVi+Wj2++9GTh/s+vI
         Iz+7cNVt44OrPCRyvjoBHNcVhXM38UQJuQ0cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdjYJOzVCfeCe7Ioc9Rew5+ItUP7VYboNciWI+K3Sds=;
        b=X6J7b20rWG4eOuzWV3n2HwM2xYQ5bO39gIL95cEGnEtPanJPUlUbIQYnAmLl1n3foU
         mWDU4wQbQS4WBkLRlz+rsQsXgbsfIeJFkG/fxcXlFBme+ZHY4yBDs2pXNGE19BXOsbmh
         90ZKetGPY0tFtTVGP3X6hsoBlU4Ec7nk9nY8NYmzlxzwWQ43NgoSWyDz2p93Yrm4EFYJ
         UDKyO0gSfrlZjkvtLBo7QtXrPh3iI7NptiUv3UE3BVIFT3sIoY4luDcZzPJxPhS6JOVR
         54O5c1zICuK3ybQyfNAbqqHg7TfU/hwtp6AopYoV3wx1hk+83vyx/MawjllbCpE2rMvm
         ReHw==
X-Gm-Message-State: AJcUuketkwBkGeUdVlGr+c8BXgBfosvIgPvWPPiWSmBmhqMl0a4VJ93L
        CyXSGncChK8pobB/G4roSMx2OKriHYA=
X-Google-Smtp-Source: ALg8bN55cEIDbK0VkwQUmLYP54x29nQw4jVbIpvsfLaRNo+wWXRLi2bfO/yIv6HLu6AabvJK1cbRVQ==
X-Received: by 2002:a2e:6109:: with SMTP id v9-v6mr6830311ljb.126.1547158279350;
        Thu, 10 Jan 2019 14:11:19 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id e14-v6sm15544011ljl.43.2019.01.10.14.11.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 14:11:18 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id g11-v6so11165537ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 14:11:17 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr7100855ljs.118.1547158277491;
 Thu, 10 Jan 2019 14:11:17 -0800 (PST)
MIME-Version: 1.0
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica>
In-Reply-To: <20190110122442.GA21216@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 14:11:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
Message-ID: <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dominique Martinet <asmadeus@codewreck.org>
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

On Thu, Jan 10, 2019 at 4:25 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Linus Torvalds wrote on Thu, Jan 10, 2019:
> > (Except, of course, if somebody actually notices outside of tests.
> > Which may well happen and just force us to revert that commit. But
> > that's a separate issue entirely).
>
> Both Dave and I pointed at a couple of utilities that break with
> this. nocache can arguably work with the new behaviour but will behave
> differently; vmtouch on the other hand is no longer able to display
> what's in cache or not - people use that for example to "warm up" a
> container in page cache based on how it appears after it had been
> running for a while is a pretty valid usecase to me.

So honestly, the main reason I'm loath to revert is that yes, we know
of theoretical differences, but they seem to all be
performance-related.

It would be really good to hear numbers. Is the warm-up optimization
something that changes things from 3ms to 3.5ms? Or does it change
things from 3ms to half a second?

Because Dave is absolutely correct that mincore() isn't really even
all that interesting an information leak if you can do the same with
RWF_NOWAIT. But the other side of that same coin is that if we're not
able to block mincore() sanely, then there's no point at looking at
RWF_NOWAIT either.

And we *can* do sane things about RWF_NOWAIT. For example, we could
start async IO on RWF_NOWAIT, and suddenly it would go from "probe the
page cache" to "probe and fill", and be much harder to use as an
attack vector..

Do we want to do that? Maybe, maybe not. But if mincore() can't be
fixed, there's no point in even trying.

Now, if the mincore() change results in a big performance hit for
people who use it as a heuristic for filling caches etc, then
reverting the trial balloon is obviously something we must do, but at
that point I'd also like to know which load it was that cared so much,
and just what it did. Because we did have an alternate patch that just
said "was the file writably opened, then we can do the page cache
probing". But at least one user (fincore) didn't do even that.

So right now, I consider the mincore change to be a "try to probe the
state of mincore users", and we haven't really gotten a lot of
information back yet.

              Linus
