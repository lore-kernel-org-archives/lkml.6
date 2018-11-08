Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC6FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8AB42081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwcYdFf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8AB42081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeKIAXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:23:37 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43516 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeKIAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:23:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so9637445plb.10;
        Thu, 08 Nov 2018 06:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mf4jQKDBupERk9IP8j/c7DldYt9kVutHpnKEjeY1Ldg=;
        b=fwcYdFf+9AlZPQwgogQlJD8nZixcB1NlIKPDRxASQuGLmaREwbPAatcGpBZ8bpEe37
         9LkibaSPSNezsxfBfMooMzyLDtzKjk0s2FUK6kcI9a4BTS//xo8V+KVD2wxfB13g5EED
         LpQNKyP0fRDytR6bmjZkbPdNyooVTg+KVeNlb+4OeTxE1vqw7CQcLhIjCcgyx0D6ZEyT
         tV5aqZCnX82IZ9ZK+Q8CXenTH4hwRpPEPGorbGoxPKz8mo5+v8hAkYzBLiTMp59PDX8Y
         N2Mt2Zq1YE5RbT863qtEEXa6tChXao9UysBn4evXd0Lh6X2CLkh0IzcVEjyWwHYDEIyZ
         tdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mf4jQKDBupERk9IP8j/c7DldYt9kVutHpnKEjeY1Ldg=;
        b=cUcM6H85fjDRlXHhRLJVbYw4Q6xshiMAVX3aqy0s/XEtw1KWMbUBGaTKKlej8xnoNV
         X4h9HrKVsj0E0Naxm2Y6tx6CTEW6BrqztTm+Jfuit67+C0DWfZMegzJPt/KOijwN1+V4
         mhci5jWrgtQCQ9tH6VlIzOot66qVc+pm9XpMKFuctdON0ggsNxiDA7+U0mc7zqOUVANK
         urIuZaApOMQni4P+kdZzROMp1eVLS5w310Ze4GqPBA1aX8BhGDKgBNfceFTMCeC9TSyl
         PmfKpJXHLI8wbGdTJiCdyIXlI5KewIqSuNJAgpsjBixjK2P6uiUkCzrYXHffxQCWkkcx
         yAvw==
X-Gm-Message-State: AGRZ1gKDYwjYyvP6kdyamKn6zXxJkOnSaRk64rPC64xz8PKMfparm8OQ
        dR+6x5uD+PwCgV5cwQkVtiBHLSLKpYg=
X-Google-Smtp-Source: AJdET5d+H5rPfoE0oonLG665c8wR9C9dx7PhY7q+uqSJYkvd0eAiOgvy8oAubVWMGKEIVxFqhAXmWg==
X-Received: by 2002:a17:902:7784:: with SMTP id o4-v6mr4757041pll.292.1541688466314;
        Thu, 08 Nov 2018 06:47:46 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id k75-v6sm11526731pfb.119.2018.11.08.06.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 06:47:45 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [Resend PATCH V5 9/10] KVM/MMU: Flush tlb directly in the kvm_set_pte_rmapp()
Date:   Thu,  8 Nov 2018 22:46:38 +0800
Message-Id: <20181108144639.11206-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
References: <20181108144639.11206-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

This patch is to flush tlb directly in the kvm_set_pte_rmapp()
and return 0.

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index b13b419166c4..39e0e2572710 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1776,6 +1776,11 @@ static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 		}
 	}
 
+	if (need_flush && kvm_available_flush_tlb_with_range()) {
+		kvm_flush_remote_tlbs_with_address(kvm, gfn, 1);
+		return 0;
+	}
+
 	return need_flush;
 }
 
-- 
2.14.4

