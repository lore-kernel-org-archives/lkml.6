Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E525C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18D320895
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 23:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bwq2LeWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18D320895
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeHEBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 21:10:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33102 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbeHEBKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 21:10:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id b90-v6so3293375plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 16:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=OqZgw7jOMqadTNUK5I9Q1OLPDjiLDsG6YXzHdkx0g+Y=;
        b=bwq2LeWihoIvA5KVWE6jdplXqI3QqDFrhpdRn1HLkxhCu+xzogx49sywuKc0M3F62M
         532WxzlFXTYrdgL+FG1NjnV4VXFnA7a/4/O8kpaiy3nrbDbt2IQJVFgfzbY7ZWkcmW88
         aftyClWtkOIeGrGS2fFtpyXHnd3VgQb946zrw0qGD7qg8XQ+MWT2Mad4Iym6MqFo0oH1
         Ef2rBCukMukw7QCcw3g6YvVE6tYuiMLkfLa4c8AEjgV3RPNkZaP3nF4e0vJViuzlC5Lp
         AK4VEYKzeC1tQlRjRmvkdb/Ax4rI9FCVX+19zU0GckNTdFqnKnOuUPmH3CIIIJK3rE8m
         6NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=OqZgw7jOMqadTNUK5I9Q1OLPDjiLDsG6YXzHdkx0g+Y=;
        b=LCu4Mr+tOBgksCv9Ru8m1OPHrAzFoa5SG/X8cO0t7ppe+jOyijLhmRdxC9KJg3oKHw
         0KjbCKO52qX2hBiusMv668QVQ8FeXCBqJPtqSqVqCs2IqS70YFQrURjM+bga0Q0hM9GM
         aKtG1D/3Kx46INB8gMoOxY7sWDORwrfohk6jg1k86nmAsW7eQO+/lcWByHhd+0d2JZFg
         pp3Kpu/fseCu5dVGSLR2pma+EEf6wM0583lk8tH8mq3Z/ctdmVtMuiRFt3XRPvqPBg9t
         rewd00xLZigJBCMcR1DjoX4Af+0zhD4h5tiHyKI6SbGtEsXSIjorpMoWLCOidveW2yew
         9AMw==
X-Gm-Message-State: AOUpUlEhn6rS3tiJIuSQSyckYzGtjOlXKCXnqZOIjuxuHlj2koltsBp/
        0FFZiwmCRuG+Ed82zla7GvousA==
X-Google-Smtp-Source: AAOMgpcdJpEUFPUVpd0i4QPDeFZ8SjdP03AF46T8nvCI3cSFEXhsQZKfrp1nG4AR/UWVvVpwzqV0LQ==
X-Received: by 2002:a17:902:758b:: with SMTP id j11-v6mr8576612pll.29.1533424078109;
        Sat, 04 Aug 2018 16:07:58 -0700 (PDT)
Received: from [100.112.67.156] ([104.133.9.108])
        by smtp.gmail.com with ESMTPSA id 87-v6sm17631312pfn.103.2018.08.04.16.07.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 04 Aug 2018 16:07:56 -0700 (PDT)
Date:   Sat, 4 Aug 2018 16:07:48 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com>
cc:     akpm <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>,
        mgorman <mgorman@techsingularity.net>,
        minchan <minchan@kernel.org>, vinmenon <vinmenon@codeaurora.org>,
        hannes <hannes@cmpxchg.org>,
        "hillf.zj" <hillf.zj@alibaba-inc.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: Re: [PATCH] [PATCH] mm: disable preemption before
 swapcache_free
In-Reply-To: <20180727140749669129112@wingtech.com>
Message-ID: <alpine.LSU.2.11.1808041332410.1120@eggly.anvils>
References: <2018072514375722198958@wingtech.com>, <20180725141643.6d9ba86a9698bc2580836618@linux-foundation.org>, <2018072610214038358990@wingtech.com>, <20180726060640.GQ28386@dhcp22.suse.cz>, <20180726150323057627100@wingtech.com>,
 <20180726151118.db0cf8016e79bed849e549f9@linux-foundation.org> <20180727140749669129112@wingtech.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jul 2018, zhaowuyun@wingtech.com wrote:
