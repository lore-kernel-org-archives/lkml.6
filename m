Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA90C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6CE2147C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 14:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="juTHXYgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6CE2147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJMWcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 18:32:39 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44161 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeJMWci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 18:32:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id p25-v6so7251112pli.11;
        Sat, 13 Oct 2018 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7Q3nhAKtrRoanNPwr2twsR26XJWb59XJ8/rc2Pd+TSM=;
        b=juTHXYgXukWYR3Td4NTZZK6EJLKtcc6JdtqVHyNu+kVR7xNZRl7aB5E1F/+X0kGgap
         qxYqLJppNLOOpufkoOoq0YAr4eTDOyTlmY1XkFTntdxA1E9W+6nsoUFrymLOxvIkISDs
         VNWAIoDMPg1407iiY6co46rGu+zg0rOqZi2LzPtdoaKkNQayIsu1RK+wapeaI3hNJk4c
         i6c6RnmaJcYLt5AkoDGg9h+sCiOcxqWLiqodUdP5rqLHXEftTO2e7Yy58kFmcFgn4DN9
         jheeK/0XgrxVB/SypoJqIXIctCGbK/JD3phe3myubOehZ0O7hKTwPm8lSthWuQLyY8vD
         WWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7Q3nhAKtrRoanNPwr2twsR26XJWb59XJ8/rc2Pd+TSM=;
        b=C8ZpgukMOt7ORDWRvmBSKSh81vvmH3/W7HLbMSgWnZNeDE8D0KFriYL8fzsJmQRYVe
         n5CucQsXXylBbA9XjYr4Yc5+nImDhQP5oFbd1kf0Z+2fwjN4NO8C4fs97q3KwxEtuRDw
         FXF5C5Bec9/FvemABrmomlw8vEM0nPE1A+4ijsGxOIWcj5aL+PfS7i07Qqib5XfdqXO3
         7xBvEigY2OPsOwDlNOaDn5A64WpVrJmaX1FulxweorMf69PZTECWXq1D9MdEa9onF70r
         0iQTtqhrcbX9W3+RWOI/jSnwN5mLZJBdAtRpP1Hv0rXHfw4AwTF9U3Zf+DmsLRWg+TbH
         Vssw==
X-Gm-Message-State: ABuFfohPp1NMvd6bIhfd+CAq5u3T9xAyz3tMl82aKcNtazMtJNIyU67u
        m/vMvX4BAHT+LW5YRJtgAzM=
X-Google-Smtp-Source: ACcGV63b0c5lCTEQrOnu8mN9LxriClh6gIER0G18ZTTiuME/nyTJxVt+XPErq0I0h9n5EgJY8XNvgQ==
X-Received: by 2002:a17:902:509:: with SMTP id 9-v6mr10216527plf.155.1539442512417;
        Sat, 13 Oct 2018 07:55:12 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2404:f801:9000:18:d9bf:62c6:740b:9fc4])
        by smtp.googlemail.com with ESMTPSA id v81-v6sm8688724pfj.25.2018.10.13.07.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 07:55:11 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com
Subject: [PATCH V4 8/15] KVM/MMU: Flush tlb directly in kvm_mmu_zap_collapsible_spte()
Date:   Sat, 13 Oct 2018 22:53:59 +0800
Message-Id: <20181013145406.4911-9-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

kvm_mmu_zap_collapsible_spte() returns flush request to the
slot_handle_leaf() and the latter does flush on demand. When
range flush is available, make kvm_mmu_zap_collapsible_spte()
to flush tlb with range directly to avoid returning range back
to slot_handle_leaf().

Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
 arch/x86/kvm/mmu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index c4f7679f12c3..e984a0067a43 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5743,7 +5743,13 @@ static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
 			!kvm_is_reserved_pfn(pfn) &&
 			PageTransCompoundMap(pfn_to_page(pfn))) {
 			drop_spte(kvm, sptep);
-			need_tlb_flush = 1;
+
+			if (kvm_available_flush_tlb_with_range())
+				kvm_flush_remote_tlbs_with_address(kvm, sp->gfn,
+					KVM_PAGES_PER_HPAGE(sp->role.level));
+			else
+				need_tlb_flush = 1;
+
 			goto restart;
 		}
 	}
-- 
2.14.4

