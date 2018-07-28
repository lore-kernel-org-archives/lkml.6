Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A8CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9710720878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Una2UMrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9710720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbeG2Aid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39768 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731435AbeG2Aia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:30 -0400
Received: by mail-wm0-f66.google.com with SMTP id h20-v6so9483152wmb.4;
        Sat, 28 Jul 2018 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mX20Br/IeB5XpIR5slsbblFYEtSQups2qjDeKh8xwNo=;
        b=Una2UMrPXziP+M45f3AoovKDo54Q4UNFfDwPs2sxQM9AZd4TxyOjGr1IU6+e4ZV6ND
         AqhGKdPzxwWIhHEoB+VZemG3LfQZLKXW/5aCAXx0tJq47hpIaRxOOJfbB9RfivS8HS08
         b0YIfcXZxx9F4q1A555xmkUUqgOdVp3wZWBohHQhYBTGUgbi3HSny8+gc7H6kjlXeDYf
         RYAdWJeRB4sbS+lrER1trbd4A8QFY1z1hoXIA9RkqBL+eA/tDGtm6cSIW3WEoJP4pAzs
         nWVWXteEbNtQl3NmjE31PvP/bBKzzNzvsN+0W7xNP3JO0nowVo7i093A2Owyc1zg7GX/
         5IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=mX20Br/IeB5XpIR5slsbblFYEtSQups2qjDeKh8xwNo=;
        b=U08pFDsXE0GdumeFeVyE5+JXRHX4JN+p0Gbkr9fRaXdHmpU6PlJ/2lsEGUYBgVroPl
         NHQf7pp4H2G8yZVQaypyH8Z9BxdX3H5Vc9CxKyJ+5vbmOaLwnNsC+ljHfQghe2qOLivO
         QaBGtHp5IaUW7QWmeWcc0zjrTZImY8U7l5Brro0h6JCHh4mLQODfKbQN5LVV+vd5UVFd
         w7pD3fmZWm7hYkvqKmRraRkZxAUH7fB00sKzW/czcQtoSHeI1JCVT6a1QZcdqVF1/q83
         98a6zTmQPQPZnVkPpz4adAEcTAHf6V8jH6nRG7+7JA2IOJW8mVgSZYK0aVc72OwekNv2
         9/9w==
X-Gm-Message-State: AOUpUlHLdsJCl2sKzNfCDLJKKJB19CJSsykWq40BsMqIPQIhDMuG1TbD
        lqpsT9zpLN3JXcYoYbFGmm5MSmqI
X-Google-Smtp-Source: AAOMgpdEop9OocS8oZV3MQd2KRf66wU+mdDwdjoABU5k3J15SVWpPCYmw1SDe5ZrqgzMR+0Ji9Z0cw==
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr9360042wmd.142.1532819418386;
        Sat, 28 Jul 2018 16:10:18 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:17 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 02/10] kvm: selftests: create a GDT and TSS
Date:   Sun, 29 Jul 2018 01:10:04 +0200
Message-Id: <1532819412-51357-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GDT and the TSS base were left to zero, and this has interesting effects
when the TSS descriptor is later read to set up a VMCS's TR_BASE.  Basically
it worked by chance, and this patch fixes it by setting up all the protected
mode data structures properly.

Because the GDT and TSS addresses are virtual, the page tables now always
exist at the time of vcpu setup.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +-
 tools/testing/selftests/kvm/include/x86.h          |  11 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         |   4 +-
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   5 +-
 tools/testing/selftests/kvm/lib/x86.c              | 111 +++++++++++++--------
 5 files changed, 86 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 637b7017b6ee..87e05664c7f9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -75,7 +75,7 @@ void vcpu_ioctl(struct kvm_vm *vm,
 	uint32_t vcpuid, unsigned long ioctl, void *arg);
 void vm_ioctl(struct kvm_vm *vm, unsigned long ioctl, void *arg);
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
-void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
+void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, int pgd_memslot, int gdt_memslot);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 	uint32_t data_memslot, uint32_t pgd_memslot);
 void *addr_gpa2hva(struct kvm_vm *vm, vm_paddr_t gpa);
diff --git a/tools/testing/selftests/kvm/include/x86.h b/tools/testing/selftests/kvm/include/x86.h
index 4a5b2c4c1a0f..d8788ddb0210 100644
--- a/tools/testing/selftests/kvm/include/x86.h
+++ b/tools/testing/selftests/kvm/include/x86.h
@@ -56,8 +56,8 @@ enum x86_register {
 struct desc64 {
 	uint16_t limit0;
 	uint16_t base0;
-	unsigned base1:8, type:5, dpl:2, p:1;
-	unsigned limit1:4, zero0:3, g:1, base2:8;
+	unsigned base1:8, s:1, type:4, dpl:2, p:1;
+	unsigned limit1:4, avl:1, l:1, db:1, g:1, base2:8;
 	uint32_t base3;
 	uint32_t zero1;
 } __attribute__((packed));
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 37e2a787d2fc..610d1326f03d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -701,7 +701,7 @@ static int vcpu_mmap_sz(void)
  * Creates and adds to the VM specified by vm and virtual CPU with
  * the ID given by vcpuid.
  */
-void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
+void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid, int pgd_memslot, int gdt_memslot)
 {
 	struct vcpu *vcpu;
 
@@ -736,7 +736,7 @@ void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid)
 	vcpu->next = vm->vcpu_head;
 	vm->vcpu_head = vcpu;
 
