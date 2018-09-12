Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22777C04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E3206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E3206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeILIH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:07:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeILIH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:07:59 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A7F7D5FDD725;
        Wed, 12 Sep 2018 11:05:38 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Wed, 12 Sep 2018 11:05:28 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, "David Airlie" <airlied@linux.ie>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/fb-helper: Remove set but not used variable 'connector_funcs'
Date:   Wed, 12 Sep 2018 03:15:30 +0000
Message-ID: <1536722130-108819-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/drm_fb_helper.c: In function 'drm_pick_crtcs':
drivers/gpu/drm/drm_fb_helper.c:2373:43: warning:
 variable 'connector_funcs' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 73cf10a..16e3a59 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2370,7 +2370,6 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
 {
 	int c, o;
 	struct drm_connector *connector;
-	const struct drm_connector_helper_funcs *connector_funcs;
 	int my_score, best_score, score;
 	struct drm_fb_helper_crtc **crtcs, *crtc;
 	struct drm_fb_helper_connector *fb_helper_conn;
@@ -2399,8 +2398,6 @@ static int drm_pick_crtcs(struct drm_fb_helper *fb_helper,
 	if (drm_has_preferred_mode(fb_helper_conn, width, height))
 		my_score++;
 
-	connector_funcs = connector->helper_private;
-
 	/*
 	 * select a crtc for this connector and then attempt to configure
 	 * remaining connectors



