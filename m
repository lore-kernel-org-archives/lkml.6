Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5C8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CA92174C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CA92174C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732630AbeHCMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:35:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39855 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbeHCMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:35:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AdtTe3854010
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:39:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AdsfT3854007;
        Fri, 3 Aug 2018 03:39:54 -0700
Date:   Fri, 3 Aug 2018 03:39:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Feiner <tipbot@zytor.com>
Message-ID: <tip-301d328a6f8b53bb86c5ecf72db7bc178bcf1999@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dwmw@amazon.co.uk, pfeiner@google.com, hpa@zytor.com,
        pshier@google.com, jmattson@google.com, konrad.wilk@oracle.com,
        bp@suse.de
Reply-To: bp@suse.de, pshier@google.com, jmattson@google.com,
          konrad.wilk@oracle.com, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          pfeiner@google.com, dwmw@amazon.co.uk
In-Reply-To: <20180801180657.138051-1-pshier@google.com>
References: <20180801180657.138051-1-pshier@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Add EPT_AD feature bit
Git-Commit-ID: 301d328a6f8b53bb86c5ecf72db7bc178bcf1999
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

Commit-ID:  301d328a6f8b53bb86c5ecf72db7bc178bcf1999
Gitweb:     https://git.kernel.org/tip/301d328a6f8b53bb86c5ecf72db7bc178bcf1999
Author:     Peter Feiner <pfeiner@google.com>
AuthorDate: Wed, 1 Aug 2018 11:06:57 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:36:23 +0200

x86/cpufeatures: Add EPT_AD feature bit

Some Intel processors have an EPT feature whereby the accessed & dirty bits
in EPT entries can be updated by HW. MSR IA32_VMX_EPT_VPID_CAP exposes the
presence of this capability.

There is no point in trying to use that new feature bit in the VMX code as
VMX needs to read the MSR anyway to access other bits, but having the
feature bit for EPT_AD in place helps virtualization management as it
exposes "ept_ad" in /proc/cpuinfo/$proc/flags if the feature is present.

[ tglx: Amended changelog ]

Signed-off-by: Peter Feiner <pfeiner@google.com>
Signed-off-by: Peter Shier <pshier@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/20180801180657.138051-1-pshier@google.com

---
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/intel.c        | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 5701f5cecd31..7fff98fa5855 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -229,7 +229,7 @@
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
-
+#define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index eb75564f2d25..c050cd6066af 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -465,14 +465,17 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 #define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
 #define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
 #define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+#define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
 
 	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+	u32 msr_vpid_cap, msr_ept_cap;
 
 	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
 	clear_cpu_cap(c, X86_FEATURE_VNMI);
 	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
 	clear_cpu_cap(c, X86_FEATURE_EPT);
 	clear_cpu_cap(c, X86_FEATURE_VPID);
+	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
 
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
 	msr_ctl = vmx_msr_high | vmx_msr_low;
@@ -487,8 +490,13 @@ static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
 		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
 		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
 			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT) {
 			set_cpu_cap(c, X86_FEATURE_EPT);
+			rdmsr(MSR_IA32_VMX_EPT_VPID_CAP,
+			      msr_ept_cap, msr_vpid_cap);
+			if (msr_ept_cap & x86_VMX_FEATURE_EPT_CAP_AD)
+				set_cpu_cap(c, X86_FEATURE_EPT_AD);
+		}
 		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
 			set_cpu_cap(c, X86_FEATURE_VPID);
 	}
