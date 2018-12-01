Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B409C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1AF20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 01:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1AF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeLANJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 08:09:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15621 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726013AbeLANJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 08:09:11 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8831F7E4390A1;
        Sat,  1 Dec 2018 09:57:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Sat, 1 Dec 2018 09:57:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jglisse@redhat.com>, <akpm@linux-foundation.org>,
        <sfr@canb.auug.org.au>, <dan.j.williams@intel.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mm/hmm: remove set but not used variable 'devmem'
Date:   Sat, 1 Dec 2018 02:06:11 +0000
Message-ID: <1543629971-128377-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

mm/hmm.c: In function 'hmm_devmem_ref_kill':
mm/hmm.c:995:21: warning:
 variable 'devmem' set but not used [-Wunused-but-set-variable]

It not used any more since commit 35d39f953d4e ("mm, hmm: replace
hmm_devmem_pages_create() with devm_memremap_pages()")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/hmm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 50fbaf8..361f370 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -992,9 +992,6 @@ static void hmm_devmem_ref_exit(void *data)
 
 static void hmm_devmem_ref_kill(struct percpu_ref *ref)
 {
-	struct hmm_devmem *devmem;
-
-	devmem = container_of(ref, struct hmm_devmem, ref);
 	percpu_ref_kill(ref);
 }



