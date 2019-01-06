Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61357C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131B62070D
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 21:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/bEAEry"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfAFVq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 16:46:58 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34338 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfAFVq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 16:46:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so28848768lfc.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 13:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nn7oD0ol2iP0y2yprlx6IYbrc5ZCwYkBInEfjdZxW1Q=;
        b=M/bEAErya4WRSn1yBbBGino0mk0VL3ARKUKSUTjPHagjtYO0zZ0S6MvcT7J5V2CWp6
         bOL3Jrs2fvoni9kUHg4lOokcHUJ6H5QMa6syqJfEW0w/haX0AYMs8KJlqwsGEDtCkz6u
         nXNYcC+GPtGSdTNy5xuCQTCKFgzJZ+nNo6Yy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nn7oD0ol2iP0y2yprlx6IYbrc5ZCwYkBInEfjdZxW1Q=;
        b=aicCw1xnrxyYLO5xK9nxjJFMJbCXfkGKrKvpO4rxP6ycvKUEHDS56wtcgQD2yBqgBj
         uLHxtm7ZijbZc0LmD+QsXhp9kpOilfgaIWd2Dcdkx1V5zBhE9jjSIqyX/uAlpLJz3TzK
         /4qffcKSuGua5TLq/3wMIHy7IxXwWBLrUPqalQKWNzJZhZDF9zqJ3N1FWjkm4A/8d6oy
         +1/PusZDGxXtcFOtApEpFUEnBV1X5CkKn6jla9fGixV1lZeKM+ES53drgK//HcIVwUsS
         CQD6itqNRONoeuraTwSL4tY8dNtLXFfpmVtP7V7pDfTSmC/F+UNNqOHOkHCOC3ZnWN2Y
         iyKQ==
X-Gm-Message-State: AA+aEWar8B1MZ22/15Xaq741ffcwQZpHGeiaoCrTAzYZwARJWx/TGXyu
        ua2LGz8mrQUBNeOkBp24gvvW9SCuxQw=
X-Google-Smtp-Source: AFSGD/XNDBEkT1hzR46U3Q4avdkGOLMQPMLtlTGWCYCiNVPe7kICK0I1NguQIYnLnaZztDvDtyihpw==
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr27973758lfe.152.1546811215071;
        Sun, 06 Jan 2019 13:46:55 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r76-v6sm13691664ljr.83.2019.01.06.13.46.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 13:46:53 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id g11-v6so36492490ljk.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 13:46:53 -0800 (PST)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr11741960ljh.59.1546811213226;
 Sun, 06 Jan 2019 13:46:53 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
 <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
In-Reply-To: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jan 2019 13:46:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
Message-ID: <CAHk-=wiqbKEC5jUXr3ax+oUuiRrp=QMv_ZnUfO-SPv=UNJ-OTw@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
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

On Sat, Jan 5, 2019 at 5:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Slightly updated patch in case somebody wants to try things out.

I decided to just apply that patch. It is *not* marked for stable,
very intentionally, because I expect that we will need to wait and see
if there are issues with it, and whether we might have to do something
entirely different (more like the traditional behavior with some extra
"only for owner" logic).

But doing a test patch during the merge window (which is about to
close) sounds like the right thing to do.

                 Linus
