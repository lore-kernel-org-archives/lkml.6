Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDF5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5A72089D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="a0/VPmHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5A72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeblueprint.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753069AbeGDOZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:25:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34278 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752458AbeGDOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:24:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id d3-v6so4199563edi.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=2s2L0RJviU0vmewBnaBqWTtDyZnpfpltGB2v9Wr7PLg=;
        b=a0/VPmHr7lnFTWa/+zQKLBEz8AGbkuyAR26pVX7P8JAw5GOGE+hG7MoxDPOu9C85mu
         t4Vn34kwkNP4TZy8f/e9hIUmJbM4wBjLXeuuN0U3g40ckr95SKAKKHk2RBvYeJMb1skB
         v3iBniUocB4Vzs4ZYPs633p7eUDt78+pw9i33M8hDJ0Egki2BGCeZf1VifHVobXgCynv
         xsYiQFc5hIIYbBIlNr35sOjnPmRenYJx3R8AwqJypotegpthEb/YRjogPAR8lPnPLiUR
         s6cRBdTGxdLWkJPcNazmxMJtm9G0zYmQK9T5sARVHlZeuK8q3+rPiDq2gDzQGVoUFy6I
         cEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2s2L0RJviU0vmewBnaBqWTtDyZnpfpltGB2v9Wr7PLg=;
        b=o1ScVV2NkIIBdRLj99Nv2iV/1XZSvCakn9UMEk7/F8UicTA6YAbEW+KVUI1MIZSloJ
         o3XF23bl/BwsTtAo6aHl3/ixDEAdV8KAxPHLO+mMui0QhOTsx4H9Nrzvdir9WgRPoM6E
         k+OwDD0zEuHDLqJLmdH72Az+xSnkzhtdKTQj5gH5G1lDvFG6QP1gprxUTY5AKHQozguQ
         qINLHFr+jHiSjcMR+kGO+XgMIpscFfBO1pkJ0YSGPAL8pkDPcp7vaHAEaNS9demQ/cRs
         U9/9hRGy9T23yI9oz1BAkeFel7mVsfpEtL6F0OX9Bzw2qTkHRxQzl+lR9hgrHajK0N2h
         uTcg==
X-Gm-Message-State: APt69E3KA6F0s9jnlX6PqKArm/TTsA1B2aTgpBF0VV1FC7vo7A2fb30B
        HC6uCu3MSMk9KU3AAoRuMJALkoI+
X-Google-Smtp-Source: AAOMgpfmnfKTY0gxFJljgjxOVDKKJYD3ji7Lg+bLMzjQuVBZtMz/G5PId+v1XCXhUcuIWiaWpyQkRQ==
X-Received: by 2002:a50:89aa:: with SMTP id g39-v6mr2828955edg.25.1530714297449;
        Wed, 04 Jul 2018 07:24:57 -0700 (PDT)
Received: from localhost ([2a02:c7f:9214:6300:de53:60ff:fe39:5599])
        by smtp.gmail.com with ESMTPSA id r3-v6sm2021488edh.9.2018.07.04.07.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:24:57 -0700 (PDT)
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [PATCH] sched/fair: Avoid divide by zero when rebalancing domains
Date:   Wed,  4 Jul 2018 15:24:55 +0100
Message-Id: <20180704142455.16035-1-matt@codeblueprint.co.uk>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Matt Fleming <matt@codeblueprint.co.uk>
---
 kernel/sched/fair.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2f0a0be4d344..2c81662c858a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9597,6 +9597,16 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 */
 	smp_mb();
 
+	/*
+	 * Ensure this_rq's clock and load are up-to-date before we
+	 * rebalance since it's possible that they haven't been
+	 * updated for multiple schedule periods, i.e. many seconds.
+	 */
+	raw_spin_lock_irq(&this_rq->lock);
+	update_rq_clock(this_rq);
+	cpu_load_update_idle(this_rq);
+	raw_spin_unlock_irq(&this_rq->lock);
+
 	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
 		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
 			continue;
-- 
2.13.6

