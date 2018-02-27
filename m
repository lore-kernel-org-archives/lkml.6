Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-893183-1519718707-2-2683434563376182871
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519718707; b=lXMpx+5F24qxCyCcKe5O4nAW1JJrAqM+z8D6E5e7YlmyFMH
    Dv9Yza58v9XBfS4vGRKzsB0vUoIg38soy3qYejKFxHnO8aJOYlVops/78lewkdU0
    Tqi+KIA6ZKbzllmjZkaOOLrRINdKudEgm54BJkvac0zeRR0l1xFIPkBDSPnjBYm1
    2zSwvKoYx4jGwng5GpbaB4HKiSWq/clLsF/zliDhskgMSAU92C87lhPbIGrz1NhN
    qnvhvomV0wB/82WfVNOq8Hr2j5tu3ZH0LBNiSuIhrRJtTb6Izi6M7rI10LBVrcD9
    ACIkspALRIyeXi1kHQiZG8HUeK4GP+K8eFA132w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519718707; bh=kIq4ssKZTCb6GqpWa8+2T2Ttq0
    AAICi2PBJVuQc8nCU=; b=Lp5Wzq6JsV4ID+fysi8sZU301eB4KU0kiZvqNA5YqM
    1HATu89oE6ijRT4Ev8of60fBpSF0O6NKCzbzzqbbWM1frPNeWfx3BHZU8hMhlGAv
    zEFzvxq8npxXGZjVZlHaBd3xhc5fgGvRA1feonKZeHAzDbSojJodCO0OlL3Mcs2v
    ayUxpDuIqhuN2v9RzrpXWJ443Pa5bpubtfNfxyIKegkl+vdOlXFksjr01LqOn0iU
    HzQe+LJ0w8ijtu4h4URn6QVOrE384UQXWvezX/PZpdgJOoEOZ+ROPHKTmxc3hAvr
    9T35weC1Y9JS9B8681MeDvsZOSUzMe3b8IEx7F+tn4Sg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeB0IFE (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 03:05:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:56336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbeB0IFD (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 03:05:03 -0500
Date: Tue, 27 Feb 2018 09:05:01 +0100
From: Michal Kubecek <mkubecek@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Manoj Boopathi Raj <manojboopathi@google.com>
Subject: Re: [PATCH 4.4 002/193] net: replace dst_cache ip6_tunnel
 implementation with the generic one
Message-ID: <20180227080500.p6truendtzuis7jb@unicorn.suse.cz>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170326.406395326@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223170326.406395326@linuxfoundation.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:23:55PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Paolo Abeni <pabeni@redhat.com>
> 
> commit 607f725f6f7d5ec3759fbc16224afb60e2152a5b upstream.
> 
> This also fix a potential race into the existing tunnel code, which
> could lead to the wrong dst to be permanenty cached:
> 
> CPU1:					CPU2:
>   <xmit on ip6_tunnel>
>   <cache lookup fails>
>   dst = ip6_route_output(...)
> 					<tunnel params are changed via nl>
> 					dst_cache_reset() // no effect,
> 							// the cache is empty
>   dst_cache_set() // the wrong dst
> 	// is permanenty stored
> 	// into the cache
> 
> With the new dst implementation the above race is not possible
> since the first cache lookup after dst_cache_reset will fail due
> to the timestamp check
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Suggested-and-acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Manoj Boopathi Raj <manojboopathi@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
...
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
...
> @@ -1053,7 +962,6 @@ static int ip6_tnl_xmit2(struct sk_buff
>  	struct ipv6_tel_txoption opt;
>  	struct dst_entry *dst = NULL, *ndst = NULL;
>  	struct net_device *tdev;
> -	bool use_cache = false;
>  	int mtu;
>  	unsigned int max_headroom = sizeof(struct ipv6hdr);
>  	u8 proto;
> @@ -1061,39 +969,28 @@ static int ip6_tnl_xmit2(struct sk_buff
>  
>  	/* NBMA tunnel */
>  	if (ipv6_addr_any(&t->parms.raddr)) {
> -		if (skb->protocol == htons(ETH_P_IPV6)) {
> -			struct in6_addr *addr6;
> -			struct neighbour *neigh;
> -			int addr_type;
> -
> -			if (!skb_dst(skb))
> -				goto tx_err_link_failure;
> -
> -			neigh = dst_neigh_lookup(skb_dst(skb),
> -						 &ipv6_hdr(skb)->daddr);
> -			if (!neigh)
> -				goto tx_err_link_failure;
> +		struct in6_addr *addr6;
> +		struct neighbour *neigh;
> +		int addr_type;
> +
> +		if (!skb_dst(skb))
> +			goto tx_err_link_failure;
>  
> -			addr6 = (struct in6_addr *)&neigh->primary_key;
> -			addr_type = ipv6_addr_type(addr6);
> +		neigh = dst_neigh_lookup(skb_dst(skb),
> +					 &ipv6_hdr(skb)->daddr);
> +		if (!neigh)
> +			goto tx_err_link_failure;
>  
> -			if (addr_type == IPV6_ADDR_ANY)
> -				addr6 = &ipv6_hdr(skb)->daddr;
> +		addr6 = (struct in6_addr *)&neigh->primary_key;
> +		addr_type = ipv6_addr_type(addr6);
>  
> -			memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> -			neigh_release(neigh);
> -		}
> -	} else if (t->parms.proto != 0 && !(t->parms.flags &
> -					    (IP6_TNL_F_USE_ORIG_TCLASS |
> -					     IP6_TNL_F_USE_ORIG_FWMARK))) {
> -		/* enable the cache only if neither the outer protocol nor the
> -		 * routing decision depends on the current inner header value
> -		 */
> -		use_cache = true;
> -	}
> +		if (addr_type == IPV6_ADDR_ANY)
> +			addr6 = &ipv6_hdr(skb)->daddr;
>  
> -	if (use_cache)
> -		dst = ip6_tnl_dst_get(t);
> +		memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> +		neigh_release(neigh);
> +	} else if (!fl6->flowi6_mark)
> +		dst = dst_cache_get(&t->dst_cache);
>  
>  	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
>  		goto tx_err_link_failure;
> @@ -1156,8 +1053,8 @@ static int ip6_tnl_xmit2(struct sk_buff
>  		skb = new_skb;
>  	}
>  
> -	if (use_cache && ndst)
> -		ip6_tnl_dst_set(t, ndst);
> +	if (!fl6->flowi6_mark && ndst)
> +		dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
>  	skb_dst_set(skb, dst);
>  
>  	skb->transport_header = skb->network_header;

This part looks essentially like a revert of earlier commit befb92542439
("ipv6: check skb->protocol before lookup for nexthop", mainline
199ab00f3cdb). Is it possible that it comes from an incorrect resolution
of the conflict caused by these two being backported in opposite order
(befb92542439 < b8c7f80cbdcd) than the original mainline commits
(607f725f6f7d < 199ab00f3cdb)?

Michal Kubecek
