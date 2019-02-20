Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82770C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591422146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfBTDSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:18:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfBTDSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:18:17 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 05673B32CE2C1F5DD00B;
        Wed, 20 Feb 2019 11:18:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Wed, 20 Feb 2019 11:18:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Oded Gabbay <oded.gabbay@gmail.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <David1.Zhou@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variables 'vm, bo'
Date:   Wed, 20 Feb 2019 03:31:50 +0000
Message-ID: <20190220033150.163019-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'update_gpuvm_pte':
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:840:20: warning:
 variable 'bo' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:838:20: warning:
 variable 'vm' set but not used [-Wunused-but-set-variable]

They're never used since introduction in a46a2cd103a8 ("drm/amdgpu: Add GPUVM
memory management functions for KFD")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d7b10d79f1de..63daf758cd03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -837,13 +837,7 @@ static int update_gpuvm_pte(struct amdgpu_device *adev,
 		struct amdgpu_sync *sync)
 {
 	int ret;
-	struct amdgpu_vm *vm;
-	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
-
-	bo_va = entry->bo_va;
-	vm = bo_va->base.vm;
-	bo = bo_va->base.bo;
+	struct amdgpu_bo_va *bo_va = entry->bo_va;
 
 	/* Update the page tables  */
 	ret = amdgpu_vm_bo_update(adev, bo_va, false);





