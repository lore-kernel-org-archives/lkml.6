Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C1BC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE0A2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sabayonlinux-org.20150623.gappssmtp.com header.i=@sabayonlinux-org.20150623.gappssmtp.com header.b="EGGhaQwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE0A2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sabayonlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbeJEDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:08:49 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38017 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:08:48 -0400
Received: by mail-vs1-f68.google.com with SMTP id a202so2986927vsd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sabayonlinux-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vZRB+ECzJBsu8ERpBHLFOvsFQDIl9W9b6QMG4i5dX0s=;
        b=EGGhaQwC++eqT9D5gyXvm3V+/hkrb3lbuj+AXgGP6Te+JGq4j5y2GdEAdfSSwb8N0O
         m6Qp5agkujKJu1Ji0m5wXQf9CWl3wX56h/hyD3jJClN1WRq9gFlLNJQEmXHD3dgal3Sn
         RyY7NjC7sS98R1CTzNEXDq7imMUd+oa91xA+dl1R+DL346lFrNTP1H/Yca+sljxkO59l
         oRecMy7gZIYvZ+6XvivoJKTnu1DyiPRS2v+tKVJY/sNIcNQWXdcF4qNwIpB3tJ7Xv2bC
         Jq1AQnEgD7OCP7ZOc/KzNSkaptn9R5MCnQOOt4NvaKCntOPaaM/J+9sfCvdVg/8qyrVY
         Xpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vZRB+ECzJBsu8ERpBHLFOvsFQDIl9W9b6QMG4i5dX0s=;
        b=aqZIYguqkDCakYfCj7vhud0uwTxhaduvSGsGlbh/g+uNKszL+zZdM7I4/9uXVc5xz1
         U85oThSYRJnuaa98Ak68FfqHYyR5Uq5wWKE+9h1IRvBKtIr0W2YVt0laQs1zrSnPadAN
         bfrBZ4EOJPYz2zeqozYRtKpy/5FCsj1nuOQHzemSMkJ/8Qd33nH05ohj7939fjeoViED
         GUeoiWrZ0qddiYSd+HobouwhcpoCGImwJV15RgFZedJ3ZnWj48whPXsXcHyC77VPjEhK
         2WaGYtUz5xzr2ckSchOpNKXcsOqjiNmAciUIZu/qHjkhPt7EHMsb+RT5YudqRa4IX7HV
         FP8g==
X-Gm-Message-State: ABuFfogh3j/qyVFhEkI3MJHQVjVkZo4r6i+lHCSzIgCcP0+Wuxn4oLkY
        GJxCDA5sE9lT9GBg1dM1S6lj4h9gWkcwMLGBmzM2IA==
X-Google-Smtp-Source: ACcGV62i4ebS2zs91DO74zoiAjUp4euyUeFB0XwEq9+I5pnqZ3JU9TEmDT/BugSD5URf9N/l6sFhhuEU2NUGaM2mcUw=
X-Received: by 2002:a67:843:: with SMTP id 64mr413840vsi.166.1538684036648;
 Thu, 04 Oct 2018 13:13:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:8d9:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 13:13:56 -0700 (PDT)