> >On Thu, 26 Jul 2018 15:03:23 +0800 "zhaowuyun@wingtech.com" <zhaowuyun@wingtech.com> wrote:
> >
> >> >On Thu 26-07-18 10:21:40, zhaowuyun@wingtech.com wrote:
> >> >[...]
> >> >> Our project really needs a fix to this issue
> >> >
> >> >Could you be more specific why? My understanding is that RT tasks
> >> >usually have all the memory mlocked otherwise all the real time
> >> >expectations are gone already.
> >> >--
> >> >Michal Hocko
> >> >SUSE Labs
> >>
> >>
> >> The RT thread is created by a process with normal priority, and the process was sleep,
> >> then some task needs the RT thread to do something, so the process create this thread, and set it to RT policy.
> >> I think that is the reason why RT task would read the swap.
> >
> >A simpler bandaid might be to replace the cond_resched() with msleep(1). 
> 
> 
> Thanks for the suggestion, we will try that.

Andrew's msleep(1) may be a good enough bandaid for you. And I share
Michal's doubt about your design, in which an RT thread meets swap:
this may not be the last problem you have with that.

But this is a real bug when CONFIG_PREEMPT=y, RT threads or not: we
just didn't notice, because it's usually hidden by the cond_resched().
(I think that was added in 3.10, because in 2.6.29 I had been guilty of
inserting a discard, and wait for completion, in between allocating swap
and adding to swap cache; but Shao Hua fixed my discard in 3.12.) Thanks
a lot for making us aware of this bug.

After reminding myself of the issues here, I disagree with much of what
has been said: we shall "always" want the loop in __read_swap_cache_async()
(though some of its error handling is probably superfluous now, agreed);
and your disabling of preemption is not just a bandaid, it's exactly the
right approach.

