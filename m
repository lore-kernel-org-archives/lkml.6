Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49AFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F25B20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F25B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387525AbeHAIXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:23:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387419AbeHAIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:23:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CC6572CCEA1F;
        Wed,  1 Aug 2018 14:39:04 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 1 Aug 2018
 14:38:57 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        <yuchao0@huawei.com>, <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        <hsiangkao@aol.com>, <chao@kernel.org>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: remove a redundant marco in xattr
Date:   Wed, 1 Aug 2018 14:38:31 +0800
Message-ID: <1533105511-26197-2-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533105511-26197-1-git-send-email-gaoxiang25@huawei.com>
References: <1532915461-2512-1-git-send-email-gaoxiang25@huawei.com>
 <1533105511-26197-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to '#if CONFIG_EROFS_FS_XATTR' in xattr.c,
let's remove it.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index b74b314..6b9685f 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -420,7 +420,6 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 };
 #endif
 
-#ifdef CONFIG_EROFS_FS_XATTR
 const struct xattr_handler *erofs_xattr_handlers[] = {
 	&erofs_xattr_user_handler,
 #ifdef CONFIG_EROFS_FS_POSIX_ACL
@@ -433,7 +432,6 @@ static int erofs_xattr_generic_get(const struct xattr_handler *handler,
 #endif
 	NULL,
 };
-#endif
 
 struct listxattr_iter {
 	struct xattr_iter it;
-- 
1.9.1

