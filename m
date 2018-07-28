Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CF7C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E9920878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjnh7LSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E9920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeG2Aig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54847 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbeG2Aif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so9080718wmb.4;
        Sat, 28 Jul 2018 16:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ScVvJXpNPQb/WQvL4Z/M3mQPq/fd/NsdzqV6KWYQts=;
        b=Jjnh7LSaebwT8AyKzEZVcjKFZVt3UkDIBk5940zCygl4o5XteStlPpOt/geC9RNzDA
         hjfVXFR+UbkwtaD/gujFyl2hi3+wxTN0FIxZUp2omfjHLmQBQpElZ+fZwp6hK2tc5jWQ
         81qvGv2Gr5Y8JFbX1smQqWaq4+gyQpbV8mmCgz6gYffCWqXnFUxZvS9btaFjJyrszukE
         JCIgvwC4k+3tkMkjTeh8LJdfyBZBPfCVH6hE0xIDW6EQjeYdfhIH4T81lJz2u+0yHcw+
         edIMRplKQfZYaPwrZciMQLQFe3matLKc0l5PdltvElUOCVfHjCn9gTabnQWJVf/4Ddme
         WXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/ScVvJXpNPQb/WQvL4Z/M3mQPq/fd/NsdzqV6KWYQts=;
        b=lzCut1kroGZXhTdSXpFxz5PtO9xml1vjLein2Eoe2nnp3PXSPN5ew/ogLDac81XWFd
         ebwk1ze4nhLjotQ2xQItvaaa9ZX9Ec4NduhdHv+xOOCmd1ciwmEvwbrh+/xN5TrOh5TN
         +6q2le853rtjOzd64gGLWj13TxgslLPF8Ex7YlALQEHAIE568ImVXvWMEUIkmjjGht/8
         Tk3sw+fB7kXBJLFw6exLuKcUN34NDy/Oeak6XugFws0MtkLnLv2biO1JlctRbQv6aROO
         +ZH67oNma5PGVRN6xOwtpHlhb0yIhuHp3NQT1RqduyIFUAHPdY0H3EnX1vZ2LPeQTczm
         1FLg==
X-Gm-Message-State: AOUpUlE2OZmedquAXVArlxajhyoZh71PP6pWyZZ60p90j9h56D7v5Urs
        F4dQDooJzrvfhgV4+fSbfow06F4Z
X-Google-Smtp-Source: AAOMgpd/0YKPe1ItflaqVO/UpOQ+qYPpynLbG/xQiJRahjvU5s05lD5inoiOHI7ZCDFR3sQz4tPQwg==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr9923421wmg.50.1532819422439;
        Sat, 28 Jul 2018 16:10:22 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:21 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 05/10] kvm: selftests: add basic test for state save and restore
Date:   Sun, 29 Jul 2018 01:10:07 +0200
Message-Id: <1532819412-51357-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test calls KVM_RUN repeatedly, and creates an entirely new VM with the
old memory and vCPU state on every exit to userspace.  The kvm_util API is
expanded with two functions that manage the lifetime of a kvm_vm struct:
the first closes the file descriptors and leaves the memory allocated,
and the second opens the file descriptors and reuses the memory from
the previous incarnation of the kvm_vm struct.

For now the test is very basic, as it does not test for example XSAVE or
vCPU events.  However, it will test nested virtualization state starting
with the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/Makefile               |   1 +
 tools/testing/selftests/kvm/include/kvm_util.h     |   2 +
 tools/testing/selftests/kvm/include/x86.h          |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c         |  88 +++++++++++----
 .../testing/selftests/kvm/lib/kvm_util_internal.h  |   2 +
 tools/testing/selftests/kvm/lib/x86.c              | 122 +++++++++++++++++++++
 tools/testing/selftests/kvm/state_test.c           | 119 ++++++++++++++++++++
 7 files changed, 316 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/state_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 65bda4fb0ad6..dd0e5163f01f 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -10,6 +10,7 @@ TEST_GEN_PROGS_x86_64 = set_sregs_test
 TEST_GEN_PROGS_x86_64 += sync_regs_test
 TEST_GEN_PROGS_x86_64 += vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += cr4_cpuid_sync_test
+TEST_GEN_PROGS_x86_64 += state_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 87e05664c7f9..d32632f71ab8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -53,6 +53,8 @@ enum vm_mem_backing_src_type {
 
 struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm);
 void kvm_vm_free(struct kvm_vm *vmp);
+void kvm_vm_restart(struct kvm_vm *vmp, int perm);
+void kvm_vm_release(struct kvm_vm *vmp);
 
 int kvm_memcmp_hva_gva(void *hva,
 	struct kvm_vm *vm, const vm_vaddr_t gva, size_t len);
