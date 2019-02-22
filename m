Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E53C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE158207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 06:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbfBVGPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 01:15:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbfBVGPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 01:15:45 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EE6C41962F416FA915D1;
        Fri, 22 Feb 2019 14:15:42 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 22 Feb 2019
 14:15:34 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <ktkhai@virtuozzo.com>,
        <gregkh@linuxfoundation.org>, <tom@quantonium.net>,
        <asmadeus@codewreck.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] kcm: Remove unnecessary SLAB_PANIC for kmem_cache_create() in kcm_init
Date:   Fri, 22 Feb 2019 14:15:30 +0800
Message-ID: <20190222061530.9820-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

There has check NULL on kmem_cache_create on failure in kcm_init,
no need use SLAB_PANIC to panic the system.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/kcm/kcmsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 571d824..c5c5ab6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -2036,13 +2036,13 @@ static int __init kcm_init(void)
 
 	kcm_muxp = kmem_cache_create("kcm_mux_cache",
 				     sizeof(struct kcm_mux), 0,
-				     SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+				     SLAB_HWCACHE_ALIGN, NULL);
 	if (!kcm_muxp)
 		goto fail;
 
 	kcm_psockp = kmem_cache_create("kcm_psock_cache",
 				       sizeof(struct kcm_psock), 0,
-					SLAB_HWCACHE_ALIGN | SLAB_PANIC, NULL);
+					SLAB_HWCACHE_ALIGN, NULL);
 	if (!kcm_psockp)
 		goto fail;
 
-- 
2.7.0


