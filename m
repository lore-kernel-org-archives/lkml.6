Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB15C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989C52183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfAHROM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:14:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:55400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbfAHROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:14:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E5819AE19;
        Tue,  8 Jan 2019 17:14:09 +0000 (UTC)
Date:   Tue, 8 Jan 2019 18:14:01 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cache: Rename config option to CONFIG_X86_RESCTRL
Message-ID: <20190108171401.GC12235@zn.tnic>
References: <20181223124859.GA26860@zn.tnic>
 <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
 <20181226205616.GA4557@zn.tnic>
 <20181228124904.GC20003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228124904.GC20003@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will queue to x86/urgent if no issues.

---
From: Borislav Petkov <bp@suse.de>

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
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