diff --git a/tools/testing/selftests/kvm/include/x86.h b/tools/testing/selftests/kvm/include/x86.h
index d8788ddb0210..2559f6d2d683 100644
--- a/tools/testing/selftests/kvm/include/x86.h
+++ b/tools/testing/selftests/kvm/include/x86.h
@@ -310,6 +310,10 @@ static inline unsigned long get_xmm(int n)
 	return 0;
 }
 
+struct kvm_x86_state;
+struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid);
+void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *state);
+
 /*
  * Basic CPU control in CR0
  */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 163482873363..643309d6de74 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -62,6 +62,18 @@ int kvm_check_cap(long cap)
 	return ret;
 }
 
+static void vm_open(struct kvm_vm *vm, int perm)
+{
+	vm->kvm_fd = open(KVM_DEV_PATH, perm);
+	if (vm->kvm_fd < 0)
+		exit(KSFT_SKIP);
+
+	/* Create VM. */
+	vm->fd = ioctl(vm->kvm_fd, KVM_CREATE_VM, NULL);
+	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
+		"rc: %i errno: %i", vm->fd, errno);
+}
+
 /* VM Create
  *
  * Input Args:
@@ -90,16 +102,7 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	TEST_ASSERT(vm != NULL, "Insufficent Memory");
 
 	vm->mode = mode;
-	kvm_fd = open(KVM_DEV_PATH, perm);
-	if (kvm_fd < 0)
-		exit(KSFT_SKIP);
-
-	/* Create VM. */
-	vm->fd = ioctl(kvm_fd, KVM_CREATE_VM, NULL);
-	TEST_ASSERT(vm->fd >= 0, "KVM_CREATE_VM ioctl failed, "
-		"rc: %i errno: %i", vm->fd, errno);
-
-	close(kvm_fd);
+	vm_open(vm, perm);
 
 	/* Setup mode specific traits. */
 	switch (vm->mode) {
@@ -132,6 +135,39 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	return vm;
 }
 
+/* VM Restart
+ *
+ * Input Args:
+ *   vm - VM that has been released before
+ *   perm - permission
+ *
+ * Output Args: None
+ *
+ * Reopens the file descriptors associated to the VM and reinstates the
+ * global state, such as the irqchip and the memory regions that are mapped
+ * into the guest.
+ */
+void kvm_vm_restart(struct kvm_vm *vmp, int perm)
+{
+	struct userspace_mem_region *region;
+
+	vm_open(vmp, perm);
+	if (vmp->has_irqchip)
+		vm_create_irqchip(vmp);
+
+	for (region = vmp->userspace_mem_region_head; region;
+		region = region->next) {
+		int ret = ioctl(vmp->fd, KVM_SET_USER_MEMORY_REGION, &region->region);
+		TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
+			    "  rc: %i errno: %i\n"
+			    "  slot: %u flags: 0x%x\n"
+			    "  guest_phys_addr: 0x%lx size: 0x%lx",
+			    ret, errno, region->region.slot, region->region.flags,
+			    region->region.guest_phys_addr,
+			    region->region.memory_size);
+	}
+}
+
 /* Userspace Memory Region Find
  *
  * Input Args:
@@ -256,6 +292,23 @@ static void vm_vcpu_rm(struct kvm_vm *vm, uint32_t vcpuid)
 	free(vcpu);
 }
 
+void kvm_vm_release(struct kvm_vm *vmp)
+{
+	int ret;
+
+	/* Free VCPUs. */
+	while (vmp->vcpu_head)
+		vm_vcpu_rm(vmp, vmp->vcpu_head->id);
+
+	/* Close file descriptor for the VM. */
+	ret = close(vmp->fd);
+	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
+		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
+
+	close(vmp->kvm_fd);
+	TEST_ASSERT(ret == 0, "Close of /dev/kvm fd failed,\n"
+		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
+}
 
 /* Destroys and frees the VM pointed to by vmp.
  */
@@ -286,22 +339,11 @@ void kvm_vm_free(struct kvm_vm *vmp)
 		free(region);
 	}
 
-	/* Free VCPUs. */
-	while (vmp->vcpu_head)
-		vm_vcpu_rm(vmp, vmp->vcpu_head->id);
-
 	/* Free sparsebit arrays. */
 	sparsebit_free(&vmp->vpages_valid);
 	sparsebit_free(&vmp->vpages_mapped);
 
-	/* Close file descriptor for the VM. */
-	ret = close(vmp->fd);
-	TEST_ASSERT(ret == 0, "Close of vm fd failed,\n"
-		"  vmp->fd: %i rc: %i errno: %i", vmp->fd, ret, errno);
-
-	close(vmp->kvm_fd);
-	TEST_ASSERT(ret == 0, "Close of /dev/kvm fd failed,\n"
-		"  vmp->kvm_fd: %i rc: %i errno: %i", vmp->kvm_fd, ret, errno);
+	kvm_vm_release(vmp);
 
 	/* Free the structure describing the VM. */
 	free(vmp);
