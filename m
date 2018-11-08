Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055DBC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F020685
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 09:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEhtQBqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31F020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKHSup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 13:50:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34657 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeKHSup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 13:50:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id f12-v6so8078252plo.1;
        Thu, 08 Nov 2018 01:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvvPy7Q4qFhIcL2nJjG34LofSZ7R5VeljzNsh5L5Nb8=;
        b=DEhtQBqXnAEIMkbcf2z0yIj3vhQ93LgYqzJ9qlXT6XP4/fd490GehyvO8sTpfp7xJ8
         KrNclJnEWr09b7CucahuuqcGeVxXbdc1+vF5wbKD2AFgokvyV5srkExxl1lRAOgFrt4a
         jTVkTNP3Oo/N3p53aswcO2uEAEdqRJtNZMOTBLaC7ntAdCdY6p4wOadjoNcZpW/k36dc
         ypo6F4fNyzgkEP7XNz7ZIgxM8ESluYpM0DCRS+G5kySr+FdFl6XLVl+FCqr3CedhSgw2
         naOiSDsCu5yv2LBNSbb3qA62ZvmckieMUygEfuIg56E817/yPIlTNiJYELpsDDySc/fF
         kBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XvvPy7Q4qFhIcL2nJjG34LofSZ7R5VeljzNsh5L5Nb8=;
        b=RThjUuK95zgRWQuF4ALUg39A17R0r5stcmnka4S9c8RQiuti2wOXRH1JHzk0OYuOG0
         3EyKgjTdKEdqqIPVwlDjPpqf4c/GCCJRBbURGCXFLbwQo+RNozNtkPIb2kbRVCAJgaAd
         PL5jRCkR8FktBf99LvbW3gmUx/4PqijikfGZoFAFosQ6WEwpesAl3Smt4mPrW2FuYXzn
         apxDfVDHjSr9+nWZ0feb242LoI+MTbAXmVN+KVcMeUSti9KCsCc9wkGl6R4Cu/F8r019
         nawff4KRspPbDGIirAUgR2osq3xqrVwWos1u4Zm7C19C07m1RxmO69wdz1na+Um9r5eQ
         H8/g==
X-Gm-Message-State: AGRZ1gJTNwpJziHAegOGYbkQizqDgSkcwWXSqaYTEDGH80DXIaryT1MD
        bJhbIt7xDq/tH0/7coTherE=
X-Google-Smtp-Source: AJdET5cTpSSOy5lYBlq8QiWi/JCLzDziKFJCGQlK6RGhGZBDjaTSK2Qk1X1Wh+zJ10tF2u4eRMN/Ig==
X-Received: by 2002:a17:902:1122:: with SMTP id d31-v6mr3801300pla.259.1541668571406;
        Thu, 08 Nov 2018 01:16:11 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id w66-v6sm3284114pfb.51.2018.11.08.01.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 01:16:11 -0800 (PST)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [PATCH V5 10/10] KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
Date:   Thu,  8 Nov 2018 17:14:47 +0800
Message-Id: <20181108091447.8275-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
References: <20181108091447.8275-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Originally, flush tlb is done by slot_handle_level_range(). This patch
is to flush tlb directly in the kvm_zap_gfn_range() when range
flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v4:
	Move operation of setting flush_tlb out of for loop.
---
 arch/x86/kvm/mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 39e0e2572710..898560b0807c 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5633,8 +5633,13 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	bool flush_tlb = true;
+	bool flush = false;
 	int i;
 
+	if (kvm_available_flush_tlb_with_range())
+		flush_tlb = false;
+
 	spin_lock(&kvm->mmu_lock);
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		slots = __kvm_memslots(kvm, i);
@@ -5646,12 +5651,17 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 			if (start >= end)
 				continue;
 
-			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
-						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+			flush |= slot_handle_level_range(kvm, memslot,
+					kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
+					PT_MAX_HUGEPAGE_LEVEL, start,
+					end - 1, flush_tlb);
 		}
 	}
 
+	if (flush)
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
+				gfn_end - gfn_start + 1);
+
 	spin_unlock(&kvm->mmu_lock);
 }
 
-- 
2.14.4

