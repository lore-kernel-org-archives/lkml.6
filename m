Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1690823-1517938474-2-8166912697116858045
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517938473; b=u/0voIvpdeyfz0x89Ntc6e68VQqsHDJfTdPsN70VW9UVYaw
    1/7uSLhKWNq3vEoIs2uhA9klOv8UtXnbQMzGRUR7dbBiR1jKBkpjxVKKqdK45vdF
    8xVFU1OytxJaubxsf/oFlmUdwyxI2/JS5FRDbUySyT7s7Lnk5CsmRXXgQYiaqix9
    3sFi840u/PFApNctWzBIEr+ukspIy39M6bEbFkyNlyGyyPW1YCMg1h30YZbSQO7W
    rDh/ssAwroYHkU45GGkc2/Twh52jCEHt3Tbc/uwE/xO9vLz2zmd/lUQuI33ec2T2
    fGeQWhUfbZM+2f6cCNgAbIBDVsEPVaACFFLt9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517938473; bh=MmrDipP6Mu9YuVO8A/LM5lIgXkIUWMFnPeC8MVvB+eU=; b=T
    w5uLYbU0raNFK3nIM0uvm2pZox533FTBZfFA0KMola8IuIUFs5yHBKGauJOuPqZ1
    AA55dRMLe/oPc7IP8outKZy2siKuVs+uBy/48lOmzPcSihWFv+vXfOpFgTWqHy2N
    j+nItO+8QKkz3EdXMaAFysogzUj8vYW0MkedT/C+ums0Tnz2LkZsvPin8jI8JMbN
    DEvobsnFXJ/JD7J3uDAZS5OmXAFaao2brrimPBFMmFqfTWhn1Ensr6R6kUF2rIIy
    TUippE73kXD3FmRwaSmCx3aIeRX+KeL7l9H4PYhtWbSNec6FUXwJgREvElYvcsL+
    jiC8TEbg6MJZDW8lR+JZg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=sPekm+Ep x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=sPekm+Ep x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBFRaJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:30:09 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44320 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeBFR3y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:29:54 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="330970449"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 3/9] KVM: nVMX: Eliminate vmcs02 pool
Date: Tue,  6 Feb 2018 17:29:35 +0000
Message-Id: <1517938181-15317-4-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jim Mattson <jmattson@google.com>

The potential performance advantages of a vmcs02 pool have never been
realized. To simplify the code, eliminate the pool. Instead, a single
vmcs02 is allocated per VCPU when the VCPU enters VMX operation.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
Reviewed-by: Ameya More <ameya.more@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>

(cherry picked from commit de3a0021a60635de96aa92713c1a31a96747d72c)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx.c | 146 +++++++++--------------------------------------------
 1 file changed, 23 insertions(+), 123 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9408ae8..55b1474 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -174,7 +174,6 @@ module_param(ple_window_max, int, S_IRUGO);
 extern const ulong vmx_return;
 
 #define NR_AUTOLOAD_MSRS 8
