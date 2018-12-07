Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C81DC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF939208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 12:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mena-vt-edu.20150623.gappssmtp.com header.i=@mena-vt-edu.20150623.gappssmtp.com header.b="ZRLrCoeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF939208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mena.vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLGMti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:49:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55468 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLGMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 07:49:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so4248584wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mena-vt-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aBx4Uf0AXPUXYaYC8L7IOOvH1hBcTiqrQSEjZvFMvY=;
        b=ZRLrCoeXD9HW8NIerF03oCdBCfs49Kp1L+4nSKW3GXD2Oq7tL/6qr6EIac2uT/L0el
         DPWzzOG+eEgD/0CL1mm/lzRuqDFU+j7TXH05SlfQOurMEQpG0S4fTGcgQveCjfkHmJaI
         pCTNXx5TrQmu8OJZeNA3vWJ+SgSft7oEwlepT2AFDZXeGXqvfsIkEUVwyGrtWJfN/Uti
         QrqdD+0d+avOGwZHD+JXLAr9++3byKWfskeJv9HgdL1DfhB2Ki4prBhvK9q3w5vvDJ12
         zMoR4r0b2LmF2kZvzdwd8smerBUM+M6obbMfBIoyeFSHT+JT5lOx6MlH8cJvvyCk6oSP
         6jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aBx4Uf0AXPUXYaYC8L7IOOvH1hBcTiqrQSEjZvFMvY=;
        b=lPnNOOJdQfOIPkTwWebcWm6ofsFiCDQFknQ1CucNx5ifSytkhI3b2cMBDyuxiKlhoi
         ee9UIslRwRo4AVF4lja7LgK0eddmLOen058ROw9yJYee/i935hwQgg91ovwZc/SVYxne
         d7iHicf4jbtuaFVnQW0GHfNKx50uV9rovlBGtb8cDDc7kR2hEmvjh0wey5DISKYYi0qe
         Wbd2GASef4vpBZT5O83uv8sOkQixDmZA8eTZUTk3UWX63WgwQSX+d6X2yd1snG/GTq09
         KIgC6tl8Z4YV1W8f2I6E+X+DyH15T/PfQfn9IscizhxOIOvoHg9YjgAZFoUOzrNPSPU/
         50Hw==
X-Gm-Message-State: AA+aEWZRPXarN2DUDGxrZKYflwU04X1S3T445XtikNDqV/mNmvXcYMcF
        zfEONOjuNQOFfHFJSReJCXnrVg==
X-Google-Smtp-Source: AFSGD/UgbVwxu0T4GOFk5WoSSvUhKOVLjgnI86o17K0DWzUsnEBQw6xC+04yacjI7Psv/elfu6Qi9A==
X-Received: by 2002:a1c:2b45:: with SMTP id r66mr2063076wmr.7.1544186971172;
        Fri, 07 Dec 2018 04:49:31 -0800 (PST)
Received: from localhost.localdomain ([156.213.98.90])
        by smtp.gmail.com with ESMTPSA id i192sm4362949wmg.7.2018.12.07.04.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 04:49:30 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
Subject: [PATCH 09/10] KVM: Add new exit reason For ROE violations
Date:   Fri,  7 Dec 2018 14:48:02 +0200
Message-Id: <20181207124803.10828-10-ahmedsoliman@mena.vt.edu>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
References: <20181207124803.10828-1-ahmedsoliman@mena.vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that qemu will not be able to detect ROE violations, so
one option would be create host API to tell if a given page is ROE
protected, or create ROE violation exit reason.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman@mena.vt.edu>
---
 arch/x86/kvm/x86.c       | 10 +++++++++-
 include/kvm/roe.h        | 12 ++++++++++++
 include/uapi/linux/kvm.h |  2 +-
 virt/kvm/kvm_main.c      |  1 +
 virt/kvm/roe.c           |  2 +-
 virt/kvm/roe_generic.h   |  9 +--------
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 28475c83f9..ddd15bb1a7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5334,6 +5334,7 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 			const struct read_write_emulator_ops *ops)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	struct kvm_memory_slot *slot;
 	gpa_t gpa;
 	int rc;
 
