Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE0A20843
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE0A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbeIYRUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:20:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727114AbeIYRUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:20:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1776189AE3FFA;
        Tue, 25 Sep 2018 19:13:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.399.0; Tue, 25 Sep 2018 19:13:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-nfs@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] nfsd: remove set but not used variable 'dirp'
Date:   Tue, 25 Sep 2018 11:22:53 +0000
Message-ID: <1537874573-182553-1-git-send-email-yuehaibing@huawei.com>
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

fs/nfsd/vfs.c: In function 'nfsd_create':
fs/nfsd/vfs.c:1279:16: warning:
 variable 'dirp' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/nfsd/vfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b53e763..d74583f 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1276,7 +1276,6 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		int type, dev_t rdev, struct svc_fh *resfhp)
 {
 	struct dentry	*dentry, *dchild = NULL;
-	struct inode	*dirp;
 	__be32		err;
 	int		host_err;
 
@@ -1288,7 +1287,6 @@ __be32 nfsd_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		return err;
 
 	dentry = fhp->fh_dentry;
-	dirp = d_inode(dentry);
 
 	host_err = fh_want_write(fhp);
 	if (host_err)

