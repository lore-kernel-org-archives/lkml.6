Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F2C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715BD208EC
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715BD208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934418AbeGJQCE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:02:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934062AbeGJQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:02:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6AG0tQH3196546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 10 Jul 2018 09:00:56 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6AG0tnN3196543;
        Tue, 10 Jul 2018 09:00:55 -0700
Date:   Tue, 10 Jul 2018 09:00:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        peterz@infradead.org, sfr@canb.auug.org.au,
        sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mpe@ellerman.id.au, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org, abdhalee@linux.vnet.ibm.com
Reply-To: mpe@ellerman.id.au, linux-next@vger.kernel.org,
          linuxppc-dev@lists.ozlabs.org, abdhalee@linux.vnet.ibm.com,
          tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
          peterz@infradead.org, mingo@kernel.org,
          sachinp@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          sfr@canb.auug.org.au
In-Reply-To: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
References: <20180710114210.GI2476@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] watchdog/softlockup: Fix the SOFTLOCKUP_DETECTOR=n
 build
Git-Commit-ID: aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e
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

Commit-ID:  aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e
Gitweb:     https://git.kernel.org/tip/aef92a8bed25d03b8f03ce499a56e8e8e5e2c05e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Tue, 10 Jul 2018 13:42:10 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 10 Jul 2018 17:56:22 +0200

watchdog/softlockup: Fix the SOFTLOCKUP_DETECTOR=n build

I got confused by all the various CONFIG options here about and
conflated CONFIG_LOCKUP_DETECTOR and CONFIG_SOFTLOCKUP_DETECTOR.

This results in a build failure for:

   CONFIG_LOCKUP_DETECTOR=y && CONFIG_SOFTLOCKUP_DETECTOR=n

As reported by Abdul.

Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-next <linux-next@vger.kernel.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: mpe <mpe@ellerman.id.au>
Cc: sachinp <sachinp@linux.vnet.ibm.com>
Cc: stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 9cf57731b63e ("watchdog/softlockup: Replace "watchdog/%u" threads with cpu_stop_work")
Link: http://lkml.kernel.org/r/20180710114210.GI2476@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/nmi.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 80664bbeca43..08f9247e9827 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -33,15 +33,10 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 #define sysctl_hardlockup_all_cpu_backtrace 0
 #endif /* !CONFIG_SMP */
 
-extern int lockup_detector_online_cpu(unsigned int cpu);
-extern int lockup_detector_offline_cpu(unsigned int cpu);
-
 #else /* CONFIG_LOCKUP_DETECTOR */
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
 static inline void lockup_detector_cleanup(void) { }
-#define lockup_detector_online_cpu	NULL
-#define lockup_detector_offline_cpu	NULL
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
@@ -50,12 +45,18 @@ extern void touch_softlockup_watchdog(void);
 extern void touch_softlockup_watchdog_sync(void);
 extern void touch_all_softlockup_watchdogs(void);
 extern unsigned int  softlockup_panic;
-#else
+
+extern int lockup_detector_online_cpu(unsigned int cpu);
+extern int lockup_detector_offline_cpu(unsigned int cpu);
+#else /* CONFIG_SOFTLOCKUP_DETECTOR */
 static inline void touch_softlockup_watchdog_sched(void) { }
 static inline void touch_softlockup_watchdog(void) { }
 static inline void touch_softlockup_watchdog_sync(void) { }
 static inline void touch_all_softlockup_watchdogs(void) { }
-#endif
+
+#define lockup_detector_online_cpu	NULL
+#define lockup_detector_offline_cpu	NULL
+#endif /* CONFIG_SOFTLOCKUP_DETECTOR */
 
 #ifdef CONFIG_DETECT_HUNG_TASK
 void reset_hung_task_detector(void);
