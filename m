Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E81C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8521A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8521A20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeJWUwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:52:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14105 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726953AbeJWUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:52:03 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE441309548E4;
        Tue, 23 Oct 2018 20:28:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Oct 2018 20:28:20 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akpm@linux-foundation.org>, <mark@fasheh.com>,
        <jlbec@evilplan.org>
CC:     <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ocfs2: remove set but not used variable 'lastzero'
Date:   Tue, 23 Oct 2018 20:15:42 +0800
Message-ID: <1540296942-24533-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lastzero is not used after setting its value. It is safe to remove
the unused variable.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 fs/ocfs2/localalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 7642b67..308f05b 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -835,7 +835,7 @@ static int ocfs2_local_alloc_find_clear_bits(struct ocfs2_super *osb,
 				     u32 *numbits,
 				     struct ocfs2_alloc_reservation *resv)
 {
-	int numfound = 0, bitoff, left, startoff, lastzero;
+	int numfound = 0, bitoff, left, startoff;
 	int local_resv = 0;
 	struct ocfs2_alloc_reservation r;
 	void *bitmap = NULL;
@@ -873,7 +873,6 @@ static int ocfs2_local_alloc_find_clear_bits(struct ocfs2_super *osb,
 	bitmap = OCFS2_LOCAL_ALLOC(alloc)->la_bitmap;
 
 	numfound = bitoff = startoff = 0;
-	lastzero = -1;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
 	while ((bitoff = ocfs2_find_next_zero_bit(bitmap, left, startoff)) != -1) {
 		if (bitoff == left) {
-- 
1.7.12.4

