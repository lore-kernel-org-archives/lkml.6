Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877C12146D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 12:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388108AbeKOWKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 17:10:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14673 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbeKOWKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 17:10:20 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E5F72BDB63185;
        Thu, 15 Nov 2018 20:01:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Thu, 15 Nov 2018 20:01:14 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "David Airlie" <airlied@linux.ie>,
        Thierry Reding <treding@nvidia.com>,
        Daniel Stone <daniels@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Adam Jackson" <ajax@redhat.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <virtualization@lists.linux-foundation.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/cirrus: Remove set but not used variable 'bo'
Date:   Thu, 15 Nov 2018 12:10:36 +0000
Message-ID: <1542283836-152176-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/cirrus/cirrus_fbdev.c: In function 'cirrusfb_create':
drivers/gpu/drm/cirrus/cirrus_fbdev.c:172:20: warning:
 variable 'bo' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit
f9aa76a85248 ("drm/kms: driver for virtual cirrus under qemu")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 68ab182..4dd499c 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -169,7 +169,6 @@ static int cirrusfb_create(struct drm_fb_helper *helper,
 	struct drm_mode_fb_cmd2 mode_cmd;
 	void *sysram;
 	struct drm_gem_object *gobj = NULL;
-	struct cirrus_bo *bo = NULL;
 	int size, ret;
 
 	mode_cmd.width = sizes->surface_width;
@@ -185,8 +184,6 @@ static int cirrusfb_create(struct drm_fb_helper *helper,
 		return ret;
 	}
 
-	bo = gem_to_cirrus_bo(gobj);
-
 	sysram = vmalloc(size);
 	if (!sysram)
 		return -ENOMEM;





