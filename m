Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71038C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F324520878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQStI7BB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F324520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbeG2Aid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32781 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeG2Aic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so8730298wrp.0;
        Sat, 28 Jul 2018 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePmDOgFp2AMZCra5faS/xY0gEzPi8Hbv4kbsUgf7MK8=;
        b=BQStI7BBKGC+NIm/tLoMtTlFX+0tK52Lzdv+5JmwLPvau9yMA9c4C36p3huXKEmW70
         e1G4ahEZW1n8TZIh6h8u8djrziVht5hs/nXhbBhNiMA961VzBxl0kZ73vXCtRFj+SAz5
         LH/QnfQme22Wti3oyn5qkBaCKk032MaQjFTpyoZi4LMpzDEAvPM50mtrhZqpvTHasoC7
         UmHFSuggC8NzKqno8nd79f84wPOpPdNeuD0lp/HqEGbta1mcLxgU4dOO3C3f2XRQ17l9
         5MBtxd0Lar69FCMsee281KK0fwLl1zY5JUm6tEYXiieMKaVQgVqSl4gdLTKhCtfu6Hq5
         t9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ePmDOgFp2AMZCra5faS/xY0gEzPi8Hbv4kbsUgf7MK8=;
        b=tVoxZ0edKGm3shbikSrt4/zEMtG1dm0WRa8+VoAKKLNvMTm5/oE605Ye2FsD2PY9DO
         NvD0BWsNhjsOmr207hceXO8t6aDocTJLOjnZwWD8OHgnfuY70VzvC98zaZyu2kNcW09e
         PPwD0qkf4tW4Gap1pgkSGnaGex7wcfno1Og7u/hgNe30YDaKk/btHQ91h9DIIfJUrsc/
         iI61e3TMBfMCXoK9wJPfV6Gh5adxV1CkVe2Xc6ytnO+piXvQt7HeAlcgf+wOCgIwchSM
         PEdkjcaCdg6c5av5S2fALCi173LOGHPP6jLYph+AYSS0gy5bNV5yE5WmmNG3de4qqoP6
         pWtw==
X-Gm-Message-State: AOUpUlGJYxjDpafZtSmizzJh2YQ5RXHrpNEGfHQQZG9P1PbvTYP+33Ai
        W5ve+ByrqJtUYnsSqLoUz6J2sAJI
X-Google-Smtp-Source: AAOMgpczZSIq4V+dEdLmhTIJbjCj+tpEoF3/Zh34pLj5DYHNes2f+claFNzGWtSf18OvCpu8S2bbDg==
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr11024139wrn.143.1532819419602;
        Sat, 28 Jul 2018 16:10:19 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:19 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 03/10] kvm: selftests: actually use all of lib/vmx.c
Date:   Sun, 29 Jul 2018 01:10:05 +0200
Message-Id: <1532819412-51357-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation of the VMXON and VMCS is currently done twice, in
lib/vmx.c and in vmx_tsc_adjust_test.c.  Reorganize the code to
provide a cleaner and easier to use API to the tests.  lib/vmx.c
now does the complete setup of the VMX data structures, but does not
create the VM or set CPUID.  This has to be done by the caller.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/cr4_cpuid_sync_test.c |  2 +-
 tools/testing/selftests/kvm/include/vmx.h         | 21 +++++--
 tools/testing/selftests/kvm/lib/vmx.c             | 71 ++++++++++++++---------
 tools/testing/selftests/kvm/vmx_tsc_adjust_test.c | 69 +++++-----------------
 4 files changed, 73 insertions(+), 90 deletions(-)

diff --git a/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
index dbbaf3c3fbfe..8346b33c2073 100644
--- a/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/cr4_cpuid_sync_test.c
@@ -95,7 +95,7 @@ int main(int argc, char *argv[])
 	setbuf(stdout, NULL);
 
 	/* Create VM */
-	vm = vm_create_default_vmx(VCPU_ID, guest_code);
+	vm = vm_create_default(VCPU_ID, guest_code);
 	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 	run = vcpu_state(vm, VCPU_ID);
 
