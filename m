Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F8C43615
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89BA20C0C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89BA20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeHTF3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:29:04 -0400
Received: from exmail.andestech.com ([59.124.169.137]:41537 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTF3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:29:04 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7K2DRg8072835;
        Mon, 20 Aug 2018 10:13:27 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 20 Aug 2018
 10:15:13 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <linux-kernel@vger.kernel.org>
CC:     <zongbox@gmail.com>, <greentime@andestech.com>,
        Zong Li <zong@andestech.com>
Subject: [PATCH 1/2] nds32: Remove the deprecated ABI implementation
Date:   Mon, 20 Aug 2018 10:15:04 +0800
Message-ID: <78c2435e2e53169a3190d30e971c5df8a6819919.1534730156.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1534730156.git.zong@andestech.com>
References: <cover.1534730156.git.zong@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7K2DRg8072835
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are not using NDS32 ABI 2 for now, just remove the preprocessor
directives __NDS32_ABI_2.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/traps.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index 7684c8f..f432310 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -117,13 +117,8 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 		       !((unsigned long)base_reg & 0x3) &&
 		       ((unsigned long)base_reg >= TASK_SIZE)) {
 			unsigned long next_fp;
-#if !defined(__NDS32_ABI_2)
-			ret_addr = base_reg[0];
-			next_fp = base_reg[1];
-#else
 			ret_addr = base_reg[-1];
 			next_fp = base_reg[FP_OFFSET];
-#endif
 			if (__kernel_text_address(ret_addr)) {
 
 				ret_addr = ftrace_graph_ret_addr(
-- 
2.7.4