-	vcpu_setup(vm, vcpuid);
+	vcpu_setup(vm, vcpuid, pgd_memslot, gdt_memslot);
 }
 
 /* VM Virtual Address Unused Gap
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index a0bd1980c81c..cbb40288890a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -51,13 +51,16 @@ struct kvm_vm {
 	struct userspace_mem_region *userspace_mem_region_head;
 	struct sparsebit *vpages_valid;
 	struct sparsebit *vpages_mapped;
+
 	bool pgd_created;
 	vm_paddr_t pgd;
+	vm_vaddr_t gdt;
+	vm_vaddr_t tss;
 };
 
 struct vcpu *vcpu_find(struct kvm_vm *vm,
 	uint32_t vcpuid);
-void vcpu_setup(struct kvm_vm *vm, int vcpuid);
+void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_memslot);
 void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent);
 void regs_dump(FILE *stream, struct kvm_regs *regs,
 	uint8_t indent);
diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
index 2f17675f4275..024e95f1b470 100644
--- a/tools/testing/selftests/kvm/lib/x86.c
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -239,25 +239,6 @@ void virt_pgd_alloc(struct kvm_vm *vm, uint32_t pgd_memslot)
 		vm_paddr_t paddr = vm_phy_page_alloc(vm,
 			KVM_GUEST_PAGE_TABLE_MIN_PADDR, pgd_memslot);
 		vm->pgd = paddr;
-
-		/* Set pointer to pgd tables in all the VCPUs that
-		 * have already been created.  Future VCPUs will have
-		 * the value set as each one is created.
-		 */
-		for (struct vcpu *vcpu = vm->vcpu_head; vcpu;
-			vcpu = vcpu->next) {
-			struct kvm_sregs sregs;
-
-			/* Obtain the current system register settings */
-			vcpu_sregs_get(vm, vcpu->id, &sregs);
-
-			/* Set and store the pointer to the start of the
-			 * pgd tables.
-			 */
-			sregs.cr3 = vm->pgd;
-			vcpu_sregs_set(vm, vcpu->id, &sregs);
-		}
-
 		vm->pgd_created = true;
 	}
 }
@@ -460,9 +441,32 @@ static void kvm_seg_set_unusable(struct kvm_segment *segp)
 	segp->unusable = true;
 }
 
+static void kvm_seg_fill_gdt_64bit(struct kvm_vm *vm, struct kvm_segment *segp)
+{
+	void *gdt = addr_gva2hva(vm, vm->gdt);
+	struct desc64 *desc = gdt + (segp->selector >> 3) * 8;
+
+	desc->limit0 = segp->limit & 0xFFFF;
+	desc->base0 = segp->base & 0xFFFF;
+	desc->base1 = segp->base >> 16;
+	desc->s = segp->s;
+	desc->type = segp->type;
+	desc->dpl = segp->dpl;
+	desc->p = segp->present;
+	desc->limit1 = segp->limit >> 16;
+	desc->l = segp->l;
+	desc->db = segp->db;
+	desc->g = segp->g;
+	desc->base2 = segp->base >> 24;
+	if (!segp->s)
+		desc->base3 = segp->base >> 32;
+}
+
+
 /* Set Long Mode Flat Kernel Code Segment
  *
  * Input Args:
+ *   vm - VM whose GDT is being filled, or NULL to only write segp
  *   selector - selector value
  *
  * Output Args:
@@ -473,7 +477,7 @@ static void kvm_seg_set_unusable(struct kvm_segment *segp)
  * Sets up the KVM segment pointed to by segp, to be a code segment
  * with the selector value given by selector.
  */
