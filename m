Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0166EC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E382086D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cm8s3Ol6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbfAPFuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:50:08 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37368 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbfAPFuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:50:07 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so3924953lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZ1+S4udBrUGqA2qKTo5GfQAEHGyi6IpM7GyhEi/87Q=;
        b=Cm8s3Ol69OXV+2VWR7fkXnsX1n+j4dzdhPWdlz+bQiLV2defpBkGRVFg2h3wehxX/B
         m22hjZI3XvFBpyA+dLrVT89Aow6fflPmxfHCQP4AbP8oZLi4pChb1R0mNyMz920VsOlR
         MEg/wP8hNUn4G/821olrUDpO5emm1o1mNr/E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZ1+S4udBrUGqA2qKTo5GfQAEHGyi6IpM7GyhEi/87Q=;
        b=AxL96kmHPfIBbqB4EPPNTwWkp+WSmFVnFn4teC1xmkHnhErc3pXo+LDlTlRkXkj2VE
         xmiHY78wMvA6BxdTBa0g886CaGNviSxDMSO+u19bXIH+4GqUqMGBxPHbN1CjAOpJ01gJ
         uh9kM6fXeodJo6rFUqoWc2p19l0L4re9FroqLHyGk2GAWC0Co3J+kKmBF+1oNOM/XnWu
         loqv/y7Ej5KrIlYg822nffpHnakzcc+z3R/bNge9j6SztizH03RVqw3pS/bdwLJntV8S
         7JZdyhWhr2L2TqedcBqZlqABBKZLhah15GSxj1BAyCSfZG/ErTMfPaIoAHY+1M7H1OsC
         qeBg==
X-Gm-Message-State: AJcUukf0mXkL8KM9JuaK0hOzb7dvm315FnQwIgFvA4m+G5qvoBP7tHkP
        8Zhsaa+wuIideQUFrkwDk2pnW+6BgQA=
X-Google-Smtp-Source: ALg8bN4BKnbpIhEpkzkpsRQ6+At2f7wTIKyqVNnhGpxM2uiNwY0gy1ThUS35eckBQDTutnJPeK9fNg==
X-Received: by 2002:a19:f89:: with SMTP id 9mr5351322lfp.10.1547617805290;
        Tue, 15 Jan 2019 21:50:05 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id g24sm982860lfh.33.2019.01.15.21.50.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 21:50:04 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id e26so3927636lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:50:03 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr5627124lfc.147.1547617803433;
 Tue, 15 Jan 2019 21:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard> <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
 <20190111040434.GN27534@dastard> <CAHk-=wh-kegfnPC_dmw0A72Sdk4B9tvce-cOR=jEfHDU1-4Eew@mail.gmail.com>
 <20190111073606.GP27534@dastard> <CAHk-=wj+xyz_GKjgKpU6SF3qeqouGmRoR8uFxzg_c1VpeGEJMw@mail.gmail.com>
 <20190115234510.GA6173@dastard> <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
In-Reply-To: <CAHk-=wjc2inOae8+9-DK4jFK78-7ZpNR=TEyZg0Dj57SYwP-ng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jan 2019 17:49:46 +1200
X-Gmail-Original-Message-ID: <CAHk-=wje=2Pndo+xZ5fLJ9VCoo6NYLV_a9D8mxpuSTFdz3eGMg@mail.gmail.com>
Message-ID: <CAHk-=wje=2Pndo+xZ5fLJ9VCoo6NYLV_a9D8mxpuSTFdz3eGMg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>,
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

On Wed, Jan 16, 2019 at 4:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Jan 16, 2019 at 11:45 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > I'm assuming that you can invalidate the page cache reliably by a
> > means that does not repeated require probing to detect invalidation
> > has occurred. I've mentioned one method in this discussion
> > already...
>
> Yes. And it was made clear to you that it was a bug in xfs dio and
> what the right thing to do was.

Side note: I actually think we *do* the right thing. Even for xfs. I
couldn't find the alleged place that invalidates the page cache on dio
reads.

The *generic* dio code only does it for writes (which is correct and
fine). And maybe xfs has some extra invalidation, but I don't see it.

So I actually hope your "you can use direct-io read to do directed
invalidating of the page cache" isn't true. I admittedly did *not* try
to delve very deeply into it, but the invalidates I found looked
correct. The generic code does it for writes, and at least ext4 does
the "writeback and wait" for reads.

There *does* seem to be a 'invalidate_inode_pages2_range()' call in
iomap_dio_rw(). That has a *comment* that says it only is for writes,
but it looks to me like it would trigger for reads too.

Just a plain bug/oversight? Or me misreading things.

So yes, maybe xfs does that "invalidate on read", but it really seems
to be just a bug. If the xfs people insist on keeping the bug, fine
(looks like gfs2 and xfs are the only users), but it seems kind of
sad.

             Linus
