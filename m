Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C55EC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDE52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BDE52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbeIKQuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:50:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726563AbeIKQt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:49:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C7627DC57640;
        Tue, 11 Sep 2018 19:50:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.399.0; Tue, 11 Sep 2018 19:50:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        David Airlie <airlied@linux.ie>,
        "Andrew F. Davis" <afd@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] drm/omap: remove set but not used variable 'frame_height'
Date:   Tue, 11 Sep 2018 12:00:53 +0000
Message-ID: <1536667253-5792-1-git-send-email-yuehaibing@huawei.com>
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

drivers/gpu/drm/omapdrm/dss/dispc.c: In function 'dispc_ovl_setup_common':
drivers/gpu/drm/omapdrm/dss/dispc.c:2627:19: warning:
 variable 'frame_height' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/omapdrm/dss/dispc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index e61a959..7c23f23 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -2624,7 +2624,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 	unsigned int offset0, offset1;
 	s32 row_inc;
 	s32 pix_inc;
-	u16 frame_width, frame_height;
+	u16 frame_width;
 	unsigned int field_offset = 0;
 	u16 in_height = height;
 	u16 in_width = width;
@@ -2714,13 +2714,10 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
 	row_inc = 0;
 	pix_inc = 0;
 
-	if (plane == OMAP_DSS_WB) {
+	if (plane == OMAP_DSS_WB)
 		frame_width = out_width;
-		frame_height = out_height;
-	} else {
+	else
 		frame_width = in_width;
-		frame_height = height;
-	}
 
 	calc_offset(screen_width, frame_width,
 			fourcc, fieldmode, field_offset,



