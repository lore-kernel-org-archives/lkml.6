Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933315AbeBUKxC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:53:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51775 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeBUKw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:52:56 -0500
Date: Wed, 21 Feb 2018 02:52:16 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-a504ab7384eea0361e9292681f4a7b9d5010ccf2@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, fengguang.wu@intel.com,
        hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, jgross@suse.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
        jgross@suse.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fengguang.wu@intel.com, mingo@kernel.org
In-Reply-To: <20180221094232.23462-1-jgross@suse.com>
References: <20180221094232.23462-1-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Make the x86_init noop functions static
Git-Commit-ID: a504ab7384eea0361e9292681f4a7b9d5010ccf2
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

Commit-ID:  a504ab7384eea0361e9292681f4a7b9d5010ccf2
Gitweb:     https://git.kernel.org/tip/a504ab7384eea0361e9292681f4a7b9d5010ccf2
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed, 21 Feb 2018 10:42:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 11:22:37 +0100

x86/boot: Make the x86_init noop functions static

Make the noop functions in x86_init.c static in case they are used
locally only.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180221094232.23462-1-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/x86_init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 9e4e994..b8cff22 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -26,11 +26,11 @@
 
 void x86_init_noop(void) { }
 void __init x86_init_uint_noop(unsigned int unused) { }
-int __init iommu_init_noop(void) { return 0; }
-void iommu_shutdown_noop(void) { }
-bool __init bool_x86_init_noop(void) { return false; }
-void x86_op_int_noop(int cpu) { }
-u64 u64_x86_init_noop(void) { return 0; }
+static int __init iommu_init_noop(void) { return 0; }
+static void iommu_shutdown_noop(void) { }
+static bool __init bool_x86_init_noop(void) { return false; }
+static void x86_op_int_noop(int cpu) { }
+static u64 u64_x86_init_noop(void) { return 0; }
 
 /*
  * The platform setup functions are preset with the default functions
