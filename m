Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D85C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1751B222A7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549991726;
	bh=6ZcZDrtcGXwMAiGV0Zs9oTG2Fpc//1Xokmij2kFklO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tIxj+Fy80icwOOP/H+TbD8DXLyPBEEKkVA7IG2+4Szyhp1t63cFUobEL8y33VcQK/
	 MSUaa4N5TG/INeGP2ws2KdhEdjl3hS8KRMdDwn7yIk1zAHtzVyDKApDOknKagY8RMy
	 clGmUBI0v4GTuItRog6Pcekh8dEfhL51Z/JygcGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfBLRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbfBLRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:15:22 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54627222A0;
        Tue, 12 Feb 2019 17:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549991722;
        bh=6ZcZDrtcGXwMAiGV0Zs9oTG2Fpc//1Xokmij2kFklO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHHD87NPhD+uSqSFdiokFiPjuZSIgs2mw5h2sWEXPzIAcLWMUzY1SE8NZi7xHlnOr
         J4qOgRhapWi79pYJpZQkau6g03mHsXblJA3yXxxPRoUzhrxemE+WmNBrb0p1F/2X5T
         WkgzuMjcF/WKVFBUe+Bjp8O2xBv8CaLqKO7ivH1M=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 16/32] softirq: Normalize softirq_pending naming scheme
Date:   Tue, 12 Feb 2019 18:14:07 +0100
Message-Id: <20190212171423.8308-17-frederic@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171423.8308-1-frederic@kernel.org>
References: <20190212171423.8308-1-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>

Use the subsystem as the prefix to name the __softirq_data accessors.
They are going to be extended and want a more greppable and standard
naming sheme.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/s390/include/asm/hardirq.h |  4 ++--
 include/linux/interrupt.h       | 24 ++++++++++++------------
 kernel/softirq.c                |  4 ++--
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index e26325fe287d..3103680487cf 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -14,8 +14,8 @@
 #include <asm/lowcore.h>
 
 #define local_softirq_pending() (S390_lowcore.softirq_data)
-#define set_softirq_pending(x) (S390_lowcore.softirq_data = (x))
-#define or_softirq_pending(x)  (S390_lowcore.softirq_data |= (x))
+#define softirq_pending_set(x) (S390_lowcore.softirq_data = (x))
+#define softirq_pending_or(x)  (S390_lowcore.softirq_data |= (x))
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_HAS_DO_SOFTIRQ
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a32bdd9bb103..a5dec926531b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -447,18 +447,6 @@ extern bool force_irqthreads;
 #define force_irqthreads	(0)
 #endif
 
-#ifndef local_softirq_pending
-
-#ifndef local_softirq_data_ref
-#define local_softirq_data_ref irq_stat.__softirq_data
-#endif
-
-#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
-#define set_softirq_pending(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
-#define or_softirq_pending(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
-
-#endif /* local_softirq_pending */
-
 /* Some architectures might implement lazy enabling/disabling of
  * interrupts. In some cases, such as stop_machine, we might want
  * to ensure that after a local_irq_disable(), interrupts have
@@ -485,6 +473,18 @@ enum
 
 #define SOFTIRQ_STOP_IDLE_MASK (~(1 << RCU_SOFTIRQ))
 
+#ifndef local_softirq_pending
+
+#ifndef local_softirq_data_ref
+#define local_softirq_data_ref irq_stat.__softirq_data
+#endif
+
+#define local_softirq_pending()	(__this_cpu_read(local_softirq_data_ref))
+#define softirq_pending_set(x)	(__this_cpu_write(local_softirq_data_ref, (x)))
+#define softirq_pending_or(x)	(__this_cpu_or(local_softirq_data_ref, (x)))
+
+#endif /* local_softirq_pending */
+
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
  */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 2dcaef813acb..2137c54baf98 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -268,7 +268,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 
 restart:
 	/* Reset the pending bitmask before enabling irqs */
-	set_softirq_pending(0);
+	softirq_pending_set(0);
 
 	local_irq_enable();
 
@@ -449,7 +449,7 @@ void raise_softirq(unsigned int nr)
 void __raise_softirq_irqoff(unsigned int nr)
 {
 	trace_softirq_raise(nr);
-	or_softirq_pending(1UL << nr);
+	softirq_pending_or(1UL << nr);
 }
 
 void open_softirq(int nr, void (*action)(struct softirq_action *))
-- 
2.17.1

