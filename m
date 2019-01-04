Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABACC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF20221871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1NjRFrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfADIza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:55:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36724 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbfADIz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:55:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so17234652pgm.3;
        Fri, 04 Jan 2019 00:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
        b=G1NjRFrN/C6osVf7UtbSVtMVpqA9Ea/+QkseFh5fipznXIehIqBOj+WICVCUWsH4fm
         XXrhC1ChDLsoNN78/Jf69XvF4QTvyKS9C0EiG02MtsqGdb/vznYx/ApjHr3GqQaAnc59
         iAzfvakgMPJ9lrvgBNJm4sYCxASvjQdGTWmPXRnBeoYThC7wrSDBO3dfRbcb5WIyDr3H
         /Cn6OmQEBoOqFU++9g31s+9rVVQi9bp8oJg2/DBj/pdk8x12iaIwwR0R4dkwHBh3RkSW
         8wMmO9dWO47ftRi5WiiLwFVdRdVrMEsSK046I7vBDMukcSQjf0h6zVVmkLcMYlYK+egF
         HwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZK8Ep/iS40KCOfUlldAdh4saGJOIzh8GKtl9Mv0nhLM=;
        b=CjZ1hrpb8+xeNGltu6TeqGk7YfS3gNM6CYoG/+KkMPodaXOM/WfrgpyuDif9Y8tlOq
         aS3gZlJJs9WaM6MvDSVOzsWJoLt0eW9C0HmQ6ZgjCRDijXj+taHbtbVMFy8jm4KOScv7
         MegEzcha3OjwFgS04a3qj+blYQjI2QTxUXYwHWIWgxSkge+WKbsSobqoLGlamxPgrjYj
         gJYMJHJ/8rRkfF5EI/Xu7UfWO31ip4Ho6ygjaeqvG0EYzeN44cEI5BFEdsfcuQ5DuwPl
         J8GNtLwPsa0CZcmHTC3n3BnPPgLuoZD5B0N/z7OJYB/2ApZFG8ZiRVCaLmCkUEA1OaEv
         kh0w==
X-Gm-Message-State: AJcUukfXGaqS8x+obwUwvb9cSlsXw+O/V/IALEpWpZ5QZdvfqPYaLSc5
        FbddI9zlM51WJqDYnmiZJFA=
X-Google-Smtp-Source: ALg8bN75sfO1wfGgbU1C9NYyKaexIVA3NbEhpqovnyfTJeb3GDT9BdXc/J/k5irnfWBqolOtTpXZ/g==
X-Received: by 2002:a63:da45:: with SMTP id l5mr909998pgj.111.1546592127395;
        Fri, 04 Jan 2019 00:55:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:55:26 -0800 (PST)
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
Subject: [PATCH 9/11] KVM/MMU: Flush tlb in the kvm_mmu_write_protect_pt_masked()
Date:   Fri,  4 Jan 2019 16:54:03 +0800
Message-Id: <20190104085405.40356-10-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb in the kvm_mmu_write_protect_pt_masked() when
tlb range flush is available and make kvm_mmu_write_protect_pt_masked()
return flush request.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 9d8ee6ea02db..30ed7a79335b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1624,20 +1624,30 @@ static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
  * Used when we do not need to care about huge page mappings: e.g. during dirty
  * logging we do not have any such mappings.
  */
-static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
+static bool kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 				     struct kvm_memory_slot *slot,
 				     gfn_t gfn_offset, unsigned long mask)
 {
 	struct kvm_rmap_head *rmap_head;
+	bool flush = false;
 
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		flush |= __rmap_write_protect(kvm, rmap_head, false);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
 	}
+
+	if (flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm,
+				slot->base_gfn + gfn_offset,
+				hweight_long(mask));
+		flush = false;
+	}
+
+	return flush;
 }
 
 /**
@@ -1683,13 +1693,14 @@ bool kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 				struct kvm_memory_slot *slot,
 				gfn_t gfn_offset, unsigned long mask)
 {
-	if (kvm_x86_ops->enable_log_dirty_pt_masked)
+	if (kvm_x86_ops->enable_log_dirty_pt_masked) {
 		kvm_x86_ops->enable_log_dirty_pt_masked(kvm, slot, gfn_offset,
 				mask);
-	else
-		kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset, mask);
-
-	return true;
+		return true;
+	} else {
+		return kvm_mmu_write_protect_pt_masked(kvm, slot, gfn_offset,
+				mask);
+	}
 }
 
 /**
-- 
2.14.4

