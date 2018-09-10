Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4B5C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4711B20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4711B20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbeIJPKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:10:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38337 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeIJPKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:10:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAGV4c1808239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:16:31 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAGVIW1808236;
        Mon, 10 Sep 2018 03:16:31 -0700
Date:   Mon, 10 Sep 2018 03:16:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-575638d1047eb057a5cdf95cc0b3c084e1279508@git.kernel.org>
Cc:     morten.rasmussen@arm.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, valentin.schneider@arm.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          torvalds@linux-foundation.org, morten.rasmussen@arm.com,
          valentin.schneider@arm.com, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <1530699470-29808-8-git-send-email-morten.rasmussen@arm.com>
References: <1530699470-29808-8-git-send-email-morten.rasmussen@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Change root_domain->overload type to
 int
Git-Commit-ID: 575638d1047eb057a5cdf95cc0b3c084e1279508
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

Commit-ID:  575638d1047eb057a5cdf95cc0b3c084e1279508
Gitweb:     https://git.kernel.org/tip/575638d1047eb057a5cdf95cc0b3c084e1279508
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 4 Jul 2018 11:17:45 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 11:05:52 +0200

sched/core: Change root_domain->overload type to int

sizeof(_Bool) is implementation defined, so let's just go with 'int' as
is done for other structures e.g. sched_domain_shared->has_idle_cores.

The local 'overload' variable used in update_sd_lb_stats can remain
bool, as it won't impact any struct layout and can be assigned to the
root_domain field.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dietmar.eggemann@arm.com
Cc: gaku.inami.xh@renesas.com
Cc: vincent.guittot@linaro.org
Link: http://lkml.kernel.org/r/1530699470-29808-8-git-send-email-morten.rasmussen@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fe17e0be2d7b..4d181478c5b8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -716,7 +716,7 @@ struct root_domain {
 	cpumask_var_t		online;
 
 	/* Indicate more than one runnable task for any CPU */
-	bool			overload;
+	int			overload;
 
 	/*
 	 * The bit corresponding to a CPU gets set here if such CPU has more
@@ -1698,7 +1698,7 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	if (prev_nr < 2 && rq->nr_running >= 2) {
 #ifdef CONFIG_SMP
 		if (!rq->rd->overload)
-			rq->rd->overload = true;
+			rq->rd->overload = 1;
 #endif
 	}
 
