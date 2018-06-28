Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB52C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8C0279F6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="C8BsDErf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8C0279F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935630AbeF1W3J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:29:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40817 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeF1W3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:29:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id a6-v6so5745611ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCDtEpV9dMbkPS/3LL9T2xJOB65ebxEvghcdrpVHLwI=;
        b=C8BsDErfGxWUcXLxsQx2jenuLeExkHZ0OXyImAKWoJS+1V5lDHfJ80s9gVZi436wJG
         GME5aEdS71Fvzr8Qmuk4/rHygN3ia66O3mVY8tbGhFBhLHRq6oYU3/Da9fAgg7JH4eiQ
         zSw7dpUWMAc7GyKVhh7lxDtMT8y3RWl/QsZw6eSc1KJP3Xv6UN/Ucf1j9SB0LXast43M
         WyjlB5jPdbNvZTke5OHAFka+4tkeecTUWLs1LTEzgpkIVDKT2S9d+/reuGfNCWd+wcsl
         LEc8GA+cp3CyymMwyH2LkAdtRfGRwJLWLFyUDKyLG+au94HpGhC4k58NXKteQ9+nDdO9
         MhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCDtEpV9dMbkPS/3LL9T2xJOB65ebxEvghcdrpVHLwI=;
        b=bAuWy2GPxWF3uj4d8bxHoH38aulqKqrootFYeWrG2fGnQqWTgoGu7oA25Wk/kNdryG
         XhMvDykP61WYtQ3hUlMD9lIEttd/evVNeuHd8NXJvxs3bna7qAke+iGJ6JWwOfTyLMtx
         1qDEHDywHYHk1xhwX0CRdrZJpx4wq1A7MywzgLEUDF8/JGunmjuUQXuzA1bCmqU54oCy
         o3MvUwSwubFi7WQmIRjycfvPPAfMEBxaL895boyfBUbnWVXUnINebqCE5O/qXb9Q/7X3
         dKdMv3qI9xerZZ5nQJ6HV1REM7gSxfmqU/b8hjQMwwLkKo8u7azFG5FHYFKuhhausq5F
         Jr9A==
X-Gm-Message-State: APt69E1Noc8sWSFPAh3yISk62q6pz+UTojO9nuRjAEIwNKkFSJvHFMP+
        T213DB2+7QQBkwJe6FaAhrPB00Dw1ZAM3KpRSQLklQA=
X-Google-Smtp-Source: AAOMgpcBNteOTraGXO5Bt4crUYiTIme9sUcolfPCZpSruIcy9hQn66NlK1p95lCtfhgIyBfOTDbE7c1OEMFOBqQWKB4=
X-Received: by 2002:a2e:9e57:: with SMTP id g23-v6mr8064838ljk.14.1530224946510;
 Thu, 28 Jun 2018 15:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <e3584154c8594cf64e9293ec6f473cdaaabe2954.1529003588.git.rgb@redhat.com>
In-Reply-To: <e3584154c8594cf64e9293ec6f473cdaaabe2954.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 18:28:55 -0400
Message-ID: <CAHC9VhScxWn9jP7wMdkVoQM-5i2RnMM2HJe-baHGu3D4NpJvpQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 6/6] audit: extend config_change
 mark/watch/tree rule changes
To:     rgb@redhat.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>, sgrubb@redhat.com,
        aviro@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Give a clue as to the source of mark, watch and tree rule changes.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h          |  4 ++--
>  kernel/audit_fsnotify.c |  2 +-
>  kernel/audit_tree.c     | 24 ++++++++++++------------
>  kernel/audit_watch.c    |  6 ++++--
>  kernel/auditsc.c        |  4 ++--
>  5 files changed, 21 insertions(+), 19 deletions(-)

