Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9143FC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE6A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="copbONn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE6A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeKTC4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:46 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41080 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730817AbeKTC4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:45 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so21777590lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgVXQ3CLQfGRH3ZhVn4OwVhozYu4Bb0P5h9w+FADwOU=;
        b=copbONn8rZoP+VeMqVboVHNS73kCswhaZYKv+CQWJBPTVmrERrw08xvC4P72V4R3ys
         c5f8AzW12s2LPNP4ojNcjYk+pfcSyFuHOSL2NZIYzMRxbgnfyI/PiJ2mWB2GXv1I82Q/
         i1nxj3Vrws79LHEPEr9SRnGwdRgTW3kwhcSDfGLu8q4V9fmgSwu8lSQR/f+uyaHiUB/o
         N66s2NHJBUP7/F4AlRWx+IAtiE2H8nUGJas/HvdolRQUjCaRSgG/Y95njGw0RcXP4DtJ
         oFI0evJ1VYl1XagH7bse4VvkbVkepT5FbFhlw3leqjsI2TIj+lgzqIyeTuyIk2m2PGWm
         SjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgVXQ3CLQfGRH3ZhVn4OwVhozYu4Bb0P5h9w+FADwOU=;
        b=hfuoULvOHjU6Qd4FdRJqv3rEZtDLtCX2OXpXqh0dg1hI1x2AL4m1Hr0MHWOgiWT/et
         4tUxZ9geK2Cc0/KkECwZAzADy7IkQTFwj2HgGgUGcSL/2zaSZGFeeE8cNaTyQFdryL/5
         n3azozdEFwSQBVvYVWhFu+NR/TrJbt406tJhoL4550hG6GACPnZnpFprBbzLYYosNjV6
         QfubUwaUuab/wjoIxVMC+PiB9B07iibp2gH/mzoV62zGNDQaBMk0uN1vqdToTzjsY+OD
         HEqkbAf3gqO+Pmy/tt4TRHYUHVDf1Isa3reTSkAEhWPPW+5CCn4Ik2/B3L2WN4i2CuzG
         sBFw==
X-Gm-Message-State: AGRZ1gJCVwHpUz3/HIcr384G9eNOLWv1s3UPAmw1bFewMDq/4cXcJnKZ
        Vb1ky+XS+gCs3jSfFttEhLYSoM7jhYucqK1uI6W8
X-Google-Smtp-Source: AJdET5cb6jcNMBLuWWplozQ8MyVaCeHwUUOanrNsorUcgjjHH2z0sfgg4sBZJMyHXCMDhNh1bue2f3YzTdWkF06x4tA=
X-Received: by 2002:a19:a7c1:: with SMTP id q184mr10554682lfe.4.1542645155440;
 Mon, 19 Nov 2018 08:32:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <9d922798e48fc40d3743ce73e01725ac8cdcee04.1532709911.git.rgb@redhat.com>
In-Reply-To: <9d922798e48fc40d3743ce73e01725ac8cdcee04.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:23 -0500
Message-ID: <CAHC9VhRYkgjBvpRwb=C-GBRKqg0gLs7i=HXN_bEyh_udP6O+6Q@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 4/6] audit: hand taken context to
 audit_kill_trees for syscall logging
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 3:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Since the context is taken from the task in __audit_syscall_exit() and
> __audit_free(), hand it to audit_kill_trees() so it can be used to
> associate with a syscall record.  This requires adding the context
> parameter to kill_rules() rather than using the current audit_context
> (which has been taken).
>
> The callers of trim_marked() and evict_chunk() still have their context.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h      |  4 ++--
>  kernel/audit_tree.c | 18 ++++++++++--------
>  kernel/auditsc.c    |  4 ++--
>  3 files changed, 14 insertions(+), 12 deletions(-)

