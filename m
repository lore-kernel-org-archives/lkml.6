Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2887293-1526598283-2-2945548694273204001
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526598283; b=F7yAMYxOnuaCiqrRoarbGELETDEGOky19EkBSfCCw/gY2VwR2P
    hG8KzoKAG2XueJcL/GHVivy46UIzLp8s3SU3sxY+Z9iY7yTDA9ZbuzKPypKmCN9Y
    F2Czj5sL8xupZA6Bg1fE57qNu1zI8d7JrpOQZ4zxqiiThqf6inNCTUBIoAl3h+Fy
    FSbaT9ksl6l3js5vRy3EpGba8gE3ItLeku6hIl14LRLLBcPN1jO6Rma2/OFizkfn
    y1MFJfQYZumta4ncsHPAC0hyfV/BJU071ULRxxFlkau/JPpKnyAmM0RZ0EWaoYV/
    ibmDTh4CB53axQPzlyM+NIdF2Z3kAyTOtt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526598283; bh=NWqRk6tkVjfwiNgfa6pkyk3d4ZJEoOp55a39VE6bka
    8=; b=lSPsBycRa4MWfK3AHYhQ0S5niszMM3IO4dJ8Y5yLNa5IDwVNm8VflnbsSC
    r0W7odjxois+CrUQDZYgsWGVL/OelkLmzch+0eOHJgQGLsRMokFiGUrROxTjTCWD
    RAqakNSYwmLOIrBQohhekktCFFXZlPtZ3cHlAn7Yd06xDaGx/otLHb6DgvaHtFOW
    g1pD9YxRwswfvpoyQLoB87N97uC6wWbQYHYLVLvaXJVPkYEEV+JRpKwJVoRsDm7q
    ZyXYWPYiXdl/b61FnD7OAgd6PuRM8+OBwV6V/2s848mNpokGKqCbREVcysEGc3Xw
    6PkDBVIRmEB71nrGE8seHGzNT0lA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=RacGAVQ0
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BhJ2gisQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=RacGAVQ0
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BhJ2gisQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH06wLh53oBvLd5aSBvfolsCGw41OOX4XSstl8ddc+riFnY0S42JJy99iH1oIgaFVM8szsyot0B5K1Bh3BcMGGAseUtjvAHLdLU4enADQs/grUfzHjLy
    ajJ2X2xMVp004Au76XfWOuTYFJn23myyxOX4/Xn3eMyD335jIzeu3XgS4cPGXUK4z3r2OmZxEnlMzn6+xC+c8KlND0jKnFu0kFaTWs7vkz9ISJhhY2NHCJHn
    sFHm7kvfHcJ7QUv6r4Yhyw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=HaXwMiz5ljGrDwebwVYA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEQXEk (ORCPT <rfc822;linux@kroah.com>);
        Thu, 17 May 2018 19:04:40 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42857 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751280AbeEQXEi (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 17 May 2018 19:04:38 -0400
X-Google-Smtp-Source: AB8JxZrig40jaU8itrohYm3PQVrhhb/1GoH5fi74RqSeqd5x+dEm38MxJ5q3NQi51hB9Pc0DFbCG+2f3UuGl/VXqeoU=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <fbed63483b5206009ee43ae889b30d43051f386c.1526430313.git.rgb@redhat.com>
References: <cover.1526430313.git.rgb@redhat.com> <fbed63483b5206009ee43ae889b30d43051f386c.1526430313.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 17 May 2018 19:04:35 -0400
Message-ID: <CAHC9VhRXn782LH5nvh9fKpk+EzbmmCEaHsj7fNTG3Yi5fp03_g@mail.gmail.com>
Subject: Re: [PATCH ghak81 V3 3/3] audit: collect audit task parameters
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
        Netfilter Devel List <netfilter-devel@vger.kernel.org>,
        Linux Security Module list
        <linux-security-module@vger.kernel.org>,
        Integrity Measurement Architecture
        <linux-integrity@vger.kernel.org>,
        SElinux list <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 7:55 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
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
>  kernel/fork.c         |  2 +-
>  6 files changed, 71 insertions(+), 26 deletions(-)

As discussed on-list and offline, I'm going to hold off on this change
until the audit container ID work is father along.  That is the main
driver for this change, and until that is closer to ready I just can't
justify the extra overhead.

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 69c7847..4f824c4 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -216,8 +216,15 @@ static inline void audit_log_task_info(struct audit_buffer *ab,
>
>  /* These are defined in auditsc.c */
>                                 /* Public API */
> +struct audit_task_info {
> +       kuid_t                  loginuid;
> +       unsigned int            sessionid;
> +       struct audit_context    *ctx;
> +};
> +extern struct audit_task_info init_struct_audit;
> +extern void __init audit_task_init(void);
>  extern int  audit_alloc(struct task_struct *task);
> -extern void __audit_free(struct task_struct *task);
> +extern void audit_free(struct task_struct *task);
>  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>                                   unsigned long a2, unsigned long a3);
>  extern void __audit_syscall_exit(int ret_success, long ret_value);
> @@ -239,12 +246,15 @@ extern void audit_seccomp_actions_logged(const char *names,
>
>  static inline void audit_set_context(struct task_struct *task, struct audit_context *ctx)
>  {
> -       task->audit_context = ctx;
> +       task->audit->ctx = ctx;
>  }
>
>  static inline struct audit_context *audit_context(void)
>  {
> -       return current->audit_context;
> +       if (current->audit)
> +               return current->audit->ctx;
> +       else
> +               return NULL;
>  }
>
>  static inline bool audit_dummy_context(void)
> @@ -252,11 +262,7 @@ static inline bool audit_dummy_context(void)
>         void *p = audit_context();
>         return !p || *(int *)p;
>  }
> -static inline void audit_free(struct task_struct *task)
> -{
> -       if (unlikely(task->audit_context))
> -               __audit_free(task);
> -}
> +
>  static inline void audit_syscall_entry(int major, unsigned long a0,
>                                        unsigned long a1, unsigned long a2,
>                                        unsigned long a3)
> @@ -328,12 +334,18 @@ extern int auditsc_get_stamp(struct audit_context *ctx,
>
>  static inline kuid_t audit_get_loginuid(struct task_struct *tsk)
>  {
> -       return tsk->loginuid;
> +       if (tsk->audit)
> +               return tsk->audit->loginuid;
> +       else
> +               return INVALID_UID;
>  }
>
>  static inline unsigned int audit_get_sessionid(struct task_struct *tsk)
>  {
> -       return tsk->sessionid;
> +       if (tsk->audit)
> +               return tsk->audit->sessionid;
> +       else
> +               return AUDIT_SID_UNSET;
>  }
>
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
> @@ -458,6 +470,8 @@ static inline void audit_fanotify(unsigned int response)
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> +static inline void __init audit_task_init(void)
> +{ }
>  static inline int audit_alloc(struct task_struct *task)
>  {
>         return 0;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b3d697f..6a5db0e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -29,7 +29,6 @@
>  #include <linux/task_io_accounting.h>
>
>  /* task_struct member predeclarations (sorted alphabetically): */
> -struct audit_context;
>  struct backing_dev_info;
>  struct bio_list;
>  struct blk_plug;
> @@ -832,10 +831,8 @@ struct task_struct {
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
>
> diff --git a/init/init_task.c b/init/init_task.c
> index 74f60ba..4058840 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -119,8 +119,7 @@ struct task_struct init_task
>         .thread_group   = LIST_HEAD_INIT(init_task.thread_group),
>         .thread_node    = LIST_HEAD_INIT(init_signals.thread_head),
>  #ifdef CONFIG_AUDITSYSCALL
> -       .loginuid       = INVALID_UID,
> -       .sessionid      = AUDIT_SID_UNSET,
> +       .audit          = &init_struct_audit,
>  #endif
>  #ifdef CONFIG_PERF_EVENTS
>         .perf_event_mutex = __MUTEX_INITIALIZER(init_task.perf_event_mutex),
> diff --git a/init/main.c b/init/main.c
> index b795aa3..7ca3dfb 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -91,6 +91,7 @@
>  #include <linux/cache.h>
>  #include <linux/rodata_test.h>
>  #include <linux/jump_label.h>
> +#include <linux/audit.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -720,6 +721,7 @@ asmlinkage __visible void __init start_kernel(void)
>         nsfs_init();
>         cpuset_init();
>         cgroup_init();
> +       audit_task_init();
>         taskstats_init_early();
>         delayacct_init();
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ef3e189..4b1138a 100644
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
> +
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
>
>         state = audit_filter_task(tsk, &key);
>         if (state == AUDIT_DISABLED) {
> +               audit_set_context(tsk, NULL);
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
> @@ -1469,26 +1495,33 @@ static void audit_log_exit(struct audit_context *context, struct task_struct *ts
>  }
>
>  /**
> - * __audit_free - free a per-task audit context
> + * audit_free - free a per-task audit context
>   * @tsk: task whose audit context block to free
>   *
>   * Called from copy_process and do_exit
>   */
> -void __audit_free(struct task_struct *tsk)
> +void audit_free(struct task_struct *tsk)
>  {
>         struct audit_context *context;
> +       struct audit_task_info *info;
>
>         context = audit_take_context(tsk, 0, 0);
> -       if (!context)
> -               return;
> -
>         /* Check for system calls that do not go through the exit
>          * function (e.g., exit_group), then free context block.
>          * We use GFP_ATOMIC here because we might be doing this
>          * in the context of the idle thread */
>         /* that can happen only if we are called from do_exit() */
> -       if (context->in_syscall && context->current_state == AUDIT_RECORD_CONTEXT)
> +       if (context && context->in_syscall &&
> +           context->current_state == AUDIT_RECORD_CONTEXT)
>                 audit_log_exit(context, tsk);
> +       /* Freeing the audit_task_info struct must be performed after
> +        * audit_log_exit() due to need for loginuid and sessionid.
> +        */
> +       info = tsk->audit;
> +       tsk->audit = NULL;
> +       kmem_cache_free(audit_task_cache, info);
> +       if (!context)
> +               return;
>         if (!list_empty(&context->killed_trees))
>                 audit_kill_trees(&context->killed_trees);
>
> @@ -2071,8 +2104,8 @@ int audit_set_loginuid(kuid_t loginuid)
>                         sessionid = (unsigned int)atomic_inc_return(&session_id);
>         }
>
> -       task->sessionid = sessionid;
> -       task->loginuid = loginuid;
> +       task->audit->sessionid = sessionid;
> +       task->audit->loginuid = loginuid;
>  out:
>         audit_log_set_loginuid(oldloginuid, loginuid, oldsessionid, sessionid, rc);
>         return rc;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cd18448..92ab849 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1713,7 +1713,7 @@ static __latent_entropy struct task_struct *copy_process(
>         p->start_time = ktime_get_ns();
>         p->real_start_time = ktime_get_boot_ns();
>         p->io_context = NULL;
> -       audit_set_context(p, NULL);
> +       p->audit = NULL;
>         cgroup_fork(p);
>  #ifdef CONFIG_NUMA
>         p->mempolicy = mpol_dup(p->mempolicy);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