diff --git a/tools/testing/selftests/kvm/include/vmx.h b/tools/testing/selftests/kvm/include/vmx.h
index 6ed8499807fd..9caaf56696a4 100644
--- a/tools/testing/selftests/kvm/include/vmx.h
+++ b/tools/testing/selftests/kvm/include/vmx.h
@@ -486,9 +486,22 @@ static inline uint32_t vmcs_revision(void)
 	return rdmsr(MSR_IA32_VMX_BASIC);
 }
 
-void prepare_for_vmx_operation(void);
-void prepare_vmcs(void *guest_rip, void *guest_rsp);
-struct kvm_vm *vm_create_default_vmx(uint32_t vcpuid,
-				     vmx_guest_code_t guest_code);
+struct vmx_pages {
+	void *vmxon_hva;
+	uint64_t vmxon_gpa;
+	void *vmxon;
+
+	void *vmcs_hva;
+	uint64_t vmcs_gpa;
+	void *vmcs;
+
+	void *msr_hva;
+	uint64_t msr_gpa;
+	void *msr;
+};
+
+struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva);
+bool prepare_for_vmx_operation(struct vmx_pages *vmx);
+void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp);
 
 #endif /* !SELFTEST_KVM_VMX_H */
diff --git a/tools/testing/selftests/kvm/lib/vmx.c b/tools/testing/selftests/kvm/lib/vmx.c
index 0231bc0aae7b..5701e52a33ed 100644
--- a/tools/testing/selftests/kvm/lib/vmx.c
+++ b/tools/testing/selftests/kvm/lib/vmx.c
@@ -13,47 +13,43 @@
 #include "x86.h"
 #include "vmx.h"
 
-/* Create a default VM for VMX tests.
+/* Allocate memory regions for nested VMX tests.
  *
  * Input Args:
- *   vcpuid - The id of the single VCPU to add to the VM.
- *   guest_code - The vCPU's entry point
+ *   vm - The VM to allocate guest-virtual addresses in.
  *
- * Output Args: None
+ * Output Args:
+ *   p_vmx_gva - The guest virtual address for the struct vmx_pages.
  *
  * Return:
- *   Pointer to opaque structure that describes the created VM.
+ *   Pointer to structure with the addresses of the VMX areas.
  */
-struct kvm_vm *
-vm_create_default_vmx(uint32_t vcpuid, vmx_guest_code_t guest_code)
+struct vmx_pages *
+vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva)
 {
-	struct kvm_cpuid2 *cpuid;
-	struct kvm_vm *vm;
-	vm_vaddr_t vmxon_vaddr;
-	vm_paddr_t vmxon_paddr;
-	vm_vaddr_t vmcs_vaddr;
-	vm_paddr_t vmcs_paddr;
-
-	vm = vm_create_default(vcpuid, (void *) guest_code);
-
-	/* Enable nesting in CPUID */
-	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
+	vm_vaddr_t vmx_gva = vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	struct vmx_pages *vmx = addr_gva2hva(vm, vmx_gva);
 
 	/* Setup of a region of guest memory for the vmxon region. */
-	vmxon_vaddr = vm_vaddr_alloc(vm, getpagesize(), 0, 0, 0);
-	vmxon_paddr = addr_gva2gpa(vm, vmxon_vaddr);
+	vmx->vmxon = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->vmxon_hva = addr_gva2hva(vm, (uintptr_t)vmx->vmxon);
+	vmx->vmxon_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmxon);
 
 	/* Setup of a region of guest memory for a vmcs. */
-	vmcs_vaddr = vm_vaddr_alloc(vm, getpagesize(), 0, 0, 0);
-	vmcs_paddr = addr_gva2gpa(vm, vmcs_vaddr);
+	vmx->vmcs = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->vmcs_hva = addr_gva2hva(vm, (uintptr_t)vmx->vmcs);
+	vmx->vmcs_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmcs);
 
-	vcpu_args_set(vm, vcpuid, 4, vmxon_vaddr, vmxon_paddr, vmcs_vaddr,
-		      vmcs_paddr);
+	/* Setup of a region of guest memory for the MSR bitmap. */
+	vmx->msr = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->msr_hva = addr_gva2hva(vm, (uintptr_t)vmx->msr);
+	vmx->msr_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->msr);
 
-	return vm;
+	*p_vmx_gva = vmx_gva;
+	return vmx;
 }
 
