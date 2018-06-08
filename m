Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3A03MTTXGlvnRgAAmS7hNA
	; Fri, 08 Jun 2018 19:21:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E26D607A4; Fri,  8 Jun 2018 19:21:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jfesLKBL"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D69BA602FC;
	Fri,  8 Jun 2018 19:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D69BA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeFHTVZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:21:25 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37541 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752883AbeFHTVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:21:23 -0400
Received: by mail-wr0-f195.google.com with SMTP id d8-v6so14413770wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q53QBDXnxlR4sc3eEHSrM160BdAoCRY2jD5oHnn6Lss=;
        b=jfesLKBLREVJZzO0Ku7203ztEv3W52BOhq4mqvRGt/Q1o0WRBPu41afYOve99v8QSC
         kGkuZcnqiXWDLMk8lEdzbBXQ2BxdXhJUE6kpC44xejTx/RUuwsxcPjQUYM+lcewLA0mV
         xGRizHSqaw1OjmVPpqGrWqb9GdTt5T4mm/TssPGWUnWUhoX5tDU9VclKnSltFaKIaIbE
         oKb/utlBodRpBmt9cgMmkmnktQmR6aNwb3YeKnGbNKhy+U+XxQCmBOkcHFiBzUjPHYLG
         S5GcS33WGIqsHg8eRLkV9KHaBQcX1S9HuC6/HU1LvicU9bKtIRch/OV+19N6/hZLJQ2X
         HF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q53QBDXnxlR4sc3eEHSrM160BdAoCRY2jD5oHnn6Lss=;
        b=hbEYMvtEtQgTNNmJ7xy9qEKhD6wMfkp16d1cfQ7hAZwHaVl4Lwerq5g398Pgy9GfKH
         meb6+P3+J1Ptb23DPHkvJhA4vHBaJlKQFZjLFGcdyqL24iq2KTwfxicsnsR4HP/CBIqt
         PgaFolwlHhd6Q+/fQ4n/HhTFF/Rz2xscyZ34tM9MF8ptxvFOffw7zAyflUJAICX1Arrd
         vxNM360FOFVTuFy19TEIbcCEevtqDQMDerCA4gC71x3oBFsgGqWv/zU4AVbOWEjnMRCT
         TfKHb1suA7FGJTYUz80MQSDRDsoBE3TbQLXxvPV1y+ph5CeedrTtks5acPavK/YSGFUQ
         zloQ==
X-Gm-Message-State: APt69E0P9zdYImjuWrxqmf+fMa9cifvHlYqFldZ/q6y5zn4N6bHhp2pw
        UC7o5fnnpYW5qQvAJp6OvbyJsp9g8bsf5aDIEHzMUw==
X-Google-Smtp-Source: ADUXVKLATvxFhm2JxshnDam96GJ8HGl4Id94n5CtoD00Fuk9AMqs3cyqFSsGRSjyzhh1onKsXldGRq8uQ0c74wLlmgc=
X-Received: by 2002:adf:e48e:: with SMTP id i14-v6mr6540348wrm.8.1528485682094;
 Fri, 08 Jun 2018 12:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <152698356466.3393.5351712806709424140.stgit@localhost.localdomain>
 <152698379298.3393.3040399931339145602.stgit@localhost.localdomain>
In-Reply-To: <152698379298.3393.3040399931339145602.stgit@localhost.localdomain>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 8 Jun 2018 12:21:10 -0700
Message-ID: <CALvZod4zzw0f_q4a1HpMHWjhjfK9OcegRkAQb5ZSyfjAYpAfJw@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] mm: Generalize shrink_slab() calls in shrink_node()
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        stummala@codeaurora.org, gregkh@linuxfoundation.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>, mka@chromium.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Chris Wilson <chris@chris-wilson.co.uk>, longman@redhat.com,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, jbacik@fb.com,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>, lirongqing@baidu.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 3:09 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> From: Vladimir Davydov <vdavydov.dev@gmail.com>
>
> The patch makes shrink_slab() be called for root_mem_cgroup
> in the same way as it's called for the rest of cgroups.
> This simplifies the logic and improves the readability.
>
> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> ktkhai: Description written.
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |   21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f26ca1e00efb..6dbc659db120 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -628,10 +628,8 @@ static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
>   * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
>   * unaware shrinkers will receive a node id of 0 instead.
>   *
> - * @memcg specifies the memory cgroup to target. If it is not NULL,
> - * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
> - * objects from the memory cgroup specified. Otherwise, only unaware
> - * shrinkers are called.
> + * @memcg specifies the memory cgroup to target. Unaware shrinkers
> + * are called only if it is the root cgroup.
>   *
>   * @priority is sc->priority, we take the number of objects and >> by priority
>   * in order to get the scan target.
> @@ -645,7 +643,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>         struct shrinker *shrinker;
>         unsigned long freed = 0;
>

Shouldn't there be a VM_BUG_ON(!memcg) here?

> -       if (memcg && !mem_cgroup_is_root(memcg))
> +       if (!mem_cgroup_is_root(memcg))
>                 return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>
>         if (!down_read_trylock(&shrinker_rwsem))
> @@ -658,9 +656,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>                         .memcg = memcg,
>                 };
>
> -               if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> -                       continue;
> -
>                 if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>                         sc.nid = 0;
>
> @@ -690,6 +685,7 @@ void drop_slab_node(int nid)
>                 struct mem_cgroup *memcg = NULL;
>
>                 freed = 0;
> +               memcg = mem_cgroup_iter(NULL, NULL, NULL);
>                 do {
>                         freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
>                 } while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> @@ -2709,9 +2705,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                         shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
>                         node_lru_pages += lru_pages;
>
> -                       if (memcg)
> -                               shrink_slab(sc->gfp_mask, pgdat->node_id,
> -                                           memcg, sc->priority);
> +                       shrink_slab(sc->gfp_mask, pgdat->node_id,
> +                                   memcg, sc->priority);
>
>                         /* Record the group's reclaim efficiency */
>                         vmpressure(sc->gfp_mask, memcg, false,
> @@ -2735,10 +2730,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                         }
>                 } while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>
> -               if (global_reclaim(sc))
> -                       shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
> -                                   sc->priority);
> -
>                 if (reclaim_state) {
>                         sc->nr_reclaimed += reclaim_state->reclaimed_slab;
>                         reclaim_state->reclaimed_slab = 0;
>
