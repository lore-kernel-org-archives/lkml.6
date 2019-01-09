Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4330621738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfAIKEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:04:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:32957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbfAIKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:04:14 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x09A3sbi3905848
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 9 Jan 2019 02:03:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x09A3s1r3905845;
        Wed, 9 Jan 2019 02:03:54 -0800
Date:   Wed, 9 Jan 2019 02:03:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-90802938f7e88045ace123e105e22e8c3e7f9c7e@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tony.luck@intel.com, torvalds@linux-foundation.org,
        reinette.chatre@intel.com, james.morse@arm.com, bp@suse.de,
        babu.moger@amd.com, fenghua.yu@intel.com
Reply-To: hpa@zytor.com, tony.luck@intel.com, james.morse@arm.com,
          torvalds@linux-foundation.org, reinette.chatre@intel.com,
          babu.moger@amd.com, fenghua.yu@intel.com, bp@suse.de,
          mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190108171401.GC12235@zn.tnic>
References: <20190108171401.GC12235@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cache: Rename config option to
 CONFIG_X86_RESCTRL
Git-Commit-ID: 90802938f7e88045ace123e105e22e8c3e7f9c7e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  90802938f7e88045ace123e105e22e8c3e7f9c7e
Gitweb:     https://git.kernel.org/tip/90802938f7e88045ace123e105e22e8c3e7f9c7e
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 8 Jan 2019 17:38:29 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 9 Jan 2019 10:29:03 +0100

x86/cache: Rename config option to CONFIG_X86_RESCTRL

CONFIG_RESCTRL is too generic. The final goal is to have a generic
option called like this which is selected by the arch-specific ones
CONFIG_X86_RESCTRL and CONFIG_ARM64_RESCTRL. The generic one will
cover the resctrl filesystem and other generic and shared bits of
functionality.

Signed-off-by: Borislav Petkov <bp@suse.de>
Suggested-by: Ingo Molnar <mingo@kernel.org>
Requested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/20190108171401.GC12235@zn.tnic
---
 Documentation/x86/resctrl_ui.txt     | 2 +-
 arch/x86/Kconfig                     | 2 +-
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 2 +-
 arch/x86/kernel/cpu/resctrl/Makefile | 4 ++--
 include/linux/sched.h                | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.txt
index d9aed8303984..e8e8d14d3c4e 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -9,7 +9,7 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
 
-This feature is enabled by the CONFIG_RESCTRL and the X86 /proc/cpuinfo
+This feature is enabled by the CONFIG_X86_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6185d4f33296..15af091611e2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -446,7 +446,7 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config RESCTRL
+config X86_RESCTRL
 	bool "Resource Control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 54990fe2a3ae..40ebddde6ac2 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
 
-#ifdef CONFIG_RESCTRL
+#ifdef CONFIG_X86_RESCTRL
 
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
 
 static inline void resctrl_sched_in(void) {}
 
-#endif /* CONFIG_RESCTRL */
+#endif /* CONFIG_X86_RESCTRL */
 
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index ac78f90aea56..b6fa0869f7aa 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
-obj-$(CONFIG_RESCTRL)			+= resctrl/
+obj-$(CONFIG_X86_RESCTRL)		+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 6895049ceef7..1cabe6fd8e11 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESCTRL)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_RESCTRL)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_X86_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89541d248893..224666226e87 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -995,7 +995,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_RESCTRL
+#ifdef CONFIG_X86_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
