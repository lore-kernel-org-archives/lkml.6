Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEC3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C5424BC0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEsq7EhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C5424BC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933308AbeGCGVr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:21:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42277 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932767AbeGCGVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:44 -0400
Received: by mail-pl0-f65.google.com with SMTP id y15-v6so505296pll.9;
        Mon, 02 Jul 2018 23:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0Gr9ejuqBU5gH3HhPH6aITKeIKdA6uQcfzNPk8llIw=;
        b=fEsq7EhQICL0B8lWgquPXLaz0srYocryxquzN1YZNJSejaIfX3vGTwH7X3RaxppY2H
         iO27lHvKIrS3r8QGhfLTmXaCM/e5BeHrIglKhzob3UpTRq4+3neK28jeAsfmVlQdeUqa
         s/UcgQ08fmjmV3PpYLFRzig0CE1ulcoT4AQIxzwTvjecyvXxxmF364MRTuhK6U3goInJ
         Ps2iMyD+ZAkV4h2WTRKEXvvjLVdQkZsIrPhOlx6a2clGli4ejuFzopcT1HXvgeFNjVzq
         cQ5RoYt5yeNxY3IsskkfgJd6JSzcFgG/Jgzn3YUhnVfvFQwwegq1PzyhBKOMIxbkE85B
         nUiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0Gr9ejuqBU5gH3HhPH6aITKeIKdA6uQcfzNPk8llIw=;
        b=No+rQFKSw4aa3n0oke5/61fGo7jIZhBujDLSRNYjzVg2d6slDvKi6OWDqVH/7XYBHM
         rf8vK0yPSu4ZK8TJ+BNEDdHATN8h22mSQrEJmtPeLa5KF7IlFqEJWGsKKVSXziPYQScN
         WUIjazZPMqTUbNSQyIOSCnbav9VI2F84OcR4hS1VgqkXijlD4y3nVlLziOp2HZCe3FoE
         qTefOMilXkx1ZZzWqXCJdfopEmn2e379NqsqsBKeCqJx46Gz6s1Ek/6Zarmj4iGNKA/W
         8AuYg4E3XcB+MiNx97EF+dGuz0wJb4oc5lgb8OoMo+Oz5MM0wejkVkLpk2iMNyRd4WdL
         fFVA==
X-Gm-Message-State: APt69E3W7XVNevgwIG8KbYjYJvPPlJAE9cqrogRKwCHLaRlfUeU0Vqyt
        zOJ9iCIcb7k8uU29vDfGEASNKg==
X-Google-Smtp-Source: ADUXVKL7cQtXCusUFqneHhTluB32TSugzwEpv/61LdITYlzopSdZACQIhdaUhbFaPNdD8CxvMMhW+g==
X-Received: by 2002:a17:902:a9ca:: with SMTP id b10-v6mr28811471plr.275.1530598903817;
        Mon, 02 Jul 2018 23:21:43 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:43 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 4/6] KVM: X86: Implement PV IPIs send hypercall
Date:   Tue,  3 Jul 2018 14:21:29 +0800
Message-Id: <1530598891-21370-5-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
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
mode. Intel guest can enter x2apic cluster mode when interrupt remmaping 
is enabled in qemu, however, latest AMD EPYC still just supports xapic 
mode which can get great improvement by PV IPIs.  

Hardware: Xeon Skylake 2.5GHz, 2 sockets, 40 cores, 80 threads, the VM 
is 80 vCPUs, IPI microbenchmark(https://lkml.org/lkml/2017/12/19/141):

x2apic cluster mode, vanilla

 Dry-run:                         0,            2392199 ns
 Self-IPI:                  6907514,           15027589 ns
 Normal IPI:              223910476,          251301666 ns
 Broadcast IPI:                   0,         9282161150 ns
 Broadcast lock:                  0,         8812934104 ns

x2apic cluster mode, pv-ipi 

 Dry-run:                         0,            2449341 ns
 Self-IPI:                  6720360,           15028732 ns
 Normal IPI:              228643307,          255708477 ns
 Broadcast IPI:                   0,         7572293590 ns  => 22% performance boost 
 Broadcast lock:                  0,         8316124651 ns

x2apic physical mode, vanilla

 Dry-run:                         0,            3135933 ns
 Self-IPI:                  8572670,           17901757 ns
 Normal IPI:              226444334,          255421709 ns
 Broadcast IPI:                   0,        19845070887 ns
 Broadcast lock:                  0,        19827383656 ns

x2apic physical mode, pv-ipi

 Dry-run:                         0,            2446381 ns
 Self-IPI:                  6788217,           15021056 ns
 Normal IPI:              219454441,          249583458 ns
 Broadcast IPI:                   0,         7806540019 ns  => 154% performance boost 
 Broadcast lock:                  0,         9143618799 ns

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/hypercalls.txt |  6 ++++++
 arch/x86/kvm/x86.c                       | 36 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa7..46657ef 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6689,6 +6689,39 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
 
+/*
+ * Return 0 if successfully added and 1 if discarded.
+ */
+static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
+			unsigned long ipi_bitmap_high, int vector)
+{
+	int i;
+	struct kvm_apic_map *map;
+	struct kvm_vcpu *vcpu;
+	struct kvm_lapic_irq irq = {
+		.delivery_mode = APIC_DM_FIXED,
+		.vector = vector,
+	};
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
@@ -6737,6 +6770,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
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

