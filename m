Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2898263-1519909515-5-380585072406398813
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
    t=1519909514; b=uyT+9TPa8Ny1Ys1YSe+esdu0MRmfscw4O9OUm+1sbuKgAi4
    vowON77gXi3cVPBzaX3JiPz4o/0ofgXvBi2GL8+Dztzq7n+fga4xlTo7UGmXRZFO
    gJtWE2vSqhJXz8oI6phKOebsPhQnJrcev8bPgZugErPd1tXzTHss+uOfD7KJYpHc
    om1zHew/QbJtQCk4u4pPml4UuLun6eaAWYHcqiTNk7WoiiO/1QmQNuUqVirTqAGM
    XUFmI8LrzAaSxqrb9v15CZg3jqdol5WSjD5E1kcqV9Kc4h0OL5oxo0UswV+TcsPx
    UHbSvNvIRs9ZWwGP+au8L5XDswuo8minCwFv04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519909514;
    bh=NZ2qtdpybzZDjgWGLMAPxPIrjxBvuuwvSlz1/mXg4z0=; b=sU6hbjbSpUGx
    Si3HxkqhnZw5ejnoWMKz1CrfmFqKySATa6EF8gFwW5ThD5el2wD1mYTtIRu4Gyy0
    P3VKNAUDtzPl/YZZvS70QiadBkuTlDQym6Dc5+wZv+SS7Iw3SYi1A9D5uORWg0QQ
    M5RpldtCWSW5PmmATPt1W1ZLFjauv9Up9eEQspU33Hfx597oiCLybiggvwXBEhEm
    Hhp0q0y4Ske90eIUUlBkEHriuwyi/C9Ecqhy7LyIHLmfBekqKwQpi8sboLtYPPfX
    +hiIiwmJYZlgZbtJWq5GJ7/H+Z66WGNgWHC3ndSV4UdLuQE753fYBCYSnfff9MiK
    XzLfAP0crg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HRBfzix6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g9ZMxkfu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=HRBfzix6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g9ZMxkfu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbeCANE3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 08:04:29 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47083 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030752AbeCAM6x (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Mar 2018 07:58:53 -0500
X-Google-Smtp-Source: AG47ELtrUVevA+U8jJo2/4wlgSw/treYCtTMy+wJ12JcqE4tDPXxow8MyP5Baq7jfd16SplCjfrN9g==
From: Alex Shi <alex.shi@linaro.org>
To: Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Alex Shi <alex.shi@linaro.org>
Subject: [PATCH 25/45] arm64: KVM: Use per-CPU vector when BP hardening is enabled
Date: Thu,  1 Mar 2018 20:54:02 +0800
Message-Id: <1519908862-11425-26-git-send-email-alex.shi@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Marc Zyngier <marc.zyngier@arm.com>

commit 6840bdd73d07 upstream

Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/include/asm/kvm_mmu.h   | 10 ++++++++++
 arch/arm/kvm/arm.c               |  8 +++++++-
 arch/arm64/include/asm/kvm_mmu.h | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/switch.c      |  2 +-
 4 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index a58bbaa..d10e362 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -223,6 +223,16 @@ static inline unsigned int kvm_get_vmid_bits(void)
 	return 8;
 }
 
+static inline void *kvm_get_hyp_vector(void)
+{
+	return kvm_ksym_ref(__kvm_hyp_vector);
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c38bfbe..4e4ae07 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1088,7 +1088,7 @@ static void cpu_init_hyp_mode(void *dummy)
 	pgd_ptr = kvm_mmu_get_httbr();
 	stack_page = __this_cpu_read(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
-	vector_ptr = (unsigned long)kvm_ksym_ref(__kvm_hyp_vector);
+	vector_ptr = (unsigned long)kvm_get_hyp_vector();
 
 	__cpu_init_hyp_mode(pgd_ptr, hyp_stack_ptr, vector_ptr);
 	__cpu_init_stage2();
@@ -1345,6 +1345,12 @@ static int init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = kvm_map_vectors();
+	if (err) {
+		kvm_err("Cannot map vectors\n");
+		goto out_err;
+	}
+
 	/*
 	 * Map the Hyp stack pages
 	 */
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 6d22017..80bf337 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -313,5 +313,43 @@ static inline unsigned int kvm_get_vmid_bits(void)
 	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
 
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+#include <asm/mmu.h>
+
+static inline void *kvm_get_hyp_vector(void)
+{
+	struct bp_hardening_data *data = arm64_get_bp_hardening_data();
+	void *vect = kvm_ksym_ref(__kvm_hyp_vector);
+
+	if (data->fn) {
+		vect = __bp_harden_hyp_vecs_start +
+		       data->hyp_vectors_slot * SZ_2K;
+
+		if (!cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
+			vect = lm_alias(vect);
+	}
+
+	return vect;
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return create_hyp_mappings(kvm_ksym_ref(__bp_harden_hyp_vecs_start),
+				   kvm_ksym_ref(__bp_harden_hyp_vecs_end),
+				   PAGE_HYP_EXEC);
+}
+
+#else
+static inline void *kvm_get_hyp_vector(void)
+{
+	return kvm_ksym_ref(__kvm_hyp_vector);
+}
+
+static inline int kvm_map_vectors(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ARM64_KVM_MMU_H__ */
diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 0c848c1..cf6d962 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -50,7 +50,7 @@ static void __hyp_text __activate_traps_vhe(void)
 	val &= ~CPACR_EL1_FPEN;
 	write_sysreg(val, cpacr_el1);
 
-	write_sysreg(__kvm_hyp_vector, vbar_el1);
+	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 
 static void __hyp_text __activate_traps_nvhe(void)
-- 
2.7.4
