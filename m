Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E35C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9AB20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="aE8gRnu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfANXGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:06:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42340 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfANXGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:06:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id l15-v6so650809lja.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KFcffHXckPzV/8f9aMGMDIoDr8zAvxUPITrJRmxio4M=;
        b=aE8gRnu9uYyuWNqpR7HoTjtcMBuCMe6unQaFyvoNaDOv7NgT/Gv76VDF4TxaVBBoWE
         JjWlLYcowmY7QazGo+EK/RluZfbOV2KVESKnuckQGdvYGd60U00CHBnzk+ErCjclrzMv
         wM+WaJ0Ygyn/1BAMyDbLHwYNkD7JuwR2Llp1Y6VaDW0JtgvSzlXL/nrCvOEc9Dhcy6XT
         g7wM/MDJJsKwsFV1a9n81wk/6mTsW5MGeFWgra55yWuMBl8IQToTi7GbKEaHlHvicN58
         ePj6wPayabS3cKLjk/IthLfa8eXoH7ADnVgD/fHOsYnDmziZddB3KIN0mzPhZLmZ8Us4
         KAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KFcffHXckPzV/8f9aMGMDIoDr8zAvxUPITrJRmxio4M=;
        b=taFNakIN15rYhNl0P162prDJz832ulnqvDoNN7jvSLmG0WUk21c1r0WbmRvtqDdhMs
         WiOYsIs6I7TJvCSs6kfpFfek8udIqvj3/zN8GfzkTeSas3S3AIxSJoTzT5Iyn84Ow+r+
         Tt4k4Zr0jK1owSi7t873VIOwjfPCRcr5yMmJlae3eWlPat+BNJcByg0w0eg64GlCTAzA
         tAzpeTcmSRsS7+WooIKVlLiAaamXCpQfelaO7AhJHPl8GmeO3NMlEpG3CF8loclqiKeo
         LMjjjDM9hMpqq+Pl1rR7DtMwQPQVpltreQxlYxASrxOthfB6Ybh9jXCm5E384hYOhsg5
         FO+w==
X-Gm-Message-State: AJcUukfpS+924h/oEIuguMUBZuvrxobnvmZttTLw9sv0KEj6TC3kwrbn
        bBvXUYaOvLP7cppA/T4EDEAuxnsZt/Buf8M4t5Fs
X-Google-Smtp-Source: ALg8bN4DKGjt/HJUhfmO6rHYeXCYM29HHDRzIDPjSAhGzUdwCrmGp3C67JWfj2+eDqMyMRKlNc/awUYXDhsKWKOBg3I=
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr562571lji.145.1547507186712;
 Mon, 14 Jan 2019 15:06:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <557aec24451674a80c757600e39b91fd8cfc29a4.1544477629.git.rgb@redhat.com>
In-Reply-To: <557aec24451674a80c757600e39b91fd8cfc29a4.1544477629.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Jan 2019 18:06:15 -0500
Message-ID: <CAHC9VhQDNx=2k+OshQ_LO6qW0he9mcsAwh_BiyVdYBEgrgn6dg@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 3/4] audit: hand taken context to
 audit_kill_trees for syscall logging
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since the context is derived from the task parameter handed to
> __audit_free(), hand the context to audit_kill_trees() so it can be used
> to associate with a syscall record.  This requires adding the context
> parameter to kill_rules() rather than using the current audit_context.
>
> The callers of trim_marked() and evict_chunk() still have their context.
>
> The EOE record was being issued prior to the pruning of the killed_tree
> list.
>
> Move the kill_trees call before the audit_log_exit call in
> __audit_free() and __audit_syscall_exit() so that any pruned trees
> CONFIG_CHANGE records are included with the associated syscall event by
> the user library due to the EOE record flagging the end of the event.
>
> See: https://github.com/linux-audit/audit-kernel/issues/50
> See: https://github.com/linux-audit/audit-kernel/issues/59
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/audit.h      |  4 ++--
>  kernel/audit_tree.c | 18 ++++++++++--------
>  kernel/auditsc.c    | 12 ++++++------
>  3 files changed, 18 insertions(+), 16 deletions(-)

Merged.

