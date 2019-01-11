Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6C0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 152E820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 07:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547190902;
	bh=GHFRCYyqFvRLHYSTeVdolZ0etbz9jI6UlJjw1Mhteoc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=c5JC8s+EE4WvijzVm75XodTJayD2zd4jrrdkLLXUV3ApTgcm39KYL3UFAvLIKI2Ry
	 NM1yrOnCa6pwX++NZD51LEPbGDRO6srHAbHKLBHC5XS5DsWOKoUVKTg0ejknOuKNyu
	 IGPE6SX1FQpOISPGyVnUv+mIIxc8LZCXrUiuzoT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbfAKHPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 02:15:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfAKHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 02:15:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so13964304wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 23:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=+/evsO+oyLZmAF4duXTWCKwVWox824mdZ0LQMsYqzgY=;
        b=JbZMwr6IuLgT9qizwkpQbiNEDqeETXIcsEhw/G0obgm5cbqeY+WEJ8xz5bIbGAqCPF
         5I9N8ICdtqLInbF1rlKHZl0Bhv4FcDDE+sM7BSSTduHId0+Ie+pyQtf1z979KqQiEUvQ
         hBpX8vBJ5Rs1CbhKUWwVgjgE2iAGYX2QjGbhfSB6bs5Jsm5y0dhXWMqu8lDevVzjiUON
         7JnPzvvDVEBEU8AvO8ocHDXBXxawMUZqGLqmvjCdy69DoTYF3S5LO6Wt45IW/w9lZyDk
         ZDmdNMIfhySRu7V9HdVkHCyRxpOISdSFiqmXM17DN8Z4wTvl1FbE+rsKmsjz/smJauCU
         4NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=+/evsO+oyLZmAF4duXTWCKwVWox824mdZ0LQMsYqzgY=;
        b=fNEkTUuiLxd4Rjr24+OKQ8J00hbUAI9Pmkp94jHVK+d7jqx7vnD/N42CXSMFa2sx4c
         uzrGlEJuHfS/ZqMchFSbix3t3JpX2vQPU07OsbaOnB2p6W33y0F5NbLqeIt8tTUMt3Qo
         GTkBBG9nOfKTf1cddFG2UpMPALT8pTM4G+/jC96GyU07pe8woeY74NDJxg/6Rz/Y7N1b
         F252ODYV22EeBlNv04FT6F1CBdVRfd6eOxd5jhbcze0hh6qgygUmCggwz1Gjp/TULJJ8
         M8S+3vNHujyNEYC2k6qfE16Hhw3sWBAGZOdlll3huryi2oNU6pM97cHPZcO4N8iML3HY
         czIA==
X-Gm-Message-State: AJcUukd2koNuVYrlMDOnj/N2yES1CviqR1k2rXCyZ8HzWGnt9qj9LfOU
        MONkLAqjMNJOZ3h4VrhF/wY=
X-Google-Smtp-Source: ALg8bN6kfDHZz4PjL1HY1Ua7cZiqKGS9K/7p+s5sYWgsb1rm1gOrP8bWLkohcMilE1JHAdxcPfroBw==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr12754039wrq.133.1547190896951;
        Thu, 10 Jan 2019 23:14:56 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q9sm81659720wrp.0.2019.01.10.23.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 23:14:56 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:14:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20190111071454.GA26394@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: e4f358916d528d479c3c12bd2fd03f2d5a576380 x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE

A 32-bit build fix, CONFIG_RETPOLINE fixes and rename CONFIG_RESCTRL to 
CONFIG_X86_RESCTRL.

  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  include/linux/module.h             # e4f358916d52: x86, modpost: Replace last r
  samples/seccomp/Makefile           # a77d1d196bc6: samples/seccomp: Fix 32-bit 
  scripts/mod/modpost.c              # e4f358916d52: x86, modpost: Replace last r

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/cache: Rename config option to CONFIG_X86_RESCTRL

Tycho Andersen (1):
      samples/seccomp: Fix 32-bit build

WANG Chao (1):
      x86, modpost: Replace last remnants of RETPOLINE with CONFIG_RETPOLINE


 Documentation/x86/resctrl_ui.txt     | 2 +-
 arch/x86/Kconfig                     | 2 +-
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 2 +-
 arch/x86/kernel/cpu/bugs.c           | 2 +-
 arch/x86/kernel/cpu/resctrl/Makefile | 4 ++--
 include/linux/compiler-gcc.h         | 2 +-
 include/linux/module.h               | 2 +-
 include/linux/sched.h                | 2 +-
 samples/seccomp/Makefile             | 1 +
 scripts/mod/modpost.c                | 2 +-
 11 files changed, 13 insertions(+), 12 deletions(-)

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
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 8654b8b0c848..1de0f4170178 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -215,7 +215,7 @@ static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 static bool spectre_v2_bad_module;
 
 bool retpoline_module_ok(bool has_retpoline)
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
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 5776da43da97..dd8268f5f5f0 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -68,7 +68,7 @@
  */
 #define uninitialized_var(x) x = x
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 #define __noretpoline __attribute__((__indirect_branch__("keep")))
 #endif
 
diff --git a/include/linux/module.h b/include/linux/module.h
index 9a21fe3509af..8fa38d3e7538 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -828,7 +828,7 @@ static inline void module_bug_finalize(const Elf_Ehdr *hdr,
 static inline void module_bug_cleanup(struct module *mod) {}
 #endif	/* CONFIG_GENERIC_BUG */
 
-#ifdef RETPOLINE
+#ifdef CONFIG_RETPOLINE
 extern bool retpoline_module_ok(bool has_retpoline);
 #else
 static inline bool retpoline_module_ok(bool has_retpoline)
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
diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 4920903c8009..fb43a814d4c0 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -34,6 +34,7 @@ HOSTCFLAGS_bpf-direct.o += $(MFLAG)
 HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
+HOSTCFLAGS_user-trap.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0de2fb236640..26bf886bd168 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2185,7 +2185,7 @@ static void add_intree_flag(struct buffer *b, int is_intree)
 /* Cannot check for assembler */
 static void add_retpoline(struct buffer *b)
 {
-	buf_printf(b, "\n#ifdef RETPOLINE\n");
+	buf_printf(b, "\n#ifdef CONFIG_RETPOLINE\n");
 	buf_printf(b, "MODULE_INFO(retpoline, \"Y\");\n");
 	buf_printf(b, "#endif\n");
 }
