Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15749C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E02208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLxAAQCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6E02208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbeG0STg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:19:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46484 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388995AbeG0STf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:19:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id h14-v6so5703207wrw.13;
        Fri, 27 Jul 2018 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ak+J+Wbf8nDUvp/6HGgnbR2jlNE6VVmsNQLCf6Cv1s8=;
        b=LLxAAQCuH0Wv55OBbl+Scx8Q4/MaHbj9V9cw7NGktWuO1jVBwcZUvPtPI1yNZyX3JT
         Nq1BAwKdT3Kj4kDiy5hla1AvRDa2OtqSBkG0tQdI4pc62jNBlevSVWjDB7BfIF8hus6m
         0goDvlshfLkY0tXvfTzW7OqrI00FL3fQnkPnaXiwgAvsYH3LK5a/cJZ4Bg3LHZX86yC0
         ZeVpXvOQxIKXlXKiZZL+Egg1HVVO839PWmNVp/cDhXax7avDTg1frsODBtPYb/dMKacz
         z//zlK/TCUaa5n+x10mCCpCoDUtyMnStwGMx3mwgCMzlRSnJPcw6yKRTSJ0dDcSfBnK0
         2EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ak+J+Wbf8nDUvp/6HGgnbR2jlNE6VVmsNQLCf6Cv1s8=;
        b=BWTtxg+ovjnjrtMwqWptjhzEoTWHf5cHwTHoCFCi1mROtnQk/ST+I3gR3+jxZHiDeM
         iCC0GiETsCPk9O25Rka3167/CZNZp1E3D7y4xMR33R7MhYgZwskMPKLOtwAoCMpQJB2L
         Bf4IIR9w/JJyR3uTGuhX69k1YXLWGj/B7lhFhfDw8R87BiMO3v01ZVlFA5rhsB13U3Pt
         DfzVsw3HC+AYqYy29AXn9V4giDvK95iq4/3Sw4s5zZVHK4/kMbibB5+4ahqwBT0dMM9U
         egdP2iTkSMr4nbeqMTR/BysW4RS0JcMDFMgCkgHSfPLQUHr22mWiG76mo5ZpqncuIQ8U
         isnA==
X-Gm-Message-State: AOUpUlG8uK2neLJmmAucSF4byoSVrKQQ8Gzl5oAw/tLCuCQ+fBnjWfrz
        qBG304a6UeTex2jytCgMT4J8IEsT
X-Google-Smtp-Source: AAOMgpdb1lKweoqZVT5ppJOtQhte4Z8iNKR/FOJ9H8A3t2HKFOO58OJdcPf8nqTiaiR/tpZ5Bt7oLA==
X-Received: by 2002:adf:dbc3:: with SMTP id e3-v6mr5375415wrj.217.1532710608728;
        Fri, 27 Jul 2018 09:56:48 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id u185-v6sm5528184wmg.25.2018.07.27.09.56.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 09:56:48 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com
Subject: [PATCH 4/4] x86/kvm/mmu: introduce guest_mmu
Date:   Fri, 27 Jul 2018 18:56:41 +0200
Message-Id: <1532710601-45449-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
References: <1532710601-45449-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

When EPT is used for nested guest we need to re-init MMU as shadow
EPT MMU (nested_ept_init_mmu_context() does that). When we return back
from L2 to L1 kvm_mmu_reset_context() in nested_vmx_load_cr3() resets
MMU back to normal TDP mode. Add a special 'guest_mmu' so we can use
separate root caches; the improved hit rate is not very important for
single vCPU performance, but it avoids contention on the mmu_lock for
many vCPUs.

On the nested CPUID benchmark, with 16 vCPUs, an L2->L1->L2 vmexit
goes from 42k to 26k cycles.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/mmu.c              | 15 +++++++++++----
 arch/x86/kvm/vmx.c              | 26 ++++++++++++++++++--------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7b157cd43e1f..932c3285739f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -538,6 +538,9 @@ struct kvm_vcpu_arch {
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
 
+	/* L1 MMU when running nested */
+	struct kvm_mmu guest_mmu;
+
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
 	 *
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 1bcab6f9d1c8..3e3c351b5c61 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4937,8 +4937,10 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
 
@@ -5365,13 +5367,18 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+
 	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
 	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
-	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
-
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 
+	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
+	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
+		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
+
+	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
 	return alloc_mmu_pages(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 362842f9b523..644a8e009947 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8175,8 +8175,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
  * Free whatever needs to be freed from vmx->nested when L1 goes down, or
  * just stops using VMX.
  */
-static void free_nested(struct vcpu_vmx *vmx)
+static void free_nested(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
@@ -8209,6 +8211,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8217,7 +8221,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
 {
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -8248,6 +8252,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 	if (vmptr == vmx->nested.current_vmptr)
 		nested_release_vmcs12(vmx);
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	kvm_vcpu_write_guest(vcpu,
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
@@ -8631,6 +8637,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		}
 
 		nested_release_vmcs12(vmx);
+
+		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
@@ -10576,12 +10584,12 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
  */
 static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 {
-       struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-       vcpu_load(vcpu);
-       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-       free_nested(vmx);
-       vcpu_put(vcpu);
+	vcpu_load(vcpu);
+	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+	free_nested(vcpu);
+	vcpu_put(vcpu);
 }
 
 static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
@@ -10907,6 +10915,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
 		return 1;
 
+	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	kvm_init_shadow_ept_mmu(vcpu,
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
@@ -10922,6 +10931,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
@@ -12960,7 +12970,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->nested.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 }
 
 /*
-- 
1.8.3.1

