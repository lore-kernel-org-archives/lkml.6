Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1689308-1519486641-2-15796502631610439939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enrosk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519486640; b=gRvxXKfUyAjqCF+aELLb6FRwg1FQH5V/Moxd2BcQh9leooG
    BSei0+qnOBVa4KNg5UNoKkXoIG66GchEygFN2/IOtdOMu05F4T6zovmzQQyfC3CQ
    MSB7ZWoy3lH2EhZNNPvsBwaYnurZ6rVphpYNOwEY+o07f81l3xMufKJuy5ts3B+q
    nR4endCsoCuxOuw239oFdrNjfOqAFpr5meLYhvXzeyXNNUdGpCqd5l40PEHzK+C0
    pZOvxpIHr0LEBsv+LdKfvFquNjp73VF+y7R2ldsFz0nJcpZjBiGN3jW16F4RJ1fL
    fkxNtS/iIOqWqSXZll8s+un/y83i53svm5XQ70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519486640; bh=+7/jNruDfSjWTf78dnFecvF33Y
    rvYUieGTVQxmGEVtA=; b=Z6FAZRw9NlaT1SDDAeFZ+XdR6PWXPmEE26CKyPkleC
    REczw+mtMz/r//XHm7EpETlmyd0ePc4Ere//Dnkbok3Ou8F3xgCzklJ18DH5a0M1
    LUxR8gZo6s57QU1eK/DC52iiiqLkq7oFjFMkGbQHjH3cT95x+YnxzuNh0jTAryJ/
    S+2+zAKhitXg2TGRcmdt54zOsPjWDlCC95VqirIolRGF8O/M5HrFDGWR8ZPTNAaM
    9YE8GHw9YgYltMbRGUe2OMCOCo862uXFh4LqrrEACxWYhcAQ8viyCK6Tb1XQsp/V
    IeN46EuuBJEjD8lkk4HmT0GcBQYuZhr+8TNwrO0OuIqw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tv8FEqjq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iUQgsU88;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Tv8FEqjq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iUQgsU88;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751449AbeBXPhS (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Feb 2018 10:37:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36283 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbeBXPhQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Feb 2018 10:37:16 -0500
X-Google-Smtp-Source: AH8x227d/rZTuhWJWYcSlTN+IjJvZVuzV5oLr3R2fmSL7m3/ZHsnEYVH2ISd8wZKRKKToIqnDIsCGQ==
Date: Sat, 24 Feb 2018 08:37:11 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Boopathi Raj <manojboopathi@google.com>
Subject: Re: [PATCH 4.4 002/193] net: replace dst_cache ip6_tunnel
 implementation with the generic one
Message-ID: <20180224153711.GA4657@flashbox>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170326.406395326@linuxfoundation.org>
 <20180223230008.GA30215@flashbox>
 <20180224083539.GE9681@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224083539.GE9681@kroah.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 09:35:39AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 23, 2018 at 04:00:08PM -0700, Nathan Chancellor wrote:
> > On Fri, Feb 23, 2018 at 07:23:55PM +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Paolo Abeni <pabeni@redhat.com>
> > > 
> > > commit 607f725f6f7d5ec3759fbc16224afb60e2152a5b upstream.
> > > 
> > > This also fix a potential race into the existing tunnel code, which
> > > could lead to the wrong dst to be permanenty cached:
> > > 
> > > CPU1:					CPU2:
> > >   <xmit on ip6_tunnel>
> > >   <cache lookup fails>
> > >   dst = ip6_route_output(...)
> > > 					<tunnel params are changed via nl>
> > > 					dst_cache_reset() // no effect,
> > > 							// the cache is empty
> > >   dst_cache_set() // the wrong dst
> > > 	// is permanenty stored
> > > 	// into the cache
> > > 
> > > With the new dst implementation the above race is not possible
> > > since the first cache lookup after dst_cache_reset will fail due
> > > to the timestamp check
> > > 
> > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > Suggested-and-acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Manoj Boopathi Raj <manojboopathi@google.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > ---
> > >  include/net/ip6_tunnel.h |   15 ----
> > >  net/ipv6/Kconfig         |    1 
> > >  net/ipv6/ip6_gre.c       |   12 +--
> > >  net/ipv6/ip6_tunnel.c    |  151 +++++++----------------------------------------
> > >  net/ipv6/ip6_vti.c       |    2 
> > >  5 files changed, 35 insertions(+), 146 deletions(-)
> > > 
> > > --- a/include/net/ip6_tunnel.h
> > > +++ b/include/net/ip6_tunnel.h
> > > @@ -5,6 +5,8 @@
> > >  #include <linux/netdevice.h>
> > >  #include <linux/if_tunnel.h>
> > >  #include <linux/ip6_tunnel.h>
> > > +#include <net/ip_tunnels.h>
> > > +#include <net/dst_cache.h>
> > >  
> > >  #define IP6TUNNEL_ERR_TIMEO (30*HZ)
> > >  
> > > @@ -32,12 +34,6 @@ struct __ip6_tnl_parm {
> > >  	__be32			o_key;
> > >  };
> > >  
> > > -struct ip6_tnl_dst {
> > > -	seqlock_t lock;
> > > -	struct dst_entry __rcu *dst;
> > > -	u32 cookie;
> > > -};
> > > -
> > >  /* IPv6 tunnel */
> > >  struct ip6_tnl {
> > >  	struct ip6_tnl __rcu *next;	/* next tunnel in list */
> > > @@ -45,7 +41,7 @@ struct ip6_tnl {
> > >  	struct net *net;	/* netns for packet i/o */
> > >  	struct __ip6_tnl_parm parms;	/* tunnel configuration parameters */
> > >  	struct flowi fl;	/* flowi template for xmit */
> > > -	struct ip6_tnl_dst __percpu *dst_cache;	/* cached dst */
> > > +	struct dst_cache dst_cache;	/* cached dst */
> > >  
> > >  	int err_count;
> > >  	unsigned long err_time;
> > > @@ -65,11 +61,6 @@ struct ipv6_tlv_tnl_enc_lim {
> > >  	__u8 encap_limit;	/* tunnel encapsulation limit   */
> > >  } __packed;
> > >  
> > > -struct dst_entry *ip6_tnl_dst_get(struct ip6_tnl *t);
> > > -int ip6_tnl_dst_init(struct ip6_tnl *t);
> > > -void ip6_tnl_dst_destroy(struct ip6_tnl *t);
> > > -void ip6_tnl_dst_reset(struct ip6_tnl *t);
> > > -void ip6_tnl_dst_set(struct ip6_tnl *t, struct dst_entry *dst);
> > >  int ip6_tnl_rcv_ctl(struct ip6_tnl *t, const struct in6_addr *laddr,
> > >  		const struct in6_addr *raddr);
> > >  int ip6_tnl_xmit_ctl(struct ip6_tnl *t, const struct in6_addr *laddr,
> > > --- a/net/ipv6/Kconfig
> > > +++ b/net/ipv6/Kconfig
> > > @@ -205,6 +205,7 @@ config IPV6_NDISC_NODETYPE
> > >  config IPV6_TUNNEL
> > >  	tristate "IPv6: IP-in-IPv6 tunnel (RFC2473)"
> > >  	select INET6_TUNNEL
> > > +	select DST_CACHE
> > >  	---help---
> > >  	  Support for IPv6-in-IPv6 and IPv4-in-IPv6 tunnels described in
> > >  	  RFC 2473.
> > > --- a/net/ipv6/ip6_gre.c
> > > +++ b/net/ipv6/ip6_gre.c
> > > @@ -362,7 +362,7 @@ static void ip6gre_tunnel_uninit(struct
> > >  	struct ip6gre_net *ign = net_generic(t->net, ip6gre_net_id);
> > >  
> > >  	ip6gre_tunnel_unlink(ign, t);
> > > -	ip6_tnl_dst_reset(t);
> > > +	dst_cache_reset(&t->dst_cache);
> > >  	dev_put(dev);
> > >  }
> > >  
> > > @@ -640,7 +640,7 @@ static netdev_tx_t ip6gre_xmit2(struct s
> > >  	}
> > >  
> > >  	if (!fl6->flowi6_mark)
> > > -		dst = ip6_tnl_dst_get(tunnel);
> > > +		dst = dst_cache_get(&tunnel->dst_cache);
> > >  
> > >  	if (!dst) {
> > >  		dst = ip6_route_output(net, NULL, fl6);
> > > @@ -709,7 +709,7 @@ static netdev_tx_t ip6gre_xmit2(struct s
> > >  	}
> > >  
> > >  	if (!fl6->flowi6_mark && ndst)
> > > -		ip6_tnl_dst_set(tunnel, ndst);
> > > +		dst_cache_set_ip6(&tunnel->dst_cache, ndst, &fl6->saddr);
> > >  	skb_dst_set(skb, dst);
> > >  
> > >  	proto = NEXTHDR_GRE;
> > > @@ -1017,7 +1017,7 @@ static int ip6gre_tnl_change(struct ip6_
> > >  	t->parms.o_key = p->o_key;
> > >  	t->parms.i_flags = p->i_flags;
> > >  	t->parms.o_flags = p->o_flags;
> > > -	ip6_tnl_dst_reset(t);
> > > +	dst_cache_reset(&t->dst_cache);
> > >  	ip6gre_tnl_link_config(t, set_mtu);
> > >  	return 0;
> > >  }
> > > @@ -1228,7 +1228,7 @@ static void ip6gre_dev_free(struct net_d
> > >  {
> > >  	struct ip6_tnl *t = netdev_priv(dev);
> > >  
> > > -	ip6_tnl_dst_destroy(t);
> > > +	dst_cache_destroy(&t->dst_cache);
> > >  	free_percpu(dev->tstats);
> > >  	free_netdev(dev);
> > >  }
> > > @@ -1266,7 +1266,7 @@ static int ip6gre_tunnel_init_common(str
> > >  	if (!dev->tstats)
> > >  		return -ENOMEM;
> > >  
> > > -	ret = ip6_tnl_dst_init(tunnel);
> > > +	ret = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
> > >  	if (ret) {
> > >  		free_percpu(dev->tstats);
> > >  		dev->tstats = NULL;
> > > --- a/net/ipv6/ip6_tunnel.c
> > > +++ b/net/ipv6/ip6_tunnel.c
> > > @@ -122,97 +122,6 @@ static struct net_device_stats *ip6_get_
> > >  	return &dev->stats;
> > >  }
> > >  
> > > -/*
> > > - * Locking : hash tables are protected by RCU and RTNL
> > > - */
> > > -
> > > -static void ip6_tnl_per_cpu_dst_set(struct ip6_tnl_dst *idst,
> > > -				    struct dst_entry *dst)
> > > -{
> > > -	write_seqlock_bh(&idst->lock);
> > > -	dst_release(rcu_dereference_protected(
> > > -			    idst->dst,
> > > -			    lockdep_is_held(&idst->lock.lock)));
> > > -	if (dst) {
> > > -		dst_hold(dst);
> > > -		idst->cookie = rt6_get_cookie((struct rt6_info *)dst);
> > > -	} else {
> > > -		idst->cookie = 0;
> > > -	}
> > > -	rcu_assign_pointer(idst->dst, dst);
> > > -	write_sequnlock_bh(&idst->lock);
> > > -}
> > > -
> > > -struct dst_entry *ip6_tnl_dst_get(struct ip6_tnl *t)
> > > -{
> > > -	struct ip6_tnl_dst *idst;
> > > -	struct dst_entry *dst;
> > > -	unsigned int seq;
> > > -	u32 cookie;
> > > -
> > > -	idst = raw_cpu_ptr(t->dst_cache);
> > > -
> > > -	rcu_read_lock();
> > > -	do {
> > > -		seq = read_seqbegin(&idst->lock);
> > > -		dst = rcu_dereference(idst->dst);
> > > -		cookie = idst->cookie;
> > > -	} while (read_seqretry(&idst->lock, seq));
> > > -
> > > -	if (dst && !atomic_inc_not_zero(&dst->__refcnt))
> > > -		dst = NULL;
> > > -	rcu_read_unlock();
> > > -
> > > -	if (dst && dst->obsolete && !dst->ops->check(dst, cookie)) {
> > > -		ip6_tnl_per_cpu_dst_set(idst, NULL);
> > > -		dst_release(dst);
> > > -		dst = NULL;
> > > -	}
> > > -	return dst;
> > > -}
> > > -EXPORT_SYMBOL_GPL(ip6_tnl_dst_get);
> > > -
> > > -void ip6_tnl_dst_reset(struct ip6_tnl *t)
> > > -{
> > > -	int i;
> > > -
> > > -	for_each_possible_cpu(i)
> > > -		ip6_tnl_per_cpu_dst_set(per_cpu_ptr(t->dst_cache, i), NULL);
> > > -}
> > > -EXPORT_SYMBOL_GPL(ip6_tnl_dst_reset);
> > > -
> > > -void ip6_tnl_dst_set(struct ip6_tnl *t, struct dst_entry *dst)
> > > -{
> > > -	ip6_tnl_per_cpu_dst_set(raw_cpu_ptr(t->dst_cache), dst);
> > > -
> > > -}
> > > -EXPORT_SYMBOL_GPL(ip6_tnl_dst_set);
> > > -
> > > -void ip6_tnl_dst_destroy(struct ip6_tnl *t)
> > > -{
> > > -	if (!t->dst_cache)
> > > -		return;
> > > -
> > > -	ip6_tnl_dst_reset(t);
> > > -	free_percpu(t->dst_cache);
> > > -}
> > > -EXPORT_SYMBOL_GPL(ip6_tnl_dst_destroy);
> > > -
> > > -int ip6_tnl_dst_init(struct ip6_tnl *t)
> > > -{
> > > -	int i;
> > > -
> > > -	t->dst_cache = alloc_percpu(struct ip6_tnl_dst);
> > > -	if (!t->dst_cache)
> > > -		return -ENOMEM;
> > > -
> > > -	for_each_possible_cpu(i)
> > > -		seqlock_init(&per_cpu_ptr(t->dst_cache, i)->lock);
> > > -
> > > -	return 0;
> > > -}
> > > -EXPORT_SYMBOL_GPL(ip6_tnl_dst_init);
> > > -
> > >  /**
> > >   * ip6_tnl_lookup - fetch tunnel matching the end-point addresses
> > >   *   @remote: the address of the tunnel exit-point
> > > @@ -331,7 +240,7 @@ static void ip6_dev_free(struct net_devi
> > >  {
> > >  	struct ip6_tnl *t = netdev_priv(dev);
> > >  
> > > -	ip6_tnl_dst_destroy(t);
> > > +	dst_cache_destroy(&t->dst_cache);
> > >  	free_percpu(dev->tstats);
> > >  	free_netdev(dev);
> > >  }
> > > @@ -464,7 +373,7 @@ ip6_tnl_dev_uninit(struct net_device *de
> > >  		RCU_INIT_POINTER(ip6n->tnls_wc[0], NULL);
> > >  	else
> > >  		ip6_tnl_unlink(ip6n, t);
> > > -	ip6_tnl_dst_reset(t);
> > > +	dst_cache_reset(&t->dst_cache);
> > >  	dev_put(dev);
> > >  }
> > >  
> > > @@ -1053,7 +962,6 @@ static int ip6_tnl_xmit2(struct sk_buff
> > >  	struct ipv6_tel_txoption opt;
> > >  	struct dst_entry *dst = NULL, *ndst = NULL;
> > >  	struct net_device *tdev;
> > > -	bool use_cache = false;
> > >  	int mtu;
> > >  	unsigned int max_headroom = sizeof(struct ipv6hdr);
> > >  	u8 proto;
> > > @@ -1061,39 +969,28 @@ static int ip6_tnl_xmit2(struct sk_buff
> > >  
> > >  	/* NBMA tunnel */
> > >  	if (ipv6_addr_any(&t->parms.raddr)) {
> > > -		if (skb->protocol == htons(ETH_P_IPV6)) {
> > > -			struct in6_addr *addr6;
> > > -			struct neighbour *neigh;
> > > -			int addr_type;
> > > -
> > > -			if (!skb_dst(skb))
> > > -				goto tx_err_link_failure;
> > > -
> > > -			neigh = dst_neigh_lookup(skb_dst(skb),
> > > -						 &ipv6_hdr(skb)->daddr);
> > > -			if (!neigh)
> > > -				goto tx_err_link_failure;
> > > +		struct in6_addr *addr6;
> > > +		struct neighbour *neigh;
> > > +		int addr_type;
> > > +
> > > +		if (!skb_dst(skb))
> > > +			goto tx_err_link_failure;
> > >  
> > > -			addr6 = (struct in6_addr *)&neigh->primary_key;
> > > -			addr_type = ipv6_addr_type(addr6);
> > > +		neigh = dst_neigh_lookup(skb_dst(skb),
> > > +					 &ipv6_hdr(skb)->daddr);
> > > +		if (!neigh)
> > > +			goto tx_err_link_failure;
> > >  
> > > -			if (addr_type == IPV6_ADDR_ANY)
> > > -				addr6 = &ipv6_hdr(skb)->daddr;
> > > +		addr6 = (struct in6_addr *)&neigh->primary_key;
> > > +		addr_type = ipv6_addr_type(addr6);
> > >  
> > > -			memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> > > -			neigh_release(neigh);
> > > -		}
> > > -	} else if (t->parms.proto != 0 && !(t->parms.flags &
> > > -					    (IP6_TNL_F_USE_ORIG_TCLASS |
> > > -					     IP6_TNL_F_USE_ORIG_FWMARK))) {
> > > -		/* enable the cache only if neither the outer protocol nor the
> > > -		 * routing decision depends on the current inner header value
> > > -		 */
> > > -		use_cache = true;
> > > -	}
> > > +		if (addr_type == IPV6_ADDR_ANY)
> > > +			addr6 = &ipv6_hdr(skb)->daddr;
> > >  
> > > -	if (use_cache)
> > > -		dst = ip6_tnl_dst_get(t);
> > > +		memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> > > +		neigh_release(neigh);
> > > +	} else if (!fl6->flowi6_mark)
> > > +		dst = dst_cache_get(&t->dst_cache);
> > >  
> > >  	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
> > >  		goto tx_err_link_failure;
> > > @@ -1156,8 +1053,8 @@ static int ip6_tnl_xmit2(struct sk_buff
> > >  		skb = new_skb;
> > >  	}
> > >  
> > > -	if (use_cache && ndst)
> > > -		ip6_tnl_dst_set(t, ndst);
> > > +	if (!fl6->flowi6_mark && ndst)
> > > +		dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
> > >  	skb_dst_set(skb, dst);
> > >  
> > >  	skb->transport_header = skb->network_header;
> > > @@ -1392,7 +1289,7 @@ ip6_tnl_change(struct ip6_tnl *t, const
> > >  	t->parms.flowinfo = p->flowinfo;
> > >  	t->parms.link = p->link;
> > >  	t->parms.proto = p->proto;
> > > -	ip6_tnl_dst_reset(t);
> > > +	dst_cache_reset(&t->dst_cache);
> > >  	ip6_tnl_link_config(t);
> > >  	return 0;
> > >  }
> > > @@ -1663,7 +1560,7 @@ ip6_tnl_dev_init_gen(struct net_device *
> > >  	if (!dev->tstats)
> > >  		return -ENOMEM;
> > >  
> > > -	ret = ip6_tnl_dst_init(t);
> > > +	ret = dst_cache_init(&t->dst_cache, GFP_KERNEL);
> > >  	if (ret) {
> > >  		free_percpu(dev->tstats);
> > >  		dev->tstats = NULL;
> > > --- a/net/ipv6/ip6_vti.c
> > > +++ b/net/ipv6/ip6_vti.c
> > > @@ -645,7 +645,7 @@ vti6_tnl_change(struct ip6_tnl *t, const
> > >  	t->parms.i_key = p->i_key;
> > >  	t->parms.o_key = p->o_key;
> > >  	t->parms.proto = p->proto;
> > > -	ip6_tnl_dst_reset(t);
> > > +	dst_cache_reset(&t->dst_cache);
> > >  	vti6_link_config(t);
> > >  	return 0;
> > >  }
> > > 
> > >
> > 
> > It may also be wise to take these two commits from mainline, as they
> > are along the same lines as this one:
> > 
> > 09acddf873b ("ip_tunnel: replace dst_cache with generic implementation")
> > 27337e16f2d ("ip_tunnel: fix preempt warning in ip tunnel creation/updating")
> 
> Ah, good idea.
> 
> > There is a minor conflict with the first one due to stable commit
> > 6f99825e7632 ("sit: fix a double free on error path").
> > 
> > I'll most likely carry them anyways, it fixes a build error with some
> > out of tree code but less out of tree code I have, the better!
> 
> I'll do that for the next release.  What "out of tree" code relies on
> this?  Something from the CAF tree that is not merged upstream?
> 
> thanks,
> 
> greg k-h

WireGuard. For any tree that didn't have dst_cache, it was backported
and used automatically but if dst_cache is present, it was implicitly
relying on DST_CACHE being selected through NET_UDP_TUNNEL (which is
how I found those commits). Jason has since fixed it:

https://git.zx2c4.com/WireGuard/commit/?id=b3722a8b0578630794776ece5710e6a47155aa92

I'd still say those commits are worth adding since they are part of that
series.

Thanks!
Nathan
