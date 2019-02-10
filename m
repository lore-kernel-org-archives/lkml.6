Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36DDC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEC82146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 22:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="K6hBQ6KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBJWzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 17:55:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40079 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfBJWzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 17:55:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so13416847wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 14:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0Mx52VzrBxWZWOoRj+5Y7ar+5+0GKbDJBbHZX3DYozY=;
        b=K6hBQ6KU16lm41Ev8uCu6GI68PCwVpdDg9QHM5VRjQswmEJ6FiSbnX3Jlt75N1hGgK
         aWJWZeVHmgGyDGr347cN5TkwsCIH2cfkQYE8MsmVvyF8XTZ2ImtLsbcMhVn24tBtyNvf
         ciKoIbKC1rn7hwvlXHDgVaHdj438dpZWDNXbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Mx52VzrBxWZWOoRj+5Y7ar+5+0GKbDJBbHZX3DYozY=;
        b=ONMIInfGpTDqTt0dL2wSL2Ga0IdGsDA3amTlrfXz6OmDcTwPaGQRQ3Dkpf+F0iLIpx
         G6j64E/yUgxKtEXFXe8jZKJYviaiyReprPDtpZ4zx9OpK0ZpqG1vlKAHpjH4aP4k5eEg
         q8oKCQIDSecIQAOTJziAnL7rrWVyRVsMcexGreTOpkLCKmimQVi8eW5+041LyM9ULJYN
         sASK9hXSgu9jHYF1dz1dZptv06av35uLtX9QSQTyIW9WPwHQOj1k6WJt3Pg+I9x5vOaf
         hnmuY3Nw8xIO/bSKd2Z/nawz/Amfk8hITsInGRZQRNvxe7P5KEtmNV3iEjxk5no+fOy/
         YuXQ==
X-Gm-Message-State: AHQUAuazh9Aa8ZMviDyPrCII3J4n3J3a533vEfHHbj6s45LR3wpGXUoE
        tWa409cQ7rr9F0YBp7aY6PP3F/UtTXc=
X-Google-Smtp-Source: AHgI3IYB87Y3iwdvgggEFsp/T/rEhkDUjV/kkTG8IsCYtWnnd+cWvuDrVZ0fH2QhEZAhZsRhGolo9Q==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr6466850wmt.99.1549839305154;
        Sun, 10 Feb 2019 14:55:05 -0800 (PST)
Received: from [192.168.0.110] (79-100-158-105.ip.btc-net.bg. [79.100.158.105])
        by smtp.googlemail.com with ESMTPSA id w23sm7709196wmc.38.2019.02.10.14.55.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 14:55:04 -0800 (PST)
Subject: Re: [PATCH net-next] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20190210221222.28215-1-callum.sinclair@alliedtelesis.co.nz>
 <20190210221222.28215-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9f63f414-99d9-a707-8c08-0d94fc3d08ec@cumulusnetworks.com>
Date:   Mon, 11 Feb 2019 00:55:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190210221222.28215-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 12:12 AM, Callum Sinclair wrote:
> Currently the only way to clear the forwarding cache was to delete the
> entries one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which will clear the multicast forwarding
> cache on the socket without destroying the socket. The new socket option
> MRT_FLUSH_ENTRIES will clear all multicast entries on the sockets table
> and the MRT_FLUSH_VIFS will delete all multicast vifs on the socket
> table.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
>  include/uapi/linux/mroute.h  |  9 ++++-
>  include/uapi/linux/mroute6.h |  9 ++++-
>  net/ipv4/ipmr.c              | 71 ++++++++++++++++++++-------------
>  net/ipv6/ip6mr.c             | 76 +++++++++++++++++++++++-------------
>  4 files changed, 108 insertions(+), 57 deletions(-)
> 

Hi,
How could 3 be a flag ? How was this tested exactly ?

I think you can remove the "all" argument altogether and just use the
flags. Also for each iteration of this patch please add a version (as in
v1, v2 etc after net-next in the subject) and in the commit message explain what
has changed between versions like v1 -> v2: fixed blah.
And what happens if we only specify VIFF_STATIC without VIFF or just MFC_STATIC without MFC ?
I see how these work as kind of sub-flags, but there is no explanation of the intended
behaviour nor justification, in fact the commit message is wrong - MRT_FLUSH_ENTRIES
will not clean all and actually there is no MRT_FLUSH_ENTRIES flag or call.

Also please CC all of the people who reviewed previous versions like
Nicolas Dichtel.

A few more comments inline below.

Thanks,
 Nik

> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
> index 5d37a9ccce63..6b556ed7e252 100644
> --- a/include/uapi/linux/mroute.h
> +++ b/include/uapi/linux/mroute.h
> @@ -28,12 +28,19 @@
>  #define MRT_TABLE	(MRT_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT_ADD_MFC_PROXY	(MRT_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT_DEL_MFC_PROXY	(MRT_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT_MAX		(MRT_BASE+11)
> +#define MRT_FLUSH	(MRT_BASE+12)	/* Flush all mfc entries and/or vifs	*/
> +#define MRT_MAX		(MRT_BASE+12)
>  
>  #define SIOCGETVIFCNT	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT	(SIOCPROTOPRIVATE+1)
>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>  
> +/* MRT_FLUSH optional flags */
> +#define MRT_FLUSH_MFC	1	/* Flush multicast entries */
> +#define MRT_FLUSH_MFC_STATIC	2	/* Flush static multicast entries */
> +#define MRT_FLUSH_VIFS	3	/* Flush multicast vifs */
> +#define MRT_FLUSH_VIFS_STATIC	4	/* Flush static multicast vifs */
> +
>  #define MAXVIFS		32
>  typedef unsigned long vifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short vifi_t;
> diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
> index 9999cc006390..47a32c78cbea 100644
> --- a/include/uapi/linux/mroute6.h
> +++ b/include/uapi/linux/mroute6.h
> @@ -31,12 +31,19 @@
>  #define MRT6_TABLE	(MRT6_BASE+9)	/* Specify mroute table ID		*/
>  #define MRT6_ADD_MFC_PROXY	(MRT6_BASE+10)	/* Add a (*,*|G) mfc entry	*/
>  #define MRT6_DEL_MFC_PROXY	(MRT6_BASE+11)	/* Del a (*,*|G) mfc entry	*/
> -#define MRT6_MAX	(MRT6_BASE+11)
> +#define MRT6_FLUSH	(MRT6_BASE+12)	/* Flush all mfc entries and/or vifs	*/
> +#define MRT6_MAX	(MRT6_BASE+12)
>  
>  #define SIOCGETMIFCNT_IN6	SIOCPROTOPRIVATE	/* IP protocol privates */
>  #define SIOCGETSGCNT_IN6	(SIOCPROTOPRIVATE+1)
>  #define SIOCGETRPF	(SIOCPROTOPRIVATE+2)
>  
> +/* MRT6_FLUSH optional flags */
> +#define MRT6_FLUSH_MFC	1	/* Flush multicast entries */
> +#define MRT6_FLUSH_MFC_STATIC	2	/* Flush static multicast entries */
> +#define MRT6_FLUSH_VIFS	3	/* Flushing multicast vifs */
> +#define MRT6_FLUSH_VIFS_STATIC	4	/* Flush static multicast vifs */
> +
>  #define MAXMIFS		32
>  typedef unsigned long mifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short mifi_t;
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index e536970557dd..0cbd0ed4ffff 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -110,7 +110,7 @@ static int ipmr_cache_report(struct mr_table *mrt,
>  static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
>  				 int cmd);
>  static void igmpmsg_netlink_event(struct mr_table *mrt, struct sk_buff *pkt);
> -static void mroute_clean_tables(struct mr_table *mrt, bool all);
> +static void mroute_clean_tables(struct mr_table *mrt, bool all, int flags);
>  static void ipmr_expire_process(struct timer_list *t);
>  
>  #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
> @@ -415,7 +415,7 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
>  static void ipmr_free_table(struct mr_table *mrt)
>  {
>  	del_timer_sync(&mrt->ipmr_expire_timer);
> -	mroute_clean_tables(mrt, true);
> +	mroute_clean_tables(mrt, true, MRT_FLUSH_VIFS | MRT_FLUSH_MFC);
>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }
> @@ -1296,7 +1296,7 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
>  }
>  
>  /* Close the multicast socket, and clear the vif tables etc */
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +static void mroute_clean_tables(struct mr_table *mrt, bool all, int flags)
>  {
>  	struct net *net = read_pnet(&mrt->net);
>  	struct mr_mfc *c, *tmp;
> @@ -1305,35 +1305,41 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  	int i;
>  
>  	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		vif_delete(mrt, i, 0, &list);
> +	if (flags & MRT_FLUSH_VIFS) {
> +		for (i = 0; i < mrt->maxvif; i++) {
> +			if ((mrt->vif_table[i].flags & VIFF_STATIC) &&
> +			   !(all && (flags & MRT_FLUSH_VIFS_STATIC)))

nit: the ! must be 1 more space further (below the second bracket after if).


> +				continue;
> +			vif_delete(mrt, i, 0, &list);
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
> +	if (flags & MRT_FLUSH_MFC) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if ((c->mfc_flags & MFC_STATIC) &&
> +				!(all && (flags & MRT_FLUSH_MFC_STATIC)))

again wrong indentation, the ! must be below the second bracket after the if (the
first character of the condition).

> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
> +			list_del_rcu(&c->list);
>  			cache = (struct mfc_cache *)c;
> +			call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
> +										  mrt->id);

again wrong indentation

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
> @@ -1354,7 +1360,7 @@ static void mrtsock_destruct(struct sock *sk)
>  						    NETCONFA_IFINDEX_ALL,
>  						    net->ipv4.devconf_all);
>  			RCU_INIT_POINTER(mrt->mroute_sk, NULL);
> -			mroute_clean_tables(mrt, false);
> +			mroute_clean_tables(mrt, false, MRT_FLUSH_VIFS | MRT_FLUSH_MFC);
>  		}
>  	}
>  	rtnl_unlock();
> @@ -1479,6 +1485,17 @@ int ip_mroute_setsockopt(struct sock *sk, int optname, char __user *optval,
>  					   sk == rtnl_dereference(mrt->mroute_sk),
>  					   parent);
>  		break;
> +	case MRT_FLUSH:
> +		if (optlen != sizeof(val)) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +		if (get_user(val, (int __user *)optval)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		mroute_clean_tables(mrt, false, val);
> +		break;
>  	/* Control PIM assert. */
>  	case MRT_ASSERT:
>  		if (optlen != sizeof(val)) {
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index cc01aa3f2b5e..31041d4332bc 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -97,7 +97,7 @@ static void mr6_netlink_event(struct mr_table *mrt, struct mfc6_cache *mfc,
>  static void mrt6msg_netlink_event(struct mr_table *mrt, struct sk_buff *pkt);
>  static int ip6mr_rtm_dumproute(struct sk_buff *skb,
>  			       struct netlink_callback *cb);
> -static void mroute_clean_tables(struct mr_table *mrt, bool all);
> +static void mroute_clean_tables(struct mr_table *mrt, bool all, int flags);
>  static void ipmr_expire_process(struct timer_list *t);
>  
>  #ifdef CONFIG_IPV6_MROUTE_MULTIPLE_TABLES
> @@ -393,7 +393,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
>  static void ip6mr_free_table(struct mr_table *mrt)
>  {
>  	del_timer_sync(&mrt->ipmr_expire_timer);
> -	mroute_clean_tables(mrt, true);
> +	mroute_clean_tables(mrt, true, MRT6_FLUSH_VIFS | MRT6_FLUSH_MFC);
>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }
> @@ -1496,42 +1496,48 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
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
> +			if ((mrt->vif_table[i].flags & VIFF_STATIC) &&
> +			    !(all && (flags & MRT6_FLUSH_VIFS_STATIC)))
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
> -		call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
> -					       FIB_EVENT_ENTRY_DEL,
> -					       (struct mfc6_cache *)c, mrt->id);
> -		mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
> -		mr_cache_put(c);
> -	}
> +	if (flags & MRT6_FLUSH_MFC) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if ((c->mfc_flags & MFC_STATIC) &&
> +				!(all && (flags & MRT6_FLUSH_MFC_STATIC)))

wrong indentation

> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
> +			list_del_rcu(&c->list);
> +			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
> +										   FIB_EVENT_ENTRY_DEL,
> +										   (struct mfc6_cache *)c, mrt->id);

