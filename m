Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B342A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfBRNF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:05:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3665 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728833AbfBRNF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:05:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 19A6297C14510CBF73B7;
        Mon, 18 Feb 2019 21:05:54 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 21:05:48 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Igor Mammedov <imammedo@redhat.com>
Subject: [PATCH] x86/smpboot: Remove unused phys_id variable
Date:   Mon, 18 Feb 2019 21:05:01 +0800
Message-ID: <1550495101-41755-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'phys_id' local variable became unused after commit ce4b1b16502b
("x86/smpboot: Initialize secondary CPU only if master CPU will wait for it").
Remove it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 arch/x86/kernel/smpboot.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ccd1f2a8e557..5d5421b48e55 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -149,7 +149,7 @@ static inline void smpboot_restore_warm_reset_vector(void)
  */
 static void smp_callin(void)
 {
-	int cpuid, phys_id;
+	int cpuid;
 
 	/*
 	 * If waken up by an INIT in an 82489DX configuration
@@ -160,11 +160,6 @@ static void smp_callin(void)
 	cpuid = smp_processor_id();
 
 	/*
-	 * (This works even if the APIC is not enabled.)
-	 */
-	phys_id = read_apic_id();
-
-	/*
 	 * the boot CPU has finished the init stage and is spinning
 	 * on callin_map until we finish. We are free to set up this
 	 * CPU, first the APIC. (this is probably redundant on most
-- 
2.7.4

