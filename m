Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E980C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3714F20851
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 22:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBTWkK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:40:10 -0500
Received: from mail-oln040092069047.outbound.protection.outlook.com ([40.92.69.47]:53600
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfBTWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 17:40:10 -0500
Received: from VE1EUR02FT040.eop-EUR02.prod.protection.outlook.com
 (10.152.12.58) by VE1EUR02HT020.eop-EUR02.prod.protection.outlook.com
 (10.152.13.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Wed, 20 Feb
 2019 22:40:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com (10.152.12.59) by
 VE1EUR02FT040.mail.protection.outlook.com (10.152.13.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Wed, 20 Feb 2019 22:40:06 +0000
Received: from AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3]) by AM3PR03MB0966.eurprd03.prod.outlook.com
 ([fe80::8011:1f4d:3804:e5f3%10]) with mapi id 15.20.1643.014; Wed, 20 Feb
 2019 22:40:06 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
CC:     Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] drm/rockchip: vop: reset scale mode when win is disabled
Thread-Topic: [PATCH] drm/rockchip: vop: reset scale mode when win is disabled
Thread-Index: AQHUyW05H5dNG+/wEE607ybuV0Af9w==
Date:   Wed, 20 Feb 2019 22:40:06 +0000
Message-ID: <AM3PR03MB0966DE3E19BACE07328CD637AC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0027.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::40) To AM3PR03MB0966.eurprd03.prod.outlook.com
 (2a01:111:e400:884c::23)
x-incomingtopheadermarker: OriginalChecksum:07B09172BD2F7D4BC5C1748A13EE5499F8B953BB47035F112553B387E03C06F9;UpperCasedChecksum:F50CF5423A08EAB22D129A083D0148D264ADC4814803F3108621B221D9F69C72;SizeAsReceived:8680;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [UZkNIAOMz8V0gxymtiAWGeKq7clYol4R]
x-microsoft-original-message-id: <20190220223951.18757-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031322404)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT020;
x-ms-traffictypediagnostic: VE1EUR02HT020:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR02HT020;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT020;
x-microsoft-antispam-message-info: kPjagEvzxBJ835bcET2DQSF/32aBd0kY0WXP+qWMBBkFXHrmPT0mNa8JH9sd/qsg
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d57983-ff30-4883-825e-08d697845b99
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 54485d23-c432-40fe-8436-6091d627118c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 22:40:04.4805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NV12 framebuffers produced by the VPU shows distorted on RK3288
after win has been disabled when scaling is active.

This issue can be reproduced using a 1080p modeset by:
- Scale a 1280x720 NV12 framebuffer to 1920x1080 on win0
- Disable win0
- Display a 1920x1080 NV12 framebuffer without scaling on win0
- Output will now show the framebuffer distorted

And by:
- Scale a 1280x720 NV12 framebuffer to 1920x1080
- Change to a 720p modeset (win gets disabled and scaling reset to none)
- Output will now show the framebuffer distorted

Fix this by setting scale mode to none when win is disabled.

Fixes: 4c156c21c794 ("drm/rockchip: vop: support plane scale")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index fb70fb486fbf..cdbb47566cac 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -511,6 +511,18 @@ static void vop_core_clks_disable(struct vop *vop)
 	clk_disable(vop->hclk);
 }
 
+static void vop_win_disable(struct vop *vop, const struct vop_win_data *win)
+{
+	if (win->phy->scl && win->phy->scl->ext) {
+		VOP_SCL_SET_EXT(vop, win, yrgb_hor_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, yrgb_ver_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, cbcr_hor_scl_mode, SCALE_NONE);
+		VOP_SCL_SET_EXT(vop, win, cbcr_ver_scl_mode, SCALE_NONE);
+	}
+
+	VOP_WIN_SET(vop, win, enable, 0);
+}
+
 static int vop_enable(struct drm_crtc *crtc)
 {
 	struct vop *vop = to_vop(crtc);
@@ -556,7 +568,7 @@ static int vop_enable(struct drm_crtc *crtc)
 		struct vop_win *vop_win = &vop->win[i];
 		const struct vop_win_data *win = vop_win->data;
 
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 	}
 	spin_unlock(&vop->reg_lock);
 
@@ -700,7 +712,7 @@ static void vop_plane_atomic_disable(struct drm_plane *plane,
 
 	spin_lock(&vop->reg_lock);
 
-	VOP_WIN_SET(vop, win, enable, 0);
+	vop_win_disable(vop, win);
 
 	spin_unlock(&vop->reg_lock);
 }
@@ -1476,7 +1488,7 @@ static int vop_initial(struct vop *vop)
 		int channel = i * 2 + 1;
 
 		VOP_WIN_SET(vop, win, channel, (channel + 1) << 4 | channel);
-		VOP_WIN_SET(vop, win, enable, 0);
+		vop_win_disable(vop, win);
 		VOP_WIN_SET(vop, win, gate, 1);
 	}
 
-- 
2.17.1

