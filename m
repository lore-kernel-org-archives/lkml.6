Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A176CC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C7B218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 09:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfBBJqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 04:46:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfBBJqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 04:46:54 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x129jxp33715541
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 2 Feb 2019 01:45:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x129juko3715527;
        Sat, 2 Feb 2019 01:45:56 -0800
Date:   Sat, 2 Feb 2019 01:45:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Johannes Weiner <tipbot@zytor.com>
Message-ID: <tip-e6d429313ea5c776d2e76b4494df69102e6b7115@git.kernel.org>
Cc:     mingo@redhat.com, fenghua.yu@intel.com,
        kirill.shutemov@linux.intel.com, reinette.chatre@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hannes@cmpxchg.org, james.morse@arm.com,
        puwen@hygon.cn, corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        bp@suse.de, mingo@kernel.org, Babu.Moger@amd.com,
        tglx@linutronix.de
Reply-To: Babu.Moger@amd.com, tglx@linutronix.de, x86@kernel.org,
          mingo@kernel.org, bp@suse.de, puwen@hygon.cn, hpa@zytor.com,
          corbet@lwn.net, peterz@infradead.org, james.morse@arm.com,
          hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
          tony.luck@intel.com, reinette.chatre@intel.com,
          kirill.shutemov@linux.intel.com, fenghua.yu@intel.com,
          mingo@redhat.com
In-Reply-To: <20190130195621.GA30653@cmpxchg.org>
References: <20190130195621.GA30653@cmpxchg.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/resctrl: Avoid confusion over the new
 X86_RESCTRL config
Git-Commit-ID: e6d429313ea5c776d2e76b4494df69102e6b7115
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

Commit-ID:  e6d429313ea5c776d2e76b4494df69102e6b7115
Gitweb:     https://git.kernel.org/tip/e6d429313ea5c776d2e76b4494df69102e6b7115
Author:     Johannes Weiner <hannes@cmpxchg.org>
AuthorDate: Tue, 29 Jan 2019 17:44:36 -0500
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 2 Feb 2019 10:34:52 +0100

x86/resctrl: Avoid confusion over the new X86_RESCTRL config

"Resource Control" is a very broad term for this CPU feature, and a term
that is also associated with containers, cgroups etc. This can easily
cause confusion.

Make the user prompt more specific. Match the config symbol name.

 [ bp: In the future, the corresponding ARM arch-specific code will be
   under ARM_CPU_RESCTRL and the arch-agnostic bits will be carved out
   under the CPU_RESCTRL umbrella symbol. ]

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Babu Moger <Babu.Moger@amd.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Morse <james.morse@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: linux-doc@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190130195621.GA30653@cmpxchg.org
---
 Documentation/x86/resctrl_ui.txt     | 2 +-
 arch/x86/Kconfig                     | 6 +++---
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 2 +-
 arch/x86/kernel/cpu/resctrl/Makefile | 4 ++--
 include/linux/sched.h                | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.txt
index e8e8d14d3c4e..c1f95b59e14d 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -9,7 +9,7 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
 
-This feature is enabled by the CONFIG_X86_RESCTRL and the x86 /proc/cpuinfo
+This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..68261430fe6e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -446,12 +446,12 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config X86_RESCTRL
-	bool "Resource Control support"
+config X86_CPU_RESCTRL
+	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Enable Resource Control support.
+	  Enable x86 CPU resource control support.
 
 	  Provide support for the allocation and monitoring of system resources
 	  usage by the CPU.
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 40ebddde6ac2..f6b7fe2833cc 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
 
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
 
 static inline void resctrl_sched_in(void) {}
 
-#endif /* CONFIG_X86_RESCTRL */
+#endif /* CONFIG_X86_CPU_RESCTRL */
 
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index b6fa0869f7aa..cfd24f9f7614 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
-obj-$(CONFIG_X86_RESCTRL)		+= resctrl/
+obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 1cabe6fd8e11..4a06c37b9cf1 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_X86_RESCTRL)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_X86_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 224666226e87..8c328b14c424 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -995,7 +995,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
