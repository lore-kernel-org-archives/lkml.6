Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBBAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2B921473
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sabayonlinux-org.20150623.gappssmtp.com header.i=@sabayonlinux-org.20150623.gappssmtp.com header.b="N4zH+F1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2B921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sabayonlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbeK3CNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:13:44 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35065 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeK3CNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:13:43 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so1703298lfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sabayonlinux-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=acxzmzyl0DOYDN5T45/dbwrEQWJWoaSaw53QI4TiOBk=;
        b=N4zH+F1BsJjwq3+7/u+QssRvJKQ/d4Aaq5uRxq7KGkoVQABb1+2NEZNs+Hgt9gcLih
         jjaHmZjQlO22Hrok32/RR8vv0ZteP7uIAGYFK68PaZIVvBLHUjf18oyKETpdCXflAXQU
         N3DAw1rXRwdDmmmr/oGHJ0t+8BaEULqcytyr4GcGOn3qkQ7xb8ZJFV5tmL5mVxTsZ5z3
         Dce0Z0kSLv6uqvN2N2WY2O3ptNHWBEJTUvUtH4DDWyjR6I/048/5UjMQP1BICGtTiVlV
         a/NFclyXLstao6NlGMatrYZnL2s/8wEZMp5N22Il10QDllp5xx4dMgyOXqujj22BndBZ
         IPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=acxzmzyl0DOYDN5T45/dbwrEQWJWoaSaw53QI4TiOBk=;
        b=lb1Cc2MSGLbWYOo67z0hC2VNGgDNRV+3tcdf+hPceC83mQxgGZs4rj1a9QKHo+IWca
         7t5F9Ade9ashq4E6L6BiQKlbCVJv3LbkJgbNjTayr6cR6LmaTPiL+Gc2v1AEP2FHSsBQ
         FLSvuG9E0JCIBquXLlPFwXKF8IzsWWZVjCmz35MFMjwO+ZzxW1p88vAt+dY4T2vJDCET
         riLEjDHI09cXmNjfYFSb70xbKSnv/KjB3PFkdpqdeJb6I36d2Le9SdSZIzObclXPx+gJ
         ifiUBdx/HIK0oXty+huhPI8hRCvLmcwtE3V5xHz8nHVKcFwhK1yLuFUOU8POYoWQ/PSq
         r8sw==
X-Gm-Message-State: AA+aEWaQW/DmM6E0IiqVKiaoHNy2DwXKe1AvPFnR43KeuYA/UYVedNgW
        Hhq0oT+ldNOlW9bEuCCGn3wdwx1zRWjpHifCL54oSw==
X-Google-Smtp-Source: AFSGD/UU89ouyWzfN2C0AWbMFFN+wJNkEa9ZTn56IxF0SMOOUFpkvQtJs3i96DsRhAAagD6ZwcOQC1p5if4+idlIpWA=
X-Received: by 2002:a19:d90c:: with SMTP id q12mr1244503lfg.24.1543504079667;
 Thu, 29 Nov 2018 07:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20180917211703.481236999@linuxfoundation.org> <20180917211711.665799911@linuxfoundation.org>
 <CAKcLGm9+Juyf894=UcwCoDg+zzJ=zQeoryzhG0s7GdiAbjLaiQ@mail.gmail.com> <20181129103323.GD20297@kroah.com>
