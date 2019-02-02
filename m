Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D3C282DB
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459302075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 01:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agQsC2Qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfBBBje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 20:39:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45959 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfBBBjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 20:39:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so4074978pfd.12;
        Fri, 01 Feb 2019 17:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
        b=agQsC2QdMvpn4C7uhQZI3oL3d4Tompeso7z2aiQkFncmX4JWg/uBamjV6PdFYhVR3k
         oX2uDQAPGf5vd3JMceHjWd3zOb6honNJovwJzyFsDilYk3h4kPDusmb8mZ7ZEYleqcSE
         9uBme4VReWk1RL9qbeNyI+Z8+CHg7tBC670AHNS9Ixurcy4RidGTlBfGSEeSBVskoBE4
         kDDouF+hsf/IUxkz3wWDqCor8SL1zRKNxx8sFfe0FC1ZLM9D8d8rtxmhZTbUJwEcx94e
         uAcqSt+1r9k0d5su0uGKjFvdvzQFGnPHQYuPGbaLZGAetRUCfjM2O99LcXRklvHcAi42
         iNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S4ftVHg5FlZ3hwaB6myWBWPeAhGqQEGBON/Y0CtAvlA=;
        b=WxQlOAylkl6JYpWwrvkZ871XamxSsihmKmzsRKTgZicVIyJCRsyeBHZ4LQfg1eV3jd
         +WJ0NvJewV0ZsuHfH+SgJrNzz9LViTZYjihUWLxDAwK09duLOxvZMWxuTQZ+RpI8Ac8O
         Cy/548aPx8nDKioiXd2CLF1mlHeHF0/n0rbYgQegnSExYMTwo137gKT8NnJv70vF001+
         GdxFOE9ElvdxzCDncsGta+gFohsxuy5T/xiaXS10XFjuLGfPPsnH5LregpIGV2RU26Dc
         x9dWoTT9shZ040ScoeAUaCSkvuslHNyFg61L6+0cMhe56YvuzIOOiHinISDz2CQamMBB
         pIig==
X-Gm-Message-State: AJcUukdl3Mh5RAkcgtc69MOJ3rnExXzAIhSNR8kcrLihw3AfyN01S52e
        Vmex4xRZswUpOFHl8rdJxfQ=
X-Google-Smtp-Source: ALg8bN6ijptjqFitOy96WFBZeRXgkg4rQ+4Jg8H6p266gaeKh2xdTdOvDwbEn+uVqVIuUB2t5iGdSg==
X-Received: by 2002:a62:5910:: with SMTP id n16mr41321495pfb.128.1549071572866;
        Fri, 01 Feb 2019 17:39:32 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id d3sm9183425pgl.64.2019.02.01.17.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 17:39:32 -0800 (PST)
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
Subject: [PATCH V2 6/10] KVM/MMU: Flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
Date:   Sat,  2 Feb 2019 09:38:22 +0800
Message-Id: <20190202013825.51261-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
References: <20190202013825.51261-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_mmu_slot_gfn_write_protect()
when range flush is available.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d57574b49823..6b5e9bed6665 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1718,6 +1718,11 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
 	}
 
+	if (write_protected && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		write_protected = false;
+	}
+
 	return write_protected;
 }
 
-- 
2.14.4

