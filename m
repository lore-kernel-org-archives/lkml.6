Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC9C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD420878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNi29ojO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8DD420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeG2Aii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45984 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeG2Aih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id t13-v6so8667818wrv.12;
        Sat, 28 Jul 2018 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTziOgrLd3+UQ2zdVnM2sW14AnHwXoiEmENvYU3Oz7E=;
        b=QNi29ojOkus6RPQD3Pb7o1D+x3DGQUzoPvqWeZVr6yn156rbtgwugSqu0xhuFC1UdC
         L2hqfYPEbd+45yS5UMQLrT2UVjaf4dYcZvKlRp0JeSar/SEzXI5S0rGt2UyZt/UfQArH
         iYJrelBPQVC3uX/sHA/noSHnphLoOoHkasKR2bxox1hG6Y2rewq0EJEejFXnKi+99F0v
         qlVbGLPsAMx9NW584zmQqDiaUegVBROBe8LD3jfoOx4wgaan1TZFrzy/nQoZwWuTpL7e
         dVUoj1SE0EeSGdp5vHZlQCHtyY+TbSDQpbVm2571IMp3Hv48vUS4kQY8wCfARh3kH92H
         a97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=eTziOgrLd3+UQ2zdVnM2sW14AnHwXoiEmENvYU3Oz7E=;
        b=Us0kF463m4Y7qZH4tSkBmXxl7x6t1Hf/hcQ+vDQP58jnBdMwFaDmg3o9CTbci1hy2r
         JiLZFkRQDr99MI9TT/bDKugqEuqA0/IHwmCcJ83DtFazpNI+xtmVvL+EITm1lxpRU32e
         OXhGA3XXJklvdfuCy5TmYwO3auyayol4YmSR36X8cshvDvzxavfOy5MgPnXrlpXRs+6U
         7+xd/94nyEYqD6Wxsy3ydHANR2QHJm5vRiTqDPpNXu3gJVkSX+kDWimjzStHcXANh+Qq
         CcI+NX+a4Zqe7mE19opc0BVCqGqJFWSZvOfXzNOdH+ib8reFpSf7NfaXKmpW+yvhCMVd
         3KWQ==
X-Gm-Message-State: AOUpUlHPYi44jjD3Nc8d1hklVinJVaHr75VH/r7HdnOZeqN3py1GBKFM
        Sq56nG9lCRAJ1JCTuWmCiv6PzjHR
X-Google-Smtp-Source: AAOMgpdkTmQRuTRtl0OH7k3+APcDnZmlKMQy/Om3yfEyRfi4tIzR94BjTr5ME6gnwEwxFXrpIL8Bjg==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr11180407wrb.127.1532819426170;
        Sat, 28 Jul 2018 16:10:26 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:25 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 08/10] kvm: selftests: add test for nested state save/restore
Date:   Sun, 29 Jul 2018 01:10:10 +0200
Message-Id: <1532819412-51357-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/vmx.h | 32 +++++++++++++
 tools/testing/selftests/kvm/lib/x86.c     | 27 ++++++++++-
 tools/testing/selftests/kvm/state_test.c  | 75 ++++++++++++++++++++++++++++++-
 3 files changed, 131 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/vmx.h b/tools/testing/selftests/kvm/include/vmx.h
index 9caaf56696a4..2b37f9b6f7df 100644
--- a/tools/testing/selftests/kvm/include/vmx.h
+++ b/tools/testing/selftests/kvm/include/vmx.h
@@ -380,6 +380,30 @@ static inline int vmptrld(uint64_t vmcs_pa)
 	return ret;
 }
 
+static inline int vmptrst(uint64_t *value)
+{
+	uint64_t tmp;
+	uint8_t ret;
+
+	__asm__ __volatile__("vmptrst %[value]; setna %[ret]"
+		: [value]"=m"(tmp), [ret]"=rm"(ret)
+		: : "cc", "memory");
+
+	*value = tmp;
+	return ret;
+}
+
+/*
+ * A wrapper around vmptrst that ignores errors and returns zero if the
+ * vmptrst instruction fails.
+ */
+static inline uint64_t vmptrstz(void)
+{
+	uint64_t value = 0;
+	vmptrst(&value);
+	return value;
+}
+
 /*
  * No guest state (e.g. GPRs) is established by this vmlaunch.
  */
@@ -444,6 +468,15 @@ static inline int vmresume(void)
 	return ret;
 }
 
