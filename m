Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeCMNW2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:22:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54948 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbeCMNWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:22:22 -0400
From: Colin King <colin.king@canonical.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/pp: remove redundant pointer internal_buf
Date: Tue, 13 Mar 2018 13:22:17 +0000
Message-Id: <20180313132217.31025-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer internal_buf is assigned a value but the pointer is never
read, hence it is redundant and can be removed.

Cleans up clang warning:
drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/smu7_smumgr.c:630:2:
warning: Value stored to 'internal_buf' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
index 7394bb46b8b2..dcb151cabc00 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c
@@ -585,7 +585,6 @@ int smu7_setup_pwr_virus(struct pp_hwmgr *hwmgr)
 int smu7_init(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_smumgr *smu_data;
-	uint8_t *internal_buf;
 	uint64_t mc_addr = 0;
 	int r;
 	/* Allocate memory for backend private data */
@@ -627,7 +626,6 @@ int smu7_init(struct pp_hwmgr *hwmgr)
 					&smu_data->header_buffer.kaddr);
 		return -EINVAL;
 	}
-	internal_buf = smu_data->smu_buffer.kaddr;
 	smu_data->smu_buffer.mc_addr = mc_addr;
 
 	if (smum_is_hw_avfs_present(hwmgr))
-- 
2.15.1
