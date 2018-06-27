Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025BC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8AA25C42
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 22:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUu7H0MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8AA25C42
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966246AbeF0WDu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 18:03:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38978 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754983AbeF0WDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 18:03:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id b8-v6so3463284wro.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UNuFbxS1174MQmNhCNiONQ3bEKYR6UrAHbNguBxOtE=;
        b=dUu7H0MGYzK0mOjeDYNCtqY9nTRNP6x+K8HNuCYV9Te7fwYVjIouxlf2Zr13mHR/RI
         sseR7UOXxwzCBYUlh/PYDd9j4ZrWvCag21Xy83uzvbOI5gAdRM3qK9dCZXxUyAOw3/x4
         Xov/sm+N8egGYgAZbujYUB9y1z1Pl+sqa5rPpLxYbBNnDwoKKMQwohAYSftEFbRuYzhJ
         J+wFePm1rCrz1k0ZQH7lytKsEykl7C/4frbPjsGTIVBBpvUT+3hLpfesCr6LmEwPY8GF
         lsHtfln8hmBzZIoyLoAVh3I86vt88BuZ+PE+QO9lboKqAkqXj1jjvO2cDJmlTCkPbfcq
         DYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UNuFbxS1174MQmNhCNiONQ3bEKYR6UrAHbNguBxOtE=;
        b=Kvx5Ilh/zw6r6NfQ3Tb2A97hF9mk7NyHYlHwuL+t+iBs7rVQmCYbN89SdEt4UVeXRR
         VQFHzxlSedpGTf2PDWpt8d+pYqwgbvM+9fLQaIAD3X7crnlSyNxD0bkT/ZHt7+cwGam2
         3eRI9rsUuQhH08iC2jCcDRG2qETpbahKd7krnanha2Z3sFDCZ9Bmy3KwwZgVRU2Z1Jhr
         ry0EBwpDADg207eXSE91b6DdwptUtFUnoYroHfPnjJAGAwdLpUkgXQtsJosRcrH9eQJs
         0Hlc2HOPI0WpxHc/hrJvPlBAyQJ6FEbOPEwwldYI5tFvXPurbetYv4OR6pgJ70Hq3oWR
         AXQg==
X-Gm-Message-State: APt69E1kafbnAAxJXITN/TLscvqLiLvixBBhw7P5lzsKBIZdEUZjJfEh
        G5fi7Zz7PDEAxw4zaMUVLSVxmZgTIPOhBwSWrXQDDg==
X-Google-Smtp-Source: AAOMgpfSgQTOtEU1jpIiYMqvwexPSmsRtkH7CDuEoM1A5HO0BNz6TomC9tFTdWBPaX1eAEmEevFulpZeKRwzh7SusV0=
X-Received: by 2002:adf:9527:: with SMTP id 36-v6mr2106746wrs.99.1530137027557;
 Wed, 27 Jun 2018 15:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180627204139.225988-1-shakeelb@google.com> <f08b2e2c-d4c6-7a80-10d9-104c0aab593b@gmail.com>
In-Reply-To: <f08b2e2c-d4c6-7a80-10d9-104c0aab593b@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 Jun 2018 15:03:35 -0700
Message-ID: <CALvZod4JTY8T19L-q+E1LLFVGFso6ea1MACKdFsed8dM-3AvYQ@mail.gmail.com>
Subject: Re: [RFC PATCH] net, mm: account sock objects to kmemcg
To:     eric.dumazet@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 2:51 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
>
>
> On 06/27/2018 01:41 PM, Shakeel Butt wrote:
> > Currently the kernel accounts the memory for network traffic through
> > mem_cgroup_[un]charge_skmem() interface. However the memory accounted
> > only includes the truesize of sk_buff which does not include the size of
> > sock objects. In our production environment, with opt-out kmem
> > accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
> > among the top most charged kmem caches and consume a significant amount
> > of memory which can not be left as system overhead. So, this patch
> > converts the kmem caches of more important sock objects to SLAB_ACCOUNT.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >  net/ipv4/raw.c      | 1 +
> >  net/ipv4/tcp_ipv4.c | 2 +-
> >  net/ipv4/udp.c      | 1 +
> >  net/ipv6/raw.c      | 1 +
> >  net/ipv6/tcp_ipv6.c | 2 +-
> >  net/ipv6/udp.c      | 1 +
> >  net/unix/af_unix.c  | 1 +
> >  7 files changed, 7 insertions(+), 2 deletions(-)
>
>
> Hey, you just disclosed we do not use DCCP ;)
>

Oops.

>
> Joke aside, what about simply factorizing this stuff ?
>

This will opt-in all the sock kmem_caches which I think is better and
much smaller change. Should I resend this or do you want to send the
patch?

> diff --git a/net/core/sock.c b/net/core/sock.c
> index bcc41829a16d50714bdd3c25c976c0b7296fab84..b6714f8d7e9ba313723a6f619799c56230ff5fd4 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3243,7 +3243,8 @@ static int req_prot_init(const struct proto *prot)
>
>         rsk_prot->slab = kmem_cache_create(rsk_prot->slab_name,
>                                            rsk_prot->obj_size, 0,
> -                                          prot->slab_flags, NULL);
> +                                          SLAB_ACCOUNT | prot->slab_flags,
> +                                          NULL);
>
>         if (!rsk_prot->slab) {
>                 pr_crit("%s: Can't create request sock SLAB cache!\n",
> @@ -3258,7 +3259,8 @@ int proto_register(struct proto *prot, int alloc_slab)
>         if (alloc_slab) {
>                 prot->slab = kmem_cache_create_usercopy(prot->name,
>                                         prot->obj_size, 0,
> -                                       SLAB_HWCACHE_ALIGN | prot->slab_flags,
> +                                       SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
> +                                       prot->slab_flags,
>                                         prot->useroffset, prot->usersize,
>                                         NULL);
>
>

Shakeel
