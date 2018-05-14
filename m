Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753521AbeENMul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:50:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeENMuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:50:40 -0400
Date: Mon, 14 May 2018 05:49:53 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-a58bdf25b98bf765b4b732f2c56097ddcb9f2d5a@git.kernel.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        peterz@infradead.org, paulus@samba.org, fenghua.yu@intel.com,
        deller@gmx.de, ysato@users.sourceforge.jp, tglx@linutronix.de,
        mingo@kernel.org, dalias@libc.org, bigeasy@linutronix.de,
        mpe@ellerman.id.au, torvalds@linux-foundation.org, tony.luck@intel.com,
        jejb@parisc-linux.org, heiko.carstens@de.ibm.com,
        schwidefsky@de.ibm.com, hpa@zytor.com, benh@kernel.crashing.org,
        frederic@kernel.org
Reply-To: paulus@samba.org, ysato@users.sourceforge.jp, deller@gmx.de,
        tglx@linutronix.de, mingo@kernel.org, fenghua.yu@intel.com,
        peterz@infradead.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de, dalias@libc.org,
        torvalds@linux-foundation.org, tony.luck@intel.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, hpa@zytor.com, frederic@kernel.org,
        jejb@parisc-linux.org, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
In-Reply-To: <1525786706-22846-7-git-send-email-frederic@kernel.org>
References: <1525786706-22846-7-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/ia64: Switch to generic
 local_softirq_pending() implementation
Git-Commit-ID: a58bdf25b98bf765b4b732f2c56097ddcb9f2d5a
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

Commit-ID:  a58bdf25b98bf765b4b732f2c56097ddcb9f2d5a
Gitweb:     https://git.kernel.org/tip/a58bdf25b98bf765b4b732f2c56097ddcb9f2d5a
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:21 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:27 +0200

softirq/ia64: Switch to generic local_softirq_pending() implementation

Benefit from the generic softirq mask implementation that rely on per-CPU
mutators instead of working with raw operators on top of this_cpu_ptr().

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <jejb@parisc-linux.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rich Felker <dalias@libc.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: http://lkml.kernel.org/r/1525786706-22846-7-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/hardirq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index 22fae710e420..ccde7c2ba00f 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending()	(*this_cpu_ptr(&ia64_cpu_info.softirq_pending))
+#define local_softirq_pending_ref	ia64_cpu_info.softirq_pending
 
 #include <linux/threads.h>
 #include <linux/irq.h>
