Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209F520700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="p7QyebLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfBVTQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:16:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40245 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfBVTQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:16:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id q188so617157ybc.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 11:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ch+IrhOotwsiBbkZp+IeYBbpstxbpSb81CB7W4c9iKw=;
        b=p7QyebLN0ZHPV0mrxHDSsUYEsSDKPDgLdF4AyXo6JBnQAik8BXsgDOy+9d4faBnikI
         cHnJZVGgKBWKMsG17Q+d81RfHqEgsCjE34KxnrOQEK327UAQeIjZ1EvW3xPI3nzcJp/e
         694TAxOO7mMk7bcGrnNDoN05RVUpexxagF1qHhsd0iSxKrHLiAC7CC3KB7Ir1DeM0gi6
         8glHmHZ3url2TFp1UdXof5Q/VgTw88tWa5yhhiXY8BC8zgMvulNZopN+gYQMpuoYYGrc
         gywoZqGNRv8zba6mxApM85gvFzaHaZTMKeNbY6WGtLpP8xy8qIKGK9UD3AlkSr5Pzyc4
         qE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ch+IrhOotwsiBbkZp+IeYBbpstxbpSb81CB7W4c9iKw=;
        b=H8B3FC0SLnpzVC7DbIBeOQsYCw3e7vWiC5SWI0lWNAZKayeXTI+Qsai57sXjRH25hF
         VGtWdRj4lGeta56wUSRTezxuNFDbPiSEgi74Y2m8T4faQPSC8Zpayfywdd3cEnGHGS8e
         eBoK4QR6hGGas4+hZv9uI/oTBsELJE6Ib/YBb4Jq+4tKLr8sv6LsVETUywrUt3E+I12m
         UmDpfXhCTpKtRjhDQnF2OCW5hV4KUUrCmCi1PF9VTwpwXFUP7sN78XkjCyPlq2sph9xy
         QTvExud345IdtDo0qa8RYcjVy90H4zPcgT2O0Qf36cQ11gwLUe1jREJ6gAvwwdqk7bzH
         i/Ug==
X-Gm-Message-State: AHQUAuY6RnUhpAB6T8ifYpaL3+GZnI0Vf+56cpIAlwWz0Q+91Eb/NuzT
        4Em7mNW2AZd/+G8UuMt07ukIug==
X-Google-Smtp-Source: AHgI3IbFsJR9WqArxrjJB/G5LtHREJOHEINy/tUTd8v/9gUMk5Doxdnh2Fz8JfuJOvPZQIUwue7bZw==
X-Received: by 2002:a25:9ac7:: with SMTP id t7mr4715071ybo.469.1550862954392;
        Fri, 22 Feb 2019 11:15:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:cd3d])
        by smtp.gmail.com with ESMTPSA id a190sm730703ywg.76.2019.02.22.11.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:15:53 -0800 (PST)
Date:   Fri, 22 Feb 2019 14:15:52 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
Message-ID: <20190222191552.GA15922@cmpxchg.org>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222175825.18657-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:58:25PM +0300, Andrey Ryabinin wrote:
> In a presence of more than 1 memory cgroup in the system our reclaim
> logic is just suck. When we hit memory limit (global or a limit on
> cgroup with subgroups) we reclaim some memory from all cgroups.
> This is sucks because, the cgroup that allocates more often always wins.
> E.g. job that allocates a lot of clean rarely used page cache will push
> out of memory other jobs with active relatively small all in memory
> working set.
> 
> To prevent such situations we have memcg controls like low/max, etc which
> are supposed to protect jobs or limit them so they to not hurt others.
> But memory cgroups are very hard to configure right because it requires
> precise knowledge of the workload which may vary during the execution.
> E.g. setting memory limit means that job won't be able to use all memory
> in the system for page cache even if the rest the system is idle.
> Basically our current scheme requires to configure every single cgroup
> in the system.
> 
> I think we can do better. The idea proposed by this patch is to reclaim
> only inactive pages and only from cgroups that have big
> (!inactive_is_low()) inactive list. And go back to shrinking active lists
> only if all inactive lists are low.

Yes, you are absolutely right.

We shouldn't go after active pages as long as there are plenty of
inactive pages around. That's the global reclaim policy, and we
currently fail to translate that well to cgrouped systems.

Setting group protections or limits would work around this problem,
but they're kind of a red herring. We shouldn't ever allow use-once
streams to push out hot workingsets, that's a bug.

> @@ -2489,6 +2491,10 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  
>  		scan >>= sc->priority;
>  
> +		if (!sc->may_shrink_active && inactive_list_is_low(lruvec,
> +						file, memcg, sc, false))
> +			scan = 0;
> +
>  		/*
>  		 * If the cgroup's already been deleted, make sure to
>  		 * scrape out the remaining cache.
> @@ -2733,6 +2739,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	struct reclaim_state *reclaim_state = current->reclaim_state;
>  	unsigned long nr_reclaimed, nr_scanned;
>  	bool reclaimable = false;
> +	bool retry;
>  
>  	do {
>  		struct mem_cgroup *root = sc->target_mem_cgroup;
> @@ -2742,6 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		};
>  		struct mem_cgroup *memcg;
>  
> +		retry = false;
> +
>  		memset(&sc->nr, 0, sizeof(sc->nr));
>  
>  		nr_reclaimed = sc->nr_reclaimed;
> @@ -2813,6 +2822,13 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			}
>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>  
> +		if ((sc->nr_scanned - nr_scanned) == 0 &&
> +		     !sc->may_shrink_active) {
> +			sc->may_shrink_active = 1;
> +			retry = true;
> +			continue;
> +		}

Using !scanned as the gate could be a problem. There might be a cgroup
that has inactive pages on the local level, but when viewed from the
system level the total inactive pages in the system might still be low
compared to active ones. In that case we should go after active pages.

Basically, during global reclaim, the answer for whether active pages
should be scanned or not should be the same regardless of whether the
memory is all global or whether it's spread out between cgroups.

The reason this isn't the case is because we're checking the ratio at
the lruvec level - which is the highest level (and identical to the
node counters) when memory is global, but it's at the lowest level
when memory is cgrouped.

So IMO what we should do is:

- At the beginning of global reclaim, use node_page_state() to compare
  the INACTIVE_FILE:ACTIVE_FILE ratio and then decide whether reclaim
  can go after active pages or not. Regardless of what the ratio is in
  individual lruvecs.

- And likewise at the beginning of cgroup limit reclaim, walk the
  subtree starting at sc->target_mem_cgroup, sum up the INACTIVE_FILE
  and ACTIVE_FILE counters, and make inactive_is_low() decision on
  those sums.