-void prepare_for_vmx_operation(void)
+bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 {
 	uint64_t feature_control;
 	uint64_t required;
@@ -88,12 +84,27 @@ void prepare_for_vmx_operation(void)
 	feature_control = rdmsr(MSR_IA32_FEATURE_CONTROL);
 	if ((feature_control & required) != required)
 		wrmsr(MSR_IA32_FEATURE_CONTROL, feature_control | required);
+
+	/* Enter VMX root operation. */
+	*(uint32_t *)(vmx->vmxon) = vmcs_revision();
+	if (vmxon(vmx->vmxon_gpa))
+		return false;
+
+	/* Load a VMCS. */
+	*(uint32_t *)(vmx->vmcs) = vmcs_revision();
+	if (vmclear(vmx->vmcs_gpa))
+		return false;
+
+	if (vmptrld(vmx->vmcs_gpa))
+		return false;
+
+	return true;
 }
 
 /*
  * Initialize the control fields to the most basic settings possible.
  */
-static inline void init_vmcs_control_fields(void)
+static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 {
 	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
 	vmwrite(POSTED_INTR_NV, 0);
@@ -119,6 +130,8 @@ static inline void init_vmcs_control_fields(void)
 	vmwrite(CR4_GUEST_HOST_MASK, 0);
 	vmwrite(CR0_READ_SHADOW, get_cr0());
 	vmwrite(CR4_READ_SHADOW, get_cr4());
+
+	vmwrite(MSR_BITMAP, vmx->msr_gpa);
 }
 
 /*
@@ -235,9 +248,9 @@ static inline void init_vmcs_guest_state(void *rip, void *rsp)
 	vmwrite(GUEST_SYSENTER_EIP, vmreadz(HOST_IA32_SYSENTER_EIP));
 }
 
-void prepare_vmcs(void *guest_rip, void *guest_rsp)
+void prepare_vmcs(struct vmx_pages *vmx, void *guest_rip, void *guest_rsp)
 {
-	init_vmcs_control_fields();
+	init_vmcs_control_fields(vmx);
 	init_vmcs_host_state();
 	init_vmcs_guest_state(guest_rip, guest_rsp);
 }
diff --git a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
index d7cb7944a42e..fc414c284368 100644
--- a/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
+++ b/tools/testing/selftests/kvm/vmx_tsc_adjust_test.c
@@ -46,11 +46,6 @@ enum {
 	PORT_DONE,
 };
 
-struct vmx_page {
-	vm_vaddr_t virt;
-	vm_paddr_t phys;
-};
-
 enum {
 	VMXON_PAGE = 0,
 	VMCS_PAGE,
@@ -67,9 +62,6 @@ struct kvm_single_msr {
 /* The virtual machine object. */
 static struct kvm_vm *vm;
 
-/* Array of vmx_page descriptors that is shared with the guest. */
-struct vmx_page *vmx_pages;
-
 #define exit_to_l0(_port, _arg) do_exit_to_l0(_port, (unsigned long) (_arg))
 static void do_exit_to_l0(uint16_t port, unsigned long arg)
 {
@@ -105,7 +97,7 @@ static void l2_guest_code(void)
 	__asm__ __volatile__("vmcall");
 }
 
