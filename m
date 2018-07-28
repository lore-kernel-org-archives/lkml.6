Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BD1C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3F120878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkpa724r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3F120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbeG2Aig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39772 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeG2Aif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:35 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so9483241wmb.4;
        Sat, 28 Jul 2018 16:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dw0tnLcPRlLp/CPLVdchiMw/KWxx8qaqoZVlMVZuHJA=;
        b=mkpa724r9gDv6NJgyCcA9L5Rn/JyMpEp2lwLvQ4i15HyoNLfe2OPZjR7eL57Q43psX
         iM0WDZt3Ru2JsKxtHSiv7W6+Zo5I8X78VGMuu0uKVrfG3foULzwrR30Xr3JQjgBumy+t
         TeC64BdPHQEMRzb5ICnwFQTN0IMf4csx4vr5iSbqu9voz60PovE1SQGp0D6zFnyOZSHe
         jpPInbGnmMw7oG3Zz3jbFir7pNIsFWLp1N5lUPn033lqSd8ZFgBS21f7L7TV31hDMV+n
         vMyXmqmtCV5xH35HRqX2zKRDmFvq0KqJCU9xXzRcGjEUNJctaf7faaTfsNWr2RwMi9kc
         EUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Dw0tnLcPRlLp/CPLVdchiMw/KWxx8qaqoZVlMVZuHJA=;
        b=HXZhCononIqyRrKgNGyc502059FKH9X73744Yq4MXcHd84G3qYV152SUlXyOwQQQuH
         1dV64+BEW070Cbj/mAGzQyCw9G4rDMTo8nrd6xB8GHKnBcSioqCxPoieV8xj60jMm/pq
         pUlVXwt+hwijVbLfYWUaYK5Agqww4GwVuoyY0pFX8LcTtxV5hQr4oIm2QENs+VZIFuDG
         CPY8MHUrDSf7w8dstAfneb9S2s1FmGjqp6PyCh/hQRNOazOtZWKQlVmj69A3U+RSEqLF
         r/rN8L8gjTVEyigbI89T+/rwOn4hu5/F+OkqV0XB5n4zOaL8LFrmBXliwaleRSTnBI+t
         gSEQ==
X-Gm-Message-State: AOUpUlHkySc/xeo6VY+jqhZIE9C+UVEx7E118f+aghzTTgQYxm13dDQo
        pSjuBLiBwP9DbxzehW9ohG9HZplB
X-Google-Smtp-Source: AAOMgpemd4weqKgSbPcezfo2YcDMSIFe7SPk0372ZpdY+gcrk4eEI0ebbejKXdhGjebvkj4Dl0uWNg==
X-Received: by 2002:a1c:9b43:: with SMTP id d64-v6mr9505000wme.109.1532819423579;
        Sat, 28 Jul 2018 16:10:23 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:23 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 06/10] KVM: x86: do not load vmcs12 pages while still in SMM
Date:   Sun, 29 Jul 2018 01:10:08 +0200
Message-Id: <1532819412-51357-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the vCPU enters system management mode while running a nested guest,
RSM starts processing the vmentry while still in SMM.  In that case,
however, the pages pointed to by the vmcs12 might be incorrectly
loaded from SMRAM.  To avoid this, delay the handling of the pages
until just before the next vmentry.  This is done with a new request
and a new entry in kvm_x86_ops, which we will be able to reuse for
nested VMX state migration.

Extracted from a patch by Jim Mattson and KarimAllah Ahmed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/vmx.c              | 53 +++++++++++++++++++++++++++--------------
 arch/x86/kvm/x86.c              |  2 ++
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c13cd28d9d1b..da957725992d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -75,6 +75,7 @@
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
 #define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
+#define KVM_REQ_GET_VMCS12_PAGES	KVM_ARCH_REQ(24)
 
 #define CR0_RESERVED_BITS                                               \
 	(~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM | X86_CR0_TS \
@@ -1085,6 +1086,8 @@ struct kvm_x86_ops {
 
 	void (*setup_mce)(struct kvm_vcpu *vcpu);
 
+	void (*get_vmcs12_pages)(struct kvm_vcpu *vcpu);
+
 	int (*smi_allowed)(struct kvm_vcpu *vcpu);
 	int (*pre_enter_smm)(struct kvm_vcpu *vcpu, char *smstate);
 	int (*pre_leave_smm)(struct kvm_vcpu *vcpu, u64 smbase);
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 2630ab38d72c..17aede06ae0e 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -10636,9 +10636,9 @@ static void vmx_inject_page_fault_nested(struct kvm_vcpu *vcpu,
 static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 						 struct vmcs12 *vmcs12);
 
-static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
-					struct vmcs12 *vmcs12)
+static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu)
 {
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct page *page;
 	u64 hpa;
@@ -11750,13 +11750,18 @@ static int check_vmentry_postreqs(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	return 0;
 }
 
-static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
+/*
+ * If p_exit_qual is NULL, this is being called from state restore (either
+ * kvm_set_nested_state or RSM).  Otherwise it's called from vmlaunch/vmresume.
+ */
+static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu, u32 *p_exit_qual)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	bool from_vmentry = !!p_exit_qual;
 	u32 msr_entry_idx;
