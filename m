Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3218FC282C0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098520870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NTKD5+lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfAVClm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:41:42 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37971 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfAVCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:41:41 -0500
Received: by mail-yw1-f68.google.com with SMTP id d190so8832597ywb.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Y2bLoS2D6sf3QVEXazrUJ6vwinbbs+17ubyrvA6rnE=;
        b=NTKD5+lgaalZjZ1dJtbwKn4koSaKIBspB9yYoyDZQ5WKohIjQCFi9LwZoB8RVOCboo
         rlTkpDtyWpdihV0T5aQZHqVkKL+L1UvI8xvLaGrxF7a3+004bAkzlg8tGeDf5vXpePa5
         LQhBTwnykoTc3NoxJh9dIhUpeysYgCZmV9gcBmWEN+ceceb9rimrqIGxqEO8C+7l1/mK
         ntg6+gSQOo3zwAlVOCVxXpfle2B6lD/8xDdhzi270mzdIKhBKUVNSv5sQBBVfT0w2i6X
         OzlGOtuA5yeIGwiMJw+IdwJS4SUv6CW4IY1GXAhYAYhS32w0/m6tIQuAueggrwGQJyxb
         wFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Y2bLoS2D6sf3QVEXazrUJ6vwinbbs+17ubyrvA6rnE=;
        b=O0UvOxWSKnXQcTpWd2mVpLuqxQyHSSNsSMHjKmltqdfesKmkhawTS/aGyKa77dCUIY
         cOGHI4Rrke/fK1GOG6QBGx3oPOWmmp0YxB5IC5YmJwMZXXirFHCydDxK4jPTRhTsWF8F
         yJ382btI1Xb+iVJyfBqEsVb20TEcMRYv61XELwKIzLVzSz3AO729yOiq2/fz2ZNmCMep
         L82M3Fy43WPWnWnebdi/o9b901M8dLxSEiDyKrJevxpXnRol18E80ZvDouGdsT1P7Rew
         uteXaHS6ih8Zk/KrrdvZTXoq//0CxAeGAtSNC89MZBCfezhASDHQPPxZh3ju9X5205J/
         ecIg==
X-Gm-Message-State: AJcUukf9d/ZD0RQ2EuLKxEuCx/JwlUY1ufG4HKJyO4wOTg2s6HEzhbpL
        0R3Qx/9hZVPWgRGtEZrfpRY7H2upTnpQOuz/wPA2gg==
X-Google-Smtp-Source: ALg8bN7YLFBGOo8Ep29MSSpxZnp9reR7ulfRf6zYkkztFv3AoVxRpMCCLqSJzq7ZjVc09H4Vep/MRUhWEew9i2Hd7Dk=
X-Received: by 2002:a81:60c4:: with SMTP id u187mr30368278ywb.345.1548124899854;
 Mon, 21 Jan 2019 18:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20190121215850.221745-1-shakeelb@google.com> <20190121215850.221745-2-shakeelb@google.com>
In-Reply-To: <20190121215850.221745-2-shakeelb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Jan 2019 18:41:28 -0800
Message-ID: <CALvZod5mvwj9yGOxaaOCnSTkg9rxVbdztewFgdyw_do4BwsHPQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm, oom: remove 'prefer children over parent' heuristic
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 1:59 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> From the start of the git history of Linux, the kernel after selecting
> the worst process to be oom-killed, prefer to kill its child (if the
> child does not share mm with the parent). Later it was changed to prefer
> to kill a child who is worst. If the parent is still the worst then the
> parent will be killed.
>
> This heuristic assumes that the children did less work than their parent
> and by killing one of them, the work lost will be less. However this is
> very workload dependent. If there is a workload which can benefit from
> this heuristic, can use oom_score_adj to prefer children to be killed
> before the parent.
>
> The select_bad_process() has already selected the worst process in the
> system/memcg. There is no need to recheck the badness of its children
> and hoping to find a worse candidate. That's a lot of unneeded racy
> work. Also the heuristic is dangerous because it make fork bomb like
> workloads to recover much later because we constantly pick and kill
> processes which are not memory hogs. So, let's remove this whole
> heuristic.
>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Michal, though I have kept your Acked-by but I have made a couple of
changes in the code. Please let me know if you are ok with the
changes.

