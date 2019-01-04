Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5958E206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfoGxhg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfADIyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:54:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45999 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfADIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:54:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so17135840plm.12;
        Fri, 04 Jan 2019 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
        b=UfoGxhg+Hd437kHWcocOKD4R7AEnDRlzv3+9E9HJw9uGV7/pvCZrMR6ZoCK0BaqvmA
         77Mu3LTWe655ERI5Dx3fl4LFYedAvptTqCeFZZV9fkMKJGpW12xQcbXlTMWvnlaPeKtD
         1+xxgO+uhbCznYh4qlV1zGwrCM9GFUEipbnIkCZPi04bRrGL2ONf/Z9HO1fHrvkWEmJ0
         FD46PfpqMUag74dDDGZGWKMOsdJlPqLQM/KOrNyNNZjhHBQPqSwWFxJirOueeWMCLZn/
         xbs/7qlpNmF0vIj9CJjAubmh84omLHTWBxD1AhGu4ws7s4c0KGWR/JFEk5A2OpbMg3oa
         x9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3xvjZ/wjhJvQ+EiSQdkuRkphovQlZ1pkKAij+DudaK0=;
        b=gIQWXBgUVR7wL2PIT5LNV62e01qoFG55/87iktbMtrQ+GIGwhf7+HyjUwfG2BBGcku
         q4LJ6LdKfPD7VoYSgVivsiLlRxEkSbrdMu10rt8Y9VakEyN350Z3sB6Y8ih2BrKs5/YR
         2BxvCWDWew7nmYkp97q1WGBFKeluTN4pT7XRvaDfahrDbQKdtACPGe+UNarrbE3SWLkU
         Ri4xWW4bwNvu2eLSi34X0ulUdSYV/Teem/0UHHcQlOBGw5Yo74PSaKFlDS9nWjipEq0o
         D2TCjJWyoGaa/HtTx5pKDEJa+YxbInShG+l6fgK6Iuu7DTgF2LukjHSPzI6h2MddF8Og
         ipPA==
X-Gm-Message-State: AJcUukf8xf/VMXEnVqFzb7tytgVq3EBcLV8trkTvAg8JZ5loyag7KJ03
        2uMODYksQAI6VPz/MtQS5MM=
X-Google-Smtp-Source: ALg8bN5WGbG/X0YfKxi+O0qWupEnRFREachjWFJDxbXTB00aKKZLPgBmf4DoRkBwMh4mrFM0l5hDCw==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr50903905plk.282.1546592074861;
        Fri, 04 Jan 2019 00:54:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:34 -0800 (PST)
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
Subject: [PATCH 2/11] KVM/VMX: Fill range list in kvm_fill_hv_flush_list_func()
Date:   Fri,  4 Jan 2019 16:53:56 +0800
Message-Id: <20190104085405.40356-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2c159efedc40..384f4782afba 100644
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
+		list_for_each_entry(sp, range->flush_list, flush_link) {
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

