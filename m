Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6FC04E87
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEEB021564
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 17:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEEB021564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeI0X0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 19:26:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41999 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeI0X0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 19:26:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8RH7DI5102241
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 27 Sep 2018 10:07:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8RH7DVU102238;
        Thu, 27 Sep 2018 10:07:13 -0700
Date:   Thu, 27 Sep 2018 10:07:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pu Wen <tipbot@zytor.com>
Message-ID: <tip-b8f4abb652146ddde04ab6e2a80e8cde27ff4470@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, puwen@hygon.cn
Reply-To: bp@suse.de, hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, puwen@hygon.cn
In-Reply-To: <654dd12876149fba9561698eaf9fc15d030301f8.1537533369.git.puwen@hygon.cn>
References: <654dd12876149fba9561698eaf9fc15d030301f8.1537533369.git.puwen@hygon.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/kvm: Add Hygon Dhyana support to KVM
Git-Commit-ID: b8f4abb652146ddde04ab6e2a80e8cde27ff4470
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

Commit-ID:  b8f4abb652146ddde04ab6e2a80e8cde27ff4470
Gitweb:     https://git.kernel.org/tip/b8f4abb652146ddde04ab6e2a80e8cde27ff4470
Author:     Pu Wen <puwen@hygon.cn>
AuthorDate: Sun, 23 Sep 2018 17:36:31 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 27 Sep 2018 18:28:59 +0200

x86/kvm: Add Hygon Dhyana support to KVM

The Hygon Dhyana CPU has the SVM feature as AMD family 17h does.
So enable the KVM infrastructure support to it.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Cc: pbonzini@redhat.com
Cc: rkrcmar@redhat.com
Cc: tglx@linutronix.de
Cc: mingo@redhat.com
Cc: hpa@zytor.com
Cc: x86@kernel.org
Cc: thomas.lendacky@amd.com
Cc: kvm@vger.kernel.org
Link: https://lkml.kernel.org/r/654dd12876149fba9561698eaf9fc15d030301f8.1537533369.git.puwen@hygon.cn
---
 arch/x86/include/asm/kvm_emulate.h |  4 ++++
 arch/x86/include/asm/virtext.h     |  5 +++--
 arch/x86/kvm/emulate.c             | 11 ++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
index 0f82cd91cd3c..93c4bf598fb0 100644
--- a/arch/x86/include/asm/kvm_emulate.h
+++ b/arch/x86/include/asm/kvm_emulate.h
@@ -364,6 +364,10 @@ struct x86_emulate_ctxt {
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_ecx 0x21726574
 #define X86EMUL_CPUID_VENDOR_AMDisbetterI_edx 0x74656273
 
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ebx 0x6f677948
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_ecx 0x656e6975
+#define X86EMUL_CPUID_VENDOR_HygonGenuine_edx 0x6e65476e
+
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ebx 0x756e6547
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_ecx 0x6c65746e
 #define X86EMUL_CPUID_VENDOR_GenuineIntel_edx 0x49656e69
diff --git a/arch/x86/include/asm/virtext.h b/arch/x86/include/asm/virtext.h
index 0116b2ee9e64..e05e0d309244 100644
--- a/arch/x86/include/asm/virtext.h
+++ b/arch/x86/include/asm/virtext.h
@@ -83,9 +83,10 @@ static inline void cpu_emergency_vmxoff(void)
  */
 static inline int cpu_has_svm(const char **msg)
 {
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
 		if (msg)
-			*msg = "not amd";
+			*msg = "not amd or hygon";
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 106482da6388..34edf198708f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -2711,7 +2711,16 @@ static bool em_syscall_is_enabled(struct x86_emulate_ctxt *ctxt)
 	    edx == X86EMUL_CPUID_VENDOR_AMDisbetterI_edx)
 		return true;
 
-	/* default: (not Intel, not AMD), apply Intel's stricter rules... */
+	/* Hygon ("HygonGenuine") */
+	if (ebx == X86EMUL_CPUID_VENDOR_HygonGenuine_ebx &&
+	    ecx == X86EMUL_CPUID_VENDOR_HygonGenuine_ecx &&
+	    edx == X86EMUL_CPUID_VENDOR_HygonGenuine_edx)
+		return true;
+
+	/*
+	 * default: (not Intel, not AMD, not Hygon), apply Intel's
+	 * stricter rules...
+	 */
 	return false;
 }
 
