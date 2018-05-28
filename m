Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165897AbeE1OmU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 10:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161162AbeE1Kan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:30:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>,
        Michael Kelley <mhkelley@outlook.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kys@microsoft.com,
        martin.petersen@oracle.com, mikelley@microsoft.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 101/329] cpumask: Make for_each_cpu_wrap() available on UP as well
Date: Mon, 28 May 2018 12:00:30 +0200
Message-Id: <20180528100251.219971171@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhkelley@outlook.com>

[ Upstream commit d207af2eab3f8668b95ad02b21930481c42806fd ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/cpumask.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -164,6 +164,8 @@ static inline unsigned int cpumask_local
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
 #define for_each_cpu_not(cpu, mask)		\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
+#define for_each_cpu_wrap(cpu, mask, start)	\
+	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)(start))
 #define for_each_cpu_and(cpu, mask, and)	\
 	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
 #else
