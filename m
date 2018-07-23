Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257DFC6778A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D5E20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8tzXOGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D5E20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbeGWBqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45398 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387749AbeGWBqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:30 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so10950874pgq.12;
        Sun, 22 Jul 2018 17:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAj0wpkzMgjSjcinyt8YwVCTAp82w+xoQBngFo020p8=;
        b=K8tzXOGHCF4RPc6cyLqAByho/ZV8tQ4pJr3PWDE9S05zjQpFGeUuWlCNdve1i+T6Q1
         no1jVhBMbnGW2HoFyG9NaUdvYeK0L9UV8mXfhkMBxayY6My7d/B30ZElo9tcpXg1toQf
         VUa9WzVnLgxfv4acSvavjRpsKGRNrMODsS8DTksWOOnvu9Cz2xRb8qh6xHR0hNfNpGHb
         qJEfjYYLcLgdCtH5FKzvh266g/IasOURPpkufuTShB2d7NJPQw1kM8qt4EpOiFrIxVT5
         QRQfWQ0iYLlD4nmJ/q2C/s4BpoBAg0CEZjYB7dpQGnxfeTwx0K2jw58U8FKxaFa8DTRK
         VgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAj0wpkzMgjSjcinyt8YwVCTAp82w+xoQBngFo020p8=;
        b=uZG66QeRje6P1oDh07u2iD8pfRFw8xMlJEMBE0F3k5Jvxw/mOd3DuF9KvhaaiM05Cw
         E4rE6PHHG13tz2lztjc6t/UOrdbOMiav0i6HzgEcixDV73l0qToqRP6GNdHzy4+t9tBR
         Qa2gm5/uFFec0lEmC+1IrLoThHwx/iVz+kxbAqCB7kMk8YrBRH82EXL/ESb1IEI8YAX1
         +qcKexdq1dDKo8DezU/S41je9qhBd1exoWLmPveoIC0s+x7n6IKUCeKro7hglaoUAyUZ
         yX93yB2CyJCuYkmY3k+KWFcTbZ6dIu2PPv5I/UCMyk9zrmCL5Uh/XWefGff7OszAqRTj
         ZuIA==
X-Gm-Message-State: AOUpUlFT/wskYLx0LzrsF0N2ass6Mrt8yYuoNnPReITwB97H4Q1pyneB
        80c2TGIrgPC/iSJzfXcW6m2fMf6o
X-Google-Smtp-Source: AAOMgpeNWKofoSf3wQ8f/ETTffK+ohmzn38jD/oHJ6Ve54LRWNt6D/RSJkkE1e9Nico3LHDSFLa8CA==
X-Received: by 2002:a63:d15:: with SMTP id c21-v6mr10300734pgl.322.1532306874342;
        Sun, 22 Jul 2018 17:47:54 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:53 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 5/6] KVM: X86: Add NMI support to PV IPIs
Date:   Mon, 23 Jul 2018 08:47:38 +0800
Message-Id: <1532306859-31166-6-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
References: <1532306859-31166-1-git-send-email-wanpengli@tencent.com>
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

