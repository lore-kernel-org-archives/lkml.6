Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE1BC282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A5220844
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYWWdogH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBBBjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37774 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfBBBjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3762972pgb.4;
        Fri, 01 Feb 2019 17:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
        b=rYWWdogHyyfoXHNw5vYGz1rLozTLpmOkP0KHq197u7SHmMLbh+SkNqa7NpQtSdMfQq
         Sg2+fJLGoIFUvNopzkSuf+xcc4vTZubXH7cPBLLLEF9z9cMpKmuLzM00WWcaWtYOlYoY
         8QZOVzS/gUsOqXwweSfmeSAQirZ8DFeZxbW/1g1BV9EA1eQNZMAK5En0+ASsQb0IFPtW
         9ehITCoiqh4YiLLPrNJ9/A5Hqo5hIs9LcngkxxNaQ7bQ2DORxuesRxtd5sJsPHHiZCUq
         iuLVUhdb9FEKI7KaHoyxW5MzXqgNtzYoWOuflVepi2+pqZY5pl9G0HkcTbOHhVZ1b240
         7JiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fivvub99Xix9SC3KKfxY3DnEgPVHfJZb9qun3OaRWg=;
        b=XSp+RbJ4ssfRLG/y8sggGiAaXC3amM5s8YwPc5d48ey59kCLSsz844jZ45UbNpTzAt
         +8bMAOGEc3jeHZ566EqNplzG4qEmUtH+1CxK1yntAktUiqFPHCNhum+1+CwDJN12Mw50
         c/R9igiPt044aMSKki8B91qWDQqKyN796PGQ5OTJE7fZYkocP6firo92wFTIwKplJb71
         ktjK3kl8I7v6j4hqkivX6GivGOsYG7mDQa9OaJ4x8cnd/+WW8Ss4m8j/QRapQnjzv7d4
         v+EabJhPT3gVVF1xHeT66PhDL/tWCT2v6CnURYrTR8/LF3bXDABlKdLd8+GvdP4Pgx1A
         8m2Q==
X-Gm-Message-State: AJcUukcuCVYNYoCShfJpnMVN5imOYNb8d0BVwsd2LQes+qdbgfnGbfAC
        /+Bz2iv/b+YnuP+qdR2uXGY=
X-Google-Smtp-Source: ALg8bN7W+aadejbG7oa19lQl7G9yPYUZCeqRb9Yml4K7aisKFkTmeYC8Fchg3oAyUGiZP9Vgewt9Xw==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr41603341pfw.256.1549071557589;
        Fri, 01 Feb 2019 17:39:17 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:16 -0800 (PST)
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
Subject: [PATCH V2 4/10] KVM/MMU: Introduce tlb flush with range list
Date:   Sat,  2 Feb 2019 09:38:20 +0800
Message-Id: <20190202013825.51261-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to introduce tlb flush with range list interface and use
struct kvm_mmu_page as list entry. Use flush list function in the
kvm_mmu_commit_zap_page().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 70cafd3f95ab..d57574b49823 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -289,6 +289,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
 	range.start_gfn = start_gfn;
 	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct hlist_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	if (hlist_empty(flush_list))
+		return;
+
+	range.flush_list = flush_list;
 
 	kvm_flush_remote_tlbs_with_range(kvm, &range);
 }
@@ -2708,6 +2722,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2721,7 +2736,15 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
+			if (sp->last_level)
+				hlist_add_head(&sp->flush_link, &flush_list);
+
+		kvm_flush_remote_tlbs_with_list(kvm, &flush_list);
+	} else {
+		kvm_flush_remote_tlbs(kvm);
+	}
 
 	list_for_each_entry_safe(sp, nsp, invalid_list, link) {
 		WARN_ON(!sp->role.invalid || sp->root_count);
-- 
2.14.4

