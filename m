Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3973753-1520974089-2-10913604790737434200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520974089; b=a085F4nQ+bx7p1D9NkvOXKgJqc+o0sBw16zPzV5rKemhOeR
    o3Hx5P+RBcK9MmbcrIzObYFSpr1XVluhEYhP4CkZcJDiSlEoQ0WGcZXJBDQyepXq
    ID6gGDJtWH6o3GsAAvDPjGmI2d5KGcVCH2AlBDx7Pngm7fwTmfDO7i/mtZXIrxTB
    i4j6ETRqbQIVnOkOxEtGZKyMsRVhJoQjhXiu68SjxIkc85ayvRjaTnJFx/5ZAdAF
    hYFKqg4XyB04BftEsu8ODrfkuyTdURqV2FkkhJcKHRMHa4kuGh8xfkbzYcJI5j/z
    eWAxCiGNQmPMW8ykpZX49AinXEaafVxMG6bCuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520974089; bh=668+hZeGRohZ25/uzfptnjHtZQ91x8SmlAsFSi
    2lg8Y=; b=nXYpZENRRXDdIGUqISgyYi4CuQERCXvlwmnRhTSgfxkaJ/iG6+Inmm
    WkL/YTwYYrKXFQ0FXZgQfUo86cIoEds1nEHBeUqcQKCl15mRNrQubxrQkVPxh1ZE
    o9YQ/pkJCyeUey0PgGeh1nPAFRujnZl3q41bGMFAZ7WCF1DCQEeikZa9uVbjjcmf
    eQJ49Ilap1lu6GcCMoiXFZwkepjMW5okR7bPeannswCz76fShoxpGDqH0mlkXgrm
    oLGyq6Kst4plnBF4uB/bHbPddNMgWzAL6QW0fP8mI6jF/bhv8quGzamkaq0nGlER
    uOeJFo8vy9po7faqWZIFpfuE0sjnwoDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MADkjNDy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HiGDZjwm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MADkjNDy x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HiGDZjwm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeCMUsG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 16:48:06 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42613 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753082AbeCMUsF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 16:48:05 -0400
X-Google-Smtp-Source: AG47ELs8I+wgj/dCGHxOrxky20upnOzymt02AGFckExpA4LuNHACHjx3EJ/ddau1A6gLB1i78xgg1Y2QX+3RJdWKmOk=
MIME-Version: 1.0
In-Reply-To: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 13 Mar 2018 13:47:43 -0700
Message-ID: <CAG48ez1ww-pVQ9R+d+P+smRR3eaEkJ-=9GW-O-QOvH-YZoFG8A@mail.gmail.com>
Subject: Re: [RESEND RFC] translate_pid API
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Cc: kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Nagarajan.Muthukrishnan@oracle.com,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Serge Hallyn <serge.hallyn@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, xemul@parallels.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:18 AM,  <nagarathnam.muthusamy@oracle.com> wrote:
> Resending the RFC with participants of previous discussions
> in the list.
>
> Following patch which is a variation of a solution discussed
> in https://lwn.net/Articles/736330/ provides the users of
> pid namespace, the functionality of pid translation between
> namespaces using a namespace identifier. The topic of
> pid translation has been discussed in the community few times
> but there has always been a resistance to adding new solution
> for this problem.

