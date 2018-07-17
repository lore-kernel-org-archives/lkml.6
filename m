Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A1AECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89AC620852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AC620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGQKBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:01:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40890 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:01:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1ffMIT-0002kV-LA; Tue, 17 Jul 2018 09:29:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix spelling mistake "successed" -> "succeeded"
Date:   Tue, 17 Jul 2018 10:29:29 +0100
Message-Id: <20180717092929.19311-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err error message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9883fa9bb41b..e9feb3c58389 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2004,7 +2004,7 @@ static int amdgpu_device_ip_reinit_early_sriov(struct amdgpu_device *adev)
 				continue;
 
 			r = block->version->funcs->hw_init(adev);
-			DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"successed");
+			DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
 				return r;
 		}
@@ -2039,7 +2039,7 @@ static int amdgpu_device_ip_reinit_late_sriov(struct amdgpu_device *adev)
 				continue;
 
 			r = block->version->funcs->hw_init(adev);
-			DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"successed");
+			DRM_INFO("RE-INIT: %s %s\n", block->version->funcs->name, r?"failed":"succeeded");
 			if (r)
 				return r;
 		}
@@ -3092,7 +3092,7 @@ static int amdgpu_device_handle_vram_lost(struct amdgpu_device *adev)
  * @adev: amdgpu device pointer
  *
  * attempt to do soft-reset or full-reset and reinitialize Asic
- * return 0 means successed otherwise failed
+ * return 0 means succeeded otherwise failed
  */
 static int amdgpu_device_reset(struct amdgpu_device *adev)
 {
@@ -3170,7 +3170,7 @@ static int amdgpu_device_reset(struct amdgpu_device *adev)
  * @from_hypervisor: request from hypervisor
  *
  * do VF FLR and reinitialize Asic
- * return 0 means successed otherwise failed
+ * return 0 means succeeded otherwise failed
  */
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 				     bool from_hypervisor)
@@ -3295,7 +3295,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		dev_info(adev->dev, "GPU reset(%d) failed\n", atomic_read(&adev->gpu_reset_counter));
 		amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_GPU_RESET_FAIL, 0, r);
 	} else {
-		dev_info(adev->dev, "GPU reset(%d) successed!\n",atomic_read(&adev->gpu_reset_counter));
+		dev_info(adev->dev, "GPU reset(%d) succeeded!\n",atomic_read(&adev->gpu_reset_counter));
 	}
 
 	amdgpu_vf_error_trans_all(adev);
-- 
2.17.1

