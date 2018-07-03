Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EF3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9A24B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oir1M62M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB9A24B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbeGCGWP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:22:15 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42630 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933290AbeGCGVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:46 -0400
Received: by mail-pf0-f196.google.com with SMTP id v9-v6so486357pff.9;
        Mon, 02 Jul 2018 23:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+lzxbs0R+lV8jrr6MkWE9KyYkwdfW2ntGogp5ddu8g=;
        b=Oir1M62Mg7oto3Ud6f5iDCo/u86wtjVRVlBu2qAHkko8ch1TpEtT/vsd9pGUsC5kdC
         VD6d/xpPeOLFkeK0b850g3g3N6j3d1Vc6HUxBFE/qzQ2JeQhfZ6Flas6Hrz9cD/TYKqX
         71P/MBL2JIvJ9k/E7kN8Ddr8rz6wJ1gulZ1NQuO9eFI5kzaN3TaIPBul0B80zZUJ77Ga
         fI68G6NjHg+f9XnxbicM78V9LtYscfqqI0vP85eUj3GEKTUninwBFulQYewDjC7fRYSU
         nXmXAp1gm0jBt38/q+ZTgy7Tu3DAXlanFucOxsynBEQgp2t/apL4Nc19DM33SI+ELYWW
         Ps3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+lzxbs0R+lV8jrr6MkWE9KyYkwdfW2ntGogp5ddu8g=;
        b=jGXvCgexMtcqhlt9O69aqRhK3FKeq+rgwu6cDWsu1Pu5YBE1EP1R9QwCvM0QmO+EDu
         0CWyJCSPlcaktzruBZG0w2v1uFhlSeMBVgFRFBMdkHyIo+KY/d821h0twrRUCLvhqpPa
         uyDAk0i9+knZOCdL9RJN+YVI+4YJSxRiPIrB86xYP1Ef3I7DX0968bg+y4BekjK5Ezd6
         PU6I6GhHhzjv7f2ZNwc3m5FW3Msgwdtg3QTE/IhriijlprVbeW2XNzj7UnzBDMKP5zu5
         qjgIOg7NlYTOIzN1mf4p6NNfN5G/Ut0jQW/xwSEE8+0CZGEiyPzutRE/THgUGz64UNwe
         frAQ==
X-Gm-Message-State: APt69E2AI7Rb7ri9r/ceWI23JymSEwX82q4xKgfXJ/vm3KKGpcuQN5BV
        Cs39hW1/G2Nao/Ts8y0n76Vhiw==
X-Google-Smtp-Source: AAOMgpcnNvtHFM1PQySzbNnBWW7soaYcdVTlSI3neMWS+4JIsNz3bNMEs6ssu+yw5ghukiepLZghiw==
X-Received: by 2002:a62:f704:: with SMTP id h4-v6mr6061935pfi.169.1530598905838;
        Mon, 02 Jul 2018 23:21:45 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:45 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 5/6] KVM: X86: Add NMI support to PV IPIs
Date:   Tue,  3 Jul 2018 14:21:30 +0800
Message-Id: <1530598891-21370-6-git-send-email-wanpengli@tencent.com>
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

The NMI delivery mode of ICR is used to deliver an NMI to the processor, 
and the vector information is ignored.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 13 +++++++++++--
 arch/x86/kvm/x86.c    | 16 +++++++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 81be75b..b866518 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -459,7 +459,7 @@ static void __init sev_map_percpu_data(void)
 #ifdef CONFIG_X86_64
 static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
-	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0;
+	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0, icr = 0;
 	int cpu, apic_id, ret = 0;
 
 	if (cpumask_empty(mask))
@@ -479,7 +479,16 @@ static int __send_ipi_mask(const struct cpumask *mask, int vector)
 		}
 	}
 
-	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
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
 
 irq_restore_exit:
 	local_irq_restore(flags);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 46657ef..2e4c4d7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6693,15 +6693,21 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
  * Return 0 if successfully added and 1 if discarded.
  */
 static int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
-			unsigned long ipi_bitmap_high, int vector)
+			unsigned long ipi_bitmap_high, unsigned long icr)
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

