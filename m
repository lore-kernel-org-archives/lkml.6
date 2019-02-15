Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251E32192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfBODVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:21:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfBODVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:21:17 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5FA9629EF71154F10FE9;
        Fri, 15 Feb 2019 11:21:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Feb 2019 11:21:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm: Remove set but not used variable 'gem'
Date:   Fri, 15 Feb 2019 03:35:07 +0000
Message-ID: <20190215033507.103232-1-yuehaibing@huawei.com>
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

drivers/gpu/drm/vc4/vc4_txp.c: In function 'vc4_txp_connector_atomic_check':
drivers/gpu/drm/vc4/vc4_txp.c:252:29: warning:
 variable 'gem' set but not used [-Wunused-but-set-variable]
  struct drm_gem_cma_object *gem;
                             ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/vc4/vc4_txp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index aa279b5b0de7..afb1c4ec4f18 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -249,7 +249,6 @@ static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 					struct drm_connector_state *conn_state)
 {
 	struct drm_crtc_state *crtc_state;
-	struct drm_gem_cma_object *gem;
 	struct drm_framebuffer *fb;
 	int i;
 
@@ -275,8 +274,6 @@ static int vc4_txp_connector_atomic_check(struct drm_connector *conn,
 	if (i == ARRAY_SIZE(drm_fmts))
 		return -EINVAL;
 
-	gem = drm_fb_cma_get_gem_obj(fb, 0);
-
 	/* Pitch must be aligned on 16 bytes. */
 	if (fb->pitches[0] & GENMASK(3, 0))
 		return -EINVAL;





