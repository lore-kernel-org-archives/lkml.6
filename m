Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A94C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F9420862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97F9420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeG1Igh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:36:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726056AbeG1Igh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:36:37 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B482FC7CC5FA3;
        Sat, 28 Jul 2018 15:11:03 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.382.0; Sat, 28 Jul
 2018 15:10:56 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: fix a compile warning of Z_EROFS_VLE_VMAP_ONSTACK_PAGES
Date:   Sat, 28 Jul 2018 15:10:32 +0800
Message-ID: <1532761832-6964-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532607728-103372-26-git-send-email-gaoxiang25@huawei.com>
References: <1532607728-103372-26-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a type mismatch in the definition of
Z_EROFS_VLE_VMAP_ONSTACK_PAGES, let's fix it.

Link: https://lists.01.org/pipermail/kbuild-all/2018-July/050707.html
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 3521dfb..3939985 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -218,7 +218,7 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 }
 
 #define Z_EROFS_VLE_VMAP_ONSTACK_PAGES	\
-	min(THREAD_SIZE / 8 / sizeof(struct page *), 96UL)
+	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VLE_VMAP_GLOBAL_PAGES	2048
 
 /* unzip_vle_lz4.c */
-- 
1.9.1