@@ -5375,7 +5376,14 @@ static int emulator_read_write(struct x86_emulate_ctxt *ctxt,
 
 	vcpu->run->mmio.len = min(8u, vcpu->mmio_fragments[0].len);
 	vcpu->run->mmio.is_write = vcpu->mmio_is_write = ops->write;
-	vcpu->run->exit_reason = KVM_EXIT_MMIO;
+	slot = kvm_vcpu_gfn_to_memslot(vcpu, gpa >> PAGE_SHIFT);
+	if (slot && ops->write && (kvm_roe_check_range(slot, gpa>>PAGE_SHIFT,
+			gpa - (gpa & PAGE_MASK), bytes) ||
+			gfn_is_full_roe(slot, gpa>>PAGE_SHIFT)))
+		vcpu->run->exit_reason = KVM_EXIT_ROE;
+	else
+		vcpu->run->exit_reason = KVM_EXIT_MMIO;
+
 	vcpu->run->mmio.phys_addr = gpa;
 
 	return ops->read_write_exit_mmio(vcpu, gpa, val, bytes);
diff --git a/include/kvm/roe.h b/include/kvm/roe.h
index 6a86866623..3121a67753 100644
--- a/include/kvm/roe.h
+++ b/include/kvm/roe.h
@@ -13,4 +13,16 @@ void kvm_roe_arch_commit_protection(struct kvm *kvm,
 		struct kvm_memory_slot *slot);
 int kvm_roe(struct kvm_vcpu *vcpu, u64 a0, u64 a1, u64 a2, u64 a3);
 bool kvm_roe_arch_is_userspace(struct kvm_vcpu *vcpu);
+bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
+		int len);
+static inline bool gfn_is_full_roe(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap);
+
+}
+static inline bool gfn_is_partial_roe(struct kvm_memory_slot *slot, gfn_t gfn)
+{
+	return test_bit(gfn - slot->base_gfn, slot->partial_roe_bitmap);
+}
+
 #endif
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2b7a652c9f..185767e512 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -235,7 +235,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
 #define KVM_EXIT_HYPERV           27
-
+#define KVM_EXIT_ROE		  28
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
 #define KVM_INTERNAL_ERROR_EMULATION	1
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0d129b05d5..c3a21d3bc8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -62,6 +62,7 @@
 #include "async_pf.h"
 #include "vfio.h"
 #include "roe_generic.h"
+#include <kvm/roe.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/kvm.h>
diff --git a/virt/kvm/roe.c b/virt/kvm/roe.c
index dfb1de314c..6555838f0c 100644
--- a/virt/kvm/roe.c
+++ b/virt/kvm/roe.c
@@ -60,7 +60,7 @@ bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 		return false;
 	return kvm_roe_protected_range(slot, gpa, len);
 }
-
+EXPORT_SYMBOL_GPL(kvm_roe_check_range);
 
 void kvm_roe_free(struct kvm_memory_slot *slot)
 {
diff --git a/virt/kvm/roe_generic.h b/virt/kvm/roe_generic.h
index ad121372f2..f1ce4a8aec 100644
--- a/virt/kvm/roe_generic.h
+++ b/virt/kvm/roe_generic.h
@@ -14,12 +14,5 @@ void kvm_roe_free(struct kvm_memory_slot *slot);
 int kvm_roe_init(struct kvm_memory_slot *slot);
 bool kvm_roe_check_range(struct kvm_memory_slot *slot, gfn_t gfn, int offset,
 		int len);
-static inline bool gfn_is_full_roe(struct kvm_memory_slot *slot, gfn_t gfn)
-{
-	return test_bit(gfn - slot->base_gfn, slot->roe_bitmap);
-}
-static inline bool gfn_is_partial_roe(struct kvm_memory_slot *slot, gfn_t gfn)
-{
-	return test_bit(gfn - slot->base_gfn, slot->partial_roe_bitmap);
-}
+
 #endif
-- 
2.19.2

