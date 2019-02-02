Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6CAC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEDF2075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qo2D+LA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfBBBjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:05 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45936 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbfBBBjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so4074594pfd.12;
        Fri, 01 Feb 2019 17:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xNQ01b3YQcncQcyZ7/8o/Bl5YsleBiAszwwH1EpMGyk=;
        b=Qo2D+LA2DH0Xd98ZgKOyGosKOaLUNvRcl8albFhAHWIgW4SuiFPDTPXliCZhxwU9lo
         KuuHRNm0DC2NEuc+wOFl8VdvU8buZBjimk+zdX1acGwI0ZOAf1OgyamVONKBCjgRenKp
         GxbK6DvdmvX4NKNFXt2+kraiR1ZDN4arbq3lKp/4zhu+A2145+lTvVbUti6VrRcOGkoV
         a4QDX0M3aYO8xuOOntVq9CTNfb+ooOC9th262XOMJZlEEjaJSWChR0+LEBoFacmJsJxV
         tGoUdzOf2NlbeOOo8kF7j5yZgsQg6E/LAjE4U2dpcaLJgFYeA3umIkUnyJFgteWFffI2
         Rlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xNQ01b3YQcncQcyZ7/8o/Bl5YsleBiAszwwH1EpMGyk=;
        b=oLEBR2rZL4VFLI0Z4NndoZXDTQfpkFRo15vxNXVM0X31Te3u0mIGfACe/aURiI6Jj2
         fumrGwdhlI6FUF+2HTqqvJppyjk+0ks4iogfKwN6PIBrNJa9bST9/1CtlpUXQk0b8+Bv
         8X+XMlZF16nm0iVVfn23QRHw+Zg0Top/KCbUTal9abc6Q42B1a7SPO1Ux1h/ngvBsJ/D
         fG1QFo7Cn/YjvpCR/oegaXAEjMh4n74+i3CqElAVmCAGBUJyWs0S9s4I9RzsjOJuEzGC
         CUPr0Z9XtFXBxijqFP7JcIjAekFn2GJJ9Oebmh8d7yzWrS+ywJp3pE1KfIXZgDagret1
         aBbw==
X-Gm-Message-State: AJcUukdKHmnJ2zN2by6AsOLfLI/qNbT6xo3H8SBdU91p1Ja7sOKCLPZI
        IWBjru+BDwO3FbYBixl4pv0=
X-Google-Smtp-Source: ALg8bN52qHZIAftboT3KzOVgAevCJ9IrwTwxVL8yULXyNRr/rVn5RkQZ3gqqqU8ZvuoQTn18Iq1NIQ==
X-Received: by 2002:a62:1e87:: with SMTP id e129mr41458755pfe.221.1549071542091;
        Fri, 01 Feb 2019 17:39:02 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:01 -0800 (PST)
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
Subject: [PATCH V2 2/10] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date:   Sat,  2 Feb 2019 09:38:18 +0800
Message-Id: <20190202013825.51261-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
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
Change since v1:
       Make flush list as a "hlist" instead of a "list" in order to 
       keep struct kvm_mmu_page size.

arch/x86/include/asm/kvm_host.h |  7 +++++++
 arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 49f449f56434..4a3d3e58fe0a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -317,6 +317,12 @@ struct kvm_rmap_head {
 
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
 
@@ -443,6 +449,7 @@ struct kvm_mmu {
 struct kvm_tlb_range {
 	u64 start_gfn;
 	u64 pages;
+	struct hlist_head *flush_list;
 };
 
 enum pmc_type {
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9d954b4adce3..6452d0efd2cc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -427,9 +427,23 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
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
+			int pages = KVM_PAGES_PER_HPAGE(sp->role.level);
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

