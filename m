Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1828774-1524102435-2-760121070998121157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524102435; b=LKxp7L1RyZkkOnVID8TTFjq3XFSOHhOlT0V07H4EByS8Is5WYU
    P+cgK/y5+ROK4FGNvbSueVQ1Ku74yCDWYgLc09u1LMYCEbL7od2cqTsf+K2fiznB
    GQLYghKxi341VQLz6bDx+U3afjFsDHIgS/0BIOt3/NWzF9ZK8qdx4358WkoP+v9T
    M/9lsk89bub/q1dIeeBq3S5J7oSuJ7k4xLIHCKOnlDmG/INgL/6cNsvqjgd2cyc+
    TIvIzGS1wVZB7MNjqWCLM20Q7yeOGlVyC4UEWZ6bqjZKpWDrIApNXm26z868spZW
    BLbdzmoeLGWyQA9A2nWKnHd/NIaX3TKG0KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524102435; bh=bSPsG8C2KUPUODfGMZ2Mab3PDO/6NTqKITkLVS4UJK
    0=; b=XZOP9Y/VRNUc4spJrpl3Wplbjhuql5/+dW12J8BLuJNJ4Q3DWryHGrfng7
    qNyw1djYaZPn6RMzFWcHsXAfGI7leSmnf1154uxjR69PY0R+2n1D8eI48m0TbE8O
    m4KWCwrvrSUseOsP5EUWKR+LhggubgzSZY1qcR54HHTH/E0yFhnFSQG3lzhDRuo9
    Q+STx2t5RgdiGZngiA4kAcxxvIgHbJ2j8IutLrQn8ED3wNRF8FaD62F/TizygP1D
    sFd3N4XlgOL4OZb9n+S36kzMVBfEHkCkQLg9u2/BHoP1Sozo6pX0gle/Zi2hNVXK
    9Sn81vRTtPBAgaMJDk79cAak9X9g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=E+AwJVaW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yleo9/0L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=E+AwJVaW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yleo9/0L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfIbeEpQgrYMeFntzaq9ZKkA/HfBG4z2FDd8n2M1xrF+v+Nu82gPJQ7DhYJq9BSBY87g8XmdCDxocGwaE/iDHy9GgZD4pTkUJ3EmVc1ED+Ea4lGoHaD
    DNjyCdfSMD6AC4vlOaCNB+PnQ/9+jeOYAGtae6Zf6wRhKwxyv2J9l3B9D/Rndh5hZG96VTZJ4KBYOev6TfaOC269twZ1ukVYq/wjEbmn+0qGJnYIKvmyWNkS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=qRfYg4EXcgQVTRYvy6MA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbeDSBqx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 21:46:53 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39449 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeDSBqw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 21:46:52 -0400
X-Google-Smtp-Source: AIpwx4/tFMsCZ7RLbFOLrj0veBg6g1Tg+G5NqSRHRraCdqcIkcTXaHZlPHHsYA9uHrocpY97cZcAOf+yobS13PEn3Ao=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 21:46:49 -0400
Message-ID: <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid to
 network namespaces
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Audit events could happen in a network namespace outside of a task
> context due to packets received from the net that trigger an auditing
> rule prior to being associated with a running task.  The network
> namespace could in use by multiple containers by association to the
> tasks in that network namespace.  We still want a way to attribute
> these events to any potential containers.  Keep a list per network
> namespace to track these container identifiiers.
>
> Add/increment the container identifier on:
> - initial setting of the container id via /proc
> - clone/fork call that inherits a container identifier
> - unshare call that inherits a container identifier
> - setns call that inherits a container identifier
> Delete/decrement the container identifier on:
> - an inherited container id dropped when child set
> - process exit
> - unshare call that drops a net namespace
> - setns call that drops a net namespace
>
> See: https://github.com/linux-audit/audit-kernel/issues/32
> See: https://github.com/linux-audit/audit-testsuite/issues/64
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/audit.h       |  7 +++++++
>  include/net/net_namespace.h | 12 ++++++++++++
>  kernel/auditsc.c            |  9 ++++++---
>  kernel/nsproxy.c            |  6 ++++++
>  net/core/net_namespace.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 76 insertions(+), 3 deletions(-)

