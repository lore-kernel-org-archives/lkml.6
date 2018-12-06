Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668E8C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC7F20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLHIycFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC7F20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbeLFNVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:21:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36704 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbeLFNVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:21:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so179398pfc.3;
        Thu, 06 Dec 2018 05:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
        b=WLHIycFYaXQ0FyPdeQRQYs8WC6bRrqlmuBnn6QQ5Su48WMNqzCTGkVaprlW0Q2x/bR
         UTsOxyI7d2K6WaP40kFHCNbt34I9aSTgcPkW/UOAWKkTj+Yf4RP3ggqyJY5zjH2QJLo6
         CRe6IcNHI7A2foaAs4cDYedVKh+LVY9grpe2ZRjRNAO9muRrWJ4xg+bJ8rIFaVGMHU4G
         sBb3UAAH7MIql9s0cdbCgYuTZUaFHJwULgDmpVjYWOZ0NM+cKXTZa0QIaA9SJsdRKxA+
         7L+uQ8nxkQ4T70pnsws420LQGf2DRAWlBWVTwdT8YRngx6/RzjUYw3zCZ1TWxnr19JrP
         XcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yl5M/YR6xjWoRgtWFGXbuS2VcfNF+kKFSMttnjzt4tA=;
        b=bQX75WHXMpMVXeh6qmTV2W858jpvMK3nWbXGVH26a00iYA8S+6BKtLLhXjywqT2wHr
         0gNzZ//uB82hnIdtkX7NjeZ6EwuZqlH+gyatkK3T11i9P1GilnM5EehupbpPraK2TRQy
         MqV49twwlCRFNBAbl8G6gMOFZD28KAmvyRaDjGoqraAT5yVg2qalqkJvhCgrl1N9Eo5i
         6WZsimcz0WNfaxGQ8yAPKEVsQfFct2lkfkXffp37d1N/66R/fFOruheT0ExGE1X4iARG
         7GCRjQKazsCqPNqnUfWINHOnnllKowZXj86obSBdwHJ04OFWXjWpuzL6YTbI/frNH09N
         25Tw==
X-Gm-Message-State: AA+aEWZLdxTF6T263tbf4RV2r6xSMaiEHhhpkDXAOoqlJPz1K63Liiwm
        qc5Cz0Q0vcrhOuzFc6d3fwE=
X-Google-Smtp-Source: AFSGD/Vad2NHYMuKRk3TpLn/tHk7cqeYYELuO43hDvsNWnBZeImb5HMnRC3+z6OQuE1c3wZTRRDOFA==
X-Received: by 2002:a62:cf02:: with SMTP id b2mr29644460pfg.183.1544102494752;
        Thu, 06 Dec 2018 05:21:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:21:34 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [Resend PATCH V5 1/10] KVM: Add tlb_remote_flush_with_range callback in kvm_x86_ops
Date:   Thu,  6 Dec 2018 21:21:04 +0800
Message-Id: <20181206132113.2691-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
 arch/x86/include/asm/kvm_host.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fbda5a917c5b..fc7513ecfc13 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -439,6 +439,11 @@ struct kvm_mmu {
 	u64 pdptrs[4]; /* pae */
 };
 
+struct kvm_tlb_range {
+	u64 start_gfn;
+	u64 pages;
+};
+
 enum pmc_type {
 	KVM_PMC_GP = 0,
 	KVM_PMC_FIXED,
@@ -1042,6 +1047,8 @@ struct kvm_x86_ops {
 
 	void (*tlb_flush)(struct kvm_vcpu *vcpu, bool invalidate_gpa);
 	int  (*tlb_remote_flush)(struct kvm *kvm);
+	int  (*tlb_remote_flush_with_range)(struct kvm *kvm,
+			struct kvm_tlb_range *range);
 
 	/*
 	 * Flush any TLB entries associated with the given GVA.
-- 
2.14.4

