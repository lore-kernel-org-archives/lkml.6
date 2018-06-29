Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3961CC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CA227CE7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 09:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7nwD3jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CA227CE7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeF2Jvb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 05:51:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32934 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934443AbeF2Jv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 05:51:26 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so3980074pfi.0;
        Fri, 29 Jun 2018 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNAFApQlKNqb1l2dWjcohG2cmHJGI86vML2l5Sl1fkE=;
        b=f7nwD3jWgzmW9mrhy+WuLLJgjYWR1h1ZOg4zIWM8sACWFMROwmT5g1pTv8NbsjsWCx
         qZN4anG2J3PrWep90Rd9XKWh58zgo9fZUd7buczfoyVoujevtkJ4nBk1XqoxXM8JZP5S
         E2ZEcJzGVRgLNpX9thIZL14+QvauYjL2baaoV370dDcebVtwARuitlENT9a61gAYyAqn
         vZtToNDmGLgPhSRzsNHfnkkDTKOjFopCMypPVmRVqRIfm4phBqB25nvOVOxpjM8YZlpP
         /sJcC47MIIVtIOoGC+DoufsBA86JqWGyK1Pi6ozJI4M4B8JcQhDSpTeQJg20IAoHot8n
         bCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNAFApQlKNqb1l2dWjcohG2cmHJGI86vML2l5Sl1fkE=;
        b=tZiothirs6ut58LgQJw0mR3IkXnoELAYxYy4TnEhauMRZoFWt54B2WsymEA3NNmRCR
         k9XpvWT2cH40yGbSlaw7KhF/sU3MZWdZt0n8VQEEooJ7cZqznU2sAN7n2Lae8r9gdXjE
         Y22uOa3a11TxWrE/IFFFnOcuWAuJPKdsU8XuttKqqP/uIH7iG0HlUI2Q3TmxHzAQEjwE
         l/TFVV9fsT/VCyXJrX7vv013Pi+8u8wo2NRuYi9kkYGwQJvG6U++dTeJ1D8cSTay3hEp
         yUaLvWYPTgzUepRTNYNWgXmD5nLwy4MRtjrnebRZSWA/vLQnizMcPVh/HgUnBPVzYicN
         Vxsw==
X-Gm-Message-State: APt69E2kNLSHyhxfRnQkzNVLNRqXCxIlZ9gtcpbOz/4JY1aWeTW2t3qi
        pV31nGf98FXvDhc/dRU7EJ3Nwg==
X-Google-Smtp-Source: AAOMgpdloL4HUFirn2JVE3oT5m+PmwqADfGsgQhmj1xNDC8SR3i6P7pv0TrfPGwtLPxYwXEDgfbbpg==
X-Received: by 2002:a63:710d:: with SMTP id m13-v6mr2832346pgc.66.1530265885732;
        Fri, 29 Jun 2018 02:51:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id z19-v6sm16802066pfm.187.2018.06.29.02.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 02:51:25 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH 2/2] KVM: X86: Implement PV send IPI support
Date:   Fri, 29 Jun 2018 17:51:16 +0800
Message-Id: <1530265876-18136-3-git-send-email-wanpengli@tencent.com>
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

Using hypercall to send IPIs by one vmexit instead of one by one for
xAPIC/x2APIC physical mode and one vmexit per-cluster for x2APIC cluster 
mode. 

Even if enable qemu interrupt remapping and PV TLB Shootdown, I can still 
observe ~14% performance boost by ebizzy benchmark for 64 vCPUs VM, the 
total msr-induced vmexits reduce ~70%.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 Documentation/virtual/kvm/cpuid.txt |  4 ++++
 arch/x86/kvm/cpuid.c                |  3 ++-
 arch/x86/kvm/x86.c                  | 25 +++++++++++++++++++++++++
 include/uapi/linux/kvm_para.h       |  1 +
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/cpuid.txt b/Documentation/virtual/kvm/cpuid.txt
index ab022dc..d72359f 100644
--- a/Documentation/virtual/kvm/cpuid.txt
+++ b/Documentation/virtual/kvm/cpuid.txt
@@ -62,6 +62,10 @@ KVM_FEATURE_ASYNC_PF_VMEXIT        ||    10 || paravirtualized async PF VM exit
                                    ||       || can be enabled by setting bit 2
                                    ||       || when writing to msr 0x4b564d02
 ------------------------------------------------------------------------------
+KVM_FEATURE_PV_SEND_IPI            ||    11 || guest checks this feature bit
+                                   ||       || before enabling paravirtualized
+                                   ||       || send IPIs.
+------------------------------------------------------------------------------
 KVM_FEATURE_CLOCKSOURCE_STABLE_BIT ||    24 || host will warn if no guest-side
                                    ||       || per-cpu warps are expected in
                                    ||       || kvmclock.
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7e042e3..7bcfa61 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -621,7 +621,8 @@ static inline int __do_cpuid_ent(struct kvm_cpuid_entry2 *entry, u32 function,
 			     (1 << KVM_FEATURE_CLOCKSOURCE_STABLE_BIT) |
 			     (1 << KVM_FEATURE_PV_UNHALT) |
 			     (1 << KVM_FEATURE_PV_TLB_FLUSH) |
-			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT);
+			     (1 << KVM_FEATURE_ASYNC_PF_VMEXIT) |
+			     (1 << KVM_FEATURE_PV_SEND_IPI);
 
 		if (sched_info_on())
 			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0046aa7..c2e6cdb 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6689,6 +6689,27 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
 	kvm_irq_delivery_to_apic(kvm, NULL, &lapic_irq, NULL);
 }
 
+static void kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap, u8 vector)
+{
+	struct kvm_apic_map *map;
+	struct kvm_vcpu *vcpu;
+	struct kvm_lapic_irq lapic_irq = {0};
+	int i;
+
+	lapic_irq.delivery_mode = APIC_DM_FIXED;
+	lapic_irq.vector = vector;
+
+	rcu_read_lock();
+	map = rcu_dereference(kvm->arch.apic_map);
+
+	for_each_set_bit(i, &ipi_bitmap, sizeof(unsigned long)) {
+		vcpu = map->phys_map[i]->vcpu;
+		kvm_apic_set_irq(vcpu, &lapic_irq, NULL);
+	}
+
+	rcu_read_unlock();
+}
+
 void kvm_vcpu_deactivate_apicv(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.apicv_active = false;
@@ -6738,6 +6759,10 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		ret = kvm_pv_clock_pairing(vcpu, a0, a1);
 		break;
 #endif
+	case KVM_HC_SEND_IPI:
+		kvm_pv_send_ipi(vcpu->kvm, a0, a1);
+		ret = 0;
+		break;
 	default:
 		ret = -KVM_ENOSYS;
 		break;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index dcf629d..7395f38 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -26,6 +26,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
+#define KVM_HC_SEND_IPI         	10
 
 /*
  * hypercalls use architecture specific
-- 
2.7.4

