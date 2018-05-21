Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937930-2-2663150347145542320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937929; b=S6i8IPIRB4VvYVwM7bVLTWLBkhlSUrJyUmyuyolQAIrjTBI6iO
    /L6lY5fuvftnRztG3HTXkhQn74GfAVQqJ23SgOd0H29mV6lCjy65ZqZ+5BCg0MTl
    z/zn18CvaEphbuboH3mQOI7UDCsUsTY9G7MUjMH3s8yGa6D+VsMPT3b9SMEBCmz+
    /RAx+df9gxLxqqIWDpUcTgRaia95FT4oMe/gEW+LKs6kX925GdRkHl3pUO6RBZhN
    3AjRg+YD/Dz+r8SNvQOU87cRX2pqFVcf/y8EWSyuqJ9rKj0+a6IzjvSHfGzFxX9g
    wp3kb02zCU92OKAWt5zrCqQzLwOHOWQ/SJHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937929; bh=VmV7hP+Ws6WMv85Spe/tmE5f7eOZ7o
    X0Ka0syEu5QlM=; b=ierl/DF+TacwfiIYXbyxsP3dNFuLMgO9W8xPMyBAL/HT9e
    03gblqHaN1mSExMpTvFK4rQVXRc3iYwoZZK6wFkDkbeE/hpaIoKrpRBAKpNLgBke
    Xg3p9wJC4qyiEgsPyyABcqivaWjWgzkObjkGO9xvhNU6XA6bIJIhFVHUu2w8MBzZ
    Q/0P9OSJQhsARloq36du4NOsiZ/+j45HTkJF7hIwKaZ/vhhE3v/HPrQLcK6i1dzt
    Dvqmf6BZgWQejuIH+6H6PHPVStbD2AH6clj8XsTiICJ2UjjG/0CHZMn1jJFq9phL
    6wfs6xQuozCItesmA5xvuwDwQNLKO7OVEg6t3NKw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=m46QDPH2 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=m46QDPH2 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNYoZ0n3rgw2Xy6xBg2+69D6soeEazPEAVQhix7MCqkN2umoYBD+aaIlXr/r/o5eoQ2ib0O4O2nTqEfpbe9fHZUW7wtomOKadWJUKs3ZAMZTJzP82aRj
    vCXnF4AFwkQhbhfP/TRqn1Uw8HKvHK+emzP6I+n7GrpFv7FICHARFnggqzm3zrx9toMHyS09AtI6HmhUzfc+r26iZfxW8PBpoCcJje3VbtW77SUXOar/9t+M
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=nXWYpeTi0pL7Hka7e4gA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932418AbeEUVZ0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754310AbeEUVZY (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:25:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 076/110] x86/process: Allow runtime control of Speculative Store Bypass
Date: Mon, 21 May 2018 23:12:13 +0200
Message-Id: <20180521210512.839843987@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 885f82bfbc6fefb6664ea27965c3ab9ac4194b8c upstream

The Speculative Store Bypass vulnerability can be mitigated with the
Reduced Data Speculation (RDS) feature. To allow finer grained control of
this eventually expensive mitigation a per task mitigation control is
required.

Add a new TIF_RDS flag and put it into the group of TIF flags which are
evaluated for mismatch in switch_to(). If these bits differ in the previous
and the next task, then the slow path function __switch_to_xtra() is
invoked. Implement the TIF_RDS dependent mitigation control in the slow
path.

If the prctl for controlling Speculative Store Bypass is disabled or no
task uses the prctl then there is no overhead in the switch_to() fast
path.

Update the KVM related speculation control functions to take TID_RDS into
account as well.

Based on a patch from Tim Chen. Completely rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h   |    3 ++-
 arch/x86/include/asm/spec-ctrl.h   |   17 +++++++++++++++++
 arch/x86/include/asm/thread_info.h |    4 +++-
 arch/x86/kernel/cpu/bugs.c         |   26 +++++++++++++++++++++-----
 arch/x86/kernel/process.c          |   22 ++++++++++++++++++++++
 5 files changed, 65 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -42,7 +42,8 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
