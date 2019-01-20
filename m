Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DE6C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384BD20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvHYWjA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfAUHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:32:41 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42113 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfAUHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:32:41 -0500
Received: by mail-yb1-f195.google.com with SMTP id q145so6790196ybq.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVWug8Y2Ns5o1OPZVIkMf1S2JdPZN07bhMcpTWiOsqE=;
        b=FvHYWjA385j/IdO0J937EWIjOGmT2E9/HvCkAqB997Srj0BN7ANK7ru7SqXyQDdIOZ
         46uFSw3JgtVdVpa4C/M55nkP4/N/rtsxHYc03v+ayds2x19Dhq/+GamhCjDQrI8Q0EKS
         2wf8Iqy4t7FCvBmDABUY2j8KABp3gmR/xLs0HCQic/kp/mR05NfJZEBAPabmhh9OynEO
         gvvkY+490tsUhw+hf8rmrDZGwa8WQwIi/hPv6P2MnITMHuRUCEYXeTLiykUWMzr6s2I7
         f+MLv0cqqFmzB1IrOS+MsdkNS5piEi11IRitRpfhhWWnKYrzw2YnJScyqc74wUCLql9Z
         sBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVWug8Y2Ns5o1OPZVIkMf1S2JdPZN07bhMcpTWiOsqE=;
        b=Ki5XTUTLtyZPkeTVDgBSksPYZuLznjvtx4dSe4yUp5XAUF8t5YJS7O2cxpp9EMOIKI
         VPT1HQB080yl1cC48+PU++oBaS+gBP0m69OblvHMmF9EvohOLrgosYwO+CqLdCxsfvtF
         AyWDNoyPnvP1BBSO2LpIVWBoFTJ7qs1aHdjY9r9i7jM7eKHlKQ8ZFiSGMvSbgrdiHTVs
         Z5GzZy4SchmldQz23FgSRZW7K/bsGNdWxtJFtApfgcwwdkS+5HOxt3t8jy6rs2dQmBKx
         rZhjMmSbSkCT1IoqTB/WsFw5U84/zhPNqyfOfkmJVtsgrIE1QPpm0cYUDVmJwXdBMyit
         FXKw==
X-Gm-Message-State: AJcUukdiWRERrREP4LDZhr07DnedhJlS1JqHme+DWDqvKczGLKkw0vKD
        p00j1srql/B0WMpNWuiuTeyPxf7oWGYBPcJTqVOQA6Ffh2c=
X-Google-Smtp-Source: ALg8bN6Q/qsc2n5y4uUzQDlUmsve6sirgrw5MTByulwHQoaWncZN+PGTc0fSmkcHbt6V/XIIw0/QoYYtLXltzIUlmBQ=
X-Received: by 2002:a25:d7c5:: with SMTP id o188mr14584562ybg.464.1548015873274;
 Sun, 20 Jan 2019 12:24:33 -0800 (PST)
MIME-Version: 1.0
References: <20190119005022.61321-1-shakeelb@google.com> <20190119070934.GD4087@dhcp22.suse.cz>
In-Reply-To: <20190119070934.GD4087@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 20 Jan 2019 12:24:22 -0800
Message-ID: <CALvZod7Dk-TLFHf1wi=qLAY3nv4t6grEmJkppZz=JB3GutXC+g@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, oom: fix use-after-free in oom_kill_process
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:09 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 18-01-19 16:50:22, Shakeel Butt wrote:
> [...]
> > On looking further it seems like the process selected to be oom-killed
> > has exited even before reaching read_lock(&tasklist_lock) in
> > oom_kill_process(). More specifically the tsk->usage is 1 which is due
> > to get_task_struct() in oom_evaluate_task() and the put_task_struct
> > within for_each_thread() frees the tsk and for_each_thread() tries to
> > access the tsk. The easiest fix is to do get/put across the
> > for_each_thread() on the selected task.
>
> Very well spotted! The code seems safe because we are careful to
> transfer the victim along with reference counting but I've totally
> missed that the loop itself needs a reference. It seems that this has
> been broken since the heuristic has been introduced. But I haven't
> checked it closely. I am still on vacation.
>
> > Now the next question is should we continue with the oom-kill as the
> > previously selected task has exited? However before adding more
> > complexity and heuristics, let's answer why we even look at the
> > children of oom-kill selected task?
>
> The objective was the work protection assuming that children did less
> work than their parrent. I find this argument a bit questionable because
> it highly depends a specific workload while it opens doors for
> problematic behavior at the same time. If you have a fork bomb like
> workload then it is basically hard to resolve the OOM condition as
> children have barely any memory so we keep looping killing tasks which
> will not free up much. So I am all for removing this heuristic.
>
> > The select_bad_process() has already
> > selected the worst process in the system/memcg. Due to race, the
> > selected process might not be the worst at the kill time but does that
> > matter matter?
>
> No, we don't I believe. The aim of the oom killer is to kill something.
> We will never be ideal here because this is a land of races.
>
> > The userspace can play with oom_score_adj to prefer
> > children to be killed before the parent. I looked at the history but it
> > seems like this is there before git history.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Fixes: 5e9d834a0e0c ("oom: sacrifice child with highest badness score for parent")
> Cc: stable
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!

Thanks for the review. I will keep this for the stable branches and
for the next release I will remove this whole children selection
heuristic.

Shakeel

> > ---
> >  mm/oom_kill.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 0930b4365be7..1a007dae1e8f 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -981,6 +981,13 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >        * still freeing memory.
> >        */
> >       read_lock(&tasklist_lock);
> > +
> > +     /*
> > +      * The task 'p' might have already exited before reaching here. The
> > +      * put_task_struct() will free task_struct 'p' while the loop still try
> > +      * to access the field of 'p', so, get an extra reference.
> > +      */
> > +     get_task_struct(p);
> >       for_each_thread(p, t) {
> >               list_for_each_entry(child, &t->children, sibling) {
> >                       unsigned int child_points;
> > @@ -1000,6 +1007,7 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >                       }
> >               }
> >       }
> > +     put_task_struct(p);
> >       read_unlock(&tasklist_lock);
> >
> >       /*
> > --
> > 2.20.1.321.g9e740568ce-goog
>
> --
> Michal Hocko
> SUSE Labs
