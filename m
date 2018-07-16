Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B91ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4110920C07
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 04:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110920C07
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeGPEri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 00:47:38 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:7812 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeGPErh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 00:47:37 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 5E5066D8EF17DEFA9702;
        Mon, 16 Jul 2018 12:06:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6G46cn2071066;
        Mon, 16 Jul 2018 12:06:38 +0800 (GMT-8)
        (envelope-from jiang.biao2@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018071612063974-486048 ;
          Mon, 16 Jul 2018 12:06:39 +0800 
From:   Jiang Biao <jiang.biao2@zte.com.cn>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, hpa@zytor.com,
        x86@kernel.org, albcamus@gmail.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, jiang.biao2@zte.com.cn
Subject: [PATCH 3/5] x86/pti: make pti_set_kernel_image_nonglobal static
Date:   Mon, 16 Jul 2018 12:03:38 +0800
Message-Id: <1531713820-24544-4-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
References: <1531713820-24544-1-git-send-email-jiang.biao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-16 12:06:40,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-16 12:06:38,
        Serialize complete at 2018-07-16 12:06:38
X-MAIL: mse01.zte.com.cn w6G46cn2071066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pti_set_kernel_image_nonglobal() is only used in pti.c, make it
static.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 arch/x86/mm/pti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index bb6f608..a76b2cc 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -473,7 +473,7 @@ void pti_clone_kernel_text(void)
  * the other set_memory.h functions.  Just extern it.
  */
 extern int set_memory_nonglobal(unsigned long addr, int numpages);
-void pti_set_kernel_image_nonglobal(void)
+static void pti_set_kernel_image_nonglobal(void)
 {
 	/*
 	 * The identity map is created with PMDs, regardless of the
-- 
2.7.4

