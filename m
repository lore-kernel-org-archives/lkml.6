Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D508FC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8699B2082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 00:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699B2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbeKDJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 04:26:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeKDJ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 04:26:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA40D4f93851408
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 3 Nov 2018 17:13:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA40D3iO3851405;
        Sat, 3 Nov 2018 17:13:03 -0700
Date:   Sat, 3 Nov 2018 17:13:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-47b7aee14fd7e453370a5d15dfb11c958ca360f2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        valentin.schneider@arm.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, valentin.schneider@arm.com,
          peterz@infradead.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
References: <1537974727-30788-1-git-send-email-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Clean up load_balance() condition
Git-Commit-ID: 47b7aee14fd7e453370a5d15dfb11c958ca360f2
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

Commit-ID:  47b7aee14fd7e453370a5d15dfb11c958ca360f2
Gitweb:     https://git.kernel.org/tip/47b7aee14fd7e453370a5d15dfb11c958ca360f2
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 26 Sep 2018 16:12:06 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 4 Nov 2018 00:59:22 +0100

sched/fair: Clean up load_balance() condition

The alignment of the condition is off, clean that up.

Also, logical operators have lower precedence than bitwise/relational
operators, so remove one layer of parentheses to make the condition a
bit simpler to follow.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dietmar.Eggemann@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: patrick.bellasi@arm.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1537974727-30788-1-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ee271bb661cc..4e298931a715 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8877,9 +8877,9 @@ out_all_pinned:
 
 out_one_pinned:
 	/* tune up the balancing interval */
-	if (((env.flags & LBF_ALL_PINNED) &&
-			sd->balance_interval < MAX_PINNED_INTERVAL) ||
-			(sd->balance_interval < sd->max_interval))
+	if ((env.flags & LBF_ALL_PINNED &&
+	     sd->balance_interval < MAX_PINNED_INTERVAL) ||
+	    sd->balance_interval < sd->max_interval)
 		sd->balance_interval *= 2;
 
 	ld_moved = 0;
