Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeBUKj7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:39:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39271 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:39:56 -0500
Date: Wed, 21 Feb 2018 02:38:21 -0800
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-083c6eeab2cc13894618d188b854f2fc6b5b2303@git.kernel.org>
Cc: frederic@kernel.org, riel@redhat.com, cmetcalf@mellanox.com,
        torvalds@linux-foundation.org, cl@linux.com,
        paulmck@linux.vnet.ibm.com, kernellwp@gmail.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, efault@gmx.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, lcapitulino@redhat.com,
        mingo@kernel.org, kernellwp@gmail.com, efault@gmx.de, riel@redhat.com,
        cmetcalf@mellanox.com, frederic@kernel.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, cl@linux.com
In-Reply-To: <1519186649-3242-8-git-send-email-frederic@kernel.org>
References: <1519186649-3242-8-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/isolation: Update nohz documentation to
 explain tick offload
Git-Commit-ID: 083c6eeab2cc13894618d188b854f2fc6b5b2303
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

Commit-ID:  083c6eeab2cc13894618d188b854f2fc6b5b2303
Gitweb:     https://git.kernel.org/tip/083c6eeab2cc13894618d188b854f2fc6b5b2303
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Wed, 21 Feb 2018 05:17:29 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:49:10 +0100

sched/isolation: Update nohz documentation to explain tick offload

Update the documentation to reflect the 1Hz tick offload changes.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wanpeng Li <kernellwp@gmail.com>
Link: http://lkml.kernel.org/r/1519186649-3242-8-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1d1d53f..50b9837 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1766,6 +1766,17 @@
 
 			nohz
 			  Disable the tick when a single task runs.
+
+			  A residual 1Hz tick is offloaded to workqueues, which you
+			  need to affine to housekeeping through the global
+			  workqueue's affinity configured via the
+			  /sys/devices/virtual/workqueue/cpumask sysfs file, or
+			  by using the 'domain' flag described below.
+
+			  NOTE: by default the global workqueue runs on all CPUs,
+			  so to protect individual CPUs the 'cpumask' file has to
+			  be configured manually after bootup.
+
 			domain
 			  Isolate from the general SMP balancing and scheduling
 			  algorithms. Note that performing domain isolation this way