In-Reply-To: <20180917211711.665799911@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org> <20180917211711.665799911@linuxfoundation.org>
From:   Mitch Harder <mitch.harder@sabayonlinux.org>
Date:   Thu, 4 Oct 2018 15:13:56 -0500
Message-ID: <CAKcLGm9+Juyf894=UcwCoDg+zzJ=zQeoryzhG0s7GdiAbjLaiQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 117/126] net: sk_buff rbnode reorg
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Mon, Sep 17, 2018 at 5:42 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Eric Dumazet <edumazet@google.com>
>
> commit bffa72cf7f9df842f0016ba03586039296b4caaf upstream
>
> skb->rbnode shares space with skb->next, skb->prev and skb->tstamp
>
> Current uses (TCP receive ofo queue and netem) need to save/restore
> tstamp, while skb->dev is either NULL (TCP) or a constant for a given
> queue (netem).
>
> Since we plan using an RB tree for TCP retransmit queue to speedup SACK
> processing with large BDP, this patch exchanges skb->dev and
> skb->tstamp.
>
> This saves some overhead in both TCP and netem.
>
> v2: removes the swtstamp field from struct tcp_skb_cb
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>
> Cc: Wei Wang <weiwan@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/skbuff.h                  |   24 ++--
>  include/net/inet_frag.h                 |    3
>  net/ipv4/inet_fragment.c                |   14 +-
>  net/ipv4/ip_fragment.c                  |  182 +++++++++++++++++---------------
>  net/ipv6/netfilter/nf_conntrack_reasm.c |    1
>  net/ipv6/reassembly.c                   |    1
>  6 files changed, 128 insertions(+), 97 deletions(-)
>
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -663,23 +663,27 @@ struct sk_buff {
>                         struct sk_buff          *prev;
>
>                         union {
> -                               ktime_t         tstamp;
> -                               u64             skb_mstamp;
> +                               struct net_device       *dev;
> +                               /* Some protocols might use this space to store information,
> +                                * while device pointer would be NULL.
> +                                * UDP receive path is one user.
> +                                */
> +                               unsigned long           dev_scratch;
>                         };
>                 };
> -               struct rb_node  rbnode; /* used in netem & tcp stack */
> +               struct rb_node          rbnode; /* used in netem, ip4 defrag, and tcp stack */
> +               struct list_head        list;
>         };
> -       struct sock             *sk;
>
>         union {
> -               struct net_device       *dev;
> -               /* Some protocols might use this space to store information,
> -                * while device pointer would be NULL.
> -                * UDP receive path is one user.
> -                */
> -               unsigned long           dev_scratch;
> +               struct sock             *sk;
>                 int                     ip_defrag_offset;
>         };
> +
> +       union {
> +               ktime_t         tstamp;
> +               u64             skb_mstamp;
> +       };
>         /*
>          * This is the control buffer. It is free to use for every
>          * layer. Please put your private variables there. If you
> --- a/include/net/inet_frag.h
> +++ b/include/net/inet_frag.h
> @@ -75,7 +75,8 @@ struct inet_frag_queue {
>         struct timer_list       timer;
>         spinlock_t              lock;
>         refcount_t              refcnt;
> -       struct sk_buff          *fragments;
> +       struct sk_buff          *fragments;  /* Used in IPv6. */
> +       struct rb_root          rb_fragments; /* Used in IPv4. */
>         struct sk_buff          *fragments_tail;
>         ktime_t                 stamp;
>         int                     len;
> --- a/net/ipv4/inet_fragment.c
> +++ b/net/ipv4/inet_fragment.c
> @@ -136,12 +136,16 @@ void inet_frag_destroy(struct inet_frag_
>         fp = q->fragments;
>         nf = q->net;
>         f = nf->f;
> -       while (fp) {
> -               struct sk_buff *xp = fp->next;
> +       if (fp) {
> +               do {
> +                       struct sk_buff *xp = fp->next;
>
> -               sum_truesize += fp->truesize;
> -               kfree_skb(fp);
> -               fp = xp;
> +                       sum_truesize += fp->truesize;
> +                       kfree_skb(fp);
> +                       fp = xp;
> +               } while (fp);
> +       } else {
> +               sum_truesize = skb_rbtree_purge(&q->rb_fragments);
>         }
>         sum = sum_truesize + f->qsize;
>
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -136,7 +136,7 @@ static void ip_expire(struct timer_list
>  {
>         struct inet_frag_queue *frag = from_timer(frag, t, timer);
>         const struct iphdr *iph;
> -       struct sk_buff *head;
> +       struct sk_buff *head = NULL;
>         struct net *net;
>         struct ipq *qp;
>         int err;
> @@ -152,14 +152,31 @@ static void ip_expire(struct timer_list
>
>         ipq_kill(qp);
>         __IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
> -
> -       head = qp->q.fragments;
> -
>         __IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
>
> -       if (!(qp->q.flags & INET_FRAG_FIRST_IN) || !head)
> +       if (!qp->q.flags & INET_FRAG_FIRST_IN)
>                 goto out;
>
> +       /* sk_buff::dev and sk_buff::rbnode are unionized. So we
> +        * pull the head out of the tree in order to be able to
> +        * deal with head->dev.
> +        */
> +       if (qp->q.fragments) {
> +               head = qp->q.fragments;
> +               qp->q.fragments = head->next;
> +       } else {
> +               head = skb_rb_first(&qp->q.rb_fragments);
> +               if (!head)
> +                       goto out;
> +               rb_erase(&head->rbnode, &qp->q.rb_fragments);
> +               memset(&head->rbnode, 0, sizeof(head->rbnode));
> +               barrier();
> +       }
> +       if (head == qp->q.fragments_tail)
> +               qp->q.fragments_tail = NULL;
> +
> +       sub_frag_mem_limit(qp->q.net, head->truesize);
> +
>         head->dev = dev_get_by_index_rcu(net, qp->iif);
>         if (!head->dev)
>                 goto out;
> @@ -179,16 +196,16 @@ static void ip_expire(struct timer_list
>             (skb_rtable(head)->rt_type != RTN_LOCAL))
>                 goto out;
>
> -       skb_get(head);
>         spin_unlock(&qp->q.lock);
>         icmp_send(head, ICMP_TIME_EXCEEDED, ICMP_EXC_FRAGTIME, 0);
> -       kfree_skb(head);
>         goto out_rcu_unlock;
>
>  out:
>         spin_unlock(&qp->q.lock);
>  out_rcu_unlock:
>         rcu_read_unlock();
> +       if (head)
> +               kfree_skb(head);
>         ipq_put(qp);
>  }
>
> @@ -231,7 +248,7 @@ static int ip_frag_too_far(struct ipq *q
>         end = atomic_inc_return(&peer->rid);
>         qp->rid = end;
>
> -       rc = qp->q.fragments && (end - start) > max;
> +       rc = qp->q.fragments_tail && (end - start) > max;
>
>         if (rc) {
>                 struct net *net;
> @@ -245,7 +262,6 @@ static int ip_frag_too_far(struct ipq *q
>
>  static int ip_frag_reinit(struct ipq *qp)
>  {
> -       struct sk_buff *fp;
>         unsigned int sum_truesize = 0;
>
>         if (!mod_timer(&qp->q.timer, jiffies + qp->q.net->timeout)) {
> @@ -253,20 +269,14 @@ static int ip_frag_reinit(struct ipq *qp
>                 return -ETIMEDOUT;
>         }
>
> -       fp = qp->q.fragments;
> -       do {
> -               struct sk_buff *xp = fp->next;
> -
> -               sum_truesize += fp->truesize;
> -               kfree_skb(fp);
> -               fp = xp;
> -       } while (fp);
> +       sum_truesize = skb_rbtree_purge(&qp->q.rb_fragments);
>         sub_frag_mem_limit(qp->q.net, sum_truesize);
>
>         qp->q.flags = 0;
>         qp->q.len = 0;
>         qp->q.meat = 0;
>         qp->q.fragments = NULL;
> +       qp->q.rb_fragments = RB_ROOT;
>         qp->q.fragments_tail = NULL;
>         qp->iif = 0;
>         qp->ecn = 0;
> @@ -278,7 +288,8 @@ static int ip_frag_reinit(struct ipq *qp
>  static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
>  {
>         struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
> -       struct sk_buff *prev, *next;
> +       struct rb_node **rbn, *parent;
> +       struct sk_buff *skb1;
>         struct net_device *dev;
>         unsigned int fragsize;
>         int flags, offset;
> @@ -341,58 +352,58 @@ static int ip_frag_queue(struct ipq *qp,
>         if (err)
>                 goto err;
>
> -       /* Find out which fragments are in front and at the back of us
> -        * in the chain of fragments so far.  We must know where to put
> -        * this fragment, right?
> -        */
> -       prev = qp->q.fragments_tail;
> -       if (!prev || prev->ip_defrag_offset < offset) {
> -               next = NULL;
> -               goto found;
> -       }
> -       prev = NULL;
> -       for (next = qp->q.fragments; next != NULL; next = next->next) {
> -               if (next->ip_defrag_offset >= offset)
> -                       break;  /* bingo! */
> -               prev = next;
> -       }
> +       /* Note : skb->rbnode and skb->dev share the same location. */
> +       dev = skb->dev;
> +       /* Makes sure compiler wont do silly aliasing games */
> +       barrier();
>
> -found:
>         /* RFC5722, Section 4, amended by Errata ID : 3089
>          *                          When reassembling an IPv6 datagram, if
>          *   one or more its constituent fragments is determined to be an
>          *   overlapping fragment, the entire datagram (and any constituent
>          *   fragments) MUST be silently discarded.
>          *
> -        * We do the same here for IPv4.
> +        * We do the same here for IPv4 (and increment an snmp counter).
>          */
>
> -       /* Is there an overlap with the previous fragment? */
> -       if (prev &&
> -           (prev->ip_defrag_offset + prev->len) > offset)
> -               goto discard_qp;
> -
> -       /* Is there an overlap with the next fragment? */
> -       if (next && next->ip_defrag_offset < end)
> -               goto discard_qp;
> +       /* Find out where to put this fragment.  */
> +       skb1 = qp->q.fragments_tail;
> +       if (!skb1) {
> +               /* This is the first fragment we've received. */
> +               rb_link_node(&skb->rbnode, NULL, &qp->q.rb_fragments.rb_node);
> +               qp->q.fragments_tail = skb;
> +       } else if ((skb1->ip_defrag_offset + skb1->len) < end) {
> +               /* This is the common/special case: skb goes to the end. */
> +               /* Detect and discard overlaps. */
> +               if (offset < (skb1->ip_defrag_offset + skb1->len))
> +                       goto discard_qp;
> +               /* Insert after skb1. */
> +               rb_link_node(&skb->rbnode, &skb1->rbnode, &skb1->rbnode.rb_right);
> +               qp->q.fragments_tail = skb;
> +       } else {
> +               /* Binary search. Note that skb can become the first fragment, but
> +                * not the last (covered above). */
> +               rbn = &qp->q.rb_fragments.rb_node;
> +               do {
> +                       parent = *rbn;
> +                       skb1 = rb_to_skb(parent);
> +                       if (end <= skb1->ip_defrag_offset)
> +                               rbn = &parent->rb_left;
> +                       else if (offset >= skb1->ip_defrag_offset + skb1->len)
> +                               rbn = &parent->rb_right;
> +                       else /* Found an overlap with skb1. */
> +                               goto discard_qp;
> +               } while (*rbn);
> +               /* Here we have parent properly set, and rbn pointing to
> +                * one of its NULL left/right children. Insert skb. */
> +               rb_link_node(&skb->rbnode, parent, rbn);
> +       }
> +       rb_insert_color(&skb->rbnode, &qp->q.rb_fragments);
>
> -       /* Note : skb->ip_defrag_offset and skb->dev share the same location */
> -       dev = skb->dev;
>         if (dev)
>                 qp->iif = dev->ifindex;
> -       /* Makes sure compiler wont do silly aliasing games */
> -       barrier();
>         skb->ip_defrag_offset = offset;
>
> -       /* Insert this fragment in the chain of fragments. */
> -       skb->next = next;
> -       if (!next)
> -               qp->q.fragments_tail = skb;
> -       if (prev)
> -               prev->next = skb;
> -       else
> -               qp->q.fragments = skb;
> -
>         qp->q.stamp = skb->tstamp;
>         qp->q.meat += skb->len;
>         qp->ecn |= ecn;
> @@ -414,7 +425,7 @@ found:
>                 unsigned long orefdst = skb->_skb_refdst;
>
>                 skb->_skb_refdst = 0UL;
> -               err = ip_frag_reasm(qp, prev, dev);
> +               err = ip_frag_reasm(qp, skb, dev);
>                 skb->_skb_refdst = orefdst;
>                 return err;
>         }
> @@ -431,15 +442,15 @@ err:
>         return err;
>  }
>
> -
>  /* Build a new IP datagram from all its fragments. */
> -
> -static int ip_frag_reasm(struct ipq *qp, struct sk_buff *prev,
> +static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
>                          struct net_device *dev)
>  {
>         struct net *net = container_of(qp->q.net, struct net, ipv4.frags);
>         struct iphdr *iph;
> -       struct sk_buff *fp, *head = qp->q.fragments;
> +       struct sk_buff *fp, *head = skb_rb_first(&qp->q.rb_fragments);
> +       struct sk_buff **nextp; /* To build frag_list. */
> +       struct rb_node *rbn;
>         int len;
>         int ihlen;
>         int err;
> @@ -453,25 +464,20 @@ static int ip_frag_reasm(struct ipq *qp,
>                 goto out_fail;
>         }
>         /* Make the one we just received the head. */
> -       if (prev) {
> -               head = prev->next;
> -               fp = skb_clone(head, GFP_ATOMIC);
> +       if (head != skb) {
> +               fp = skb_clone(skb, GFP_ATOMIC);
>                 if (!fp)
>                         goto out_nomem;
> -
> -               fp->next = head->next;
> -               if (!fp->next)
> +               rb_replace_node(&skb->rbnode, &fp->rbnode, &qp->q.rb_fragments);
> +               if (qp->q.fragments_tail == skb)
>                         qp->q.fragments_tail = fp;
> -               prev->next = fp;
> -
> -               skb_morph(head, qp->q.fragments);
> -               head->next = qp->q.fragments->next;
> -
> -               consume_skb(qp->q.fragments);
> -               qp->q.fragments = head;
> +               skb_morph(skb, head);
> +               rb_replace_node(&head->rbnode, &skb->rbnode,
> +                               &qp->q.rb_fragments);
> +               consume_skb(head);
> +               head = skb;
>         }
>
> -       WARN_ON(!head);
>         WARN_ON(head->ip_defrag_offset != 0);
>
>         /* Allocate a new buffer for the datagram. */
> @@ -496,24 +502,35 @@ static int ip_frag_reasm(struct ipq *qp,
>                 clone = alloc_skb(0, GFP_ATOMIC);
>                 if (!clone)
>                         goto out_nomem;
> -               clone->next = head->next;
> -               head->next = clone;
>                 skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
>                 skb_frag_list_init(head);
>                 for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
>                         plen += skb_frag_size(&skb_shinfo(head)->frags[i]);
>                 clone->len = clone->data_len = head->data_len - plen;
> -               head->data_len -= clone->len;
> -               head->len -= clone->len;
> +               skb->truesize += clone->truesize;
>                 clone->csum = 0;bffa72cf7f9df
>                 clone->ip_summed = head->ip_summed;
>                 add_frag_mem_limit(qp->q.net, clone->truesize);
> +               skb_shinfo(head)->frag_list = clone;
> +               nextp = &clone->next;
> +       } else {
> +               nextp = &skb_shinfo(head)->frag_list;
>         }
>
> -       skb_shinfo(head)->frag_list = head->next;
>         skb_push(head, head->data - skb_network_header(head));
>
> -       for (fp=head->next; fp; fp = fp->next) {
> +       /* Traverse the tree in order, to build frag_list. */
> +       rbn = rb_next(&head->rbnode);
> +       rb_erase(&head->rbnode, &qp->q.rb_fragments);
> +       while (rbn) {
> +               struct rb_node *rbnext = rb_next(rbn);
> +               fp = rb_to_skb(rbn);
> +               rb_erase(rbn, &qp->q.rb_fragments);
> +               rbn = rbnext;
> +               *nextp = fp;
> +               nextp = &fp->next;
> +               fp->prev = NULL;
> +               memset(&fp->rbnode, 0, sizeof(fp->rbnode));
>                 head->data_len += fp->len;
>                 head->len += fp->len;
>                 if (head->ip_summed != fp->ip_summed)
> @@ -524,7 +541,9 @@ static int ip_frag_reasm(struct ipq *qp,
>         }
>         sub_frag_mem_limit(qp->q.net, head->truesize);
>
> +       *nextp = NULL;
>         head->next = NULL;
> +       head->prev = NULL;
>         head->dev = dev;
>         head->tstamp = qp->q.stamp;
>         IPCB(head)->frag_max_size = max(qp->max_df_size, qp->q.max_size);
> @@ -552,6 +571,7 @@ static int ip_frag_reasm(struct ipq *qp,
>
>         __IP_INC_STATS(net, IPSTATS_MIB_REASMOKS);
>         qp->q.fragments = NULL;
> +       qp->q.rb_fragments = RB_ROOT;
>         qp->q.fragments_tail = NULL;
>         return 0;
>
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -471,6 +471,7 @@ nf_ct_frag6_reasm(struct frag_queue *fq,
>                                           head->csum);
>
>         fq->q.fragments = NULL;
> +       fq->q.rb_fragments = RB_ROOT;
>         fq->q.fragments_tail = NULL;
>
>         return true;
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -472,6 +472,7 @@ static int ip6_frag_reasm(struct frag_qu
>         __IP6_INC_STATS(net, __in6_dev_get(dev), IPSTATS_MIB_REASMOKS);
>         rcu_read_unlock();
>         fq->q.fragments = NULL;
> +       fq->q.rb_fragments = RB_ROOT;
>         fq->q.fragments_tail = NULL;
>         return 1;
>
>
>

I'm getting a kernel panic on the >=4.14.71 stable kernels, and I've
isolated the problem back to this patch.

My 4.18.11 kernel seems to be OK.

Whenever I inject a delay into the interface with iproute2 tools, I get a panic.

Example command:
tc qdisc add dev eth0 root netem delay 35ms

The RIP is pointing at netif_skb_features+0x31/0x230

My efforts to get a transmittable copy of the panic have been thwarted.

There's some confusion between this patch and the upstream patch
refered to in the commit message

The upstream commit patches net/sched/sch_netem.c which isn't even
touched in this commit.

Althought the commit messages are the same, the two patches seem to
have a different purpose.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/net/sched?id=bffa72cf7f9df842f0016ba03586039296b4caaf

The commit message seems more relavant to this patch.

The upstream commit bffa72cf7f9df842f0016ba03586039296b4caaf has not
yet been applied to the stable tree.

I decided to roll the dice, and apply the upstream patch
bffa72cf7f9df842f0016ba03586039296b4caaf (it's been in the main kernel
tree just over a year).

When I manually patch my 4.14.74 kernel with
bffa72cf7f9df842f0016ba03586039296b4caaf, my panic seems to be solved.

I'm uncertain if this is the proper solution, but I hope this points
in the direction of the issue.
