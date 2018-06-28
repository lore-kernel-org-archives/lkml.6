Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD7C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089DE277F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eq/rysHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089DE277F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967016AbeF1WYF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:24:05 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40529 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966989AbeF1WYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:24:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id a6-v6so5737811ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 15:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/YlVDztboctX8LEKl48nxtRX1IAYQ9bBUlXIWB0SlY=;
        b=eq/rysHxFLutHL5ecr9IfKH1vX2IjCr3O75WxUu1AEeQQfE71JpwKLPHoTmy845b0r
         fenyMJ3PF7eTSNA8iGobL9F8+QdKYf3VlYvb0QjS5K1bgfAGl5ShpoPMUOBXcp7ez5n2
         uOJe+wsdKwcVfWUNRtVdi42KtYfIf5kndjy8zh1yVtC84c+8Hj4G1qwSV7/t1CnxqqXk
         7Sq2alVQDqTXLnViUDjp56e/eCdTWRU3GsFPPIIdB1/Opmbm5OJ68jJom3SP5fzcWhiM
         TRE+yQdtnXm4i8OzPXZuAV7VHF1+njY/xH63xySgBTRcUkMWAIWm8TaG8/xrqKFGXJsU
         VHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/YlVDztboctX8LEKl48nxtRX1IAYQ9bBUlXIWB0SlY=;
        b=qtLBCod8BncGJI7qMGGYu2sPUtojQUGSm7lfmWIbY9BlA5c6XS/mWoYih7SitkZ6yy
         dcPetiVCMbgtVdJF1P6rOj0WkPxO5wsBdDnwS7I57nZZ1OrMwndSrqOzjz0SC8dqLLrT
         3G12B0tBSwSqoq6Fsrl4Jcoz3E7sHtLA7AKwK89P4ByaGxqqf8BCMriFbW0QkhYbdISl
         t7hjcuDKHXrEvBBDS8yVXddJy4hAm51eHmQv+7QKmuzjLM9c7lwYERoJHnUHsI/x4zz6
         lSe9V1GXylfYIyAa9gMT3rpF3VBUoXHLJUVIn+yoDBA67tNSml/fZAZw+Jj/2/ai+th2
         ZG6Q==
X-Gm-Message-State: APt69E2L4Tf7YEDKt2sjw3Nfatl8W3yCgNAO09WMiNGKX+G9aGbpJcpF
        7Qzh4APkRRqdI5eopnk9IK7K5aHTpNUA3WdVpkL7
X-Google-Smtp-Source: AAOMgpddbUpx5hknQ8np1CbejHSmN14ngsdAx4AK+/4epomazXgEdhR7QbdjOwuUoQbj5XtEOCol+bx6AZ4ya5qr5dY=
X-Received: by 2002:a2e:4b01:: with SMTP id y1-v6mr8059349lja.135.1530224642128;
 Thu, 28 Jun 2018 15:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <7a95a34c5e90053f8214090e0d73cd54d6d281a2.1529003588.git.rgb@redhat.com>
In-Reply-To: <7a95a34c5e90053f8214090e0d73cd54d6d281a2.1529003588.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 28 Jun 2018 18:23:51 -0400
Message-ID: <CAHC9VhRMhX8iL2N2TN7qQmZ=3rb8uAr=kUiOjc04JAR0QzR6fg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 4/6] audit: hand taken context to
 audit_kill_trees for syscall logging
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
>
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
> index a01b9da..2d3e1071 100644
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
> index ceb1c45..2590c9e 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1490,7 +1490,7 @@ void __audit_free(struct task_struct *tsk)
>         if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, tsk);
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> +               audit_kill_trees(context);

See my comment below about the ordering of audit_kill_trees() and
audit_log_exit().

>         audit_free_context(context);
>  }
> @@ -1577,7 +1577,7 @@ void __audit_syscall_exit(int success, long return_code)
>         context->prio = context->state == AUDIT_RECORD_CONTEXT ? ~0ULL : 0;
>
>         if (!list_empty(&context->killed_trees))
> -               audit_kill_trees(&context->killed_trees);
> +               audit_kill_trees(context);

I wonder if we should move the kill_trees if-block above the
audit_log_exit() block so that any records that are emitted will be
before the SYSCALL record.  I didn't chase down all the code paths,
but it seems like it should be safe, no?

>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
