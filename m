Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B60FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449442084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smIYEfEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449442084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388029AbeGTRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:20:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44912 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbeGTRU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:20:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so5408167pls.11;
        Fri, 20 Jul 2018 09:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V7zwJ0ywobsjSZWTW9QqXuo56/lwfNePcwyAd8m7TDU=;
        b=smIYEfEcQKIxKTpl1PigIZ7uQYjdPs1sqwat32B7VosWN2w8hI0JPn2XiFMFnRd2eV
         2JFk4YoEMnrWw6nPOipMN7octq9/aLiFqUV5jPLu9ws1As9UiEIm47tUonGVhYS4QCvQ
         B5lGlaUAJxry/Dib5V3APiIAqPNKSUzBi2XNXixWE6g7IMIQoW0lL9fWKSlrdoUPQl//
         UbNhNxYBPw6gFvwYNwRS11FkEwaDFjv5HhdXcvofsr3c+h91cQRfGpx6yrS0TGfHI9V9
         +FW7F5hOHu1JwGVJLdkdWwZYFFngRYdAaZ65oLkk1voeHGXXjM1aXJENt7Hg8QQhWDGp
         4Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V7zwJ0ywobsjSZWTW9QqXuo56/lwfNePcwyAd8m7TDU=;
        b=ISd6cZLQlIFpWv9HUNffggfn5rN5zV85f43iEiOxfsdj7dO8DX3JTVTpgW81su+jWQ
         GoDa/sUgkO4zaQyjSlbdcADj3bV/oZypHEHJQ9IAevGaoSlO99SWiclqAGokAc4QlBo0
         iNJmmu+ymLiQh4KTPe7aonumFWTz6L6Ays92TCusvN0gmzJN9talmGbTW7XtuEedu1Ol
         GHjq9Vt78RaQ9S8iEwNdlYDSuJNcd3VHVGkAQyX9teRBNMHLLMXbJORCEy09WRAgqRvG
         JR+mPGyUy7eWp1EKJ9S9CYDR6R7Q+g83lWPcGU0Zk+gZse0KMjwayps23V8if5Qhxrob
         4YsA==
X-Gm-Message-State: AOUpUlHftCf922a88Vq6PfTRWUhBmEbxEYMnXUNEy4aIc6DuaM1C3Bfq
        7ivqdA5zMIe6qGISMPnoPocWTohwQC8=
X-Google-Smtp-Source: AAOMgpeTj9qXBF2lmLUMbToLaHuoq2EN/xc3OA7VpVdDM7r0OeasE36eZPeP1MRN0G+H3tFn4BROQg==
X-Received: by 2002:a17:902:5a83:: with SMTP id r3-v6mr2721680pli.78.1532104285073;
        Fri, 20 Jul 2018 09:31:25 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id q21-v6sm3995859pfl.156.2018.07.20.09.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:31:24 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 4/6] KVM: X86: Implement PV IPIs send hypercall
Date:   Sat, 21 Jul 2018 00:28:53 +0800
Message-Id: <1532104133-15777-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
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
lets a guest which sends multicast IPIs at most can handle 128 vCPUs per 
hypercall on 64-bit machines and 64 vCPUs per hypercall on 32-bit machines.

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
 Documentation/virtual/kvm/hypercalls.txt | 17 ++++++++++++++
 arch/x86/kvm/x86.c                       | 38 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index a890529..912b877 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -121,3 +121,20 @@ compute the CLOCK_REALTIME for its clock, at the same instant.
 
 Returns KVM_EOPNOTSUPP if the host does not use TSC clocksource,
 or if clock type is different than KVM_CLOCK_PAIRING_WALLCLOCK.
+
+6. KVM_HC_SEND_IPI
+------------------------
+Architecture: x86
+Status: active
+Purpose: Hypercall used to send IPIs.
+
+a0: ipi_bitmap low 64 bits
+a1: ipi_bitmap high 64 bits
+a2: the lowest APIC ID in bitmap
+a3: APIC ICR
+
+The hypercall lets a guest send multicast IPIs at most can handle
+128 vCPUs per hypercall on 64-bit machines and 64 vCPUs per hypercall
+on 32-bit machines.
+
+Returns 0 if successfully delivery the IPIs and 1 if discarded.
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2b812b3..016c7e2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6691,6 +6691,41 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
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
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	for_each_set_bit(i, &ipi_bitmap_low, BITS_PER_LONG) {
+		vcpu = map->phys_map[min + i]->vcpu;
+		if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+			return 1;
+	}
+
+	if (op_64_bit) {
+		for_each_set_bit(i, &ipi_bitmap_high, BITS_PER_LONG) {
+			vcpu = map->phys_map[min + i + BITS_PER_LONG]->vcpu;
+			if (!kvm_apic_set_irq(vcpu, &irq, NULL))
+				return 1;
+		}
+	}
+
+	rcu_read_unlock();
+	return 0;
+}
+
 void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.apicv_active = false;
@@ -6739,6 +6774,9 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
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

