Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ECFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15AB2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEpu/iiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfAKWyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:54:45 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:42295 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfAKWyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:54:44 -0500
Received: by mail-yb1-f194.google.com with SMTP id q145so6464460ybq.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 14:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zNLkCKY+SwAC6X03tE2DXpF/Ov1i3/WPtlft+zOut7Q=;
        b=FEpu/iiLCbxOefMnzM+e29eZKUax+WKTJ9cjl7jOddbTZebY2/SostcNctqDa4Dx1d
         6PVGqwf/eCG5vnokQvGr4clowLfbg9xLUZSMTuLRfbpPvCHlaY+r0yVqlebFpQBruaV6
         lpGG8ufiLq04g9gN1mr9xx3dGHW2oYOasQKFdaUk5gry9EnW89oel9439Cf4X2wo7fRV
         6SjB4/q2uvmLUY6xdEowY1v/MCl4iduT4Ws1P/pzxqenWqc/QYNbjXJpSLwcZsvrULgI
         gCwPzn2kRQKyMt4LWg8uPyulInvJ63418sXt8UOrwObgJNQlkxH8xLhrQ8iD4eGPD2cb
         wjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNLkCKY+SwAC6X03tE2DXpF/Ov1i3/WPtlft+zOut7Q=;
        b=YOxn/Hzgbzy6yl7g5lDpUDdxI0r3plNbpO60ZxbOP1hSY89LG9sf5yVAePhGuxCytu
         ZP6liC1UiPvh9gd1+9WkrKEeldsBxBKBFASq1dJMzCIojVZhd9MynuPPs57BqI4EzVtI
         xLoUqgvE8TjfiLnkLP5lEOFAGr+UP4obdn3Qkr9Bx5OazdLUS8AMuZr8DUzafDZe3pwC
         eV58corTkScHG9nqu53+sQ+vtlfpg7t7oODu1PMvJ6tEgdbNZKW90+bWb/cA/8CZeFu9
         oi+YrfSktMB6oHLlCW7lNOXuMWnlCkO/d3L2UxV2imnrbwTgjGSBl9iGoWkMJknFm1Cu
         PUBQ==
X-Gm-Message-State: AJcUukcCY0HEIqRZgpG0WSCL7+DYJgzLfjslIT1quAkQZPdsJG/EfRwO
        QJe7hp76avC0iztNQbaRGewQqSW0hZkAcW1OvHMNog==
X-Google-Smtp-Source: ALg8bN58sg1/k3eAFawuHi7YEe3TN+vxtPFSanna48jdOcq38wo8Sg27Eph82abwE/4dr65J2nl/OGgjza8a2AtX4xQ=
X-Received: by 2002:a25:2743:: with SMTP id n64mr959711ybn.164.1547247283381;
 Fri, 11 Jan 2019 14:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20190110174432.82064-1-shakeelb@google.com> <20190111205948.GA4591@cmpxchg.org>
In-Reply-To: <20190111205948.GA4591@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Jan 2019 14:54:32 -0800
Message-ID: <CALvZod7O2CJuhbuLUy9R-E4dTgL4WBg8CayW_AFnCCG6KCDjUA@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: schedule high reclaim for remote memcgs on high_work
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Fri, Jan 11, 2019 at 12:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Hi Shakeel,
>
> On Thu, Jan 10, 2019 at 09:44:32AM -0800, Shakeel Butt wrote:
> > If a memcg is over high limit, memory reclaim is scheduled to run on
> > return-to-userland.  However it is assumed that the memcg is the current
> > process's memcg.  With remote memcg charging for kmem or swapping in a
> > page charged to remote memcg, current process can trigger reclaim on
> > remote memcg.  So, schduling reclaim on return-to-userland for remote
> > memcgs will ignore the high reclaim altogether. So, record the memcg
> > needing high reclaim and trigger high reclaim for that memcg on
> > return-to-userland.  However if the memcg is already recorded for high
> > reclaim and the recorded memcg is not the descendant of the the memcg
> > needing high reclaim, punt the high reclaim to the work queue.
>
> The idea behind remote charging is that the thread allocating the
> memory is not responsible for that memory, but a different cgroup
> is. Why would the same thread then have to work off any high excess
> this could produce in that unrelated group?
>
> Say you have a inotify/dnotify listener that is restricted in its
> memory use - now everybody sending notification events from outside
> that listener's group would get throttled on a cgroup over which it
> has no control. That sounds like a recipe for priority inversions.
>
> It seems to me we should only do reclaim-on-return when current is in
> the ill-behaved cgroup, and punt everything else - interrupts and
> remote charges - to the workqueue.

This is what v1 of this patch was doing but Michal suggested to do
what this version is doing. Michal's argument was that the current is
already charging and maybe reclaiming a remote memcg then why not do
the high excess reclaim as well.

Personally I don't have any strong opinion either way. What I actually
wanted was to punt this high reclaim to some process in that remote
memcg. However I didn't explore much on that direction thinking if
that complexity is worth it. Maybe I should at least explore it, so,
we can compare the solutions. What do you think?

Shakeel