-#define VMCS02_POOL_SIZE 1
 
 struct vmcs {
 	u32 revision_id;
@@ -208,7 +207,7 @@ struct shared_msr_entry {
  * stored in guest memory specified by VMPTRLD, but is opaque to the guest,
  * which must access it using VMREAD/VMWRITE/VMCLEAR instructions.
  * More than one of these structures may exist, if L1 runs multiple L2 guests.
- * nested_vmx_run() will use the data here to build a vmcs02: a VMCS for the
+ * nested_vmx_run() will use the data here to build the vmcs02: a VMCS for the
  * underlying hardware which will be used to run L2.
  * This structure is packed to ensure that its layout is identical across
  * machines (necessary for live migration).
@@ -387,13 +386,6 @@ struct __packed vmcs12 {
  */
 #define VMCS12_SIZE 0x1000
 
-/* Used to remember the last vmcs02 used for some recently used vmcs12s */
-struct vmcs02_list {
-	struct list_head list;
-	gpa_t vmptr;
-	struct loaded_vmcs vmcs02;
-};
-
 /*
  * The nested_vmx structure is part of vcpu_vmx, and holds information we need
  * for correct emulation of VMX (i.e., nested VMX) on this vcpu.
@@ -420,15 +412,15 @@ struct nested_vmx {
 	 */
 	bool sync_shadow_vmcs;
 
-	/* vmcs02_list cache of VMCSs recently used to run L2 guests */
-	struct list_head vmcs02_pool;
-	int vmcs02_num;
 	bool change_vmcs01_virtual_x2apic_mode;
 	/* L2 must run next, and mustn't decide to exit to L1. */
 	bool nested_run_pending;
+
+	struct loaded_vmcs vmcs02;
+
 	/*
-	 * Guest pages referred to in vmcs02 with host-physical pointers, so
-	 * we must keep them pinned while L2 runs.
+	 * Guest pages referred to in the vmcs02 with host-physical
+	 * pointers, so we must keep them pinned while L2 runs.
 	 */
 	struct page *apic_access_page;
 	struct page *virtual_apic_page;
@@ -6682,94 +6674,6 @@ static int handle_monitor(struct kvm_vcpu *vcpu)
 }
 
 /*
- * To run an L2 guest, we need a vmcs02 based on the L1-specified vmcs12.
- * We could reuse a single VMCS for all the L2 guests, but we also want the
- * option to allocate a separate vmcs02 for each separate loaded vmcs12 - this
- * allows keeping them loaded on the processor, and in the future will allow
- * optimizations where prepare_vmcs02 doesn't need to set all the fields on
- * every entry if they never change.
- * So we keep, in vmx->nested.vmcs02_pool, a cache of size VMCS02_POOL_SIZE
- * (>=0) with a vmcs02 for each recently loaded vmcs12s, most recent first.
- *
- * The following functions allocate and free a vmcs02 in this pool.
- */
-
-/* Get a VMCS from the pool to use as vmcs02 for the current vmcs12. */
-static struct loaded_vmcs *nested_get_current_vmcs02(struct vcpu_vmx *vmx)
-{
-	struct vmcs02_list *item;
-	list_for_each_entry(item, &vmx->nested.vmcs02_pool, list)
-		if (item->vmptr == vmx->nested.current_vmptr) {
-			list_move(&item->list, &vmx->nested.vmcs02_pool);
-			return &item->vmcs02;
-		}
-
-	if (vmx->nested.vmcs02_num >= max(VMCS02_POOL_SIZE, 1)) {
-		/* Recycle the least recently used VMCS. */
-		item = list_last_entry(&vmx->nested.vmcs02_pool,
-				       struct vmcs02_list, list);
-		item->vmptr = vmx->nested.current_vmptr;
-		list_move(&item->list, &vmx->nested.vmcs02_pool);
-		return &item->vmcs02;
-	}
-
-	/* Create a new VMCS */
-	item = kmalloc(sizeof(struct vmcs02_list), GFP_KERNEL);
-	if (!item)
-		return NULL;
-	item->vmcs02.vmcs = alloc_vmcs();
-	item->vmcs02.shadow_vmcs = NULL;
-	if (!item->vmcs02.vmcs) {
-		kfree(item);
-		return NULL;
-	}
-	loaded_vmcs_init(&item->vmcs02);
-	item->vmptr = vmx->nested.current_vmptr;
-	list_add(&(item->list), &(vmx->nested.vmcs02_pool));
-	vmx->nested.vmcs02_num++;
-	return &item->vmcs02;
-}
-
-/* Free and remove from pool a vmcs02 saved for a vmcs12 (if there is one) */
-static void nested_free_vmcs02(struct vcpu_vmx *vmx, gpa_t vmptr)
-{
-	struct vmcs02_list *item;
-	list_for_each_entry(item, &vmx->nested.vmcs02_pool, list)
-		if (item->vmptr == vmptr) {
-			free_loaded_vmcs(&item->vmcs02);
-			list_del(&item->list);
-			kfree(item);
-			vmx->nested.vmcs02_num--;
-			return;
-		}
-}
-
-/*
- * Free all VMCSs saved for this vcpu, except the one pointed by
- * vmx->loaded_vmcs. We must be running L1, so vmx->loaded_vmcs
- * must be &vmx->vmcs01.
- */
-static void nested_free_all_saved_vmcss(struct vcpu_vmx *vmx)
-{
-	struct vmcs02_list *item, *n;
-
-	WARN_ON(vmx->loaded_vmcs != &vmx->vmcs01);
-	list_for_each_entry_safe(item, n, &vmx->nested.vmcs02_pool, list) {
-		/*
-		 * Something will leak if the above WARN triggers.  Better than
-		 * a use-after-free.
-		 */
-		if (vmx->loaded_vmcs == &item->vmcs02)
-			continue;
-
-		free_loaded_vmcs(&item->vmcs02);
-		list_del(&item->list);
-		kfree(item);
-		vmx->nested.vmcs02_num--;
-	}
-}
-
-/*
  * The following 3 functions, nested_vmx_succeed()/failValid()/failInvalid(),
  * set the success or error code of an emulated VMX instruction, as specified
  * by Vol 2B, VMX Instruction Reference, "Conventions".
@@ -7082,6 +6986,12 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	vmx->nested.vmcs02.vmcs = alloc_vmcs();
+	vmx->nested.vmcs02.shadow_vmcs = NULL;
+	if (!vmx->nested.vmcs02.vmcs)
+		goto out_vmcs02;
+	loaded_vmcs_init(&vmx->nested.vmcs02);
+
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
 				(unsigned long *)__get_free_page(GFP_KERNEL);
@@ -7104,9 +7014,6 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		vmx->vmcs01.shadow_vmcs = shadow_vmcs;
 	}
 
-	INIT_LIST_HEAD(&(vmx->nested.vmcs02_pool));
-	vmx->nested.vmcs02_num = 0;
-
 	hrtimer_init(&vmx->nested.preemption_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL_PINNED);
 	vmx->nested.preemption_timer.function = vmx_preemption_timer_fn;
@@ -7124,6 +7031,9 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	free_page((unsigned long)vmx->nested.msr_bitmap);
 
 out_msr_bitmap:
+	free_loaded_vmcs(&vmx->nested.vmcs02);
+
+out_vmcs02:
 	return -ENOMEM;
 }
 
@@ -7209,7 +7119,7 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->vmcs01.shadow_vmcs = NULL;
 	}
 	kfree(vmx->nested.cached_vmcs12);
-	/* Unpin physical memory we referred to in current vmcs02 */
+	/* Unpin physical memory we referred to in the vmcs02 */
 	if (vmx->nested.apic_access_page) {
 		nested_release_page(vmx->nested.apic_access_page);
 		vmx->nested.apic_access_page = NULL;
@@ -7225,7 +7135,7 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
-	nested_free_all_saved_vmcss(vmx);
+	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
 /* Emulate the VMXOFF instruction */
@@ -7259,8 +7169,6 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
 
-	nested_free_vmcs02(vmx, vmptr);
-
 	skip_emulated_instruction(vcpu);
 	nested_vmx_succeed(vcpu);
 	return 1;
@@ -8049,10 +7957,11 @@ static bool nested_vmx_exit_handled(struct kvm_vcpu *vcpu)
 
 	/*
 	 * The host physical addresses of some pages of guest memory
-	 * are loaded into VMCS02 (e.g. L1's Virtual APIC Page). The CPU
-	 * may write to these pages via their host physical address while
-	 * L2 is running, bypassing any address-translation-based dirty
-	 * tracking (e.g. EPT write protection).
+	 * are loaded into the vmcs02 (e.g. vmcs12's Virtual APIC
+	 * Page). The CPU may write to these pages via their host
+	 * physical address while L2 is running, bypassing any
+	 * address-translation-based dirty tracking (e.g. EPT write
+	 * protection).
 	 *
 	 * Mark them dirty on every exit from L2 to prevent them from
 	 * getting out of sync with dirty tracking.
@@ -10221,7 +10130,6 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	struct vmcs12 *vmcs12;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	int cpu;
-	struct loaded_vmcs *vmcs02;
 	bool ia32e;
 	u32 msr_entry_idx;
 
@@ -10361,17 +10269,13 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	 * the nested entry.
 	 */
 
-	vmcs02 = nested_get_current_vmcs02(vmx);
-	if (!vmcs02)
-		return -ENOMEM;
-
 	enter_guest_mode(vcpu);
 
 	if (!(vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS))
 		vmx->nested.vmcs01_debugctl = vmcs_read64(GUEST_IA32_DEBUGCTL);
 
 	cpu = get_cpu();
-	vmx->loaded_vmcs = vmcs02;
+	vmx->loaded_vmcs = &vmx->nested.vmcs02;
 	vmx_vcpu_put(vcpu);
 	vmx_vcpu_load(vcpu, cpu);
 	vcpu->cpu = cpu;
@@ -10886,10 +10790,6 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	vm_exit_controls_reset_shadow(vmx);
 	vmx_segment_cache_clear(vmx);
 
-	/* if no vmcs02 cache requested, remove the one we used */
-	if (VMCS02_POOL_SIZE == 0)
-		nested_free_vmcs02(vmx, vmx->nested.current_vmptr);
-
 	load_vmcs12_host_state(vcpu, vmcs12);
 
 	/* Update any VMCS fields that might have changed while L2 ran */
-- 
2.7.4
