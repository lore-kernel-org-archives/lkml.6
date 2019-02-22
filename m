Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6659DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EA02075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIyl/DXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfBVPHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:07:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38218 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfBVPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:07:04 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so1228689plb.5;
        Fri, 22 Feb 2019 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
        b=bIyl/DXXoGgQ4YrmVh1iadO3QT3Swk9cSFXEkSmL/zgA6U5uSOK3j/JZSbs9Qtn+qa
         S0pmsqlkUsMp0oIEQ+Pt4CQ6Q3Cd/sKIFlYfcMIRRXe+Cq8f4I/9jlvjiaYi5WqcZmHz
         wJCQqz6u1iv0Ns7GKuH2nmuhofoUU1g88ZohSdRaH4x+ZQyljcbTpY2SiHBhskEuCmFb
         IDqMu8v+TxxqQch73KOvnX7gyDpvry5EPBWhnMOQXwm9mRacBeSzxaj1q1DLUaayBKEU
         4BCaeriqTYrulXkLn9cB1HowchpJzY6P4U6kyBnvCTvp3xXgSi/GPRYdMXQqbQBNxiRb
         CXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XOGqMApv5NREZBijyNBtk5Mq8chNh80zkhgEbpmMbVY=;
        b=dnqGNjcrGU/g6a8cr/To2JWDHJ9td90Dect2vc7kszbuIG1sIOhe1pDuKLoSA0w38u
         t3jF/dVLuHD+B8swIZ8KZl4QWo2MS5MJ5klndKXPpderwy3oyO6ECOQMaCKopZPvSRiy
         79XtSNiHd4cDeWD14DbVQqFZRUyUaLzPUucjx32wIXdvAyy5RxYseVxsvKslBliJMreD
         cV5YDp1C4MAQMsxSlBpMKvneUGBrLKwAZyrSP008HZW5UkHaPvdQ89UExKbCsqGauP6M
         FeBNQMKRl9Fl6il3EkCQcDzNhXbokJqwvIWN5hh+sQ/Wp1UvZUWRdjWScPUmkUUfsJZh
         DtCw==
X-Gm-Message-State: AHQUAuYD18FXW2nnbetq3gauzamo6lPlQ13QXMZE9urU6ssTs7Or1i5B
        TofpcEOdycgjAHWoPqCLK8o=
X-Google-Smtp-Source: AHgI3IZnxTMvvgIxIDjzAuWz/HznH+k+Vt2jo6Sat5I/rRyjGjsyeBvU0wvI0UHS3T9mvcSEjBCnPA==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr4652130pll.110.1550848023631;
        Fri, 22 Feb 2019 07:07:03 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id a4sm6151780pga.52.2019.02.22.07.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 07:07:02 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, christoffer.dall@arm.com,
        marc.zyngier@arm.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, jhogan@kernel.org,
        ralf@linux-mips.org, paul.burton@mips.com, paulus@ozlabs.org,
        benh@kernel.crashing.org, mpe@ellerman.id.au, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 1/10] X86/Hyper-V: Add parameter offset for hyperv_fill_flush_guest_mapping_list()
Date:   Fri, 22 Feb 2019 23:06:28 +0800
Message-Id: <20190222150637.2337-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
References: <20190222150637.2337-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

Add parameter offset to specify start position to add flush ranges in
guest address list of struct hv_guest_mapping_flush_list.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/nested.c        | 4 ++--
 arch/x86/include/asm/mshyperv.h | 2 +-
 arch/x86/kvm/vmx/vmx.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
index dd0a843f766d..96f8bac7476d 100644
--- a/arch/x86/hyperv/nested.c
+++ b/arch/x86/hyperv/nested.c
@@ -58,11 +58,11 @@ EXPORT_SYMBOL_GPL(hyperv_flush_guest_mapping);
 
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 pages)
+		int offset, u64 start_gfn, u64 pages)
 {
 	u64 cur = start_gfn;
 	u64 additional_pages;
-	int gpa_n = 0;
+	int gpa_n = offset;
 
 	do {
 		/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index cc60e617931c..d6be685ab6b0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -357,7 +357,7 @@ int hyperv_flush_guest_mapping_range(u64 as,
 		hyperv_fill_flush_list_func fill_func, void *data);
 int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
-		u64 start_gfn, u64 end_gfn);
+		int offset, u64 start_gfn, u64 end_gfn);
 
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4950bb20e06a..77b5379e3655 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -433,7 +433,7 @@ static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush
 {
 	struct kvm_tlb_range *range = data;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
 			range->pages);
 }
 
-- 
2.14.4

