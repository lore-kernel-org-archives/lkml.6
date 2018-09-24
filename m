Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09DE2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK1WZ31t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09DE2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeIXVjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:39:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46842 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbeIXVjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:39:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so8325247wrr.13;
        Mon, 24 Sep 2018 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=0BkH5m0GuqqcfqME6Xifhw9fwDwbf5Zilx/nd6W+4j8=;
        b=TK1WZ31t9ThTfmFuFoGhTv6Ub3m7Wym6nOS8vIBX86V3u0fSD7A2oiGXRLaQ4lwqio
         ehd5iUhA1LRQZnZLH+z2ZvJU5kU+DBT5549QbxUJQE62vU3Q4WlPsVWaC8S4UXrTeEtK
         rE+JmkhHYlNK0hXkTHNhXugd5XVIjHz/jjCVT3Xm9FulUxNKfeH0HeK/FWwNVKLtkdgG
         MZB6JPgDUVOR1EVm4uebMhKzwPJaNbh9NRQoxpzOECduKU5wFAt4BFLwlkEldSinbgZq
         CQz/Ug05WHO4vQWxJs7M2cuFb5HVCaxuuZPD6XPLppFtXoy2ZwfbaAxLrZ6fvvRbi8dx
         AftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=0BkH5m0GuqqcfqME6Xifhw9fwDwbf5Zilx/nd6W+4j8=;
        b=NNbdbjK1TMRaUrQaKiw8pi+gS6S81xtrK7KkUdMLI9ljjx74c/+oZfm2bcEYO0Tz2o
         FTIHeB3t/OwOG/t6zxfu6rkjmrMsnZcy+ZUD/gxqIar6yOhPCJXvkenqct3dnDSxcbJ6
         i4F4DVBhRRar1VoFKmCrKWKqFsgS2Pl6Pvw2E7hFDHZER0q95bOGUunIQRuncRKrpm+p
         Fp2SWJCtu6aEQYL+qKwIHCNkdLxk8yEMfsYwbaGoWHNqhztXQuv7fd+vXbZ+VbTW4NbB
         vhW/wpQaPoY7TRgOBQmKVasJC/TaCNzoQ7SGcP9ldi6iVATh/C+57WcqmrBtaxnujq8C
         wg4w==
X-Gm-Message-State: ABuFfohrZ1rLH+GCp5plkJGnLNk1AHB8BhCFFJt5kevLWzFtWM7oIp83
        xDZN1sbSQbCaSOLR24dKsVIwYG5C
X-Google-Smtp-Source: ACcGV63Hp9RP1QaZtlmwXZcEvOh4ZUEwbgRfrQxpIXK5gJheHss0RF+KrHRrl5aLcAJEY+QrgA+qEQ==
X-Received: by 2002:adf:ce0e:: with SMTP id p14-v6mr9917215wrn.118.1537803386338;
        Mon, 24 Sep 2018 08:36:26 -0700 (PDT)
Received: from 640k.lan (94-36-187-248.adsl-ull.clienti.tiscali.it. [94.36.187.248])
        by smtp.gmail.com with ESMTPSA id z141-v6sm10602149wmc.3.2018.09.24.08.36.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 08:36:25 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: never trap MSR_KERNEL_GS_BASE
Date:   Mon, 24 Sep 2018 17:36:24 +0200
Message-Id: <1537803384-17360-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM has an old optimization whereby accesses to the kernel GS base MSR
are trapped when the guest is in 32-bit and not when it is in 64-bit mode.
The idea is that swapgs is not available in 32-bit mode and thus the
guest has no reason to access the MSR unless in 64-bit mode.  Therefore
32-bit applications need not pay the price of switching the kernel GS
base between the host and the guest values, 64-bit applications.

However, this optimization adds complexity to the code for little
benefit (these days most guests are going to be 64-bit anyway) and in fact
broke after commit 678e315e78a7 ("KVM: vmx: add dedicated utility to
access guest's kernel_gs_base", 2018-08-06); the guest kernel GS base
is not restored correctly by the RSM instruction and UEFI Secure Boot
was broken.  This patch just removes the optimization; the kernel
GS base MSR is now never trapped by KVM, similarly to the FS and GS
base MSRs.

Fixes: 678e315e78a780dbef384b92339c8414309dbc11
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 06412ba46aa3..8b066480224b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -121,7 +121,6 @@
 
 #define MSR_BITMAP_MODE_X2APIC		1
 #define MSR_BITMAP_MODE_X2APIC_APICV	2
-#define MSR_BITMAP_MODE_LM		4
 
 #define KVM_VMX_TSC_MULTIPLIER_MAX     0xffffffffffffffffULL
 
@@ -2899,8 +2898,7 @@ static void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
 		vmx->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
 	}
 
