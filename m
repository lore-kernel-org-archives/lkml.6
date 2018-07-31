Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B82C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93E8208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keqxAfam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D93E8208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbeGaNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:38:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40482 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeGaNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:38:31 -0400
Received: by mail-oi0-f65.google.com with SMTP id w126-v6so27375836oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBmICVvCU1qN27R+73QzpCdboitbfyfLAhWBxyXhWAc=;
        b=keqxAfamYcix3eI+VqsbQMbz7UWC+EOWq3NS6bfnTUB5hHt3Q1caUQ5xFMd+Qom+my
         q1VFjz4z+w1gsikpnYMkT/E1BbJRMWh96i36/pjHvPRr2tWxr70Q8B/IunfPRMqaSKpq
         S/4hpNZIvyXkIVjx/PlyAsm8C26Yu3JUHwB/6iIVVGJXMLjXRJcNsAi9UUH9N42pG7j4
         dzE2zxPrVcI66B3scfttfuAzK7+p77OAjTZlcr7Dht6rDEsYw+WphajoK9EP9gh2CvXX
         zT100bGRTo20WDRwaB8xkWwLe8wFGgMNXgqlbncpiMDunh9vdckyZXPuRxLs30wP6MuS
         XS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBmICVvCU1qN27R+73QzpCdboitbfyfLAhWBxyXhWAc=;
        b=dYFsC3IGO2OUz18r6CZ8RTrrl6s1uN041yyV/JnKkM25xINqSDehcYCxxG8CNjDE77
         MN/x1skv6bncgdTUMpNq5DZebcBSwYhFwGgG2gslXo/sYZPBTd7VMMO4chTLfa6QZKgj
         TzOdy6/bpypFI2jvVW/VdGJLuZ62zMjgONAMipmmNjR2I1lrkeY5rz5aPDTGEuvfAqai
         A78rV+TvZbdi7oEQjixsrhNKwKgZiQZFus4DXgtYD57ivnwmTbyZvIxsccgjSnK4qIBb
         N/wMLsDwCI3BLK1KtIXl6RlHSNszqMRl0wVKqJd+oqa532xLfQfSAocOT9iGwFS/NXfq
         rSMw==
X-Gm-Message-State: AOUpUlFsH5HVEbzqumFSR5qGQsIT+QtQzsttl5m08Lff1ZqHlSrqRzvH
        ow5DzXI8AnGbW5vtQWwYmwevfPtAomNaIO3fifQ=
X-Google-Smtp-Source: AAOMgpfO1BytxkYnxS0tVw3sVTxo1sTdJLGtnN1TtJj8OJrKrwH0bcMKv+PvEQzAEjPPfVIj7IUYR/sluI5xBUMAZpI=
X-Received: by 2002:aca:52d1:: with SMTP id g200-v6mr20801569oib.134.1533038311821;
 Tue, 31 Jul 2018 04:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com> <20180731111924.GI4557@dhcp22.suse.cz>
