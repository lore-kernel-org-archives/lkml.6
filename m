Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C7BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECE22145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="1Js8gUX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECE22145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJTHYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:24:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35031 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeJTHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:24:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so32222021ljj.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoTz7lmVDo5s3RMZIY5Fp6Xr9oR7jVQHzy7kV2OsjMg=;
        b=1Js8gUX90HEZ80l4q3AnPbtBII/1w0dQ2dPMfcM82+lNu0t4ikOiaDIRm0oSKsSajQ
         mI63ETFgQamnusbZKoPYaDsXCjuSf4R43NctoFP1bYyC0QODAzYf4UxElDATssI5qyBE
         uA/T1ZURR/LP6lNjuWy8w7l4z5t+zCH3HA3uarPGhiMW54DcNSpfbtVBEWfdTD+GKfo+
         7QoHYw9CfzS0sqJD/W9IEu0/m1faesatjnVob0+VeE+FHxHX40v3+LSW9HPnR71wkefK
         WX+0hBS62rO9WJO/MZg8SyPShYSL9K9x1D5eyGmWUu0FWJOlXtCIfftA1zIeqDDQgNkR
         HpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoTz7lmVDo5s3RMZIY5Fp6Xr9oR7jVQHzy7kV2OsjMg=;
        b=prtjAB392COUdQxV4WCpYm4/4VbrG+kKPS6odMQxvtaIoiAIxIEuhCugYopwvsjWBY
         e3zyK1A3xp6Jd5Q9GzQCBsL1uVeP8sxKwvEbhLabiC22eQpLrDJOEjZC0ZRc0YgAGESO
         ryDEBdX6XY8EAGAAorKgesZz7cpur3L0J5hH5TSoZP106YzpQjLUMlPj7dEmvvnvATFR
         GGOKTeQQqOSmbGf9DeKUXixHXixUNLsmpTFHvhvkqiu0w3KrNoIhEPxhAME5ouQU+bNw
         d9FgvP28nCFJ3y06inmjIXns+E5JZzRkGAG4x/X53GpMgkqW827y3tzlpe37OiRAqgDN
         oAsQ==
X-Gm-Message-State: AGRZ1gJZ9JtbhMtWoxGihXormNNs4wKJjUUpslqMo0Ohpok8OAp90xGp
        YRqHl0uLoJQ19JuXkAjTM1hcfJWZkGcSh/tGDoJs
X-Google-Smtp-Source: ACcGV61hWdQ4XIdAaM4rXpJmDrtqIJDs38M0O6LPIRDzlhBqxBZWT6cq7zwkmZFL9ZXhA8n+cqRP6FVjhPHkX7mcusc=
X-Received: by 2002:a2e:3810:: with SMTP id f16-v6mr4929220lja.77.1539990968063;
 Fri, 19 Oct 2018 16:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
In-Reply-To: <8e617ab568df28a66dfbe3284452de186b42fb0f.1533065887.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Oct 2018 19:15:56 -0400
Message-ID: <CAHC9VhQFqs1SyvximK+8XJG5Fk3p9WsWhEV5sY6kksN9tc6eKw@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 01/10] audit: collect audit task parameters
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

On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> The audit-related parameters in struct task_struct should ideally be
> collected together and accessed through a standard audit API.
>
> Collect the existing loginuid, sessionid and audit_context together in a
> new struct audit_task_info called "audit" in struct task_struct.
>
> Use kmem_cache to manage this pool of memory.
> Un-inline audit_free() to be able to always recover that memory.
>
> See: https://github.com/linux-audit/audit-kernel/issues/81
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h | 34 ++++++++++++++++++++++++----------
>  include/linux/sched.h |  5 +----
>  init/init_task.c      |  3 +--
>  init/main.c           |  2 ++
>  kernel/auditsc.c      | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>  kernel/fork.c         |  4 +++-
>  6 files changed, 73 insertions(+), 26 deletions(-)

