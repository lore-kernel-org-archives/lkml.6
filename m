Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeEBOnY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:43:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeEBOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:43:20 -0400
From: Colin King <colin.king@canonical.com>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: clean up assignment of amdgpu_crtc
Date: Wed,  2 May 2018 15:43:16 +0100
Message-Id: <20180502144316.32056-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The declaration of pointer amdgpu_crtc has a redundant assignment to
amdgpu_crtc. Clean this up by removing it.

Detected by CoverityScan, CID#1460299 ("Evaluation order violation")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1dd1142246c2..2beb8821e19e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3773,7 +3773,7 @@ static void remove_stream(struct amdgpu_device *adev,
 static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 			       struct dc_cursor_position *position)
 {
-	struct amdgpu_crtc *amdgpu_crtc = amdgpu_crtc = to_amdgpu_crtc(crtc);
+	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	int x, y;
 	int xorigin = 0, yorigin = 0;
 
-- 
2.17.0
