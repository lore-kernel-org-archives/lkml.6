Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0ED82082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 07:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netflix.com header.i=@netflix.com header.b="H1yszSmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbfAPHwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 02:52:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46430 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730076AbfAPHwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 02:52:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id y14so4081381lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 23:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netflix.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFDn5ysZInbYYMmQO8U1DXJt9AnYsoBmKkVlkjzfZYM=;
        b=H1yszSmfXcQwcHnbLw+bx6wvU0WL5aTIQ5hJu2oppIOt0Vq42K4bSpXfnoXcwBVjR5
         brgret9pUAXqqW05+wgG/+qE3nE97JTVBh5q7kjUf2YxC833ygob19mk+wO+AT5p+O1X
         rTKma5dBUQPuIUephTJAIc2HUx0KSJxDJ8qO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFDn5ysZInbYYMmQO8U1DXJt9AnYsoBmKkVlkjzfZYM=;
        b=JLW3IiyE+Uc9S90CwzDZtW62N1y1Xv/3+5uBdC3kq6yOXgWA8NeTSSLoBsoZdseppb
         SE33lwOzelEFeO4DiE4tO9QLxfnP2rivraFe1BhaozooP9PHa50KARSm6SlCmN+xL1dd
         hRaq3ZX4r2do8ubhbd7MFip96cGVOL6r5FpbePMuDcZvJrqn31Hr1TFXnM4aAfp6Y+Sm
         dhcCQwm4pU3NjCc6NLI6pV+iPjGBNKt4Q4sxFlRwSeEzx+wwAkzK3Go/SMxPEJYaqMGz
         BDfIm4Jrl2DgmI5XnnnGg9UMircOyBLyYXxIVu/S4BtPKFGp9s/HP+kmEtlvzeyXxyq3
         wdzQ==
X-Gm-Message-State: AJcUukeqqBAWpcCkW3czc1UvPrHDHNpmZn4iiF6/ToALd5VRS9n0kFk8
        QHlGDdN/vnQvd4xuYZZDIYt1qwG5bCH4P3rbnjlKDg==
X-Google-Smtp-Source: ALg8bN7F/x7ESxZ+Ge+Zcg/ER7Z0sQjuE0YhIxSxPtUPxFp88JF9rcVqkltIzGwukBCHUUfYD/Z2TxbsjIv4qqfbqN0=
X-Received: by 2002:a19:4402:: with SMTP id r2mr5614346lfa.111.1547625158227;
 Tue, 15 Jan 2019 23:52:38 -0800 (PST)
MIME-Version: 1.0
References: <20190110070355.GJ27534@dastard> <CAHk-=wigwXV_G-V1VxLs6BAvVkvW5=Oj+xrNHxE_7yxEVwoe3w@mail.gmail.com>
 <20190110122442.GA21216@nautica> <CAHk-=wip2CPrdOwgF0z4n2tsdW7uu+Egtcx9Mxxe3gPfPW_JmQ@mail.gmail.com>
 <5c3e7de6.1c69fb81.4aebb.3fec@mx.google.com> <CAHk-=wgF9p9xNzZei_-ejGLy1bJf4VS1C5E9_V0kCTEpCkpCTQ@mail.gmail.com>
 <9E337EA6-7CDA-457B-96C6-E91F83742587@amacapital.net> <CAHk-=wjqkbjL2_BwUYxJxJhdadiw6Zx-Yu_mK3E6P7kG3wSGcQ@mail.gmail.com>
 <20190116054613.GA11670@nautica> <CAHk-=wjVjecbGRcxZUSwoSgAq9ZbMxbA=MOiqDrPgx7_P3xGhg@mail.gmail.com>
 <20190116063430.GA22938@nautica>
In-Reply-To: <20190116063430.GA22938@nautica>
From:   Josh Snyder <joshs@netflix.com>
Date:   Tue, 15 Jan 2019 23:52:25 -0800
Message-ID: <CA+t-nXTfdo07EBvVo+mu8SRhrVyB=mEPLDQikHfpJue1jALJtQ@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
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

On Tue, Jan 15, 2019 at 10:34 PM Dominique Martinet <asmadeus@codewreck.org>
wrote:
>
> There is a difference with your previous patch though, that used to list no
> page in core when it didn't know; this patch lists pages as in core when it
> refuses to tell. I don't think that's very important, though.

Is there a reason not to return -EPERM in this case?

>
> If anything, the 0400 user-owner file might be a problem in some edge
> case (e.g. if you're preloading git directories, many objects are 0444);
> should we *also* check ownership?...

Yes, this seems valuable. Some databases with immutable files (e.g. git, as
you've mentioned) conceivably operate this way.

Josh
