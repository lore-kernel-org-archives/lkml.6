Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB653ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6716420858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4jAXSIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6716420858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbeGWHju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41059 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbeGWHjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so645687pfn.8;
        Sun, 22 Jul 2018 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=07tgC2NhRGJJFeudTQ2D6feQ+qtfTI+yBjXaPz1hor0=;
        b=a4jAXSItfPiRPjZlsUanDHzdWnGGBVc8UjCPRtjQdiYL3lZjaPS5WLaifHPGJ5OQNI
         2qjOOqYSTXb8QOxDzOtg0ZMRP6LOGrFpbCCTouZmIv4Ser4u2poSb4rL3OZ9u9qTs3m+
         ZZT+EpxkSCUZZkHB/dvtnecP6Kkx9LsI1VexNeMLUzsGfQxYdHnFo2yf6/vER0f58rr+
         dkWJsticF0MoHEh5S6M/2ktv1EtHxBN73FvEryRpDXkmszCMMv1EFNUQporYXHt/Q68+
         +bPOvWUu0ETJiGZ9+LvO+2h0K3fkXPLLHRTtZIYj6JmdP6z9plduBv26P8itKqfVoX7L
         6N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=07tgC2NhRGJJFeudTQ2D6feQ+qtfTI+yBjXaPz1hor0=;
        b=B0R4V7rclqLpS6g+loLY0IkWvFYIk5cWpTEziH0YyU3TxJVZJ1erHa/pxyPb0I3cCv
         p8sWpnCiMRQ0tGB1mMSKEVYm85fXgtwDlHqKf7Ec4NN+t/qDFtTw/5hhfKMM3nHxvZDI
         /fXJhhk6aUBE+p9XysDEhNzyWYsWTqV7fJHVEZ5ODNb6N9lBQBE24kvDJwHnlLG8U1NY
         x+PJYAnFlWBeZJa5eILboCfMq49i9GfXg3kkKJRY4X8w+FWJ515YvjNE7vaWaVA4T3CY
         EwS2XtDTG5+iJ7AE5aFi3v3fJ1a4LYsgzNFwdft0j+O9O43F8vEmDOcU8BBtMzj8tUxn
         sITg==
X-Gm-Message-State: AOUpUlFImiPL/wey4xr6oEueB+veCSpY8wiOfIzA3FXOhmhxE/u6dW64
        wXUPcHOk/9KHe/PGD5/tME8PRzrg
X-Google-Smtp-Source: AAOMgpeMW/7LLogMpBMyWDxRL75LE3GIcGGuTDapstgXiGNGoTGhbglGqAja9w+53+bSyt9/GaOjxA==
X-Received: by 2002:a63:9856:: with SMTP id l22-v6mr11343671pgo.208.1532328009609;
        Sun, 22 Jul 2018 23:40:09 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:09 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 4/6] KVM: X86: Implement PV IPIs send hypercall
Date:   Mon, 23 Jul 2018 14:39:54 +0800
Message-Id: <1532327996-17619-5-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
References: <1532327996-17619-1-git-send-email-wanpengli@tencent.com>
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
mode which can get great improvement by Exit-less IPIs. This patchset 
lets a guest send multicast IPIs, with at most 128 destinations per 
hypercall in 64-bit mode and 64 vCPUs per hypercall in 32-bit mode.

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
 Documentation/virtual/kvm/hypercalls.txt | 20 +++++++++++++++++
 arch/x86/kvm/x86.c                       | 37 ++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index a890529..9895123 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -121,3 +121,23 @@ compute the CLOCK_REALTIME for its clock, at the same instant.
 
 Returns KVM_EOPNOTSUPP if the host does not use TSC clocksource,
 or if clock type is different than KVM_CLOCK_PAIRING_WALLCLOCK.
+
+6. KVM_HC_SEND_IPI
+------------------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to send IPIs.
+
+a0: lower part of the bitmap of destination APIC IDs
+a1: higher part of the bitmap of destination APIC IDs
+a2: the lowest APIC ID in bitmap
+a3: APIC ICR
+
+The hypercall lets a guest send multicast IPIs, with at most 128
+128 destinations per hypercall in 64-bit mode and 64 vCPUs per
+hypercall in 32-bit mode.  The destinations are represented by a
+bitmap contained in the first two arguments (a0 and a1). Bit 0 of
+a0 corresponds to the APIC ID in the third argument (a2), bit 1
+corresponds to the APIC ID a2+1, and so on.
+
+Returns 0 if successfully delivery the IPIs and 1 if discarded.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2b812b3..a43a29f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6691,6 +6691,40 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
 
+/*
+ * Return 0 if successfully added and 1 if discarded.
+ */
+static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
+		unsigned long ipi_bitmap_high, int min, int vector, int op_64_bit)
+{
+	int i;
+	struct kvm_apic_map *map;
+	struct kvm_vcpu *vcpu;
+	struct kvm_lapic_irq irq = {
+		.delivery_mode = APIC_DM_FIXED,
+		.vector = vector,
+	};
+	int cluster_size = op_64_bit ? 64 : 32;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	for_each_set_bit(i, &ipi_bitmap_low, cluster_size) {
+		vcpu = map->phys_map[min + i]->vcpu;
+		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+			return 1;
+	}
+
+	for_each_set_bit(i, &ipi_bitmap_high, cluster_size) {
+		vcpu = map->phys_map[min + i + cluster_size]->vcpu;
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
@@ -6739,6 +6773,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 	case KVM_HC_CLOCK_PAIRING:
 		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
 		break;
+	case KVM_HC_SEND_IPI:
+		ret = kvm_pv_send_ipi(vcpu->kvm, a0, a1, a2, a3, op_64_bit);
+		break;
 #endif
 	default:
 		ret = -KVM_ENOSYS;
-- 
2.7.4

