Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37D2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EA420818
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 21:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EA420818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407696AbeKWIcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 03:32:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeKWIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 03:32:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMLnvYE3947717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 13:49:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMLnvc13947713;
        Thu, 22 Nov 2018 13:49:57 -0800
Date:   Thu, 22 Nov 2018 13:49:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Babu Moger <tipbot@zytor.com>
Message-ID: <tip-6fe07ce35e8ad870ba1cf82e0481e0fc0f526eff@git.kernel.org>
Cc:     pbonzini@redhat.com, jroedel@suse.de, Babu.Moger@amd.com,
        gregkh@linuxfoundation.org, jannh@google.com,
        qianyue.zj@alibaba-inc.com, puwen@hygon.cn, jpoimboe@redhat.com,
        Thomas.Lendacky@amd.com, linux-doc@vger.kernel.org,
        pombredanne@nexb.com, mingo@kernel.org, hpa@zytor.com,
        tony.luck@intel.com, luto@kernel.org, davem@davemloft.net,
        sherry.hurwitz@amd.com, peterz@infradead.org,
        xiaochen.shen@intel.com, dima@arista.com, chang.seok.bae@intel.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, reinette.chatre@intel.com,
        mchehab+samsung@kernel.org, rafael@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, kstewart@linuxfoundation.org,
        babu.moger@amd.com, rian@alum.mit.edu, dwmw2@infradead.org,
        corbet@lwn.net, brijesh.singh@amd.com, bp@suse.de, arnd@arndb.de,
        vkuznets@redhat.com, mingo@redhat.com,
        kirill.shutemov@linux.intel.com
Reply-To: Babu.Moger@amd.com, jroedel@suse.de, pbonzini@redhat.com,
          jpoimboe@redhat.com, puwen@hygon.cn, qianyue.zj@alibaba-inc.com,
          gregkh@linuxfoundation.org, jannh@google.com,
          pombredanne@nexb.com, Thomas.Lendacky@amd.com,
          linux-doc@vger.kernel.org, luto@kernel.org,
          sherry.hurwitz@amd.com, davem@davemloft.net,
          peterz@infradead.org, tony.luck@intel.com, mingo@kernel.org,
          hpa@zytor.com, suravee.suthikulpanit@amd.com,
          reinette.chatre@intel.com, linux-kernel@vger.kernel.org,
          dima@arista.com, chang.seok.bae@intel.com, fenghua.yu@intel.com,
          xiaochen.shen@intel.com, akpm@linux-foundation.org,
          tglx@linutronix.de, rafael@kernel.org,
          mchehab+samsung@kernel.org, arnd@arndb.de, bp@suse.de,
          corbet@lwn.net, brijesh.singh@amd.com, dwmw2@infradead.org,
          rian@alum.mit.edu, babu.moger@amd.com,
          kstewart@linuxfoundation.org, kirill.shutemov@linux.intel.com,
          mingo@redhat.com, vkuznets@redhat.com
In-Reply-To: <20181121202811.4492-9-babu.moger@amd.com>
References: <20181121202811.4492-9-babu.moger@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/resctrl: Rename the config option INTEL_RDT to
 RESCTRL
Git-Commit-ID: 6fe07ce35e8ad870ba1cf82e0481e0fc0f526eff
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

Commit-ID:  6fe07ce35e8ad870ba1cf82e0481e0fc0f526eff
Gitweb:     https://git.kernel.org/tip/6fe07ce35e8ad870ba1cf82e0481e0fc0f526eff
Author:     Babu Moger <Babu.Moger@amd.com>
AuthorDate: Wed, 21 Nov 2018 20:28:39 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 22 Nov 2018 20:16:19 +0100

x86/resctrl: Rename the config option INTEL_RDT to RESCTRL

The resource control feature is supported by both Intel and AMD. So,
rename CONFIG_INTEL_RDT to the vendor-neutral CONFIG_RESCTRL.

Now CONFIG_RESCTRL will be used for both Intel and AMD to enable
Resource Control support. Update the texts in config and condition
accordingly.

 [ bp: Simplify Kconfig text. ]

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
Link: https://lkml.kernel.org/r/20181121202811.4492-9-babu.moger@amd.com
---
 arch/x86/Kconfig                     | 22 +++++++++++++++-------
 arch/x86/include/asm/resctrl_sched.h |  4 ++--
 arch/x86/kernel/cpu/Makefile         |  2 +-
 arch/x86/kernel/cpu/resctrl/Makefile |  4 ++--
 include/linux/sched.h                |  2 +-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d734f3c8234..2d0577e805d2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -448,15 +448,23 @@ config RETPOLINE
 	  code are eliminated. Since this includes the syscall entry path,
 	  it is not entirely pointless.
 
-config INTEL_RDT
-	bool "Intel Resource Director Technology support"
-	depends on X86 && CPU_SUP_INTEL
+config RESCTRL
+	bool "Resource Control support"
+	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Select to enable resource allocation and monitoring which are
-	  sub-features of Intel Resource Director Technology(RDT). More
-	  information about RDT can be found in the Intel x86
-	  Architecture Software Developer Manual.
+	  Enable Resource Control support.
+
+	  Provide support for the allocation and monitoring of system resources
+	  usage by the CPU.
+
+	  Intel calls this Intel Resource Director Technology
+	  (Intel(R) RDT). More information about RDT can be found in the
+	  Intel x86 Architecture Software Developer Manual.
+
+	  AMD calls this AMD Platform Quality of Service (AMD QoS).
+	  More information about AMD QoS can be found in the AMD64 Technology
+	  Platform Quality of Service Extensions manual.
 
 	  Say N if unsure.
 
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 6e082697a613..54990fe2a3ae 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
 
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
 
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
 
 static inline void resctrl_sched_in(void) {}
 
-#endif /* CONFIG_INTEL_RDT */
+#endif /* CONFIG_RESCTRL */
 
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 8501d16dd642..dc4acaa1549d 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_X86_MCE)			+= mcheck/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
-obj-$(CONFIG_INTEL_RDT)			+= resctrl/
+obj-$(CONFIG_RESCTRL)			+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index fa3cb91d7849..6895049ceef7 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_INTEL_RDT)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_INTEL_RDT)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_RESCTRL)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..7952dfba2c76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -993,7 +993,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_INTEL_RDT
+#ifdef CONFIG_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
