Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF03DC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3320858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 09:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E3320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbeGVKVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 06:21:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9663 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728201AbeGVKVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 06:21:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F0E50E2BF1EF3;
        Sun, 22 Jul 2018 17:25:08 +0800 (CST)
Received: from linux-work.huawei.com (10.67.189.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Sun, 22 Jul 2018 17:25:04 +0800
From:   nixiaoming <nixiaoming@huawei.com>
To:     <bfields@fieldses.org>, <jlayton@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nixiaoming@huawei.com>
Subject: [PATCH] fs/nfsd: Delete invalid assignment statements in nfsd4_decode_exchange_id
Date:   Sun, 22 Jul 2018 16:50:44 +0800
Message-ID: <20180722085044.50701-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dummy = be32_to_cpup(p++);
dummy = be32_to_cpup(p++);
Assigning value to "dummy" here, but that stored value
is overwritten before it can be used.

delete invalid assignment statements in nfsd4_decode_exchange_id

Signed-off-by: n00202754 <nixiaoming@huawei.com>
---
 fs/nfsd/nfs4xdr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index a96843c..8e78541 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -1392,8 +1392,8 @@ nfsd4_decode_exchange_id(struct nfsd4_compoundargs *argp,
 
 		/* ssp_window and ssp_num_gss_handles */
 		READ_BUF(8);
-		dummy = be32_to_cpup(p++);
-		dummy = be32_to_cpup(p++);
+		be32_to_cpup(p++);
+		be32_to_cpup(p++);
 		break;
 	default:
 		goto xdr_error;
-- 
2.10.1

