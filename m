Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeBHSAS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:00:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752702AbeBHSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:00:15 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510DF217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=frederic@kernel.org
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Wanpeng Li <kernellwp@gmail.com>,
        Mike Galbraith <efault@gmx.de>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 6/6] sched/isolation: Tick offload documentation
Date: Thu,  8 Feb 2018 18:59:39 +0100
Message-Id: <1518112779-30196-7-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518112779-30196-1-git-send-email-frederic@kernel.org>
References: <1518112779-30196-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the documentation to reflect the 1Hz tick offload changes.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wanpeng Li <kernellwp@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 39ac9d4..c851e41 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1762,7 +1762,11 @@
 			specified in the flag list (default: domain):
 
 			nohz
-			  Disable the tick when a single task runs.
+			  Disable the tick when a single task runs. A residual 1Hz
+			  tick is offloaded to workqueues that you need to affine
+			  to housekeeping through the sysfs file
+			  /sys/devices/virtual/workqueue/cpumask or using the below
+			  domain flag.
 			domain
 			  Isolate from the general SMP balancing and scheduling
 			  algorithms. Note that performing domain isolation this way
-- 
2.7.4
