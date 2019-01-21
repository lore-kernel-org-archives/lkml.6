Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B7FC31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3149B2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9q2rpu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbfAUSQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:16:59 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43437 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfAUSQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:16:59 -0500
Received: by mail-yb1-f193.google.com with SMTP id e12so1372795ybn.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 10:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yqWAy9Z9opyx6z4Tb1LRzCzNVLXkkyvInsVgcl7h00E=;
        b=k9q2rpu+CziuO2sZ88V02gPiunwNegCSfruPvj/IYCJ36M5JJck244BbMFrmiw4aiD
         nxGV/R3ewy7FYfAXBcHal1+++S8W4mXgkU2WONeNHdHOrFd5H0e5HLE0iFTzzTGreT0r
         sxlJMiUcxhl2mV9ruX2UZm0CutfFY4hDrmBEZXqdSqjcDvpQLLEg98yyeQ0kFjHY43n7
         XI7wjEBlbaY0a2gQTh5sKIV7c8ysw08A6nhbxmu5HjxHDpSyH7eRbjZmBKYnHZhworfQ
         C0UNWIrLlDYoLHlevygU62R0Qm4pgI3uqdI4T5tbH32hG/ZVmshsUCy0iGFw1N9nMQaB
         fzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yqWAy9Z9opyx6z4Tb1LRzCzNVLXkkyvInsVgcl7h00E=;
        b=N2Tq3491gxYb55EGbd0QTiR6p82btOZyZ+xdqe4K+Omg2KwWQvxLPKnAWm8hc53dBF
         yx85V6pQyxsHEfSV/AZAeHoifwNr3Sxc0Duy9WuqCBRTwRsPP8Iol1wXovHGaDa8iQqO
         28tcOadki/fcSQPw7bGrHgplYQRvnG5Ks6vE7xGkeGK4ss3yydYq2M6jboVeVM2SEQal
         Ry0cJQFHhUKEWKJ3NCLXA2Ko6qrGNgRCtBflWTeV/mN0gT/AYttCY0tmXj/f7lCxjN0N
         yRk/PnSV2E2eTWfoZY53bx8fy8N+i3dw16wwl7uQB6BD6l8a0BhH0eEtHNmzcarIx6CY
         J7zg==
X-Gm-Message-State: AJcUukclUTh+LJPiehnRoKyh/iBQ0H8ZD5cgVyd9QjBpZ4Rbgxj03MFz
        zNH7G+EZsE4V0qErZBPH+3tai0vkcsDjsDlX0mptLw==
X-Google-Smtp-Source: ALg8bN7Yd6u8G+XkZK/u9Y7F0bKJZN4uJSK6xVQ0zkB1uvEob12BxJRDrIjA2AQdImzqxPAoAz/5wSQF6buIeLq3EPQ=
X-Received: by 2002:a25:6f8b:: with SMTP id k133mr6385877ybc.496.1548094617882;
 Mon, 21 Jan 2019 10:16:57 -0800 (PST)
MIME-Version: 1.0
References: <20190120215059.183552-1-shakeelb@google.com> <20190121091933.GL4087@dhcp22.suse.cz>
In-Reply-To: <20190121091933.GL4087@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Jan 2019 10:16:47 -0800
Message-ID: <CALvZod7PaFzTkHmE2Vz06jrfWK3owo098+OUW55dfh1i=d39pA@mail.gmail.com>
Subject: Re: [PATCH] mm, oom: remove 'prefer children over parent' heuristic
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 1:19 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 20-01-19 13:50:59, Shakeel Butt wrote:
> > >From the start of the git history of Linux, the kernel after selecting
> > the worst process to be oom-killed, prefer to kill its child (if the
> > child does not share mm with the parent). Later it was changed to prefer
> > to kill a child who is worst. If the parent is still the worst then the
> > parent will be killed.
> >
> > This heuristic assumes that the children did less work than their parent
> > and by killing one of them, the work lost will be less. However this is
> > very workload dependent. If there is a workload which can benefit from
> > this heuristic, can use oom_score_adj to prefer children to be killed
> > before the parent.
> >
> > The select_bad_process() has already selected the worst process in the
> > system/memcg. There is no need to recheck the badness of its children
> > and hoping to find a worse candidate. That's a lot of unneeded racy
> > work. So, let's remove this whole heuristic.
>
> Yes, I agree with this direction. Let's try it and see whether there is
> anything really depending on the heuristic. I hope that is not the case
> but at least we will hear about it and the reasoning behind.
>
> I think the changelog should also mension that the heuristic is
> dangerous because it make fork bomb like workloads to recover much later
> because we constantly pick and kill processes which are not memory hogs.
>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Appart from the nit in the printk output
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Also I would prefer s@p@victim@ because it makes the code more readable
>
> I pressume you are going to send this along with the fix for the
> use-after-free in one series.
>
> Thanks.

