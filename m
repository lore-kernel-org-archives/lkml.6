Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947CD21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUohI3Aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfADIyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:54:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45596 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbfADIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:54:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so17213298pgc.12;
        Fri, 04 Jan 2019 00:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sAXI9KUfdDUDhWP7B1nKmtj4xb/BMelYpMd0QbjlSBM=;
        b=nUohI3AjWQx6ybvOgpH7SxHa8o5nsYzlNw8zm2CmuYood2//x0Ie4POL9QksnHBF2I
         YUbLZhd1Rp+Pw6ZIBVPNdREu5ob8/NSLRq6m6/VDtSShPyah6oXk0qwJ6GERJPgXeO6u
         EUrdYFIOaWou/NJf40/UaAiehOFsZxMS2TqrBcwpH33yZixYhEMZPtTbO+uZ+PPeOhxm
         zlA1ylEHJ9eNnEnCg0PxAzkRvuMGjQSok91W0OHcF2QBzYWHJGfBB0JFkC9KNPbDKMby
         Hmyv2RXoicnEdLehOZJWYCkBrWb+0Z28p/1rQQ6j0R0WDyLlpYjwaX0cBTOkQtA6E5YA
         Z3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sAXI9KUfdDUDhWP7B1nKmtj4xb/BMelYpMd0QbjlSBM=;
        b=Nh59qEzGcKlq0nvNuHu9ZT4LQP3maCBYFy5TZVQdg3zVIZ9pYQnTtRHL2ELUv1Rg5+
         UpOQHTZFABkvZ88PJiHPQPDYt2mpRuWcYZtNo9ce7sFFv0fbXdpxW+N22QSG0g/QvtZa
         Sl82v2aOIDbzC3VGMeOFWRbnGeEKioLfx+YbeDPlea6k1noprCuREYIVG+qVKinksbPp
         CwJYzyp2UZIIaWPXWFsnRR9sxzpvhcb9ajhLN82JYBjRHPWHUdwDJSBy6olehOtJZg5i
         SI7Uz0dxn74aOJHdkZPG1TIFnPN/ZhVvvtihqpwiGJwZ/oCHt745SKE7jXyvUjf//b2J
         kqtA==
X-Gm-Message-State: AJcUukdqZW2zTxYetvNW4y7HC4IyROPxwxel09gNVJZ2jeVsw7fcbSIk
        xmGK1YgTiwVYUdkL/rAgUfw=
X-Google-Smtp-Source: ALg8bN7Fz7+aq6w8K/s4ukB3gYF8YzqWG/pOgvQxWE6lOgsKscCNdev/1KgoCdAPP4uOC2Ddj7PWew==
X-Received: by 2002:a63:e5c:: with SMTP id 28mr842672pgo.369.1546592082509;
        Fri, 04 Jan 2019 00:54:42 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:41 -0800 (PST)
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
Subject: [PATCH 3/11] KVM: Add spte's point in the struct kvm_mmu_page
Date:   Fri,  4 Jan 2019 16:53:57 +0800
Message-Id: <20190104085405.40356-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
index 4660ce90de7f..78d2a6714c3b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -332,6 +332,7 @@ struct kvm_mmu_page {
 	int root_count;          /* Currently serving as active root */
 	unsigned int unsync_children;
 	struct kvm_rmap_head parent_ptes; /* rmap pointers to parent sptes */
+	u64 *sptep;
 
 	/* The page is obsolete if mmu_valid_gen != kvm->arch.mmu_valid_gen.  */
 	unsigned long mmu_valid_gen;
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..068694fa2371 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3160,6 +3160,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, int write, int map_writable,
 			pseudo_gfn = base_addr >> PAGE_SHIFT;
 			sp = kvm_mmu_get_page(vcpu, pseudo_gfn, iterator.addr,
 					      iterator.level - 1, 1, ACC_ALL);
+			sp->sptep = iterator.sptep;
 
 			link_shadow_page(vcpu, iterator.sptep, sp);
 		}
@@ -3588,6 +3589,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 		sp = kvm_mmu_get_page(vcpu, 0, 0,
 				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
 	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
@@ -3604,6 +3606,7 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
 			root = __pa(sp->spt);
 			++sp->root_count;
+			sp->sptep = NULL;
 			spin_unlock(&vcpu->kvm->mmu_lock);
 			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
 		}
@@ -3644,6 +3647,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
 		root = __pa(sp->spt);
 		++sp->root_count;
+		sp->sptep = NULL;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = root;
 		return 0;
@@ -3681,6 +3685,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
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