In-Reply-To: <20181129103323.GD20297@kroah.com>
From:   Mitch Harder <mitch.harder@sabayonlinux.org>
Date:   Thu, 29 Nov 2018 09:07:48 -0600
Message-ID: <CAKcLGm9g6Z=_vzCzdGBrgafeuEzAzFB+SsPbD_CgNcuVV84KHA@mail.gmail.com>
Subject: Re: [PATCH 4.14 117/126] net: sk_buff rbnode reorg
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Wei Wang <weiwan@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 4:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 04, 2018 at 03:13:56PM -0500, Mitch Harder wrote:
> > On Mon, Sep 17, 2018 at 5:42 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > >
> > > ------------------
> > >
> > > From: Eric Dumazet <edumazet@google.com>
> > >
> > > commit bffa72cf7f9df842f0016ba03586039296b4caaf upstream
> > >
> > > skb->rbnode shares space with skb->next, skb->prev and skb->tstamp
> > >
> > > Current uses (TCP receive ofo queue and netem) need to save/restore
> > > tstamp, while skb->dev is either NULL (TCP) or a constant for a given
> > > queue (netem).
> > >
> > > Since we plan using an RB tree for TCP retransmit queue to speedup SACK
> > > processing with large BDP, this patch exchanges skb->dev and
> > > skb->tstamp.
> > >
> > > This saves some overhead in both TCP and netem.
> > >
> > > v2: removes the swtstamp field from struct tcp_skb_cb
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Cc: Soheil Hassas Yeganeh <soheil@google.com>
> > > Cc: Wei Wang <weiwan@google.com>
> > > Cc: Willem de Bruijn <willemb@google.com>
> > > Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  include/linux/skbuff.h                  |   24 ++--
> > >  include/net/inet_frag.h                 |    3
> > >  net/ipv4/inet_fragment.c                |   14 +-
> > >  net/ipv4/ip_fragment.c                  |  182 +++++++++++++++++---------------
> > >  net/ipv6/netfilter/nf_conntrack_reasm.c |    1
> > >  net/ipv6/reassembly.c                   |    1
> > >  6 files changed, 128 insertions(+), 97 deletions(-)
> > >
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -663,23 +663,27 @@ struct sk_buff {
> > >                         struct sk_buff          *prev;
> > >
> > >                         union {
> > > -                               ktime_t         tstamp;
> > > -                               u64             skb_mstamp;
> > > +                               struct net_device       *dev;
> > > +                               /* Some protocols might use this space to store information,
> > > +                                * while device pointer would be NULL.
> > > +                                * UDP receive path is one user.
> > > +                                */
> > > +                               unsigned long           dev_scratch;
> > >                         };
> > >                 };
> > > -               struct rb_node  rbnode; /* used in netem & tcp stack */
> > > +               struct rb_node          rbnode; /* used in netem, ip4 defrag, and tcp stack */
> > > +               struct list_head        list;
> > >         };
> > > -       struct sock             *sk;
> > >
> > >         union {
> > > -               struct net_device       *dev;
> > > -               /* Some protocols might use this space to store information,
> > > -                * while device pointer would be NULL.
> > > -                * UDP receive path is one user.
> > > -                */
> > > -               unsigned long           dev_scratch;
> > > +               struct sock             *sk;
> > >                 int                     ip_defrag_offset;
> > >         };
> > > +
> > > +       union {
> > > +               ktime_t         tstamp;
> > > +               u64             skb_mstamp;
> > > +       };
> > >         /*
> > >          * This is the control buffer. It is free to use for every
> > >          * layer. Please put your private variables there. If you
> > > --- a/include/net/inet_frag.h
> > > +++ b/include/net/inet_frag.h
> > > @@ -75,7 +75,8 @@ struct inet_frag_queue {
> > >         struct timer_list       timer;
> > >         spinlock_t              lock;
> > >         refcount_t              refcnt;
> > > -       struct sk_buff          *fragments;
> > > +       struct sk_buff          *fragments;  /* Used in IPv6. */
> > > +       struct rb_root          rb_fragments; /* Used in IPv4. */
> > >         struct sk_buff          *fragments_tail;
> > >         ktime_t                 stamp;
> > >         int                     len;
> > > --- a/net/ipv4/inet_fragment.c
> > > +++ b/net/ipv4/inet_fragment.c
> > > @@ -136,12 +136,16 @@ void inet_frag_destroy(struct inet_frag_
> > >         fp = q->fragments;
> > >         nf = q->net;
> > >         f = nf->f;
> > > -       while (fp) {
> > > -               struct sk_buff *xp = fp->next;
> > > +       if (fp) {
> > > +               do {
> > > +                       struct sk_buff *xp = fp->next;
> > >
> > > -               sum_truesize += fp->truesize;
> > > -               kfree_skb(fp);
> > > -               fp = xp;
> > > +                       sum_truesize += fp->truesize;
> > > +                       kfree_skb(fp);
> > > +                       fp = xp;
> > > +               } while (fp);
> > > +       } else {
> > > +               sum_truesize = skb_rbtree_purge(&q->rb_fragments);
> > >         }
> > >         sum = sum_truesize + f->qsize;
> > >
> > > --- a/net/ipv4/ip_fragment.c
> > > +++ b/net/ipv4/ip_fragment.c
> > > @@ -136,7 +136,7 @@ static void ip_expire(struct timer_list
> > >  {
> > >         struct inet_frag_queue *frag = from_timer(frag, t, timer);
> > >         const struct iphdr *iph;
> > > -       struct sk_buff *head;
> > > +       struct sk_buff *head = NULL;
> > >         struct net *net;
> > >         struct ipq *qp;
> > >         int err;
> > > @@ -152,14 +152,31 @@ static void ip_expire(struct timer_list
> > >
> > >         ipq_kill(qp);
> > >         __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
> > > -
> > > -       head = qp->q.fragments;
> > > -
> > >         __IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
> > >
> > > -       if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !head)
> > > +       if (!qp->q.flags & INET_FRAG_FIRST_IN)
> > >                 goto out;
> > >
> > > +       /* sk_buff::dev and sk_buff::rbnode are unionized. So we
> > > +        * pull the head out of the tree in order to be able to
> > > +        * deal with head->dev.
> > > +        */
> > > +       if (qp->q.fragments) {
> > > +               head = qp->q.fragments;
> > > +               qp->q.fragments = head->next;
> > > +       } else {
> > > +               head = skb_rb_first(&qp->q.rb_fragments);
> > > +               if (!head)
> > > +                       goto out;
> > > +               rb_erase(&head->rbnode, &qp->q.rb_fragments);
> > > +               memset(&head->rbnode, 0, sizeof(head->rbnode));
> > > +               barrier();
> > > +       }
> > > +       if (head == qp->q.fragments_tail)
> > > +               qp->q.fragments_tail = NULL;
> > > +
> > > +       sub_frag_mem_limit(qp->q.net, head->truesize);
> > > +
> > >         head->dev = dev_get_by_index_rcu(net, qp->iif);
> > >         if (!head->dev)
> > >                 goto out;
> > > @@ -179,16 +196,16 @@ static void ip_expire(struct timer_list
> > >             (skb_rtable(head)->rt_type != RTN_LOCAL))
> > >                 goto out;
> > >
> > > -       skb_get(head);
> > >         spin_unlock(&qp->q.lock);
> > >         icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
> > > -       kfree_skb(head);
> > >         goto out_rcu_unlock;
> > >
> > >  out:
> > >         spin_unlock(&qp->q.lock);
> > >  out_rcu_unlock:
> > >         rcu_read_unlock();
> > > +       if (head)
> > > +               kfree_skb(head);
> > >         ipq_put(qp);
> > >  }
> > >
> > > @@ -231,7 +248,7 @@ static int ip_frag_too_far(struct ipq *q
> > >         end = atomic_inc_return(&peer->rid);
> > >         qp->rid = end;
> > >
> > > -       rc = qp->q.fragments && (end - start) > max;
> > > +       rc = qp->q.fragments_tail && (end - start) > max;
> > >
> > >         if (rc) {
> > >                 struct net *net;
> > > @@ -245,7 +262,6 @@ static int ip_frag_too_far(struct ipq *q
> > >
> > >  static int ip_frag_reinit(struct ipq *qp)
> > >  {
> > > -       struct sk_buff *fp;
> > >         unsigned int sum_truesize = 0;
> > >
> > >         if (!mod_timer(&qp->q.timer, jiffies + qp->q.net->timeout)) {
> > > @@ -253,20 +269,14 @@ static int ip_frag_reinit(struct ipq *qp
> > >                 return -ETIMEDOUT;
> > >         }
> > >
> > > -       fp = qp->q.fragments;
> > > -       do {
> > > -               struct sk_buff *xp = fp->next;
> > > -
> > > -               sum_truesize += fp->truesize;
> > > -               kfree_skb(fp);
> > > -               fp = xp;
> > > -       } while (fp);
> > > +       sum_truesize = skb_rbtree_purge(&qp->q.rb_fragments);
> > >         sub_frag_mem_limit(qp->q.net, sum_truesize);
> > >
> > >         qp->q.flags = 0;
> > >         qp->q.len = 0;
> > >         qp->q.meat = 0;
> > >         qp->q.fragments = NULL;
> > > +       qp->q.rb_fragments = RB_ROOT;
> > >         qp->q.fragments_tail = NULL;
> > >         qp->iif = 0;
> > >         qp->ecn = 0;
> > > @@ -278,7 +288,8 @@ static int ip_frag_reinit(struct ipq *qp
> > >  static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
> > >  {
> > >         struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
> > > -       struct sk_buff *prev, *next;
> > > +       struct rb_node **rbn, *parent;
> > > +       struct sk_buff *skb1;
> > >         struct net_device *dev;
> > >         unsigned int fragsize;
> > >         int flags, offset;
> > > @@ -341,58 +352,58 @@ static int ip_frag_queue(struct ipq *qp,
> > >         if (err)
> > >                 goto err;
> > >
> > > -       /* Find out which fragments are in front and at the back of us
> > > -        * in the chain of fragments so far.  We must know where to put
> > > -        * this fragment, right?
> > > -        */
> > > -       prev = qp->q.fragments_tail;
> > > -       if (!prev || prev->ip_defrag_offset < offset) {
> > > -               next = NULL;
> > > -               goto found;
> > > -       }
> > > -       prev = NULL;
> > > -       for (next = qp->q.fragments; next != NULL; next = next->next) {
> > > -               if (next->ip_defrag_offset >= offset)
> > > -                       break;  /* bingo! */
> > > -               prev = next;
> > > -       }
> > > +       /* Note : skb->rbnode and skb->dev share the same location. */
> > > +       dev = skb->dev;
> > > +       /* Makes sure compiler wont do silly aliasing games */
> > > +       barrier();
> > >
> > > -found:
> > >         /* RFC5722, Section 4, amended by Errata ID : 3089
> > >          *                          When reassembling an IPv6 datagram, if
> > >          *   one or more its constituent fragments is determined to be an
> > >          *   overlapping fragment, the entire datagram (and any constituent
> > >          *   fragments) MUST be silently discarded.
> > >          *
> > > -        * We do the same here for IPv4.
> > > +        * We do the same here for IPv4 (and increment an snmp counter).
> > >          */
> > >
> > > -       /* Is there an overlap with the previous fragment? */
> > > -       if (prev &&
> > > -           (prev->ip_defrag_offset + prev->len) > offset)
> > > -               goto discard_qp;
> > > -
> > > -       /* Is there an overlap with the next fragment? */
> > > -       if (next && next->ip_defrag_offset < end)
> > > -               goto discard_qp;
> > > +       /* Find out where to put this fragment.  */
> > > +       skb1 = qp->q.fragments_tail;
> > > +       if (!skb1) {
> > > +               /* This is the first fragment we've received. */
> > > +               rb_link_node(&skb->rbnode, NULL, &qp->q.rb_fragments.rb_node);
> > > +               qp->q.fragments_tail = skb;
> > > +       } else if ((skb1->ip_defrag_offset + skb1->len) < end) {
> > > +               /* This is the common/special case: skb goes to the end. */
> > > +               /* Detect and discard overlaps. */
> > > +               if (offset < (skb1->ip_defrag_offset + skb1->len))
> > > +                       goto discard_qp;
> > > +               /* Insert after skb1. */
> > > +               rb_link_node(&skb->rbnode, &skb1->rbnode, &skb1->rbnode.rb_right);
> > > +               qp->q.fragments_tail = skb;
> > > +       } else {
> > > +               /* Binary search. Note that skb can become the first fragment, but
> > > +                * not the last (covered above). */
> > > +               rbn = &qp->q.rb_fragments.rb_node;
> > > +               do {
> > > +                       parent = *rbn;
> > > +                       skb1 = rb_to_skb(parent);
> > > +                       if (end <= skb1->ip_defrag_offset)
> > > +                               rbn = &parent->rb_left;
> > > +                       else if (offset >= skb1->ip_defrag_offset + skb1->len)
> > > +                               rbn = &parent->rb_right;
> > > +                       else /* Found an overlap with skb1. */
> > > +                               goto discard_qp;
> > > +               } while (*rbn);
> > > +               /* Here we have parent properly set, and rbn pointing to
> > > +                * one of its NULL left/right children. Insert skb. */
> > > +               rb_link_node(&skb->rbnode, parent, rbn);
> > > +       }
> > > +       rb_insert_color(&skb->rbnode, &qp->q.rb_fragments);
> > >
> > > -       /* Note : skb->ip_defrag_offset and skb->dev share the same location */
> > > -       dev = skb->dev;
> > >         if (dev)
> > >                 qp->iif = dev->ifindex;
> > > -       /* Makes sure compiler wont do silly aliasing games */
> > > -       barrier();
> > >         skb->ip_defrag_offset = offset;
> > >
> > > -       /* Insert this fragment in the chain of fragments. */
> > > -       skb->next = next;
> > > -       if (!next)
> > > -               qp->q.fragments_tail = skb;
> > > -       if (prev)
> > > -               prev->next = skb;
> > > -       else
> > > -               qp->q.fragments = skb;
> > > -
> > >         qp->q.stamp = skb->tstamp;
> > >         qp->q.meat += skb->len;
> > >         qp->ecn |= ecn;
> > > @@ -414,7 +425,7 @@ found:
> > >                 unsigned long orefdst = skb->_skb_refdst;
> > >
> > >                 skb->_skb_refdst = 0UL;
> > > -               err = ip_frag_reasm(qp, prev, dev);
> > > +               err = ip_frag_reasm(qp, skb, dev);
> > >                 skb->_skb_refdst = orefdst;
> > >                 return err;
> > >         }
> > > @@ -431,15 +442,15 @@ err:
> > >         return err;
> > >  }
> > >
> > > -
> > >  /* Build a new IP datagram from all its fragments. */
> > > -
> > > -static int ip_frag_reasm(struct ipq *qp, struct sk_buff *prev,
> > > +static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
> > >                          struct net_device *dev)
> > >  {
> > >         struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
> > >         struct iphdr *iph;
> > > -       struct sk_buff *fp, *head = qp->q.fragments;
> > > +       struct sk_buff *fp, *head = skb_rb_first(&qp->q.rb_fragments);
> > > +       struct sk_buff **nextp; /* To build frag_list. */
> > > +       struct rb_node *rbn;
> > >         int len;
> > >         int ihlen;
> > >         int err;
> > > @@ -453,25 +464,20 @@ static int ip_frag_reasm(struct ipq *qp,
> > >                 goto out_fail;
> > >         }
> > >         /* Make the one we just received the head. */
> > > -       if (prev) {
> > > -               head = prev->next;
> > > -               fp = skb_clone(head, GFP_ATOMIC);
> > > +       if (head != skb) {
> > > +               fp = skb_clone(skb, GFP_ATOMIC);
> > >                 if (!fp)
> > >                         goto out_nomem;
> > > -
> > > -               fp->next = head->next;
> > > -               if (!fp->next)
> > > +               rb_replace_node(&skb->rbnode, &fp->rbnode, &qp->q.rb_fragments);
> > > +               if (qp->q.fragments_tail == skb)
> > >                         qp->q.fragments_tail = fp;
> > > -               prev->next = fp;
> > > -
> > > -               skb_morph(head, qp->q.fragments);
> > > -               head->next = qp->q.fragments->next;
> > > -
> > > -               consume_skb(qp->q.fragments);
> > > -               qp->q.fragments = head;
> > > +               skb_morph(skb, head);
> > > +               rb_replace_node(&head->rbnode, &skb->rbnode,
> > > +                               &qp->q.rb_fragments);
> > > +               consume_skb(head);
> > > +               head = skb;
> > >         }
> > >
> > > -       WARN_ON(!head);
> > >         WARN_ON(head->ip_defrag_offset != 0);
> > >
> > >         /* Allocate a new buffer for the datagram. */
> > > @@ -496,24 +502,35 @@ static int ip_frag_reasm(struct ipq *qp,
> > >                 clone = alloc_skb(0, GFP_ATOMIC);
> > >                 if (!clone)
> > >                         goto out_nomem;
> > > -               clone->next = head->next;
> > > -               head->next = clone;
> > >                 skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
> > >                 skb_frag_list_init(head);
> > >                 for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
> > >                         plen += skb_frag_size(&skb_shinfo(head)->frags[i]);
> > >                 clone->len = clone->data_len = head->data_len - plen;
> > > -               head->data_len -= clone->len;
> > > -               head->len -= clone->len;
> > > +               skb->truesize += clone->truesize;
> > >                 clone->csum = 0;bffa72cf7f9df
> > >                 clone->ip_summed = head->ip_summed;
> > >                 add_frag_mem_limit(qp->q.net, clone->truesize);
> > > +               skb_shinfo(head)->frag_list = clone;
> > > +               nextp = &clone->next;
> > > +       } else {
> > > +               nextp = &skb_shinfo(head)->frag_list;
> > >         }
> > >
> > > -       skb_shinfo(head)->frag_list = head->next;
> > >         skb_push(head, head->data - skb_network_header(head));
> > >
> > > -       for (fp=head->next; fp; fp = fp->next) {
> > > +       /* Traverse the tree in order, to build frag_list. */
> > > +       rbn = rb_next(&head->rbnode);
> > > +       rb_erase(&head->rbnode, &qp->q.rb_fragments);
> > > +       while (rbn) {
> > > +               struct rb_node *rbnext = rb_next(rbn);
> > > +               fp = rb_to_skb(rbn);
> > > +               rb_erase(rbn, &qp->q.rb_fragments);
> > > +               rbn = rbnext;
> > > +               *nextp = fp;
> > > +               nextp = &fp->next;
> > > +               fp->prev = NULL;
> > > +               memset(&fp->rbnode, 0, sizeof(fp->rbnode));
> > >                 head->data_len += fp->len;
> > >                 head->len += fp->len;
> > >                 if (head->ip_summed != fp->ip_summed)
> > > @@ -524,7 +541,9 @@ static int ip_frag_reasm(struct ipq *qp,
> > >         }
> > >         sub_frag_mem_limit(qp->q.net, head->truesize);
> > >
> > > +       *nextp = NULL;
> > >         head->next = NULL;
> > > +       head->prev = NULL;
> > >         head->dev = dev;
> > >         head->tstamp = qp->q.stamp;
> > >         IPCB(head)->frag_max_size = max(qp->max_df_size, qp->q.max_size);
> > > @@ -552,6 +571,7 @@ static int ip_frag_reasm(struct ipq *qp,
> > >
> > >         __IP_INC_STATS(net, IPSTATS_MIB_REASMOKS);
> > >         qp->q.fragments = NULL;
> > > +       qp->q.rb_fragments = RB_ROOT;
> > >         qp->q.fragments_tail = NULL;
> > >         return 0;
> > >
> > > --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> > > +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> > > @@ -471,6 +471,7 @@ nf_ct_frag6_reasm(struct frag_queue *fq,
> > >                                           head->csum);
> > >
> > >         fq->q.fragments = NULL;
> > > +       fq->q.rb_fragments = RB_ROOT;
> > >         fq->q.fragments_tail = NULL;
> > >
> > >         return true;
> > > --- a/net/ipv6/reassembly.c
> > > +++ b/net/ipv6/reassembly.c
> > > @@ -472,6 +472,7 @@ static int ip6_frag_reasm(struct frag_qu
> > >         __IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
> > >         rcu_read_unlock();
> > >         fq->q.fragments = NULL;
> > > +       fq->q.rb_fragments = RB_ROOT;
> > >         fq->q.fragments_tail = NULL;
> > >         return 1;
> > >
> > >
> > >
> >
> > I'm getting a kernel panic on the >=4.14.71 stable kernels, and I've
> > isolated the problem back to this patch.
> >
> > My 4.18.11 kernel seems to be OK.
> >
> > Whenever I inject a delay into the interface with iproute2 tools, I get a panic.
> >
> > Example command:
> > tc qdisc add dev eth0 root netem delay 35ms
> >
> > The RIP is pointing at netif_skb_features+0x31/0x230
> >
> > My efforts to get a transmittable copy of the panic have been thwarted.
> >
> > There's some confusion between this patch and the upstream patch
> > refered to in the commit message
> >
> > The upstream commit patches net/sched/sch_netem.c which isn't even
> > touched in this commit.
> >
> > Althought the commit messages are the same, the two patches seem to
> > have a different purpose.
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/sched?id=bffa72cf7f9df842f0016ba03586039296b4caaf
> >
> > The commit message seems more relavant to this patch.
> >
> > The upstream commit bffa72cf7f9df842f0016ba03586039296b4caaf has not
> > yet been applied to the stable tree.
> >
> > I decided to roll the dice, and apply the upstream patch
> > bffa72cf7f9df842f0016ba03586039296b4caaf (it's been in the main kernel
> > tree just over a year).
> >
> > When I manually patch my 4.14.74 kernel with
> > bffa72cf7f9df842f0016ba03586039296b4caaf, my panic seems to be solved.
>
> That is odd, as this commit is in the 4.14.71 kernel release, so it
> should not be able to be applied to 4.14.74.
>
> If something still needs to be done here for the 4.14.y kernel tree,
> please let me know.
>
> thanks,
>
> greg k-h

Thanks for the response.

This issue was fixed in the 4.14.79 stable release with this patch:

sch_netem: restore skb->dev after dequeuing from the rbtree
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/net/sched/sch_netem.c?h=linux-4.14.y&id=bd6df7a19559f9b52049f97c3188a7d1544e16df