wrong indentation

> +			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
> +			mr_cache_put(c);
> +		}
>  
> -	if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> -		spin_lock_bh(&mfc_unres_lock);
> -		list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> -			list_del(&c->list);
> -			mr6_netlink_event(mrt, (struct mfc6_cache *)c,
> -					  RTM_DELROUTE);
> -			ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
> +		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
> +			spin_lock_bh(&mfc_unres_lock);
> +			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
> +				list_del(&c->list);
> +				mr6_netlink_event(mrt, (struct mfc6_cache *)c,
> +								  RTM_DELROUTE);

wrong indentation

> +				ip6mr_destroy_unres(mrt, (struct mfc6_cache *)c);
> +			}
> +			spin_unlock_bh(&mfc_unres_lock);
>  		}
> -		spin_unlock_bh(&mfc_unres_lock);
>  	}
>  }
>  
> @@ -1587,7 +1593,7 @@ int ip6mr_sk_done(struct sock *sk)
>  						     NETCONFA_IFINDEX_ALL,
>  						     net->ipv6.devconf_all);
>  
> -			mroute_clean_tables(mrt, false);
> +			mroute_clean_tables(mrt, false, MRT6_FLUSH_VIFS | MRT6_FLUSH_MFC);
>  			err = 0;
>  			break;
>  		}
> @@ -1703,6 +1709,20 @@ int ip6_mroute_setsockopt(struct sock *sk, int optname, char __user *optval, uns
>  		rtnl_unlock();
>  		return ret;
>  
> +	case MRT6_FLUSH:
> +	{
> +		int flags;
> +
> +		if (optlen != sizeof(flags))
> +			return -EINVAL;
> +		if (get_user(flags, (int __user *)optval))
> +			return -EFAULT;
> +		rtnl_lock();
> +		mroute_clean_tables(mrt, true, flags);
> +		rtnl_unlock();
> +		return 0;
> +	}
> +
>  	/*
>  	 *	Control PIM assert (to activate pim will activate assert)
>  	 */
> 

