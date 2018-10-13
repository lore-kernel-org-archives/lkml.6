Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2875C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AF4D20877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g34Durb7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF4D20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeJMWcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36508 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeJMWcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id y11-v6so7260592plt.3;
        Sat, 13 Oct 2018 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0GvA2HR3eOqyHHGjxCwJx3woyzx38j35WwXnqi/n/80=;
        b=g34Durb71MEKAdijJAPq+8eZ8GT5gpHLMksd1SXsEGfOjBaND3oWn03Ac5qvZeFhM5
         YDAq8qsx/55N8q6LTLpp8t82wizssjsfjueQeQ00WLvpAShBp7LDwAO2Onn1hlzKDaJp
         EUpJ8WZi1RtyKTEJWtyvS+SG+sImsHNdVMVM+LdwttcLA/6cRWEqpgMRvG9ejyE7yXPO
         Na1ivB2A8NuYrsVcLDL1J3S8bBTz+uCTKGv+WJNuooAOhf1Bpr7IWWH6ENWHh3c0r6vw
         mKsYuelIHyxHTeXSC5BvEvfxecdYCCn3+pGFoI2hpdWOsQPu4R10Ibrg+2gjUHLVfHsS
         2Tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0GvA2HR3eOqyHHGjxCwJx3woyzx38j35WwXnqi/n/80=;
        b=jyfgWtNIWQoRivv21tq38fwUPriMcUpo9xCHz/HGYPKkFam1iexPHVl0BTAeYq6pUm
         ngztTD4lxvqyWxr6lhOPIyAsjs3mA5o/uyQ2b0Yz75I5wMLlGQ8HO/HRswmy7jewHE+2
         ZqnHsClZj9VAiC4zdqJB2Ftt7zc2CeX8tz6/Io83psFD1RedocjUvKWVSOI/Zuiunm1b
         4lgdnU7n0yhdxNiTVjR/W82gX4b73Z7w//C3CNZE/V8K/aJ9KXoSZzfo1LKzjy9z7duQ
         +WcRB7qfswtBLUxyuOhk4xBgFfWKk8cM9KY3pZBKvUXozy0uAvl6o4OEUqQAyGgrtYrZ
         RpdQ==
X-Gm-Message-State: ABuFfojzbObd+3Aml/nZw07c9biWk3R4c/nLm5dB9W6O5QNSK8WTU8kj
        y4gkncejo4Lw+EgMGYGgCgc=
X-Google-Smtp-Source: ACcGV60ikecKSwddzZHkwDQyFs8R1d3k3sGDt2PhDx5OOMosd0ewKRzlRpDY6s+PeMSeRVAIH704Nw==
X-Received: by 2002:a17:902:70c4:: with SMTP id l4-v6mr10045344plt.194.1539442498886;
        Sat, 13 Oct 2018 07:54:58 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:58 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 5/15] KVM/MMU: Move tlb flush in kvm_set_pte_rmapp() to kvm_mmu_notifier_change_pte()
Date:   Sat, 13 Oct 2018 22:53:56 +0800
Message-Id: <20181013145406.4911-6-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
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
index fd24a4dc45e9..5d3a180c57e2 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1781,10 +1781,7 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
-	if (need_flush)
-		kvm_flush_remote_tlbs(kvm);
-
-	return 0;
+	return need_flush;
 }
 
 struct slot_rmap_walk_iterator {
@@ -1920,8 +1917,7 @@ int kvm_unmap_hva_range(struct kvm *kvm, unsigned long start, unsigned long end)
 
 int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte)
 {
-	kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
-	return 0;
+	return kvm_handle_hva(kvm, hva, (unsigned long)&pte, kvm_set_pte_rmapp);
 }
 
 static int kvm_age_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index acc951cc2663..bd026d74541e 100644
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

