Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2445703-1524254942-2-5026740717842409601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524254941; b=mx24o2EUWTfG88+br6kx8YwuiVuCvlJ6sYeU1rCqdPhq+mPjqs
    Nk9A+Q7ZJbJ9LVuLR1v0azMIx3/TfTPFI3YZ8o/bGvA/YfGENXZV0D56vBU6S8vR
    VVD/jqjYjjlXqwIZ9fLEeSOObaQu/6xSHNO1vVvXKYTeFjBYJzSs+AXBKWI6cjfL
    yVrLd7Hn12mxPFX/B61iHQFAIFFn2creFVzKVmoLHJBhw/vbTvWIuwJfGakofEUY
    /S97SXP9cinAPzFdZEbx2+3GqhOTyan2oqbVxbwQT9ScmRZ6+A4G+9f+22JbSeaP
    FYrQiU5c7jx66is1vu2QFbdaF/lPtSL802Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524254941; bh=CvUwFUr19qkndDtzswDsHYt77TgaW9
    gcUzRxvi41H4E=; b=kTv3sIjtks/r8wlYzI1w7ychZJmymze0bSaP0uACDKe5oU
    k+FM+/bGpEF7xo1TePgPzniKuyEZmUewLKb41Gwtsa5iI5aGbdGuS4NnZzpnGSJt
    ZVi6yG/tCykK4nndwEfxBUmtOG2gW7ZtoTxHw15o4sPZjjNAQ7WUh8CRv75fBb9e
    Ppgh0TOil3QQcGIvcU7xPQELo8OuIWUOayXeim74WaSwwHqhqG+sxVGVcYyGZnxS
    J/x05I/teg/r/Kzo7NP/t8f3AjdXMrPz2WhA2FpS3SadlrfzybJ22MMGu/qkCg1k
    5iXXlfmwpkMALPpwnv91Kzesp7zv5cskDAt4sWOg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPI2m73aNS8O6tgB9zHqVJpYkUE7itorp34IteP/BLAoTqLLWmjToXmpAQ71wYwCgy/sjv5ZBeHTD5icJFHvDxmZqlzFl99LArHu7c8zIi18o3fTKZ2k
    LFh64OQ3S4kZfCo//mLRtnDEYz3S3My85Bc3UzvVg/cN3CKu+t9/8lQh8h0xgFc8G3EPudVmSRvdWsWSkqtM2P36uTO34zO3SrRxNLtPFDeacr5gi6yEOMAg
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=r4AHofZVfCTW7qhh9tsA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751478AbeDTUIk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 16:08:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750927AbeDTUIj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Apr 2018 16:08:39 -0400
Date: Fri, 20 Apr 2018 16:02:26 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid
 to network namespaces
Message-ID: <20180420200226.7tyxzuovdbgclw3m@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
 <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 21:46, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Audit events could happen in a network namespace outside of a task