I think having some additional context here would be helpful for
everyone, so I agree with this on principle.  However, I think we need
to get clarification from Steve that his parser is able to handle
these richer "op" values.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index f39f7aa..5e072f5 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -312,7 +312,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern int audit_tag_tree(char *old, char *new);
>  extern const char *audit_tree_path(struct audit_tree *tree);
>  extern void audit_put_tree(struct audit_tree *tree);
> -extern void audit_kill_trees(struct audit_context *context);
> +extern void audit_kill_trees(struct audit_context *context, char *trig);
>  #else
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
> @@ -321,7 +321,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_put_tree(tree) (void)0
>  #define audit_tag_tree(old, new) -EINVAL
>  #define audit_tree_path(rule) ""       /* never called */
> -#define audit_kill_trees(context) BUG()
> +#define audit_kill_trees(context, trig) BUG()
>  #endif
>
>  extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
> diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
> index 1640eb6..c10ba91 100644
> --- a/kernel/audit_fsnotify.c
> +++ b/kernel/audit_fsnotify.c
> @@ -158,7 +158,7 @@ static void audit_autoremove_mark_rule(struct audit_fsnotify_mark *audit_mark)
>         struct audit_krule *rule = audit_mark->rule;
>         struct audit_entry *entry = container_of(rule, struct audit_entry, rule);
>
> -       audit_mark_log_rule_change(audit_mark, "autoremove_rule");
> +       audit_mark_log_rule_change(audit_mark, "autoremove_rule(mark)");
>         audit_del_rule(entry);
>  }
>
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index 2d3e1071..1726cfa 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -493,7 +493,7 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
>         return 0;
>  }
>
> -static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule)
> +static void audit_tree_log_remove_rule(struct audit_context *context, struct audit_krule *rule, char *trig)
>  {
>         struct audit_buffer *ab;
>
> @@ -502,7 +502,7 @@ static void audit_tree_log_remove_rule(struct audit_context *context, struct aud
>         ab = audit_log_start(context, GFP_KERNEL, AUDIT_CONFIG_CHANGE);
>         if (unlikely(!ab))
>                 return;
> -       audit_log_format(ab, "op=remove_rule");
> +       audit_log_format(ab, "op=remove_rule(tree:%s)", trig);
>         audit_log_format(ab, " dir=");
>         audit_log_untrustedstring(ab, rule->tree->pathname);
>         audit_log_key(ab, rule->filterkey);
> @@ -510,7 +510,7 @@ static void audit_tree_log_remove_rule(struct audit_context *context, struct aud
>         audit_log_end(ab);
>  }
>
> -static void kill_rules(struct audit_context *context, struct audit_tree *tree)
> +static void kill_rules(struct audit_context *context, struct audit_tree *tree, char *trig)
>  {
>         struct audit_krule *rule, *next;
>         struct audit_entry *entry;
> @@ -521,7 +521,7 @@ static void kill_rules(struct audit_context *context, struct audit_tree *tree)
>                 list_del_init(&rule->rlist);
>                 if (rule->tree) {
>                         /* not a half-baked one */
> -                       audit_tree_log_remove_rule(context, rule);
> +                       audit_tree_log_remove_rule(context, rule, trig);
>                         if (entry->rule.exe)
>                                 audit_remove_mark(entry->rule.exe);
>                         rule->tree = NULL;
> @@ -551,7 +551,7 @@ static void prune_one(struct audit_tree *victim)
>
>  /* trim the uncommitted chunks from tree */
>
> -static void trim_marked(struct audit_tree *tree)
> +static void trim_marked(struct audit_tree *tree, char *trig)
>  {
>         struct list_head *p, *q;
>         spin_lock(&hash_lock);
> @@ -584,7 +584,7 @@ static void trim_marked(struct audit_tree *tree)
>                 tree->goner = 1;
>                 spin_unlock(&hash_lock);
>                 mutex_lock(&audit_filter_mutex);
> -               kill_rules(audit_context(), tree);
> +               kill_rules(audit_context(), tree, trig);
>                 list_del_init(&tree->list);
>                 mutex_unlock(&audit_filter_mutex);
>                 prune_one(tree);
> @@ -665,7 +665,7 @@ void audit_trim_trees(void)
>                                 node->index &= ~(1U<<31);
>                 }
>                 spin_unlock(&hash_lock);
> -               trim_marked(tree);
> +               trim_marked(tree, "trim");
>                 drop_collected_mounts(root_mnt);
>  skip_it:
>                 put_tree(tree);
> @@ -798,7 +798,7 @@ int audit_add_tree_rule(struct audit_krule *rule)
>                         node->index &= ~(1U<<31);
>                 spin_unlock(&hash_lock);
>         } else {
> -               trim_marked(tree);
> +               trim_marked(tree, "add");
>                 goto Err;
>         }
>
> @@ -900,7 +900,7 @@ int audit_tag_tree(char *old, char *new)
>                                 node->index &= ~(1U<<31);
>                         spin_unlock(&hash_lock);
>                 } else {
> -                       trim_marked(tree);
> +                       trim_marked(tree, "equiv");
>                 }
>
>                 put_tree(tree);
> @@ -924,7 +924,7 @@ static void audit_schedule_prune(void)
>   * ... and that one is done if evict_chunk() decides to delay until the end
>   * of syscall.  Runs synchronously.
>   */
> -void audit_kill_trees(struct audit_context *context)
> +void audit_kill_trees(struct audit_context *context, char *trig)
>  {
>         struct list_head *list = &context->killed_trees;
>
> @@ -935,7 +935,7 @@ void audit_kill_trees(struct audit_context *context)
>                 struct audit_tree *victim;
>
>                 victim = list_entry(list->next, struct audit_tree, list);
> -               kill_rules(context, victim);
> +               kill_rules(context, victim, trig);
>                 list_del_init(&victim->list);
>
>                 mutex_unlock(&audit_filter_mutex);
> @@ -974,7 +974,7 @@ static void evict_chunk(struct audit_chunk *chunk)
>                 list_del_init(&owner->same_root);
>                 spin_unlock(&hash_lock);
>                 if (!postponed) {
> -                       kill_rules(audit_context(), owner);
> +                       kill_rules(audit_context(), owner, "evict");
>                         list_move(&owner->list, &prune_list);
>                         need_prune = 1;
>                 } else {
> diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
> index da2978b..693d0a8 100644
> --- a/kernel/audit_watch.c
> +++ b/kernel/audit_watch.c
> @@ -317,7 +317,9 @@ static void audit_update_watch(struct audit_parent *parent,
>                         if (oentry->rule.exe)
>                                 audit_remove_mark(oentry->rule.exe);
>
> -                       audit_watch_log_rule_change(r, owatch, "updated_rules");
> +                       audit_watch_log_rule_change(r, owatch, invalidating ?
> +                                                   "updated_rules(watch:inval)" :
> +                                                   "updated_rules(watch:set)");
>
>                         call_rcu(&oentry->rcu, audit_free_rule_rcu);
>                 }
> @@ -345,7 +347,7 @@ static void audit_remove_parent_watches(struct audit_parent *parent)
>         list_for_each_entry_safe(w, nextw, &parent->watches, wlist) {
>                 list_for_each_entry_safe(r, nextr, &w->rules, rlist) {
>                         e = container_of(r, struct audit_entry, rule);
> -                       audit_watch_log_rule_change(r, w, "remove_rule");
> +                       audit_watch_log_rule_change(r, w, "remove_rule(watch:parent)");
>                         if (e->rule.exe)
>                                 audit_remove_mark(e->rule.exe);
>                         list_del(&r->rlist);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d56aead..32428a3 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1486,7 +1486,7 @@ void __audit_free(struct task_struct *tsk)
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, tsk);
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
> +               audit_kill_trees(context, "free");
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
>                 struct audit_buffer *ab;
>
> @@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, current);
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
> +               audit_kill_trees(context, "exit");
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT) {
>                 struct audit_buffer *ab;
>
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