> Cc: Roman Gushchin <guro@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
>
> ---
> Changelog since v2:
> - Propagate the message to __oom_kill_process().
>
> Changelog since v1:
> - Improved commit message based on mhocko's comment.
> - Replaced 'p' with 'victim'.
> - Removed extra pr_err message.
>
> ---
>  mm/oom_kill.c | 78 ++++++++++++---------------------------------------
>  1 file changed, 18 insertions(+), 60 deletions(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1a007dae1e8f..c90184fd48a3 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -843,7 +843,7 @@ static bool task_will_free_mem(struct task_struct *task)
>         return ret;
>  }
>
> -static void __oom_kill_process(struct task_struct *victim)
> +static void __oom_kill_process(struct task_struct *victim, const char *message)
>  {
>         struct task_struct *p;
>         struct mm_struct *mm;
> @@ -874,8 +874,9 @@ static void __oom_kill_process(struct task_struct *victim)
>          */
>         do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>         mark_oom_victim(victim);
> -       pr_err("Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> -               task_pid_nr(victim), victim->comm, K(victim->mm->total_vm),
> +       pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB\n",
> +               message, task_pid_nr(victim), victim->comm,
> +               K(victim->mm->total_vm),
>                 K(get_mm_counter(victim->mm, MM_ANONPAGES)),
>                 K(get_mm_counter(victim->mm, MM_FILEPAGES)),
>                 K(get_mm_counter(victim->mm, MM_SHMEMPAGES)));
> @@ -932,24 +933,19 @@ static void __oom_kill_process(struct task_struct *victim)
>   * Kill provided task unless it's secured by setting
>   * oom_score_adj to OOM_SCORE_ADJ_MIN.
>   */
> -static int oom_kill_memcg_member(struct task_struct *task, void *unused)
> +static int oom_kill_memcg_member(struct task_struct *task, void *message)
>  {
>         if (task->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
>                 get_task_struct(task);
> -               __oom_kill_process(task);
> +               __oom_kill_process(task, message);
>         }
>         return 0;
>  }
>
>  static void oom_kill_process(struct oom_control *oc, const char *message)
>  {
> -       struct task_struct *p = oc->chosen;
> -       unsigned int points = oc->chosen_points;
> -       struct task_struct *victim = p;
> -       struct task_struct *child;
> -       struct task_struct *t;
> +       struct task_struct *victim = oc->chosen;
>         struct mem_cgroup *oom_group;
> -       unsigned int victim_points = 0;
>         static DEFINE_RATELIMIT_STATE(oom_rs, DEFAULT_RATELIMIT_INTERVAL,
>                                               DEFAULT_RATELIMIT_BURST);
>
> @@ -958,57 +954,18 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>          * its children or threads, just give it access to memory reserves
>          * so it can die quickly
>          */
> -       task_lock(p);
> -       if (task_will_free_mem(p)) {
> -               mark_oom_victim(p);
> -               wake_oom_reaper(p);
> -               task_unlock(p);
> -               put_task_struct(p);
> +       task_lock(victim);
> +       if (task_will_free_mem(victim)) {
> +               mark_oom_victim(victim);
> +               wake_oom_reaper(victim);
> +               task_unlock(victim);
> +               put_task_struct(victim);
>                 return;
>         }
> -       task_unlock(p);
> +       task_unlock(victim);
>
>         if (__ratelimit(&oom_rs))
> -               dump_header(oc, p);
> -
> -       pr_err("%s: Kill process %d (%s) score %u or sacrifice child\n",
> -               message, task_pid_nr(p), p->comm, points);
> -
> -       /*
> -        * If any of p's children has a different mm and is eligible for kill,
> -        * the one with the highest oom_badness() score is sacrificed for its
> -        * parent.  This attempts to lose the minimal amount of work done while
> -        * still freeing memory.
> -        */
> -       read_lock(&tasklist_lock);
> -
> -       /*
> -        * The task 'p' might have already exited before reaching here. The
> -        * put_task_struct() will free task_struct 'p' while the loop still try
> -        * to access the field of 'p', so, get an extra reference.
> -        */
> -       get_task_struct(p);
> -       for_each_thread(p, t) {
> -               list_for_each_entry(child, &t->children, sibling) {
> -                       unsigned int child_points;
> -
> -                       if (process_shares_mm(child, p->mm))
> -                               continue;
> -                       /*
> -                        * oom_badness() returns 0 if the thread is unkillable
> -                        */
> -                       child_points = oom_badness(child,
> -                               oc->memcg, oc->nodemask, oc->totalpages);
> -                       if (child_points > victim_points) {
> -                               put_task_struct(victim);
> -                               victim = child;
> -                               victim_points = child_points;
> -                               get_task_struct(victim);
> -                       }
> -               }
> -       }
> -       put_task_struct(p);
> -       read_unlock(&tasklist_lock);
> +               dump_header(oc, victim);
>
>         /*
>          * Do we need to kill the entire memory cgroup?
> @@ -1017,14 +974,15 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>          */
>         oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
>
> -       __oom_kill_process(victim);
> +       __oom_kill_process(victim, message);
>
>         /*
>          * If necessary, kill all tasks in the selected memory cgroup.
>          */
>         if (oom_group) {
>                 mem_cgroup_print_oom_group(oom_group);
> -               mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
> +               mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member,
> +                                     (void*) message);
>                 mem_cgroup_put(oom_group);
>         }
>  }
> --
> 2.20.1.321.g9e740568ce-goog
>
