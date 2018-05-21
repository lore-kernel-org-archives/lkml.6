Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1306010-1526937329-2-17364076742133883958
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
    1526937328; b=RtYsWELokFZLJi2BpGBBa6Z0FK0ibJVocN0T0lkuVGmyoxX+tY
    P02I9H52TyD5A/qQvmmGw0dD93Hlv8Pom+e/FMeGYL8D5LwRSmIS6wt7ZU5IG/3D
    m6qgMkHodiP/qIgvHVzwUUjtZyEwXjtLc4Yx/hMR559F6hVHunee5ZjbyflamtsS
    1m4B0aKWKR8vzZISSqmutTZmY6qgNq8kxzlvvTAv5VAPJb4S2hW6QQ2p6WNJgf41
    gaG/YdXsS/K9rP9JLrZ+22NzTDADSwTdL4df1hPOnIYJAspKhkI0NRUwCSNnDPFV
    H/ZRm2I1oUmpHijb7yU86NMH4NpOrlSX76bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937328; bh=oc1Awm88Hfjk9HFBnAzJIn3prOD2G4
    hULH94etgCdw0=; b=LcxPa06d90b35cYb54wzzoeSXNkYoccRd055YRbridbY/w
    fsm0WAuZyb2mgCcPNekbUii3xMyHTBRTg5iQpxLP/yGZd6K5cdBv5Qka/IceLCqX
    PdvP3565T52KbYyteX/wwaxFgrZuPjoGF3x63zbFWUbjY5xMpqUAVmdUKQpcV5Jl
    3p7FqfVvvAv1i5DatbPt7K9TCpLD2iqkepdy6gy098pHzsza55LE5kYQDc3awWQk
    Fd8EhGz5ntnAzD1txFQIttgdYRKNZzoGYfALdtYKHEBeMu4zXkXv63X0G7vKPEAM
    ooX1RlVpQU8CPyYUwB+nlT/3Ud11RNkgQWZRZt8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ID9ReVhN x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ID9ReVhN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFwipv7DHkCb0skPMHzi0QZxDkP4MpxYTBdFKBaKnIzTC05xF6QiLIBhYHsg55iEylbJhxIGHifle6/7ZDX1e0EZ2gHi2Ay4YltOfax4xtN2qhhLv5g+
    wbQhMnao/3ZCp8Clb8Xfh728SPg4yTJMeN9ZZc1u9ogvIYRFjXd4C213G+bH9M3+zRvhWjuu0o/vc3PyM3OXGe82wecEoh6N+ne9zj+BbKUcK4Yl1WB0BZzG
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=pBOR-ozoAAAA:8
    a=ag1SF4gXAAAA:8 a=1H-uOaH5oox9kN_oUl8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeEUVP0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeEUVPW (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:15:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Masters <jcm@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 39/87] x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
Date: Mon, 21 May 2018 23:11:15 +0200
Message-Id: <20180521210424.131361504@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 1b86883ccb8d5d9506529d42dbe1a5257cb30b18 upstream

The 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to all
the other bits as reserved. The Intel SDM glossary defines reserved as
implementation specific - aka unknown.

As such at bootup this must be taken it into account and proper masking for
the bits in use applied.

A copy of this document is available at
https://bugzilla.kernel.org/show_bug.cgi?id=199511

[ tglx: Made x86_spec_ctrl_base __ro_after_init ]

Suggested-by: Jon Masters <jcm@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/nospec-branch.h |   24 ++++++++++++++++++++----
 arch/x86/kernel/cpu/bugs.c           |   28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -217,6 +217,17 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
+/*
+ * The Intel specification for the SPEC_CTRL MSR requires that we
+ * preserve any already set reserved bits at boot time (e.g. for
+ * future additions that this kernel is not currently aware of).
+ * We then set any additional mitigation bits that we want
+ * ourselves and always use this as the base for SPEC_CTRL.
+ * We also use this when handling guest entry/exit as below.
+ */
+extern void x86_spec_ctrl_set(u64);
+extern u64 x86_spec_ctrl_get_default(void);
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
@@ -254,8 +265,9 @@ void alternative_msr_write(unsigned int
 
 static inline void indirect_branch_prediction_barrier(void)
 {
-	alternative_msr_write(MSR_IA32_PRED_CMD, PRED_CMD_IBPB,
-			      X86_FEATURE_USE_IBPB);
+	u64 val = PRED_CMD_IBPB;
+
+	alternative_msr_write(MSR_IA32_PRED_CMD, val, X86_FEATURE_USE_IBPB);
 }
 
 /*
@@ -266,14 +278,18 @@ static inline void indirect_branch_predi
  */
 #define firmware_restrict_branch_speculation_start()			\
 do {									\
+	u64 val = x86_spec_ctrl_get_default() | SPEC_CTRL_IBRS;		\
+									\
 	preempt_disable();						\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS,	\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 } while (0)
 
 #define firmware_restrict_branch_speculation_end()			\
 do {									\
-	alternative_msr_write(MSR_IA32_SPEC_CTRL, 0,			\
+	u64 val = x86_spec_ctrl_get_default();				\
+									\
+	alternative_msr_write(MSR_IA32_SPEC_CTRL, val,			\
 			      X86_FEATURE_USE_IBRS_FW);			\
 	preempt_enable();						\
 } while (0)
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -27,6 +27,12 @@
 
 static void __init spectre_v2_select_mitigation(void);
 
+/*
+ * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
+ * writes to SPEC_CTRL contain whatever reserved bits have been set.
+ */
+static u64 __ro_after_init x86_spec_ctrl_base;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -36,6 +42,13 @@ void __init check_bugs(void)
 		print_cpu_info(&boot_cpu_data);
 	}
 
+	/*
+	 * Read the SPEC_CTRL MSR to account for reserved bits which may
+	 * have unknown values.
+	 */
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
@@ -94,6 +107,21 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
+void x86_spec_ctrl_set(u64 val)
+{
+	if (val & ~SPEC_CTRL_IBRS)
+		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
+	else
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
+
+u64 x86_spec_ctrl_get_default(void)
+{
+	return x86_spec_ctrl_base;
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
