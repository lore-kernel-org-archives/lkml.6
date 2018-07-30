Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7199FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EB620881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55EB620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeG3Pbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:31:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54955 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeG3Pba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:31:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7B5B75A0C27F2;
        Mon, 30 Jul 2018 21:56:19 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Mon, 30 Jul 2018 21:56:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/boot/KASLR: Make local variable mem_limit static
Date:   Mon, 30 Jul 2018 21:44:33 +0800
Message-ID: <1532958273-47725-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

arch/x86/boot/compressed/kaslr.c:102:20: warning: symbol 'mem_limit' was not declared. Should it be static?

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/boot/compressed/kaslr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 5aae509..d1e19f3 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -99,7 +99,7 @@ struct mem_vector {
 
 
 /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
-unsigned long long mem_limit = ULLONG_MAX;
+static unsigned long long mem_limit = ULLONG_MAX;
 
 
 enum mem_avoid_index {
-- 
1.7.12.4

