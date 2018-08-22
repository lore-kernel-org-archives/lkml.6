Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAE1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EE021837
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DkMiT0fv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EE021837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbeHVGXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:23:20 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:50663 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHVGXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:23:20 -0400
Received: by mail-it0-f65.google.com with SMTP id j81-v6so1192861ite.0;
        Tue, 21 Aug 2018 20:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehmMJcjx9zcIA5zS1u/TheMvFlyFqEcPsMLE4+0uvZE=;
        b=DkMiT0fvAJXF0XgeV3a5S1oCTVZR5161XLdmygSWDLAxGhsr+jHM32hypcJNdgb3dj
         SDXa3SV1MccqXbyuPzV7flJfPtPHRujDkvSYK4Sv0ts55I8JnxM/18pd75Gr0XDwaJcG
         5j+t42sCi+MuA2SFliEeLxp42/Hq0STElykQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehmMJcjx9zcIA5zS1u/TheMvFlyFqEcPsMLE4+0uvZE=;
        b=r2Vlq5qzO/wWaMgZ3kmKmGKnpJm3ZDPv1S+19A6gBwsdpOMFWC9EOQWRWT+7CAOO7e
         s+Gmk5o/WXjMii0Y4lYdlM7tnRtZtNIPvK0FJZdEpXfQmSZr7NUGPDjCDj1wymkng0T0
         EgKX9ZOaCt3heRzJ0/xbQAbQJqgSXP6VNaUDOP1+pXRq6gYQAEffuyMF+MaEOEGLgYSg
         PSRBtaJ12koG+pCFr+tX0PR+jDMzU6Yk9l2JK1kREQEU6+RsroqE5Nh+ry9BUEZTDXzK
         rK4TGA5Qty7per76q7NR0/SaiGSszqA2M1FjQIL6dctHh4ijPlOAneHUVQb58baXpQp4
         XtBA==
X-Gm-Message-State: AOUpUlFLL7LeOAKws5ZR+Ec73PzCdxHQwj0ChtlaFe54na/FVMozQ0jC
        pIPV4tbV7qyWEs+2nWS+FODqrrN1GtfeF2tE1pU=
X-Google-Smtp-Source: AA+uWPxuL2+1UR4+XBSsHnCzvZt5cDrbOWo/CzqFIcOeey9KOOZrQGkxO7+dnQD3mAM/VXMflTBrpsRD/hJzuKIB0j4=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr47835088jaf.70.1534906830158;
 Tue, 21 Aug 2018 20:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161357.GB1199@bombadil.infradead.org> <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
 <20180822025040.GA12244@bombadil.infradead.org>
In-Reply-To: <20180822025040.GA12244@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Aug 2018 20:00:18 -0700
Message-ID: <CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjoRQX_g@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.19
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 7:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> So, should I have based just on your tree and sent you a description of
> what a resolved conflict should look like?

Absolutely.

Or preferably not rebasing at all, just starting from a good solid
base for new development in the first place.

Sometimes you start from the wrong point, and decide that you really
need to rebase, but then you should rebase to a more stable point, not
on top of some random independent development.

Rebasing can be a really good tool to clean up development that was
haphazard - maybe as you  go along you notice that something you did
earlier turned out to be counter-productive, so you rebase and clean
up your history that has not been made public yet.

But when you send me a big new feature, the absolutely *last* thing I
want to ever see is to see it based on some random unstable base.

And rebasing to avoid merge conflicts is *always* the wrong thing to
do, unless the reason you're rebasing is "hey, I wrote this feature
ages ago, I need to really refresh it to a more modern and stable
kernel, so I'll rebase it onto the current last release instead, so
that I have a good starting point".

And even then the basic reason is not so much that there were
conflicts, but that you just want your series to make more sense on
its own, and not have one horribly complex merge that is just due to
the fact that it was based on something ancient.

The absolute last thing I want to see during the merge window is
multiple independent features that have been tied together just
because they are rebased on top of each other.

Because that means - as in this case - that if one branch has
problems, it now affects all of them.

Merge conflicts aren't bad. In 99% of all cases, the conflict is
trivial to solve. And the cost of trying to deal with them with
rebasing is much much higher.

               Linus
