Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F58ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5095420874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7Arqycp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5095420874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbeGWHjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:53 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41063 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbeGWHjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so7830346ply.8;
        Sun, 22 Jul 2018 23:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hLPPMYGdD0fm1elVKuI1+Qq8XS3C+8cQ2h0sKkGQNY=;
        b=a7ArqycpEChtuKCBEZYQK8B16YK00dN5IFCdvfXk2eumFmDC3UPExHsEA2irUXkhvR
         z62A71OykmAylouI5zQEGtwQR134JEPN9hIFBgZ4CE72BzOLc4qgUCuDXeQ1rZLa+pq3
         H6c/rAc5sLSp52/tsJBEs6Un1wW9zaFwh0Hq7E5chnEaN5M6UXccEw/+r/AwKszCv/ZM
         yzWIP2ANNmpumCsN/X515Yx1u9fgUG1QAacw2ixJuv2CPZERQDHEKaMvUD7atfUvPNBu
         vKN6XhPMem3BBjAlPPCSVarG1fdwVUuXkPDFoci/e1RqjkUnxXxkg9T7HAEgCmXvMr5W
         bXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hLPPMYGdD0fm1elVKuI1+Qq8XS3C+8cQ2h0sKkGQNY=;
        b=hwL4y2wAPDhGis0waZyBBplPeL28BQJNU2zfWjbzZeqqosAPNl7EvJOrvJ0JMMCEG5
         XdINkQeyexHULJcLLb9jYEEZm7RFfPNyrdhoZBDCSYZYrj0jjtPM4K2awpPktLYLJ3vA
         VvysLKoRYFP5dR41HCoSVmM04vDGtgC1JI7R0rGVYXhxtsbPtUcjdcBa+2ls6u14a0ls
         9pf6jy2Jx0Qkw+llg4s2O+k41RTvqTRxi9HSWCAYg4vrfl5mdzA7/BPASoAx/jjQqz9/
         0ELO5s5gT2GhOoIH5a8yyLqO5dUrhriheTflrzO03blM94kAyfN91M/1wI1X60HVe6X4
         jwGQ==
X-Gm-Message-State: AOUpUlHnglYyKo5FXqP8djdqKpKlUR0b9znKtKLbTCP4zUcw9+OYekBK
        1KFQwdlkHN1O8PzzBMJy1pL51Ne6
X-Google-Smtp-Source: AAOMgpeFTPmIEkwOdETtzXw5aIEdhrxiqO/GWkYJ4+h7UW7zCLVvfuDgS3Nq+PZm1o3DicWVrenCKw==
X-Received: by 2002:a17:902:4324:: with SMTP id i33-v6mr11620445pld.43.1532328011668;
        Sun, 22 Jul 2018 23:40:11 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:11 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 5/6] KVM: X86: Add NMI support to PV IPIs
Date:   Mon, 23 Jul 2018 14:39:55 +0800
Message-Id: <1532327996-17619-6-git-send-email-wanpengli@tencent.com>
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
index a43a29f..c118040 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6695,17 +6695,23 @@ static void kvm_pv_kick_cpu_op(struct kvm *kvm, unsigned long flags, int apicid)
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
 	int cluster_size = op_64_bit ? 64 : 32;
 
+	switch (icr & APIC_VECTOR_MASK) {
+	default:
+		irq.vector = icr & APIC_VECTOR_MASK;
+		break;
+	case NMI_VECTOR:
+		break;
+	}
+	irq.delivery_mode = icr & APIC_MODE_MASK;
+
 	rcu_read_lock();
 	map = rcu_dereference(kvm->arch.apic_map);
 
-- 
2.7.4

