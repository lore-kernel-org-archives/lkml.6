Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FDEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DE22086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 02:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfBUCgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 21:36:12 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbfBUCgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 21:36:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 84430925CBD4688F6663;
        Thu, 21 Feb 2019 10:36:09 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.207)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 21 Feb 2019 10:35:59
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: switch to ->iterate_shared()
Date:   Thu, 21 Feb 2019 10:34:11 +0800
Message-ID: <20190221023411.2980-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190221023411.2980-1-gaoxiang25@huawei.com>
References: <20190221023411.2980-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 6192269444eb ("introduce a parallel variant of ->iterate()"),
readdir can be done without taking exclusive inode lock of course.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index 8f8ac9675921..829f7b12e0dc 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -142,6 +142,6 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 const struct file_operations erofs_dir_fops = {
 	.llseek		= generic_file_llseek,
 	.read		= generic_read_dir,
-	.iterate	= erofs_readdir,
+	.iterate_shared	= erofs_readdir,
 };
 
-- 
2.14.4

