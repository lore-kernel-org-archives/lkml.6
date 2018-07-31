Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09462C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB24208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="h78zMBxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB24208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbeGaT3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:29:21 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:43755 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbeGaT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:29:21 -0400
Received: by mail-yb0-f194.google.com with SMTP id y3-v6so735130ybo.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SVe9hcyFwhLf6K6lt9pcEGSB7DPyqiY6bwyA75H/X18=;
        b=h78zMBxQqwJu2tIZYP5CaMj6k0uOK2slaAdcgG4BeWo3qS4FfBj+GYJf+drn44qiK2
         qKwWFkGKzE/Po00hgsVUxxUpQ9lAIPnw7xwLIjddERsfoXz5XUcaRN87hLC1N38npQZp
         RTtsmdUjwLYfCNrPxx2NGezyWcnFpZygCMd7F1rVhvZkQ2/BOavdTnisUis02fXObVPW
         OLwo1hs0U7ojBt00UI/NiwsgSVOqzc+vY//MvUWoo6sTTq1AzPRG1BWkyZAFCbe5bzK3
         Lkf6vmWBmzNYLgOn0zrel+w8yKdhuha/cY5Jkocm01i1jLVg1W78ty2squdHnWpYTfi6
         9UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SVe9hcyFwhLf6K6lt9pcEGSB7DPyqiY6bwyA75H/X18=;
        b=dB4QfLajzz9CuLKlEHr7RDwcuCD/tx/C4dFXdsjWZulO2/0gXfFe4Sk0HCqYjmUIij
         J9jbFXNCiUh8ASw+tzQKxeuHKXH9gDUJGhCf6mM8kD2cRhzR1GBg1dxLyB4X9GHYj1ym
         /B+fdTvWp1C9HDP+MjxbFUem5F7aq5G3pyPY7XEUkO2JSf3L+lsjtUwvJMk6xcxEM/25
         /G7GYUzVFNh5LoANqbz++phjYMX/1ZdHxESHDd/Vh0v2XmGxFWFDSnC7gaPHf3Y74GDk
         4m1grzL3XCMVlzVWF384X06Grj/DHm74TjO2YKFI8JPoUpylWWqYWA0m0yKwLjjfhaol
         xm/w==
X-Gm-Message-State: AOUpUlFzoTo8kIwxV8l2GaGqOq2UhKFh4RsMrHYPIt+5v61cb2FXZCEI
        1UkdvC1G8Bp3tvoSEofqSRXbIA==
X-Google-Smtp-Source: AAOMgpfpJkiful0IHBqzX4K8YjUgMH63KIS1pCYQC2yf1MNvpwqDwSY1jtdUHZMqbz47OCameH1kxg==
X-Received: by 2002:a25:fc01:: with SMTP id v1-v6mr475449ybd.406.1533059276566;
        Tue, 31 Jul 2018 10:47:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:e414])
        by smtp.gmail.com with ESMTPSA id l4-v6sm6269229ywk.47.2018.07.31.10.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 10:47:55 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:50:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-patch-test@lists.linaro.org
Subject: Re: [PATCH v2] mm: terminate the reclaim early when direct reclaiming
Message-ID: <20180731175050.GA31657@cmpxchg.org>
References: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533035368-30911-1-git-send-email-zhaoyang.huang@spreadtrum.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 07:09:28PM +0800, Zhaoyang Huang wrote:
> This patch try to let the direct reclaim finish earlier than it used
> to be. The problem comes from We observing that the direct reclaim
> took a long time to finish when memcg is enabled. By debugging, we
> find that the reason is the softlimit is too low to meet the loop
> end criteria. So we add two barriers to judge if it has reclaimed
> enough memory as same criteria as it is in shrink_lruvec:
> 1. for each memcg softlimit reclaim.
> 2. before starting the global reclaim in shrink_zone.
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@spreadtrum.com>
> ---
>  include/linux/memcontrol.h |  3 ++-
>  mm/memcontrol.c            |  3 +++
>  mm/vmscan.c                | 38 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 6c6fb11..a7e82c7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -325,7 +325,8 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg,
>  void mem_cgroup_uncharge_list(struct list_head *page_list);
>  
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
> -
> +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> +			unsigned long nr_scanned, gfp_t gfp_mask, int order);
>  static struct mem_cgroup_per_node *
>  mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c0280b..e4efd46 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2577,6 +2577,9 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
>  			(next_mz == NULL ||
>  			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
>  			break;
> +		if (direct_reclaim_reach_watermark(pgdat, nr_reclaimed,
> +					*total_scanned, gfp_mask, order))
> +			break;
>  	} while (!nr_reclaimed);
>  	if (next_mz)
>  		css_put(&next_mz->memcg->css);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 03822f8..19503f3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2518,6 +2518,34 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>  		(memcg && memcg_congested(pgdat, memcg));
>  }
>  
> +bool direct_reclaim_reach_watermark(pg_data_t *pgdat, unsigned long nr_reclaimed,
> +		unsigned long nr_scanned, gfp_t gfp_mask,
> +		int order)
> +{
> +	struct scan_control sc = {
> +		.gfp_mask = gfp_mask,
> +		.order = order,
> +		.priority = DEF_PRIORITY,
> +		.nr_reclaimed = nr_reclaimed,
> +		.nr_scanned = nr_scanned,
> +	};
> +	if (!current_is_kswapd())
> +		return false;
> +	if (!IS_ENABLED(CONFIG_COMPACTION))
> +		return false;
> +	/*
> +	 * In fact, we add 1 to nr_reclaimed and nr_scanned to let should_continue_reclaim
> +	 * NOT return by finding they are zero, which means compaction_suitable()
> +	 * takes effect here to judge if we have reclaimed enough pages for passing
> +	 * the watermark and no necessary to check other memcg anymore.
> +	 */
> +	if (!should_continue_reclaim(pgdat,
> +				sc.nr_reclaimed + 1, sc.nr_scanned + 1, &sc))
> +		return true;

As per the previous submission, should_continue_reclaim() is really
not an appropriate function to use. It's for the compaction policy.
You might be able to hack around it with faking the reclaim progress,
but this will fail in subtle ways when people change the compaction
policy in that function in the future.

If you use it only for the watermark check, check it explicitly.

Other than that, I agree with Michal that we need much more data on
this; what the configuration is like, what the memory situation is
like when your problem happens, how long the stalls are, and how your
patch helps with overreclaim etc.
