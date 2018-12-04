Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D378C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D20C206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D20C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeLDOYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:24:08 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33387 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726662AbeLDOXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:23:23 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D1F020E1F; Tue,  4 Dec 2018 15:23:19 +0100 (CET)
Received: from localhost.localdomain (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 82CC920E20;
        Tue,  4 Dec 2018 15:22:42 +0100 (CET)
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v3 15/21] drm/sun4i: drv: Allow framebuffer modifiers in mode config
Date:   Tue,  4 Dec 2018 15:22:12 +0100
Message-Id: <20181204142218.16284-16-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the final step to indicate to the core that our driver
supports framebuffer modifiers.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 9e4c375ccc96..93da837194cf 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -97,6 +97,7 @@ static int sun4i_drv_bind(struct device *dev)
 	}
 
 	drm_mode_config_init(drm);
+	drm->mode_config.allow_fb_modifiers = true;
 
 	ret = component_bind_all(drm->dev, drm);
 	if (ret) {
-- 
2.19.2