This looks okay, but see my comments in 5/6.  Since you're going to
need to respin this anyway, I would suggest rebasing it on to of the
current audit/next as Jan's audit tree changes might cause some merge
fuzz.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 214e149..f39f7aa 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -312,7 +312,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern int audit_tag_tree(char *old, char *new);
>  extern const char *audit_tree_path(struct audit_tree *tree);
>  extern void audit_put_tree(struct audit_tree *tree);
> -extern void audit_kill_trees(struct list_head *list);
> +extern void audit_kill_trees(struct audit_context *context);
>  #else
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
> @@ -321,7 +321,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_put_tree(tree) (void)0
>  #define audit_tag_tree(old, new) -EINVAL
>  #define audit_tree_path(rule) ""       /* never called */
> -#define audit_kill_trees(list) BUG()
> +#define audit_kill_trees(context) BUG()
>  #endif
>
>  extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index f0b7d30..c2281e3 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -493,13 +493,13 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
>         return 0;
>  }
>
> -static void audit_tree_log_remove_rule(struct audit_krule *rule)
> +static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
>  {
>         struct audit_buffer *ab;
>
>         if (!audit_enabled)
>                 return;
> -       ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_CONFIG_CHANGE);
> +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
>         audit_log_format(ab, "op=remove_rule");
> @@ -510,7 +510,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
>         audit_log_end(ab);
>  }
>
> -static void kill_rules(struct audit_tree *tree)
> +static void kill_rules(struct audit_context *context, struct audit_tree *tree)
>  {
>         struct audit_krule *rule, *next;
>         struct audit_entry *entry;
> @@ -521,7 +521,7 @@ static void kill_rules(struct audit_tree *tree)
>                 list_del_init(&rule->rlist);
>                 if (rule->tree) {
>                         /* not a half-baked one */
> -                       audit_tree_log_remove_rule(rule);
> +                       audit_tree_log_remove_rule(context, rule);
>                         if (entry->rule.exe)
>                                 audit_remove_mark(entry->rule.exe);
>                         rule->tree = NULL;
> @@ -584,7 +584,7 @@ static void trim_marked(struct audit_tree *tree)
>                 tree->goner = 1;
>                 spin_unlock(&hash_lock);
>                 mutex_lock(&audit_filter_mutex);
> -               kill_rules(tree);
> +               kill_rules(audit_context(), tree);
>                 list_del_init(&tree->list);
>                 mutex_unlock(&audit_filter_mutex);
>                 prune_one(tree);
> @@ -924,8 +924,10 @@ static void audit_schedule_prune(void)
>   * ... and that one is done if evict_chunk() decides to delay until the end
>   * of syscall.  Runs synchronously.
>   */
> -void audit_kill_trees(struct list_head *list)
> +void audit_kill_trees(struct audit_context *context)
>  {
> +       struct list_head *list = &context->killed_trees;
> +
>         audit_ctl_lock();
>         mutex_lock(&audit_filter_mutex);
>
> @@ -933,7 +935,7 @@ void audit_kill_trees(struct list_head *list)
>                 struct audit_tree *victim;
>
>                 victim = list_entry(list->next, struct audit_tree, list);
> -               kill_rules(victim);
> +               kill_rules(context, victim);
>                 list_del_init(&victim->list);
>
>                 mutex_unlock(&audit_filter_mutex);
> @@ -972,7 +974,7 @@ static void evict_chunk(struct audit_chunk *chunk)
>                 list_del_init(&owner->same_root);
>                 spin_unlock(&hash_lock);
>                 if (!postponed) {
> -                       kill_rules(owner);
> +                       kill_rules(audit_context(), owner);
>                         list_move(&owner->list, &prune_list);
>                         need_prune = 1;
>                 } else {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index fb20746..986c5ce 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1490,7 +1490,7 @@ void __audit_free(struct task_struct *tsk)
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, tsk);
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> +               audit_kill_trees(context);
>
>         audit_free_context(context);
>  }
> @@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
>         context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
>
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> +               audit_kill_trees(context);
>
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
> --
> 1.8.3.1
>


--
paul moore
www.paul-moore.com
