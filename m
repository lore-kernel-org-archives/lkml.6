Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC8C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0263C20894
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 02:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0263C20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbeHBEA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 00:00:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10212 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeHBEA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 00:00:56 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E850904E2DD6;
        Thu,  2 Aug 2018 10:12:07 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Thu, 2 Aug 2018 10:12:05 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/binfmt_elf: remove the same condition check
Date:   Thu, 2 Aug 2018 10:00:28 +0800
Message-ID: <1533175228-17547-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_align is used to double check in a expression. It is redundant.
so just remove one of them.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index efae2fb..b6c5b02 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1439,7 +1439,7 @@ static int writenote(struct memelfnote *men, struct coredump_params *cprm)
 
 	return dump_emit(cprm, &en, sizeof(en)) &&
 	    dump_emit(cprm, men->name, en.n_namesz) && dump_align(cprm, 4) &&
-	    dump_emit(cprm, men->data, men->datasz) && dump_align(cprm, 4);
+	    dump_emit(cprm, men->data, men->datasz);
 }
 
 static void fill_elf_header(struct elfhdr *elf, int segs,
-- 
1.7.12.4

