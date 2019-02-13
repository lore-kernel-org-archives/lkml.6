Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D981EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76F22190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind-com.20150623.gappssmtp.com header.i=@6wind-com.20150623.gappssmtp.com header.b="Q79vyAta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392031AbfBMPb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:31:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51990 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391894AbfBMPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:31:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2961028wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 07:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind-com.20150623.gappssmtp.com; s=20150623;
        h=reply-to:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wP97OyXW11faEfnpZsHOd7gbXL4owSi4tRmm6Ed3q0w=;
        b=Q79vyAta7pCHhZKyTAx57IXwNBMMqQHNDcpJTkHHZjOlDTxY7bIbshvChS2N5igcNf
         kt+25lnvseC7UGaFDIwQCTlinJ88DvJlluFcq8XKGLcQ6yMx5RjpBmoIr7zNhHkhEKXr
         H2RMUZE2wQytfz5N9Jwa6gLg2ShUlj9+/PoiLHMULCi0if7GonPtyRQGNZl6L0u5wfq9
         ZBiW4BdxDM4APXeS5nCoE8HSzN6cgd4Oq1q/Irrncj2uux6sHkkiXzCqMuAr6KQbaAtW
         q8UfN9h19wz9P6/sti0PozlNo7Ce1YkP5UxdId8rlk+m+aoo2Nj+PRNGz4ieAzaTU79k
         rUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wP97OyXW11faEfnpZsHOd7gbXL4owSi4tRmm6Ed3q0w=;
        b=V64SS5AiyrP9kNGxmo3ou1uqOll7TiKOGvdZi2BNVYiKCcgx+qka++8msKNu4jcmd0
         hMPvYJxUeKKwQbRNCOM8Ur2LqcGigVBbbG2TJF0Khqh2YraVNbNEAryOQNFV6TEZk2Ud
         CELrIo3Hz13r5kddonSimw7sS1ViWmkMJjlJ/X+JzCyt5BXf4rKGUixXvoXnDi5EwD8a
         ZUJ/puEA14G9Zu7WqizsJ9roLpmaTg08LZNFYNBiUTcsHXu9VHxY+NBK8XBLXtTy+6D9
         ceM4ZVBBqbgmfnqCqxqE9zMPrGIOhxwD1t2f94CeiVMXzGvPmic4mtzjaQLtqKaV9ZcL
         x3sA==
X-Gm-Message-State: AHQUAuaEoEuuLQn0phVM7w72V5OLVekoTIMjef7SOPfePtA/uUvF9p0A
        KFh3SzaHpJUeEjSIUbm49WUb+16eN/M=
X-Google-Smtp-Source: AHgI3IZzmn1PHl3Hr/z/9plxTXuFUQrURW4doLm/IJa6opfbaJV7VmSijBbhL1/Mh3MsCD4irsgB4g==
X-Received: by 2002:a1c:6442:: with SMTP id y63mr710708wmb.143.1550071911548;
        Wed, 13 Feb 2019 07:31:51 -0800 (PST)
Received: from ?IPv6:2a01:e35:8b63:dc30:ccd8:e662:fb13:d2be? ([2a01:e35:8b63:dc30:ccd8:e662:fb13:d2be])
        by smtp.gmail.com with ESMTPSA id 65sm50139905wrb.62.2019.02.13.07.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 07:31:50 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v4] ipmr: ip6mr: Create new sockopt to clear mfc
 cache or vifs
To:     Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>,
        davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190212031255.16121-1-callum.sinclair@alliedtelesis.co.nz>
 <20190212031255.16121-2-callum.sinclair@alliedtelesis.co.nz>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <79bd14a5-de54-1ae1-80a5-ada98aa9cc42@6wind.com>
Date:   Wed, 13 Feb 2019 16:31:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190212031255.16121-2-callum.sinclair@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/02/2019 à 04:12, Callum Sinclair a écrit :
[snip]
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
> +	if (flags & (MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC)) {
> +		list_for_each_entry_safe(c, tmp, &mrt->mfc_cache_list, list) {
> +			if (((c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC_STATIC)) ||
> +			    (!(c->mfc_flags & MFC_STATIC) && !(flags & MRT_FLUSH_MFC)))
> +				continue;
> +			rhltable_remove(&mrt->mfc_hash, &c->mnode, ipmr_rht_params);
> +			list_del_rcu(&c->list);
>  			cache = (struct mfc_cache *)c;
> +			call_ipmr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL, cache,
> +						      mrt->id);
>  			mroute_netlink_event(mrt, cache, RTM_DELROUTE);
> -			ipmr_destroy_unres(mrt, cache);
> +			mr_cache_put(c);
> +		}
> +
> +		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
I wonder if the mfc_unres_queue must be cleaned up when only
MRT_FLUSH_MFC_STATIC is provided. My first intuition would be to do it only with
MRT_FLUSH_MFC.
Any opinion?


Regards,
Nicolas
