Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA2212086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 03:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfBUDZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 22:25:25 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfBUDZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 22:25:25 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 21F131D806D7DF1928D6;
        Thu, 21 Feb 2019 11:25:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Thu, 21 Feb 2019 11:25:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/nouveau/dmem: remove set but not used variable 'drm'
Date:   Thu, 21 Feb 2019 03:38:51 +0000
Message-ID: <20190221033851.70331-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/nouveau/nouveau_dmem.c: In function 'nouveau_dmem_free':
drivers/gpu/drm/nouveau/nouveau_dmem.c:103:22: warning:
 variable 'drm' set but not used [-Wunused-but-set-variable]
  struct nouveau_drm *drm;
                      ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index aa9fec80492d..900a302b7ce9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -100,12 +100,10 @@ static void
 nouveau_dmem_free(struct hmm_devmem *devmem, struct page *page)
 {
 	struct nouveau_dmem_chunk *chunk;
-	struct nouveau_drm *drm;
 	unsigned long idx;
 
 	chunk = (void *)hmm_devmem_page_get_drvdata(page);
 	idx = page_to_pfn(page) - chunk->pfn_first;
-	drm = chunk->drm;
 
 	/*
 	 * FIXME:





