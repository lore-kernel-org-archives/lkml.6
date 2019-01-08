Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28664C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFA7206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GokJAs66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfAHR6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:58:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32916 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfAHR6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:58:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so3623819lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=db+M0hMXHCoSkBdeDd5EZtIcwj8USIPc3aH5GApnu2E=;
        b=GokJAs66VB328JuQAj7nCMPOAKLlFcIc1p0dIohaE7gWVg6SFWJMtUNk8AtOJne6fl
         ykxMuYplWSTTnqZD6aJrfG9Fs/q+OYzkO7lTF3D5CUolWfqub2ihmQauLhXG90AsQt1c
         6/pQk57mtM2CylvQftRJfayqv1m0lTg+9u4aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=db+M0hMXHCoSkBdeDd5EZtIcwj8USIPc3aH5GApnu2E=;
        b=McPhyMT/aDu6hnUEvcNEV4FQsRgQ0f2KsSgHlZc1bvt7gSLxMwWwNSA4OfL2Gs/RCy
         6ZQlXUM8dbNAp6XSsozZDpqyM0jfFEz0aOeUP/+X5K4ngSvZVBhCA0al/7eQmqfYGPeQ
         TAmEeb0N6n7g96Tb/LEx8Gu4nm+cXZms2afoIabUpsZqt79ZVqF0u4NdhpOt3lYM4qr6
         jFil2r5038ucDGZfFPIKv1ei4GLHiJylYA8AcW5mWGWPHrTlfUaQOiYUjWmxrkKFgifg
         yjyk6KllmrYmPKx6VICliZVQ9S7sjJlPxBM30PSxDtj5gG56uQ5MnJwWvIrJOr0H3H4N
         v5gw==
X-Gm-Message-State: AJcUukfQBWY2OlRfZIGSqh12wV/BmPZKW5uDWbaFzgmxLuLQ7a6KodaY
        ovfb8lOGTJTCK5rQFYbZ7ZJyDsGXcbGOZQ==
X-Google-Smtp-Source: ALg8bN56J+XSQ3GX9XvUYtgbFT6Rs/4QESdDkM+ZYbpGqRN5qRkar+XefjDAWNebPZe+KWPiHRn89w==
X-Received: by 2002:a19:10a4:: with SMTP id 36mr1626956lfq.60.1546970288376;
        Tue, 08 Jan 2019 09:58:08 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id m1sm13295384lfb.56.2019.01.08.09.58.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:58:07 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id y11so3608247lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:58:06 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr1719606lfc.124.1546970286304;
 Tue, 08 Jan 2019 09:58:06 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
 <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com> <20190108044336.GB27534@dastard>
In-Reply-To: <20190108044336.GB27534@dastard>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 09:57:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
Message-ID: <CAHk-=wjvzEFQcTGJFh9cyV_MPQftNrjOLon8YMMxaX0G1TLqkg@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dave Chinner <david@fromorbit.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>,
        Jiri Kosina <jikos@kernel.org>,
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

On Mon, Jan 7, 2019 at 8:43 PM Dave Chinner <david@fromorbit.com> wrote:
>
> So, I read the paper and before I was half way through it I figured
> there are a bunch of other similar page cache invalidation attacks
> we can perform without needing mincore. i.e. Focussing on mmap() and
> mincore() misses the wider issues we have with global shared caches.

Oh, agreed, and that was discussed in the original report too.

The thing is, you can also depend on our pre-faulting of pages in the
page fault handler, and use that to get the cached status of nearby
pages. So do something like "fault one page, then do mincore() to see
how many pages near it were mapped". See our "do_fault_around()"
logic.

But mincore is certainly the easiest interface, and the one that
doesn't require much effort or setup. It's also the one where our old
behavior was actually arguably simply stupid and actively wrong (ie
"in caches" isn't even strictly speaking a valid question, since the
caches in question may be invalid). So let's try to see if giving
mincore() slightly more well-defined semantics actually causes any
pain.

I do think that the RWF_NOWAIT case might also be interesting to look at.

                 Linus
