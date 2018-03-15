Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977033-1521140272-2-17168333704012227990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521140271; b=JcvXgjdlJ7Z4Ag7I07fJM1Njzi5s3dbTJm+3jPDz99ifGg/
    V8+vctZz9wHzZ9MsF8dUCtWYoJmUp9ADFzc8FPKPelPgOpm/a+cR3UTA///5PKia
    EjH1+vybNghXo97Ujo0Ajk987xzUnjwz7Iqxxjare+lsXD6SKW18siZCsSKUVWi+
    MjLekOKyo0uUpoG/1j3VVq96UkNS0otCGxBuzWJYIKHuXRL0HyXNNjZqJ9nBCLf6
    k/Nxcvhszn5ucgT00f7QreV5DwnPq3tY/IcqGZUheHGXKf7RR65zZcZR+31WYBNR
    ixuxhRtf9um423Vv6RfVlGxCa8Wh3IQ0MbYJ1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521140271; bh=OVanvcC/dLgyh6uP3KXtKdocGMaip3rlCnvK2N
    PvV18=; b=Wse8Rj1oGwj6Lns3bwjJ0p3XhWVTWmheB9ApvPSvndOZe06HCndRdf
    Wtjyc5bnnwrXHJFNREij2/P/XxL8rqp/3ARAIFosRkPS59+udoNwtUilPYKOcg08
    42HQk4Qrcc6CCbipeMoShikgrpyy7Oe4jkL5zSGu4vVS4oZebNrlr4fJ27mnIkTb
    h+rXU+jgP3ufqsEGzOnvmYkT/ZX3BT1bPGSCK1sk6jRnKUhoL9hobEZeLT7GKUgU
    pOyP7flkW/Ax9pvZKW9WSrjvF5/iO7OlNLs5Q2kRhhHRt5tUe1w1IQ5bLGmRAdv8
    PlNDjicem8peVVzb2o6LAI2sVW1ZdhGg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JjdRc6ZH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Bj9ogods;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=JjdRc6ZH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Bj9ogods;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeCOS5s (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 14:57:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53816 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCOS5r (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 14:57:47 -0400
X-Google-Smtp-Source: AG47ELupcj36LEjVov3hI936B0awkrFP9fzxv3U881sqBL2FGo477K8SVFqFS4sdDjMCJU2GD+o92CBZN1zPc6fa6fI=
MIME-Version: 1.0
In-Reply-To: <20180315164553.17856-1-aryabinin@virtuozzo.com>
References: <20180315164553.17856-1-aryabinin@virtuozzo.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 15 Mar 2018 11:57:44 -0700
Message-ID: <CALvZod5LVv61Wdsq_h+4i392O1uQprGri+99WfA=Qxr=ZBoZLw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm/vmscan: Wake up flushers for legacy cgroups too
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 9:45 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
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
>             active_anon:1168KB inactive_file:24760KB active_file:24960KB unevictable:0KB
>     Memory cgroup out of memory: Kill process 3861 (bash) score 88 or sacrifice child
>     Killed process 3876 (dd) total-vm:8484kB, anon-rss:1052kB, file-rss:1720kB, shmem-rss:0kB
>     oom_reaper: reaped process 3876 (dd), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>
> Wake up flushers in legacy cgroup reclaim too.
>
> Fixes: bbef938429f5 ("mm: vmscan: remove old flusher wakeup from direct reclaim path")
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>

Indeed I am seeing oom-kills without the patch.

Tested-by: Shakeel Butt <shakeelb@google.com>

> Cc: <stable@vger.kernel.org>
> ---
>  mm/vmscan.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8fcd9f8d7390..4390a8d5be41 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1771,6 +1771,20 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>         if (stat.nr_writeback && stat.nr_writeback == nr_taken)
>                 set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>
> +       /*
> +        * If dirty pages are scanned that are not queued for IO, it
> +        * implies that flushers are not doing their job. This can
> +        * happen when memory pressure pushes dirty pages to the end of
> +        * the LRU before the dirty limits are breached and the dirty
> +        * data has expired. It can also happen when the proportion of
> +        * dirty pages grows not through writes but through memory
> +        * pressure reclaiming all the clean cache. And in some cases,
> +        * the flushers simply cannot keep up with the allocation
> +        * rate. Nudge the flusher threads in case they are asleep.
> +        */
> +       if (stat.nr_unqueued_dirty == nr_taken)
> +               wakeup_flusher_threads(WB_REASON_VMSCAN);
> +
>         /*
>          * Legacy memcg will stall in page writeback so avoid forcibly
>          * stalling here.
> @@ -1783,22 +1797,9 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>                 if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
>                         set_bit(PGDAT_CONGESTED, &pgdat->flags);
>
> -               /*
> -                * If dirty pages are scanned that are not queued for IO, it
> -                * implies that flushers are not doing their job. This can
> -                * happen when memory pressure pushes dirty pages to the end of
> -                * the LRU before the dirty limits are breached and the dirty
> -                * data has expired. It can also happen when the proportion of
> -                * dirty pages grows not through writes but through memory
> -                * pressure reclaiming all the clean cache. And in some cases,
> -                * the flushers simply cannot keep up with the allocation
> -                * rate. Nudge the flusher threads in case they are asleep, but
> -                * also allow kswapd to start writing pages during reclaim.
> -                */
> -               if (stat.nr_unqueued_dirty == nr_taken) {
> -                       wakeup_flusher_threads(WB_REASON_VMSCAN);
> +               /* Allow kswapd to start writing pages during reclaim. */
> +               if (stat.nr_unqueued_dirty == nr_taken)
>                         set_bit(PGDAT_DIRTY, &pgdat->flags);
> -               }
>
>                 /*
>                  * If kswapd scans pages marked marked for immediate
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe cgroups" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
