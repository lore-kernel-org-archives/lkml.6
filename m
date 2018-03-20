Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646100-1521558023-2-3188057879533126522
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521558021; b=YJdS8yIR0pNgdtJo4ixPwjIfQPGrbW2whSE6voHS2Q9McBq
    j+oiWxDyjh1MnHpfBpkbjQp3S9Fid6LrMuf8nnJig/8V7jUzL/EeCp0uW0qT+7Wa
    YNkqyZcL6GdzEsFmg3q+yC7BJwB2Y9wNKVoqc8XxRd+k7GxedYhyo9oEWxGeKOUC
    NUqysk7/QwGsurIXHG2P8aXCiT65meWHm9nq1KY/jMqAruLhMoOYYEQcnsJHDlLR
    nz3LM56rnpm6kKlq8R27ByuZ5uptPf775aWLZTYFx8xuS2Zz3z/WdElONaDfPNo0
    ABiY3WsZBsij47XWa9NicSKDyBUfCdQBy5UGlew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521558021; bh=dsWuFUwe7/43sFJdPk7AxV/h6G
    rGwqgzNt46eEwLgx8=; b=eR7dxGPWYX2YxoLpIXRZd2ulHW+lr1/Pu7CyldL7fb
    T4eeGf4B+SD8VCayNcKB1gQWeouUvuXwwTNerGo7bp/7SuFMXDesx6VnUd9a7Y9h
    U0qVviubpEpeQu3qMamL1G/0i5l4+ZQjAY+7r172Zwx/Hcgf1Y16MKPxAXFPdnkD
    9myP8rJZb5oMWEDAemly/f6K+9tGNyRNJPICpUiufIoZD/87mLuFEiV1caWijdu1
    fsLNw8Dofd/0aVMEcVALbXU+FXdMm7AXb0YEhkbcq+qNZ/UkgoRr5Wx8Ra0vP+sE
    6OG1Tyv+55aGl5p2k8YYyGnFtQfghuftpe+KrV1Pvhqw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751633AbeCTPAT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:00:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:38910 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751458AbeCTPAS (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 20 Mar 2018 11:00:18 -0400
Date: Tue, 20 Mar 2018 16:00:16 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/vmscan: Wake up flushers for legacy cgroups too
Message-ID: <20180320150016.GW23100@dhcp22.suse.cz>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 15-03-18 19:45:48, Andrey Ryabinin wrote:
> Commit 726d061fbd36 ("mm: vmscan: kick flushers when we encounter
> dirty pages on the LRU") added flusher invocation to
> shrink_inactive_list() when many dirty pages on the LRU are encountered.
> 
> However, shrink_inactive_list() doesn't wake up flushers for legacy
> cgroup reclaim, so the next commit bbef938429f5 ("mm: vmscan: remove
> old flusher wakeup from direct reclaim path") removed the only source
> of flusher's wake up in legacy mem cgroup reclaim path.
> 
> This leads to premature OOM if there is too many dirty pages in cgroup:
>     # mkdir /sys/fs/cgroup/memory/test
>     # echo $$ > /sys/fs/cgroup/memory/test/tasks
>     # echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
>     # dd if=/dev/zero of=tmp_file bs=1M count=100
>     Killed
> 
>     dd invoked oom-killer: gfp_mask=0x14000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=0
> 
>     Call Trace:
>      dump_stack+0x46/0x65
>      dump_header+0x6b/0x2ac
>      oom_kill_process+0x21c/0x4a0
>      out_of_memory+0x2a5/0x4b0
>      mem_cgroup_out_of_memory+0x3b/0x60
>      mem_cgroup_oom_synchronize+0x2ed/0x330
>      pagefault_out_of_memory+0x24/0x54
>      __do_page_fault+0x521/0x540
>      page_fault+0x45/0x50
> 
>     Task in /test killed as a result of limit of /test
>     memory: usage 51200kB, limit 51200kB, failcnt 73
>     memory+swap: usage 51200kB, limit 9007199254740988kB, failcnt 0
>     kmem: usage 296kB, limit 9007199254740988kB, failcnt 0
>     Memory cgroup stats for /test: cache:49632KB rss:1056KB rss_huge:0KB shmem:0KB
>             mapped_file:0KB dirty:49500KB writeback:0KB swap:0KB inactive_anon:0KB
> 	    active_anon:1168KB inactive_file:24760KB active_file:24960KB unevictable:0KB
>     Memory cgroup out of memory: Kill process 3861 (bash) score 88 or sacrifice child
>     Killed process 3876 (dd) total-vm:8484kB, anon-rss:1052kB, file-rss:1720kB, shmem-rss:0kB
>     oom_reaper: reaped process 3876 (dd), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> Wake up flushers in legacy cgroup reclaim too.
> 
> Fixes: bbef938429f5 ("mm: vmscan: remove old flusher wakeup from direct reclaim path")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: <stable@vger.kernel.org>

Yes, this makes sense. We are stalling on writeback pages for the legacy
memcg but we do not have any way to throttle dirty pages before the
writeback kicks in

Acked-by: Michal Hocko <mhocko@suse.cz>

> ---
>  mm/vmscan.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8fcd9f8d7390..4390a8d5be41 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1771,6 +1771,20 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	if (stat.nr_writeback && stat.nr_writeback == nr_taken)
>  		set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  
> +	/*
> +	 * If dirty pages are scanned that are not queued for IO, it
> +	 * implies that flushers are not doing their job. This can
> +	 * happen when memory pressure pushes dirty pages to the end of
> +	 * the LRU before the dirty limits are breached and the dirty
> +	 * data has expired. It can also happen when the proportion of
> +	 * dirty pages grows not through writes but through memory
> +	 * pressure reclaiming all the clean cache. And in some cases,
> +	 * the flushers simply cannot keep up with the allocation
> +	 * rate. Nudge the flusher threads in case they are asleep.
> +	 */
> +	if (stat.nr_unqueued_dirty == nr_taken)
> +		wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>  	/*
>  	 * Legacy memcg will stall in page writeback so avoid forcibly
>  	 * stalling here.
> @@ -1783,22 +1797,9 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  		if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
>  			set_bit(PGDAT_CONGESTED, &pgdat->flags);
>  
> -		/*
> -		 * If dirty pages are scanned that are not queued for IO, it
> -		 * implies that flushers are not doing their job. This can
> -		 * happen when memory pressure pushes dirty pages to the end of
> -		 * the LRU before the dirty limits are breached and the dirty
> -		 * data has expired. It can also happen when the proportion of
> -		 * dirty pages grows not through writes but through memory
> -		 * pressure reclaiming all the clean cache. And in some cases,
> -		 * the flushers simply cannot keep up with the allocation
> -		 * rate. Nudge the flusher threads in case they are asleep, but
> -		 * also allow kswapd to start writing pages during reclaim.
> -		 */
> -		if (stat.nr_unqueued_dirty == nr_taken) {
> -			wakeup_flusher_threads(WB_REASON_VMSCAN);
> +		/* Allow kswapd to start writing pages during reclaim. */
> +		if (stat.nr_unqueued_dirty == nr_taken)
>  			set_bit(PGDAT_DIRTY, &pgdat->flags);
> -		}
>  
>  		/*
>  		 * If kswapd scans pages marked marked for immediate
> -- 
> 2.16.1

-- 
Michal Hocko
SUSE Labs
