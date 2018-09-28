Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019ECC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC6621748
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 10:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC6621748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeI1Qxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 12:53:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729093AbeI1Qxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 12:53:51 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04DD3D20E4287;
        Fri, 28 Sep 2018 18:30:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Fri, 28 Sep 2018 18:30:35 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/stm: ltdc: remove set but not used variable 'src_h'
Date:   Fri, 28 Sep 2018 10:39:40 +0000
Message-ID: <1538131180-34108-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/stm/ltdc.c: In function 'ltdc_plane_atomic_check':
drivers/gpu/drm/stm/ltdc.c:694:13: warning:
 variable 'src_y' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
             ^
             ^
drivers/gpu/drm/stm/ltdc.c:694:6: warning:
 variable 'src_x' set but not used [-Wunused-but-set-variable]
  u32 src_x, src_y, src_w, src_h;
      ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 61dd661..a91e041 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -691,7 +691,7 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 				   struct drm_plane_state *state)
 {
 	struct drm_framebuffer *fb = state->fb;
-	u32 src_x, src_y, src_w, src_h;
+	u32 src_w, src_h;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -699,8 +699,6 @@ static int ltdc_plane_atomic_check(struct drm_plane *plane,
 		return 0;
 
 	/* convert src_ from 16:16 format */
-	src_x = state->src_x >> 16;
-	src_y = state->src_y >> 16;
 	src_w = state->src_w >> 16;
 	src_h = state->src_h >> 16;
 



