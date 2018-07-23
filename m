Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BE9ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3A120858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmQP9Nhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3A120858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbeGWHjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:39:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40152 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388004AbeGWHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:39:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id e13-v6so696999pff.7;
        Sun, 22 Jul 2018 23:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kw6302ch86pg258GLepkuZEk2pw2bUxOqBJi45V/0IA=;
        b=LmQP9NhvqYalMKYmPOW6WmfontXkDePLE8oOv5WqLNI3lKMV/pzzccVUh7jM9cYpnM
         GLWvVWwYS7Aw9HZwF1udnWRcc8wEHjrXdMr4r5boxwU+36JKkyrNEnB0MrJC8yAZZRfa
         /9pumDgZS3h77200r29jME5aXVEGw+776YPHvu/OYOeSOFVhKfpEBEDhKkQX2c5UvLA3
         5Enrs00IgaWVSBcwgcAUPBmv7pIolBVHPTdzdOdPW6Qo6pKEsJlZ90j0CvGIfDTCoTaO
         V8CYXrJpJHNy2A7UATXaukA60K3pNb9QWCfGOjoYDA6MQwRa8dDfCnHkFkxGU9gEFiXS
         GGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kw6302ch86pg258GLepkuZEk2pw2bUxOqBJi45V/0IA=;
        b=msCkkd2sZ+SbpabzCxFJHwNhKsVKyCcxZ5jPNG3QZIE4adDMAhkGgsGUUR/4HgT4pb
         LhkZJDOFOFCSMHYwCr8klPsGLs/CHlKPwOnmT97gp3NEb/Cw+vhmn+KsE2VOHKmc7HDo
         fOfXFRzuRz38R1uCMv8u3Ug1x+/5qqnEor/oPOdBQQJWhK8l6uAhLyoIi2seEjDbzPR6
         4fOe8LHmZTJoa9ch2sxH3UYf0vaPtvamhjYEhKdeCAE6+f0D60q1RYTQBcGfVxwUEvPv
         BPR6uM9BDjWFDLTbBI8PoYNhTGujZUwPOefS+qQW8ha0q586BtK0taLnz1rO/uox8+2f
         cmPw==
X-Gm-Message-State: AOUpUlHb25bTGOcpiryvIBiAO8Vg7O7K47SSArnqKl4Nn8W3Fmc+CIzB
        z1eqgjfG/dpBRCoScDTS7Mrvclnf
X-Google-Smtp-Source: AAOMgpeB2KNJCiF0yrv1XidZ1ijEwkxnIbjLOUBFhbf+V4mB1jiSQvdnKQBH92EVksyNLtILqDdT1Q==
X-Received: by 2002:a63:f309:: with SMTP id l9-v6mr10807134pgh.369.1532328007514;
        Sun, 22 Jul 2018 23:40:07 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id p17-v6sm8165598pgv.26.2018.07.22.23.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:40:07 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v5 3/6] KVM: X86: Fallback to original apic hooks when bad happens
Date:   Mon, 23 Jul 2018 14:39:53 +0800
Message-Id: <1532327996-17619-4-git-send-email-wanpengli@tencent.com>
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

Fallback to original apic hooks when unlikely kvm fails to add the
pending IRQ to lapic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index eed6046..57eb4a2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -47,6 +47,7 @@
 #include <asm/hypervisor.h>
 #include <asm/kvm_guest.h>
 
+static struct apic orig_apic;
 static int kvmapf = 1;
 
 static int __init parse_no_kvmapf(char *arg)
@@ -454,10 +455,10 @@ static void __init sev_map_percpu_data(void)
 }
 
 #ifdef CONFIG_SMP
-static void __send_ipi_mask(const struct cpumask *mask, int vector)
+static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags;
-	int cpu, apic_id, min = 0, max = 0;
+	int cpu, apic_id, min = 0, max = 0, ret = 0;
 #ifdef CONFIG_X86_64
 	__uint128_t ipi_bitmap = 0;
 	int cluster_size = 128;
@@ -467,7 +468,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 #endif
 
 	if (cpumask_empty(mask))
-		return;
+		return 0;
 
 	local_irq_save(flags);
 
@@ -481,7 +482,7 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 		} else if (apic_id < min + cluster_size) {
 			max = apic_id < max ? max : apic_id;
 		} else {
-			kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+			ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 				(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
 			min = max = apic_id;
 			ipi_bitmap = 0;
@@ -490,11 +491,12 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 	}
 
 	if (ipi_bitmap) {
-		kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
+		ret = kvm_hypercall4(KVM_HC_SEND_IPI, (unsigned long)ipi_bitmap,
 			(unsigned long)(ipi_bitmap >> BITS_PER_LONG), min, vector);
 	}
 
 	local_irq_restore(flags);
+	return ret;
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
@@ -511,7 +513,8 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 	cpumask_copy(&new_mask, mask);
 	cpumask_clear_cpu(this_cpu, &new_mask);
 	local_mask = &new_mask;
-	__send_ipi_mask(local_mask, vector);
+	if (__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
 }
 
 static void kvm_send_ipi_allbutself(int vector)
@@ -521,7 +524,8 @@ static void kvm_send_ipi_allbutself(int vector)
 
 static void kvm_send_ipi_all(int vector)
 {
-	__send_ipi_mask(cpu_online_mask, vector);
+	if (__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
 }
 
 /*
@@ -529,6 +533,8 @@ static void kvm_send_ipi_all(int vector)
  */
 static void kvm_setup_pv_ipi(void)
 {
+	orig_apic = *apic;
+
 	apic->send_IPI_mask = kvm_send_ipi_mask;
 	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
 	apic->send_IPI_allbutself = kvm_send_ipi_allbutself;
-- 
2.7.4

