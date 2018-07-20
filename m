Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCEAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E9B20661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4B//pQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E9B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbeGTRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:18:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35795 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387918AbeGTRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:18:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so7311931pgv.2;
        Fri, 20 Jul 2018 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAj0wpkzMgjSjcinyt8YwVCTAp82w+xoQBngFo020p8=;
        b=W4B//pQ+KMg/ujAltT8lso352WpKYTUYiXyHNfqG4Jd7ycKmJrxSN42ulbvZ7GA8yo
         Bgd/qApP0d8Ppp7838q0L9y4u55CQ2iqQkm6/7pWV6/F562jze7kzqpA8HGN1EAOnFne
         M2GctN9ofKiMszyS5hkoBxSLSfBf9U1uw4C31HuQV6zYm+NxOtpHUOk/M3r3yOro+6jv
         0rhNSzPPnejVUMcq9PsDyH4VFDLRLSmQ0jtvsvz/Je1hewIqE9LHs9AjzJ6C48e/veCV
         PT274gcKvzBYRL0YrJtnQqY5qLv5HO3bfz7PX1bJMLuOmXYdzyjRi6LSYASvqvI5reWZ
         Dtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zAj0wpkzMgjSjcinyt8YwVCTAp82w+xoQBngFo020p8=;
        b=cbBQxLcskaQo6OzJsmwjG7Iw2t7ri3D2vYj4EDQ2l0Y4b/yPz81dOUkKEABhlIK6xs
         Cqd3hyGhqtLVwBCXlVsg/7bDzX4YkrLSrHLEUIFK3rOxDLniuVqYWx9OA3trqIhS5Deu
         Wl962MyVo17AMpsCqtiU9VxKxvrPlj+OYbGSRe/yAzPcPJZJuPzMhluqbHyQ6ZJi2hdu
         3jLVYYrmaBsY1oPWzCwWdPlRpU/eHf939EfFhtjC5ovWrbuu/Cv4zSJsosPv6sM00tMp
         tzDgIkk1PoFvWyKWjtfDuR7FVZxHph6KUymXoMQws+73DXaIZ6d0Up59M0t93ypMjLng
         lLfw==
X-Gm-Message-State: AOUpUlHhWpT/+LH8/j6Lwwq5sE4UMBpsrnF2jwc3K9EkAaO9eCwejUOL
        k01/JpI3Qs6IHxLjvi8uEn1urLmJA0k=
X-Google-Smtp-Source: AAOMgpdh9z7IO61io9Lnp55aw32SBXWPFVZxEfB6tXSeNwzLFGQ347ueN32XwGKkN8V8QrDX4Itm+Q==
X-Received: by 2002:a63:1b5c:: with SMTP id b28-v6mr2791928pgm.204.1532104146899;
        Fri, 20 Jul 2018 09:29:06 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id m15-v6sm6381930pfj.171.2018.07.20.09.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:29:06 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 5/6] KVM: X86: Add NMI support to PV IPIs
Date:   Sat, 21 Jul 2018 00:29:02 +0800
Message-Id: <1532104142-15821-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

The NMI delivery mode of ICR is used to deliver an NMI to the processor, 
and the vector information is ignored.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 15 ++++++++++++---
 arch/x86/kvm/x86.c    | 16 +++++++++++-----
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 57eb4a2..3456531 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -458,7 +458,7 @@ static void __init sev_map_percpu_data(void)
 static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	int cpu, apic_id, min = 0, max = 0, ret = 0;
+	int cpu, apic_id, min = 0, max = 0, ret = 0, icr = 0;
 #ifdef CONFIG_X86_64
 	__uint128_t ipi_bitmap = 0;
 	int cluster_size = 128;
@@ -472,6 +472,15 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	local_irq_save(flags);
 
+	switch (vector) {
+	default:
+		icr = APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		icr = APIC_DM_NMI;
+		break;
+	}
+
 	for_each_cpu(cpu, mask) {
 		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
 		if (!ipi_bitmap) {
@@ -483,7 +492,7 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
 			max = apic_id < max ? max : apic_id;
 		} else {
 			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
-				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
+				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
 			min = max = apic_id;
 			ipi_bitmap = 0;
 		}
@@ -492,7 +501,7 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
 
 	if (ipi_bitmap) {
 		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
-			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
+			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, icr);
 	}
 
 	local_irq_restore(flags);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 016c7e2..c9dbc2c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6695,15 +6695,21 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
  * Return 0 if successfully added and 1 if discarded.
  */
 static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-		unsigned long ipi_bitmap_high, int min, int vector, int op_64_bit)
+		unsigned long ipi_bitmap_high, int min, unsigned long icr, int op_64_bit)
 {
 	int i;
 	struct kvm_apic_map *map;
 	struct kvm_vcpu *vcpu;
-	struct kvm_lapic_irq irq = {
-		.delivery_mode = APIC_DM_FIXED,
-		.vector = vector,
-	};
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
 
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
-- 
2.7.4

