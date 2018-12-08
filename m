Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75BEC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DF42082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 08:28:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DF42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLHI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 03:28:29 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbeLHI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 03:28:28 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0BA77E99055D9;
        Sat,  8 Dec 2018 16:28:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Sat, 8 Dec 2018 16:28:16 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        "Sam Bobroff" <sbobroff@linux.ibm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/ast: Remove set but not used variable 'bo'
Date:   Sat, 8 Dec 2018 08:36:25 +0000
Message-ID: <1544258185-50430-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/ast/ast_fb.c: In function 'astfb_create':
drivers/gpu/drm/ast/ast_fb.c:194:17: warning:
 variable 'bo' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit 312fec1405dd ("drm: Initial KMS
driver for AST (ASpeed Technologies) 2000 series (v2)")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/ast/ast_fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_fb.c b/drivers/gpu/drm/ast/ast_fb.c
index de26df0..c2e4136 100644
--- a/drivers/gpu/drm/ast/ast_fb.c
+++ b/drivers/gpu/drm/ast/ast_fb.c
@@ -191,7 +191,6 @@ static int astfb_create(struct drm_fb_helper *helper,
 	int size, ret;
 	void *sysram;
 	struct drm_gem_object *gobj = NULL;
-	struct ast_bo *bo = NULL;
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
 	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7)/8);
@@ -206,7 +205,6 @@ static int astfb_create(struct drm_fb_helper *helper,
 		DRM_ERROR("failed to create fbcon backing object %d\n", ret);
 		return ret;
 	}
-	bo = gem_to_ast_bo(gobj);
 
 	sysram = vmalloc(size);
 	if (!sysram)



