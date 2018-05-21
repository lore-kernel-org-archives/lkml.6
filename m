Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937686-2-16910394019292392134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937685; b=TNJ1lGg96LT9zUfjJeLXqd52qMCPwWp76w3U8I/bcF7ZWfmni6
    iPy4eufnXdcowRN5iMIEfVnm9w8K/Avsp0ydnSvL4j/bQTuQ12mkWcHA/2ltydb2
    Odu0/UUbYcuneaUmuIkfKJ/UXCkbnGPPRO9uSULqWwWkrH+IRlkh0UF2C9YxUn0l
    BO5AmictnXOu+PiALA8CWYqYOLB9+ld04SzsWiM3RWVbYsztbnVwsJkVJab8SuyI
    uUaTgCl9Eke1in5PdTamBusF4BheL5DiFjBixNRvj0UBTp4kly0I6KRDf6QTiEvx
    hdEN+bF0cmDsOKlspxF5hYplD38tC7sDhUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937685; bh=ck3lepnvsiHQMVizoRtKCXD3t9+vdm
    IBi0F/5Q8QfP0=; b=X79atlfcexDMKVhb9xcdaovWjAKhMiKP70LHg50djTy+/D
    1jVsc4g/fJZSa6p9VZSUIOxh55zfmSPgUZ4wOm1QWGbzIEeBBbQmw+KO7xjRnsDD
    f8shXDLFwKoc0cGoF9PlIenr7WJGw7SyrBhaw4KBJSYbgoRAL8cmVJbqipCyGzFk
    os9S+PoCTBgsVN1O1UCnl7ZQe6477DeJrzfDSh4kRDxtW3G2718wnmqiZ+VbJ7VH
    egfdAPR7vKMgrXIqcHsLdzC7MPkz2l84b72optN5rrJLNaZW2ZEuakiXTw5pesH9
    rju57F/VJ9yl6hg1LyvybZLSXMufTQ5ViqbvfBYw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=x4/TRv7N x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=x4/TRv7N x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGh6VDd0lDbh7F06XTm3sKHO10hpJxm1cxZSAUTKaqngEN9hxlWeat1pvaaHtqWnqPYc5wO7zJpTw81VtXnECy1UVctaPJfa8hd+wXgblSyEt+2jIR/i
    MozuXeN/KJTie9dV3Ujrd45v3F3m/UT0C5NtL2sCaPk3dbH5OxQ/8vSfUDLH+kMDormofJi75mD/xIP9D+XN6y0GJfJ0B+N4UVEOlyihkurWfkAHbokhvp+4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=ag1SF4gXAAAA:8 a=0EWn0uG7xdJw7G4bnVsA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeEUVVU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeEUVVS (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:21:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 82/95] x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
Date: Mon, 21 May 2018 23:12:12 +0200
Message-Id: <20180521210502.330264479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 7eb8956a7fec3c1f0abc2a5517dada99ccc8a961 upstream

The availability of the SPEC_CTRL MSR is enumerated by a CPUID bit on
Intel and implied by IBRS or STIBP support on AMD. That's just confusing
and in case an AMD CPU has IBRS not supported because the underlying
problem has been fixed but has another bit valid in the SPEC_CTRL MSR,
the thing falls apart.

Add a synthetic feature bit X86_FEATURE_MSR_SPEC_CTRL to denote the
availability on both Intel and AMD.

While at it replace the boot_cpu_has() checks with static_cpu_has() where
possible. This prevents late microcode loading from exposing SPEC_CTRL, but
late loading is already very limited as it does not reevaluate the
mitigation options and other bits and pieces. Having static_cpu_has() is
the simplest and least fragile solution.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    2 ++
 arch/x86/kernel/cpu/bugs.c         |   18 +++++++++++-------
 arch/x86/kernel/cpu/common.c       |    9 +++++++--
 arch/x86/kernel/cpu/intel.c        |    1 +
 4 files changed, 21 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -206,6 +206,8 @@
 #define X86_FEATURE_RETPOLINE_AMD	( 7*32+13) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
 
+#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -64,7 +64,7 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	/* Select the proper spectre mitigation before patching alternatives */
@@ -145,7 +145,7 @@ u64 x86_spec_ctrl_get_default(void)
 {
 	u64 msrval = x86_spec_ctrl_base;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 	return msrval;
 }
@@ -155,10 +155,12 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -170,10 +172,12 @@ void x86_spec_ctrl_restore_host(u64 gues
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -631,7 +635,7 @@ int arch_prctl_spec_ctrl_get(struct task
 
 void x86_spec_ctrl_setup_ap(void)
 {
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -737,19 +737,24 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
 
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_AMD_IBRS))
+	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 
-	if (cpu_has(c, X86_FEATURE_AMD_STIBP))
+	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
 		set_cpu_cap(c, X86_FEATURE_STIBP);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -188,6 +188,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_IBPB);
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
 	}
