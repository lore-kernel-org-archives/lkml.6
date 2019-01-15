Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787C1C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475ED20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 19:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzAXW+YI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389396AbfAOTig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 14:38:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:32833 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388713AbfAOTig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 14:38:36 -0500
Received: by mail-yw1-f68.google.com with SMTP id p65so1534302ywe.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cLRbj6ZrwUgB3ed0j9nxtSpZlKaYfrBPTp259N8B/A=;
        b=FzAXW+YIbjj8DpDu2MDZ0WqKcbXJ3SWF4P4UCqbL6HqTDOHlIVL0/XhJBDCgyPXCFc
         FbspV0nhzHZO8u/Ui72yv8BpC0PyJ7HV+HDf66IyeE+1MbtLTIflaluazaHmr553ae2V
         tjAp+4at4o5/IaXTAG1yJwNSn6mW7LZAOVJBfXG4Gacb1DLDnuZmUOn4WiDULexO6/GH
         9igeGGjyTkTLX4hN5Jl3Ad/adMcbKzeZOIxv7YbGYHl7ARq1k0DKmo7G8q+kR0Glzlq4
         pRcRQN+AHiqpTofCYLOpEk3zar28MiDfsBNDsd1eI9MqGjbAlTW8DGTTe+jJ9YP1XpUj
         aHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cLRbj6ZrwUgB3ed0j9nxtSpZlKaYfrBPTp259N8B/A=;
        b=F4cGuAEpvv4bnSxoJ0ZwUHODznXm2ffcaHKu8bn0EmmoJ1ue5AAsf4XAFY+tj0EOkP
         RkJoajYgihJGPnt5+t0I6TUwvOlvEhE4O7qYzdoQxe+bH5MGMEapx8SI4DYZr62Rmp32
         3L94p4NYHOojeRemUCYG2R3RNMw+e2Xm9vvLIW/bGP1fsklIKO9/1pmhKp+bIHk0J+GC
         eHIonbxLiAFvlZlEBK8HFabrUDj8VGGnNyz9Ijdy4GvunL+ygLUcZCLFP+wOM9Sg6JW8
         8rBr/wsLLaBVAfTNOkjrtgzXTiFrOTQjHXAvzSC2p5YI+s/6sJvM1VVB2cVgf5BSgUV9
         YhMA==
X-Gm-Message-State: AJcUukeSPf5Q25blZJnX/3dmMgAyf3yQG5PR8aKaV74sfD+/7BoXNqAF
        jyXyEHEhQnci1AmtMAt0OoCGC22p+bnP69mN3uMaNw==
X-Google-Smtp-Source: ALg8bN7Vxx2AeMbVykY9japellF7+ir8UaUpIcIPYA19UNwpNQo4G0nfXJhT8X3UW1MwgOkVr3qIxdIScB5X9LFw4ns=
X-Received: by 2002:a81:ee07:: with SMTP id l7mr4491703ywm.489.1547581114321;
 Tue, 15 Jan 2019 11:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20190110174432.82064-1-shakeelb@google.com> <20190111205948.GA4591@cmpxchg.org>
 <CALvZod7O2CJuhbuLUy9R-E4dTgL4WBg8CayW_AFnCCG6KCDjUA@mail.gmail.com>
 <20190113183402.GD1578@dhcp22.suse.cz> <CALvZod6paX4_vtgP8AJm5PmW_zA_ecLLP2qTvQz8rRyKticgDg@mail.gmail.com>
 <20190115072551.GO21345@dhcp22.suse.cz>
In-Reply-To: <20190115072551.GO21345@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Jan 2019 11:38:23 -0800
Message-ID: <CALvZod6U+OGZJ1mcSG++Q5CJtEjLbr3pwvLRBbkpbZbqf6YSsA@mail.gmail.com>
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

On Mon, Jan 14, 2019 at 11:25 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 14-01-19 12:18:07, Shakeel Butt wrote:
> > On Sun, Jan 13, 2019 at 10:34 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Fri 11-01-19 14:54:32, Shakeel Butt wrote:
> > > > Hi Johannes,
> > > >
> > > > On Fri, Jan 11, 2019 at 12:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > Hi Shakeel,
> > > > >
> > > > > On Thu, Jan 10, 2019 at 09:44:32AM -0800, Shakeel Butt wrote:
> > > > > > If a memcg is over high limit, memory reclaim is scheduled to run on
> > > > > > return-to-userland.  However it is assumed that the memcg is the current
> > > > > > process's memcg.  With remote memcg charging for kmem or swapping in a
> > > > > > page charged to remote memcg, current process can trigger reclaim on
> > > > > > remote memcg.  So, schduling reclaim on return-to-userland for remote
> > > > > > memcgs will ignore the high reclaim altogether. So, record the memcg
> > > > > > needing high reclaim and trigger high reclaim for that memcg on
> > > > > > return-to-userland.  However if the memcg is already recorded for high
> > > > > > reclaim and the recorded memcg is not the descendant of the the memcg
> > > > > > needing high reclaim, punt the high reclaim to the work queue.
> > > > >
> > > > > The idea behind remote charging is that the thread allocating the
> > > > > memory is not responsible for that memory, but a different cgroup
> > > > > is. Why would the same thread then have to work off any high excess
> > > > > this could produce in that unrelated group?
> > > > >
> > > > > Say you have a inotify/dnotify listener that is restricted in its
> > > > > memory use - now everybody sending notification events from outside
> > > > > that listener's group would get throttled on a cgroup over which it
> > > > > has no control. That sounds like a recipe for priority inversions.
> > > > >
> > > > > It seems to me we should only do reclaim-on-return when current is in
> > > > > the ill-behaved cgroup, and punt everything else - interrupts and
> > > > > remote charges - to the workqueue.
> > > >
> > > > This is what v1 of this patch was doing but Michal suggested to do
> > > > what this version is doing. Michal's argument was that the current is
> > > > already charging and maybe reclaiming a remote memcg then why not do
> > > > the high excess reclaim as well.
> > >
> > > Johannes has a good point about the priority inversion problems which I
> > > haven't thought about.
> > >
> > > > Personally I don't have any strong opinion either way. What I actually
> > > > wanted was to punt this high reclaim to some process in that remote
> > > > memcg. However I didn't explore much on that direction thinking if
> > > > that complexity is worth it. Maybe I should at least explore it, so,
> > > > we can compare the solutions. What do you think?
> > >
> > > My question would be whether we really care all that much. Do we know of
> > > workloads which would generate a large high limit excess?
> > >
> >
> > The current semantics of memory.high is that it can be breached under
> > extreme conditions. However any workload where memory.high is used and
> > a lot of remote memcg charging happens (inotify/dnotify example given
> > by Johannes or swapping in tmpfs file or shared memory region) the
> > memory.high breach will become common.
>
> This is exactly what I am asking about. Is this something that can
> happen easily? Remote charges on themselves should be rare, no?
>

At the moment, for kmem we can do remote charging for fanotify,
inotify and buffer_head and for anon pages we can do remote charging
on swap in. Now based on the workload's cgroup setup the remote
charging can be very frequent or rare.

At Google, remote charging is very frequent but since we are still on
cgroup-v1 and do not use memory.high, the issue this patch is fixing
is not observed. However for the adoption of cgroup-v2, this fix is
needed.

Shakeel
