Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC0BC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8224B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEqjqT/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A8224B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933498AbeGCGXG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:23:06 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45866 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932954AbeGCGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id y24-v6so481360pfe.12;
        Mon, 02 Jul 2018 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RhQ75Bf0R6xmnFSr0/qvxhwe89nSoi/CZ9mkyqjtTwo=;
        b=CEqjqT/r/TFVho2GI5pnaRJO15TJ45aqmWETY5ViX0LYoadHlvVEIz87ikhVRUUltI
         MgSIosg3l9HBtsHwcS/f4qTBi1HoOkFgyiSx2Olas8OwQsy3lfT/Wij88vdO55c08lf5
         ZaHgK9jSh4P6I+/NcwFLIn2X7hKV2Iwv04cfHuJI2TSSdsiGb+I5HSdU3LR5cANZyHIO
         kZckLwVI2sYQWDtQzpsYjTTSz2pS/BNgxYmMap89uWhhqjHN+J7hz9YeOQs7llt3M914
         pPLKsWxRpJm8qo2biILG6YtrpvtRvUvWFg9cu29qedY1lPta+Ci15zD4Sh1KtbS0iHop
         98RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RhQ75Bf0R6xmnFSr0/qvxhwe89nSoi/CZ9mkyqjtTwo=;
        b=VqTN/8H+fraNKS7vjcljC3TsYc9Fh9+CADuBLtglyGOS91SGWipIiqBLEAWoNydlpF
         sQwgbdSTgHS1ZuneWvNoT43Zyc3kbcSpd09nLTnkOZaBT9hl8tTBDHoE8d7MNof4Pe/K
         oTBuDeppyd0XejgUssl4VZZi2SV+SxV/WtQRUsUfPC4orkhx9Zm92IcQpxkgAC9C56Y+
         3g99U9YfY/N79iaF6zl4cuGJspZC7SI7vMrVVsvk3Cr1JiQycWKVk5j5flLSO9AQWjv4
         G2uo10Sybflkn5p0ut5ACq6RhjG1wszJI7Ie91tokXl2zIFFSqvs4+gWDxp4xjwgLEkN
         JyEg==
X-Gm-Message-State: APt69E3DnHF7450mqsgO/wuc3m8JPYTXHP4+ktPXx5QW0StaRCv2LzNX
        BYI6Yn+h/AxZ0ReiLheIvHae6A==
X-Google-Smtp-Source: ADUXVKK6yMfg4jEytsnMmdbAlZzHnHh7LJ/wy8VD4QXH7bBiYcYYAobnDAoaabAE4Hp8B4wh3Bd+yg==
X-Received: by 2002:a65:5304:: with SMTP id m4-v6mr24195604pgq.250.1530598899754;
        Mon, 02 Jul 2018 23:21:39 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:39 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
Date:   Tue,  3 Jul 2018 14:21:27 +0800
Message-Id: <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
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

Implement paravirtual apic hooks to enable PV IPIs.

apic->send_IPI_mask
apic->send_IPI_mask_allbutself
apic->send_IPI_allbutself
apic->send_IPI_all

The PV IPIs supports maximal 128 vCPUs VM, it is big enough for cloud 
environment currently, supporting more vCPUs needs to introduce more 
complex logic, in the future this might be extended if needed.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                | 70 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm_para.h        |  1 +
 3 files changed, 72 insertions(+)

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
index 591bcf2..2fe1420 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,6 +454,71 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
+
+#ifdef CONFIG_X86_64
+static void __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0;
+	int cpu, apic_id;
+
+	if (cpumask_empty(mask))
+		return;
+
+	local_irq_save(flags);
+
+	for_each_cpu(cpu, mask) {
+		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
+		if (apic_id < BITS_PER_LONG)
+			__set_bit(apic_id, &ipi_bitmap_low);
+		else if (apic_id < 2 * BITS_PER_LONG)
+			__set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);
+	}
+
+	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
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
+#endif
+
 static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
@@ -626,6 +691,11 @@ static uint32_t __init kvm_detect(void)
 
 static void __init kvm_apic_init(void)
 {
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
+	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
+		num_possible_cpus() <= 2 * BITS_PER_LONG)
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
+#define KVM_HC_SEND_IPI 		10
 
 /*
  * hypercalls use architecture specific
-- 
2.7.4

