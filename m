Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835047-2-7516173041869068552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519835046; b=kbzsq1OKSlDyNpDhbYlbtwdaghXwz3UWmkkjVaEIpPAS97X
    KuyD4pzDE19++nl6x8nAMGFV5ONDpZQWQ7viPZ+V45VueYtT9HvM8pSx/bwXoPda
    iEoUM0zKH9k84lMdHBsEb2e4SP35p9nEeM3fI98V/XCFCZOYrkQ2i4Png5eFme6F
    JgBVRR3BsfLOjigY87bfminN7xcSCn3gcepaTYG8+RLvMX7TyeLgMwXhAdfP6lPm
    9B1HxCy0HyKkSE7Gs7Fj2SQ5IRBTrP/idx/pIwK4hnTsHu+gAmCB0Pyvqttjc4Y1
    GyLoEC2ht4tYoA6uzq+My76Js7nzaRTi4DVWNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835046; bh=6wvXrxdPAO7ff/fGK77
    9wataCw/j3pyzFvLElM7t1m0=; b=KvUUsiEVFrEUhwJBXnOtIfdUGsb0PiNqIpe
    8hoJ7QNHerPWTMR6FJj9Uwn/ZY1+pnRdX0uwjLpYUy3qU4VXsy92gMwlJDOdmQua
    H4Yulit10p+l3Luqj7CD0Wy3eTuwu307L4Mdf5yHqM0r9kvOb2G6R3d5yzNICuXP
    XhiDvHvnAGc//kWeWjSxoMsVvVDnKYAxgzcawN0qeDvhDI0vvrknGpQz5cCw2JDC
    +2ORSRBuu20HIeMjxO1U5su5iydvyZ/k9iNuE8VXZeDAOydkSh9mMWJv1J3mhK4Z
    kIYAjGPiUWq2Daz+Qu6q7qgJwPtXdGnqqjeJbn+B2gXFWVwUwiQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeB1QXv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:23:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35385 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935062AbeB1QUq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:46 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.170473068@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 103/254] MIPS: ptrace: Prevent writes to read-only
 FCSR bits
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit abf378be49f38c4d3e23581d3df3fa9f1b1b11d2 upstream.

Correct the cases missed with commit 9b26616c8d9d ("MIPS: Respect the
ISA level in FCSR handling") and prevent writes to read-only FCSR bits
there.

This in particular applies to FP context initialisation where any IEEE
754-2008 bits preset by `mips_set_personality_nan' are cleared before
the relevant ptrace(2) call takes effect and the PTRACE_POKEUSR request
addressing FPC_CSR where no masking of read-only FCSR bits is done.

Remove the FCSR clearing from FP context initialisation then and unify
PTRACE_POKEUSR/FPC_CSR and PTRACE_SETFPREGS handling, by factoring out
code from `ptrace_setfpregs' and calling it from both places.

This mostly matters to soft float configurations where the emulator can
be switched this way to a mode which should not be accessible and cannot
be set with the CTC1 instruction.  With hard float configurations any
effect is transient anyway as read-only bits will retain their values at
the time the FP context is restored.

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13239/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: There is no mips_set_personality_nan(), so make
 init_fp_ctx() copy the initial value of FCSR31]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -57,8 +57,7 @@ static void init_fp_ctx(struct task_stru
 	/* Begin with data registers set to all 1s... */
 	memset(&target->thread.fpu.fpr, ~0, sizeof(target->thread.fpu.fpr));
 
-	/* ...and FCSR zeroed */
-	target->thread.fpu.fcr31 = 0;
+	target->thread.fpu.fcr31 = boot_cpu_data.fpu_csr31;
 
 	/*
 	 * Record that the target has "used" math, such that the context
@@ -80,6 +79,22 @@ void ptrace_disable(struct task_struct *
 }
 
 /*
+ * Poke at FCSR according to its mask.  Don't set the cause bits as
+ * this is currently not handled correctly in FP context restoration
+ * and will cause an oops if a corresponding enable bit is set.
+ */
+static void ptrace_setfcr31(struct task_struct *child, u32 value)
+{
+	u32 fcr31;
+	u32 mask;
+
+	value &= ~FPU_CSR_ALL_X;
+	fcr31 = child->thread.fpu.fcr31;
+	mask = boot_cpu_data.fpu_msk31;
+	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+}
+
+/*
  * Read a general register set.	 We always use the 64-bit format, even
  * for 32-bit kernels and for 32-bit processes on a 64-bit kernel.
  * Registers are sign extended to fill the available space.
@@ -159,9 +174,7 @@ int ptrace_setfpregs(struct task_struct
 {
 	union fpureg *fregs;
 	u64 fpr_val;
-	u32 fcr31;
 	u32 value;
-	u32 mask;
 	int i;
 
 	if (!access_ok(VERIFY_READ, data, 33 * 8))
@@ -176,10 +189,7 @@ int ptrace_setfpregs(struct task_struct
 	}
 
 	__get_user(value, data + 64);
-	value &= ~FPU_CSR_ALL_X;
-	fcr31 = child->thread.fpu.fcr31;
-	mask = boot_cpu_data.fpu_msk31;
-	child->thread.fpu.fcr31 = (value & ~mask) | (fcr31 & mask);
+	ptrace_setfcr31(child, value);
 
 	/* FIR may not be written.  */
 
@@ -739,7 +749,7 @@ long arch_ptrace(struct task_struct *chi
 			break;
 #endif
 		case FPC_CSR:
-			child->thread.fpu.fcr31 = data & ~FPU_CSR_ALL_X;
+			ptrace_setfcr31(child, data);
 			break;
 		case DSP_BASE ... DSP_BASE + 5: {
 			dspreg_t *dregs;
