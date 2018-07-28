Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56F0C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAEF20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erB1qOCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAEF20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbeG2Ait (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:38:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39251 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731546AbeG2Aii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:38:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so8701281wre.6;
        Sat, 28 Jul 2018 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JVXYu2khguRaCJwFwnH9obZNzbhFTTRXmLK08N6+ynw=;
        b=erB1qOCe6fEByAd6qmVMUcQm71JnyUt0iPFKGNpf7FJ6sPi06Lge5psiJJ+kTenT3P
         9uulVSLN6SLklB92VsRjVgsHxtvve7I0boiAKZI/2i8VSqWlz2nzpyGM1ztzP4PrUxUT
         y8dlT1FPa50kFDxrs6g9uuGiXPRfjToUru7wVziTH2+T1nwh67PCzVKvUZ+AOKG3H067
         YsEhqcIrqN/xa8viCRhzMKnoQdrXzOrtYDMfYYDYVCiuwKLLYcdZ3QaNpiKuL8GY+dvU
         1LBV6lsg39jvJl4XClCUPfcl1lGMo5XrXVJonTCtPxEx0oyGW61hCEin/SFbKTxhmJap
         xJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JVXYu2khguRaCJwFwnH9obZNzbhFTTRXmLK08N6+ynw=;
        b=e1eOkxYIQcACINvPR8aLYTdcIzJeAybeBhUJqUbqFseEjntT2bu5HSDSbJ/d59WJdC
         VwbUgCgvbu9osla0oCdo13Th+aEGorL1VEPrbWOUPB9NIAiQ5q3q147VOBQdDuEbf3xU
         YRMQazSUNq2Pd71J659XM3gnN8R5LCpNSzeOBw8qjGd5n3IBiaBOjWUfihWt5P3uszKD
         Na5lrJmKEW1fOMZ3crNfvjjIgDlDKWRRkksmyXRBExDcB6DH2zpw1r9EevHLLZB/erPT
         ylYg/RWr13t9L4LjINWyeiL8H9Fgz7DlklozbYuZDGCJKpU8eOVyXGYyEiN2qVTBdQwS
         mTZA==
X-Gm-Message-State: AOUpUlHqD89LNV2glvQkaoXE6mS6C2EKqKmAHGQHzN1LNwJiRvsOueEl
        gfYjRB2zeNBYDSb8XKyWWxTaqKqO
X-Google-Smtp-Source: AAOMgpdMdwpNcZoVzX0Xa/Qd0aCck5a5bThiG/GYJPbKASLi9PdfmbTRuF68ghUcBkOxFbKXH6ZHsQ==
X-Received: by 2002:adf:e642:: with SMTP id b2-v6mr11427005wrn.254.1532819427488;
        Sat, 28 Jul 2018 16:10:27 -0700 (PDT)
Received: from 640k.lan (94-36-184-250.adsl-ull.clienti.tiscali.it. [94.36.184.250])
        by smtp.gmail.com with ESMTPSA id j6-v6sm6190725wro.13.2018.07.28.16.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:10:26 -0700 (PDT)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Jim Mattson <jmattson@google.com>, rkrcmar@redhat.com
Subject: [PATCH 09/10] KVM: nVMX: include shadow vmcs12 in nested state
Date:   Sun, 29 Jul 2018 01:10:11 +0200
Message-Id: <1532819412-51357-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
References: <1532819412-51357-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shadow vmcs12 cannot be flushed on KVM_GET_NESTED_STATE,
because at that point guest memory is assumed by userspace to
be immutable.  Capture the cache in vmx_get_nested_state, adding
another page at the end if there is an active shadow vmcs12.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b5ee9e08bb48..ce8c0c759a19 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -13167,9 +13167,15 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 		kvm_state.vmx.vmxon_pa = vmx->nested.vmxon_ptr;
 		kvm_state.vmx.vmcs_pa = vmx->nested.current_vmptr;
 
-		if (vmx->nested.current_vmptr != -1ull)
+		if (vmx->nested.current_vmptr != -1ull) {
 			kvm_state.size += VMCS12_SIZE;
 
+			if (is_guest_mode(vcpu) &&
+			    nested_cpu_has_shadow_vmcs(vmcs12) &&
+			    vmcs12->vmcs_link_pointer != -1ull)
+				kvm_state.size += VMCS12_SIZE;
+		}
+
 		if (vmx->nested.smm.vmxon)
 			kvm_state.vmx.smm.flags |= KVM_STATE_NESTED_SMM_VMXON;
 
@@ -13208,6 +13214,13 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
 	if (copy_to_user(user_kvm_nested_state->data, vmcs12, sizeof(*vmcs12)))
 		return -EFAULT;
 
+	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	    vmcs12->vmcs_link_pointer != -1ull) {
+		if (copy_to_user(user_kvm_nested_state->data + VMCS12_SIZE,
+				 get_shadow_vmcs12(vcpu), sizeof(*vmcs12)))
+			return -EFAULT;
+	}
+
 out:
 	return kvm_state.size;
 }
@@ -13288,6 +13301,22 @@ static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
 	vmx->nested.nested_run_pending =
 		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
 
+	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
+	    vmcs12->vmcs_link_pointer != -1ull) {
+		struct vmcs12 *shadow_vmcs12 = get_shadow_vmcs12(vcpu);
+		if (kvm_state->size < sizeof(kvm_state) + 2 * sizeof(*vmcs12))
+			return -EINVAL;
+
+		if (copy_from_user(shadow_vmcs12,
+				   user_kvm_nested_state->data + VMCS12_SIZE,
+				   sizeof(*vmcs12)))
+			return -EFAULT;
+
+		if (shadow_vmcs12->hdr.revision_id != VMCS12_REVISION ||
+		    !shadow_vmcs12->hdr.shadow_vmcs)
+			return -EINVAL;
+	}
+
 	if (check_vmentry_prereqs(vcpu, vmcs12) ||
 	    check_vmentry_postreqs(vcpu, vmcs12, &exit_qual))
 		return -EINVAL;
-- 
1.8.3.1