-	if (is_long_mode(&vmx->vcpu))
-		wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+	wrmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #else
 	savesegment(fs, fs_sel);
 	savesegment(gs, gs_sel);
@@ -2951,8 +2949,7 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 	vmx->loaded_cpu_state = NULL;
 
 #ifdef CONFIG_X86_64
-	if (is_long_mode(&vmx->vcpu))
-		rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+	rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
 #endif
 	if (host_state->ldt_sel || (host_state->gs_sel & 7)) {
 		kvm_load_ldt(host_state->ldt_sel);
@@ -2980,24 +2977,19 @@ static void vmx_prepare_switch_to_host(struct vcpu_vmx *vmx)
 #ifdef CONFIG_X86_64
 static u64 vmx_read_guest_kernel_gs_base(struct vcpu_vmx *vmx)
 {
-	if (is_long_mode(&vmx->vcpu)) {
-		preempt_disable();
-		if (vmx->loaded_cpu_state)
-			rdmsrl(MSR_KERNEL_GS_BASE,
-			       vmx->msr_guest_kernel_gs_base);
-		preempt_enable();
-	}
+	preempt_disable();
+	if (vmx->loaded_cpu_state)
+		rdmsrl(MSR_KERNEL_GS_BASE, vmx->msr_guest_kernel_gs_base);
+	preempt_enable();
 	return vmx->msr_guest_kernel_gs_base;
 }
 
 static void vmx_write_guest_kernel_gs_base(struct vcpu_vmx *vmx, u64 data)
 {
-	if (is_long_mode(&vmx->vcpu)) {
-		preempt_disable();
-		if (vmx->loaded_cpu_state)
-			wrmsrl(MSR_KERNEL_GS_BASE, data);
-		preempt_enable();
-	}
+	preempt_disable();
+	if (vmx->loaded_cpu_state)
+		wrmsrl(MSR_KERNEL_GS_BASE, data);
+	preempt_enable();
 	vmx->msr_guest_kernel_gs_base = data;
 }
 #endif
@@ -5073,19 +5065,6 @@ static void vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 	if (!msr)
 		return;
 
-	/*
-	 * MSR_KERNEL_GS_BASE is not intercepted when the guest is in
-	 * 64-bit mode as a 64-bit kernel may frequently access the
-	 * MSR.  This means we need to manually save/restore the MSR
-	 * when switching between guest and host state, but only if
-	 * the guest is in 64-bit mode.  Sync our cached value if the
-	 * guest is transitioning to 32-bit mode and the CPU contains
-	 * guest state, i.e. the cache is stale.
-	 */
-#ifdef CONFIG_X86_64
-	if (!(efer & EFER_LMA))
-		(void)vmx_read_guest_kernel_gs_base(vmx);
-#endif
 	vcpu->arch.efer = efer;
 	if (efer & EFER_LMA) {
 		vm_entry_controls_setbit(to_vmx(vcpu), VM_ENTRY_IA32E_MODE);
@@ -6078,9 +6057,6 @@ static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
 			mode |= MSR_BITMAP_MODE_X2APIC_APICV;
 	}
 
-	if (is_long_mode(vcpu))
-		mode |= MSR_BITMAP_MODE_LM;
-
 	return mode;
 }
 
@@ -6121,9 +6097,6 @@ static void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu)
 	if (!changed)
 		return;
 
-	vmx_set_intercept_for_msr(msr_bitmap, MSR_KERNEL_GS_BASE, MSR_TYPE_RW,
-				  !(mode & MSR_BITMAP_MODE_LM));
-
 	if (changed & (MSR_BITMAP_MODE_X2APIC | MSR_BITMAP_MODE_X2APIC_APICV))
 		vmx_update_msr_bitmap_x2apic(msr_bitmap, mode);
 
-- 
1.8.3.1