We could do something heavier, perhaps rearranging the swapcache tree work
to be done under swap_lock as well as tree_lock (I'm talking 4.9-language),
but that's very unlikely to be an improvement. Disabling preemption yokes
the two spinlocks together in an efficient way, without overhead on other
paths; on rare occasions we spin around __read_swap_cache_async() instead
of spinning around to acquire a spinlock.

But your patch is incomplete. The same needs to be done in delete_from_
swap_cache(), and we would also need to protect against preemption between
the get_swap_page() and the add_to_swap_cache(), in add_to_swap() and in
shmem_writepage(). The latter gets messy, but 4.11 (where Tim Chen uses
SWAP_HAS_CACHE more widely) gives a good hint: __read_swap_cache_async()
callers are only interested in swap entries that are already in use and
still in use. (Though swapoff has to be more careful, partly because one
of its jobs is to clear out swap-cache-only entries, partly because the
current interface would mistake a NULL for no-entry as out-of-memory.)

Below is the patch I would do for 4.9 (diffed against 4.9.117), and I'm
showing that because it's the simplest case. Although the principles stay
the same, the codebase here has gone through several shifts, and 4.19 will
probably be different again. So I'll test and post a patch against 4.19-rc
in a few weeks time, and that can then be backported to stable: but will
need several manual backports because of the intervening changes.

I did wonder whether just to extend the irq-disabled section in
delete_from_swap_cache() etc: that's easy, and works, and is even better
protection against spinning too long; but it's not absolutely necessary,
so all in all, probably better avoided. I did wonder whether to remove
the cond_resched(), but it's not a bad place for one, so I've left it in.

When checking worst cases of looping around __read_swap_cache_async(),
after the patch, I was worried for a while. I had naively imagined that
going more than twice around the loop should be vanishingly rare, but
that is not so at all. But the bad cases I looked into were all the same:
after forking, two processes, on HT siblings, each serving do_swap_page(),
trying to bring the same swap into its mm, with a sparse swapper_space
tree: one process gets to do all the work of allocating new radix-tree
nodes and bringing them into D-cache, while the other just spins around
__read_swap_cache_async() seeing SWAP_HAS_CACHE but not yet the page in
the radix-tree. That's okay, that makes sense.

Hugh
---

 mm/swap_state.c |   26 +++++++++++++-------------
 mm/swapfile.c   |    8 +++++++-
 mm/vmscan.c     |    3 +++
 3 files changed, 23 insertions(+), 14 deletions(-)

--- 4.9.117/mm/swap_state.c	2016-12-11 11:17:54.000000000 -0800
+++ linux/mm/swap_state.c	2018-08-04 11:50:46.577788766 -0700
@@ -225,9 +225,11 @@ void delete_from_swap_cache(struct page
 	address_space = swap_address_space(entry);
 	spin_lock_irq(&address_space->tree_lock);
 	__delete_from_swap_cache(page);
+	/* Expedite swapcache_free() to help __read_swap_cache_async() */
+	preempt_disable();
 	spin_unlock_irq(&address_space->tree_lock);
-
 	swapcache_free(entry);
+	preempt_enable();
 	put_page(page);
 }
 
@@ -337,19 +339,17 @@ struct page *__read_swap_cache_async(swp
 		if (err == -EEXIST) {
 			radix_tree_preload_end();
 			/*
-			 * We might race against get_swap_page() and stumble
-			 * across a SWAP_HAS_CACHE swap_map entry whose page
-			 * has not been brought into the swapcache yet, while
-			 * the other end is scheduled away waiting on discard
-			 * I/O completion at scan_swap_map().
+			 * We might race against __delete_from_swap_cache() and
+			 * stumble across a swap_map entry whose SWAP_HAS_CACHE
+			 * has not yet been cleared: hence preempt_disable()
+			 * in __remove_mapping() and delete_from_swap_cache(),
+			 * so they cannot schedule away before clearing it.
 			 *
-			 * In order to avoid turning this transitory state
-			 * into a permanent loop around this -EEXIST case
-			 * if !CONFIG_PREEMPT and the I/O completion happens
-			 * to be waiting on the CPU waitqueue where we are now
-			 * busy looping, we just conditionally invoke the
-			 * scheduler here, if there are some more important
-			 * tasks to run.
+			 * We need similar protection against racing calls to
+			 * __read_swap_cache_async(): preempt_disable() before
+			 * swapcache_prepare() above, preempt_enable() after
+			 * __add_to_swap_cache() below: which are already in
+			 * radix_tree_maybe_preload(), radix_tree_preload_end().
 			 */
 			cond_resched();
 			continue;
--- 4.9.117/mm/swapfile.c	2018-08-04 11:40:08.463504848 -0700
+++ linux/mm/swapfile.c	2018-08-04 11:50:46.577788766 -0700
@@ -2670,7 +2670,13 @@ static int __swap_duplicate(swp_entry_t
 		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
 		if (!has_cache && count)
 			has_cache = SWAP_HAS_CACHE;
-		else if (has_cache)		/* someone else added cache */
+		/*
+		 * __read_swap_cache_async() can usually skip entries without
+		 * real usage (including those in between being allocated and
+		 * added to swap cache); but swapoff (!SWP_WRITEOK) must not.
+		 */
+		else if (has_cache &&
+			 (count || !(p->flags & SWP_WRITEOK)))
 			err = -EEXIST;
 		else				/* no users remaining */
 			err = -ENOENT;
--- 4.9.117/mm/vmscan.c	2018-08-04 11:40:08.471504902 -0700
+++ linux/mm/vmscan.c	2018-08-04 11:50:46.577788766 -0700
@@ -709,8 +709,11 @@ static int __remove_mapping(struct addre
 		swp_entry_t swap = { .val = page_private(page) };
 		mem_cgroup_swapout(page, swap);
 		__delete_from_swap_cache(page);
+		/* Expedite swapcache_free() for __read_swap_cache_async() */
+		preempt_disable();
 		spin_unlock_irqrestore(&mapping->tree_lock, flags);
 		swapcache_free(swap);
+		preempt_enable();
 	} else {
 		void (*freepage)(struct page *);
 		void *shadow = NULL;
