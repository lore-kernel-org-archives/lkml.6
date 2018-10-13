Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE2BC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E9420877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZMjwXcI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJMWce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38780 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so4182598pll.5;
        Sat, 13 Oct 2018 07:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q/7F43zhWx/k3N9zoPwgZYybcBw1Pe45+WdtmLtkfPE=;
        b=iZMjwXcIZQ64Vc7p72mkpjWEZuW++pmBRYnTO420QfKWfgp/Oz9qnwRlrR3tD6md4u
         m0KtdxhX9jnvyaKY182mG9HaiciZcpxsiHS01J3/J88qay558wvMaAD3ot/Fh2hiWNLZ
         TbdFOCKCfL/E33aQUBMZSd8zpFb5wTqw3n3K7IcOL3gz6vKWfVneu9BdniNbOhMpbNvP
         huWxK8AB0IPNaR+U2azLVoStK7ig28McwBp+VjPAFW7A4Ocxj11mAwrHFL6yRkOWOcQw
         1yKZHBNiXqd+6u3PHKpUZZI+S7gyjpodLAW+RkcpCPcqORmHk8HslnS984bX6ZZbS1BJ
         bFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q/7F43zhWx/k3N9zoPwgZYybcBw1Pe45+WdtmLtkfPE=;
        b=rLrE2zDj8qnELyutVYKIjvk+iwfgb9Hppz5L6RewL24ct3nAzdQ3doJ3xvTYujwQqt
         nxEP0ohSD70D+q8ioAgiyffMBfx3rTZGCWNRb9zL7AcIgajp+q1UjUF/NozL8cHwIDep
         Rc4Oso1dATJMt6+uvROZZtVlncVENj5vQ4SAbiCPNBM516cIM0a/O8mZpF+I9Jf2mY32
         UbI0eFhRJ04Kz/8lqLQgK11KersrBfgvsStoOEXuWznhg7cdJOsgbeMs+wl7UKv/jZ4O
         xR5Wy9KdxZqJ4G2mzC6IGtYzirOGZmGQg5FCT0jKoA7DE3ESui+0kJvcZ6XRTioCMMgf
         e+ug==
X-Gm-Message-State: ABuFfogGVURdBk+//O/t/v3CSQhrzxAv63GFTE3ww9VAaFwYnDpm3OYP
        kvTEFvn5vqoM4cnjUyqfHGk=
X-Google-Smtp-Source: ACcGV60FwrRWDNj+IcKMRZrOX1DRC7j2CMJerg5Mj2+tBbXgLwDK8Vd9p+YXEoRXbDiHzYWedN6KfQ==
X-Received: by 2002:a17:902:b58c:: with SMTP id a12-v6mr9905953pls.226.1539442507928;
        Sat, 13 Oct 2018 07:55:07 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:07 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 7/15] KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
Date:   Sat, 13 Oct 2018 22:53:58 +0800
Message-Id: <20181013145406.4911-8-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
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
 arch/x86/kvm/mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index f3742ff4ec18..c4f7679f12c3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5647,6 +5647,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	bool flush = false;
 	int i;
 
 	spin_lock(&kvm->mmu_lock);
@@ -5654,18 +5655,27 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(memslot, slots) {
 			gfn_t start, end;
+			bool flush_tlb = true;
 
 			start = max(gfn_start, memslot->base_gfn);
 			end = min(gfn_end, memslot->base_gfn + memslot->npages);
 			if (start >= end)
 				continue;
 
-			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
-						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+			if (kvm_available_flush_tlb_with_range())
+				flush_tlb = false;
+
+			flush = slot_handle_level_range(kvm, memslot,
+					kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
+					PT_MAX_HUGEPAGE_LEVEL, start,
+					end - 1, flush_tlb);
 		}
 	}
 
+	if (flush && kvm_available_flush_tlb_with_range())
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
+				gfn_end - gfn_start + 1);
+
 	spin_unlock(&kvm->mmu_lock);
 }
 
-- 
2.14.4

