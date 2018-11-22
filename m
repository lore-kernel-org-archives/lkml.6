Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F18C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806B4206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806B4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407618AbeKWI3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:29:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404865AbeKWI3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:29:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLjxjJ3947060
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:45:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLjrAh3947055;
        Thu, 22 Nov 2018 13:45:53 -0800
Date:   Thu, 22 Nov 2018 13:45:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-fa7d949337ccad32c76740c88e0e0351c349053b@git.kernel.org>
Cc:     jroedel@suse.de, dwmw2@infradead.org,
        kirill.shutemov@linux.intel.com, arnd@arndb.de,
        pbonzini@redhat.com, gregkh@linuxfoundation.org, luto@kernel.org,
        xiaochen.shen@intel.com, puwen@hygon.cn, jpoimboe@redhat.com,
        peterz@infradead.org, mchehab+samsung@kernel.org,
        fenghua.yu@intel.com, qianyue.zj@alibaba-inc.com,
        davem@davemloft.net, chang.seok.bae@intel.com, rafael@kernel.org,
        vkuznets@redhat.com, suravee.suthikulpanit@amd.com,
        Babu.Moger@amd.com, rian@alum.mit.edu, sherry.hurwitz@amd.com,
        linux-doc@vger.kernel.org, bp@suse.de, reinette.chatre@intel.com,
        jannh@google.com, babu.moger@amd.com, hpa@zytor.com,
        dima@arista.com, tglx@linutronix.de, tony.luck@intel.com,
        Thomas.Lendacky@amd.com, pombredanne@nexb.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org, mingo@redhat.com,
        kstewart@linuxfoundation.org, akpm@linux-foundation.org,
        brijesh.singh@amd.com
Reply-To: davem@davemloft.net, qianyue.zj@alibaba-inc.com,
          suravee.suthikulpanit@amd.com, vkuznets@redhat.com,
          chang.seok.bae@intel.com, rafael@kernel.org, puwen@hygon.cn,
          mchehab+samsung@kernel.org, peterz@infradead.org,
          jpoimboe@redhat.com, fenghua.yu@intel.com,
          xiaochen.shen@intel.com, luto@kernel.org, jroedel@suse.de,
          dwmw2@infradead.org, arnd@arndb.de,
          kirill.shutemov@linux.intel.com, pbonzini@redhat.com,
          gregkh@linuxfoundation.org, pombredanne@nexb.com,
          mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          corbet@lwn.net, akpm@linux-foundation.org,
          kstewart@linuxfoundation.org, brijesh.singh@amd.com,
          dima@arista.com, tglx@linutronix.de, tony.luck@intel.com,
          Thomas.Lendacky@amd.com, reinette.chatre@intel.com, bp@suse.de,
          jannh@google.com, hpa@zytor.com, babu.moger@amd.com,
          rian@alum.mit.edu, Babu.Moger@amd.com, sherry.hurwitz@amd.com,
          linux-doc@vger.kernel.org
In-Reply-To: <20181121202811.4492-2-babu.moger@amd.com>
References: <20181121202811.4492-2-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Rename and move rdt files to a
 separate directory
Git-Commit-ID: fa7d949337ccad32c76740c88e0e0351c349053b
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

Commit-ID:  fa7d949337ccad32c76740c88e0e0351c349053b
Gitweb:     https://git.kernel.org/tip/fa7d949337ccad32c76740c88e0e0351c349053b
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:25 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:18 +0100

x86/resctrl: Rename and move rdt files to a separate directory

New generation of AMD processors add support for RDT (or QOS) features.
Together, these features will be called RESCTRL. With more than one
vendors supporting these features, it seems more appropriate to rename
these files.

Create a new directory with the name 'resctrl' and move all the
intel_rdt files to the new directory. This way all the resctrl related
code resides inside one directory.

 [ bp: Add SPDX identifier to the Makefile ]

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: David Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Pu Wen <puwen@hygon.cn>
Cc: <qianyue.zj@alibaba-inc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Rian Hunter <rian@alum.mit.edu>
Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: <xiaochen.shen@intel.com>
Link: https://lkml.kernel.org/r/20181121202811.4492-2-babu.moger@amd.com
---
 arch/x86/include/asm/{intel_rdt_sched.h => resctrl_sched.h}         | 0
 arch/x86/kernel/cpu/Makefile                                        | 5 +----
 arch/x86/kernel/cpu/resctrl/Makefile                                | 4 ++++
 arch/x86/kernel/cpu/{intel_rdt.c => resctrl/core.c}                 | 4 ++--
 .../kernel/cpu/{intel_rdt_ctrlmondata.c => resctrl/ctrlmondata.c}   | 2 +-
 arch/x86/kernel/cpu/{intel_rdt.h => resctrl/internal.h}             | 6 +++---
 arch/x86/kernel/cpu/{intel_rdt_monitor.c => resctrl/monitor.c}      | 2 +-
 .../kernel/cpu/{intel_rdt_pseudo_lock.c => resctrl/pseudo_lock.c}   | 6 +++---
 .../{intel_rdt_pseudo_lock_event.h => resctrl/pseudo_lock_event.h}  | 2 +-
 arch/x86/kernel/cpu/{intel_rdt_rdtgroup.c => resctrl/rdtgroup.c}    | 4 ++--
 arch/x86/kernel/process_32.c                                        | 2 +-
 arch/x86/kernel/process_64.c                                        | 2 +-
 12 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/intel_rdt_sched.h b/arch/x86/include/asm/resctrl_sched.h
