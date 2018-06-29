Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D575C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1456427CEB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwYrkOWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1456427CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbeF2Jva (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:51:30 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39646 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeF2JvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:51:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id s24-v6so4204079plq.6;
        Fri, 29 Jun 2018 02:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QhaIBUjX7fR0W39zD5fjgK1oF9ieGgHFtc13HXHMIss=;
        b=dwYrkOWAGAsbRhe7SPU2+TJUVpCd/yvsj8wryHp3uRwxh+jyKDlo3aoXg3X6zsXFLn
         RYXL4BxyVYEG2ZNIysN9VU4eUTLlwpJHgd7as3mc6vlarLllin+cDAnVf0rsRTJM0gjJ
         Jg1SxVERisXKj0CKULU8SMDa08l5wpDB8jv0Y5JrsBhDCS/qBTu6+73x3DOAql+qjNrK
         0/pz5TsGy3S9d1Zh/St2dJoP0H9KwwJOI5QOxt0EE/wQS4EwufDzYWQv6PQK9T2Wg/5l
         kP3Su0UI/WrM0T0rNtIk/myezp+1extGwVW5noe0/ZT/ppupFtyTRwLdzpOJgr9nySTd
         0LVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QhaIBUjX7fR0W39zD5fjgK1oF9ieGgHFtc13HXHMIss=;
        b=UYXCAoM0Fyv5U9y1BIj96wyOOsIraebsgWaf1QqgY6O1sxV9P6Xbj6qX26ewjkpobz
         FlDYFkwJDN5vzksdy6UAsCVyIm1HxUfH9djUSGbgnA+HySYhMtrsvHHzH/oWBSmhvyj+
         Ov67kiRVAy9ZSL7oEpFMwRDoMKKEAvLnWsNK6gl52MErkM/kEn22VNSXB3/1X8Ei9iGi
         j7SsbjhpHO/eF51NFev/78Fn1SqsQyU9h3wp3HjE2EGaOQ69vpDW9bGn3/RiKTuELrRI
         TCpBsVVYJQ9AyMFPjCOaLZPRZBY35Z8UpkL6r4oqwv7COgGL0T8NVQABdewQ4UkX6998
         EbqQ==
X-Gm-Message-State: APt69E1sX3znN+t4YrJl1obs5rYgBbgC5cFBioK/4WFs3oOUxJRjBVYF
        aMbn4JmkWnpnzCicL3LWMzoFMA==
X-Google-Smtp-Source: ADUXVKI3bN5I3d0KvcJ3y/BNqD5FIQ9SuNARkZwvW35QEIZGaKXg8gAgfsl2Olh7aF4yv7dpE7Dwfg==
X-Received: by 2002:a17:902:88:: with SMTP id a8-v6mr13850712pla.156.1530265883468;
        Fri, 29 Jun 2018 02:51:23 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm16802066pfm.187.2018.06.29.02.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 02:51:22 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 1/2] KVM: X86: Implement PV IPI in linux guest
Date:   Fri, 29 Jun 2018 17:51:15 +0800
Message-Id: <1530265876-18136-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
References: <1530265876-18136-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Implement PV IPIs in guest kernel.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                | 63 ++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index 5b2300b..b4f8dc3 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -454,6 +454,57 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
+
+static void __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	unsigned long flags, ipi_bitmap = 0;
+	int cpu;
+
+	local_irq_save(flags);
+
+	for_each_cpu(cpu, mask)
+		__set_bit(per_cpu(x86_cpu_to_apicid, cpu), &ipi_bitmap);
+	kvm_hypercall2(KVM_HC_SEND_IPI, ipi_bitmap, vector);
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
+static void kvm_setup_pv_ipi(void)
+{
+	apic->send_IPI_mask = kvm_send_ipi_mask;
+	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
+	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
+	apic->send_IPI_all = kvm_send_ipi_all;
+	printk("KVM setup pv IPIs\n");
+}
+
 static void __init kvm_smp_prepare_cpus(unsigned int max_cpus)
 {
 	native_smp_prepare_cpus(max_cpus);
@@ -624,12 +675,24 @@ static uint32_t __init kvm_detect(void)
 	return kvm_cpuid_base();
 }
 
+static void __init kvm_apic_init(void)
+{
+	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI))
+		kvm_setup_pv_ipi();
+}
+
+static void __init kvm_init_platform(void)
+{
+	x86_platform.apic_post_init = kvm_apic_init;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
+	.init.init_platform 	= kvm_init_platform,
 };
 
 static __init int activate_jump_labels(void)
-- 
2.7.4

