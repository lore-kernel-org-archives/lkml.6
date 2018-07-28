Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B34FC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AAC20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrJf7tsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AAC20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbeG2Ail (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45986 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbeG2Aik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id t13-v6so8667869wrv.12;
        Sat, 28 Jul 2018 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OJHV53Jb9s+O5ffmEab12ynBlpZtZGfRUuopwwQN1q4=;
        b=OrJf7tsJ5m9OX6z6kmPlFQT1qFSwi1OWKtujo8gT9l4YrWSNTy6pSTZgDk0Zmm0wIW
         xxmQkJbnpuek9iRl2fgEIPcYZnVpcG9pEWVI3e5z/B9oiJqcbREqw2veUHmXmGl1uXNM
         gk7pjjmnNowa6HcQD0Ut5jZQWm2K0OZNp7azU0DehMYaYZASjMISQAtLTJJVaFlAkR6J
         z3/9/serRS3WDEletue+i3F0/otdRaCjh0z+oC173RNV88DQL/gH9S5XxNcEpxHbQSKa
         vFAwmTH7/NEteTFfIZoG1o2VeDgYTfKdU2ShIYFupf5+9mx1Yn1O/D+zJeVhykfd0PMl
         lTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OJHV53Jb9s+O5ffmEab12ynBlpZtZGfRUuopwwQN1q4=;
        b=NZi9c/2MVadzytjBhw+riHYxRGGS3WujMsdFlWJCSIy7KLvOjKzHHhjH0q94krwAuE
         aNSN/VXh8FHLfJySKBz//qILTf+T1tsMjQtkpdBcSiROB4DY/1T3q5KSiBjq/xEL7qCo
         uYYegJ79NdNpQg1GBZf+8TQinhWjPTJvPzJIkJ7JLQqVdMAefY/hQdHsX1KROWkAr+mo
         ZrDgHSuGWBFPviwWBa46GlZFudV/Gnq4/MG8nXCw7CPHLS7WX/y85qM7Pan8CtooKRAf
         otXAogn1lKHIu0j+lt9wNIxQTzJprOjZCetQSuL58R89K62ByyesoZqxoFb70PeUCXKm
         J1Rw==
X-Gm-Message-State: AOUpUlGyUHh/RSb1ClFMLkXI5vyqdLclOUfCwmr8NBp+TSJntAfVhp3i
        R5yoGwr1X4yLnbkyRDAPJezBxEeI
X-Google-Smtp-Source: AAOMgpcdK3XIHo7LOgbbeHcCS69sKJq1MNW9KGO3SJXaw6W5uQdaVNME9KV0LETi7QGgLe0h0nTuBw==
X-Received: by 2002:adf:e992:: with SMTP id h18-v6mr10740885wrm.238.1532819428709;
        Sat, 28 Jul 2018 16:10:28 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:28 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 10/10] KVM: selftests: add tests for shadow VMCS save/restore
Date:   Sun, 29 Jul 2018 01:10:12 +0200
Message-Id: <1532819412-51357-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This includes setting up the shadow VMCS and the secondary execution
controls in lib/vmx.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tools/testing/selftests/kvm/include/vmx.h | 12 +++++++++++
 tools/testing/selftests/kvm/lib/vmx.c     | 33 +++++++++++++++++++++++++++---
 tools/testing/selftests/kvm/state_test.c  | 34 +++++++++++++++++++++++++++++--
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/vmx.h b/tools/testing/selftests/kvm/include/vmx.h
index 2b37f9b6f7df..02cdecf9560c 100644
--- a/tools/testing/selftests/kvm/include/vmx.h
+++ b/tools/testing/selftests/kvm/include/vmx.h
@@ -530,6 +530,18 @@ struct vmx_pages {
 	void *msr_hva;
 	uint64_t msr_gpa;
 	void *msr;
+
+	void *shadow_vmcs_hva;
+	uint64_t shadow_vmcs_gpa;
+	void *shadow_vmcs;
+
+	void *vmread_hva;
+	uint64_t vmread_gpa;
+	void *vmread;
+
+	void *vmwrite_hva;
+	uint64_t vmwrite_gpa;
+	void *vmwrite;
 };
 
 struct vmx_pages *vcpu_alloc_vmx(struct kvm_vm *vm, vm_vaddr_t *p_vmx_gva);
diff --git a/tools/testing/selftests/kvm/lib/vmx.c b/tools/testing/selftests/kvm/lib/vmx.c
index 5701e52a33ed..b987c3c970eb 100644
--- a/tools/testing/selftests/kvm/lib/vmx.c
+++ b/tools/testing/selftests/kvm/lib/vmx.c
@@ -44,6 +44,23 @@ struct vmx_pages *
 	vmx->msr = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
 	vmx->msr_hva = addr_gva2hva(vm, (uintptr_t)vmx->msr);
 	vmx->msr_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->msr);