similarity index 100%
rename from arch/x86/include/asm/intel_rdt_sched.h
rename to arch/x86/include/asm/resctrl_sched.h
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 1f5d2291c31e..8501d16dd642 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -36,13 +36,10 @@ obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 
-obj-$(CONFIG_INTEL_RDT)	+= intel_rdt.o intel_rdt_rdtgroup.o intel_rdt_monitor.o
-obj-$(CONFIG_INTEL_RDT)	+= intel_rdt_ctrlmondata.o intel_rdt_pseudo_lock.o
-CFLAGS_intel_rdt_pseudo_lock.o = -I$(src)
-
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
+obj-$(CONFIG_INTEL_RDT)			+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
new file mode 100644
index 000000000000..fa3cb91d7849
--- /dev/null
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_INTEL_RDT)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_INTEL_RDT)	+= ctrlmondata.o pseudo_lock.o
+CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/resctrl/core.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.c
rename to arch/x86/kernel/cpu/resctrl/core.c
index 44272b7107ad..27c4316bb691 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -30,8 +30,8 @@
 #include <linux/cpuhotplug.h>
 
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "internal.h"
 
 #define MBA_IS_LINEAR	0x4
 #define MBA_MAX_MBPS	U32_MAX
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
rename to arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 27937458c231..407d2179bfcb 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -26,7 +26,7 @@
 #include <linux/kernfs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
-#include "intel_rdt.h"
+#include "internal.h"
 
 /*
  * Check whether MBA bandwidth percentage value is correct. The value is
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/resctrl/internal.h
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt.h
rename to arch/x86/kernel/cpu/resctrl/internal.h
index 3736f6dc9545..1b36709591d8 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_INTEL_RDT_H
-#define _ASM_X86_INTEL_RDT_H
+#ifndef _ASM_X86_RESCTRL_INTERNAL_H
+#define _ASM_X86_RESCTRL_INTERNAL_H
 
 #include <linux/sched.h>
 #include <linux/kernfs.h>
@@ -568,4 +568,4 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 
-#endif /* _ASM_X86_INTEL_RDT_H */
+#endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_monitor.c
rename to arch/x86/kernel/cpu/resctrl/monitor.c
index b0f3aed76b75..d492d4c0e8cc 100644
--- a/arch/x86/kernel/cpu/intel_rdt_monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -26,7 +26,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <asm/cpu_device_id.h>
-#include "intel_rdt.h"
+#include "internal.h"
 
 #define MSR_IA32_QM_CTR		0x0c8e
 #define MSR_IA32_QM_EVTSEL		0x0c8d
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
rename to arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 815b4e92522c..ffb7ebe69d33 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -24,14 +24,14 @@
 
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/perf_event.h>
 
 #include "../../events/perf_event.h" /* For X86_CONFIG() */
-#include "intel_rdt.h"
+#include "internal.h"
 
 #define CREATE_TRACE_POINTS
-#include "intel_rdt_pseudo_lock_event.h"
+#include "pseudo_lock_event.h"
 
 /*
  * MSR_MISC_FEATURE_CONTROL register enables the modification of hardware
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h b/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
similarity index 95%
rename from arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
rename to arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
index 2c041e6d9f05..428ebbd4270b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock_event.h
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock_event.h
@@ -39,5 +39,5 @@ TRACE_EVENT(pseudo_lock_l3,
 
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE intel_rdt_pseudo_lock_event
+#define TRACE_INCLUDE_FILE pseudo_lock_event
 #include <trace/define_trace.h>
diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
similarity index 99%
rename from arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
rename to arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f27b8115ffa2..f5a76ca43f0f 100644
--- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -35,8 +35,8 @@
 
 #include <uapi/linux/magic.h>
 
-#include <asm/intel_rdt_sched.h>
-#include "intel_rdt.h"
+#include <asm/resctrl_sched.h>
+#include "internal.h"
 
 DEFINE_STATIC_KEY_FALSE(rdt_enable_key);
 DEFINE_STATIC_KEY_FALSE(rdt_mon_enable_key);
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5046a3c9dec2..d16207e7d1e5 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -56,7 +56,7 @@
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/proto.h>
 
 void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 0e0b4288a4b2..8f23562687fb 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -52,7 +52,7 @@
 #include <asm/switch_to.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/vdso.h>
-#include <asm/intel_rdt_sched.h>
+#include <asm/resctrl_sched.h>
 #include <asm/unistd.h>
 #include <asm/fsgsbase.h>
 #ifdef CONFIG_IA32_EMULATION
