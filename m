Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1D4C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 14:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC22081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 14:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CC22081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLHOxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 09:53:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbeLHOxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 09:53:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D2C944B8A77C1;
        Sat,  8 Dec 2018 22:53:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 22:53:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <leo.liu@amd.com>,
        <Likun.Gao@amd.com>, <David.Panariti@amd.com>, <shirish.s@amd.com>,
        <Rex.Zhu@amd.com>, <andrey.grodzovsky@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'grbm_soft_reset'
Date:   Sat, 8 Dec 2018 15:01:13 +0000
Message-ID: <1544281273-73940-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function 'gfx_v8_0_pre_soft_reset':
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:4950:27: warning:
 variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c: In function 'gfx_v8_0_post_soft_reset':
drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:5054:27: warning:
 variable 'srbm_soft_reset' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit d31a501ead7f ("drm/amdgpu: add
pre_soft_reset ip func") and e4ae0fc33631 ("drm/amdgpu: implement
gfx8 post_soft_reset")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 1454fc3..8c1ba79 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4947,14 +4947,13 @@ static bool gfx_v8_0_check_soft_reset(void *handle)
 static int gfx_v8_0_pre_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
+	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
 	    (!adev->gfx.srbm_soft_reset))
 		return 0;
 
 	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-	srbm_soft_reset = adev->gfx.srbm_soft_reset;
 
 	/* stop the rlc */
 	adev->gfx.rlc.funcs->stop(adev);
@@ -5051,14 +5050,13 @@ static int gfx_v8_0_soft_reset(void *handle)
 static int gfx_v8_0_post_soft_reset(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
+	u32 grbm_soft_reset = 0;
 
 	if ((!adev->gfx.grbm_soft_reset) &&
 	    (!adev->gfx.srbm_soft_reset))
 		return 0;
 
 	grbm_soft_reset = adev->gfx.grbm_soft_reset;
-	srbm_soft_reset = adev->gfx.srbm_soft_reset;
 
 	if (REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CP) ||
 	    REG_GET_FIELD(grbm_soft_reset, GRBM_SOFT_RESET, SOFT_RESET_CPF) ||