...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 9334fbe..8964332 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -219,8 +219,15 @@ static inline void audit_log_task_info(struct audit_buffer *ab,
>
>  /* These are defined in auditsc.c */
>                                 /* Public API */
> +struct audit_task_info {
> +       kuid_t                  loginuid;
> +       unsigned int            sessionid;
> +       struct audit_context    *ctx;
> +};

...

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 87bf02d..e117272 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -873,10 +872,8 @@ struct task_struct {
>
>         struct callback_head            *task_works;
>
> -       struct audit_context            *audit_context;
>  #ifdef CONFIG_AUDITSYSCALL
> -       kuid_t                          loginuid;
> -       unsigned int                    sessionid;
> +       struct audit_task_info          *audit;
>  #endif
>         struct seccomp                  seccomp;

Prior to this patch audit_context was available regardless of
CONFIG_AUDITSYSCALL, after this patch the corresponding audit_context
is only available when CONFIG_AUDITSYSCALL is defined.

> diff --git a/init/main.c b/init/main.c
> index 3b4ada1..6aba171 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -92,6 +92,7 @@
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/audit.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -721,6 +722,7 @@ asmlinkage __visible void __init start_kernel(void)
>         nsfs_init();
>         cpuset_init();
>         cgroup_init();
> +       audit_task_init();
>         taskstats_init_early();
>         delayacct_init();

It seems like we would need either init_struct_audit or
audit_task_init(), but not both, yes?

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index fb20746..88779a7 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -841,7 +841,7 @@ static inline struct audit_context *audit_take_context(struct task_struct *tsk,
>                                                       int return_valid,
>                                                       long return_code)
>  {
> -       struct audit_context *context = tsk->audit_context;
> +       struct audit_context *context = tsk->audit->ctx;
>
>         if (!context)
>                 return NULL;
> @@ -926,6 +926,15 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
>         return context;
>  }
>
> +static struct kmem_cache *audit_task_cache;
> +
> +void __init audit_task_init(void)
> +{
> +       audit_task_cache = kmem_cache_create("audit_task",
> +                                            sizeof(struct audit_task_info),
> +                                            0, SLAB_PANIC, NULL);
> +}

This is somewhat related to the CONFIG_AUDITSYSCALL comment above, but
since the audit_task_info contains generic audit state (not just
syscall related state), it seems like this, and the audit_task_info
accessors/helpers, should live in kernel/audit.c.

There are probably a few other things that should move to
kernel/audit.c too, e.g. audit_alloc().  Have you verified that this
builds/runs correctly on architectures that define CONFIG_AUDIT but
not CONFIG_AUDITSYSCALL?

>  /**
>   * audit_alloc - allocate an audit context block for a task
>   * @tsk: task
> @@ -940,17 +949,28 @@ int audit_alloc(struct task_struct *tsk)
>         struct audit_context *context;
>         enum audit_state     state;
>         char *key = NULL;
> +       struct audit_task_info *info;
> +
> +       info = kmem_cache_zalloc(audit_task_cache, GFP_KERNEL);
> +       if (!info)
> +               return -ENOMEM;
> +       info->loginuid = audit_get_loginuid(current);
> +       info->sessionid = audit_get_sessionid(current);
> +       tsk->audit = info;
>
>         if (likely(!audit_ever_enabled))
>                 return 0; /* Return if not auditing. */

I don't view this as necessary for initial acceptance, and
synchronization/locking might render this undesirable, but it would be
curious to see if we could do something clever with refcnts and
copy-on-write to minimize the number of kmem_cache objects in use in
the !audit_ever_enabled (and possibly the AUDIT_DISABLED) case.

>         state = audit_filter_task(tsk, &key);
>         if (state == AUDIT_DISABLED) {
> +               audit_set_context(tsk, NULL);

It's already NULL, isn't it?

>                 clear_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
>                 return 0;
>         }
>
>         if (!(context = audit_alloc_context(state))) {
> +               tsk->audit = NULL;
> +               kmem_cache_free(audit_task_cache, info);
>                 kfree(key);
>                 audit_log_lost("out of memory in audit_alloc");
>                 return -ENOMEM;
> @@ -962,6 +982,12 @@ int audit_alloc(struct task_struct *tsk)
>         return 0;
>  }
>
> +struct audit_task_info init_struct_audit = {
> +       .loginuid = INVALID_UID,
> +       .sessionid = AUDIT_SID_UNSET,
> +       .ctx = NULL,
> +};
> +
>  static inline void audit_free_context(struct audit_context *context)
>  {
>         audit_free_names(context);

--
paul moore
www.paul-moore.com