> I will outline the planned usecase of pid namespace by oracle
> database and explain why any of the existing solution cannot
> be used to solve their problem.
>
> Consider a system in which several PID namespaces with multiple
> nested levels exists in parallel with monitor processes managing
> all the namespaces. PID translation is required for controlling
> and accessing information about the processes by the monitors
> and other processes down the hierarchy of namespaces. Controlling
> primarily involves sending signals or using ptrace by a process in
> parent namespace on any of the processes in its child namespace.
> Accessing information deals with the reading /proc/<pid>/* files
> of processes in child namespace. None of the processes have
> root/CAP_SYS_ADMIN privileges.

How are you dealing with PID reuse?

[...]
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 36b0772..c635465 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -222,8 +222,13 @@ int ns_get_name(char *buf, size_t size, struct task_struct *task,
>         const char *name;
>         ns = ns_ops->get(task);
>         if (ns) {
> -               name = ns_ops->real_ns_name ? : ns_ops->name;
> -               res = snprintf(buf, size, "%s:[%u]", name, ns->inum);
> +               if (!strcmp(ns_ops->name, "pidns_id")) {

Wouldn't it be cleaner to check for "ns_ops==&pidns_id_operations"?

> +                       res = snprintf(buf, size, "[%llu]",
> +                                      (unsigned long long)ns->ns_id);
> +               } else {
> +                       name = ns_ops->real_ns_name ? : ns_ops->name;
> +                       res = snprintf(buf, size, "%s:[%u]", name, ns->inum);
> +               }
>                 ns_ops->put(ns);
>         }
>         return res;
[...]
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 49538b1..11d1d57 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -11,6 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/ns_common.h>
>  #include <linux/idr.h>
> +#include <linux/list_bl.h>
>
>
>  struct fs_pin;
> @@ -44,6 +45,8 @@ struct pid_namespace {
>         kgid_t pid_gid;
>         int hide_pid;
>         int reboot;     /* group exit code if this pidns was rebooted */
> +       struct hlist_bl_node node;
> +       atomic_t lookups_pending;
>         struct ns_common ns;
>  } __randomize_layout;
>
[...]
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 0b53eef..ff83aa8 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
[...]
> @@ -159,6 +201,30 @@ static void delayed_free_pidns(struct rcu_head *p)
>
>  static void destroy_pid_namespace(struct pid_namespace *ns)
>  {
> +       struct pid_namespace *ph;
> +       struct hlist_bl_head *head;
> +       struct hlist_bl_node *dup_node;
> +
> +       /*
> +        * Remove the namespace structure from hash table so
> +        * now new lookups can start on it.

s/now new/no new/

[...]
> @@ -474,9 +551,116 @@ static struct user_namespace *pidns_owner(struct ns_common *ns)
>         .get_parent     = pidns_get_parent,
>  };
>
> +/*
> + * translate_pid - convert pid in source pid-ns into target pid-ns.
> + * @pid: pid for translation
> + * @source: pid-ns id
> + * @target: pid-ns id
> + *
> + * Return pid in @target pid-ns, zero if task have no pid there,
> + * or -ESRCH of task with @pid is not found in @source pid-ns.

s/of/if/

> + */
> +SYSCALL_DEFINE3(translate_pid, pid_t, pid, u64, source,
> +               u64, target)
> +{
> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
> +       struct pid *struct_pid;
> +       struct pid_namespace *ph;
> +       struct hlist_bl_head *shead = NULL;
> +       struct hlist_bl_head *thead = NULL;
> +       struct hlist_bl_node *dup_node;
> +       pid_t result;
> +
> +       if (!source) {
> +               source_ns = &init_pid_ns;
> +       } else {
> +               shead = pid_ns_hash_head(pid_ns_hash, source);
> +               hlist_bl_lock(shead);
> +               hlist_bl_for_each_entry(ph, dup_node, shead, node) {
> +                       if (source == ph->ns.ns_id) {
> +                               source_ns = ph;
> +                               break;
> +                       }
> +               }
> +               if (!source_ns) {
> +                       hlist_bl_unlock(shead);
> +                       return -EINVAL;
> +               }
> +       }
> +       if (!ptrace_may_access(source_ns->child_reaper,
> +                              PTRACE_MODE_READ_FSCREDS)) {

AFAICS this proposal breaks the visibility restrictions that
namespaces normally create. If there are two namespaces-based
containers that use the same UID range, I don't think they should be
able to learn information about each other, such as which PIDs are in
use in the other container; but as far as I can tell, your proposal
makes it possible to do that (unless an LSM or so is interfering). I
would prefer it if this API required visibility of the targeted PID
namespaces in the caller's PID namespace.

When doing ptrace access checks, please use the real creds in syscalls
like this one, not the fs creds. The fs creds are for filesystem
syscalls (in particular sys_open()), not for specialized syscalls like
ptrace() or this one.
