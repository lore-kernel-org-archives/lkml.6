Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C949C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9EC21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvSEP/K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfADIzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44488 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfADIzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:55:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so17153212plt.11;
        Fri, 04 Jan 2019 00:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
        b=lvSEP/K+omY4BY0Ld25k59kJSSur3J2dCgRgr+6yby9CvFFfsgXTOn3+D1aJsvNalY
         eTPJapgS5iRWe8Q3VJfTJ0Bthyr9frF7QnBsGgTCvldicoKf7P4ofSI8pZ09IAgB4oJH
         S57zVxQI3vvPDAKwm0oQsJsa4UNZsPZkF0t/oCsc/oq0RtM8Bl0af8yVHC4PZOGlv3vr
         xk5+cqM8Wco6xLzbT7VEmWSN2LwGnGl4YyFdTsgfVbY6uz3M5hvZsFc6A91Yr6tdVH+Z
         ElpfqsR5cbQQTFpFgingD74oF7Tm329wgchjSs/dW+HIz+j+Txq5ZkJoxgkX4QVwmqbB
         /xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRXc/XwU+0JK+tTKqDimxoIXZnhU9RFFAnNgcWVG9mA=;
        b=gNNRWwonjpnlRCnIL1YafC1MrT1dhlYhkLNSYE78ZBnooYfLU3ypAg+MqHKYgSQ1pM
         siK36V8xWhtU97KqCm6CHEO0yZzXBfVreOTnA0WAFDPt58iniLXphjdiEHtSBKosJYAI
         PE+IPJ1KiAWT1AIg3eo2WOY4ocxZ8ZTN7tSNQUGTixsOqqIQh2tkdNyRC/YOfgoXdETL
         VG8B3lHeyov8S4VLCGOIqwDINnv5zicUwfOQjU9kMs7gvCaqBbNLvzpObTfcd6SqLPss
         06h7RgDklClibilp1qb3LYtXKuqt0KxbJdFzVdbTFtwd6nee+IKHzWSS8gmdimQmXLIm
         YvNA==
X-Gm-Message-State: AJcUukcL0gvTpL09qoVoPf2aQtg7ch3N5DogbIuo+idlvE3Mpnqa5NYC
        AxshztEnce47gNeU3ZKG9Ck=
X-Google-Smtp-Source: ALg8bN6SD6ySHgduF3UiOSRUnfYBNpkE+dVu9pEO0AqBi2lbwhCbWkSW6krUk3+TRsHaKT0HX3RnDg==
X-Received: by 2002:a17:902:2b84:: with SMTP id l4mr50247049plb.191.1546592119875;
        Fri, 04 Jan 2019 00:55:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:55:19 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 8/11] KVM: Make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
Date:   Fri,  4 Jan 2019 16:54:02 +0800
Message-Id: <20190104085405.40356-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to make kvm_arch_mmu_enable_log_dirty_pt_masked() return value
and caller can use it to determine whether tlb flush is necessary.
kvm_get_dirty_log_protect() and kvm_clear_dirty_log_protect() use the return
value of kvm_arch_mmu_enable_log_dirty_pt_masked() to populate flush
parameter.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/mips/kvm/mmu.c      |  5 ++++-
 arch/x86/kvm/mmu.c       |  6 +++++-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/arm/mmu.c       |  5 ++++-
 virt/kvm/kvm_main.c      | 10 ++++------
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 97e538a8c1be..f36ccb2d43ec 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -437,8 +437,10 @@ int kvm_mips_mkclean_gpa_pt(struct kvm *kvm, gfn_t start_gfn, gfn_t end_gfn)
  *
  * Walks bits set in mask write protects the associated pte's. Caller must
  * acquire @kvm->mmu_lock.
+ *
+ * Returns: Whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
@@ -447,6 +449,7 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	gfn_t end = base_gfn + __fls(mask);
 
 	kvm_mips_mkclean_gpa_pt(kvm, start, end);
+	return true;
 }
 
 /*
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 6d4f7dfeaa57..9d8ee6ea02db 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1676,8 +1676,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_clear_dirty_pt_masked);
  *
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
@@ -1686,6 +1688,8 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				mask);
 	else
 		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+
+	return true;
 }
 
 /**
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c38cc5eb7e73..e86b8c38342b 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -759,7 +759,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 int kvm_clear_dirty_log_protect(struct kvm *kvm,
 				struct kvm_clear_dirty_log *log, bool *flush);
 
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 					struct kvm_memory_slot *slot,
 					gfn_t gfn_offset,
 					unsigned long mask);
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 3053bf2584f8..232007ff3208 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1564,12 +1564,15 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
  *
  * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
  * enable dirty logging for them.
+ *
+ * Return value means whether caller needs to flush tlb.
  */
-void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 		struct kvm_memory_slot *slot,
 		gfn_t gfn_offset, unsigned long mask)
 {
 	kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
+	return true;
 }
 
 static void clean_dcache_guest_page(kvm_pfn_t pfn, unsigned long size)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e75dbb15fd09..bcbe059d98be 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1202,13 +1202,12 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 			if (!dirty_bitmap[i])
 				continue;
 
-			*flush = true;
 			mask = xchg(&dirty_bitmap[i], 0);
 			dirty_bitmap_buffer[i] = mask;
 
 			offset = i * BITS_PER_LONG;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+							memslot, offset, mask);
 		}
 		spin_unlock(&kvm->mmu_lock);
 	}
@@ -1275,9 +1274,8 @@ int kvm_clear_dirty_log_protect(struct kvm *kvm,
 		 * a problem if userspace sets them in log->dirty_bitmap.
 		*/
 		if (mask) {
-			*flush = true;
-			kvm_arch_mmu_enable_log_dirty_pt_masked(kvm, memslot,
-								offset, mask);
+			*flush = kvm_arch_mmu_enable_log_dirty_pt_masked(kvm,
+					memslot, offset, mask);
 		}
 	}
 	spin_unlock(&kvm->mmu_lock);
-- 
2.14.4