...

> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index 0490084..343a428 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -33,6 +33,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/idr.h>
>  #include <linux/skbuff.h>
> +#include <linux/audit.h>
>
>  struct user_namespace;
>  struct proc_dir_entry;
> @@ -150,6 +151,7 @@ struct net {
>  #endif
>         struct sock             *diag_nlsk;
>         atomic_t                fnhe_genid;
> +       struct list_head        audit_containerid;
>  } __randomize_layout;

We talked about this briefly off-list, you should be using audit_net
and the net_generic mechanism instead of this.

>  #include <linux/seq_file_net.h>
> @@ -301,6 +303,16 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
>  #define __net_initconst        __initconst
>  #endif
>
> +#ifdef CONFIG_NET_NS
> +void net_add_audit_containerid(struct net *net, u64 containerid);
> +void net_del_audit_containerid(struct net *net, u64 containerid);
> +#else
> +static inline void net_add_audit_containerid(struct net *, u64)
> +{ }
> +static inline void net_del_audit_containerid(struct net *, u64)
> +{ }
> +#endif
> +
>  int peernet2id_alloc(struct net *net, struct net *peer);
>  int peernet2id(struct net *net, struct net *peer);
>  bool peernet_has_id(struct net *net, struct net *peer);
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 2f02ed9..208da962 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -75,6 +75,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/fsnotify_backend.h>
>  #include <uapi/linux/limits.h>
> +#include <net/net_namespace.h>
>
>  #include "audit.h"
>
> @@ -2175,16 +2176,18 @@ static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainer
>   */
>  int audit_set_containerid(struct task_struct *task, u64 containerid)
>  {
> -       u64 oldcontainerid;
> +       u64 oldcontainerid = audit_get_containerid(task);
>         int rc;
> -
> -       oldcontainerid = audit_get_containerid(task);
> +       struct net *net = task->nsproxy->net_ns;
>
>         rc = audit_set_containerid_perm(task, containerid);
>         if (!rc) {
> +               if (cid_valid(oldcontainerid))
> +                       net_del_audit_containerid(net, oldcontainerid);

Using audit_net we can handle this internal to audit, which is a Good Thing.

>                 task_lock(task);
>                 task->containerid = containerid;
>                 task_unlock(task);
> +               net_add_audit_containerid(net, containerid);

Same.

>         }
>
>         audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> index f6c5d33..d9f1090 100644
> --- a/kernel/nsproxy.c
> +++ b/kernel/nsproxy.c
> @@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>         struct nsproxy *old_ns = tsk->nsproxy;
>         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
>         struct nsproxy *new_ns;
> +       u64 containerid = audit_get_containerid(tsk);
>
>         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
>                               CLONE_NEWPID | CLONE_NEWNET |
> @@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>                 return  PTR_ERR(new_ns);
>
>         tsk->nsproxy = new_ns;
> +       net_add_audit_containerid(new_ns->net_ns, containerid);
>         return 0;
>  }

Hopefully we can handle this in audit_net_init(), we just need to
figure out where we can get the correct task_struct for the audit
container ID (some backpointer in the net struct?).

> @@ -217,6 +219,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
>  void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
>  {
>         struct nsproxy *ns;
> +       u64 containerid = audit_get_containerid(p);
>
>         might_sleep();
>
> @@ -224,6 +227,9 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
>         ns = p->nsproxy;
>         p->nsproxy = new;
>         task_unlock(p);
> +       net_del_audit_containerid(ns->net_ns, containerid);
> +       if (new)
> +               net_add_audit_containerid(new->net_ns, containerid);

Okay, we might need a hook here for switching namespaces, but I would
much rather it be a generic audit hook that calls directly into audit.

-- 
paul moore
www.paul-moore.com
