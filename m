Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35690C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82C020841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82C020841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbeGaSXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:23:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43563 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbeGaSXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:23:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DD80AF36558FB;
        Wed,  1 Aug 2018 00:42:30 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 00:42:30 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] lib/bpf/libbpf: Simplify the code by using PTR_ERR_OR_ZERO
Date:   Wed, 1 Aug 2018 00:30:56 +0800
Message-ID: <1533054656-36134-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use PTR_ERR_OR_ZERO is better than the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 tools/lib/bpf/libbpf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 40211b5..9b61468 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2271,9 +2271,7 @@ struct bpf_map *
 
 long libbpf_get_error(const void *ptr)
 {
-	if (IS_ERR(ptr))
-		return PTR_ERR(ptr);
-	return 0;
+	return PTR_ERR_OR_ZERO(ptr);
 }
 
 int bpf_prog_load(const char *file, enum bpf_prog_type type,
-- 
1.7.12.4

