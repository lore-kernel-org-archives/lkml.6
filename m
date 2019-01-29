Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E3AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473C321473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfA2Rk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:40:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51305 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfA2Rk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:40:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0THdv4N2033260
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 29 Jan 2019 09:39:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0THdunR2033257;
        Tue, 29 Jan 2019 09:39:56 -0800
Date:   Tue, 29 Jan 2019 09:39:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Shaokun Zhang <tipbot@zytor.com>
Message-ID: <tip-691b9ab6c9676e5868a4787be9041dd990005311@git.kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com,
        zhangshaokun@hisilicon.com, bp@suse.de, mingo@kernel.org
Reply-To: hpa@zytor.com, x86@kernel.org, luto@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, bp@suse.de,
          zhangshaokun@hisilicon.com, mingo@redhat.com,
          dave.hansen@linux.intel.com
In-Reply-To: <1548747417-33551-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1548747417-33551-1-git-send-email-zhangshaokun@hisilicon.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/mm/tlb: Remove unused cpu variable
Git-Commit-ID: 691b9ab6c9676e5868a4787be9041dd990005311
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  691b9ab6c9676e5868a4787be9041dd990005311
Gitweb:     https://git.kernel.org/tip/691b9ab6c9676e5868a4787be9041dd990005311
Author:     Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate: Tue, 29 Jan 2019 15:36:57 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 29 Jan 2019 18:32:30 +0100

x86/mm/tlb: Remove unused cpu variable

The "cpu" local variable became unused after

  a2055abe9c67 ("x86/mm: Pass flush_tlb_info to flush_tlb_others() etc").

Remove it.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1548747417-33551-1-git-send-email-zhangshaokun@hisilicon.com
---
 arch/x86/mm/tlb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 999d6d8f0bef..bc4bc7b2f075 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -685,9 +685,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 		 * that UV should be updated so that smp_call_function_many(),
 		 * etc, are optimal on UV.
 		 */
-		unsigned int cpu;
-
-		cpu = smp_processor_id();
 		cpumask = uv_flush_tlb_others(cpumask, info);
 		if (cpumask)
 			smp_call_function_many(cpumask, flush_tlb_func_remote,
