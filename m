Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9284BC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380C2402D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="Hjrrns7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4380C2402D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeGEOn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:43:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36815 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753777AbeGEOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:43:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id s14-v6so11390223wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fr1JIqqJC2AfRkTB+mBsRgrLBwLqOtovoWstTtjToTg=;
        b=Hjrrns7BXaWQ6eynOJefI7RO3D4OxQsEHMYfN0iA7U44puWCV3mTdTzJbW6U2LPgkK
         8aRhBNE13Tb2/RJKufN9RO5d8VacZDX2gRhrbdvqoDji1VtwVzrmhiKdVQ3nARIl672i
         Wk3JJXJOxCWSMjasqjyeLK66hdSNQTSElrxuloRuuQYvR/BGBGN8HofciNPwy4YV+RyW
         7I9sawZBHkgwndBapkuvac++dGF9vA6Sk7U9OqDp40n65YP3wSWVXrnXx9dUuLqHAcCi
         cpsdbAxETzsqyB1cC1/oW7i8cXV8ebncWSdcNfz0bR6CBF5lX6tz1+dFJVmQndd8963y
         F3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fr1JIqqJC2AfRkTB+mBsRgrLBwLqOtovoWstTtjToTg=;
        b=c4orZlrdyDpUeFDQlUCaQ4ynllJ/6IoqsHLHo43J7WUnBDxM/tUYhLwlZ38ibgvmOG
         0NEaY0XAxtpWwQFSwp+Nr3yTCaQpJ+RW1Jv9IiqirpBtiSXwvUE+X5YJUrMpbMWVT6AM
         CKfTBmfE+eFwWfFb+1La2BAYjW5Zw9PBC+TP7zhZquvmPwTeaKpS80xom9D1uIeHjIUQ
         QbQLcxEHQddzudDGNfQqdVqBaWsaYRvga5lSjzR5Gw6emoJTeUrvjbPy7sKiG7qVOrYI
         2II47iGcqnp6pu8RY3CNhB0llIBwI9MTdZ3XFaMILH3og319othEFzk9haSSVocF7QC+
         Rguw==
X-Gm-Message-State: APt69E2ee9DMEIYvu5n0aFfTNQOHP6MdP/EcpWEzf1QMn+nWPo0gmvVJ
        OfVMleb5WNlTaHoNaH+rosyxqw==
X-Google-Smtp-Source: AAOMgpejiHYQgmYAIFKzodWO3nOM9qkCv5BAXmr4KqiUurx6LUqVVymtC2xRqZug6zcj4pi6lg5WRQ==
X-Received: by 2002:a50:e441:: with SMTP id e1-v6mr7252607edm.4.1530801836408;
        Thu, 05 Jul 2018 07:43:56 -0700 (PDT)
Received: from localhost ([2a02:c7f:9214:6300:de53:60ff:fe39:5599])
        by smtp.gmail.com with ESMTPSA id m50-v6sm4549268edc.94.2018.07.05.07.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 07:43:55 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:43:54 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     kernel test robot <xiaolong.ye@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>, lkp@01.org
Subject: Re: [lkp-robot] [sched/fair] fbd5188493:
 WARNING:inconsistent_lock_state
Message-ID: <20180705144354.GC3864@codeblueprint.co.uk>
References: <20180705080227.GH23907@yexl-desktop>
 <0ac4845e-cf6b-c5e3-a16c-f2fc457c5ef5@arm.com>
 <7c3d20fa-4997-e6ed-3750-e054ce1bd610@arm.com>
 <20180705132458.GA3864@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705132458.GA3864@codeblueprint.co.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jul, at 02:24:58PM, Matt Fleming wrote:
> 
> Hmm.. it still looks to me like we should be saving and restoring IRQs
> since this can be called from IRQ context, no?
> 
> The patch was a forward-port from one of our SLE kernels, and I messed
> up the IRQ flag balancing for the v4.18-rc3 code :-(
 
Something like this?

---->8----

From 9b152d8dadec04ac631300d86a92552e57e81db5 Mon Sep 17 00:00:00 2001
From: Matt Fleming <matt@codeblueprint.co.uk>
Date: Wed, 4 Jul 2018 14:22:51 +0100
Subject: [PATCH v2] sched/fair: Avoid divide by zero when rebalancing domains

It's possible that the CPU doing nohz idle balance hasn't had its own
load updated for many seconds. This can lead to huge deltas between
rq->avg_stamp and rq->clock when rebalancing, and has been seen to
cause the following crash:

 divide error: 0000 [#1] SMP
 Call Trace:
  [<ffffffff810bcba8>] update_sd_lb_stats+0xe8/0x560
  [<ffffffff810bd04d>] find_busiest_group+0x2d/0x4b0
  [<ffffffff810bd640>] load_balance+0x170/0x950
  [<ffffffff810be3ff>] rebalance_domains+0x13f/0x290
  [<ffffffff810852bc>] __do_softirq+0xec/0x300
  [<ffffffff8108578a>] irq_exit+0xfa/0x110
  [<ffffffff816167d9>] reschedule_interrupt+0xc9/0xd0

Make sure we update the rq clock and load before balancing.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

Changes in v2: Balance IRQ flags properly.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be4d344..150b92c7c9d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9676,6 +9676,7 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 {
 	int this_cpu = this_rq->cpu;
 	unsigned int flags;
+	struct rq_flags rf;
 
 	if (!(atomic_read(nohz_flags(this_cpu)) & NOHZ_KICK_MASK))
 		return false;
@@ -9692,6 +9693,16 @@ static bool nohz_idle_balance(struct rq *this_rq, enum cpu_idle_type idle)
 	if (!(flags & NOHZ_KICK_MASK))
 		return false;
 
+	/*
+	 * Ensure this_rq's clock and load are up-to-date before we
+	 * rebalance since it's possible that they haven't been
+	 * updated for multiple schedule periods, i.e. many seconds.
+	 */
+	rq_lock_irqsave(this_rq, &rf);
+	update_rq_clock(this_rq);
+	cpu_load_update_idle(this_rq);
+	rq_unlock_irqrestore(this_rq, &rf);
+
 	_nohz_idle_balance(this_rq, flags, idle);
 
 	return true;
-- 
2.13.6

