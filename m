Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF973C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB322075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKl4t9Ss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbfBBBjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:13 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40130 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfBBBjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so3751907pgp.7;
        Fri, 01 Feb 2019 17:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
        b=JKl4t9SsRWFQRqm/2ykkdDbszCjiZIyL9GEDu1emOACGiirfjKR4PU2Y1yFEaeqHLe
         4Gg4rW7yrPMnpiI0rSIwiM8z2uBBUK/Ol8t+l1N1VxwoceQdtJBxJeNkd4oXCXGX81Ln
         /mA+Fi7RDYkiSi5AJlTWoN2SUEgpHbUuXQrcQbSmKlwxk2aHCImQkJLlezWkOovxwH/r
         pdVkbF/4t7THhVIvbGyuKG1ZlsttuJYikvG2qecvpaGfUuC9O3QNWZVxRbeg1svaAD8C
         EQJQrmp2Uw8Htj/sc9HDeAQO0XwYAHiepwQfXGOUnd4F6iyTf9QGL+LEgTPPwhG6DHWC
         qGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkCKWdNQDd7n0mb8dlG6t1culFOMAQghK/Ej0OwX5M0=;
        b=WL02MygEvcVKAo03lucB9shsluSPQsnGY/Divr196p5im0CGDQp4CgTZJHCe1DlY4u
         mUyIUhOIdoXGquGPTO3YwI5hazYK50CoZxlb8ZRM108pDy155idgjesQdYj0gpQtI+0v
         JykC74054b4Rh9ZwfXR3oV+hE5B/4Ck7FZrZX2BlAEqFbjfYdCz03//rNd8JvCGmeHO2
         hJCEh/NLfeTWql1hkKfI7QMmlf7KlsV2bEHoYDEUJEOUNFt/MF4AkHVv+m+QaNuq8lZN
         ZIJN2engihDoFtiXYuwl9u8DkEBOUpVrluJj1h7hn+w34lKO/sLLxfNKrYetOrwXZ2Eg
         uVgw==
X-Gm-Message-State: AHQUAuYsn9XLmSxnxEJFaQcUqJq6gjKQqIPHo7N3ZgfJfwuu1u2HFPbC
        njrkXlZYdHGf/7VoEzD++Kk=
X-Google-Smtp-Source: AHgI3IYtiYj+YWXlKinAagZU+CzzWQGsIguvJwkSw/9h/aC/bdhFYr+TlIVLI3IuHned8yzL8VgVKw==
X-Received: by 2002:a65:6542:: with SMTP id a2mr4544721pgw.389.1549071549793;
        Fri, 01 Feb 2019 17:39:09 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:09 -0800 (PST)
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
Subject: [PATCH V2 3/10] KVM/MMU: Add last_level in the struct mmu_spte_page
Date:   Sat,  2 Feb 2019 09:38:19 +0800
Message-Id: <20190202013825.51261-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add last_level in the struct kvm_mmu_page. When build
flush tlb range list, last_level will be used to identify whehter the
page should be added into list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a3d3e58fe0a..9d858d68c17a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -325,6 +325,7 @@ struct kvm_mmu_page {
 	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
+	bool last_level;
 
 	/*
 	 * The following two entries are used to key the shadow page in the
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index ce770b446238..70cafd3f95ab 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -2918,6 +2918,9 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 
 	if (level > PT_PAGE_TABLE_LEVEL)
 		spte |= PT_PAGE_SIZE_MASK;
+
+	sp->last_level = is_last_spte(spte, level);
+
 	if (tdp_enabled)
 		spte |= kvm_x86_ops->get_mt_mask(vcpu, gfn,
 			kvm_is_mmio_pfn(pfn));
-- 
2.14.4