-#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
+#define SPEC_CTRL_RDS_SHIFT		2	   /* Reduced Data Speculation bit */
+#define SPEC_CTRL_RDS			(1 << SPEC_CTRL_RDS_SHIFT)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_SPECCTRL_H_
 #define _ASM_X86_SPECCTRL_H_
 
+#include <linux/thread_info.h>
 #include <asm/nospec-branch.h>
 
 /*
@@ -18,4 +19,20 @@ extern void x86_spec_ctrl_restore_host(u
 extern u64 x86_amd_ls_cfg_base;
 extern u64 x86_amd_ls_cfg_rds_mask;
 
+/* The Intel SPEC CTRL MSR base value cache */
+extern u64 x86_spec_ctrl_base;
+
+static inline u64 rds_tif_to_spec_ctrl(u64 tifn)
+{
+	BUILD_BUG_ON(TIF_RDS < SPEC_CTRL_RDS_SHIFT);
+	return (tifn & _TIF_RDS) >> (TIF_RDS - SPEC_CTRL_RDS_SHIFT);
+}
+
+static inline u64 rds_tif_to_amd_ls_cfg(u64 tifn)
+{
+	return (tifn & _TIF_RDS) ? x86_amd_ls_cfg_rds_mask : 0ULL;
+}
+
+extern void speculative_store_bypass_update(void);
+
 #endif
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -79,6 +79,7 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
+#define TIF_RDS			5	/* Reduced data speculation */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
@@ -105,6 +106,7 @@ struct thread_info {
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
+#define _TIF_RDS		(1 << TIF_RDS)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
@@ -144,7 +146,7 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP|_TIF_RDS)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -33,7 +33,7 @@ static void __init ssb_select_mitigation
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
  * writes to SPEC_CTRL contain whatever reserved bits have been set.
  */
-static u64 __ro_after_init x86_spec_ctrl_base;
+u64 __ro_after_init x86_spec_ctrl_base;
 
 /*
  * The vendor and possibly platform specific bits which can be modified in
@@ -140,25 +140,41 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
 
 u64 x86_spec_ctrl_get_default(void)
 {
-	return x86_spec_ctrl_base;
+	u64 msrval = x86_spec_ctrl_base;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		msrval |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+	return msrval;
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
 void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
 		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
 
 void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
 {
+	u64 host = x86_spec_ctrl_base;
+
 	if (!boot_cpu_has(X86_FEATURE_IBRS))
 		return;
-	if (x86_spec_ctrl_base != guest_spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		host |= rds_tif_to_spec_ctrl(current_thread_info()->flags);
+
+	if (host != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, host);
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -38,6 +38,7 @@
 #include <asm/switch_to.h>
 #include <asm/desc.h>
 #include <asm/prctl.h>
+#include <asm/spec-ctrl.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
@@ -278,6 +279,24 @@ static inline void switch_to_bitmap(stru
 	}
 }
 
+static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
+{
+	u64 msr;
+
+	if (static_cpu_has(X86_FEATURE_AMD_RDS)) {
+		msr = x86_amd_ls_cfg_base | rds_tif_to_amd_ls_cfg(tifn);
+		wrmsrl(MSR_AMD64_LS_CFG, msr);
+	} else {
+		msr = x86_spec_ctrl_base | rds_tif_to_spec_ctrl(tifn);
+		wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+	}
+}
+
+void speculative_store_bypass_update(void)
+{
+	__speculative_store_bypass_update(current_thread_info()->flags);
+}
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
@@ -309,6 +328,9 @@ void __switch_to_xtra(struct task_struct
 
 	if ((tifp ^ tifn) & _TIF_NOCPUID)
 		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
+
+	if ((tifp ^ tifn) & _TIF_RDS)
+		__speculative_store_bypass_update(tifn);
 }
 
 /*
