Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB92C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AA1214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="pmb5KYIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731259AbeL0WyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:54:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37659 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbeL0WyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:54:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so17362084ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EmcAkEM95jL8wsPF9NpowlBsmp1A4yTMQYw1xsFyo34=;
        b=pmb5KYIcFEYLnOP4LyDM6/rBROZFKQtugBJPPzdPf9n2mUXlgmFFukvyraRQhPw9W1
         24rNuk8+aWv1tcQ02Op4VMOHrB6dfSokhxyid5j4xs/KIrFw2rWg61mjU1fOJjyPfMXo
         TeUC388qhaHjQq6gZ9fafEWT2uTlffYNdxEnihqazHFOeCM69LuAzVrqX0pPgQvMxWzN
         l0oA93XuRGoZyQUQLHrzVzkTfT6lBEge1ieSVmU1yJTIRq8YivsJhjbOF2lUjfttANHg
         5ZXUvoRX+PRMCAZ218i7zxtI5hLq87e5R9aCzHaJ1/IQ0Yvclgtcg9pCijmYDCQV2oRC
         QJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EmcAkEM95jL8wsPF9NpowlBsmp1A4yTMQYw1xsFyo34=;
        b=EJxXqhX55uQk9pKS4ABjIoogOWXptyPvZHzRNhl6cr7/ifBd1/IidtpuNAq7gSDJtm
         aaj76VdbONSnqvcK21FsX1ducInK67WryPhnEEl7aDdNnyoU0ieRnp5wvHvOmpV5nmCZ
         SMLr8ffmt2cgnCrP69fcZL4FTr/dFGD12fj05d0snTtqi0CRSEtbvhrp8/6QdldfF0PF
         aZ76sgvQcWV5a3oOea3LDojIk8mt4bSmyG4wSjk10ncG/A3bdG+ILw2+6m+wsHyeFHON
         ulJ6w4fxu0zQ7LqNpWPgw2VN1PYPVM5mkaxvtv4bCyCc0XzyH87seUwwinn7zYrjuJxT
         uuvw==
X-Gm-Message-State: AJcUukeSbwDpzQDwRbIwiK0PGp35kAcDAJEgCN20FfDi0iMVMpyXGbtn
        2DBKJRa0VJ+py7SpcI97uoLLXZ3wZtZBExaw19wT
X-Google-Smtp-Source: ALg8bN5CLiXuUH6EWjnNVxg6Zg/B+Z7rAYqbjZfeRgk/YU7IKMZtrYWpGTcy05RdR9mOQl6IjPXmRMoUdO2XnFAiCA8=
X-Received: by 2002:a2e:8605:: with SMTP id a5-v6mr12242314lji.145.1545951260595;
 Thu, 27 Dec 2018 14:54:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <3f5edfb0d530d7f0061fe11b817b315b350b9d86.1533065887.git.rgb@redhat.com>
 <CAHC9VhT2GJH2cJsrCsxCZMLsdv67oXJhH9mHAgpfMRY4=y43WQ@mail.gmail.com>
 <20181031193018.67pxaxzxlbdc4lkd@madcap2.tricolour.ca> <20181227153354.k2vd4be2c6t2kqe4@madcap2.tricolour.ca>
