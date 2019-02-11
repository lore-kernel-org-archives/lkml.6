Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B442146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="bzBZ7fPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfBKJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:38:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55922 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:38:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id r17so16210817wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tVLEnCSEIATQ4cZlMijy9DyA8gaMxrFx75qSt3k+aMk=;
        b=bzBZ7fPm0WU01OH0qhMI0MF70UuUUx8xjCxgiKb922837FN2+LhoWepe31hSJcIOJ6
         ++QSA548HJYBWlEaRFHOCJyJkejgNViwTE5JJ1xIOWKFn/1ydx0LGwqsw0vCPHhCSU+k
         K7M8bdLlBcfgBuqh3DEyODSuS/bFOJMjp0PKUW3pqYHu2tMh93jyiV0syBV12gjJQfkF
         JbUCa80qaBagb4hyOnXswfPjFXDF9amuFWZg5RtXqci2nSeNudcrgzMGEeU/0+/CePNb
         v3/l9Y7Ld8VEm0pX2E+dzzGgiYc/WywKCIMlHyJOe41cQJ9pJUnil3V+Vqt49gzQyxWN
         1TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tVLEnCSEIATQ4cZlMijy9DyA8gaMxrFx75qSt3k+aMk=;
        b=akbrWbklHYaoWzp3HmNapgCyAlcpcHFp7smmZNtYteci3shQlKk4g40cN6sbBsQUoD
         R9eRiu43qAz26kqD4I9ktkRqVwPHdvZkHlA1wYP/VdNf2xY7p1Bns3sdns6crNl7I8xY
         mySQbG/L9WykproIxE3wx3lZ4sLw68meZr6ydSZaj5NM99chKwpolZGJMvSw3I3gvIFc
         1HkGye6javjGgbiVkDNhVxb+uzru7AlK5w8Q8qC5yk0xJeUMCXWHZTYe7Y9Yq8gtyrgv
         WJUfQctJCXi7+v+xr+pk0INTK8U+2eRuwyOM3jaxeR7fDSn9a4long3UnZgKOql5pPjh
         t12Q==
X-Gm-Message-State: AHQUAuZwBS/ozDAWt4+twR8TTQ/u5GHj3LMdA0+8NHOU4bMF/3un+vud
        7Rpf3X5lBpoj4+pk613Ha5TpNy/PlQY=
X-Google-Smtp-Source: AHgI3IYeFPUQ1CND+8MJoqmBuECs94GMAAtCBPgAAQ7peDod2SxZ0uvFTGyIrM0XaHN7QUK/vowQxw==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr25377693wrx.315.1549877882390;
        Mon, 11 Feb 2019 01:38:02 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:2c0d:a325:12e7:2f44? ([2a01:e35:8b63:dc30:2c0d:a325:12e7:2f44])
        by smtp.gmail.com with ESMTPSA id a144sm17307910wmd.30.2019.02.11.01.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:38:01 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190211035412.29218-1-callum.sinclair@alliedtelesis.co.nz>
 <20190211035412.29218-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <f13215de-70bf-0e4b-3b3f-0cceb2727f4f@6wind.com>
Date:   Mon, 11 Feb 2019 10:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211035412.29218-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/02/2019 à 04:54, Callum Sinclair a écrit :
> v1 -> v2:
> Implemented additional flags for static entries
> v2 -> v3:
> Cleaned up flag logic so any combination of routes can be cleared.
> Fixed style errors
> Fixed incorrect flag values
nit: those lines are usually put after the '---', thus they don't appear in the
final commit log (they are useful for reviewers only).

> 
> Currently the only way to clear the forwarding cache was to delete the
> entries one by one using the MRT_DEL_MFC socket option or to destroy and
> recreate the socket.
> 
> Create a new socket option which with the use of optional flags can
> clear any combination of multicast entries (static or not static) and
> multicast vifs (static or not static).
> 
> Calling the new socket option MRT_FLUSH with the flags MRT_FLUSH_MFC and
> MRT_FLUSH_VIFS will clear all entries and vifs on the socket except for
> static entries.
> 
> Signed-off-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
> ---
ie, here

>  include/uapi/linux/mroute.h  |  9 ++++-
>  include/uapi/linux/mroute6.h |  9 ++++-
>  net/ipv4/ipmr.c              | 73 ++++++++++++++++++++-------------
>  net/ipv6/ip6mr.c             | 78 +++++++++++++++++++++++-------------
>  4 files changed, 112 insertions(+), 57 deletions(-)
> 
> diff --git a/include/uapi/linux/mroute.h b/include/uapi/linux/mroute.h
> index 5d37a9ccce63..11c8c1fc1124 100644
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
> +#define MRT_FLUSH_VIFS	4	/* Flush multicast vifs */
> +#define MRT_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */
> +
>  #define MAXVIFS		32
>  typedef unsigned long vifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short vifi_t;
> diff --git a/include/uapi/linux/mroute6.h b/include/uapi/linux/mroute6.h
> index 9999cc006390..ac84ef11b29c 100644
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
> +#define MRT6_FLUSH_VIFS	4	/* Flushing multicast vifs */
> +#define MRT6_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */
> +
>  #define MAXMIFS		32
>  typedef unsigned long mifbitmap_t;	/* User mode code depends on this lot */
>  typedef unsigned short mifi_t;
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index e536970557dd..2c95ef8cf224 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -110,7 +110,7 @@ static int ipmr_cache_report(struct mr_table *mrt,
>  static void mroute_netlink_event(struct mr_table *mrt, struct mfc_cache *mfc,
>  				 int cmd);
>  static void igmpmsg_netlink_event(struct mr_table *mrt, struct sk_buff *pkt);
> -static void mroute_clean_tables(struct mr_table *mrt, bool all);
> +static void mroute_clean_tables(struct mr_table *mrt, int flags);
>  static void ipmr_expire_process(struct timer_list *t);
>  
>  #ifdef CONFIG_IP_MROUTE_MULTIPLE_TABLES
> @@ -415,7 +415,8 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
>  static void ipmr_free_table(struct mr_table *mrt)
>  {
>  	del_timer_sync(&mrt->ipmr_expire_timer);
> -	mroute_clean_tables(mrt, true);
> +	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
> +						MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC);
nit: MRT_FLUSH_MFC must be aligned with 'mrt'

>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }
> @@ -1296,7 +1297,7 @@ static int ipmr_mfc_add(struct net *net, struct mr_table *mrt,
>  }
>  
>  /* Close the multicast socket, and clear the vif tables etc */
> -static void mroute_clean_tables(struct mr_table *mrt, bool all)
> +static void mroute_clean_tables(struct mr_table *mrt, int flags)
>  {
>  	struct net *net = read_pnet(&mrt->net);
>  	struct mr_mfc *c, *tmp;
> @@ -1305,35 +1306,42 @@ static void mroute_clean_tables(struct mr_table *mrt, bool all)
>  	int i;
>  
>  	/* Shut down all active vif entries */
> -	for (i = 0; i < mrt->maxvif; i++) {
> -		if (!all && (mrt->vif_table[i].flags & VIFF_STATIC))
> -			continue;
> -		vif_delete(mrt, i, 0, &list);
> +	if (flags & (MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC)) {
> +		for (i = 0; i < mrt->maxvif; i++) {
> +			if (((mrt->vif_table[i].flags & VIFF_STATIC) &&
> +			     !(flags & MRT_FLUSH_VIFS_STATIC)) ||
> +			    (!(mrt->vif_table[i].flags & VIFF_STATIC) && !(flags & MRT_FLUSH)))
s/MRT_FLUSH/MRT_FLUSH_VIFS


Regards,
Nicolas
