Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBZIsC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:48:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40437 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeBZIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:48:01 -0500
Date: Mon, 26 Feb 2018 00:47:38 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-c46dacb75cd59a50a2380dcba5e7edf4fde86845@git.kernel.org>
Cc: tglx@linutronix.de, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, jgross@suse.com,
        fengguang.wu@intel.com, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de, jgross@suse.com,
        mingo@kernel.org, fengguang.wu@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20180221094232.23462-1-jgross@suse.com>
References: <20180221094232.23462-1-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/boot: Make the x86_init noop functions static
Git-Commit-ID: c46dacb75cd59a50a2380dcba5e7edf4fde86845
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

Commit-ID:  c46dacb75cd59a50a2380dcba5e7edf4fde86845
Gitweb:     https://git.kernel.org/tip/c46dacb75cd59a50a2380dcba5e7edf4fde86845
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Wed, 21 Feb 2018 10:42:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 26 Feb 2018 08:43:21 +0100

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
index 9e4e994a4836..b8cff22a8785 100644
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
