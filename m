Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755486AbeD3XP0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 19:15:26 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34518 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755390AbeD3XPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 19:15:21 -0400
X-Google-Smtp-Source: AB8JxZpRdpAxLfUtJKWuQcOyw5FTVMrUEMoqFOnOKu+dv+lG6O24Ued5ikClX799g6XMJi+VrJ7tN5+lV+yt50L9aVs=
MIME-Version: 1.0
In-Reply-To: <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
References: <20180426150618.13470-1-michel@daenzer.net> <20180427130811.7642-1-michel@daenzer.net>
 <CAKb7Uvj6FFRK6dtvR7xpfZDzs0o3QKHq7ESueBBmr_VnQt6XDQ@mail.gmail.com>
 <e8166443-14f0-1eb3-a6a2-d425792b0643@daenzer.net> <d5f9459e-801c-e592-d06d-c9052ef3ad4d@amd.com>
 <e5256136-6da0-cc5e-9490-5a70c89dfd83@daenzer.net> <361a765a-f491-4450-867e-fa88857827ee@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 1 May 2018 09:15:19 +1000
Message-ID: <CAPM=9tzmmT5G5a_2WCH5xpRr6rhY6sHdi-Kg5my0az_=haVZTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/ttm: Only allocate huge pages with new flag TTM_PAGE_FLAG_TRANSHUGE
To: "Koenig, Christian" <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
> Yes, I fixed the original false positive messages myself with the swiotlb
> maintainer and I was CCed in fixing the recent fallout from Chris changes as
> well.

So do we have a good summary of where this at now?

I'm getting reports on 4.16.4 still displaying these, what hammer do I
need to hit things with to get 4.16.x+1 to not do this?

Is there still outstanding issues upstream.

For future reference I think how this should have gone down is

a) AMD implement a public CI with igt tests for all of this
b) we get these patches pushed and debugged.

Though to be a bit more constructive, I think you should have said at
-rc6 or 7 this isn't working for this kernel cycle,
push a minimal patch to back it off, even if the bug is in swiotlb, we
don't just add stuff broken like this, even if it's not
your bug we should have backed off for a kernel or two until we had
the underlying infrastructure fixed. Otherwise we
get what we have now, which is bit of a crappile, because now I've no
idea if the swiotlb things people report are
the false positive, or some new thing.

Dave.
