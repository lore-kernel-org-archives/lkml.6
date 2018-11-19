Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23946C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47852086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EfTQScsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47852086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730896AbeKTC4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:56:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37658 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730841AbeKTC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:56:53 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so21763959lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IsqEPrbpPI1YZL5xcWKFYz4nIbxfdMJZh0sAIhonH3g=;
        b=EfTQScsu0ptLDTvj2ToxEwxQOC852wFSMz2j8BKdRpdd4vjOqUjMPousntVZcy8SOW
         W8NmB1B+DOc9Y14c9AGc0VEQhWQEQhTSKOzhhIMIlAv0SBkRbir2N5+j5PSqza+gpxdr
         YAhxXruJ6qF+CjOd8dZeK7sajF8cCsEtcgp4Fkdy2P8svFODcR0tV4/UzbhJB3iNgl5I
         oVXxJJ15zeVvA/RGBsk+HqzIHTkRN2TshbZvboAVS4GMa4d0ynwnClQ7/hMgpWs6RAue
         d+VOfDpfuMfeFTk6AT8MdMd2bBiIRfPEnUrkXfk+e3H7J8SGwWFEsCWPPseWrTPuD4a8
         qDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IsqEPrbpPI1YZL5xcWKFYz4nIbxfdMJZh0sAIhonH3g=;
        b=FHHjlXR9Wma6XJCMHDP71WuOPjV36Dl+Eg+U13LdTn/9/VSZWAi74VuJdODwHCU+bw
         GhraW/DkoX4x/1YScgKusaW856Wmjx9d05rr1dyPPISnKqhBAEJNWdAGs+DLb8tpQJV2
         zcEWvs5emEciAHMj4F+w2CMMs5CotswKvDCsQaldvALu5vQ4RBY3APNmWx+SDlz4R9e6
         mIC9PFmQ/7+0NasysJM8TB6WrPB/NdeIOsqchnkqPjE0v16eHqlXb1KaojMiwdjio0KV
         eEwMz0dO1iIyBQurj769Ojkwjo9kx4xXk/KWv9kdgROTfNCs5fmaemPQ6C4YnvCCB1jq
         BX5g==
X-Gm-Message-State: AGRZ1gKQerttj3BmwFV4oq51FSzkM62XWeLWRCeA9CUKRLO/3GgttMVN
        kkcklSKg9USYdeIszsQ9jcIHtVRnZC+BQBfdnCl4
X-Google-Smtp-Source: AJdET5cVBpW79s8J+IHi7qdxQI+JP4D50tM3nn9n720pw4fSdXHq55FmxfEuztVU7XT02QlPNbCOxM/wbFqd+ZYaicc=
X-Received: by 2002:a19:f115:: with SMTP id p21mr10751355lfh.20.1542645162670;
 Mon, 19 Nov 2018 08:32:42 -0800 (PST)
MIME-Version: 1.0
References: <cover.1532709911.git.rgb@redhat.com> <cdc20741855e883493574458bf81c12312d52738.1532709911.git.rgb@redhat.com>
In-Reply-To: <cdc20741855e883493574458bf81c12312d52738.1532709911.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 19 Nov 2018 11:32:31 -0500
Message-ID: <CAHC9VhTP+1Agc2_+U-7Kjrkqsjb-3_JK561qQqdD2HBVGW1ffw@mail.gmail.com>
Subject: Re: [PATCH ghak59 V2 6/6] audit: extend config_change mark/watch/tree
 rule changes
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

I'm not really excited about this change right now, let's hold off on
this for now (the formatting isn't great and I'm not sure it is
necessary), we can always add it later.  The record association
improvements should help here too.

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
> index ae5c89b..d52bb79 100644
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
> index c2281e3..2035097 100644
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
> index 26c2fae..6f1e060 100644
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
> index 55fd2a3..bb56c3e 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1483,7 +1483,7 @@ void __audit_free(struct task_struct *tsk)
>                 return;
>
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
> +               audit_kill_trees(context, "free");
>         /* Check for system calls that do not go through the exit
>          * function (e.g., exit_group), then free context block.
>          * We use GFP_ATOMIC here because we might be doing this
> @@ -1571,7 +1571,7 @@ void __audit_syscall_exit(int success, long return_code)
>                 return;
>
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(context);
> +               audit_kill_trees(context, "exit");
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, current);
>
> --
> 1.8.3.1
>


--
paul moore
www.paul-moore.com
