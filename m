Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeENMsf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:48:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44227 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbeENMsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:48:33 -0400
Date: Mon, 14 May 2018 05:47:20 -0700
From: tip-bot for Frederic Weisbecker <tipbot@zytor.com>
Message-ID: <tip-2e5c4632dcc0365a97c36817a368507e6a4c89b2@git.kernel.org>
Cc: bigeasy@linutronix.de, mingo@kernel.org, deller@gmx.de,
        heiko.carstens@de.ibm.com, jejb@parisc-linux.org, paulus@samba.org,
        benh@kernel.crashing.org, frederic@kernel.org, dalias@libc.org,
        peterz@infradead.org, tglx@linutronix.de, schwidefsky@de.ibm.com,
        hpa@zytor.com, mpe@ellerman.id.au, tony.luck@intel.com,
        fenghua.yu@intel.com, davem@davemloft.net,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ysato@users.sourceforge.jp
Reply-To: linux-kernel@vger.kernel.org, ysato@users.sourceforge.jp,
        davem@davemloft.net, fenghua.yu@intel.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        schwidefsky@de.ibm.com, hpa@zytor.com, mpe@ellerman.id.au,
        tony.luck@intel.com, peterz@infradead.org, jejb@parisc-linux.org,
        benh@kernel.crashing.org, paulus@samba.org, frederic@kernel.org,
        dalias@libc.org, deller@gmx.de, heiko.carstens@de.ibm.com,
        bigeasy@linutronix.de, mingo@kernel.org
In-Reply-To: <1525786706-22846-2-git-send-email-frederic@kernel.org>
References: <1525786706-22846-2-git-send-email-frederic@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] softirq/ia64: Convert local_softirq_pending() to
 per-cpu ops
Git-Commit-ID: 2e5c4632dcc0365a97c36817a368507e6a4c89b2
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

Commit-ID:  2e5c4632dcc0365a97c36817a368507e6a4c89b2
Gitweb:     https://git.kernel.org/tip/2e5c4632dcc0365a97c36817a368507e6a4c89b2
Author:     Frederic Weisbecker <frederic@kernel.org>
AuthorDate: Tue, 8 May 2018 15:38:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:25:26 +0200

softirq/ia64: Convert local_softirq_pending() to per-cpu ops

In order to consolidate and optimize generic softirq mask accesses, we
first need to convert architectures to use per-cpu operations when
possible.

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
Link: http://lkml.kernel.org/r/1525786706-22846-2-git-send-email-frederic@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/ia64/include/asm/hardirq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/hardirq.h b/arch/ia64/include/asm/hardirq.h
index bdc4669c71c3..22fae710e420 100644
--- a/arch/ia64/include/asm/hardirq.h
+++ b/arch/ia64/include/asm/hardirq.h
@@ -13,7 +13,7 @@
 
 #define __ARCH_IRQ_STAT	1
 
-#define local_softirq_pending()		(local_cpu_data->softirq_pending)
+#define local_softirq_pending()	(*this_cpu_ptr(&ia64_cpu_info.softirq_pending))
 
 #include <linux/threads.h>
 #include <linux/irq.h>