In-Reply-To: <20181227153354.k2vd4be2c6t2kqe4@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Dec 2018 17:54:09 -0500
Message-ID: <CAHC9VhSw1Aqi7BTh1CEfsWOYPQ-t8uiT6ic91bggxrwhYOi3_A@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 09/10] audit: NETFILTER_PKT: record
 each container ID associated with a netNS
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     simo@redhat.com, carlos@redhat.com, netdev@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 10:34 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-10-31 15:30, Richard Guy Briggs wrote:
> > On 2018-10-19 19:18, Paul Moore wrote:
> > > On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> > > > event standalone records.  Iterate through all potential audit container
> > > > identifiers associated with a network namespace.
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  include/linux/audit.h    |  5 +++++
> > > >  kernel/audit.c           | 26 ++++++++++++++++++++++++++
> > > >  net/netfilter/xt_AUDIT.c | 12 ++++++++++--
> > > >  3 files changed, 41 insertions(+), 2 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > > index 9a02095..8755f4d 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -169,6 +169,8 @@ extern int audit_log_contid(struct audit_context *context,
> > > >  extern void audit_netns_contid_add(struct net *net, u64 contid);
> > > >  extern void audit_netns_contid_del(struct net *net, u64 contid);
> > > >  extern void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p);
> > > > +extern void audit_log_netns_contid_list(struct net *net,
> > > > +                                struct audit_context *context);
> > > >
> > > >  extern int                 audit_update_lsm_rules(void);
> > > >
> > > > @@ -228,6 +230,9 @@ static inline void audit_netns_contid_del(struct net *net, u64 contid)
> > > >  { }
> > > >  static inline void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
> > > >  { }
> > > > +static inline void audit_log_netns_contid_list(struct net *net,
> > > > +                                       struct audit_context *context)
> > > > +{ }
> > > >
> > > >  #define audit_enabled AUDIT_OFF
> > > >  #endif /* CONFIG_AUDIT */
> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index c5fed3b..b23711c 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -392,6 +392,32 @@ void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
> > > >                 audit_netns_contid_add(new->net_ns, contid);
> > > >  }
> > > >
> > > > +void audit_log_netns_contid_list(struct net *net, struct audit_context *context)
> > > > +{
> > > > +       spinlock_t *lock = audit_get_netns_contid_list_lock(net);
> > > > +       struct audit_buffer *ab;
> > > > +       struct audit_contid *cont;
> > > > +       bool first = true;
> > > > +
> > > > +       /* Generate AUDIT_CONTAINER record with container ID CSV list */
> > > > +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_CONTAINER);
> > > > +       if (!ab) {
> > > > +               audit_log_lost("out of memory in audit_log_netns_contid_list");
> > > > +               return;
> > > > +       }
> > > > +       audit_log_format(ab, "contid=");
> > > > +       spin_lock(lock);
> > > > +       list_for_each_entry(cont, audit_get_netns_contid_list(net), list) {
> > > > +               if (!first)
> > > > +                       audit_log_format(ab, ",");
> > > > +               audit_log_format(ab, "%llu", cont->id);
> > > > +               first = false;
> > > > +       }
> > > > +       spin_unlock(lock);
> > >
> > > This is looking like potentially a lot of work to be doing under a
> > > spinlock, not to mention a single spinlock that is shared across CPUs.
> > > Considering that I expect changes to the list to be somewhat
> > > infrequent, this might be a good candidate for a RCU based locking
> > > scheme.
> >
> > Would something like this look reasonable?
> > (This is on top of a patch to make contid list lock and unlock
> > functions.)
>
> Paul, could I please get your review on this locking approach I proposed
> almost two months ago so I can be more reassured that it won't be an
> issue in v5?  Thanks!

I see that not much was learned from our last exchange.  This is disappointing.

At this point you've exhausted my goodwill, and the "This is on top of
a patch to make contid list lock and unlock
functions" comment isn't clear to me at this moment so I'm going to
suggest you just post it as part of your next patchset revision so it
can be seen in the proper context.  Based on a quick inspection it
doesn't seems like there is any mutual exclusion for the writers, but
perhaps this is part of the of "... on top of a patch ..." hand
waving; another reason to see the patch in proper context.

If you've read and understand everything under Documentation/RCU (the
checklist.txt can be helpful), it should be fine.  If you haven't, you
should do so before posting the next iteration.

> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index be5d6eb..9428fc3 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -92,6 +92,7 @@ struct audit_contid {
> >       struct list_head        list;
> >       u64                     id;
> >       refcount_t              refcount;
> > +     struct rcu_head         rcu;
> >  };
> >
> >  extern int is_audit_feature_set(int which);
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index d5b58163..6f84c25 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -106,7 +106,6 @@
> >  struct audit_net {
> >       struct sock *sk;
> >       struct list_head contid_list;
> > -     spinlock_t contid_list_lock;
> >  };
> >
> >  /**
> > @@ -327,26 +326,6 @@ struct list_head *audit_get_netns_contid_list(const struct net *net)
> >       return &aunet->contid_list;
> >  }
> >
> > -static int audit_netns_contid_lock(const struct net *net)
> > -{
> > -     struct audit_net *aunet = net_generic(net, audit_net_id);
> > -
> > -     if (!aunet)
> > -             return -EINVAL;
> > -     spin_lock(aunet->contid_list_lock);
> > -     return 0;
> > -}
> > -
> > -static int audit_netns_contid_unlock(const struct net *net)
> > -{
> > -     struct audit_net *aunet = net_generic(net, audit_net_id);
> > -
> > -     if (!aunet)
> > -             return -EINVAL;
> > -     spin_unlock(aunet->contid_list_lock);
> > -     return 0;
> > -}
> > -
> >  void audit_netns_contid_add(struct net *net, u64 contid)
> >  {
> >       struct list_head *contid_list = audit_get_netns_contid_list(net);
> > @@ -354,10 +333,9 @@ void audit_netns_contid_add(struct net *net, u64 contid)
> >
> >       if (!audit_contid_valid(contid))
> >               return;
> > -     if (audit_netns_contid_lock(net))
> > -             return;
> > +     rcu_read_lock();
> >       if (!list_empty(contid_list))
> > -             list_for_each_entry(cont, contid_list, list)
> > +             list_for_each_entry_rcu(cont, contid_list, list)
> >                       if (cont->id == contid) {
> >                               refcount_inc(&cont->refcount);
> >                               goto out;
> > @@ -367,10 +345,16 @@ void audit_netns_contid_add(struct net *net, u64 contid)
> >               INIT_LIST_HEAD(&cont->list);
> >               cont->id = contid;
> >               refcount_set(&cont->refcount, 1);
> > -             list_add(&cont->list, contid_list);
> > +             list_add_rcu(&cont->list, contid_list);
> >       }
> >  out:
> > -     audit_netns_contid_unlock(net);
> > +     rcu_read_unlock();
> > +}
> > +
> > +audit_free_contid_rcu(struct rcu_head *head) {
> > +     struct audit_contid *contid = container_of(head, struct audit_contid, rcu);
> > +
> > +     kfree(contid);
> >  }
> >
> >  void audit_netns_contid_del(struct net *net, u64 contid)
> > @@ -380,17 +364,16 @@ void audit_netns_contid_del(struct net *net, u64 contid)
> >
> >       if (!audit_contid_valid(contid))
> >               return;
> > -     if (audit_netns_contid_lock(net))
> > -             return;
> > +     rcu_read_lock();
> >       if (!list_empty(contid_list))
> > -             list_for_each_entry(cont, contid_list, list)
> > +             list_for_each_entry_rcu(cont, contid_list, list)
> >                       if (cont->id == contid) {
> > -                             list_del(&cont->list);
> > +                             list_del_rcu(&cont->list);
> >                               if (refcount_dec_and_test(&cont->refcount))
> > -                                     kfree(cont);
> > +                                     call_rcu(&cont->rcu, audit_free_contid_rcu);
> >                               break;
> >                       }
> > -     audit_netns_contid_unlock(net);
> > +     rcu_read_unlock();
> >  }
> >
> >  void audit_switch_task_namespaces(struct nsproxy *ns, struct task_struct *p)
> > @@ -418,15 +401,14 @@ void audit_log_netns_contid_list(struct net *net, struct audit_context *context)
> >               return;
> >       }
> >       audit_log_format(ab, "ref=net contid=");
> > -     if (audit_netns_contid_lock(net))
> > -             return;
> > -     list_for_each_entry(cont, audit_get_netns_contid_list(net), list) {
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(cont, audit_get_netns_contid_list(net), list) {
> >               if (!first)
> >                       audit_log_format(ab, ",");
> >               audit_log_format(ab, "%llu", cont->id);
> >               first = false;
> >       }
> > -     audit_netns_contid_unlock(net);
> > +     rcu_read_unlock();
> >       audit_log_end(ab);
> >  }
> >  EXPORT_SYMBOL(audit_log_netns_contid_list);
> > @@ -1674,7 +1656,6 @@ static int __net_init audit_net_init(struct net *net)
> >               .flags  = NL_CFG_F_NONROOT_RECV,
> >               .groups = AUDIT_NLGRP_MAX,
> >       };
> > -
> >       struct audit_net *aunet = net_generic(net, audit_net_id);
> >
> >       aunet->sk = netlink_kernel_create(net, NETLINK_AUDIT, &cfg);
> > @@ -1684,8 +1665,6 @@ static int __net_init audit_net_init(struct net *net)
> >       }
> >       aunet->sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
> >       INIT_LIST_HEAD(&aunet->contid_list);
> > -     spin_lock_init(&aunet->contid_list_lock);
> > -
> >       return 0;
> >  }
> >
> > >
> > > > +       audit_log_end(ab);
> > > > +}
> > > > +EXPORT_SYMBOL(audit_log_netns_contid_list);
> > > >
> > > >  void audit_panic(const char *message)
> > > >  {
> > > >         switch (audit_failure) {
> > > > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> > > > index af883f1..44fac3f 100644
> > > > --- a/net/netfilter/xt_AUDIT.c
> > > > +++ b/net/netfilter/xt_AUDIT.c
> > > > @@ -71,10 +71,13 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> > > >  {
> > > >         struct audit_buffer *ab;
> > > >         int fam = -1;
> > > > +       struct audit_context *context;
> > > > +       struct net *net;
> > > >
> > > >         if (audit_enabled == AUDIT_OFF)
> > > > -               goto errout;
> > > > -       ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> > > > +               goto out;
> > > > +       context = audit_alloc_local(GFP_ATOMIC);
> > > > +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> > > >         if (ab == NULL)
> > > >                 goto errout;
> > > >
> > > > @@ -104,7 +107,12 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> > > >
> > > >         audit_log_end(ab);
> > > >
> > > > +       net = xt_net(par);
> > > > +       audit_log_netns_contid_list(net, context);
> > > > +
> > > >  errout:
> > > > +       audit_free_context(context);
> > > > +out:
> > > >         return XT_CONTINUE;
> > > >  }
> > > >
> > >
> > > --
> > > paul moore
> > > www.paul-moore.com
> >
> > - RGB
> >
> > --
> > Richard Guy Briggs <rgb@redhat.com>
> > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > Remote, Ottawa, Red Hat Canada
> > IRC: rgb, SunRaycer
> > Voice: +1.647.777.2635, Internal: (81) 32635
> >
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635



-- 
paul moore
www.paul-moore.com
