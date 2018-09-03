Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752B1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392E820843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 15:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 392E820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbeICTVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:21:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbeICTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:21:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83F0TPe3340564
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 08:00:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83F0TFm3340561;
        Mon, 3 Sep 2018 08:00:29 -0700
Date:   Mon, 3 Sep 2018 08:00:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-40181646db45fb72f46563a2f3b792adc5380710@git.kernel.org>
Cc:     tglx@linutronix.de, jgross@suse.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, jgross@suse.com, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180828074026.820-12-jgross@suse.com>
References: <20180828074026.820-12-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Move items in pv_info under
 PARAVIRT_XXL umbrella
Git-Commit-ID: 40181646db45fb72f46563a2f3b792adc5380710
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

Commit-ID:  40181646db45fb72f46563a2f3b792adc5380710
Gitweb:     https://git.kernel.org/tip/40181646db45fb72f46563a2f3b792adc5380710
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:22 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:36 +0200

x86/paravirt: Move items in pv_info under PARAVIRT_XXL umbrella

All items but name in pv_info are needed by Xen PV only. Define them
with CONFIG_PARAVIRT_XXL set only.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-12-jgross@suse.com

---
 arch/x86/include/asm/paravirt.h             | 2 ++
 arch/x86/include/asm/paravirt_types.h       | 2 ++
 arch/x86/include/asm/pgtable-3level_types.h | 2 +-
 arch/x86/include/asm/ptrace.h               | 2 +-
 arch/x86/include/asm/segment.h              | 2 +-
 arch/x86/kernel/paravirt.c                  | 2 ++
 6 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 2ba23e98c5cd..dbaedf1ed622 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -104,7 +104,9 @@ static inline void wbinvd(void)
 	PVOP_VCALL0(cpu.wbinvd);
 }
 
+#ifdef CONFIG_PARAVIRT_XXL
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
+#endif
 
 static inline u64 paravirt_read_msr(unsigned msr)
 {
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index cee91a337620..5bfed396c6b4 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -66,11 +66,13 @@ struct paravirt_callee_save {
 
 /* general info */
 struct pv_info {
+#ifdef CONFIG_PARAVIRT_XXL
 	unsigned int kernel_rpl;
 	int shared_kernel_pmd;
 
 #ifdef CONFIG_X86_64
 	u16 extra_user_64bit_cs;  /* __USER_CS if none */
+#endif
 #endif
 
 	const char *name;
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index 858358a82b14..33845d36897c 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -20,7 +20,7 @@ typedef union {
 } pte_t;
 #endif	/* !__ASSEMBLY__ */
 
-#ifdef CONFIG_PARAVIRT
+#ifdef CONFIG_PARAVIRT_XXL
 #define SHARED_KERNEL_PMD	((!static_cpu_has(X86_FEATURE_PTI) &&	\
 				 (pv_info.shared_kernel_pmd)))
 #else
diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6de1fd3d0097..250be50aa257 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -144,7 +144,7 @@ static inline int v8086_mode(struct pt_regs *regs)
 static inline bool user_64bit_mode(struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_64
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 	/*
 	 * On non-paravirt systems, this is the only long mode CPL 3
 	 * selector.  We do not allow long mode selectors in the LDT.
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c122d0d5..0ffbe9519e68 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -211,7 +211,7 @@
 
 #endif
 
-#ifndef CONFIG_PARAVIRT
+#ifndef CONFIG_PARAVIRT_XXL
 # define get_kernel_rpl()		0
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 0ca0576c88ff..ce0e28506942 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -293,12 +293,14 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 struct pv_info pv_info = {
 	.name = "bare hardware",
+#ifdef CONFIG_PARAVIRT_XXL
 	.kernel_rpl = 0,
 	.shared_kernel_pmd = 1,	/* Only used when CONFIG_X86_PAE is set */
 
 #ifdef CONFIG_X86_64
 	.extra_user_64bit_cs = __USER_CS,
 #endif
+#endif
 };
 
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
