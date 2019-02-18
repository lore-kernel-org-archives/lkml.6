Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D58DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455152184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfBRIlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:41:24 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3662 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727423AbfBRIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:41:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3567E462276564538129;
        Mon, 18 Feb 2019 16:41:21 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 16:41:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <spice-devel@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/qxl: remove set but not used variable 'bo_old'
Date:   Mon, 18 Feb 2019 08:54:59 +0000
Message-ID: <20190218085459.196470-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/qxl/qxl_display.c: In function 'qxl_primary_atomic_update':
drivers/gpu/drm/qxl/qxl_display.c:538:17: warning:
 variable 'bo_old' set but not used [-Wunused-but-set-variable]

It's not used any more after 4979904c62b9 ("drm/qxl: use shadow bo directly")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 08c725544a2f..8b319ebbb0fb 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -535,7 +535,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 {
 	struct qxl_device *qdev = plane->dev->dev_private;
 	struct qxl_bo *bo = gem_to_qxl_bo(plane->state->fb->obj[0]);
-	struct qxl_bo *bo_old, *primary;
+	struct qxl_bo *primary;
 	struct drm_clip_rect norect = {
 	    .x1 = 0,
 	    .y1 = 0,
@@ -544,12 +544,6 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	};
 	uint32_t dumb_shadow_offset = 0;
 
-	if (old_state->fb) {
-		bo_old = gem_to_qxl_bo(old_state->fb->obj[0]);
-	} else {
-		bo_old = NULL;
-	}
-
 	primary = bo->shadow ? bo->shadow : bo;
 
 	if (!primary->is_primary) {