@@ -965,6 +1007,8 @@ void vm_create_irqchip(struct kvm_vm *vm)
 	ret = ioctl(vm->fd, KVM_CREATE_IRQCHIP, 0);
 	TEST_ASSERT(ret == 0, "KVM_CREATE_IRQCHIP IOCTL failed, "
 		"rc: %i errno: %i", ret, errno);
+
+	vm->has_irqchip = true;
 }
 
 /* VM VCPU State
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index cbb40288890a..542ed606b338 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -43,6 +43,7 @@ struct vcpu {
 
 struct kvm_vm {
 	int mode;
+	int kvm_fd;
 	int fd;
 	unsigned int page_size;
 	unsigned int page_shift;
@@ -52,6 +53,7 @@ struct kvm_vm {
 	struct sparsebit *vpages_valid;
 	struct sparsebit *vpages_mapped;
 
+	bool has_irqchip;
 	bool pgd_created;
 	vm_paddr_t pgd;
 	vm_vaddr_t gdt;
diff --git a/tools/testing/selftests/kvm/lib/x86.c b/tools/testing/selftests/kvm/lib/x86.c
index 024e95f1b470..78aabcb91de1 100644
--- a/tools/testing/selftests/kvm/lib/x86.c
+++ b/tools/testing/selftests/kvm/lib/x86.c
@@ -727,3 +727,119 @@ struct kvm_vm *vm_create_default(uint32_t vcpuid, void *guest_code)
 
 	return vm;
 }
+
+struct kvm_x86_state {
+	struct kvm_vcpu_events events;
+	struct kvm_mp_state mp_state;
+	struct kvm_regs regs;
+	struct kvm_xsave xsave;
+	struct kvm_xcrs xcrs;
+	struct kvm_sregs sregs;
+	struct kvm_debugregs debugregs;
+	struct kvm_msrs msrs;
+};
+
+static int kvm_get_num_msrs(struct kvm_vm *vm)
+{
+	struct kvm_msr_list nmsrs;
+	int r;
+
+	nmsrs.nmsrs = 0;
+	r = ioctl(vm->kvm_fd, KVM_GET_MSR_INDEX_LIST, &nmsrs);
+	TEST_ASSERT(r == -1 && errno == E2BIG, "Unexpected result from KVM_GET_MSR_INDEX_LIST probe, r: %i",
+		r);
+
+	return nmsrs.nmsrs;
+}
+
+struct kvm_x86_state *vcpu_save_state(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	struct kvm_msr_list *list;
+	struct kvm_x86_state *state;
+	int nmsrs, r, i;
+
+	nmsrs = kvm_get_num_msrs(vm);
+	list = malloc(sizeof(*list) + nmsrs * sizeof(list->indices[0]));
+	list->nmsrs = nmsrs;
+	r = ioctl(vm->kvm_fd, KVM_GET_MSR_INDEX_LIST, list);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_MSR_INDEX_LIST, r: %i",
+                r);
+
+	state = malloc(sizeof(*state) + nmsrs * sizeof(state->msrs.entries[0]));
+	r = ioctl(vcpu->fd, KVM_GET_VCPU_EVENTS, &state->events);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_VCPU_EVENTS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_GET_MP_STATE, &state->mp_state);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_MP_STATE, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_GET_REGS, &state->regs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_REGS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_GET_XSAVE, &state->xsave);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XSAVE, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_GET_XCRS, &state->xcrs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_XCRS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_GET_SREGS, &state->sregs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_SREGS, r: %i",
+                r);
+
+	state->msrs.nmsrs = nmsrs;
+	for (i = 0; i < nmsrs; i++)
+		state->msrs.entries[i].index = list->indices[i];
+	r = ioctl(vcpu->fd, KVM_GET_MSRS, &state->msrs);
+        TEST_ASSERT(r == nmsrs, "Unexpected result from KVM_GET_MSRS, r: %i (failed at %x)",
+                r, r == nmsrs ? -1 : list->indices[r]);
+
+	r = ioctl(vcpu->fd, KVM_GET_DEBUGREGS, &state->debugregs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_GET_DEBUGREGS, r: %i",
+                r);
+
+	free(list);
+	return state;
+}
+
+void vcpu_load_state(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_x86_state *state)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+	int r;
+
+	r = ioctl(vcpu->fd, KVM_SET_XSAVE, &state->xsave);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XSAVE, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_XCRS, &state->xcrs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_XCRS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_SREGS, &state->sregs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_SREGS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_MSRS, &state->msrs);
+        TEST_ASSERT(r == state->msrs.nmsrs, "Unexpected result from KVM_SET_MSRS, r: %i (failed at %x)",
+                r, r == state->msrs.nmsrs ? -1 : state->msrs.entries[r].index);
+
+	r = ioctl(vcpu->fd, KVM_SET_VCPU_EVENTS, &state->events);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_VCPU_EVENTS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_MP_STATE, &state->mp_state);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_MP_STATE, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_DEBUGREGS, &state->debugregs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_DEBUGREGS, r: %i",
+                r);
+
+	r = ioctl(vcpu->fd, KVM_SET_REGS, &state->regs);
+        TEST_ASSERT(r == 0, "Unexpected result from KVM_SET_REGS, r: %i",
+                r);
+}
diff --git a/tools/testing/selftests/kvm/state_test.c b/tools/testing/selftests/kvm/state_test.c
new file mode 100644
index 000000000000..e47b27b5406e
--- /dev/null
+++ b/tools/testing/selftests/kvm/state_test.c
@@ -0,0 +1,119 @@
+/*
+ * KVM_GET/SET_* tests
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ *
+ * Tests for vCPU state save/restore, including nested guest state.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "x86.h"
+
+#define VCPU_ID		5
+#define PORT_SYNC	0x1000
+#define PORT_ABORT	0x1001
+#define PORT_DONE	0x1002
+
+static inline void __exit_to_l0(uint16_t port, uint64_t arg0, uint64_t arg1)
+{
+	__asm__ __volatile__("in %[port], %%al"
+			     :
+			     : [port]"d"(port), "D"(arg0), "S"(arg1)
+			     : "rax");
+}
+
+#define exit_to_l0(_port, _arg0, _arg1) \
+	__exit_to_l0(_port, (uint64_t) (_arg0), (uint64_t) (_arg1))
+
+#define GUEST_ASSERT(_condition) do { \
+	if (!(_condition)) \
+		exit_to_l0(PORT_ABORT, "Failed guest assert: " #_condition, __LINE__);\
+} while (0)
+
+#define GUEST_SYNC(stage) \
+	exit_to_l0(PORT_SYNC, "hello", stage);
+
+static bool have_nested_state;
+
+void guest_code(void)
+{
+	GUEST_SYNC(1);
+	GUEST_SYNC(2);
+
+	exit_to_l0(PORT_DONE, 0, 0);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_regs regs1, regs2;
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_x86_state *state;
+	int stage;
+
+	struct kvm_cpuid_entry2 *entry = kvm_get_supported_cpuid_entry(1);
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, guest_code);
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	run = vcpu_state(vm, VCPU_ID);
+
+	vcpu_regs_get(vm, VCPU_ID, &regs1);
+	for (stage = 1;; stage++) {
+		_vcpu_run(vm, VCPU_ID);
+		TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
+			    "Unexpected exit reason: %u (%s),\n",
+			    run->exit_reason,
+			    exit_reason_str(run->exit_reason));
+
+		memset(&regs1, 0, sizeof(regs1));
+		vcpu_regs_get(vm, VCPU_ID, &regs1);
+		switch (run->io.port) {
+		case PORT_ABORT:
+			TEST_ASSERT(false, "%s at %s:%d", (const char *) regs1.rdi,
+				    __FILE__, regs1.rsi);
+			/* NOT REACHED */
+		case PORT_SYNC:
+			break;
+		case PORT_DONE:
+			goto done;
+		default:
+			TEST_ASSERT(false, "Unknown port 0x%x.", run->io.port);
+		}
+
+		/* PORT_SYNC is handled here.  */
+		TEST_ASSERT(!strcmp((const char *)regs1.rdi, "hello") &&
+			    regs1.rsi == stage, "Unexpected register values vmexit #%lx, got %lx",
+			    stage, (ulong) regs1.rsi);
+
+		state = vcpu_save_state(vm, VCPU_ID);
+		kvm_vm_release(vm);
+
+		/* Restore state in a new VM.  */
+		kvm_vm_restart(vm, O_RDWR);
+		vm_vcpu_add(vm, VCPU_ID, 0, 0);
+		vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+		vcpu_load_state(vm, VCPU_ID, state);
+		run = vcpu_state(vm, VCPU_ID);
+		free(state);
+
+		memset(&regs2, 0, sizeof(regs2));
+		vcpu_regs_get(vm, VCPU_ID, &regs2);
+		TEST_ASSERT(!memcmp(&regs1, &regs2, sizeof(regs2)),
+			    "Unexpected register values after vcpu_load_state; rdi: %lx rsi: %lx",
+			    (ulong) regs2.rdi, (ulong) regs2.rsi);
+	}
+
+done:
+	kvm_vm_free(vm);
+}
-- 
1.8.3.1

