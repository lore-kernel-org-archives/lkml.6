Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F761C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA4725C22
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKRL0bXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA4725C22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965391AbeGBKQQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:16:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43935 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965307AbeGBKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:14:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so7723348plj.10;
        Mon, 02 Jul 2018 03:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugHCoeBTC74pdg+Pd3dbwxxnDWjEslutbHcn+Eu6ZMA=;
        b=KKRL0bXFggb8sfRWxeFgpXPnlrMzdJd/ujTia3N+OzsxhXBJx1Bc7uLjttRtoUIjeB
         +L6qr1wneiorPszde+4v8HQ8Pxz8V1hlT9xdvhjuBPkMUhZo7WWV8/yLRFPmsC+/sxqW
         BSxCnG9l1x7HP0V8Tj57BqK2vMsn1NcLwikwbOfXe2trvxXFGTNNoYmdjYlFG2DjZzhB
         nH4Z3Xv3kSYadccOLu7bwGk3NHzjr+IfAd76yfP3ZLc/qjV5Lr6ioMwDmPsUrpZJoKcZ
         S9ovJB6z//HC99RtQrt7y+rbkwioZn5RXQQd3+pk6b63VpXxg+9CSbEFKoyjhwzFd8xF
         ShhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugHCoeBTC74pdg+Pd3dbwxxnDWjEslutbHcn+Eu6ZMA=;
        b=MqFhHJSURCbhaU84htlLBqbS/wC8XmOXa0NgygChIbB3Ae9yoSw3XLireBkK3ds4Ch
         sQ7zEwaJF2Qmc7OP/WriiSvzS37jRFFlrBMHJrL0zzz26UnubUEJCdUC8g8RfSegMc8A
         ghNAF4kMgyypNQaOmdIGVn5njLDO+lnstXsVCF2dPqV7flMczerhZkXgfR9ypgmIK/Dr
         qRbW/J6ebBa1ETd6BcqnUxrKtqLeu5DgkNkiUAToH32h5WWHkV/WB4iT+BPdEmIZk+uA
         3KlAQKvdt4yUwE82xfjOmXp6tkasAfSjiCaRF3zCnLbChk78w12htaH3iuLxcLq2D0ge
         n4Wg==
X-Gm-Message-State: APt69E1ZRXwZDSJbYie5KNUkaa5Pe0ZE6tpiNHerAAeOhbUFRAdMMaKd
        I8IjkYLyEZAe/ai7Xz0I2x+cSg==
X-Google-Smtp-Source: ADUXVKKO3rmGFmne84Y8BMm2y30Shkp5ZUCBCjDkioXSCOVyx7XEcZZTw9Ee+WYBUKKs3dgIBHEIRQ==
X-Received: by 2002:a17:902:6845:: with SMTP id f5-v6mr24952986pln.173.1530526469844;
        Mon, 02 Jul 2018 03:14:29 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id n68-v6sm29685665pfg.98.2018.07.02.03.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 03:14:29 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v2 1/2] KVM: X86: Implement PV IPI in linux guest
Date:   Mon,  2 Jul 2018 18:14:21 +0800
Message-Id: <1530526462-920-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
References: <1530526462-920-1-git-send-email-wanpengli@tencent.com>
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
 arch/x86/kernel/kvm.c         | 99 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm_para.h |  1 +
 2 files changed, 100 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b..7e3ee25 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -47,6 +47,7 @@
 #include <asm/hypervisor.h>
 #include <asm/kvm_guest.h>
 
+static struct apic orig_apic;
 static int kvmapf = 1;
 
 static int __init parse_no_kvmapf(char *arg)
@@ -454,6 +455,89 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
+
+#ifdef CONFIG_X86_64
+static bool __send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0, icr = 0;
+	int cpu, apic_id, ret = 1;
+
+	if (cpumask_empty(mask))
+		return true;
+
+	local_irq_save(flags);
+
+	for_each_cpu(cpu, mask) {
+		apic_id = per_cpu(x86_cpu_to_apicid, cpu);
+		if (apic_id < BITS_PER_LONG)
+			__set_bit(apic_id, &ipi_bitmap_low);
+		else if (apic_id < 2 * BITS_PER_LONG)
+			__set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);
+		else
+			goto ipi_mask_done;
+	}
+
+	switch (vector) {
+	default:
+		icr = APIC_DM_FIXED | vector;
+		break;
+	case NMI_VECTOR:
+		icr = APIC_DM_NMI;
+		break;
+	}
+
+	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, icr);
+
+ipi_mask_done:
+	local_irq_restore(flags);
+	return ((ret == 0) ? true : false);
+}
+
+static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
+{
+	if (!__send_ipi_mask(mask, vector))
+		orig_apic.send_IPI_mask(mask, vector);
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
+	if (!__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
+}
+
+static void kvm_send_ipi_allbutself(int vector)
+{
+	kvm_send_ipi_mask_allbutself(cpu_online_mask, vector);
+}
+
+static void kvm_send_ipi_all(int vector)
+{
+	if (!__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
+}
+
+/*
+ * Set the IPI entry points
+ */
+static void kvm_setup_pv_ipi(void)
+{
+	orig_apic = *apic;
+
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
@@ -624,12 +708,27 @@ static uint32_t __init kvm_detect(void)
 	return kvm_cpuid_base();
 }
 
+static void __init kvm_apic_init(void)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_X86_64)
+	if (kvm_para_has_feature(KVM_FEATURE_PV_SEND_IPI) &&
+		num_possible_cpus() <= 2 * BITS_PER_LONG)
+		kvm_setup_pv_ipi();
+#endif
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
+	.init.init_platform	= kvm_init_platform,
 };
 
 static __init int activate_jump_labels(void)
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index dcf629d..7395f38 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -26,6 +26,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_SEND_IPI			10
 
 /*
  * hypercalls use architecture specific
-- 
2.7.4

