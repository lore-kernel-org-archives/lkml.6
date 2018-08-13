Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05ECEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4E421798
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 05:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4E421798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeHMI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 04:27:14 -0400
Received: from exmail.andestech.com ([59.124.169.137]:25806 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHMI1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 04:27:14 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w7D5jBL4038723;
        Mon, 13 Aug 2018 13:45:11 +0800 (GMT-8)
        (envelope-from zong@andestech.com)
Received: from atcsqa06.andestech.com (10.0.1.85) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 13 Aug 2018
 13:46:29 +0800
From:   Zong Li <zong@andestech.com>
To:     <green.hu@gmail.com>, <deanbo422@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zong Li <zong@andestech.com>
Subject: [PATCH] nds32: Fix empty call trace
Date:   Mon, 13 Aug 2018 13:46:24 +0800
Message-ID: <1534139184-10993-1-git-send-email-zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w7D5jBL4038723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler predefined macro 'NDS32_ABI_2' had been removed, it should
use the '__NDS32_ABI_2' here.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/nds32/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nds32/kernel/traps.c b/arch/nds32/kernel/traps.c
index a6205fd..f0e9743 100644
--- a/arch/nds32/kernel/traps.c
+++ b/arch/nds32/kernel/traps.c
@@ -137,7 +137,7 @@ static void __dump(struct task_struct *tsk, unsigned long *base_reg)
 		       !((unsigned long)base_reg & 0x3) &&
 		       ((unsigned long)base_reg >= TASK_SIZE)) {
 			unsigned long next_fp;
-#if !defined(NDS32_ABI_2)
+#if !defined(__NDS32_ABI_2)
 			ret_addr = base_reg[0];
 			next_fp = base_reg[1];
 #else
-- 
2.7.4

