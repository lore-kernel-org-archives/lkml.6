Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08672C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E4320877
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVICMHN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E4320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJMWcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34548 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJMWcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id f78-v6so1833439pfe.1;
        Sat, 13 Oct 2018 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
        b=ZVICMHN0AFLfvRfTF9yl5eF1LtUJio6d6J3YKdxugmdHzEsj5NXvND7pZv/SidDdek
         6My4+c84eQCZREXmERXD0Z2ujNZD/ldNJn5zEVz37wk9/OYXYVpkpLkWRnABYIWyAmcK
         GF3oatbiLja/B2Ge3yx9NqdUaA+1W+keyw3OOvxZQdmm2aUfq3sYKOwk9jVqTHCjDbgk
         Wu2MFL9RTrN06WtDIlRlDY8nRY339wsHGB9T0q606/Yg7WI6wxRXmG77b0oOXGVz8pzE
         fl3VV6iszqco6/a9twuZ2bk9dauQqmQkRQ+Pzgk77Aph5Hld8/GC2Ur3ANhrpNdgLvHZ
         gQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GCaq3R6VmH1wWlGObzsIcMHnr3COIkQBYeAae2u7kcQ=;
        b=knVVLuWEaeSPXvrW79R6p2bSi6ABHhmG4Qd1j+lJ7pjrF9+sJNX0fPJgnajIDqK6vT
         GcoAld0M+XfLqOt2EaUD4t6UmqAMbcooSIkDq/6ifexe8f7/mi40TpcjA2g2NnK5FpJY
         7iLfaWn1r36KNKZmr7kd8ANGBhd8loQcMwuNu8pE1MjFLFi0C5st7EMEwdBKD2I9ihIC
         /xagdLk7QkKk1Bs+750iP6uDogUA+pk3yo+WOPUd5GbirGLfruFsRQ2ocj9aXnY5Prm6
         YmKCTUyIiPVri1b7ink5Hr69+HP6+1ulL3Yoeahpp/cNFUPjcO9Ba+gk7zwhIm+r4/j6
         APHw==
X-Gm-Message-State: ABuFfoj53gtiIeAAfYZ5M5qVWeNJO0auMidOn8tDOdL1JmhChqjKS2a4
        lbspNinzdWZKhdx0JcOnwpJF+f1QmWc=
X-Google-Smtp-Source: ACcGV62EdGNQnQ/sKcjwUyLn1xDKyo7VDncjRak4c7jj414oGg3zSQN7txG6tEyPXVxX5UwcU5idzA==
X-Received: by 2002:a65:4103:: with SMTP id w3-v6mr9732885pgp.284.1539442478487;
        Sat, 13 Oct 2018 07:54:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:37 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org, catalin.marinas@arm.com,
        will.deacon@arm.com, jhogan@kernel.org, ralf@linux-mips.org,
        paul.burton@mips.com, paulus@ozlabs.org, benh@kernel.crashing.org,
        mpe@ellerman.id.au, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devel@linuxdriverproject.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Date:   Sat, 13 Oct 2018 22:53:53 +0800
Message-Id: <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to add wrapper functions for tlb_remote_flush_with_range
callback.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change sicne V3:
       Remove code of updating "tlbs_dirty"
Change since V2:
       Fix comment in the kvm_flush_remote_tlbs_with_range()
---
 arch/x86/kvm/mmu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c73d9f650de7..ff656d85903a 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -264,6 +264,46 @@ static void mmu_spte_set(u64 *sptep, u64 spte);
 static union kvm_mmu_page_role
 kvm_mmu_calc_root_page_role(struct kvm_vcpu *vcpu);
 
+
+static inline bool kvm_available_flush_tlb_with_range(void)
+{
+	return kvm_x86_ops->tlb_remote_flush_with_range;
+}
+
+static void kvm_flush_remote_tlbs_with_range(struct kvm *kvm,
+		struct kvm_tlb_range *range)
+{
+	int ret = -ENOTSUPP;
+
+	if (range && kvm_x86_ops->tlb_remote_flush_with_range)
+		ret = kvm_x86_ops->tlb_remote_flush_with_range(kvm, range);
+
+	if (ret)
+		kvm_flush_remote_tlbs(kvm);
+}
+
+static void kvm_flush_remote_tlbs_with_list(struct kvm *kvm,
+		struct list_head *flush_list)
+{
+	struct kvm_tlb_range range;
+
+	range.flush_list = flush_list;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
+static void kvm_flush_remote_tlbs_with_address(struct kvm *kvm,
+		u64 start_gfn, u64 pages)
+{
+	struct kvm_tlb_range range;
+
+	range.start_gfn = start_gfn;
+	range.pages = pages;
+	range.flush_list = NULL;
+
+	kvm_flush_remote_tlbs_with_range(kvm, &range);
+}
+
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value)
 {
 	BUG_ON((mmio_mask & mmio_value) != mmio_value);
-- 
2.14.4

