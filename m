Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9ECDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8245920661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWalZGui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387989AbeGTRTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:19:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38011 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387830AbeGTRTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:19:32 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so5407380pls.5;
        Fri, 20 Jul 2018 09:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2kprk72x7C+VlOw+kBql/qzp+eXhH1H7X2McD1Q2yc=;
        b=oWalZGuipK5ITLmyNris0KdI/qff4dE7MJnhZ6sT704Er9ql6JdBKaUT1i/IuNBmlR
         hwntCjZl3NVgdeQXEWyZV83GSQc/zPbXqZLTzP+6WTLMJvUK3HEKCup6QaYlTdbpdOnS
         6EmjUvps5oap7Pnw4OO58PDvsCSfQTRXNbKOfy74GqFXzwhVkqi4hOmR6jAQlKgUMhZi
         K4enoTUo20eYJgSm1tBTTmdVmt66ErZrSDSQpupcBkUzLD4u/zpgU8C/QEqw/Lqb9vDH
         hU9O6UyGnUnQzUN+gww3VckjSk7a5CbBrQe4in/1Zvj4kXCcrlR8cTxMFpzVJN144TvP
         nM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2kprk72x7C+VlOw+kBql/qzp+eXhH1H7X2McD1Q2yc=;
        b=ZRNf7yYlkTpuRDDemuj9U0+mMRlz8feijcbIX2xG7Z9XTxiEoyAnls4hNJ5ee5w00S
         zPyHdBJ17P7Dx0GD39Hb+El07HnDt/zdqgkPBuHsbCo5urBiRQux6F/x8jaA+VAK7w/y
         tXYGLSHN3GpVEPrr5cc43bFH8s/y5vcNazEqIyaNbQebKi2OeykXH78GnKoQ92tWPUnF
         6JntcnOyVPKPfZiZPRjE9ncTaFWFo8tV/zi32AQI1UPfyaMyQ5ZBXPs/Eb/HxGLVS4r+
         G7021DfrHckf3WaFu4F5F6aK3o1htzYgSOMYgfrA7NA/yRDSwksSCDxmbjr5bAe3lsGn
         2QwA==
X-Gm-Message-State: AOUpUlHP4BmytFC5Uk/N1DQU1bbi9v6Xz/zCCRUHuRlyN65rP6INjlEv
        Ful9VnYu+8tNk48dpELw/Jqmo/ETY+Q=
X-Google-Smtp-Source: AAOMgpfVJLjIS34OlcEkIRlEIdBq4q6xldCrRMf7F7uVUsS1ZaX9qEWX7xtYIOhsIC9iZOmVkiDqBA==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20-v6mr2712365plr.231.1532104230626;
        Fri, 20 Jul 2018 09:30:30 -0700 (PDT)
Received: from localhost ([223.72.65.191])
        by smtp.gmail.com with ESMTPSA id f5-v6sm7526103pga.58.2018.07.20.09.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 09:30:29 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 2/6] KVM: X86: Implement PV IPIs in linux guest
Date:   Sat, 21 Jul 2018 00:28:15 +0800
Message-Id: <1532104095-15671-1-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Implement paravirtual apic hooks to enable PV IPIs.

apic->send_IPI_mask
apic->send_IPI_mask_allbutself
apic->send_IPI_allbutself
apic->send_IPI_all

This patch lets a guest which sends multicast IPIs at most can handle 128 vCPUs 
per hypercall on 64-bit machines and 64 vCPUs per hypercall on 32-bit machines.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                | 86 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm_para.h        |  1 +
 3 files changed, 88 insertions(+)

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
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 591bcf2..eed6046 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,6 +454,88 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
+static void __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	unsigned long flags;
+	int cpu, apic_id, min = 0, max = 0;
+#ifdef CONFIG_X86_64
+	__uint128_t ipi_bitmap = 0;
+	int cluster_size = 128;
+#else
+	u64 ipi_bitmap = 0;
+	int cluster_size = 64;
+#endif
+
+	if (cpumask_empty(mask))
+		return;
+
+	local_irq_save(flags);
+
+	for_each_cpu(cpu, mask) {
+		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
+		if (!ipi_bitmap) {
+			min = max = apic_id;
+		} else if (apic_id < min && max - apic_id < cluster_size) {
+			ipi_bitmap <<= min - apic_id;
+			min = apic_id;
+		} else if (apic_id < min + cluster_size) {
+			max = apic_id < max ? max : apic_id;
+		} else {
+			kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
+			min = max = apic_id;
+			ipi_bitmap = 0;
+		}
+		__set_bit(apic_id - min, (unsigned long *)&ipi_bitmap);
+	}
+
+	if (ipi_bitmap) {
+		kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
+	}
+
+	local_irq_restore(flags);
+}
+
+static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	__send_ipi_mask(mask, vector);
+}
+
+static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
+{
+	unsigned int this_cpu = smp_processor_id();
+	struct cpumask new_mask;
+	const struct cpumask *local_mask;
+
+	cpumask_copy(&new_mask, mask);
+	cpumask_clear_cpu(this_cpu, &new_mask);
+	local_mask = &new_mask;
+	__send_ipi_mask(local_mask, vector);
+}
+
+static void kvm_send_ipi_allbutself(int vector)
+{
+	kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
+}
+
+static void kvm_send_ipi_all(int vector)
+{
+	__send_ipi_mask(cpu_online_mask, vector);
+}
+
+/*
+ * Set the IPI entry points
+ */
+static void kvm_setup_pv_ipi(void)
+{
+	apic->send_IPI_mask = kvm_send_ipi_mask;
+	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
+	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
+	apic->send_IPI_all = kvm_send_ipi_all;
+	pr_info("KVM setup pv IPIs\n");
+}
+
 static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
@@ -626,6 +708,10 @@ static uint32_t __init kvm_detect(void)
 
 static void __init kvm_apic_init(void)
 {
+#if defined(CONFIG_SMP)
+	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI))
+		kvm_setup_pv_ipi();
+#endif
 }
 
 static void __init kvm_init_platform(void)
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index dcf629d..84f8fe3 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -26,6 +26,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_SEND_IPI		10
 
 /*
  * hypercalls use architecture specific
-- 
2.7.4

