Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8A7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB97721909
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d/S+qQm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeLUGFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:05:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34324 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeLUGFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:05:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so3931580oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SKCcAeW5H4+bwp7AQJhecAcvEZDXW19JmTrsciJug4w=;
        b=d/S+qQm4oJbHT5p9lTGC2fWkz8K5Bk9hacHLmCj3635B3waQQqrx5BsYm1eXsQ0ofN
         k7bHpO7LzV+uO2KMi4hYje8NjWgipT41BtnXfFpl7apqtWkonhyvTS418Ot0F+mo7a3y
         84Jnd3CTPdbUOKlyHDZ3bUenjdcTDasJv6gL6xzs4V8LYgdoEnQ9BTxAWFN+0mB2VCKZ
         QtlWaUUDtzHcNfPv99vv2HBzd4hsLqY3fMdfvpu22rgvr8iyW+19ZqoNxEvAxn6uzPBw
         QODcLkazq5Inuis7qhWPuMSl8PeqFYZqoe58/JfDg3UdPdHtyPKY2GFiY4vKkUlKIkia
         egKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SKCcAeW5H4+bwp7AQJhecAcvEZDXW19JmTrsciJug4w=;
        b=EiEGSe264M4qiUKKX5vxzXzLnUkCeeLu2HUhBQk8wq0ctgnbIQxdVbLStiXHl+/5a/
         Vl9PAvTLxYZkSsuLTpix7Nrf+l1ozcqecgF00tLg9i8Mlr5jPg746Y+bJz7LqXiAWZwZ
         TvOxoo5GuxA8wn7UlrYtX57JpwKQBIJrTNBvkPIGQuBcrq/eUnekbF7sYueQikww+mJZ
         /Bi4eYs5Gf4QVYnin5yq0llzKq0ucNUiZba/R8wLpdgBwxxoU7m0joKLPYL+lNx3+Jg0
         TN8XYtgj6s7LOYnocnBxDHuGxnIyokpX5GKrHsF+HqF5hu6YchZ/V+IdgGsF1o8WVbdr
         dBXg==
X-Gm-Message-State: AJcUukcFmF95bUT3al9TPAjE33ASMSA5yMdA7zb8iKb83HIBEcLRNcOg
        2EkMGHTe90ZjqzKJZhRD7W6Uow==
X-Google-Smtp-Source: AFSGD/U3pqvjZE1z6kg3DO6N6JzfpwRIKFjQC/hqO5a3hIEZgtZ2zfpAN7HSr0idXBNAyfz++GeSvg==
X-Received: by 2002:a05:6808:155:: with SMTP id h21mr594679oie.34.1545372301828;
        Thu, 20 Dec 2018 22:05:01 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s186sm11712006oie.13.2018.12.20.22.04.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 22:05:00 -0800 (PST)
Date:   Thu, 20 Dec 2018 22:04:51 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        vbabka@suse.cz, hannes@cmpxchg.org, hughd@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 1/2] mm: vmscan: skip KSM page in direct reclaim if
 priority is low
In-Reply-To: <20181220144513.bf099a67c1140865f496011f@linux-foundation.org>
Message-ID: <alpine.LSU.2.11.1812202143340.2191@eggly.anvils>
References: <1541618201-120667-1-git-send-email-yang.shi@linux.alibaba.com> <20181220144513.bf099a67c1140865f496011f@linux-foundation.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Dec 2018, Andrew Morton wrote:
> 
> Is anyone interested in reviewing this?  Seems somewhat serious. 
> Thanks.

Somewhat serious, but no need to rush.

> 
> From: Yang Shi <yang.shi@linux.alibaba.com>
> Subject: mm: vmscan: skip KSM page in direct reclaim if priority is low
> 
> When running a stress test, we occasionally run into the below hang issue:

Artificial load presumably.

> 
> INFO: task ksmd:205 blocked for more than 360 seconds.
>       Tainted: G            E 4.9.128-001.ali3000_nightly_20180925_264.alios7.x86_64 #1

4.9-stable does not contain Andrea's 4.13 commit 2c653d0ee2ae
("ksm: introduce ksm_max_page_sharing per page deduplication limit").

The patch below is more economical than Andrea's, but I don't think
a second workaround should be added, unless Andrea's is shown to be
insufficient, even with its ksm_max_page_sharing tuned down to suit.

Yang, please try to reproduce on upstream, or backport Andrea's to
4.9-stable - thanks.

