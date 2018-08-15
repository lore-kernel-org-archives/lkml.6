Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C5AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680FD21568
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 00:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a29LUaus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680FD21568
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeHODoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:44:11 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:46287 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeHODoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:44:10 -0400
Received: by mail-ua1-f68.google.com with SMTP id u11-v6so15274555uan.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 17:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX0CVZZvtGH4f6rcdWiWNjUoyMOI49TL6gi8/xzmnbk=;
        b=a29LUausvSSgLJlVptuV2yuIju5fVJ6ukcKEJGfPF07ydBzNNvc1IXVnVzaZlfkArZ
         bDUY9MXtEr6XdnlIcF3jMr9E42g4QD+rrLLVtPShhHcMrDvCqz2Tp1bBtXvKQK1WgJKx
         RggGusgMBncHp4aGBj+WkfOumgj/D0AIyduHz6njNOagYr11WPYaHzZIQHENd6ELXIdV
         DBEJbzGL0VG/CIqjyVN23SjlEw5yE7YTTPiFLeV0euTIBLTRl9xD7kdwVIwzZHpKA2XW
         kBSi/GI8pBNgXkwzRA/kblM4kkUT3LhHijo1vyH/QdnBO5u2EgIPUVg45n+j6Uwd+Rx5
         N3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX0CVZZvtGH4f6rcdWiWNjUoyMOI49TL6gi8/xzmnbk=;
        b=QUFBxjflMClgqQVvl+qxQY5uiK10pW1/tkNY6AHFlmQ3ceuWZlylgKb5DapQZIkpeT
         E1FIaDegWnz67JKl5zlzLa1zOtAZ4qE743j/3No3LYK7dbPumu27eoi3gJ8xMTSDPOOQ
         QOdMoG5LNwJkd1srRsaJtWdEJO+WV2UlYAYPqeiH8AbO1uVY9WQevvWsgPBUq+WNdr6l
         3g77ocIwjoAywoNKuxNxbLeSBp6Gj2Kci4MxwTQEWC5p3t+9hHFezPGItpN4sTQjX7d/
         1vnD/CWQE3goAZaY2y5qV68AnlukH2SgojJd7Cu7VmPo9F4cZ5HWhzUAmit4CkbG0xrx
         vSSg==
X-Gm-Message-State: AOUpUlG5yVVw0Hg7A1xBUo+uktjyi3LyLv/rHd+iKs+fePKUOoM6JXiY
        SPvx8YEjJ6YLqQBW0uAzKG1OP1Yz8i0vG+WNyhQ3WA==
X-Google-Smtp-Source: AA+uWPwEnGJsnR9wF7ZQ5IlnLMIk41Bp4G9Sr6s1g9ixJ8UTu36BUpaRU5woylU5PLC8Lue9ZqQVJJmu/6jFcNR6YJk=
X-Received: by 2002:a1f:ec02:: with SMTP id k2-v6mr15579549vkh.81.1534294464585;
 Tue, 14 Aug 2018 17:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180815003620.15678-1-guro@fb.com> <20180815003620.15678-2-guro@fb.com>
In-Reply-To: <20180815003620.15678-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 14 Aug 2018 17:54:13 -0700
Message-ID: <CALvZod4qhJA3NHnV_cTO0XEH1d4u62vxwug707sti7cZL6bgPw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] mm: drain memcg stocks on css offlining
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, koct9i@gmail.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 5:36 PM Roman Gushchin <guro@fb.com> wrote:
>
> Memcg charge is batched using per-cpu stocks, so an offline memcg
> can be pinned by a cached charge up to a moment, when a process
> belonging to some other cgroup will charge some memory on the same
> cpu. In other words, cached charges can prevent a memory cgroup
> from being reclaimed for some time, without any clear need.
>
> Let's optimize it by explicit draining of all stocks on css offlining.
> As draining is performed asynchronously, and is skipped if any
> parallel draining is happening, it's cheap.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Seems reasonable.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  mm/memcontrol.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4e3c1315b1de..cfb64b5b9957 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4575,6 +4575,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>         memcg_offline_kmem(memcg);
>         wb_memcg_offline(memcg);
>
> +       drain_all_stock(memcg);
> +
>         mem_cgroup_id_put(memcg);
>  }
>
> --
> 2.14.4
>
