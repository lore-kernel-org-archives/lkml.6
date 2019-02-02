Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3590C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FAE2075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWgc/n0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBBBi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:38:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44332 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfBBBiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:38:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id t13so3741400pgr.11;
        Fri, 01 Feb 2019 17:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/TrOrVhLXlgdKs/anicFSIumLYNrR3S6ily0jTwiFk=;
        b=sWgc/n0wioZ0QPyR2/TMQhWMn+EcQ4V9TLtHHpF6yUVU5eoSZFrKAXwnHKFduWuNGy
         bhdPbUncbK4hPYBXcGL6hac5877pETaapnUHwEFWCyic4Q1LtZg5eNnY9JvnC2wjdQ35
         NEc0YoMNf7cg7l8zHMGYXw6yDYSX96DJXYcin/1oF9pZBzV0D01BxgoUARYPA4S78Wys
         T6fs8GyRnxh04MBB2iQB1cXVv6z2RCeJs2+5yyTZ/dj09bGrg/0WmsW3EkSbSmkrvHE9
         l5oVFt51S01XR3mDQMHo5uDS3NeUdcWXKZrX3iNjg8/oWnwLaMugDW9zPsZJSTTeEfTm
         mO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/TrOrVhLXlgdKs/anicFSIumLYNrR3S6ily0jTwiFk=;
        b=Sb7YU9IwvAOLz5CMW6C6wFIBkIigeEFGF5xmtX5EDuMzEuglBo/IURGypFRsLrlgNm
         7AFlHt70Ap5e6XsC/vHzClfYNuOAcWWZgaRvtXFSo9wAWGb8QgqUZJT5k2O3WzA2LDrt
         9JJwtmw1KED2OSD7LJuk+ET3Dknu1AoTHj82JISFfOytAyt3Wt778dljzKog2At7Z1Jy
         UP+yrtat1PgFl4JkUiZ8bDSxD5qZuMmoHhadYpSAl4lvhyb6J8jVQoSfDYiiUIHGL0CQ
         kMK8bncQYyp9PNo2b2Neg8Vx2QBXEuZ5TgdDV2tE3V+Haj4APopyc6HsGX68WEFMQhTk
         3XCg==
X-Gm-Message-State: AHQUAua3QwppiqvrQqy583v41KCDRzBzXkuloV390JlPwp/woqMTQ+3K
        FeSbNfTgQH0cnR48H7WKt0g=
X-Google-Smtp-Source: AHgI3IZQrPjBo3eUg0JRfhqVrGX+BuDiIBD5aJn/dNJwX/tBweo7Rr0ue0lfwQapg8+KOo95O3mC9w==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr4549552pgh.265.1549071534414;
        Fri, 01 Feb 2019 17:38:54 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:38:53 -0800 (PST)
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
Subject: [PATCH V2 1/10] X86/Hyper-V: Add parameter offset for hyperv_fill_flush_guest_mapping_list()
Date:   Sat,  2 Feb 2019 09:38:17 +0800
Message-Id: <20190202013825.51261-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
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
index f6915f10e584..9d954b4adce3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -428,7 +428,7 @@ int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
 {
 	struct kvm_tlb_range *range = data;
 
-	return hyperv_fill_flush_guest_mapping_list(flush, range->start_gfn,
+	return hyperv_fill_flush_guest_mapping_list(flush, 0, range->start_gfn,
 			range->pages);
 }
 
-- 
2.14.4

