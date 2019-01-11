Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA86220879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 02:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JYnWAo/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfAKCSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 21:18:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42777 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbfAKCSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 21:18:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so9714088lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwEmlRGwHdJ7O3lGFYJW+jg6ng3jN91JyPi2+zBjdEs=;
        b=JYnWAo/Ni7M01k1aLsyCYKOAVaGuikAGimbR96ifjilXyAixrlW/S6dIFIVldFUuB7
         P+oQbm8rz/de5ONsQm0c9mbnLfseb9TIku0uKKxLtZSkOBWe884bL5INJqxLEYT4fa70
         wA3/Al5RSSgoTSyRpLPgS0Qum1NPASPXYVyls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwEmlRGwHdJ7O3lGFYJW+jg6ng3jN91JyPi2+zBjdEs=;
        b=SsBGPM0z2aAekPnvgIJ1Ybr+NZWWaecZhmUhvgzamKDHpmB8ajmypVYAAFABpxJmRe
         zM45U1sbm+GzzruqoV3tzXw+cDSYPdgW2RYBwvmxiEvQOSCobtic+S42O9aBppBhCpme
         d7Vr0bZOu8Qt9QwCOLGlkSubzSjsp9WH76bm4f9GOzUvggBiTwY00gipYXxDmy2cVl82
         YX458YnoPt/TOA4d/URsoWGnDPhruv5fYrhVPr6McaEBSQYaNfEpNT05aa4UN5dYMy9U
         n5RQ8H9udYNn7wQ1ZiG6e1wyXV0QcUfR8czgs3oiPoDA/IMAHtQZNqaHsXgA0rmKRXuU
         +pZg==
X-Gm-Message-State: AJcUukeBIaTjAjuTgNy2WJbcP8HYsrrb+A9WCEBOm3Yp7Ab2oepvb422
        +LifaN7jsqn/lO+Y6pgavD9wTitjg/E=
X-Google-Smtp-Source: ALg8bN4+NE3ctGAuYxlpVd40PErcRosGzZR3X1l43hHUowny63Tyyq2ushz8eBVHw0v5eOibCeCpEQ==
X-Received: by 2002:a19:789:: with SMTP id 131mr7533024lfh.11.1547173114873;
        Thu, 10 Jan 2019 18:18:34 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m13-v6sm15676115ljg.56.2019.01.10.18.18.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 18:18:33 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id u18so9713612lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 18:18:33 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr7540441lfc.124.1547173113051;
 Thu, 10 Jan 2019 18:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <20190111020340.GM27534@dastard>
In-Reply-To: <20190111020340.GM27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 18:18:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
Message-ID: <CAHk-=wgLgAzs42=W0tPrTVpu7H7fQ=BP5gXKnoNxMxh9=9uXag@mail.gmail.com>
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

On Thu, Jan 10, 2019 at 6:03 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Jan 10, 2019 at 02:11:01PM -0800, Linus Torvalds wrote:
> > And we *can* do sane things about RWF_NOWAIT. For example, we could
> > start async IO on RWF_NOWAIT, and suddenly it would go from "probe the
> > page cache" to "probe and fill", and be much harder to use as an
> > attack vector..
>
> We can only do that if the application submits the read via AIO and
> has an async IO completion reporting mechanism.

Oh, no, you misunderstand.

RWF_NOWAIT has a lot of situations where it will potentially return
early (the DAX and direct IO ones have their own), but I was thinking
of the one in generic_file_buffered_read(), which triggers when you
don't find a page mapping. That looks like the obvious "probe page
cache" case.

But we could literally move that test down just a few lines. Let it
start read-ahead.

.. and then it will actually trigger on the *second* case instead, where we have

                if (!PageUptodate(page)) {
                        if (iocb->ki_flags & IOCB_NOWAIT) {
                                put_page(page);
                                goto would_block;
                        }

and that's where RWF_MNOWAIT would act.

It would still return EAGAIN.

But it would have started filling the page cache. So now the act of
probing would fill the page cache, and the attacker would be left high
and dry - the fact that the page cache now exists is because of the
attack, not because of whatever it was trying to measure.

See?

But obviously this kind of change only matters if we also have
mincore() not returning the probe data. mincore() obviously can't do
the same kind of read-ahead to defeat things.

              Linus