-static void kvm_seg_set_kernel_code_64bit(uint16_t selector,
+static void kvm_seg_set_kernel_code_64bit(struct kvm_vm *vm, uint16_t selector,
 	struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
@@ -486,11 +490,14 @@ static void kvm_seg_set_kernel_code_64bit(uint16_t selector,
 	segp->g = true;
 	segp->l = true;
 	segp->present = 1;
+	if (vm)
+		kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
 /* Set Long Mode Flat Kernel Data Segment
  *
  * Input Args:
+ *   vm - VM whose GDT is being filled, or NULL to only write segp
  *   selector - selector value
  *
  * Output Args:
@@ -501,7 +508,7 @@ static void kvm_seg_set_kernel_code_64bit(uint16_t selector,
  * Sets up the KVM segment pointed to by segp, to be a data segment
  * with the selector value given by selector.
  */
-static void kvm_seg_set_kernel_data_64bit(uint16_t selector,
+static void kvm_seg_set_kernel_data_64bit(struct kvm_vm *vm, uint16_t selector,
 	struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
@@ -513,6 +520,8 @@ static void kvm_seg_set_kernel_data_64bit(uint16_t selector,
 					  */
 	segp->g = true;
 	segp->present = true;
+	if (vm)
+		kvm_seg_fill_gdt_64bit(vm, segp);
 }
 
 /* Address Guest Virtual to Guest Physical
@@ -575,13 +584,45 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 		    "gva: 0x%lx", gva);
 }
 
-void vcpu_setup(struct kvm_vm *vm, int vcpuid)
+static void kvm_setup_gdt(struct kvm_vm *vm, struct kvm_dtable *dt, int gdt_memslot,
+			  int pgd_memslot)
+{
+	if (!vm->gdt)
+		vm->gdt = vm_vaddr_alloc(vm, getpagesize(),
+			KVM_UTIL_MIN_VADDR, gdt_memslot, pgd_memslot);
+
+	dt->base = vm->gdt;
+	dt->limit = getpagesize();
+}
+
+static void kvm_setup_tss_64bit(struct kvm_vm *vm, struct kvm_segment *segp,
+				int selector, int gdt_memslot,
+				int pgd_memslot)
+{
+	if (!vm->tss)
+		vm->tss = vm_vaddr_alloc(vm, getpagesize(),
+			KVM_UTIL_MIN_VADDR, gdt_memslot, pgd_memslot);
+
+	memset(segp, 0, sizeof(*segp));
+	segp->base = vm->tss;
+	segp->limit = 0x67;
+	segp->selector = selector;
+	segp->type = 0xb;
+	segp->present = 1;
+	kvm_seg_fill_gdt_64bit(vm, segp);
+}
+
+void vcpu_setup(struct kvm_vm *vm, int vcpuid, int pgd_memslot, int gdt_memslot)
 {
 	struct kvm_sregs sregs;
 
 	/* Set mode specific system register values. */
 	vcpu_sregs_get(vm, vcpuid, &sregs);
 
+	sregs.idt.limit = 0;
+
+	kvm_setup_gdt(vm, &sregs.gdt, gdt_memslot, pgd_memslot);
+
 	switch (vm->mode) {
 	case VM_MODE_FLAT48PG:
 		sregs.cr0 = X86_CR0_PE | X86_CR0_NE | X86_CR0_PG;
@@ -589,30 +630,18 @@ void vcpu_setup(struct kvm_vm *vm, int vcpuid)
 		sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 		kvm_seg_set_unusable(&sregs.ldt);
-		kvm_seg_set_kernel_code_64bit(0x8, &sregs.cs);
-		kvm_seg_set_kernel_data_64bit(0x10, &sregs.ds);
-		kvm_seg_set_kernel_data_64bit(0x10, &sregs.es);
+		kvm_seg_set_kernel_code_64bit(vm, 0x8, &sregs.cs);
+		kvm_seg_set_kernel_data_64bit(vm, 0x10, &sregs.ds);
+		kvm_seg_set_kernel_data_64bit(vm, 0x10, &sregs.es);
+		kvm_setup_tss_64bit(vm, &sregs.tr, 0x18, gdt_memslot, pgd_memslot);
 		break;
 
 	default:
 		TEST_ASSERT(false, "Unknown guest mode, mode: 0x%x", vm->mode);
 	}
-	vcpu_sregs_set(vm, vcpuid, &sregs);
-
-	/* If virtual translation table have been setup, set system register
-	 * to point to the tables.  It's okay if they haven't been setup yet,
-	 * in that the code that sets up the virtual translation tables, will
-	 * go back through any VCPUs that have already been created and set
-	 * their values.
-	 */
-	if (vm->pgd_created) {
-		struct kvm_sregs sregs;
 
-		vcpu_sregs_get(vm, vcpuid, &sregs);
-
-		sregs.cr3 = vm->pgd;
-		vcpu_sregs_set(vm, vcpuid, &sregs);
-	}
+	sregs.cr3 = vm->pgd;
+	vcpu_sregs_set(vm, vcpuid, &sregs);
 }
 /* Adds a vCPU with reasonable defaults (i.e., a stack)
  *
@@ -629,7 +658,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
 				     DEFAULT_GUEST_STACK_VADDR_MIN, 0, 0);
 
 	/* Create VCPU */
-	vm_vcpu_add(vm, vcpuid);
+	vm_vcpu_add(vm, vcpuid, 0, 0);
 
 	/* Setup guest general purpose registers */
 	vcpu_regs_get(vm, vcpuid, &regs);
-- 
1.8.3.1

