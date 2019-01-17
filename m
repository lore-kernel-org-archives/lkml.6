Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC5BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F6920652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfAQPh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:37:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42012 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfAQPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:37:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1391596;
        Thu, 17 Jan 2019 07:37:40 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 783903F819;
        Thu, 17 Jan 2019 07:37:39 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Dietmar.Eggemann@arm.com
Subject: [PATCH 3/5] sched/fair: Prune nohz_balancer_kick() comment block
Date:   Thu, 17 Jan 2019 15:34:09 +0000
Message-Id: <20190117153411.2390-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190117153411.2390-1-valentin.schneider@arm.com>
References: <20190117153411.2390-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment block for that function lists the heuristics for
triggering a nohz kick, but the most recent ones (blocked load
updates, misfit) aren't included, and some of them (LLC nohz logic,
asym packing) are no longer in sync with the code.

The conditions are either simple enough or properly commented, so get
rid of that list instead of letting it grow.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 62f6aead7e73..7658f9d76a9a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9493,15 +9493,8 @@ static void kick_ilb(unsigned int flags)
 }
 
 /*
- * Current heuristic for kicking the idle load balancer in the presence
- * of an idle cpu in the system.
- *   - This rq has more than one task.
- *   - This rq has at least one CFS task and the capacity of the CPU is
- *     significantly reduced because of RT tasks or IRQs.
- *   - At parent of LLC scheduler domain level, this cpu's scheduler group has
- *     multiple busy cpu.
- *   - For SD_ASYM_PACKING, if the lower numbered cpu's in the scheduler
- *     domain span are idle.
+ * Current decision point for kicking the idle load balancer in the presence
+ * of idle CPUs in the system.
  */
 static void nohz_balancer_kick(struct rq *rq)
 {
-- 
2.20.1