Hugh

> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> ksmd            D    0   205      2 0x00000000
>  ffff882fa00418c0 0000000000000000 ffff882fa4b10000 ffff882fbf059d00
>  ffff882fa5bc1800 ffffc900190c7c28 ffffffff81725e58 ffffffff810777c0
>  00ffc900190c7c88 ffff882fbf059d00 ffffffff8138cc09 ffff882fa4b10000
> Call Trace:
>  [<ffffffff81725e58>] ? __schedule+0x258/0x720
>  [<ffffffff810777c0>] ? do_flush_tlb_all+0x30/0x30
>  [<ffffffff8138cc09>] ? free_cpumask_var+0x9/0x10
>  [<ffffffff81726356>] schedule+0x36/0x80
>  [<ffffffff81729916>] schedule_timeout+0x206/0x4b0
>  [<ffffffff81077d0f>] ? native_flush_tlb_others+0x11f/0x180
>  [<ffffffff8110ca40>] ? ktime_get+0x40/0xb0
>  [<ffffffff81725b6a>] io_schedule_timeout+0xda/0x170
>  [<ffffffff81726c50>] ? bit_wait+0x60/0x60
>  [<ffffffff81726c6b>] bit_wait_io+0x1b/0x60
>  [<ffffffff81726759>] __wait_on_bit_lock+0x59/0xc0
>  [<ffffffff811aff76>] __lock_page+0x86/0xa0
>  [<ffffffff810d53e0>] ? wake_atomic_t_function+0x60/0x60
>  [<ffffffff8121a269>] ksm_scan_thread+0xeb9/0x1430
>  [<ffffffff810d5340>] ? prepare_to_wait_event+0x100/0x100
>  [<ffffffff812193b0>] ? try_to_merge_with_ksm_page+0x850/0x850
>  [<ffffffff810ac226>] kthread+0xe6/0x100
>  [<ffffffff810ac140>] ? kthread_park+0x60/0x60
>  [<ffffffff8172b196>] ret_from_fork+0x46/0x60
> 
> ksmd found a suitable KSM page on the stable tree and is trying to lock
> it.  But it is locked by the direct reclaim path which is walking the
> page's rmap to get the number of referenced PTEs.
> 
> The KSM page rmap walk needs to iterate all rmap_items of the page and all
> rmap anon_vmas of each rmap_item.  So it may take (# rmap_item * #
> children processes) loops.  This number of loops might be very large in
> the worst case, and may take a long time.
> 
> Typically, direct reclaim will not intend to reclaim too many pages, and
> it is latency sensitive.  So it is not worth doing the long ksm page rmap
> walk to reclaim just one page.
> 
> Skip KSM pages in direct reclaim if the reclaim priority is low, but still
> try to reclaim KSM pages with high priority.
> 
> Link: http://lkml.kernel.org/r/1541618201-120667-1-git-send-email-yang.shi@linux.alibaba.com
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/vmscan.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> --- a/mm/vmscan.c~mm-vmscan-skip-ksm-page-in-direct-reclaim-if-priority-is-low
> +++ a/mm/vmscan.c
> @@ -1260,8 +1260,17 @@ static unsigned long shrink_page_list(st
>  			}
>  		}
>  
> -		if (!force_reclaim)
> -			references = page_check_references(page, sc);
> +		if (!force_reclaim) {
> +			/*
> +			 * Don't try to reclaim KSM page in direct reclaim if
> +			 * the priority is not high enough.
> +			 */
> +			if (PageKsm(page) && !current_is_kswapd() &&
> +			    sc->priority > (DEF_PRIORITY - 2))
> +				references = PAGEREF_KEEP;
> +			else
> +				references = page_check_references(page, sc);
> +		}
>  
>  		switch (references) {
>  		case PAGEREF_ACTIVATE:
> @@ -2136,6 +2145,16 @@ static void shrink_active_list(unsigned
>  			}
>  		}
>  
> +		/*
> +		 * Skip KSM page in direct reclaim if priority is not
> +		 * high enough.
> +		 */
> +		if (PageKsm(page) && !current_is_kswapd() &&
> +		    sc->priority > (DEF_PRIORITY - 2)) {
> +			putback_lru_page(page);
> +			continue;
> +		}
> +
>  		if (page_referenced(page, 0, sc->target_mem_cgroup,
>  				    &vm_flags)) {
>  			nr_rotated += hpage_nr_pages(page);
> _
