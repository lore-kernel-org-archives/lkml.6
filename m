Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FA7C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208F621470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbyNosx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208F621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJMWdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:33:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32815 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbeJMWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:33:09 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so7283072plp.0;
        Sat, 13 Oct 2018 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+0aCQecRdlne1HXOq2vejiA76NlkqNrTZoi6xu2Gzg=;
        b=pbyNosx6n3DIO64Sylt3I/Vyeo4ibIenFyZ2bnp8kqF64qsN9a8N9vILR6SWE1NKWI
         WhwN3oDkrxrpJOzh1DshIXB3XTXRJf+fkc8dp7yMl/qJaEJmehs+e9V53I68J5tMLdGx
         SwF6jbDz5AE7Sv8LTjGqRO1o5F7CKi9i1ga9VAAudTqNmkad83p7POEzOSq4t+dulY7T
         qxZrC7AL+CHLtKHp6fH/h97VdGZgBuJ+01E9zRg9GvF98feAIkQZG3Vu56s9a7Zai2jE
         /GeiWua9dlASMwrIejCOvz7O/bauf6SnPrbpwTxnocyhKpwBIlbEllvj1zdEkxwD8YK6
         Zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+0aCQecRdlne1HXOq2vejiA76NlkqNrTZoi6xu2Gzg=;
        b=gi985RA86LAiVW+E2a6WtAp+MuIb69cEWif5HkyfvX9jJ+TEXX1whCtmEhuj3o1Ytw
         ndVX+bY6zu9BMtoDc7kb8p8rb5yUkBLidYBwrVFJFyd5dfGsGfyG0LcmaqeNQyhNTpio
         5l5io1+137jsw7d2ch3NM5BRKvP1jsM2wYI+86SFrC9EmxDMQbipIx1/4NhDheHnXPnd
         nRS/dgrmf65VEdwIf6YS+rGDAM7J9KnXWHEegJUz9dyV2lCNQl0H0q5O05F7ozLKH/jg
         7RNnq4DFqpUYWe14aIpDAnGIUIdCDfgc8paWLzLM3qNW7FcYWy1+jeKxiXZIaPfmSynA
         WRmA==
X-Gm-Message-State: ABuFfohlfMQCPiv9h31yDGsvxiturkWwHvR8jnAx2MySJcr1ZPQ3Lgk9
        wxxEdvsj9uNZDpxyN6sr9p7M0PSl0Aw=
X-Google-Smtp-Source: ACcGV63UxhXVlQ+dVDhXqh9Nm/vKG5+J3hq5MDPfAu9Zv7CzwcQtUvnLFCtQfWKRN3DVtpuZdV3GXA==
X-Received: by 2002:a17:902:bc49:: with SMTP id t9-v6mr10205745plz.210.1539442543420;
        Sat, 13 Oct 2018 07:55:43 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:42 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V4 15/15] KVM/VMX: Add hv tlb range flush support
Date:   Sat, 13 Oct 2018 22:54:06 +0800
Message-Id: <20181013145406.4911-16-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to register tlb_remote_flush_with_range callback with
hv tlb range flush interface.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v3:
	Merge Vitaly's don't pass EPT configuration info to
vmx_hv_remote_flush_tlb() fix.
Change since v1:
       Pass flush range with new hyper-v tlb flush struct rather
than KVM tlb flush struct.
---
 arch/x86/kvm/vmx.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 8ff13f3aed11..a93c2cc8a293 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -1569,7 +1569,48 @@ static void check_ept_pointer_match(struct kvm *kvm)
 	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
 }
 
-static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
+int kvm_parse_flush_list_func(union hv_gpa_page_range gpa_list[],
+		int offset, struct list_head *flush_list,
+		int (*fill_flush_list)(union hv_gpa_page_range gpa_list[],
+		int offset, u64 start_gfn, u64 end_gfn))
+{
+	struct kvm_mmu_page *sp;
+
+	list_for_each_entry(sp, flush_list,
+			flush_link) {
+		offset = fill_flush_list(gpa_list, offset,
+				sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
+	}
+
+	return offset;
+}
+
+static inline int __hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_vcpu *vcpu, struct kvm_tlb_range *range)
+{
+	u64 ept_pointer = to_vmx(vcpu)->ept_pointer;
+	struct hyperv_tlb_range flush_range;
+
+	if (range) {
+		flush_range.start_gfn = range->start_gfn;
+		flush_range.pages = range->pages;
+		flush_range.flush_list = range->flush_list;
+		flush_range.parse_flush_list_func = kvm_parse_flush_list_func;
+
+		/*
+		 * FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE hypercall needs address
+		 * of the base of EPT PML4 table, strip off EPT configuration
+		 * information.
+		 */
+		return hyperv_flush_guest_mapping_range(ept_pointer & PAGE_MASK,
+				&flush_range);
+	} else {
+		return hyperv_flush_guest_mapping(ept_pointer & PAGE_MASK);
+	}
+}
+
+static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
 {
 	struct kvm_vcpu *vcpu;
 	int ret = -ENOTSUPP, i;
@@ -1581,16 +1622,21 @@ static int vmx_hv_remote_flush_tlb(struct kvm *kvm)
 
 	if (to_kvm_vmx(kvm)->ept_pointers_match != EPT_POINTERS_MATCH) {
 		kvm_for_each_vcpu(i, vcpu, kvm)
-			ret |= hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, i))->ept_pointer);
+			ret |= __hv_remote_flush_tlb_with_range(
+					kvm, vcpu, range);
 	} else {
-		ret = hyperv_flush_guest_mapping(
-				to_vmx(kvm_get_vcpu(kvm, 0))->ept_pointer);
+		ret = __hv_remote_flush_tlb_with_range(kvm,
+				kvm_get_vcpu(kvm, 0), range);
 	}
 
 	spin_unlock(&to_kvm_vmx(kvm)->ept_pointer_lock);
 	return ret;
 }
+
+static int hv_remote_flush_tlb(struct kvm *kvm)
+{
+	return hv_remote_flush_tlb_with_range(kvm, NULL);
+}
 #else /* !IS_ENABLED(CONFIG_HYPERV) */
 static inline void evmcs_write64(unsigned long field, u64 value) {}
 static inline void evmcs_write32(unsigned long field, u32 value) {}
@@ -7929,8 +7975,11 @@ static __init int hardware_setup(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
-	    && enable_ept)
-		kvm_x86_ops->tlb_remote_flush = vmx_hv_remote_flush_tlb;
+	    && enable_ept) {
+		kvm_x86_ops->tlb_remote_flush = hv_remote_flush_tlb;
+		kvm_x86_ops->tlb_remote_flush_with_range =
+				hv_remote_flush_tlb_with_range;
+	}
 #endif
 
 	if (!cpu_has_vmx_ple()) {
-- 
2.14.4

