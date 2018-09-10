Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D32C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B29120865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B29120865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeIJPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:09:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60835 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:09:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAFxIf1808185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:15:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAFx7o1808182;
        Mon, 10 Sep 2018 03:15:59 -0700
Date:   Mon, 10 Sep 2018 03:15:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-dbbad719449e06d73db21598d6eee178f7a54b3b@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, valentin.schneider@arm.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        morten.rasmussen@arm.com
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          morten.rasmussen@arm.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, valentin.schneider@arm.com,
          peterz@infradead.org
In-Reply-To: <1530699470-29808-7-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-7-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Change 'prefer_sibling' type to bool
Git-Commit-ID: dbbad719449e06d73db21598d6eee178f7a54b3b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  dbbad719449e06d73db21598d6eee178f7a54b3b
Gitweb:     https://git.kernel.org/tip/dbbad719449e06d73db21598d6eee178f7a54b3b
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:44 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:51 +0200

sched/fair: Change 'prefer_sibling' type to bool

This variable is entirely local to update_sd_lb_stats, so we can
safely change its type and slightly clean up its initialisation.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-7-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e08287d3806f..23017939ecab 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7982,11 +7982,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
+	int load_idx;
 	bool overload = false;
-
-	if (child && child->flags & SD_PREFER_SIBLING)
-		prefer_sibling = 1;
+	bool prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
 
 #ifdef CONFIG_NO_HZ_COMMON
 	if (env->idle == CPU_NEWLY_IDLE && READ_ONCE(nohz.has_blocked))
