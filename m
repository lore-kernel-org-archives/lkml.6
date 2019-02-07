Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C93C282CC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001692147C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="dVwNdxly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfBGGcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:32:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55232 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfBGGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:32:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so4846856wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 22:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+oceAcyQNIdiRnczM1rx6TmO9WJxqf+YudhS2UVGOPA=;
        b=dVwNdxlynBhC1AaiGoWxnHTnE+LrUlo4ZdVSV0kG9sbySby+IT05sl8tI48bYBqTg9
         nwqjIKPimILdlxL4RY8XNpWj5jLTxEXw30HtXy5O4aE86eZkJnKxprfs2X2BtGES7B6f
         vroJwMBkKE2Zo/mq+AVIawWjAuQCDfm/ex37s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oceAcyQNIdiRnczM1rx6TmO9WJxqf+YudhS2UVGOPA=;
        b=jdWL6wub80zVKLlhYfrUHh/rntag9fI9rJljamDZnh1IpwUiGSOT5NucCAfGGzQWM7
         dvBwYRhDmgf9M1MXG7B1EOfFwUbp/hh9+kVDLgUJ13b9guTTPnd6svCJ5uoSzwBkGXjX
         x92m5Y41Bb/yC2d3nMqhL7J+gy9Ffiti3aNJgGHwSMh+HSp7PLT+tPdgCGaE9xoAdxmt
         cXbpHkC80krIOURzzqzvFc2EaUSFSf2JWHYVNMfEHY5uKBPKIGydh2YZIEEUekqE+gpB
         EjBq8Rq9fovrqFJ8ihwFXG6fQ0ylACcfKBDgbZBaxjlI8LZVOk6SsBs/1gKFVCMPbrjx
         GrnQ==
X-Gm-Message-State: AHQUAub2SgZpANtZdPmCkZ9O1Ic4RZMPQrPhaHy34lQKgG8PyPpbE+H0
        u0zhtkRFc799Nq6SNmR1UL5Biffsb3g=
X-Google-Smtp-Source: AHgI3IZuovFlQA4ncQQplmdtZn8M4o1PIGKiVnc9Xhn+EIGeQkXfMSndrEswzF0Yt1hGGXhKLl6KQQ==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr4994354wmj.120.1549521171189;
        Wed, 06 Feb 2019 22:32:51 -0800 (PST)
Received: from [192.168.0.107] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.gmail.com with ESMTPSA id h17sm4056043wrq.17.2019.02.06.22.32.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 22:32:50 -0800 (PST)
Subject: Re: [PATCH] ipmr: ip6mr: Create new sockopt to clear mfc cache only
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190207020828.21854-1-callum.sinclair@alliedtelesis.co.nz>
 <20190207020828.21854-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <664366b3-6a09-7306-c227-3dd071a726ee@cumulusnetworks.com>
Date:   Thu, 7 Feb 2019 08:32:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207020828.21854-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2019 04:08, Callum Sinclair wrote:
> Currently the only way to clear the mfc cache was to delete the entries
> one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which will clear the multicast forwarding
> cache on the socket without destroying the socket.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/mroute.h  |  7 +++-
>  include/uapi/linux/mroute6.h |  7 +++-
>  net/ipv4/ipmr.c              | 69 +++++++++++++++++++++-------------
>  net/ipv6/ip6mr.c             | 73 ++++++++++++++++++++++--------------
>  4 files changed, 99 insertions(+), 57 deletions(-)
> 

Hi,
Thanks for working on this. I think you missed one comment, this still seems
to clean all tables even though the socket has a table assigned. Could it
act only on that table ? All of the MRT calls besides the init act only on
the initialized table. 
Also you're not checking if optlen is proper size, and I wonder which kernel is this
based on ? Because in net-next ip_mroute_setsockopt() takes rtnl in the beginning
and releases it in the end with the exception of MRT_DONE which needs to release it
earlier, the code below would cause a deadlock trying to get rtnl again in MRT_FLUSH.
This patch should be targeted at net-next, please indicate that also in your subject:
e.g. [PATCH net-next].

Thanks,
 Nik

> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
> index 5d37a9ccce63..2d475edc3ec3 100644
> --- a/include/uapi/linux/mroute.h
> +++ b/include/uapi/linux/mroute.h
> @@ -28,12 +28,17 @@
>  #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT_MAX		(MRT_BASE+11)
> +#define MRT_FLUSH	(MRT_BASE+12)	/* Flush all multicast entries and vifs	*/
> +#define MRT_MAX		(MRT_BASE+12)
>  
>  #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>  
> +/* Flags used for MRT_FLUSH */
> +#define MRT_FLUSH_ENTRIES	1	/* For flushing all multicast entries */
> +#define MRT_FLUSH_VIFS		2	/* For flushing all multicast vifs */
> +
>  #define MAXVIFS		32
>  typedef unsigned long vifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short vifi_t;
> diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
> index 9999cc006390..b04094d997c8 100644
> --- a/include/uapi/linux/mroute6.h
> +++ b/include/uapi/linux/mroute6.h
> @@ -31,12 +31,17 @@
>  #define MRT6_TABLE	(MRT6_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT6_ADD_MFC_PROXY	(MRT6_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT6_DEL_MFC_PROXY	(MRT6_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT6_MAX	(MRT6_BASE+11)
> +#define MRT6_FLUSH	(MRT6_BASE+12)	/* Flush all multicast entries and vifs	*/
> +#define MRT6_MAX	(MRT6_BASE+12)
>  
>  #define SIOCGETMIFCNT_IN6	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT_IN6	(SIOCPROTOPRIVATE+1)
>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>  
> +/* Flags used for MRT6_FLUSH*/
> +#define MRT6_FLUSH_ENTRIES	1	/* For flushing all multicast entries */
> +#define MRT6_FLUSH_VIFS		2	/* For flushing all multicast vifs */
> +
>  #define MAXMIFS		32
>  typedef unsigned long mifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short mifi_t;
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index ddbf8c9a1abb..2eb569138569 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -416,7 +416,7 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
>  static void ipmr_free_table(struct mr_table *mrt)
>  {
>  	del_timer_sync(&mrt->ipmr_expire_timer);
> -	mroute_clean_tables(mrt, true);
> +	mroute_clean_tables(mrt, true, MRT_FLUSH_VIFS | MRT_FLUSH_ENTRIES);
>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }
> @@ -1299,44 +1299,48 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
>  }
>  
>  /* Close the multicast socket, and clear the vif tables etc */
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +static void mroute_clean_tables(struct mr_table *mrt, bool all, int flags)
>  {
>  	struct net *net = read_pnet(&mrt->net);
> -	struct mr_mfc *c, *tmp;
>  	struct mfc_cache *cache;
> +	struct mr_mfc *c, *tmp;
>  	LIST_HEAD(list);
>  	int i;
>  
>  	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		vif_delete(mrt, i, 0, &list);
> +	if (flags & MRT_FLUSH_VIFS) {
> +		for (i = 0; i < mrt->maxvif; i++) {
> +			if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> +				continue;
> +				vif_delete(mrt, i, 0, &list);
> +		}
> +		unregister_netdevice_many(&list);
>  	}
> -	unregister_netdevice_many(&list);
>  
>  	/* Wipe the cache */
> -	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> -		if (!all && (c->mfc_flags & MFC_STATIC))
> -			continue;
> -		rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
> -		list_del_rcu(&c->list);
> -		cache = (struct mfc_cache *)c;
> -		call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
> -					      mrt->id);
> -		mroute_netlink_event(mrt, cache, RTM_DELROUTE);
> -		mr_cache_put(c);
> -	}
> -
> -	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> -		spin_lock_bh(&mfc_unres_lock);
> -		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> -			list_del(&c->list);
> +	if (flags & MRT_FLUSH_ENTRIES) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if (!all && (c->mfc_flags & MFC_STATIC))
> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
> +			list_del_rcu(&c->list);
>  			cache = (struct mfc_cache *)c;
> +			call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
> +										  mrt->id);
>  			mroute_netlink_event(mrt, cache, RTM_DELROUTE);
> -			ipmr_destroy_unres(mrt, cache);
> +			mr_cache_put(c);
> +		}
> +
> +		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +			spin_lock_bh(&mfc_unres_lock);
> +			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> +				list_del(&c->list);
> +				cache = (struct mfc_cache *)c;
> +				mroute_netlink_event(mrt, cache, RTM_DELROUTE);
> +				ipmr_destroy_unres(mrt, cache);
> +			}
> +			spin_unlock_bh(&mfc_unres_lock);
>  		}
> -		spin_unlock_bh(&mfc_unres_lock);
>  	}
>  }
>  
> @@ -1357,7 +1361,7 @@ static void mrtsock_destruct(struct sock *sk)
>  						    NETCONFA_IFINDEX_ALL,
>  						    net->ipv4.devconf_all);
>  			RCU_INIT_POINTER(mrt->mroute_sk, NULL);
> -			mroute_clean_tables(mrt, false);
> +			mroute_clean_tables(mrt, false, MRT_FLUSH_VIFS | MRT_FLUSH_ENTRIES);
>  		}
>  	}
>  	rtnl_unlock();
> @@ -1482,6 +1486,17 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, char __user *optval,
>  					   sk == rtnl_dereference(mrt->mroute_sk),
>  					   parent);
>  		break;
> +	case MRT_FLUSH:
> +		if (get_user(val, (int __user *)optval)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		rtnl_lock();
> +		ipmr_for_each_table(mrt, net) {
> +			mroute_clean_tables(mrt, true, val);
> +		}
> +		rtnl_unlock();
> +		break;
>  	/* Control PIM assert. */
>  	case MRT_ASSERT:
>  		if (optlen != sizeof(val)) {
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index 30337b38274b..473c83d197fe 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -393,7 +393,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
>  static void ip6mr_free_table(struct mr_table *mrt)
>  {
>  	del_timer_sync(&mrt->ipmr_expire_timer);
> -	mroute_clean_tables(mrt, true);
> +	mroute_clean_tables(mrt, true, MRT6_FLUSH_VIFS | MRT6_FLUSH_ENTRIES);
>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }
> @@ -1496,43 +1496,47 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
>   *	Close the multicast socket, and clear the vif tables etc
>   */
>  
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +static void mroute_clean_tables(struct mr_table *mrt, bool all, int flags)
>  {
>  	struct mr_mfc *c, *tmp;
>  	LIST_HEAD(list);
>  	int i;
>  
>  	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		mif6_delete(mrt, i, 0, &list);
> +	if (flags & MRT6_FLUSH_VIFS) {
> +		for (i = 0; i < mrt->maxvif; i++) {
> +			if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> +				continue;
> +			mif6_delete(mrt, i, 0, &list);
> +		}
> +		unregister_netdevice_many(&list);
>  	}
> -	unregister_netdevice_many(&list);
>  
>  	/* Wipe the cache */
> -	list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> -		if (!all && (c->mfc_flags & MFC_STATIC))
> -			continue;
> -		rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
> -		list_del_rcu(&c->list);
> -		mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
> -		mr_cache_put(c);
> -	}
> +	if (flags & MRT6_FLUSH_ENTRIES) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if (!all && (c->mfc_flags & MFC_STATIC))
> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
> +			list_del_rcu(&c->list);
> +			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
> +			mr_cache_put(c);
> +		}
>  
> -	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> -		spin_lock_bh(&mfc_unres_lock);
> -		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> -			list_del(&c->list);
> -			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
> -						       FIB_EVENT_ENTRY_DEL,
> -						       (struct mfc6_cache *)c,
> -						       mrt->id);
> -			mr6_netlink_event(mrt, (struct mfc6_cache *)c,
> -					  RTM_DELROUTE);
> -			ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
> +		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +			spin_lock_bh(&mfc_unres_lock);
> +			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> +				list_del(&c->list);
> +				call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
> +											   FIB_EVENT_ENTRY_DEL,
> +											   (struct mfc6_cache *)c,
> +											   mrt->id);
> +				mr6_netlink_event(mrt, (struct mfc6_cache *)c,
> +						  RTM_DELROUTE);
> +				ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
> +			}
> +			spin_unlock_bh(&mfc_unres_lock);
>  		}
> -		spin_unlock_bh(&mfc_unres_lock);
>  	}
>  }
>  
> @@ -1588,7 +1592,7 @@ int ip6mr_sk_done(struct sock *sk)
>  						     NETCONFA_IFINDEX_ALL,
>  						     net->ipv6.devconf_all);
>  
> -			mroute_clean_tables(mrt, false);
> +			mroute_clean_tables(mrt, false, MRT6_FLUSH_VIFS | MRT6_FLUSH_ENTRIES);
>  			err = 0;
>  			break;
>  		}
> @@ -1703,6 +1707,19 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, char __user *optval, uns
>  					    parent);
>  		rtnl_unlock();
>  		return ret;
> +	case MRT6_DEL_MFC_ALL:
> +	{
> +		int flags;
> +
> +		if (get_user(flags, (int __user *)optval))
> +			return -EFAULT;
> +		rtnl_lock();
> +		ip6mr_for_each_table(mrt, net) {
> +			mroute_clean_tables(mrt, true, flags);
> +		}
> +		rtnl_unlock();
> +		return 0;
> +	}
>  
>  	/*
>  	 *	Control PIM assert (to activate pim will activate assert)
> 

