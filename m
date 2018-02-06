Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1690823-1517938402-2-16446206676623174961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517938402; b=vMbKanwd30Tvyx9Bd79qZFbetxbO9WbQJZsz8ZKzf3Gxm39
    yWIh8CSbfnBdQ1AmpQlGgh4I+rWQ0DadvtluBda5U756OoDjJ2Qi//R9eP5cyrvb
    wBHlIcnZ5sYExj+aTgUgqZvkYcPYZjpvqL0iPp9QGrAfeWP+z4NcKq6ipRHobtQS
    OKRzpTWuXo6154DMppReSW27UVixSMUwJaJDMltipHtAhcjyNPFtHXJBGOZaFQvE
    O9yuw+RTnlYo0NjV9qOACvzkxnRoyUgDd1kEfl3bvvGj1ZFNBM5QKvt3yVj8zgH9
    iSZyhBoZq0v2NjZmW6hcXgfjxKg8AfwSmAGVgcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1517938402;
    bh=v/LgfVlkm+24JS3LGpkpIitibo9kPJy1ed/qoa/UM2M=; b=BHBx/D9XGJux
    Y0kVQH2ZRAasrjNb65txEWZjNgDURSa6Id82SNCGysmsz7uSyoyGqi2LiYL36+jr
    vanRi0HT1VhFCXTKn3GAm/W6BsDL/l+BUsvo6MCyUSSnMnS8PhLqgMy7HC9KjQyD
    WsJXnz18d9Gyl3vuvvVTOsSkRE1uMbmZqPB1LBxqgfUFKPg4eFwhw+HmVOmr65lI
    GK9hQm0OKrY3BPmsLU6NO8y8tK3MTHdk7MJtrJZKL49pjmOSYsr1cJVhiq7Gro9G
    PRTKiugCDBIG4EGXj3YE+Esr/7xg8fF3HbfSmwQ68gXH1vYhdtxFf07V8Z4ryGq5
    7jpqxDJnng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ZNWIWi5V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.co.uk);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=ZNWIWi5V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeBFRc1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 12:32:27 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6243 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeBFRcX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 12:32:23 -0500
X-IronPort-AV: E=Sophos;i="5.46,469,1511827200";
   d="scan'208";a="721415789"
From: David Woodhouse <dwmw@amazon.co.uk>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4/9] KVM: VMX: introduce alloc_loaded_vmcs
Date: Tue,  6 Feb 2018 17:29:36 +0000
Message-Id: <1517938181-15317-5-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Paolo Bonzini <pbonzini@redhat.com>

Group together the calls to alloc_vmcs and loaded_vmcs_init.  Soon we'll also
allocate an MSR bitmap there.

Cc: stable@vger.kernel.org       # prereq for Spectre mitigation
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit f21f165ef922c2146cc5bdc620f542953c41714b)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/vmx.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 55b1474..8c562da 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3522,11 +3522,6 @@ static struct vmcs *alloc_vmcs_cpu(int cpu)
 	return vmcs;
 }
 
-static struct vmcs *alloc_vmcs(void)
-{
-	return alloc_vmcs_cpu(raw_smp_processor_id());
-}
-
 static void free_vmcs(struct vmcs *vmcs)
 {
 	free_pages((unsigned long)vmcs, vmcs_config.order);
@@ -3545,6 +3540,22 @@ static void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	WARN_ON(loaded_vmcs->shadow_vmcs != NULL);
 }
 
+static struct vmcs *alloc_vmcs(void)
+{
+	return alloc_vmcs_cpu(raw_smp_processor_id());
+}
+
+static int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
+{
+	loaded_vmcs->vmcs = alloc_vmcs();
+	if (!loaded_vmcs->vmcs)
+		return -ENOMEM;
+
+	loaded_vmcs->shadow_vmcs = NULL;
+	loaded_vmcs_init(loaded_vmcs);
+	return 0;
+}
+
 static void free_kvm_area(void)
 {
 	int cpu;
@@ -6947,6 +6958,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	struct vmcs *shadow_vmcs;
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	int r;
 
 	/* The Intel VMX Instruction Reference lists a bunch of bits that
 	 * are prerequisite to running VMXON, most notably cr4.VMXE must be
@@ -6986,11 +6998,9 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
-	vmx->nested.vmcs02.vmcs = alloc_vmcs();
-	vmx->nested.vmcs02.shadow_vmcs = NULL;
-	if (!vmx->nested.vmcs02.vmcs)
+	r = alloc_loaded_vmcs(&vmx->nested.vmcs02);
+	if (r < 0)
 		goto out_vmcs02;
-	loaded_vmcs_init(&vmx->nested.vmcs02);
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		vmx->nested.msr_bitmap =
@@ -9111,17 +9121,15 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	if (!vmx->guest_msrs)
 		goto free_pml;
 
-	vmx->loaded_vmcs = &vmx->vmcs01;
-	vmx->loaded_vmcs->vmcs = alloc_vmcs();
-	vmx->loaded_vmcs->shadow_vmcs = NULL;
-	if (!vmx->loaded_vmcs->vmcs)
-		goto free_msrs;
 	if (!vmm_exclusive)
 		kvm_cpu_vmxon(__pa(per_cpu(vmxarea, raw_smp_processor_id())));
-	loaded_vmcs_init(vmx->loaded_vmcs);
+	err = alloc_loaded_vmcs(&vmx->vmcs01);
 	if (!vmm_exclusive)
 		kvm_cpu_vmxoff();
+	if (err < 0)
+		goto free_msrs;
 
+	vmx->loaded_vmcs = &vmx->vmcs01;
 	cpu = get_cpu();
 	vmx_vcpu_load(&vmx->vcpu, cpu);
 	vmx->vcpu.cpu = cpu;
-- 
2.7.4
