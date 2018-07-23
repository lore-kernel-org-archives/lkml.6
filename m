Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BCAECDFBB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBD72086A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 00:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy/X1Jdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBD72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbeGWBqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 21:46:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43785 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbeGWBqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 21:46:24 -0400
Received: by mail-pl0-f68.google.com with SMTP id o7-v6so7476120plk.10;
        Sun, 22 Jul 2018 17:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2kprk72x7C+VlOw+kBql/qzp+eXhH1H7X2McD1Q2yc=;
        b=cy/X1JdhgA9ACJjcJPuZ41AoB5dlFddi39ifEh9Tj8ENjvBxQf0XbdvJVmz3hqKYsC
         2MKOQP4KqqnQ8PLs7nqlhxq6PmaPtYwmb+wSEUYPqK2YWnBCOo5xXPKEj3uv50OwwQtD
         ubXnxaKKEXJYlDXIy/Oq7ycVWbzcs3zBY8jZMNzA8fy7YhMNkYzFy90vwOFrDfaSsvVU
         p4mYBr93wFDvfYXOrX23E6hwYC4CZ2+XVMFxv3i4Zzwz8VA3+//IuK46qQoapQth8uV9
         UIn7BlsKsYMEV6PDhfqxx0RdU8CQgmPxnQYbtfcBwht5B5Y6iR+FfHnk+/WG3SvGnPRq
         AWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2kprk72x7C+VlOw+kBql/qzp+eXhH1H7X2McD1Q2yc=;
        b=povLN/12TA012zxRxXNVKO0ocHBazMyFCzzcin8/JXf91RBqGFpeMCtnCh0ryFAR9w
         0RRQEGC/jm7LkGbMF9SzKe9aIoy6ru3ixtOLglprgVy/gH9SEBBWn9FWN5Hc4AV0XfFa
         UrOQ6Tm2rSO+hC9pk1FXRylXYd/Tkp03h55vIL3n5PnWP4FOiqcyQLA4cp4KC8vwkiYg
         heRssqj0zJPN1yOuEgNdQf4PW6WLHVQgAYiXKm3cH08zbiaouNVp7mJthII2MbfWws46
         POb2Ly78J6qXrI4yXZYdZhOuzrFr08Qw51kPLj+j47UPlm7S2kE/BWyKhVwUTQs/L7XX
         zI4w==
X-Gm-Message-State: AOUpUlH2AwnsweYitbZW1ZwcEX8BfI2rtbi8sT2ijhDlHkbIIao3phqi
        +zSkEnE2hLLBR9uPdutwUpBbXlV6
X-Google-Smtp-Source: AAOMgpdPXBNNH6KXCNikVba9IX6ozHp4AjFZ7Z9gYhC7e+EsWn3BJj6tMd6QrJgEysqtol6x4CJ+gQ==
X-Received: by 2002:a17:902:7891:: with SMTP id q17-v6mr11009764pll.186.1532306868264;
        Sun, 22 Jul 2018 17:47:48 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id e82-v6sm11646069pfk.87.2018.07.22.17.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 17:47:47 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 RESEND 2/6] KVM: X86: Implement PV IPIs in linux guest
Date:   Mon, 23 Jul 2018 08:47:35 +0800
Message-Id: <1532306859-31166-3-git-send-email-wanpengli@tencent.com>
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

