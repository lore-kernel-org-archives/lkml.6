Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BF3ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6D92145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="L3avroPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6D92145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJTHZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:25:40 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39521 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbeJTHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:25:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id n14-v6so14559837lfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ik/s2L4PX5QbGKcP98U3U1dgoi81TznRJBg6zVrvXkw=;
        b=L3avroPYnaAOCylGl3G7wD1mhJNOaODI8ir1hgUd83Drfe49w3L8NnuT9vHa3Iy/bO
         a2pz7/UiubCvsx5O8nQb77LK+heCO9ga8AOQediDw71Ypujhgg7icE7ylxAbZEearENh
         N0ofx4KrFWtpkULFbfq7DvecSjtaCJ+0svnnHN7JB72vxyf8VNXYiTDshBooo8yRHcZ9
         ZDLBnEoLEpEHa7SYDWSvS3YxhXxGv/hT37yJO3UwNHhwrIoEDGJTlScG6KfiHjeSRPJK
         C+PeGhQbpnrL1KNksGyQZ7uUNRw+6bvHX3jmrzA7qFMqw/IeaA1hoaNPugXOW7fNSQIU
         FvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ik/s2L4PX5QbGKcP98U3U1dgoi81TznRJBg6zVrvXkw=;
        b=qS5hMeByTsZC7unsF4Q242oWK1YZ6Y0p5U/A6r7UQ3PvNz73XirDBjBdZ4P6oH1xyb
         YO6fgZN7k1eiC0ukMXdFlcEKY+ZjM1qk35ZYqDPUpEnJsZ/wtlGxzgjcj6j48z5AX1zl
         zjiPl208cyUg9k/N+AKpsK6hPcUPiiI89XcAXIsUCol0jrrK8WMJcRYYXkzzUawWi7um
         7jIg7C7l9LcWroNLATFRwKjTADesdf2WTZt2hvvpGohaWUmnDqGlmdbKpHpHMHb8BToK
         TES4ZuVaUtoCRVFsYSl0xUbH7Z4kqXmh0YU6eHXbgzzyqa6a7PMIcRnTqnUmsKb76Rqy
         ZtBg==
X-Gm-Message-State: ABuFfogC94Xlu2sIc8LYnNe+KDU8b+tpOUC0MLvkOS8Aih/gtM6KUEGl
        PWrfqX3MG6hUNfPVWWM/IdXmjwk7PsqcCHE9PEXdhSY=
X-Google-Smtp-Source: ACcGV61s326FOzijg3F8dEIINosXPdjwRKCJ1yj0UUebW8Wa+nBbG2qKgiZQrTzCyXdp17UaSkiLdwSdv176kzJPD2g=
X-Received: by 2002:a19:8fce:: with SMTP id s75mr4053148lfk.151.1539991049481;
 Fri, 19 Oct 2018 16:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <2827530000d6b4972d446b0226adab153ff3b5c5.1533065887.git.rgb@redhat.com>
In-Reply-To: <2827530000d6b4972d446b0226adab153ff3b5c5.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:17:18 -0400
Message-ID: <CAHC9VhSG3Hk2zrNP3w=CfEBXN7_LcywiTpvhGp48661xYhRq2A@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 05/10] audit: add support for
 non-syscall auxiliary records
To:     rgb@redhat.com
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        luto@kernel.org, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> Standalone audit records have the timestamp and serial number generated
> on the fly and as such are unique, making them standalone.  This new
> function audit_alloc_local() generates a local audit context that will
> be used only for a standalone record and its auxiliary record(s).  The
> context is discarded immediately after the local associated records are
> produced.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  include/linux/audit.h |  8 ++++++++
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      | 33 ++++++++++++++++++++++++++++-----
>  3 files changed, 37 insertions(+), 5 deletions(-)

I'm not in love with the local flag, and the whole local context in
general, but that's a larger discussion and not something I want to
force on this patchset; we can fix it later.

