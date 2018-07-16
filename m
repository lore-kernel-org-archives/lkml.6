Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3763EECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E359C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E359C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbeGPILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48404 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbeGPILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:03 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61756CA8;
        Mon, 16 Jul 2018 07:44:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <Yazen.Ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 32/43] x86/cpu: Add detection of AMD RAS Capabilities
Date:   Mon, 16 Jul 2018 09:36:37 +0200
Message-Id: <20180716073515.436640999@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <Yazen.Ghannam@amd.com>

commit 71faad43060d3d2040583635fbf7d1bdb3d04118 upstream

Add a new CPUID leaf to hold the contents of CPUID 0x80000007_EBX (RasCap).

Define bits that are currently in use:

 Bit 0: McaOverflowRecov
 Bit 1: SUCCOR
 Bit 3: ScalableMca

Signed-off-by: Yazen Ghannam <Yazen.Ghannam@amd.com>
[ Shorten comment. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/1462971509-3856-5-git-send-email-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h  |    1 +
 arch/x86/include/asm/cpufeatures.h |    7 ++++++-
 arch/x86/kernel/cpu/common.c       |   10 +++++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -27,6 +27,7 @@ enum cpuid_leafs
 	CPUID_6_EAX,
 	CPUID_8000_000A_EDX,
 	CPUID_7_ECX,
+	CPUID_8000_0007_EBX,
 };
 
 #ifdef CONFIG_X86_FEATURE_NAMES
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -12,7 +12,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS	17	/* N 32-bit words worth of info */
+#define NCAPINTS	18	/* N 32-bit words worth of info */
 #define NBUGINTS	1	/* N 32-bit bug flags */
 
 /*
@@ -280,6 +280,11 @@
 #define X86_FEATURE_PKU		(16*32+ 3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE	(16*32+ 4) /* OS Protection Keys Enable */
 
+/* AMD-defined CPU features, CPUID level 0x80000007 (ebx), word 17 */
+#define X86_FEATURE_OVERFLOW_RECOV (17*32+0) /* MCA overflow recovery support */
+#define X86_FEATURE_SUCCOR	(17*32+1) /* Uncorrectable error containment and recovery */
+#define X86_FEATURE_SMCA	(17*32+3) /* Scalable MCA */
+
 /*
  * BUG word(s)
  */
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -741,6 +741,13 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		}
 	}
 
+	if (c->extended_cpuid_level >= 0x80000007) {
+		cpuid(0x80000007, &eax, &ebx, &ecx, &edx);
+
+		c->x86_capability[CPUID_8000_0007_EBX] = ebx;
+		c->x86_power = edx;
+	}
+
 	if (c->extended_cpuid_level >= 0x80000008) {
 		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
 
@@ -753,9 +760,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_phys_bits = 36;
 #endif
 
-	if (c->extended_cpuid_level >= 0x80000007)
-		c->x86_power = cpuid_edx(0x80000007);
-
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 


