Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91214C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457C324B6A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8f9uPge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457C324B6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933475AbeGCGWm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:22:42 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36238 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933231AbeGCGVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:21:42 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so506888plp.3;
        Mon, 02 Jul 2018 23:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNr5GLoJJSKFnf6nkwAKd/Dw6Pj5dKd0EWzz2EuueJg=;
        b=K8f9uPge0mRUq5cSMWo1USb+Pz9HYCAhRz0G3Hf2o5OpqJKW6BhsbDuL6HDMymAm7g
         MhkJp3JX9FbR8k8F7ZgshoVkfma92AkyuBzicaSx3yCZe3ba843wl1ZWgXjpIqXkk/tz
         aZ2wapytsC4JngVSnDq6A49ZDFDKIndv/W+LxraO7Khs+PRj6pgwDyba/0+KyY+uZe+y
         WDpjXoFH/LB0nF4SG/mTKL2HWBFumYb5vzsA8v66Xr5KvOeYBpOTu6rS38UI19WhZYDY
         JVx+GfdDO7ISxzoETlNhtNMCrGAWv2Vr4YyC6hwlLSo/tmTpAQVd+NsjpVkqndExKzca
         54Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNr5GLoJJSKFnf6nkwAKd/Dw6Pj5dKd0EWzz2EuueJg=;
        b=Y03zVV+TerHtw3919ngDITleS/20GXKQFULxzoaEVksK+8OVikpREAvtb7wVoEbErJ
         ahcPClGiQhC8KviMuWT9oHEH/n+M0BeuSPK3zjSCknD4Q99IJa+SpGjQFccdEzwD3zkc
         xzDJMlXdWHrnMqSUtMBmVJkBwNVCRLR74HJxU2R8P7t96WiCAba+v3HmLmPB20nculuq
         XZTfSV0I5mN0t7r7JB+D41SWsI0DDY41jCt01wG/GmxEaWvwpfrBI07Z/DcOFneWoq8I
         Q1gMGbW9OhkYVTGXWd0iJPfwer6XX+avSS4B/XVB1TZITI83rjno58ml7QwK3JYsC02r
         DYNg==
X-Gm-Message-State: APt69E0EqpV6kx70/MFDMFKX8GvglhSXodMZOwV88PurNLUkf17QXoXK
        Pempi0QJxDXLZhi7JRADJKK0RA==
X-Google-Smtp-Source: ADUXVKK3OMaDpnAxKS2vjx8XU2CKZxW0rI2AZx73nqg3UYuETqLFZNn1qznUwQO6MN7zmukIivlngg==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11-v6mr29657143pls.182.1530598901733;
        Mon, 02 Jul 2018 23:21:41 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.123])
        by smtp.googlemail.com with ESMTPSA id v89-v6sm1766427pfd.64.2018.07.02.23.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Jul 2018 23:21:41 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v3 3/6] KVM: X86: Fallback to original apic hooks when bad happens
Date:   Tue,  3 Jul 2018 14:21:28 +0800
Message-Id: <1530598891-21370-4-git-send-email-wanpengli@tencent.com>
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

Fallback to original apic hooks when apic id is sparse and larger 
than 128 or kvm fails to add the pending IRQ to lapic.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kernel/kvm.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 2fe1420..81be75b 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -47,6 +47,7 @@
 #include <asm/hypervisor.h>
 #include <asm/kvm_guest.h>
 
+static struct apic orig_apic;
 static int kvmapf = 1;
 
 static int __init parse_no_kvmapf(char *arg)
@@ -456,13 +457,13 @@ static void __init sev_map_percpu_data(void)
 #ifdef CONFIG_SMP
 
 #ifdef CONFIG_X86_64
-static void __send_ipi_mask(const struct cpumask *mask, int vector)
+static int __send_ipi_mask(const struct cpumask *mask, int vector)
 {
 	unsigned long flags, ipi_bitmap_low = 0, ipi_bitmap_high = 0;
-	int cpu, apic_id;
+	int cpu, apic_id, ret = 0;
 
 	if (cpumask_empty(mask))
-		return;
+		return 0;
 
 	local_irq_save(flags);
 
@@ -472,16 +473,23 @@ static void __send_ipi_mask(const struct cpumask *mask, int vector)
 			__set_bit(apic_id, &ipi_bitmap_low);
 		else if (apic_id < 2 * BITS_PER_LONG)
 			__set_bit(apic_id - BITS_PER_LONG, &ipi_bitmap_high);
+		else {
+			ret = -EFAULT;
+			goto irq_restore_exit;
+		}
 	}
 
-	kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
+	ret = kvm_hypercall3(KVM_HC_SEND_IPI, ipi_bitmap_low, ipi_bitmap_high, vector);
 
+irq_restore_exit:
 	local_irq_restore(flags);
+	return ret;
 }
 
 static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
 {
-	__send_ipi_mask(mask, vector);
+	if (__send_ipi_mask(mask, vector))
+		orig_apic.send_IPI_mask(mask, vector);
 }
 
 static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
@@ -493,7 +501,8 @@ static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
 	cpumask_copy(&new_mask, mask);
 	cpumask_clear_cpu(this_cpu, &new_mask);
 	local_mask = &new_mask;
-	__send_ipi_mask(local_mask, vector);
+	if (__send_ipi_mask(local_mask, vector))
+		orig_apic.send_IPI_mask_allbutself(mask, vector);
 }
 
 static void kvm_send_ipi_allbutself(int vector)
@@ -503,7 +512,8 @@ static void kvm_send_ipi_allbutself(int vector)
 
 static void kvm_send_ipi_all(int vector)
 {
-	__send_ipi_mask(cpu_online_mask, vector);
+	if (__send_ipi_mask(cpu_online_mask, vector))
+		orig_apic.send_IPI_all(vector);
 }
 
 /*
@@ -511,6 +521,8 @@ static void kvm_send_ipi_all(int vector)
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

