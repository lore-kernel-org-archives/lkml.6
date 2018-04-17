Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752634AbeDQKQX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:16:23 -0400
Received: from regular1.263xmail.com ([211.150.99.132]:55370 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeDQKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:16:15 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: dri-devel@lists.freedesktop.org
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <400ff531941e5cf384185bb40552a56a>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: Sandy Huang <hjc@rock-chips.com>
To: dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        David Airlie <airlied@linux.ie>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: vop: fixup linebuffer mode calc error
Date: Tue, 17 Apr 2018 18:15:07 +0800
Message-Id: <1523960108-190541-1-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When video width is bigger than 3840 the linebuffer mode
should be LB_YUV_3840X5.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 56bbd2e..3e7501b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -332,7 +332,7 @@ static inline int scl_vop_cal_lb_mode(int width, bool is_yuv)
 
 	if (width > 2560)
 		lb_mode = LB_RGB_3840X2;
-	else if (width > 1920)
+	else if (!is_yuv && width > 1920)
 		lb_mode = LB_RGB_2560X4;
 	else if (!is_yuv)
 		lb_mode = LB_RGB_1920X5;
-- 
2.7.4