> diff --git a/kernel/audit.h b/kernel/audit.h
> index 91421679a168..6ffb70575082 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -314,7 +314,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  extern int audit_tag_tree(char *old, char *new);
>  extern const char *audit_tree_path(struct audit_tree *tree);
>  extern void audit_put_tree(struct audit_tree *tree);
> -extern void audit_kill_trees(struct list_head *list);
> +extern void audit_kill_trees(struct audit_context *context);
>  #else
>  #define audit_remove_tree_rule(rule) BUG()
>  #define audit_add_tree_rule(rule) -EINVAL
> @@ -323,7 +323,7 @@ extern void audit_log_d_path_exe(struct audit_buffer *ab,
>  #define audit_put_tree(tree) (void)0
>  #define audit_tag_tree(old, new) -EINVAL
>  #define audit_tree_path(rule) ""       /* never called */
> -#define audit_kill_trees(list) BUG()
> +#define audit_kill_trees(context) BUG()
>  #endif
>
>  extern char *audit_unpack_string(void **bufp, size_t *remain, size_t len);
> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index b0bd59ef4271..bf77d265e68e 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -524,13 +524,13 @@ static int tag_chunk(struct inode *inode, struct audit_tree *tree)
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
>         audit_log_format(ab, "op=remove_rule dir=");
> @@ -540,7 +540,7 @@ static void audit_tree_log_remove_rule(struct audit_krule *rule)
>         audit_log_end(ab);
>  }
>
> -static void kill_rules(struct audit_tree *tree)
> +static void kill_rules(struct audit_context *context, struct audit_tree *tree)
>  {
>         struct audit_krule *rule, *next;
>         struct audit_entry *entry;
> @@ -551,7 +551,7 @@ static void kill_rules(struct audit_tree *tree)
>                 list_del_init(&rule->rlist);
>                 if (rule->tree) {
>                         /* not a half-baked one */
> -                       audit_tree_log_remove_rule(rule);
> +                       audit_tree_log_remove_rule(context, rule);
>                         if (entry->rule.exe)
>                                 audit_remove_mark(entry->rule.exe);
>                         rule->tree = NULL;
> @@ -633,7 +633,7 @@ static void trim_marked(struct audit_tree *tree)
>                 tree->goner = 1;
>                 spin_unlock(&hash_lock);
>                 mutex_lock(&audit_filter_mutex);
> -               kill_rules(tree);
> +               kill_rules(audit_context(), tree);
>                 list_del_init(&tree->list);
>                 mutex_unlock(&audit_filter_mutex);
>                 prune_one(tree);
> @@ -973,8 +973,10 @@ static void audit_schedule_prune(void)
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
> @@ -982,7 +984,7 @@ void audit_kill_trees(struct list_head *list)
>                 struct audit_tree *victim;
>
>                 victim = list_entry(list->next, struct audit_tree, list);
> -               kill_rules(victim);
> +               kill_rules(context, victim);
>                 list_del_init(&victim->list);
>
>                 mutex_unlock(&audit_filter_mutex);
> @@ -1017,7 +1019,7 @@ static void evict_chunk(struct audit_chunk *chunk)
>                 list_del_init(&owner->same_root);
>                 spin_unlock(&hash_lock);
>                 if (!postponed) {
> -                       kill_rules(owner);
> +                       kill_rules(audit_context(), owner);
>                         list_move(&owner->list, &prune_list);
>                         need_prune = 1;
>                 } else {
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 6593a5207fb0..b585ceb2f7a2 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1444,6 +1444,9 @@ void __audit_free(struct task_struct *tsk)
>         if (!context)
>                 return;
>
> +       if (!list_empty(&context->killed_trees))
> +               audit_kill_trees(context);
> +
>         /* We are called either by do_exit() or the fork() error handling code;
>          * in the former case tsk == current and in the latter tsk is a
>          * random task_struct that doesn't doesn't have any meaningful data we
> @@ -1460,9 +1463,6 @@ void __audit_free(struct task_struct *tsk)
>                         audit_log_exit();
>         }
>
> -       if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> -
>         audit_set_context(tsk, NULL);
>         audit_free_context(context);
>  }
> @@ -1537,6 +1537,9 @@ void __audit_syscall_exit(int success, long return_code)
>         if (!context)
>                 return;
>
> +       if (!list_empty(&context->killed_trees))
> +               audit_kill_trees(context);
> +
>         if (!context->dummy && context->in_syscall) {
>                 if (success)
>                         context->return_valid = AUDITSC_SUCCESS;
> @@ -1571,9 +1574,6 @@ void __audit_syscall_exit(int success, long return_code)
>         context->in_syscall = 0;
>         context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
>
> -       if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> -
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
>         audit_free_aux(context);
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
