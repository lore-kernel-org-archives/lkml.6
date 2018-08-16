Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F708C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764C21479
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 05:43:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2764C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbeHPIjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 04:39:15 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56578 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730182AbeHPIjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 04:39:15 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id AE9B3A48ECD4199B5E20;
        Thu, 16 Aug 2018 13:43:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7G5h8Vp056323;
        Thu, 16 Aug 2018 13:43:08 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018081613431512-4699324 ;
          Thu, 16 Aug 2018 13:43:15 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     pbonzini@redhat.com
Cc:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn
Subject: [PATCH] x86/kvm/vmx: Fix coding style in vmx_setup_l1d_flush()
Date:   Thu, 16 Aug 2018 13:42:39 +0800
Message-Id: <1534398159-48509-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-16 13:43:15,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-16 13:42:57,
        Serialize complete at 2018-08-16 13:42:57
X-MAIL: mse01.zte.com.cn w7G5h8Vp056323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Substitute spaces with tab. No functional changes.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/kvm/vmx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 46b428c0..ef712b2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -218,15 +218,15 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		return 0;
 	}
 
-       if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
-	       u64 msr;
-
-	       rdmsrl(MSR_IA32_ARCH_CAPABILITIES, msr);
-	       if (msr & ARCH_CAP_SKIP_VMENTRY_L1DFLUSH) {
-		       l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
-		       return 0;
-	       }
-       }
+	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
+		u64 msr;
+
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, msr);
+		if (msr & ARCH_CAP_SKIP_VMENTRY_L1DFLUSH) {
+			l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NOT_REQUIRED;
+			return 0;
+		}
+	}
 
 	/* If set to auto use the default l1tf mitigation method */
 	if (l1tf == VMENTER_L1D_FLUSH_AUTO) {
-- 
1.8.3.1

