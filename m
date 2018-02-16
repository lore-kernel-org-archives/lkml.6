Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbeBPKwu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:52:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933125AbeBPKwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:52:49 -0500
Date: Fri, 16 Feb 2018 02:51:27 -0800
From: tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-d207af2eab3f8668b95ad02b21930481c42806fd@git.kernel.org>
Cc: mhkelley@outlook.com, torvalds@linux-foundation.org, mingo@kernel.org,
        fengguang.wu@intel.com, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: fengguang.wu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, mhkelley@outlook.com
In-Reply-To: <SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6PR1901MB2045.namprd19.prod.outlook.com>
References: <SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6PR1901MB2045.namprd19.prod.outlook.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:core/urgent] cpumask: Make for_each_cpu_wrap() available on UP
 as well
Git-Commit-ID: d207af2eab3f8668b95ad02b21930481c42806fd
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d207af2eab3f8668b95ad02b21930481c42806fd
Gitweb:     https://git.kernel.org/tip/d207af2eab3f8668b95ad02b21930481c42806fd
Author:     Michael Kelley <mhkelley@outlook.com>
AuthorDate: Wed, 14 Feb 2018 02:54:03 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:40:24 +0100

cpumask: Make for_each_cpu_wrap() available on UP as well

for_each_cpu_wrap() was originally added in the #else half of a
large "#if NR_CPUS == 1" statement, but was omitted in the #if
half.  This patch adds the missing #if half to prevent compile
errors when NR_CPUS is 1.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Michael Kelley <mhkelley@outlook.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kys@microsoft.com
Cc: martin.petersen@oracle.com
Cc: mikelley@microsoft.com
Fixes: c743f0a5c50f ("sched/fair, cpumask: Export for_each_cpu_wrap()")
Link: http://lkml.kernel.org/r/SN6PR1901MB2045F087F59450507D4FCC17CBF50@SN6PR1901MB2045.namprd19.prod.outlook.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/cpumask.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index d4a2a7d..bf53d89 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -170,6 +170,8 @@ static inline unsigned int cpumask_local_spread(unsigned int i, int node)
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_wrap(cpu, mask, start)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask, and)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 #else