Yes, I will resend the series after incorporating the feedback.

>
> > ---
> >  mm/oom_kill.c | 49 ++++---------------------------------------------
> >  1 file changed, 4 insertions(+), 45 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 1a007dae1e8f..6cee185dc147 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -944,12 +944,7 @@ static int oom_kill_memcg_member(struct task_struct *task, void *unused)
> >  static void oom_kill_process(struct oom_control *oc, const char *message)
> >  {
> >       struct task_struct *p = oc->chosen;
> > -     unsigned int points = oc->chosen_points;
> > -     struct task_struct *victim = p;
> > -     struct task_struct *child;
> > -     struct task_struct *t;
> >       struct mem_cgroup *oom_group;
> > -     unsigned int victim_points = 0;
> >       static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
> >                                             DEFAULT_RATELIMIT_BURST);
> >
> > @@ -971,53 +966,17 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
> >       if (__ratelimit(&oom_rs))
> >               dump_header(oc, p);
> >
> > -     pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
> > -             message, task_pid_nr(p), p->comm, points);
> > -
> > -     /*
> > -      * If any of p's children has a different mm and is eligible for kill,
> > -      * the one with the highest oom_badness() score is sacrificed for its
> > -      * parent.  This attempts to lose the minimal amount of work done while
> > -      * still freeing memory.
> > -      */
> > -     read_lock(&tasklist_lock);
> > -
> > -     /*
> > -      * The task 'p' might have already exited before reaching here. The
> > -      * put_task_struct() will free task_struct 'p' while the loop still try
> > -      * to access the field of 'p', so, get an extra reference.
> > -      */
> > -     get_task_struct(p);
> > -     for_each_thread(p, t) {
> > -             list_for_each_entry(child, &t->children, sibling) {
> > -                     unsigned int child_points;
> > -
> > -                     if (process_shares_mm(child, p->mm))
> > -                             continue;
> > -                     /*
> > -                      * oom_badness() returns 0 if the thread is unkillable
> > -                      */
> > -                     child_points = oom_badness(child,
> > -                             oc->memcg, oc->nodemask, oc->totalpages);
> > -                     if (child_points > victim_points) {
> > -                             put_task_struct(victim);
> > -                             victim = child;
> > -                             victim_points = child_points;
> > -                             get_task_struct(victim);
> > -                     }
> > -             }
> > -     }
> > -     put_task_struct(p);
> > -     read_unlock(&tasklist_lock);
> > +     pr_err("%s: Kill process %d (%s) score %lu or sacrifice child\n",
> > +             message, task_pid_nr(p), p->comm, oc->chosen_points);
> >
> >       /*
> >        * Do we need to kill the entire memory cgroup?
> >        * Or even one of the ancestor memory cgroups?
> >        * Check this out before killing the victim task.
> >        */
> > -     oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
> > +     oom_group = mem_cgroup_get_oom_group(p, oc->memcg);
> >
> > -     __oom_kill_process(victim);
> > +     __oom_kill_process(p);
> >
> >       /*
> >        * If necessary, kill all tasks in the selected memory cgroup.
> > --
> > 2.20.1.321.g9e740568ce-goog
>
> --
> Michal Hocko
> SUSE Labs
