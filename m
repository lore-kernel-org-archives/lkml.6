Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E686ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1786A20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mihqylpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1786A20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbeGWHjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40928 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbeGWHjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id x5-v6so11521460pgp.7;
        Sun, 22 Jul 2018 23:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pp3fa4FZs7ME/d9V/uiE2NR8oz6VbzvCcdyF66Zlgxk=;
        b=mihqylpwwAHrXVmDu3+21drOmjyhmOwzUAHNPPdSt1q0ED4C+yums7tfgO9O3xfrla
         vO65Jb8cd6Ilf9ftAOCSgCrEVLamoO/iNQwRv/+VHouhUl0YCOCLkUr6vRMz3m87vvAE
         j+DS2KQTjvXL1upSg5rBTYTo5bDy9FgFsRB2VhtIQYDw8mcWLY8dR1YAwNDouobUOHmp
         CEPzEvcoISD1kDmEItn8HpNYgT5tEWX2PLIqOV1L+lvT7H+pWbckpiuxbqswekm/CDeG
         3+/S/SiTsXPYdsWhTZ8dIrKRUCdMcZqq6Aoj9c6fyX1/lT7N3+Xf1QuFYO23uo17K0rl
         pL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pp3fa4FZs7ME/d9V/uiE2NR8oz6VbzvCcdyF66Zlgxk=;
        b=GPf0jUs+n4bTyc7wXdMEziWKctz8ibX+gSzlQhi/Fo+0k8EtM770unTO0SHD8TG1Eg
         Nzh28YgduBk6mUwIMktLnJxUrVN5sqkCfHgYeEnH7HzNeLUuxLUpxEq4sjqFonLlck9l
         lJ3v31R+vU1Y6kaTUYYlgf8sbeIU/C287SUij7HSGBGHZC6/VV2mciHH9O5nJlkpQ2aE
         hjWSiHMZ7dfC/4Pocak0iLK+fJHvj7VNQzuhGcf0Fi1zx9MiAKE93yXUl+v0nwzTVeoH
         zMx82hWLq45Bsc/AKRHM39sm8rF4oWkZziW8DLAloU67cu5VX2bJglWiQuGtSmy2Kjfw
         0LaQ==
X-Gm-Message-State: AOUpUlF3ozVKzir5tdxiLMaj8PiOVurPs483TaJBfmaRcf+5UbmqYF8u
        Oh2hBs64yCMGuZe//noKtBq1tZt4
X-Google-Smtp-Source: AAOMgpfdNZ9yH0xus8QOzAmEHl0fXRB7PAGf4rH1aIUGzuvHH690PoWAhuvIMa4lCWPi93DuNJJvtw==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr11955980pfh.120.1532328005490;
        Sun, 22 Jul 2018 23:40:05 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:05 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 2/6] KVM: X86: Implement PV IPIs in linux guest
Date:   Mon, 23 Jul 2018 14:39:52 +0800
Message-Id: <1532327996-17619-3-git-send-email-wanpengli@tencent.com>
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

Implement paravirtual apic hooks to enable PV IPIs.

apic->send_IPI_mask
apic->send_IPI_mask_allbutself
apic->send_IPI_allbutself
apic->send_IPI_all

This patch lets a guest send multicast IPIs, with at most 128 destinations 
per hypercall in 64-bit mode and 64 vCPUs per hypercall in 32-bit mode.

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
index dcf629d..a98217d 100644
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

