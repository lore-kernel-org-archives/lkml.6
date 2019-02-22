Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E987C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40322070B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFBImuIf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfBVPHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41653 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbfBVPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id y5so1218437plk.8;
        Fri, 22 Feb 2019 07:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
        b=CFBImuIfxVblpp2dVFSl9Lp9rPMyBKJbp6SYubcKgkfBvz6HEnk2yuVurnpcFMX2jU
         cTnhiQi/FOhPDBwkoIQDJLl0zyH3eS9nXM4J9QsHwFxLU0MIYCx/f0WjO0sKTtmcgRV8
         AxLNTbxwQz+kF7evW9hWhTBmzTA/d0zBmJcztZRYNpgfeo0j99UBLFidJY2Va7EAP1M1
         CmD+rEsUr+8L9SZnkQLZ18nAAAlVLhEpxaYU64OrDAXS0e/CFewKx4NO/okJzcUpM0Cb
         jQknNeAoXBSSXwIAomw0sE6m+7zn4B+9Ndv/Mmzu5dSlNwXJHDC/5kjPbjjc1tazRh38
         fSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mf/z10rMsVUftoqc8y3M+np7GkZ7fKmVzfglvuSuVXs=;
        b=EYDNZPo5MMMx192+Prh6PFN+fix+rZg1cYzbhZmZJqh9aqImnL0tl4KPYARlw9Bxie
         rTa0ca3g6Tp+EojTneTdt9r0Vy3RdwlR0lS8ZVkFd1T+QAN8lUCeuAkv1bawV4FjmPRh
         31D2vt/Bu/Izd6Pj+u2/hyeJj/hTeG7DkMI2kOZqK4rupw/a5EfROpgV3UIj71qle6zh
         KVEOnG50nB1FWLC8yvYoou9HpXtmxcMArxr1OVaPQZGz/puWnjRo+5KDy7A0BMneVCYI
         5BCQh8nzss8hDWSOezhXsF/D7F+GtMiElPJW9uK2S4c9UFsXwQsUZuuPFes8/68nvlhE
         6axA==
X-Gm-Message-State: AHQUAubJ+qpJumJ0OiVLxnz9iVeVsj4oJNkqKv/VaBAqpTY9DNcTDs8D
        VIgfYXQqZElENC52SfKa7To=
X-Google-Smtp-Source: AHgI3IZvijtWlx7ZoYkznF2XUyI7kKJ/XBTUftVSqGMWnP6U+sXA5icoLNJDjyf30+XMJJVp91f3sw==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr4682383plb.270.1550848039252;
        Fri, 22 Feb 2019 07:07:19 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:18 -0800 (PST)
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
Subject: [PATCH V3 3/10] KVM/MMU: Introduce tlb flush with range list
Date:   Fri, 22 Feb 2019 23:06:30 +0800
Message-Id: <20190222150637.2337-4-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
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
 arch/x86/kvm/mmu.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 8d43b7c0f56f..7a862c56b954 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -291,6 +291,20 @@ static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
 
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
@@ -2719,6 +2733,7 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 				    struct list_head *invalid_list)
 {
 	struct kvm_mmu_page *sp, *nsp;
+	HLIST_HEAD(flush_list);
 
 	if (list_empty(invalid_list))
 		return;
@@ -2732,7 +2747,14 @@ static void kvm_mmu_commit_zap_page(struct kvm *kvm,
 	 * In addition, kvm_flush_remote_tlbs waits for all vcpus to exit
 	 * guest mode and/or lockless shadow page table walks.
 	 */
-	kvm_flush_remote_tlbs(kvm);
+	if (kvm_available_flush_tlb_with_range()) {
+		list_for_each_entry(sp, invalid_list, link)
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

