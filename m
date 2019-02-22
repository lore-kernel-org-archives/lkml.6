Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D5C2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVTWaQnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBVPHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46147 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBVPHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so1199595pls.13;
        Fri, 22 Feb 2019 07:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
        b=VVTWaQnAfH2eioa468QYwi8FCfMVGxfTUkZ1MqTKn4GjsZOFCHMNz49Hi7A6Ca5Lp9
         prEuk2Pk3UMgw+0LuXko8oH4teeiagMaMwpxbrWUKc1M+qc5Jp9VDoYeCSlLGaptlatg
         rWPZ77LiAzAHabZciKq1NuQ795+t/yhYaKJq5kgZHSB1rhI1qUnivpbXq5O7aThbedLC
         eq1WSwTpJri9Z2l5ITc7QB53GZd1R+5h9gSpqBUWC0Hwt0V16EdNsgTgWjLPgJN5K2c7
         Yff0G/aB75brz6zuq0/sI9Dp22FEy4SF12u1enbC3QzY62hltFL5Y88E19PzAMCVNqj+
         wpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q0P5XgUhHSeogEE24zx3HNxWmK4nJsBPit2rUo7j0iI=;
        b=e1HjcUD9cvlpxDikk9QfEk7fgLFgT2vsfUvFAtMCU+dCrvFJX0HS46haHEPbyJ1s4F
         m92yeTu7okqElDi2hcG8UH9RAoUTZD/TKSRhfYTHlSLeJclTfVQQnQL/1ywmq8boSh8Z
         Khe4fH7qMuQPCMtWmjyYl5PDwNfieNK7MLX0jR6XPYkIRcX/5qv06c3BFKs7TUX5dat3
         kSQzM1DuFRCtngBNAfXIXikYhiiYv4xpu5fVIDgIqmKU3x+zF7OudZgAWY9OUfjIVEZw
         w9FvlgboX2diQilP+TEjRQNLXiyTqZwN3Lm7bLBDgtF9TeMNErvZaTT7NI61leibSGHC
         6qSg==
X-Gm-Message-State: AHQUAubGnkWnk/dbS2HzwYO/BUJ2fWitpXhoWYD5jU0AJ6Wl60nM/BKO
        YayCsq/OkRj3nD7WMhftcb8=
X-Google-Smtp-Source: AHgI3IYt1nmRnL4fTVfYPNhScGJwllP9ezkrwos1wRWo49n4OUOin7xMzg9Vx3TPBgs0S4KkcyRnlw==
X-Received: by 2002:a17:902:5a8d:: with SMTP id r13mr4655676pli.190.1550848031497;
        Fri, 22 Feb 2019 07:07:11 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:10 -0800 (PST)
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
Subject: [PATCH V3 2/10] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date:   Fri, 22 Feb 2019 23:06:29 +0800
Message-Id: <20190222150637.2337-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Populate ranges on the flush list into struct hv_guest_mapping_flush_list
when flush list is available in the struct kvm_tlb_range.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v2:
	- Fix calculation of flush pages in the kvm_fill_hv_flush_list_func()
---
 arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 875ae7256608..9fc9dd0c92cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -318,6 +318,12 @@ struct kvm_rmap_head {
 
 struct kvm_mmu_page {
 	struct list_head link;
+
+	/*
+	 * Tlb flush with range list uses struct kvm_mmu_page as list entry
+	 * and all list operations should be under protection of mmu_lock.
+	 */
+	struct hlist_node flush_link;
 	struct hlist_node hash_link;
 	bool unsync;
 	bool mmio_cached;
@@ -441,6 +447,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 77b5379e3655..85139d318490 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -432,9 +432,23 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 		void *data)
 {
 	struct kvm_tlb_range *range = data;
+	struct kvm_mmu_page *sp;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
-			range->pages);
+	if (!range->flush_list) {
+		return hyperv_fill_flush_guest_mapping_list(flush,
+			0, range->start_gfn, range->pages);
+	} else {
+		int offset = 0;
+
+		hlist_for_each_entry(sp, range->flush_list, flush_link) {
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level + 1);
+
+			offset = hyperv_fill_flush_guest_mapping_list(flush,
+					offset, sp->gfn, pages);
+		}
+
+		return offset;
+	}
 }
 
 static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
-- 
2.14.4

