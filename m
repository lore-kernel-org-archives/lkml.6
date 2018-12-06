Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B5C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B635E214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0SIHD9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B635E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbeLFNWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:22:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46111 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbeLFNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:22:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so142262pgp.13;
        Thu, 06 Dec 2018 05:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UUDpb/AopwzZY6zTDuSmIV20QlUMqZc1Sw37yTf055A=;
        b=I0SIHD9da4kxvjq7lK7wqyyZIKx2uRYNWLOhgjONLPgb7Ek2HVrazmzob9cOccWBR8
         oERUbuATW3pQqSDtNfXPJv2XrB4xjPk5KuZHHRFk6/lraGs5qMZ2ftAn5dvSwFXsWWK/
         HMrZHdjnJo/y77zcb5Rz4kOV2LQUgTNDkvUEO2Xk8ldHf/l9BdZYvp7AIU+DbwgQDAr9
         rshyqD7nmnZ2LOyBo6azq4ICeMldkNdeUo+/6JE0ODgPFZujZW4KtJD/80g5R3ATdJOk
         GMrJ7POgCKkeoKcjUw2z7r8PHxh+h31AewYPxdkBNqx/yeTchvoHHc4FiM8B9n15x/Gu
         Bepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UUDpb/AopwzZY6zTDuSmIV20QlUMqZc1Sw37yTf055A=;
        b=ml7ZGGtjIBzquX9nzGgv4gJ/xnPk9wHjd1kL15nr8iHyjzbBcn8TrGnyOguJ5KX6Hm
         nBQdWJ0kSFsX9pVRuui14WvjrU6g1bf4Lje5O41eopKur/aqe335dUcgl1jc0s+5s8Ab
         tkVD5MuHJ3JV1fiix09V4/01YQAcdXHn2DinMRO5n21JoOORQlhqDEBPVBs59g8GVHVU
         5EdEjFBYfQaj4uYi/06BksOU2bSFfX7w4U52xjwY5adbX2WZl7pB2NykbQguIgtM67WD
         bNjaLUQRZ2PbAtOTp0wvRajp6hyl1wIZabgYlbeQhDcY6Zi1Sbdd+9NX8mXRrIWw3PZ9
         fN/w==
X-Gm-Message-State: AA+aEWYxEXTfoFupn8pffhUdnrsKto93k7AjdrBfj2gVfd883Ioka69U
        c3aM56PremJUZrCn3YglnDA=
X-Google-Smtp-Source: AFSGD/WVZVY8Ll/WK0uUuEap9MwCZAsQw/F6YiGcU71KT39iTGX6CyN4siF+c/6+P00A/XTCLsunnw==
X-Received: by 2002:a62:1541:: with SMTP id 62mr28683728pfv.230.1544102554503;
        Thu, 06 Dec 2018 05:22:34 -0800 (PST)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:1a:d9bd:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id y5sm2409246pge.49.2018.12.06.05.22.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 05:22:33 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, pbonzini@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.h.kelley@microsoft.com,
        kys@microsoft.com, vkuznets@redhat.com, linux@armlinux.org.uk
Subject: [Resend PATCH V5 10/10] KVM/MMU: Flush tlb directly in the kvm_zap_gfn_range()
Date:   Thu,  6 Dec 2018 21:21:13 +0800
Message-Id: <20181206132113.2691-11-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
References: <20181206132113.2691-1-Tianyu.Lan@microsoft.com>
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
Change since v4:
	Move operation of setting flush_tlb out of for loop.
---
 arch/x86/kvm/mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 64bd848f021e..94b0540b1471 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5624,8 +5624,13 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 {
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	bool flush_tlb = true;
+	bool flush = false;
 	int i;
 
+	if (kvm_available_flush_tlb_with_range())
+		flush_tlb = false;
+
 	spin_lock(&kvm->mmu_lock);
 	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
 		slots = __kvm_memslots(kvm, i);
@@ -5637,12 +5642,17 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 			if (start >= end)
 				continue;
 
-			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
-						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+			flush |= slot_handle_level_range(kvm, memslot,
+					kvm_zap_rmapp, PT_PAGE_TABLE_LEVEL,
+					PT_MAX_HUGEPAGE_LEVEL, start,
+					end - 1, flush_tlb);
 		}
 	}
 
+	if (flush)
+		kvm_flush_remote_tlbs_with_address(kvm, gfn_start,
+				gfn_end - gfn_start + 1);
+
 	spin_unlock(&kvm->mmu_lock);
 }
 
-- 
2.14.4

