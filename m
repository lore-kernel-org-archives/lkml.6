Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF952C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9AA20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9AA20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeKHLia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:38:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728523AbeKHLi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:38:29 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B5C85B5AFC6E7;
        Thu,  8 Nov 2018 10:05:19 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Thu, 8 Nov 2018 10:05:15 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/ttm: remove set but not used variable 'driver'
Date:   Thu, 8 Nov 2018 02:15:00 +0000
Message-ID: <1541643300-109641-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/ttm/ttm_execbuf_util.c: In function 'ttm_eu_fence_buffer_objects':
drivers/gpu/drm/ttm/ttm_execbuf_util.c:190:24: warning:
 variable 'driver' set but not used [-Wunused-but-set-variable]

It not used any more after
commit f2c24b83ae90 ("drm/ttm: flip the switch, and convert to dma_fence")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/ttm/ttm_execbuf_util.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_execbuf_util.c b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
index e493edb..efa005a 100644
--- a/drivers/gpu/drm/ttm/ttm_execbuf_util.c
+++ b/drivers/gpu/drm/ttm/ttm_execbuf_util.c
@@ -187,14 +187,12 @@ void ttm_eu_fence_buffer_objects(struct ww_acquire_ctx *ticket,
 	struct ttm_buffer_object *bo;
 	struct ttm_bo_global *glob;
 	struct ttm_bo_device *bdev;
-	struct ttm_bo_driver *driver;
 
 	if (list_empty(list))
 		return;
 
 	bo = list_first_entry(list, struct ttm_validate_buffer, head)->bo;
 	bdev = bo->bdev;
-	driver = bdev->driver;
 	glob = bo->bdev->glob;
 
 	spin_lock(&glob->lru_lock);



