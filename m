Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2899084-1519909311-2-4021064936198798736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519909310; b=Dvf9lJHc9qxet+bM/lFBtMxwdLVg3gBojRn70gE536+UwpV
    D29ODPGBSat/8duAgwmI6LLIwjBH5XCc/Dr3H7KbyI32nLzIR6OX+YLaR2hMmDfG
    x5ueFVAs9L1cGBVXSU1rrBu6+IieJOmBDvKdk2VziL9JTrDMvULvDzi4R8/l7gTU
    SdWQV6wc6dAdcACFcf0P549dKBn6x3TCGkYLaDXksblhE0JO6OS1YNfhLHqRYPR7
    JCxfLmUHe9TmeexCTs0EUj30eTKqgOji6QNQBCoyeukX9Oz82J/08HHbPE9XU6DU
    1aMaAejiLzeCa4vpCZtvW/fEIa5RvK1AQYC2qjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909310;
    bh=3nJ4z4z9UJLDq0U9q5iOSITdh7PqyHF254/P1MMmfts=; b=gOqEOA30JEf6
    szm7NM7tqJ3cePMGJQfoHMKv5NmcLWBN05K/HX2DSy/3zWLpRuHbUsC3Vb0pvNf5
    cj/6vNUxLlLRY20IZcqKm5VEudyHshDSCG2mafEVH4UH6/1Zkno0LbepVW9xrGlS
    ST/X5aZqydyqhEpTXnlyI1UR6GggaAzf/r+ggoL61vQz5fx3N07veQ9PjkRn4sfj
    uzaNz/f60uME+lUmuJsdr/cKNC5VeKTpS1/7vH9pPStnl4Rw9wlrcHi7xOlMIyIy
    jc+8gqrElqcPANMS6A+tOLWUVJ/ciSjiHI+6soHcmuXrMkmDTcjex2MUEWOhUQPh
    MehhaKVKkQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Wg1LOuBR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XPnkpHWO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Wg1LOuBR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XPnkpHWO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030954AbeCANBP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:01:15 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39677 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030736AbeCANBN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 08:01:13 -0500
X-Google-Smtp-Source: AG47ELteRlcoq2nHWCbsLDfNIWZ6fQvI59GiQAtGm3qahkKl5lc7gZG1GS91+JpaePx71mTfOgEFsQ==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 44/45] arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support
Date: Thu,  1 Mar 2018 20:54:21 +0800
Message-Id: <1519908862-11425-45-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit b092201e0020 upstream.

Add the detection and runtime code for ARM_SMCCC_ARCH_WORKAROUND_1.
It is lovely. Really.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/bpi.S        | 20 ++++++++++++
 arch/arm64/kernel/cpu_errata.c | 72 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 89 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/bpi.S b/arch/arm64/kernel/bpi.S
index dec95bd..c72f261 100644
--- a/arch/arm64/kernel/bpi.S
+++ b/arch/arm64/kernel/bpi.S
@@ -17,6 +17,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/arm-smccc.h>
 
 .macro ventry target
 	.rept 31
@@ -77,3 +78,22 @@ ENTRY(__psci_hyp_bp_inval_start)
 	ldp	x0, x1, [sp, #(16 * 8)]
 	add	sp, sp, #(8 * 18)
 ENTRY(__psci_hyp_bp_inval_end)
+
+.macro smccc_workaround_1 inst
+	sub	sp, sp, #(8 * 4)
+	stp	x2, x3, [sp, #(8 * 0)]
+	stp	x0, x1, [sp, #(8 * 2)]
+	mov	w0, #ARM_SMCCC_ARCH_WORKAROUND_1
+	\inst	#0
+	ldp	x2, x3, [sp, #(8 * 0)]
+	ldp	x0, x1, [sp, #(8 * 2)]
+	add	sp, sp, #(8 * 4)
+.endm
+
+ENTRY(__smccc_workaround_1_smc_start)
+	smccc_workaround_1	smc
+ENTRY(__smccc_workaround_1_smc_end)
+
+ENTRY(__smccc_workaround_1_hvc_start)
+	smccc_workaround_1	hvc
+ENTRY(__smccc_workaround_1_hvc_end)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index f8810bf..9632319 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -54,6 +54,10 @@ DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
 
 #ifdef CONFIG_KVM
 extern char __psci_hyp_bp_inval_start[], __psci_hyp_bp_inval_end[];
+extern char __smccc_workaround_1_smc_start[];
+extern char __smccc_workaround_1_smc_end[];
+extern char __smccc_workaround_1_hvc_start[];
+extern char __smccc_workaround_1_hvc_end[];
 
 static void __copy_hyp_vect_bpi(int slot, const char *hyp_vecs_start,
 				const char *hyp_vecs_end)
@@ -96,8 +100,12 @@ static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 	spin_unlock(&bp_lock);
 }
 #else
-#define __psci_hyp_bp_inval_start	NULL
-#define __psci_hyp_bp_inval_end		NULL
+#define __psci_hyp_bp_inval_start		NULL
+#define __psci_hyp_bp_inval_end			NULL
+#define __smccc_workaround_1_smc_start		NULL
+#define __smccc_workaround_1_smc_end		NULL
+#define __smccc_workaround_1_hvc_start		NULL
+#define __smccc_workaround_1_hvc_end		NULL
 
 static void __install_bp_hardening_cb(bp_hardening_cb_t fn,
 				      const char *hyp_vecs_start,
@@ -124,17 +132,75 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 	__install_bp_hardening_cb(fn, hyp_vecs_start, hyp_vecs_end);
 }
 
+#include <uapi/linux/psci.h>
+#include <linux/arm-smccc.h>
 #include <linux/psci.h>
 
+static void call_smc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_smc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
+static void call_hvc_arch_workaround_1(void)
+{
+	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
+}
+
+static bool check_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
+{
+	bp_hardening_cb_t cb;
+	void *smccc_start, *smccc_end;
+	struct arm_smccc_res res;
+
+	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
+		return false;
+
+	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
+		return false;
+
+	switch (psci_ops.conduit) {
+	case PSCI_CONDUIT_HVC:
+		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+		if (res.a0)
+			return false;
+		cb = call_hvc_arch_workaround_1;
+		smccc_start = __smccc_workaround_1_hvc_start;
+		smccc_end = __smccc_workaround_1_hvc_end;
+		break;
+
+	case PSCI_CONDUIT_SMC:
+		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
+				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
+		if (res.a0)
+			return false;
+		cb = call_smc_arch_workaround_1;
+		smccc_start = __smccc_workaround_1_smc_start;
+		smccc_end = __smccc_workaround_1_smc_end;
+		break;
+
+	default:
+		return false;
+	}
+
+	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
+
+	return true;
+}
+
 static int enable_psci_bp_hardening(void *data)
 {
 	const struct arm64_cpu_capabilities *entry = data;
 
-	if (psci_ops.get_version)
+	if (psci_ops.get_version) {
+		if (check_smccc_arch_workaround_1(entry))
+			return 0;
+
 		install_bp_hardening_cb(entry,
 				       (bp_hardening_cb_t)psci_ops.get_version,
 				       __psci_hyp_bp_inval_start,
 				       __psci_hyp_bp_inval_end);
+	}
 
 	return 0;
 }
-- 
2.7.4