In-Reply-To: <20180731111924.GI4557@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 31 Jul 2018 19:58:20 +0800
Message-ID: <CAGWkznGrc4cgMN4P5OJKGi_UV6kU_6yjV9XcPHv5MVRn11+pzw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: terminate the reclaim early when direct reclaiming
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 7:19 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 31-07-18 19:09:28, Zhaoyang Huang wrote:
> > This patch try to let the direct reclaim finish earlier than it used
> > to be. The problem comes from We observing that the direct reclaim
> > took a long time to finish when memcg is enabled. By debugging, we
> > find that the reason is the softlimit is too low to meet the loop
> > end criteria. So we add two barriers to judge if it has reclaimed
> > enough memory as same criteria as it is in shrink_lruvec:
> > 1. for each memcg softlimit reclaim.
> > 2. before starting the global reclaim in shrink_zone.
>
> Then I would really recommend to not use soft limit at all. It has
> always been aggressive. I have propose to make it less so in the past we
> have decided to go that way because we simply do not know whether
> somebody depends on that behavior. Your changelog doesn't really tell
> the whole story. Why is this a problem all of the sudden? Nothing has
> really changed recently AFAICT. Cgroup v1 interface is mostly for
> backward compatibility, we have much better ways to accomplish
> workloads isolation in cgroup v2.
>
> So why does it matter all of the sudden?
>
> Besides that EXPORT_SYMBOL for such a low level functionality as the
> memory reclaim is a big no-no.
>
> So without a much better explanation and with a low level symbol
> exported NAK from me.
>
My test workload is from Android system, where the multimedia apps
require much pages. We observed that one thread of the process trapped
into mem_cgroup_soft_limit_reclaim within direct reclaim and also
blocked other thread in mmap or do_page_fault(by semphore?).
Furthermore, we also observed other long time direct reclaim related
with soft limit which are supposed to cause page thrash as the
allocator itself is the most right of the rb_tree . Besides, even
without the soft_limit, shall the 'direct reclaim' check the watermark
firstly before shrink_node, for the concurrent kswapd may have
reclaimed enough pages for allocation.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
> > ---
> >  include/linux/memcontrol.h |  3 ++-
> >  mm/memcontrol.c            |  3 +++
> >  mm/vmscan.c                | 38 +++++++++++++++++++++++++++++++++++++-
> >  3 files changed, 42 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 6c6fb11..a7e82c7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -325,7 +325,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
> >  void mem_cgroup_uncharge_list(struct list_head *page_list);
> >
> >  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
> > -
> > +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> > +                     unsigned long nr_scanned, gfp_t gfp_mask, int order);
> >  static struct mem_cgroup_per_node *
> >  mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >  {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8c0280b..e4efd46 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2577,6 +2577,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> >                       (next_mz == NULL ||
> >                       loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
> >                       break;
> > +             if (direct_reclaim_reach_watermark(pgdat, nr_reclaimed,
> > +                                     *total_scanned, gfp_mask, order))
> > +                     break;
> >       } while (!nr_reclaimed);
> >       if (next_mz)
> >               css_put(&next_mz->memcg->css);
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 03822f8..19503f3 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2518,6 +2518,34 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
> >               (memcg && memcg_congested(pgdat, memcg));
> >  }
> >
> > +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> > +             unsigned long nr_scanned, gfp_t gfp_mask,
> > +             int order)
> > +{
> > +     struct scan_control sc = {
> > +             .gfp_mask = gfp_mask,
> > +             .order = order,
> > +             .priority = DEF_PRIORITY,
> > +             .nr_reclaimed = nr_reclaimed,
> > +             .nr_scanned = nr_scanned,
> > +     };
> > +     if (!current_is_kswapd())
> > +             return false;
> > +     if (!IS_ENABLED(CONFIG_COMPACTION))
> > +             return false;
> > +     /*
> > +      * In fact, we add 1 to nr_reclaimed and nr_scanned to let should_continue_reclaim
> > +      * NOT return by finding they are zero, which means compaction_suitable()
> > +      * takes effect here to judge if we have reclaimed enough pages for passing
> > +      * the watermark and no necessary to check other memcg anymore.
> > +      */
> > +     if (!should_continue_reclaim(pgdat,
> > +                             sc.nr_reclaimed + 1, sc.nr_scanned + 1, &sc))
> > +             return true;
> > +     return false;
> > +}
> > +EXPORT_SYMBOL(direct_reclaim_reach_watermark);
> > +
> >  static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  {
> >       struct reclaim_state *reclaim_state = current->reclaim_state;
> > @@ -2802,7 +2830,15 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
> >                       sc->nr_scanned += nr_soft_scanned;
> >                       /* need some check for avoid more shrink_zone() */
> >               }
> > -
> > +             /*
> > +              * we maybe have stolen enough pages from soft limit reclaim, so we return
> > +              * back if we are direct reclaim
> > +              */
> > +             if (direct_reclaim_reach_watermark(zone->zone_pgdat, sc->nr_reclaimed,
> > +                                             sc->nr_scanned, sc->gfp_mask, sc->order)) {
> > +                     sc->gfp_mask = orig_mask;
> > +                     return;
> > +             }
> >               /* See comment about same check for global reclaim above */
> >               if (zone->zone_pgdat == last_pgdat)
> >                       continue;
> > --
> > 1.9.1
>
> --
> Michal Hocko
> SUSE Labs
