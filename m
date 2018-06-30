Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23242C6778D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D6625935
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 10:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzEBfRWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D6625935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936968AbeF3KyV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 06:54:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40943 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934688AbeF3KyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 06:54:17 -0400
Received: by mail-io0-f196.google.com with SMTP id t135-v6so10697450iof.7;
        Sat, 30 Jun 2018 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B11nRb1M9ylxyDLHy7hHr/o2CQ0FpLQ5xZPddyL+xJI=;
        b=PzEBfRWgRvUXpvE702NWEr7P+KLLvxN5lXTZYnq+K4GKy6TvkfemVU8aOHzS3COhB5
         BBSNef59Cp1r31G1MpJP943sAK4dA8ymWfhjdhf/O3lX27aMdv3/cUn6i211wdNn6LC/
         8viaE58eyv22CUIowXwn4XHJnIi9r9+Y3uGA6+AjJkU0YRLjEiPSv2+d8SbsKSMNqn4P
         4F+1ef6S/vEhrGAkC1N6JpBtXVAgXfo+wNly0TXo+sz6w/NQD4j1HmMWDypR3MQtlNR9
         KhT63RbABfJhMYXWCD/tHD7EzdQ2cdi5avl2cFLSqMwlzaPXo8COEyydzWHEPeZ63+VV
         5kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B11nRb1M9ylxyDLHy7hHr/o2CQ0FpLQ5xZPddyL+xJI=;
        b=FCigsaInoydVHYjqtbTT0z1BV6Br9ZpT1FOI5Bv89gm2mJZDbJ2N79K+VjsWdO+Cse
         1BxK1U9x/ywOl65/iK5rTEJwkdvl57m7S7Nq7x7aLANGpxF0skz99AtYP1h9VRzDAzoq
         QarUfHX77IoXyuc6wUrncaLVXzuJanfs+RCehZzeBzFaKgtKFN6KgEHugCRkgJl+cS8W
         DfIAF06RSSjEMeafNA0OzQ57V7FaUsmbv/wszWuOfOO14N16UZPf++n8WF8H9cG2/g+X
         vBxLaSA6H2t2wk9PoemDQujVwItmZ7Me1G2R+wOQvnsz6t31VfncXSAHu5CvcHnNeCpB
         EQ4w==
X-Gm-Message-State: APt69E2nCfscDROwvY8ePlqcBRFYoV5yRpkQqt0bqk+waQMoVAfYy0i2
        6YsxLmFLFcxdzEo7ee25TRStRvNks1/EwBzYD+c=
X-Google-Smtp-Source: AAOMgpcdkFQSqyI5hDt2vU38OlYpFn3RduXUkHKOENjXUxssCQ54bCjwKn7S8TA8tTyawMVbvP7nNe8VAONiBtn4454=
X-Received: by 2002:a6b:b845:: with SMTP id i66-v6mr5527134iof.142.1530356056932;
 Sat, 30 Jun 2018 03:54:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ef03:0:0:0:0:0 with HTTP; Sat, 30 Jun 2018 03:53:36
 -0700 (PDT)
In-Reply-To: <1530353397-12948-1-git-send-email-laoar.shao@gmail.com>
References: <1530353397-12948-1-git-send-email-laoar.shao@gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 30 Jun 2018 18:53:36 +0800
Message-ID: <CALOAHbAXXB=WfG_ibcdbuNPRu8KDUPWurgaEU2yuBBSh386V1w@mail.gmail.com>
Subject: Re: [PATCH net-next] net, mm: avoid unnecessary memcg charge skmem
To:     David Miller <davem@davemloft.net>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2018 at 6:09 PM, Yafang Shao <laoar.shao@gmail.com> wrote:
> In __sk_mem_raise_allocated(), if mem_cgroup_charge_skmem() return
> false, mem_cgroup_uncharge_skmem will be executed.
>
> The logic is as bellow,
> __sk_mem_raise_allocated
>         ret = mem_cgroup_uncharge_skmem
>                 try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
>                 return false
>         if (!ret)
>                 mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
>
> So it is unnecessary to charge if it is not forced.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/memcontrol.h |  3 ++-
>  mm/memcontrol.c            | 12 +++++++++---
>  net/core/sock.c            |  5 +++--
>  net/ipv4/tcp_output.c      |  2 +-
>  4 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb11..56c07c9 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1160,7 +1160,8 @@ static inline void mem_cgroup_wb_stats(struct bdi_writeback *wb,
>  #endif /* CONFIG_CGROUP_WRITEBACK */
>
>  struct sock;
> -bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
> +bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
> +                            bool force);
>  void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages);
>  #ifdef CONFIG_MEMCG
>  extern struct static_key_false memcg_sockets_enabled_key;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e6f0d5e..1122be2 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5929,7 +5929,8 @@ void mem_cgroup_sk_free(struct sock *sk)
>   * Charges @nr_pages to @memcg. Returns %true if the charge fit within
>   * @memcg's configured limit, %false if the charge had to be forced.
>   */
> -bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
> +bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
> +                            bool force)
>  {
>         gfp_t gfp_mask = GFP_KERNEL;
>
> @@ -5940,7 +5941,10 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>                         memcg->tcpmem_pressure = 0;
>                         return true;
>                 }
> -               page_counter_charge(&memcg->tcpmem, nr_pages);
> +
> +               if (force)
> +                       page_counter_charge(&memcg->tcpmem, nr_pages);
> +
>                 memcg->tcpmem_pressure = 1;
>                 return false;
>         }
> @@ -5954,7 +5958,9 @@ bool mem_cgroup_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>         if (try_charge(memcg, gfp_mask, nr_pages) == 0)
>                 return true;
>
> -       try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
> +       if (force)
> +               try_charge(memcg, gfp_mask|__GFP_NOFAIL, nr_pages);
> +
>         return false;
>  }
>
> diff --git a/net/core/sock.c b/net/core/sock.c
> index bcc4182..148a840 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2401,9 +2401,10 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>  {
>         struct proto *prot = sk->sk_prot;
>         long allocated = sk_memory_allocated_add(sk, amt);
> +       bool charged = false;
>
>         if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
> -           !mem_cgroup_charge_skmem(sk->sk_memcg, amt))
> +           !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt, false)))
>                 goto suppress_allocation;
>
>         /* Under limit. */
> @@ -2465,7 +2466,7 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
>
>         sk_memory_allocated_sub(sk, amt);
>
> -       if (mem_cgroup_sockets_enabled && sk->sk_memcg)
> +       if (mem_cgroup_sockets_enabled && sk->sk_memcg && charged)
>                 mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
>
>         return 0;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index f8f6129..9b741d4 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3014,7 +3014,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
>         sk_memory_allocated_add(sk, amt);
>
>         if (mem_cgroup_sockets_enabled && sk->sk_memcg)
> -               mem_cgroup_charge_skmem(sk->sk_memcg, amt);
> +               mem_cgroup_charge_skmem(sk->sk_memcg, amt, true);
>  }
>
>  /* Send a FIN. The caller locks the socket for us.
> --
> 1.8.3.1
>

Pls. ignore this patch.

Sorry about the noise.

Thanks
Yafang
