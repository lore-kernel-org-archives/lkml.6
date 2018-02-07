Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeBGLN7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:13:59 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39720 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753595AbeBGLN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:13:58 -0500
From: Colin King <colin.king@canonical.com>
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: make structure bochs_bo_driver static
Date: Wed,  7 Feb 2018 11:13:53 +0000
Message-Id: <20180207111353.30261-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The structure bochs_bo_driver is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
drivers/gpu/drm/bochs/bochs_mm.c:197:22: warning: symbol 'bochs_bo_driver'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 704e879711e4..b1d5aee46316 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -194,7 +194,7 @@ static struct ttm_tt *bochs_ttm_tt_create(struct ttm_bo_device *bdev,
 	return tt;
 }
 
-struct ttm_bo_driver bochs_bo_driver = {
+static struct ttm_bo_driver bochs_bo_driver = {
 	.ttm_tt_create = bochs_ttm_tt_create,
 	.ttm_tt_populate = ttm_pool_populate,
 	.ttm_tt_unpopulate = ttm_pool_unpopulate,
-- 
2.15.1
