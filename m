Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E92C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9827320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBdsZw9h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9827320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbeLFNW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:22:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33450 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbeLFNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:22:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id z23so180624plo.0;
        Thu, 06 Dec 2018 05:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FsUkqMsrPK+AOjkSbOdklcddwVrVXXJsebej5QmQiao=;
        b=HBdsZw9hM1ZcwwDdOg9BcU5WyQFhfC/VYi4rXbNZ2jxjMV++RZLFCcFh7YIsBStQH2
         E2+MbncB9Juikn2Bvf76N8bYvgL0/9LNLM37hNDMS/kGhhL9L/xgWoHUIlZa3UCAfLur
         HxydnA9HXa3I+EihwiynLoQU7XwX6n9WYEwfwlgv8Fmh2qGMx9Kp2QCL9mBBse+0+OMT
         cEujxXW/xKqGN+PBELD61qIZl1yhu/2LTtNpvKGaj/1WKPsAWuTPyZUUzEVBbwTqas73
         YwU9j6cSqvClDijsKpPdFv5UZYlODkaAwShLo4urPKEHScJh7yFTzS3pjF+piIIl8tnb
         vgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FsUkqMsrPK+AOjkSbOdklcddwVrVXXJsebej5QmQiao=;
        b=jtn9K2ioVZ88udjaAbeBgV+foVTkjGclo62j/wqz4zKFlh+T3JDmagz+G7+aRNmICD
         48v1dhbnPto2kaR7uh8QEb+m44Zfo0I4usaxJV89DDxXKxfmyEq3f6G3gwb/6PxMNnvY
         Ufacj1eHnM4vHX/oox9YDeRtycVUQsdBTY84zw8okUtHL69/IOGaGCUAmwQzYigkGXq2
         HQCCTkZ0OqLID7LMDPZfrx+COW1f7WzVIPWn4Vi9MHjpl1bZTTyp3+voo9Kmb5VFctHV
         pPXWpOiR4Db4A8GGvliSPfC5UXMWpW3l2usptvak6cl8dUzdImCRd3wQE6Np9Pa51ffh
         AH/g==
X-Gm-Message-State: AA+aEWYZg3PHrq8YLMoKd6PcALw1aJahdU/vGMw97FT932xFeTpf7f7c
        QpA0NxfQRLatCfTV+r9i4Lo=
X-Google-Smtp-Source: AFSGD/XD0gxFf+fu0KwPYHQtySl3ZNKNg5c3KSNoxmhG2NvABTYNsRRdeu744t5s6/xJ22JYSiY2vw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr27881575plo.96.1544102545414;
        Thu, 06 Dec 2018 05:22:25 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.22.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:22:24 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [Resend PATCH V5 8/10] KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
Date:   Thu,  6 Dec 2018 21:21:11 +0800
Message-Id: <20181206132113.2691-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to move tlb flush in kvm_set_pte_rmapp() to
kvm_mmu_notifier_change_pte() in order to avoid redundant tlb flush.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c  | 8 ++------
 virt/kvm/kvm_main.c | 5 ++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index dfef49f1e7a6..3b0f60e88f54 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1776,10 +1776,7 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
-	if (need_flush)
-		kvm_flush_remote_tlbs(kvm);
-
-	return 0;
+	return need_flush;
 }
 
 struct slot_rmap_walk_iterator {
@@ -1915,8 +1912,7 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
-	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
-	return 0;
+	return kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..dac4b0446aed 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -354,7 +354,10 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	idx = srcu_read_lock(&kvm->srcu);
 	spin_lock(&kvm->mmu_lock);
 	kvm->mmu_notifier_seq++;
-	kvm_set_spte_hva(kvm, address, pte);
+
+	if (kvm_set_spte_hva(kvm, address, pte))
+		kvm_flush_remote_tlbs(kvm);
+
 	spin_unlock(&kvm->mmu_lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 }
-- 
2.14.4

