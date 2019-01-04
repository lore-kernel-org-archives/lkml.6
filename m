Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619AC43612
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628A0206C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 08:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdMxIz2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfADIy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 03:54:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41828 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfADIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 03:54:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so17152437plm.8;
        Fri, 04 Jan 2019 00:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
        b=bdMxIz2guzLdRdqjth6wjnjPZpbVIL8eDJoyDtFD6lpVDG7+fysF4tr92TwaeGD1UJ
         qRmQlP4GDRzHhqiUly7mOgKQGoRufG5jOxCQprD7BlFuSMnoSILnCdYWNYs+6Ifx/Sln
         BGPnkmqSEvmUauOGa4FkchQZedbLOMT0dOl6y1mzlvMOjHfyYIKmxF2lovPJcLAPFIyg
         gILasOp6WzoJ3XwF459ntkbpt1eusiDJxR2P1Wx8GAlWuPYMWPGZ7tqoeLUStKpgHcy+
         lM5Z8J2RLqWHa11em3HaSKFHjEgz+xGNaSjMe9S5fSyqT57yTB128mxRtrlcPWt36UEC
         q27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i8dTC8urZcLwzyeR/Vu4fyO0uZy0FNHekKBQ29Y6YMc=;
        b=Kqzd/zts0WBWRsVQ2aviZAePf7bi2hOJIimFgq3MC61njQWzoKwXc1rmHufz0TtlOq
         KUnjs9ZJ774uOE84wV1PUUfKyGIqZozUJjlG8C527UUvhNqjd9smzTN73q0BVnhtBDoy
         9uyLOx2S0OoPFLNRQm8in7yG99EVJxvySjy2Uh/c++WvgF4uQswKE0/1UU2G9BtZZoc3
         1za7SThCEgnrXzpqBvu9VkXBvfK2KLQci7zEAIX3kEfybh4F099FhsW7YzkjPwR/5eVX
         8HRfEALvjsq8gf+JvK16HdQk0a/SdsU4mNBHUH04qbyuKRVwMdo0lLfyOPWAoMqUVNi9
         3tyQ==
X-Gm-Message-State: AJcUukevbvZ/h0FYOsPcZW/qPpspN6yyjvv6ils8AyQJgW/fGcb/EvZp
        HvDPouWVnzOqgqfbueWU6s4=
X-Google-Smtp-Source: ALg8bN7Hd/i8EVRwXrchiQNQpGOa141b9ceEW8y8b4HLeNCBSzMideSbEpZ9osZHG5VKjOcZ5XywAA==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr50066601plj.116.1546592067395;
        Fri, 04 Jan 2019 00:54:27 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id i21sm99772145pgm.17.2019.01.04.00.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 00:54:26 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devel@linuxdriverproject.org, kvm@vger.kernel.org,
        michael.h.kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH 1/11] X86/Hyper-V: Add parameter offset for hyperv_fill_flush_guest_mapping_list()
Date:   Fri,  4 Jan 2019 16:53:55 +0800
Message-Id: <20190104085405.40356-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
References: <20190104085405.40356-1-Tianyu.Lan@microsoft.com>
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
index 87224e4c2fd9..2c159efedc40 100644
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

