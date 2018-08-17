Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6971CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098A9219CB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KpYTT5iy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098A9219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeHQXcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:32:03 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:55109 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeHQXcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:32:03 -0400
Received: by mail-it0-f41.google.com with SMTP id s7-v6so12982328itb.4;
        Fri, 17 Aug 2018 13:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K19uSTi5oPInQtM9LSDQyTC872d21K02gb4iQ3tw1kw=;
        b=KpYTT5iy17gdMAkfmKRSLETWO4j8sE1Tv0jxybX2UI8P/CvoUEYsqBdcOrErjiD/2C
         Mb8Awkjnf8iCUHKqyexLi5zBYOlDQ/ZYLOKo9xQ/V0i1nCG4xm9Nv5xU5z6D5xLtFZEa
         amhPrHR1ffrNZ66sdLYoair2zmON7okPVH4v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K19uSTi5oPInQtM9LSDQyTC872d21K02gb4iQ3tw1kw=;
        b=HdIi3pzu64MXL30zqnBGE9o4Rm9SUHvCK+JWlLVsdhPy2vveiU5rnWqrel21Nq3qvC
         nfM1+xnsCWUhvzjhQlGc96jVAzD8ZPlh+Tp71qlnIb4k96lhQ9I0zJ+ebl6b+VwPffl2
         04lQXnssZiepZtjR5NQkwOUzyMeKtoWUsB7aCxIh8qVppVEs49DlFX4MySaCstyh45PX
         2sOPukc9tak46YK7ZSFvnp6iEWvOv8UVFNQSSM95OE0BbiF9bJ9bLfm7TRq87EjuHMoZ
         wJkJwCcB0isMVdDVYcs0HYypXHExvTZMxgcmp4ZoQ67dSP2CafOOrlE3QU0vzP4nLjRU
         2VQg==
X-Gm-Message-State: AOUpUlFE0CYm6751VdfjYAj0mYtwW1QZaFY2Ft8a9h3X8h8sfskei1JL
        mV4Bv2lG71nZ5/81aQhYBTTCQ/PA8KB6+rhJoQU=
X-Google-Smtp-Source: AA+uWPxMu0hDHXLy100zD2BcNFmYKI7rUhmS3l5onYY+ruZfronTUg5F3AHK0HOsvjETmkHqelA12NlwrBsltwZIpps=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr25879012itb.123.1534537634262;
 Fri, 17 Aug 2018 13:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180816215726.GA20526@ziepe.ca> <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
 <20180817201535.GI28676@mellanox.com>
In-Reply-To: <20180817201535.GI28676@mellanox.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 13:27:02 -0700
Message-ID: <CA+55aFzcp=a2sNOVR7DTEY9dehYamXaJ1bpSfF0FZir_9MhsVg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 1:15 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> We often have merge conflicts with RDMA, how do you prefer to get the
> PR? I'm actually not very clear on this part of the process.

I  generally prefer the non-merged version, but with comments about
the conflicts.

In fact, the really preferred model is generally to send me a
non-merged pull request (say "tags/for-linus") but if the conflicts
look even half-way nasty - or simply because you did the merge anyway
just to get the proper diffstat because history is complex - mention
that you have a merged branch for verification (say
"branch/for-linus-merged").

When I get that kind of pull request, I'll just do the merge
resolution myself, and after I've done it I'll generally then do

   git checkout -b test-merge
   git pull <repoaddress> for-linus-merged

and then just compare the end result with my resolution as an extra
verification step.

I may end up skipping the verification step if everything looks
entirely trivial (and really, if you have no real reason for the
pre-merged branch, don't bother even mentioning it even if you did it
for the diffstat), but in practice whenever somebody does that, I have
no reason not to just do that simple extra verification.

Most of the time the merges are exactly the same, possibly with
whitespace or trivial ordering differences (things like Makefiles and
Kconfig files often have add-add conflicts where the ordering really
doesn't matter between two config options).

And then sometimes it shows that I missed something in my mmerge.

And sometimes it shows that  I do so many merges that I actually ended
up noticing something that the submaintainer didn't.

So it can be uninteresting, and when it isn't uninteresting it can go
either way, but so far for the people who do this, I've never been in
the situation where I was *sorry* for the double merge and extra
verification step.

Because when mis-merges happen (they are happily pretty rare) they are
_so_ annoying and can be so hard to figure out later, that I'd rather
spend a bit more time on the merge than have a dodgy one.

               Linus