I think this patch looks fine, but it seems a bit odd standalone; it's
almost always better to include new capabilities/functions in the same
patch as the user.  Since the only user is the networking bits, it
might make more sense to fold this patch into that one.

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 4f514ed..1f340ad 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -234,7 +234,9 @@ struct audit_task_info {
>  extern struct audit_task_info init_struct_audit;
>  extern void __init audit_task_init(void);
>  extern int  audit_alloc(struct task_struct *task);
> +extern struct audit_context *audit_alloc_local(gfp_t gfpflags);
>  extern void audit_free(struct task_struct *task);
> +extern void audit_free_context(struct audit_context *context);
>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>                                   unsigned long a2, unsigned long a3);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
> @@ -495,6 +497,12 @@ static inline int audit_alloc(struct task_struct *task)
>  {
>         return 0;
>  }
> +static inline struct audit_context *audit_alloc_local(gfp_t gfpflags)
> +{
> +       return NULL;
> +}
> +static inline void audit_free_context(struct audit_context *context)
> +{ }
>  static inline void audit_free(struct task_struct *task)
>  { }
>  static inline void audit_syscall_entry(int major, unsigned long a0,
> diff --git a/kernel/audit.h b/kernel/audit.h
> index 1cf1c35..a6d00a5 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -110,6 +110,7 @@ struct audit_proctitle {
>  struct audit_context {
>         int                 dummy;      /* must be the first element */
>         int                 in_syscall; /* 1 if task is in a syscall */
> +       bool                local;      /* local context needed */
>         enum audit_state    state, current_state;
>         unsigned int        serial;     /* serial number for record */
>         int                 major;      /* syscall number */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index cdb24cf..7627f21 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -913,11 +913,13 @@ static inline void audit_free_aux(struct audit_context *context)
>         }
>  }
>
> -static inline struct audit_context *audit_alloc_context(enum audit_state state)
> +static inline struct audit_context *audit_alloc_context(enum audit_state state,
> +                                                       gfp_t gfpflags)
>  {
>         struct audit_context *context;
>
> -       context = kzalloc(sizeof(*context), GFP_KERNEL);
> +       /* We can be called in atomic context via audit_tg() */
> +       context = kzalloc(sizeof(*context), gfpflags);
>         if (!context)
>                 return NULL;
>         context->state = state;
> @@ -970,7 +972,8 @@ int audit_alloc(struct task_struct *tsk)
>                 return 0;
>         }
>
> -       if (!(context = audit_alloc_context(state))) {
> +       context = audit_alloc_context(state, GFP_KERNEL);
> +       if (!(context)) {
>                 tsk->audit = NULL;
>                 kmem_cache_free(audit_task_cache, info);
>                 kfree(key);
> @@ -991,8 +994,27 @@ struct audit_task_info init_struct_audit = {
>         .ctx = NULL,
>  };
>
> -static inline void audit_free_context(struct audit_context *context)
> +struct audit_context *audit_alloc_local(gfp_t gfpflags)
>  {
> +       struct audit_context *context;
> +
> +       if (!audit_ever_enabled)
> +               return NULL; /* Return if not auditing. */
> +
> +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT, gfpflags);
> +       if (!context)
> +               return NULL;
> +       context->serial = audit_serial();
> +       context->ctime = current_kernel_time64();
> +       context->local = true;
> +       return context;
> +}
> +EXPORT_SYMBOL(audit_alloc_local);
> +
> +void audit_free_context(struct audit_context *context)
> +{
> +       if (!context)
> +               return;
>         audit_free_names(context);
>         unroll_tree_refs(context, NULL, 0);
>         free_tree_refs(context);
> @@ -1002,6 +1024,7 @@ static inline void audit_free_context(struct audit_context *context)
>         audit_proctitle_free(context);
>         kfree(context);
>  }
> +EXPORT_SYMBOL(audit_free_context);
>
>  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
> @@ -2024,7 +2047,7 @@ void __audit_inode_child(struct inode *parent,
>  int auditsc_get_stamp(struct audit_context *ctx,
>                        struct timespec64 *t, unsigned int *serial)
>  {
> -       if (!ctx->in_syscall)
> +       if (!ctx->in_syscall && !ctx->local)
>                 return 0;
>         if (!ctx->serial)
>                 ctx->serial = audit_serial();

--
paul moore
www.paul-moore.com