-	u32 exit_qual;
-	int r;
+	u32 dummy_exit_qual;
+	int r = 0;
 
 	enter_guest_mode(vcpu);
 
@@ -11770,17 +11775,27 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
 		vcpu->arch.tsc_offset += vmcs12->tsc_offset;
 
 	r = EXIT_REASON_INVALID_STATE;
-	if (prepare_vmcs02(vcpu, vmcs12, &exit_qual))
+	if (prepare_vmcs02(vcpu, vmcs12, from_vmentry ? p_exit_qual : &dummy_exit_qual))
 		goto fail;
 
-	nested_get_vmcs12_pages(vcpu, vmcs12);
+	if (from_vmentry) {
+		nested_get_vmcs12_pages(vcpu);
 
-	r = EXIT_REASON_MSR_LOAD_FAIL;
-	msr_entry_idx = nested_vmx_load_msr(vcpu,
-					    vmcs12->vm_entry_msr_load_addr,
-					    vmcs12->vm_entry_msr_load_count);
-	if (msr_entry_idx)
-		goto fail;
+		r = EXIT_REASON_MSR_LOAD_FAIL;
+		msr_entry_idx = nested_vmx_load_msr(vcpu,
+						    vmcs12->vm_entry_msr_load_addr,
+						    vmcs12->vm_entry_msr_load_count);
+		if (msr_entry_idx)
+			goto fail;
+	} else {
+		/*
+		 * The MMU is not initialized to point at the right entities yet and
+		 * "get pages" would need to read data from the guest (i.e. we will
+		 * need to perform gpa to hpa translation). Request a call
+		 * to nested_get_vmcs12_pages before the next VM-entry.
+		 */
+		kvm_make_request(KVM_REQ_GET_VMCS12_PAGES, vcpu);
+	}
 
 	/*
 	 * Note no nested_vmx_succeed or nested_vmx_fail here. At this point
@@ -11795,8 +11810,7 @@ static int enter_vmx_non_root_mode(struct kvm_vcpu *vcpu)
 		vcpu->arch.tsc_offset -= vmcs12->tsc_offset;
 	leave_guest_mode(vcpu);
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-	nested_vmx_entry_failure(vcpu, vmcs12, r, exit_qual);
-	return 1;
+	return r;
 }
 
 /*
@@ -11873,10 +11887,11 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 */
 
 	vmx->nested.nested_run_pending = 1;
-	ret = enter_vmx_non_root_mode(vcpu);
+	ret = enter_vmx_non_root_mode(vcpu, &exit_qual);
 	if (ret) {
+		nested_vmx_entry_failure(vcpu, vmcs12, ret, exit_qual);
 		vmx->nested.nested_run_pending = 0;
-		return ret;
+		return 1;
 	}
 
 	/*
@@ -12962,7 +12977,7 @@ static int vmx_pre_leave_smm(struct kvm_vcpu *vcpu, u64 smbase)
 
 	if (vmx->nested.smm.guest_mode) {
 		vcpu->arch.hflags &= ~HF_SMM_MASK;
-		ret = enter_vmx_non_root_mode(vcpu);
+		ret = enter_vmx_non_root_mode(vcpu, NULL);
 		vcpu->arch.hflags |= HF_SMM_MASK;
 		if (ret)
 			return ret;
@@ -13111,6 +13126,8 @@ static int enable_smi_window(struct kvm_vcpu *vcpu)
 
 	.setup_mce = vmx_setup_mce,
 
+	.get_vmcs12_pages = nested_get_vmcs12_pages,
+
 	.smi_allowed = vmx_smi_allowed,
 	.pre_enter_smm = vmx_pre_enter_smm,
 	.pre_leave_smm = vmx_pre_leave_smm,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2b812b3c5088..8ddf5f94876f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7257,6 +7257,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
+		if (kvm_check_request(KVM_REQ_GET_VMCS12_PAGES, vcpu))
+			kvm_x86_ops->get_vmcs12_pages(vcpu);
 		if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu))
 			kvm_mmu_unload(vcpu);
 		if (kvm_check_request(KVM_REQ_MIGRATE_TIMER, vcpu))
-- 
1.8.3.1