> > context due to packets received from the net that trigger an auditing
> > rule prior to being associated with a running task.  The network
> > namespace could in use by multiple containers by association to the
> > tasks in that network namespace.  We still want a way to attribute
> > these events to any potential containers.  Keep a list per network
> > namespace to track these container identifiiers.
> >
> > Add/increment the container identifier on:
> > - initial setting of the container id via /proc
> > - clone/fork call that inherits a container identifier
> > - unshare call that inherits a container identifier
> > - setns call that inherits a container identifier
> > Delete/decrement the container identifier on:
> > - an inherited container id dropped when child set
> > - process exit
> > - unshare call that drops a net namespace
> > - setns call that drops a net namespace
> >
> > See: https://github.com/linux-audit/audit-kernel/issues/32
> > See: https://github.com/linux-audit/audit-testsuite/issues/64
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  include/linux/audit.h       |  7 +++++++
> >  include/net/net_namespace.h | 12 ++++++++++++
> >  kernel/auditsc.c            |  9 ++++++---
> >  kernel/nsproxy.c            |  6 ++++++
> >  net/core/net_namespace.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 76 insertions(+), 3 deletions(-)
> 
> ...
> 
> > diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> > index 0490084..343a428 100644
> > --- a/include/net/net_namespace.h
> > +++ b/include/net/net_namespace.h
> > @@ -33,6 +33,7 @@
> >  #include <linux/ns_common.h>
> >  #include <linux/idr.h>
> >  #include <linux/skbuff.h>
> > +#include <linux/audit.h>
> >
> >  struct user_namespace;
> >  struct proc_dir_entry;
> > @@ -150,6 +151,7 @@ struct net {
> >  #endif
> >         struct sock             *diag_nlsk;
> >         atomic_t                fnhe_genid;
> > +       struct list_head        audit_containerid;
> >  } __randomize_layout;
> 
> We talked about this briefly off-list, you should be using audit_net
> and the net_generic mechanism instead of this.
> 
> >  #include <linux/seq_file_net.h>
> > @@ -301,6 +303,16 @@ static inline struct net *read_pnet(const possible_net_t *pnet)
> >  #define __net_initconst        __initconst
> >  #endif
> >
> > +#ifdef CONFIG_NET_NS
> > +void net_add_audit_containerid(struct net *net, u64 containerid);
> > +void net_del_audit_containerid(struct net *net, u64 containerid);
> > +#else
> > +static inline void net_add_audit_containerid(struct net *, u64)
> > +{ }
> > +static inline void net_del_audit_containerid(struct net *, u64)
> > +{ }
> > +#endif
> > +
> >  int peernet2id_alloc(struct net *net, struct net *peer);
> >  int peernet2id(struct net *net, struct net *peer);
> >  bool peernet_has_id(struct net *net, struct net *peer);
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 2f02ed9..208da962 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -75,6 +75,7 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/fsnotify_backend.h>
> >  #include <uapi/linux/limits.h>
> > +#include <net/net_namespace.h>
> >
> >  #include "audit.h"
> >
> > @@ -2175,16 +2176,18 @@ static void audit_log_set_containerid(struct task_struct *task, u64 oldcontainer
> >   */
> >  int audit_set_containerid(struct task_struct *task, u64 containerid)
> >  {
> > -       u64 oldcontainerid;
> > +       u64 oldcontainerid = audit_get_containerid(task);
> >         int rc;
> > -
> > -       oldcontainerid = audit_get_containerid(task);
> > +       struct net *net = task->nsproxy->net_ns;
> >
> >         rc = audit_set_containerid_perm(task, containerid);
> >         if (!rc) {
> > +               if (cid_valid(oldcontainerid))
> > +                       net_del_audit_containerid(net, oldcontainerid);
> 
> Using audit_net we can handle this internal to audit, which is a Good Thing.

No problem, done.

> >                 task_lock(task);
> >                 task->containerid = containerid;
> >                 task_unlock(task);
> > +               net_add_audit_containerid(net, containerid);
> 
> Same.
> 
> >         }
> >
> >         audit_log_set_containerid(task, oldcontainerid, containerid, rc);
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index f6c5d33..d9f1090 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >         struct nsproxy *old_ns = tsk->nsproxy;
> >         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
> >         struct nsproxy *new_ns;
> > +       u64 containerid = audit_get_containerid(tsk);
> >
> >         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> >                               CLONE_NEWPID | CLONE_NEWNET |
> > @@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >                 return  PTR_ERR(new_ns);
> >
> >         tsk->nsproxy = new_ns;
> > +       net_add_audit_containerid(new_ns->net_ns, containerid);
> >         return 0;
> >  }
> 
> Hopefully we can handle this in audit_net_init(), we just need to
> figure out where we can get the correct task_struct for the audit
> container ID (some backpointer in the net struct?).

I don't follow.  This needs to happen on every task startup.
audit_net_init() is only called when a new network namespace starts up.

> > @@ -217,6 +219,7 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
> >  void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
> >  {
> >         struct nsproxy *ns;
> > +       u64 containerid = audit_get_containerid(p);
> >
> >         might_sleep();
> >
> > @@ -224,6 +227,9 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
> >         ns = p->nsproxy;
> >         p->nsproxy = new;
> >         task_unlock(p);
> > +       net_del_audit_containerid(ns->net_ns, containerid);
> > +       if (new)
> > +               net_add_audit_containerid(new->net_ns, containerid);
> 
> Okay, we might need a hook here for switching namespaces, but I would
> much rather it be a generic audit hook that calls directly into audit.

Trivial, done.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
