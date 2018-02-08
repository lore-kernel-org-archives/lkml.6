Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBHJqN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:46:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeBHJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:46:11 -0500
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] drm/amdgpu: add new device to use atpx quirk
Date: Thu,  8 Feb 2018 17:46:01 +0800
Message-Id: <20180208094601.26215-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The affected system (0x0813) is pretty similar to another one (0x0812),
it also needs to use ATPX power control.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index e2c3c5ec42d1..c53095b3b0fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -568,6 +568,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
 	/* HG _PR3 doesn't seem to work on this A+A weston board */
 	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
+	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.15.1
