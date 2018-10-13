Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CBFC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1F22064E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 18:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kil9J/+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1F22064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbeJNCGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 22:06:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40348 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeJNCGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 22:06:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id j68-v6so12254882oib.7
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/8Y0Hb6Wyj/qkND39Hgf/WWfH6YJH4yKTgmz9ZnF3A=;
        b=Kil9J/+WsGxve+TAkuLPVQxkmNl9o2ziXWey4kM9rXQkjVl9sZjGAKWuvCx11tLkoD
         cvJ0v4+DcU2QrwBosy+1tPlFgyh3nYdShLCPqUdBkccpfnOwuxpajAzvpR4P3gkN5mNH
         /ml7VXssETEDk5qhJgYRF20YT9CX6/nHninXnKslZiOEbLnOJTYNr67amVSLqlzyicGJ
         W00AiDZkFlThgdc6Xjzol+NE1YbkL+EkRmmcsWbOSBH5+vQkKZiFwB/q1Z8ESn9JpK2R
         jleYzSVezWrxqWk8silsN/PnoRqEKqwuTStMTFaL2SL++fVjsy8xmOIUhKM9IJsPNAAS
         ZB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/8Y0Hb6Wyj/qkND39Hgf/WWfH6YJH4yKTgmz9ZnF3A=;
        b=WyOWTBeSebyakAMx6bxldwKZwV/FCOtIEYL+qAQxPvo9ChaabJbVXp21+g8t1x3PW5
         ErGHNMdw5Ql85SyJ0lik7Ri7FXtfGlTcIHVyRCT21UBFtgr82Kq7t/7u1xcKoKHpgWRu
         1/uQ5bTcSvj4ypi0B2atyTlcyYT+o9J4oebux2pffs3ble6SXSExr6ZYWl5DzlmvAgvr
         KkrXuRvxy4rQkq70tRbac3Ihtk7GZ8bEL/EX8UAM6wigvASz5w+Mrq28harQv0ZKCs0Y
         iE9noNtvHOzJ3DlgmQVceo4lXSqE/OUGiEyqnDbzXml0VP48CCUGqyTezkkw0PY3nKlA
         UM6A==
X-Gm-Message-State: ABuFfojYOASqm/gb9hbbg/F8TjMhzsolv28FQrybD15+ECMjDgSxf6e1
        ndyMtArt/KjuNXakGImCwAQCKwudt+oJKtuT6aRrRw==
X-Google-Smtp-Source: ACcGV63Pnnbdkm+2Pl6f5G+QsPWxynGEuA/PMoQ5RYCizerrJBiTIQWVu7tdO/7FF7Q9gLqT2t6fqciGOXf8rHnQuqo=
X-Received: by 2002:aca:efd6:: with SMTP id n205-v6mr5580705oih.3.1539455285088;
 Sat, 13 Oct 2018 11:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 13 Oct 2018 20:27:38 +0200
Message-ID: <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
To:     enkechen@cisco.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com,
        mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        guro@fb.com, marcos.souza.org@gmail.com,
        Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, kamensky@cisco.com,
        xe-linux-external@cisco.com, sstrogin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 2:33 AM Enke Chen <enkechen@cisco.com> wrote:
> For simplicity and consistency, this patch provides an implementation
> for signal-based fault notification prior to the coredump of a child
> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> be used by an application to express its interest and to specify the
> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.

Your suggested API looks vaguely similar to PR_SET_PDEATHSIG, but with
some important differences:

 - You don't reset the signal on setuid execution.
 - You permit setting this not just on the current process, but also on others.

For both of these: Are these differences actually necessary, and if
so, can you provide a specific rationale? From a security perspective,
I would very much prefer it if this API had semantics closer to
PR_SET_PDEATHSIG.