-static void l1_guest_code(struct vmx_page *vmx_pages)
+static void l1_guest_code(struct vmx_pages *vmx_pages)
 {
 #define L2_GUEST_STACK_SIZE 64
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
@@ -116,23 +108,14 @@ static void l1_guest_code(struct vmx_page *vmx_pages)
 	wrmsr(MSR_IA32_TSC, rdtsc() - TSC_ADJUST_VALUE);
 	check_ia32_tsc_adjust(-1 * TSC_ADJUST_VALUE);
 
-	prepare_for_vmx_operation();
-
-	/* Enter VMX root operation. */
-	*(uint32_t *)vmx_pages[VMXON_PAGE].virt = vmcs_revision();
-	GUEST_ASSERT(!vmxon(vmx_pages[VMXON_PAGE].phys));
-
-	/* Load a VMCS. */
-	*(uint32_t *)vmx_pages[VMCS_PAGE].virt = vmcs_revision();
-	GUEST_ASSERT(!vmclear(vmx_pages[VMCS_PAGE].phys));
-	GUEST_ASSERT(!vmptrld(vmx_pages[VMCS_PAGE].phys));
+	GUEST_ASSERT(prepare_for_vmx_operation(vmx_pages));
 
 	/* Prepare the VMCS for L2 execution. */
-	prepare_vmcs(l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+	prepare_vmcs(vmx_pages, l2_guest_code,
+		     &l2_guest_stack[L2_GUEST_STACK_SIZE]);
 	control = vmreadz(CPU_BASED_VM_EXEC_CONTROL);
 	control |= CPU_BASED_USE_MSR_BITMAPS | CPU_BASED_USE_TSC_OFFSETING;
 	vmwrite(CPU_BASED_VM_EXEC_CONTROL, control);
-	vmwrite(MSR_BITMAP, vmx_pages[MSR_BITMAP_PAGE].phys);
 	vmwrite(TSC_OFFSET, TSC_OFFSET_VALUE);
 
 	/* Jump into L2.  First, test failure to load guest CR3.  */
@@ -152,33 +135,6 @@ static void l1_guest_code(struct vmx_page *vmx_pages)
 	exit_to_l0(PORT_DONE, 0);
 }
 
-static void allocate_vmx_page(struct vmx_page *page)
-{
-	vm_vaddr_t virt;
-
-	virt = vm_vaddr_alloc(vm, PAGE_SIZE, 0, 0, 0);
-	memset(addr_gva2hva(vm, virt), 0, PAGE_SIZE);
-
-	page->virt = virt;
-	page->phys = addr_gva2gpa(vm, virt);
-}
-
-static vm_vaddr_t allocate_vmx_pages(void)
-{
-	vm_vaddr_t vmx_pages_vaddr;
-	int i;
-
-	vmx_pages_vaddr = vm_vaddr_alloc(
-		vm, sizeof(struct vmx_page) * NUM_VMX_PAGES, 0, 0, 0);
-
-	vmx_pages = (void *) addr_gva2hva(vm, vmx_pages_vaddr);
-
-	for (i = 0; i < NUM_VMX_PAGES; i++)
-		allocate_vmx_page(&vmx_pages[i]);
-
-	return vmx_pages_vaddr;
-}
-
 void report(int64_t val)
 {
 	printf("IA32_TSC_ADJUST is %ld (%lld * TSC_ADJUST_VALUE + %lld).\n",
@@ -187,7 +143,8 @@ void report(int64_t val)
 
 int main(int argc, char *argv[])
 {
-	vm_vaddr_t vmx_pages_vaddr;
+	struct vmx_pages *vmx_pages;
+	vm_vaddr_t vmx_pages_gva;
 	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
 
 	if (!(entry->ecx & CPUID_VMX)) {
@@ -195,23 +152,23 @@ int main(int argc, char *argv[])
 		exit(KSFT_SKIP);
 	}
 
-	vm = vm_create_default_vmx(VCPU_ID, (void *) l1_guest_code);
+	vm = vm_create_default(VCPU_ID, (void *) l1_guest_code);
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
 
 	/* Allocate VMX pages and shared descriptors (vmx_pages). */
-	vmx_pages_vaddr = allocate_vmx_pages();
-	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_vaddr);
+	vmx_pages = vcpu_alloc_vmx(vm, &vmx_pages_gva);
+	vcpu_args_set(vm, VCPU_ID, 1, vmx_pages_gva);
 
 	for (;;) {
 		volatile struct kvm_run *run = vcpu_state(vm, VCPU_ID);
 		struct kvm_regs regs;
 
 		vcpu_run(vm, VCPU_ID);
+		vcpu_regs_get(vm, VCPU_ID, &regs);
 		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
-			    "Got exit_reason other than KVM_EXIT_IO: %u (%s),\n",
+			    "Got exit_reason other than KVM_EXIT_IO: %u (%s), rip=%lx\n",
 			    run->exit_reason,
-			    exit_reason_str(run->exit_reason));
-
-		vcpu_regs_get(vm, VCPU_ID, &regs);
+			    exit_reason_str(run->exit_reason), regs.rip);
 
 		switch (run->io.port) {
 		case PORT_ABORT:
-- 
1.8.3.1

