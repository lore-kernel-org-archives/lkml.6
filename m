Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634C0C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528E205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0VnJccr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0528E205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJMWcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40916 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id g21-v6so595595pfi.7;
        Sat, 13 Oct 2018 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SLcpsb/KQ3TPJU0d4iQbAvxWnSdRgrbN95f0H43CeAw=;
        b=g0VnJccrNjfchgaprzW2kceKNmFDUrNGTjAOl/VyJqtgyxnogVSiSug7zaQ3ULIlMW
         jZ3PlgXOJoIm+kyvI0qA+cVbMiJVn+0kK4CnoWijPOBiBJbP5hOKBPydleYeDJAoK0Oy
         hyjyA2Xe5LW02ehR0rTuhH34yu+9QTMeAtjj0qsxuBc6Cj/4gpCTNL1wvuZYmCmpwmY9
         xF066r3vIO7h4j/hmPWOZcWOI+TJ3+/HUpnt/ktXdyTrftLlDL77vIvpIUBhhE+/NzNM
         PD7f4kfJIcsTiK2DLx3KYhKGVYPID0hBbipGku1IJZu4cELZrWGhqDCdSRq9gZLmhFpa
         gOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SLcpsb/KQ3TPJU0d4iQbAvxWnSdRgrbN95f0H43CeAw=;
        b=tbi/QL2QwVspHDcYN6lij2kjKm+AXmcWxjJNE/4u3lHq+RqH8VcUf6lFzoQ3ZTwFkb
         emSDXpgPAk5khss4FFZ369jsRoaa2b8X1Quc9UTQw6KJaodPYT4Xdexjp+mmShCNB8PO
         nzvWL7/MWj0FBMZNS65WPSQ3+dOzXa8Hd6ZvjNyCR0L/u1dBKUbvzvUmFyU47WkStVwL
         gtHi/I3EiNb0A2pxOFFNXc0dKVpcOTAh28GswwTNSFv3GWWkNvzZbSLKB1Jo5tjhej7x
         Jj8UCRc8Pi88v72cVL8Bo/lc6rRjdJB5bU/BS5eSzrQYP/hQouSlvxd8nl3rWzMmtMua
         gLHg==
X-Gm-Message-State: ABuFfoize7OjD2SDlpNB7jEi/bB9VCKyxA2zOyGyshPb/EAQRjECkCeM
        MRJUXo6ekn795k6twOuIoGU=
X-Google-Smtp-Source: ACcGV61QhVDaDAGtZit1b2xAug+ZYhHS83/rfpt1BBQT/+k/+beZ6q6imh4NbT8F6bEPjqZWxaEzXg==
X-Received: by 2002:a63:c044:: with SMTP id z4-v6mr9479108pgi.274.1539442521805;
        Sat, 13 Oct 2018 07:55:21 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:21 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 10/15] KVM: Add spte's point in the struct kvm_mmu_page
Date:   Sat, 13 Oct 2018 22:54:01 +0800
Message-Id: <20181013145406.4911-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

It's necessary to check whether mmu page is last or large page when add
mmu page into flush list. "spte" is needed for such check and so add
spte point in the struct kvm_mmu_page.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 5 +++++
 arch/x86/kvm/paging_tmpl.h      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 8279235285f8..c986ebefc9ac 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -333,6 +333,7 @@ struct kvm_mmu_page {
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
+	u64 *sptep;
 
 	/* The page is obsolete if mmu_valid_gen != kvm->arch.mmu_valid_gen.  */
 	unsigned long mmu_valid_gen;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index e984a0067a43..393f4048dd7a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3165,6 +3165,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 			pseudo_gfn = base_addr >> PAGE_SHIFT;
 			sp = kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep = iterator.sptep;
 
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3602,6 +3603,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
@@ -3618,6 +3620,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root = __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep = NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
@@ -3658,6 +3661,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = root;
 		return 0;
@@ -3695,6 +3699,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				      0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 
 		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
index 6bdca39829bc..833e8855bbc9 100644
--- a/arch/x86/kvm/paging_tmpl.h
+++ b/arch/x86/kvm/paging_tmpl.h
@@ -633,6 +633,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 			table_gfn = gw->table_gfn[it.level - 2];
 			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
 					      false, access);
+			sp->sptep = it.sptep;
 		}
 
 		/*
@@ -663,6 +664,7 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gva_t addr,
 
 		sp = kvm_mmu_get_page(vcpu, direct_gfn, addr, it.level-1,
 				      true, direct_access);
+		sp->sptep = it.sptep;
 		link_shadow_page(vcpu, it.sptep, sp);
 	}
 
-- 
2.14.4

