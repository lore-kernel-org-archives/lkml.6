Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FEDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E478720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AoIGPgeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbfAPFAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:00:49 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41718 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAPFAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:00:48 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so3844451lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MyahoR9gA3cZPmJ4fRmUUg2fkKftA4/cTtIIntxPKm0=;
        b=AoIGPgeIUOnsX1DPPQIz4mINWsh4eAVO7IZuYdn9y4NELoNnTOraTGcibFzGsdnWQu
         kZll5DLe2ClnMoYrsv4IXeCv2kriiDIwHXaVU6mcbZKXlqLHoeZXdJtz+8Islp9hHoGC
         sy7X+9W6kpegaZwAxwmWrxB6j8+30F1v7C9/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MyahoR9gA3cZPmJ4fRmUUg2fkKftA4/cTtIIntxPKm0=;
        b=cHdyrkfJZhTCeTF67YSamdkKEIHiVrCi3yg+FTe36r9UGyoWKWR09PxldkgxrInM+k
         kufjOycHBkVvetptm2+A27YWBAt94bhmhuJfR5mufhTlSK2MzyVcQi457XOXxIHdjuox
         GpHmpo0Qd9OAuBrWqdXs1jUvJ+WuyprUTRxNNNQsYh/dwL9vsbVOfWfpLBhA/5Vwf6gm
         gH/POWcOIixADAEzPED7CwaVVOSQM0ekpT7VT6htFB15l+KJZFsPdx3FqzcmcGGtD4v1
         7xDn8hSb+8jactWsSATljCHdFmPYMYu16ZQRCWn1dQRyb+cpcFhbbtSadIPDAWFf0lGV
         I5tA==
X-Gm-Message-State: AJcUuke2Td63srfabFGw5A+me3kbuMYepejIMTWoiFzWM5i1MYcuvM/y
        cWWDOLRNtNA9tmZHjukhrx3a6q3jPxM=
X-Google-Smtp-Source: ALg8bN5VbWrT48Q/1PqUHL52rxNobs2R8sdEjcvXpZdf3FD+MHjyff017OZa+d572CHzFD/3kGH/9g==
X-Received: by 2002:a19:2584:: with SMTP id l126mr5149040lfl.69.1547614846067;
        Tue, 15 Jan 2019 21:00:46 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b81-v6sm871546ljb.7.2019.01.15.21.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 21:00:43 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id e26so3862061lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 21:00:42 -0800 (PST)
X-Received: by 2002:a19:c014:: with SMTP id q20mr5034140lff.16.1547614842100;
 Tue, 15 Jan 2019 21:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20190108044336.GB27534@dastard> <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
 <20190109022430.GE27534@dastard> <nycvar.YFH.7.76.1901090326460.16954@cbobk.fhfr.pm>
 <20190109043906.GF27534@dastard> <CAHk-=wic28fSkwmPbBHZcJ3BGbiftprNy861M53k+=OAB9n0=w@mail.gmail.com>
 <20190110004424.GH27534@dastard> <CAHk-=wg1jSQ-gq-M3+HeTBbDs1VCjyiwF4gqnnBhHeWizyrigg@mail.gmail.com>
 <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
In-Reply-To: <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Jan 2019 17:00:25 +1200
X-Gmail-Original-Message-ID: <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
Message-ID: <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Josh Snyder <joshs@netflix.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Dave Chinner <david@fromorbit.com>,
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

On Wed, Jan 16, 2019 at 12:42 PM Josh Snyder <joshs@netflix.com> wrote:
>
> For Netflix, losing accurate information from the mincore syscall would
> lengthen database cluster maintenance operations from days to months.  We
> rely on cross-process mincore to migrate the contents of a page cache from
> machine to machine, and across reboots.

Ok, this is the kind of feedback we need, and means I guess we can't
just use the mapping existence for mincore.

The two other ways that we considered were:

 (a) owner of the file gets to know cache information for that file.

 (b) having the fd opened *writably* gets you cache residency information.

Sadly, taking a look at happycache, you open the file read-only, so
(b) doesn't work.

Judging just from the source code, I can't tell how the user ownership
works. Any input on that?

And if you're not the owner of the file, do you have another
suggestion for that "Yes, I have the right to see what's in-core for
this file". Because the problem is literally that if it's some random
read-only system file, the kernel shouldn't leak access patterns to
it..

                     Linus