[...]
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 312b43e..eb4a483 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2337,6 +2337,44 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>         return signr;
>  }
>
> +/*
> + * Let the parent, if so desired, know about the imminent death of a child
> + * prior to its coredump.
> + *
> + * Locking logic is similar to do_notify_parent_cldstop().
> + */
> +static void do_notify_parent_predump(struct task_struct *tsk)
> +{
> +       struct sighand_struct *sighand;
> +       struct task_struct *parent;
> +       struct kernel_siginfo info;
> +       unsigned long flags;
> +       int sig;
> +
> +       parent = tsk->real_parent;
> +       sig = parent->predump_signal;
> +
> +       /* Check again with "tasklist_lock" locked by the caller */
> +       if (!valid_predump_signal(sig))
> +               return;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = sig;
> +       if (sig == SIGCHLD)
> +               info.si_code = CLD_PREDUMP;
> +
> +       rcu_read_lock();
> +       info.si_pid = task_pid_nr_ns(tsk, task_active_pid_ns(parent));
> +       info.si_uid = from_kuid_munged(task_cred_xxx(parent, user_ns),
> +                                      task_uid(tsk));

You're sending a signal from the current namespaces, but with IDs that
have been mapped into the parent's namespaces? That looks wrong to me.

> +       rcu_read_unlock();
> +
> +       sighand = parent->sighand;
> +       spin_lock_irqsave(&sighand->siglock, flags);
> +       __group_send_sig_info(sig, &info, parent);
> +       spin_unlock_irqrestore(&sighand->siglock, flags);
> +}
> +
>  bool get_signal(struct ksignal *ksig)
>  {
>         struct sighand_struct *sighand = current->sighand;
> @@ -2497,6 +2535,19 @@ bool get_signal(struct ksignal *ksig)
>                 current->flags |= PF_SIGNALED;
>
>                 if (sig_kernel_coredump(signr)) {
> +                       /*
> +                        * Notify the parent prior to the coredump if the
> +                        * parent is interested in such a notificaiton.
> +                        */
> +                       int p_sig = current->real_parent->predump_signal;

current->real_parent is an __rcu member. I think if you run the sparse
checker against this patch, it's going to complain. Are you allowed to
access current->real_parent in this context?

> +                       if (valid_predump_signal(p_sig)) {
> +                               read_lock(&tasklist_lock);
> +                               do_notify_parent_predump(current);
> +                               read_unlock(&tasklist_lock);
> +                               cond_resched();
> +                       }
> +
>                         if (print_fatal_signals)
>                                 print_fatal_signal(ksig->info.si_signo);
>                         proc_coredump_connector(current);
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 123bd73..43eb250d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2258,6 +2258,76 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>         return -EINVAL;
>  }
>
> +static int prctl_get_predump_signal(struct task_struct *tsk, pid_t pid,
> +                                   int __user *addr)
> +{
> +       struct task_struct *p;
> +       int error;
> +
> +       /* For the current task, the common case */
> +       if (pid == 0) {
> +               put_user(tsk->predump_signal, addr);
> +               return 0;
> +       }
> +
> +       error = -ESRCH;
> +       rcu_read_lock();
> +       p = find_task_by_vpid(pid);
> +       if (p) {
> +               error = 0;
> +               put_user(p->predump_signal, addr);

This is wrong. You can't call put_user() while you're in an RCU
read-side critical section.

As below, I would like it if you could just get rid of this branch,
and restrict this prctl to operating on the current process.

> +       }
> +       rcu_read_unlock();
> +       return error;
> +}
> +
> +/*
> + * Returns true if current's euid is same as p's uid or euid,
> + * or has CAP_SYS_ADMIN.
> + *
> + * Called with rcu_read_lock, creds are safe.
> + *
> + * Adapted from set_one_prio_perm().
> + */
> +static bool set_predump_signal_perm(struct task_struct *p)
> +{
> +       const struct cred *cred = current_cred(), *pcred = __task_cred(p);
> +
> +       return uid_eq(pcred->uid, cred->euid) ||
> +              uid_eq(pcred->euid, cred->euid) ||
> +              capable(CAP_SYS_ADMIN);
> +}

This permission check permits fiddling with other processes in
scenarios where kill() wouldn't let you send signals (specifically, if
you control the EUID of the target task). That worries me. Also,
kill() is subject to LSM checks (see check_kill_permission()), but
this interface isn't. I would really prefer it if you could amend this
so that you can only operate on the current task, and get rid of this
permission check.

[...]
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>                 unsigned long, arg4, unsigned long, arg5)
>  {
> @@ -2476,6 +2546,13 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>                         return -EINVAL;
>                 error = arch_prctl_spec_ctrl_set(me, arg2, arg3);
>                 break;
> +       case PR_SET_PREDUMP_SIG:
> +               error = prctl_set_predump_signal(me, (pid_t)arg2, (int)arg3);
> +               break;
> +       case PR_GET_PREDUMP_SIG:
> +               error = prctl_get_predump_signal(me, (pid_t)arg2,
> +                                                (int __user *)arg3);
> +               break;

New prctl() calls should check that the unused arguments are zero, in
order to make it possible to safely add more flags in the future.
