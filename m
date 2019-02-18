Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2AA3217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfBRNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:44:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbfBRNoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:44:09 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CEAD5C5F464A6C2B5A16;
        Mon, 18 Feb 2019 21:44:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 21:43:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Will Deacon <will.deacon@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm: fix set but not used warning
Date:   Mon, 18 Feb 2019 13:57:43 +0000
Message-ID: <20190218135743.131904-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

lib/ioremap.c: In function 'ioremap_page_range':
lib/ioremap.c:203:16: warning:
 variable 'start' set but not used [-Wunused-but-set-variable]

flush_cache_vmap may no need param, so add __maybe_unused fix this warning.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index 063213685563..d1c7a488e731 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -200,7 +200,7 @@ int ioremap_page_range(unsigned long addr,
 		       unsigned long end, phys_addr_t phys_addr, pgprot_t prot)
 {
 	pgd_t *pgd;
-	unsigned long start;
+	unsigned long __maybe_unused start;
 	unsigned long next;
 	int err;



