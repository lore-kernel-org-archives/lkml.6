Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94233C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9312098A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rp6f8txF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9312098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJMWb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:31:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33766 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeJMWb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:31:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so7282285plp.0;
        Sat, 13 Oct 2018 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
        b=rp6f8txFq2Z++vvFYXV5hUS6IcLak/IyxBJWHXWM8AkS6KURSFVAfxx/YE97efIsUU
         E4e/KL8csquVEaxBw0R1BoISOtQsd75AZA16eXP5lGPyMZZxTDY94QRtVOd9z8gB+BGz
         EyyW4yykMzbdZnZ0H78W4ERR3OJ+/BR8mDkbAw89wA4dlzgDzcDqopu7pUYAGrfWcCvd
         nwDcS3oU1IPTjODCkh8Q1L6F4qsiz8g5B8mROcu6prFhM2YZP6/b8phF8BgMKTw+LKgf
         2oxwPYzgHQER/la4dzJ2wKp21z2Nx7HtMZdVuZl42f8NzQV9qo+aq6M+MgYi1fijdt/y
         cMhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=px0gV+gBnpOH60iOcTCGqmbUjehg++DRdbAxzx/hWFA=;
        b=O/g3gN6ia0G3bqyEF7TPwe+QsyQI20flalKRbmj6WkNZdluq8vQJ/vn/cz+s9oosbL
         PvQRgvkvBBvD+g967k/4zJhcG+jLRBaHOKXTGK6Nrn3iErqGkBQmZi9KUme9OM/He5lf
         QfZeaoXXcG2LXb7GTU6Xkk4OD1WYANmeha62aJT27VYr/X1L76NbBaEXkfXYDb8RLQ8T
         Hqbep/gyJVk4nFetmc/P0ghyMOT4moLnVxS6q0cKBcPmA/Cyz6nVApHiVIaAcICym/tv
         LLJkEO1u/J/nhMQ/HAadC4HZk6c5IjVmO+PzPvbxsap2Qo1YXYEMWnFLyZoP6UKw8WC+
         tMGw==
X-Gm-Message-State: ABuFfoiAPbZty6KCbXzypDTB1bZvc3QBNYWf9URSGJ497gRFJkm1UZZL
        Zkje3dB36fGAJaH+kOMgmETMdsEkRFg=
X-Google-Smtp-Source: ACcGV62HWs3gWO94ingYjrTNOd2X4hqsmsPW7d3NRYDQAgfnfqDU4fT7925KW4ssd+32230A+ZzFJA==
X-Received: by 2002:a17:902:2825:: with SMTP id e34-v6mr1226708plb.244.1539442470478;
        Sat, 13 Oct 2018 07:54:30 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.54.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:54:29 -0700 (PDT)
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
Subject: [PATCH V4 1/15] KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
Date:   Sat, 13 Oct 2018 22:53:52 +0800
Message-Id: <20181013145406.4911-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add flush range call back in the kvm_x86_ops and platform can use it
to register its associated function. The parameter "kvm_tlb_range"
accepts a single range and flush list which contains a list of ranges.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Change "end_gfn" to "pages" to aviod confusion as to whether
"end_gfn" is inclusive or exlusive.
---
 arch/x86/include/asm/kvm_host.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4b09d4aa9bf4..fea95aa77319 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,12 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+	struct list_head *flush_list;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1039,6 +1045,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