+	memset(vmx->msr_hva, 0, getpagesize());
+
+	/* Setup of a region of guest memory for the shadow VMCS. */
+	vmx->shadow_vmcs = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->shadow_vmcs_hva = addr_gva2hva(vm, (uintptr_t)vmx->shadow_vmcs);
+	vmx->shadow_vmcs_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->shadow_vmcs);
+
+	/* Setup of a region of guest memory for the VMREAD and VMWRITE bitmaps. */
+	vmx->vmread = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->vmread_hva = addr_gva2hva(vm, (uintptr_t)vmx->vmread);
+	vmx->vmread_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmread);
+	memset(vmx->vmread_hva, 0, getpagesize());
+
+	vmx->vmwrite = (void *)vm_vaddr_alloc(vm, getpagesize(), 0x10000, 0, 0);
+	vmx->vmwrite_hva = addr_gva2hva(vm, (uintptr_t)vmx->vmwrite);
+	vmx->vmwrite_gpa = addr_gva2gpa(vm, (uintptr_t)vmx->vmwrite);
+	memset(vmx->vmwrite_hva, 0, getpagesize());
 
 	*p_vmx_gva = vmx_gva;
 	return vmx;
@@ -98,6 +115,11 @@ bool prepare_for_vmx_operation(struct vmx_pages *vmx)
 	if (vmptrld(vmx->vmcs_gpa))
 		return false;
 
+	/* Setup shadow VMCS, do not load it yet. */
+	*(uint32_t *)(vmx->shadow_vmcs) = vmcs_revision() | 0x80000000ul;
+	if (vmclear(vmx->shadow_vmcs_gpa))
+		return false;
+
 	return true;
 }
 
@@ -109,8 +131,12 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 	vmwrite(VIRTUAL_PROCESSOR_ID, 0);
 	vmwrite(POSTED_INTR_NV, 0);
 
-	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_PINBASED_CTLS));
-	vmwrite(CPU_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_PROCBASED_CTLS));
+	vmwrite(PIN_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PINBASED_CTLS));
+	if (!vmwrite(SECONDARY_VM_EXEC_CONTROL, 0))
+		vmwrite(CPU_BASED_VM_EXEC_CONTROL,
+			rdmsr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS) | CPU_BASED_ACTIVATE_SECONDARY_CONTROLS);
+	else
+		vmwrite(CPU_BASED_VM_EXEC_CONTROL, rdmsr(MSR_IA32_VMX_TRUE_PROCBASED_CTLS));
 	vmwrite(EXCEPTION_BITMAP, 0);
 	vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0);
 	vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1); /* Never match */
@@ -124,7 +150,6 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 	vmwrite(VM_ENTRY_MSR_LOAD_COUNT, 0);
 	vmwrite(VM_ENTRY_INTR_INFO_FIELD, 0);
 	vmwrite(TPR_THRESHOLD, 0);
-	vmwrite(SECONDARY_VM_EXEC_CONTROL, 0);
 
 	vmwrite(CR0_GUEST_HOST_MASK, 0);
 	vmwrite(CR4_GUEST_HOST_MASK, 0);
@@ -132,6 +157,8 @@ static inline void init_vmcs_control_fields(struct vmx_pages *vmx)
 	vmwrite(CR4_READ_SHADOW, get_cr4());
 
 	vmwrite(MSR_BITMAP, vmx->msr_gpa);
+	vmwrite(VMREAD_BITMAP, vmx->vmread_gpa);
+	vmwrite(VMWRITE_BITMAP, vmx->vmwrite_gpa);
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/state_test.c b/tools/testing/selftests/kvm/state_test.c
index 447da4f76b56..833319b06577 100644
--- a/tools/testing/selftests/kvm/state_test.c
+++ b/tools/testing/selftests/kvm/state_test.c
@@ -55,7 +55,15 @@ void l2_guest_code(void)
         /* Exit to L1 */
 	vmcall();
 
-	GUEST_SYNC(7);
+	/* L1 has now set up a shadow VMCS for us.  */
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+	GUEST_SYNC(9);
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0fffee));
+	GUEST_SYNC(10);
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0fffee);
+	GUEST_ASSERT(!vmwrite(GUEST_RIP, 0xc0ffffee));
+	GUEST_SYNC(11);
 
 	/* Done, exit to L1 and never come back.  */
 	vmcall();
@@ -96,9 +104,31 @@ void l1_guest_code(struct vmx_pages *vmx_pages)
 
 	vmwrite(GUEST_RIP, vmreadz(GUEST_RIP) + 3);
 
+	vmwrite(SECONDARY_VM_EXEC_CONTROL, SECONDARY_EXEC_SHADOW_VMCS);
+	vmwrite(VMCS_LINK_POINTER, vmx_pages->shadow_vmcs_gpa);
+
+	GUEST_ASSERT(!vmptrld(vmx_pages->shadow_vmcs_gpa));
+	GUEST_ASSERT(vmlaunch());
+	GUEST_SYNC(7);
+	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(vmresume());
+
+	vmwrite(GUEST_RIP, 0xc0ffee);
+	GUEST_SYNC(8);
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffee);
+
+	GUEST_ASSERT(!vmptrld(vmx_pages->vmcs_gpa));
 	GUEST_ASSERT(!vmresume());
 	GUEST_ASSERT(vmreadz(VM_EXIT_REASON) == EXIT_REASON_VMCALL);
-	GUEST_SYNC(8);
+
+	GUEST_ASSERT(!vmptrld(vmx_pages->shadow_vmcs_gpa));
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
+	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(vmresume());
+	GUEST_SYNC(12);
+	GUEST_ASSERT(vmreadz(GUEST_RIP) == 0xc0ffffee);
+	GUEST_ASSERT(vmlaunch());
+	GUEST_ASSERT(vmresume());
 }
 
 void guest_code(struct vmx_pages *vmx_pages)
-- 
1.8.3.1

