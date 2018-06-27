Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA8C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E2624912
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH7OtFHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E2624912
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965674AbeF0VvU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:51:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38424 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeF0VvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:51:18 -0400
Received: by mail-pf0-f193.google.com with SMTP id j17-v6so1573291pfn.5;
        Wed, 27 Jun 2018 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5AEZF4lANcLAKHGNlxd9Ewy5EYRIsBNb3ZL1b/n8DSY=;
        b=RH7OtFHhh+qzDMODwq/FxGZ/FQVz+8Fy+85+ps/PzwnIawF4z2DjCV9sfJFN28aBi8
         qSjL6c5W3JxF9c3ektFgKdgguj47zHWsv6PPkxHQIru1xsSGIPv5BPIAqEgE23hHaRkO
         yCmvSNCi3+sA2I5QcP92Vn6FTL4SGYMIY0mDT3itk6cGrjvrFhnUAAhT7SVny3Auhy6Y
         cuOFdXmiPJgi33du2KGNPBXgmzXj235/I1fBgLDt7Jz4xkmaC/d8EcO/+QUm5KN1qvWT
         7ccElnBXUCkA+kf+YzAaYFdgNcKSwrp5rP1A57NNbs0Lw7DrVTZo9GhMOtzey/FFDf2c
         zpkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5AEZF4lANcLAKHGNlxd9Ewy5EYRIsBNb3ZL1b/n8DSY=;
        b=HP/7T6fTs1LfK8Ce3oEfWDS/pJl0ztQDoAhokvGQ1uzQtKT/utWGuk7WpiRJ2OW4jF
         /RjWYjwtT9OV5Ika3TdSHHmOWt7iCB/GCEskP3nOaSGh0UStlnuOuRxBSt/ZR48NF2ZT
         3JDxkGo7CcVr19ZEgYK41bdm30xd0/UnFP/Xu70XL2d3VXQ3+7p7wNEUexaH57RPwo2N
         y5LsU3cwHkHvWftNLHtH6/fhY6AVDWpTmDi+N9OmTP7VEE7ZhbEpE/jsHCbMuwjUgQVs
         qUJRDTH3VFWKWzumM+qQ5EF2to5j3FcIgiW+yI8Lm+GnOIziRwBw91HscddeNwFQv4ZL
         iDSw==
X-Gm-Message-State: APt69E2VtxPf81LgS2bq9q5LEmWWLWVN/AoqR92eV1fIjH7MZhqTh85+
        MdhmIo3Kl3uHvzeONp+UZYaDuWvJ
X-Google-Smtp-Source: ADUXVKKnelQjd9zcRVt7m2zhztLV5Hfin3KF6lBZxyBrdPA/7RnsEfe7iLCNcosd/DKS9aB5cBM/tQ==
X-Received: by 2002:a65:608c:: with SMTP id t12-v6mr6753601pgu.159.1530136277764;
        Wed, 27 Jun 2018 14:51:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id y33-v6sm4834796pga.41.2018.06.27.14.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 14:51:17 -0700 (PDT)
Subject: Re: [RFC PATCH] net, mm: account sock objects to kmemcg
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
References: <20180627204139.225988-1-shakeelb@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <f08b2e2c-d4c6-7a80-10d9-104c0aab593b@gmail.com>
Date:   Wed, 27 Jun 2018 14:51:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180627204139.225988-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 01:41 PM, Shakeel Butt wrote:
> Currently the kernel accounts the memory for network traffic through
> mem_cgroup_[un]charge_skmem() interface. However the memory accounted
> only includes the truesize of sk_buff which does not include the size of
> sock objects. In our production environment, with opt-out kmem
> accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
> among the top most charged kmem caches and consume a significant amount
> of memory which can not be left as system overhead. So, this patch
> converts the kmem caches of more important sock objects to SLAB_ACCOUNT.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  net/ipv4/raw.c      | 1 +
>  net/ipv4/tcp_ipv4.c | 2 +-
>  net/ipv4/udp.c      | 1 +
>  net/ipv6/raw.c      | 1 +
>  net/ipv6/tcp_ipv6.c | 2 +-
>  net/ipv6/udp.c      | 1 +
>  net/unix/af_unix.c  | 1 +
>  7 files changed, 7 insertions(+), 2 deletions(-)


Hey, you just disclosed we do not use DCCP ;)

Joke aside, what about simply factorizing this stuff ?

diff --git a/net/core/sock.c b/net/core/sock.c
index bcc41829a16d50714bdd3c25c976c0b7296fab84..b6714f8d7e9ba313723a6f619799c56230ff5fd4 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3243,7 +3243,8 @@ static int req_prot_init(const struct proto *prot)
 
        rsk_prot->slab = kmem_cache_create(rsk_prot->slab_name,
                                           rsk_prot->obj_size, 0,
-                                          prot->slab_flags, NULL);
+                                          SLAB_ACCOUNT | prot->slab_flags,
+                                          NULL);
 
        if (!rsk_prot->slab) {
                pr_crit("%s: Can't create request sock SLAB cache!\n",
@@ -3258,7 +3259,8 @@ int proto_register(struct proto *prot, int alloc_slab)
        if (alloc_slab) {
                prot->slab = kmem_cache_create_usercopy(prot->name,
                                        prot->obj_size, 0,
-                                       SLAB_HWCACHE_ALIGN | prot->slab_flags,
+                                       SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
+                                       prot->slab_flags,
                                        prot->useroffset, prot->usersize,
                                        NULL);
 

