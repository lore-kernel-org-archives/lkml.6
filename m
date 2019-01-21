Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B63C7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1963020663
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfAULbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:31:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbfAULa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:30:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0LBUkLr2496607
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 21 Jan 2019 03:30:46 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0LBUj3i2496604;
        Mon, 21 Jan 2019 03:30:45 -0800
Date:   Mon, 21 Jan 2019 03:30:45 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Valentin Schneider <tipbot@zytor.com>
Message-ID: <tip-b5a4e2bb0f4c86bfeb38df3e1d5b2f1272f0e673@git.kernel.org>
Cc:     valentin.schneider@arm.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, hpa@zytor.com, peterz@infradead.org,
        will.deacon@arm.com, akpm@linux-foundation.org, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
          valentin.schneider@arm.com, akpm@linux-foundation.org,
          will.deacon@arm.com, mingo@kernel.org, peterz@infradead.org,
          hpa@zytor.com
In-Reply-To: <1545243796-23224-3-git-send-email-valentin.schneider@arm.com>
References: <1545243796-23224-3-git-send-email-valentin.schneider@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Revert "sched/core: Take the hotplug lock in
 sched_init_smp()"
Git-Commit-ID: b5a4e2bb0f4c86bfeb38df3e1d5b2f1272f0e673
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

Commit-ID:  b5a4e2bb0f4c86bfeb38df3e1d5b2f1272f0e673
Gitweb:     https://git.kernel.org/tip/b5a4e2bb0f4c86bfeb38df3e1d5b2f1272f0e673
Author:     Valentin Schneider <valentin.schneider@arm.com>
AuthorDate: Wed, 19 Dec 2018 18:23:16 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 21 Jan 2019 11:18:54 +0100

Revert "sched/core: Take the hotplug lock in sched_init_smp()"

This reverts commit 40fa3780bac2b654edf23f6b13f4e2dd550aea10.

Now that we have a system-wide muting of hotplug lockdep during init,
this is no longer needed.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: cai@gmx.us
Cc: daniel.lezcano@linaro.org
Cc: dietmar.eggemann@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: longman@redhat.com
Cc: marc.zyngier@arm.com
Cc: mark.rutland@arm.com
Link: https://lkml.kernel.org/r/1545243796-23224-3-git-send-email-valentin.schneider@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b05eef7d7a1f..3c8b4dba3d2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5867,14 +5867,11 @@ void __init sched_init_smp(void)
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
-	 * happen. The hotplug lock is nevertheless taken to satisfy lockdep,
-	 * but there won't be any contention on it.
+	 * happen.
 	 */
-	cpus_read_lock();
 	mutex_lock(&sched_domains_mutex);
 	sched_init_domains(cpu_active_mask);
 	mutex_unlock(&sched_domains_mutex);
-	cpus_read_unlock();
 
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
