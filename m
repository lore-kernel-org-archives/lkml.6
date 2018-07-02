Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432CCC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E824A25C16
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5VAbuuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E824A25C16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965350AbeGBKOs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:14:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34314 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965308AbeGBKOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:14:32 -0400
Received: by mail-pl0-f67.google.com with SMTP id z9-v6so7730080plo.1;
        Mon, 02 Jul 2018 03:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VCO7TCxsc8KtHCebWHBjFezlg//Ibxh67BuOxD1DTw=;
        b=T5VAbuuvidvPJdV3pDpmxHze7QTJL3WFU7Q8Q8KYnF33Xrf5oS/eaaVdVoAdwTRBLC
         uWGRP1CK2WLmMYrshzaSblrV/cKinwj2QOK3UfI33hFJBRrgZ6yO+2dL0MvybflfXpB+
         mP84Us+PTmbdWIEu5d9MJY1JmLbxraCOG9xJLtySV3oJKg7JPIwL1DuPmM+KbMgUAnmp
         KkI9som5LDcUOuw0684VLUucbZKLZ2gxIAmZGTCQ2tC1q5VfV7fghJRj92cWvoX3KpVQ
         ZsWpj7ejIg9n6M3m4Jx0rQWj8eWWKcUayXixJcqi9cCPr+YCdlNrrO6ywvXqMdLZepjv
         nWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VCO7TCxsc8KtHCebWHBjFezlg//Ibxh67BuOxD1DTw=;
        b=bql1NjDb4DxXWKln6HxJpWyUNhl2du9LQzAF4waa+pDEkO4XWrC+nDz6ehA01foVz6
         Dn42s9T2FFVnIl+J82gwr5SJPFXtVNb0/bDD38fsz1HckFmuGPe5lUHkKMM9OgKi0aUv
         T///2ws6aFg+HYnIpGfzS/v6eG9IzJWmTBAEmbHMCzOESYvHoQSK8dIjKSPbR1cLTEJP
         s4FAHdOoNCS3deStnYQ2aQujcTtdTynyrLEi9wx3zuj6d6dSdLDZXWbleopuJzCWYNss
         hwVhWLovI00G+IEwnyFMVOn0Au/vsgdJhGK6xNGTJIN/uKAxXhTQBTNdwFbjqHnt26oI
         SrTA==
X-Gm-Message-State: APt69E2GaEDfslmHtQoBdxMXi4+aHpKU2OUQblGWTDnx6YNQIU4Dmpvz
        Q44z2DPjqdE+jc3YodL7o7Nbaw==
X-Google-Smtp-Source: ADUXVKIz5hJsmChj0wmnkNkbtUqspRo1VF6U01jqeEr79MzE/bXQGMr4YCQPhwEpP48g7bC2mKI3Gw==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr24902779pll.54.1530526472060;
        Mon, 02 Jul 2018 03:14:32 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id n68-v6sm29685665pfg.98.2018.07.02.03.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 03:14:31 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 2/2] KVM: X86: Implement PV send IPI support
Date:   Mon,  2 Jul 2018 18:14:22 +0800
Message-Id: <1530526462-920-3-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
References: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Using hypercall to send IPIs by one vmexit instead of one by one for
xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster 
mode. 

Even if enable qemu interrupt remapping and PV TLB Shootdown, I can still 
observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the 
total msr-induced vmexits reduce ~70%.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/cpuid.txt      |  4 +++
 Documentation/virtual/kvm/hypercalls.txt |  6 +++++
 arch/x86/include/uapi/asm/kvm_para.h     |  1 +
 arch/x86/kvm/cpuid.c                     |  3 ++-
 arch/x86/kvm/x86.c                       | 42 ++++++++++++++++++++++++++++++++
 5 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index ab022dc..97ca194 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -62,6 +62,10 @@ KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
                                    ||       || can be enabled by setting bit 2
                                    ||       || when writing to msr 0x4b564d02
 ------------------------------------------------------------------------------
+KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
+                                   ||       || before using paravirtualized
+                                   ||       || send IPIs.
+------------------------------------------------------------------------------
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index a890529..a771ee8 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -121,3 +121,9 @@ compute the CLOCK_REALTIME for its clock, at the same instant.
 
 Returns KVM_EOPNOTSUPP if the host does not use TSC clocksource,
 or if clock type is different than KVM_CLOCK_PAIRING_WALLCLOCK.
+
+6. KVM_HC_SEND_IPI
+------------------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to send IPIs.
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 0ede697..19980ec 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -28,6 +28,7 @@
 #define KVM_FEATURE_PV_UNHALT		7
 #define KVM_FEATURE_PV_TLB_FLUSH	9
 #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
+#define KVM_FEATURE_PV_SEND_IPI	11
 
 #define KVM_HINTS_REALTIME      0
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7e042e3..7bcfa61 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -621,7 +621,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
 			     (1 << KVM_FEATURE_PV_UNHALT) |
 			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
-			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
+			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
+			     (1 << KVM_FEATURE_PV_SEND_IPI);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa7..c2cef21 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6689,6 +6689,45 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
 
+/*
+ * Return 0 if successfully added and 1 if discarded.
+ */
+static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
+			unsigned long ipi_bitmap_high, unsigned long icr)
+{
+	int i;
+	struct kvm_apic_map *map;
+	struct kvm_vcpu *vcpu;
+	struct kvm_lapic_irq irq = {0};
+
+	switch (icr & APIC_VECTOR_MASK) {
+	default:
+		irq.vector = icr & APIC_VECTOR_MASK;
+		break;
+	case NMI_VECTOR:
+		break;
+	}
+	irq.delivery_mode = icr & APIC_MODE_MASK;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
+		vcpu = map->phys_map[i]->vcpu;
+		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+			return 1;
+	}
+
+	for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
+		vcpu = map->phys_map[i + BITS_PER_LONG]->vcpu;
+		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+			return 1;
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
 void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.apicv_active = false;
@@ -6737,6 +6776,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_CLOCK_PAIRING:
 		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
 		break;
+	case KVM_HC_SEND_IPI:
+		ret = kvm_pv_send_ipi(vcpu->kvm, a0, a1, a2);
+		break;
 #endif
 	default:
 		ret = -KVM_ENOSYS;
-- 
2.7.4

