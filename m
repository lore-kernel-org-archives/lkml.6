Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934473AbeBPKvZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 05:51:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45949 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933316AbeBPKvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 05:51:23 -0500
Date: Fri, 16 Feb 2018 02:50:58 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-b753a2b79a5bbad35dfaf8d3dba964727c30654a@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, douly.fnst@cn.fujitsu.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, douly.fnst@cn.fujitsu.com
In-Reply-To: <20180214062554.21020-1-douly.fnst@cn.fujitsu.com>
References: <20180214062554.21020-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Make setup_local_APIC() static
Git-Commit-ID: b753a2b79a5bbad35dfaf8d3dba964727c30654a
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

Commit-ID:  b753a2b79a5bbad35dfaf8d3dba964727c30654a
Gitweb:     https://git.kernel.org/tip/b753a2b79a5bbad35dfaf8d3dba964727c30654a
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 14 Feb 2018 14:25:54 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:39:11 +0100

x86/apic: Make setup_local_APIC() static

This function isn't used outside of apic.c, so let's mark it static.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bhe@redhat.com
Cc: ebiederm@xmission.com
Link: http://lkml.kernel.org/r/20180214062554.21020-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/apic.h | 1 -
 arch/x86/kernel/apic/apic.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 6e1990d..c6a3201 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -138,7 +138,6 @@ extern void lapic_shutdown(void);
 extern void sync_Arb_IDs(void);
 extern void init_bsp_APIC(void);
 extern void apic_intr_mode_init(void);
-extern void setup_local_APIC(void);
 extern void init_apic_mappings(void);
 void register_lapic_address(unsigned long address);
 extern void setup_boot_APIC_clock(void);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 25ddf02..871018d 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1414,7 +1414,7 @@ static void lapic_setup_esr(void)
  * Used to setup local APIC while initializing BSP or bringing up APs.
  * Always called with preemption disabled.
  */
-void setup_local_APIC(void)
+static void setup_local_APIC(void)
 {
 	int cpu = smp_processor_id();
 	unsigned int value, queued;