+static inline void vmcall(void)
+{
+	/* Currently, L1 destroys our GPRs during vmexits.  */
+	__asm__ __volatile__("push %%rbp; vmcall; pop %%rbp" : : :
+			     "rax", "rbx", "rcx", "rdx",
+			     "rsi", "rdi", "r8", "r9", "r10", "r11", "r12",
+			     "r13", "r14", "r15");
+}
+
 static inline int vmread(uint64_t encoding, uint64_t *value)
 {
 	uint64_t tmp;
diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
index 78aabcb91de1..e38345252df5 100644
--- a/tools/testing/selftests/kvm/lib/x86.c
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -736,6 +736,10 @@ struct kvm_x86_state {
 	struct kvm_xcrs xcrs;
 	struct kvm_sregs sregs;
 	struct kvm_debugregs debugregs;
+	union {
+		struct kvm_nested_state nested;
+		char nested_[16384];
+	};
 	struct kvm_msrs msrs;
 };
 
@@ -764,6 +762,14 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
 	struct kvm_msr_list *list;
 	struct kvm_x86_state *state;
 	int nmsrs, r, i;
+	static int nested_size = -1;
+
+	if (nested_size == -1) {
+		nested_size = kvm_check_cap(KVM_CAP_NESTED_STATE);
+		TEST_ASSERT(nested_size <= sizeof(state->nested_),
+			    "Nested state size too big, %i > %zi",
+			    nested_size, sizeof(state->nested_));
+	}
 
 	nmsrs = kvm_get_num_msrs(vm);
 	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
@@ -797,6 +803,17 @@ struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
         TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_SREGS, r: %i",
                 r);
 
+	if (nested_size) {
+		state->nested.size = sizeof(state->nested_);
+		r = ioctl(vcpu->fd, KVM_GET_NESTED_STATE, &state->nested);
+		TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_NESTED_STATE, r: %i",
+			r);
+		TEST_ASSERT(state->nested.size <= nested_size,
+			"Nested state size too big, %i (KVM_CHECK_CAP gave %i)",
+			state->nested.size, nested_size);
+	} else
+		state->nested.size = 0;
+
 	state->msrs.nmsrs = nmsrs;
 	for (i = 0; i < nmsrs; i++)
 		state->msrs.entries[i].index = list->indices[i];
@@ -817,6 +834,12 @@ void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *s
 	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
 	int r;
 
+	if (state->nested.size) {
+		r = ioctl(vcpu->fd, KVM_SET_NESTED_STATE, &state->nested);
+		TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_NESTED_STATE, r: %i",
+			r);
+	}
+
 	r = ioctl(vcpu->fd, KVM_SET_XSAVE, &state->xsave);
         TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XSAVE, r: %i",
                 r);
diff --git a/tools/testing/selftests/kvm/state_test.c b/tools/testing/selftests/kvm/state_test.c
index e47b27b5406e..447da4f76b56 100644
--- a/tools/testing/selftests/kvm/state_test.c
+++ b/tools/testing/selftests/kvm/state_test.c
@@ -18,6 +18,7 @@
 
 #include "kvm_util.h"
 #include "x86.h"
+#include "vmx.h"
 
 #define VCPU_ID		5
 #define PORT_SYNC	0x1000
@@ -45,16 +46,75 @@ static inline void __exit_to_l0(uint16_t port, uint64_t arg0, uint64_t arg1)
 
 static bool have_nested_state;
 
-void guest_code(void)
+void l2_guest_code(void)
+{
+	GUEST_SYNC(5);
+
+        /* Exit to L1 */
+	vmcall();
+
+	GUEST_SYNC(7);
+
+	/* Done, exit to L1 and never come back.  */
+	vmcall();
+}
+
+void l1_guest_code(struct vmx_pages *vmx_pages)
+{
+#define L2_GUEST_STACK_SIZE 64
+        unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+
+	GUEST_ASSERT(vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
+	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+
+	GUEST_SYNC(3);
+	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	GUEST_SYNC(4);
+	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(!vmlaunch());
+	GUEST_ASSERT(vmptrstz() == vmx_pages->vmcs_gpa);
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+
+	/* Check that the launched state is preserved.  */
+	GUEST_ASSERT(vmlaunch());
+
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+
+	GUEST_SYNC(6);
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+
+	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3);
+
+	GUEST_ASSERT(!vmresume());
+	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
+	GUEST_SYNC(8);
+}
+
+void guest_code(struct vmx_pages *vmx_pages)
 {
 	GUEST_SYNC(1);
 	GUEST_SYNC(2);
 
+	if (vmx_pages)
+		l1_guest_code(vmx_pages);
+
 	exit_to_l0(PORT_DONE, 0, 0);
 }
 
 int main(int argc, char *argv[])
 {
+	struct vmx_pages *vmx_pages = NULL;
+	vm_vaddr_t vmx_pages_gva = 0;
+
 	struct kvm_regs regs1, regs2;
 	struct kvm_vm *vm;
 	struct kvm_run *run;
@@ -69,6 +133,15 @@ int main(int argc, char *argv[])
 	run = vcpu_state(vm, VCPU_ID);
 
 	vcpu_regs_get(vm, VCPU_ID, &regs1);
+
+	if (kvm_check_cap(KVM_CAP_NESTED_STATE)) {
+		vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+		vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
+	} else {
+		printf("will skip nested state checks\n");
+		vcpu_args_set(vm, VCPU_ID, 1, 0);
+	}
+
 	for (stage = 1;; stage++) {
 		_vcpu_run(vm, VCPU_ID);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-- 
1.8.3.1

