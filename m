Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533282146D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533282146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389237AbeKPKhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:37:41 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:48676 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbeKPKhk (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Fri, 16 Nov 2018 05:37:40 -0500
Received: from linux-r8p5.psav.com (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 15 Nov 2018 17:27:22 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     dave@stgolabs.net, linux-kernel@vger.kernel.org,
        vgupta@synopsys.com
Subject: [PATCH 3/6] arch/arc: Remove caller signal_pending_branch predictions
Date:   Thu, 15 Nov 2018 16:27:10 -0800
Message-Id: <20181116002713.8474-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181116002713.8474-1-dave@stgolabs.net>
References: <20181116002713.8474-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is already done for us internally by the signal machinery.

Cc: vgupta@synopsys.com
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/arc/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index c9da6102eb4f..6b6df8f9f882 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -142,7 +142,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	fault = handle_mm_fault(vma, address, flags);
 
 	/* If Pagefault was interrupted by SIGKILL, exit page fault "early" */
-	if (unlikely(fatal_signal_pending(current))) {
+	if (fatal_signal_pending(current)) {
 		if ((fault & VM_FAULT_ERROR) && !(fault & VM_FAULT_RETRY))
 			up_read(&mm->mmap_sem);
 		if (user_mode(regs))
-- 
2.16.4

