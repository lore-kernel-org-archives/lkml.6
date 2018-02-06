Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1654186-1517938411-2-15285860887898097457
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
    t=1517938411; b=DRzxoEcAN343vW+Q9svOPziaKc/xFFbIOjMCa8gH6qt60nw
    vjvoasVoWgHJuRQRhV2Pww0iNoj3BaFtQd25kZ6uUlknnVq7yseHBhRP8qyicZ8S
    Pfn36FYBrDgkRxiWNaOxkWDX1KG/jUgmKns+cJHhE70qkx85klwHtSxm9BUZ+VU+
    OSYRRX7BSCzzk3x9r7joLdHj8nw9PGmyLJ8Ay0c/7n0CZsMYlzqbLZt4ecNuCzfA
    /H+8IloewGAToYNLu9HPXdRTvjbZTXcRO2uvvjBbuJkzYSpbezkYQZvDYvFCMP3O
    hOzV0XtDOa5JsZ6wrjnkC3o5YyTwrm3LZNYY7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517938411; bh=LDqT38V5DXgoja9/63gBE7FhSoWq3x7MkvecY6PXbQQ=; b=B
    X6ahEqiEfo7AM8IHx9Cc3wjVbgn8ndrxNdKFq9wiuccd0x/AQjXxEyuam9AKKREH
    FFM5tbfM3QswQ1G6Eicswkajlc7Oirgb3HVgEbFOT4wBQmXSgYCKtL16GPQRYEwN
    CLxHoUHKGoa8fESDaZ49tCU6dAuub8sa42Q26x+HnO1CHy9dHBGd2JemOnkNyu+z
    NVhtQa4tZkMckh2W42RaRxQi1ee8Qz+QJb+lGcGzYqhJvoBFOT93bh3wYlZrIKqa
    XjqyhdQdXbSZPj2LWSTUvqvNDz4IJR506wIOxRkLOag1YFAlKl/j2+JgGW5c6ivF
    vLDcNcrQaFyD0Iw34ISJw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=OGzBjiTQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=OGzBjiTQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeBFRd3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:33:29 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:17659 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752907AbeBFRcO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:32:14 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="593672675"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 2/9] KVM: nVMX: mark vmcs12 pages dirty on L2 exit
Date: Tue,  6 Feb 2018 17:29:34 +0000
Message-Id: <1517938181-15317-3-git-send-email-dwmw@amazon.co.uk>
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

From: David Matlack <dmatlack@google.com>

The host physical addresses of L1's Virtual APIC Page and Posted
Interrupt descriptor are loaded into the VMCS02. The CPU may write
to these pages via their host physical address while L2 is running,
bypassing address-translation-based dirty tracking (e.g. EPT write
protection). Mark them dirty on every exit from L2 to prevent them
from getting out of sync with dirty tracking.

Also mark the virtual APIC page and the posted interrupt descriptor
dirty when KVM is virtualizing posted interrupt processing.

Signed-off-by: David Matlack <dmatlack@google.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>

(cherry picked from commit c9f04407f2e0b3fc9ff7913c65fcfcb0a4b61570)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx.c | 53 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index fd890af..9408ae8 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -4736,6 +4736,28 @@ static bool vmx_get_enable_apicv(void)
 	return enable_apicv;
 }
 
+static void nested_mark_vmcs12_pages_dirty(struct kvm_vcpu *vcpu)
+{
+	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
+	gfn_t gfn;
+
+	/*
+	 * Don't need to mark the APIC access page dirty; it is never
+	 * written to by the CPU during APIC virtualization.
+	 */
+
+	if (nested_cpu_has(vmcs12, CPU_BASED_TPR_SHADOW)) {
+		gfn = vmcs12->virtual_apic_page_addr >> PAGE_SHIFT;
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	}
+
+	if (nested_cpu_has_posted_intr(vmcs12)) {
+		gfn = vmcs12->posted_intr_desc_addr >> PAGE_SHIFT;
+		kvm_vcpu_mark_page_dirty(vcpu, gfn);
+	}
+}
+
+
 static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -4743,18 +4765,15 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 	void *vapic_page;
 	u16 status;
 
-	if (vmx->nested.pi_desc &&
-	    vmx->nested.pi_pending) {
-		vmx->nested.pi_pending = false;
-		if (!pi_test_and_clear_on(vmx->nested.pi_desc))
-			return;
-
-		max_irr = find_last_bit(
-			(unsigned long *)vmx->nested.pi_desc->pir, 256);
+	if (!vmx->nested.pi_desc || !vmx->nested.pi_pending)
+		return;
 
-		if (max_irr == 256)
-			return;
+	vmx->nested.pi_pending = false;
+	if (!pi_test_and_clear_on(vmx->nested.pi_desc))
+		return;
 
+	max_irr = find_last_bit((unsigned long *)vmx->nested.pi_desc->pir, 256);
+	if (max_irr != 256) {
 		vapic_page = kmap(vmx->nested.virtual_apic_page);
 		if (!vapic_page) {
 			WARN_ON(1);
@@ -4770,6 +4789,8 @@ static void vmx_complete_nested_posted_interrupt(struct kvm_vcpu *vcpu)
 			vmcs_write16(GUEST_INTR_STATUS, status);
 		}
 	}
+
+	nested_mark_vmcs12_pages_dirty(vcpu);
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
@@ -8026,6 +8047,18 @@ static bool nested_vmx_exit_handled(struct kvm_vcpu *vcpu)
 				vmcs_read32(VM_EXIT_INTR_ERROR_CODE),
 				KVM_ISA_VMX);
 
+	/*
+	 * The host physical addresses of some pages of guest memory
+	 * are loaded into VMCS02 (e.g. L1's Virtual APIC Page). The CPU
+	 * may write to these pages via their host physical address while
+	 * L2 is running, bypassing any address-translation-based dirty
+	 * tracking (e.g. EPT write protection).
+	 *
+	 * Mark them dirty on every exit from L2 to prevent them from
+	 * getting out of sync with dirty tracking.
+	 */
+	nested_mark_vmcs12_pages_dirty(vcpu);
+
 	if (vmx->nested.nested_run_pending)
 		return false;
 
-- 
2.7.4
