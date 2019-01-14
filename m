Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF1A2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usVYOPw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfANUSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:18:24 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45029 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfANUSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:18:20 -0500
Received: by mail-yw1-f68.google.com with SMTP id b63so124792ywc.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ptzNydK5Q1PCEDwfDmjHWSEiaPwMsBePibwbeCNfTt0=;
        b=usVYOPw9XXkqwoIO39XNY5sffSx9x1nFMRLmaz3VT+CmOEugT2/St7wyNWeLqm200i
         sZu5YUrtr1IQCCSXHYrO1AvsGKK4b8QpjIqkrmC+KdgxEKfUNFwpFkvTo2Zz2q4PYsFG
         WTvHay+dKR8GlcjGluV9AGuRN1j1kok9Nx/aTVWKHcvRT+lLVteAaaBvuuvWhwNL9RQX
         jSnRwv/++jnfkozDPdam6qVe64rDLMuThn6YbCJ+7vJz6G9v7soosaaY7/Z3ubSkY76D
         rI91F6ya3blDaf7Yf+TuW3wvr/m3bmuCgN2OToSzw4ZQb99093m/5gM0Mj4sP2wUuq4H
         49XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ptzNydK5Q1PCEDwfDmjHWSEiaPwMsBePibwbeCNfTt0=;
        b=AORbNSjeONcFYW/6Uf73z9AuMf/SNPgBLDYWskBsazczox2rRgd8AQlyQa2if5/fMs
         CKi+WJyMpqBUy6DLl8v7xFWuJTpbJ5TKpwjzAZDA6NGn9QEeAAtHbRgy324us4RZk/mw
         +PYuMhU9QCOStRvcsJSXukh7lQDAB6umPbxX6Hta6XFnbcgqMkwR+lD6fq9PlpD6FYbB
         Q0LDslViuA/w59bxY77l8B+3Q1JIb+aKwWo3aMBveXmRdcfRSkWmlU+gnaLxxKDrpv07
         JN2nMCWZaxXPk0AijeKTbJiWptj0J3FqFrOYJhDBervkIGZNhwr9mzNW9YmyaWqUXfTb
         cXLw==
X-Gm-Message-State: AJcUukcRd0Tsfbd4eGPGbbkV/Nh+3/2iUdBnx/m5zINPC7UdAQDBpfuG
        ESKU+yzxJh9hKJAlXg/2Ht8tYcGq5iq3/WLREK2tQQ==
X-Google-Smtp-Source: ALg8bN4FXjn4pOrbWmB91djMJ9IikbMNtEpPDKFVEvbzmJGsLAVkWNPM3aI5oDKuZi4IBJsj36JFv9VgyTMv+q1hed8=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr169489ywb.345.1547497099231;
 Mon, 14 Jan 2019 12:18:19 -0800 (PST)
MIME-Version: 1.0
References: <20190110174432.82064-1-shakeelb@google.com> <20190111205948.GA4591@cmpxchg.org>
 <CALvZod7O2CJuhbuLUy9R-E4dTgL4WBg8CayW_AFnCCG6KCDjUA@mail.gmail.com> <20190113183402.GD1578@dhcp22.suse.cz>
In-Reply-To: <20190113183402.GD1578@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Jan 2019 12:18:07 -0800
Message-ID: <CALvZod6paX4_vtgP8AJm5PmW_zA_ecLLP2qTvQz8rRyKticgDg@mail.gmail.com>
Subject: Re: [PATCH v3] memcg: schedule high reclaim for remote memcgs on high_work
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 10:34 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 11-01-19 14:54:32, Shakeel Butt wrote:
> > Hi Johannes,
> >
> > On Fri, Jan 11, 2019 at 12:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > Hi Shakeel,
> > >
> > > On Thu, Jan 10, 2019 at 09:44:32AM -0800, Shakeel Butt wrote:
> > > > If a memcg is over high limit, memory reclaim is scheduled to run on
> > > > return-to-userland.  However it is assumed that the memcg is the current
> > > > process's memcg.  With remote memcg charging for kmem or swapping in a
> > > > page charged to remote memcg, current process can trigger reclaim on
> > > > remote memcg.  So, schduling reclaim on return-to-userland for remote
> > > > memcgs will ignore the high reclaim altogether. So, record the memcg
> > > > needing high reclaim and trigger high reclaim for that memcg on
> > > > return-to-userland.  However if the memcg is already recorded for high
> > > > reclaim and the recorded memcg is not the descendant of the the memcg
> > > > needing high reclaim, punt the high reclaim to the work queue.
> > >
> > > The idea behind remote charging is that the thread allocating the
> > > memory is not responsible for that memory, but a different cgroup
> > > is. Why would the same thread then have to work off any high excess
> > > this could produce in that unrelated group?
> > >
> > > Say you have a inotify/dnotify listener that is restricted in its
> > > memory use - now everybody sending notification events from outside
> > > that listener's group would get throttled on a cgroup over which it
> > > has no control. That sounds like a recipe for priority inversions.
> > >
> > > It seems to me we should only do reclaim-on-return when current is in
> > > the ill-behaved cgroup, and punt everything else - interrupts and
> > > remote charges - to the workqueue.
> >
> > This is what v1 of this patch was doing but Michal suggested to do
> > what this version is doing. Michal's argument was that the current is
> > already charging and maybe reclaiming a remote memcg then why not do
> > the high excess reclaim as well.
>
> Johannes has a good point about the priority inversion problems which I
> haven't thought about.
>
> > Personally I don't have any strong opinion either way. What I actually
> > wanted was to punt this high reclaim to some process in that remote
> > memcg. However I didn't explore much on that direction thinking if
> > that complexity is worth it. Maybe I should at least explore it, so,
> > we can compare the solutions. What do you think?
>
> My question would be whether we really care all that much. Do we know of
> workloads which would generate a large high limit excess?
>

The current semantics of memory.high is that it can be breached under
extreme conditions. However any workload where memory.high is used and
a lot of remote memcg charging happens (inotify/dnotify example given
by Johannes or swapping in tmpfs file or shared memory region) the
memory.high breach will become common.

Shakeel
