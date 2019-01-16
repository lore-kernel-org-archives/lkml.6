Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25558C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDDB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tmq3vfUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404148AbfAPLtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:49:47 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:57311
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732702AbfAPLss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSi3wrXPVHqZqyMqa0XXW3A71Qkr3M9ZXAyYl+lXvrI=;
 b=tmq3vfUUSeTjLyzTxiST44VWKgxuNaO6oapES8hM4FY95Uy+HgLueeUYvquU4mvztBWkHOSw7Cptt0F3rjx2lV3qtj8z5vHGp1hRWe3Y/PuC3fk/wlRbHoCbi1nkb3VneD0u8CJ/cp+eV5K3P0LF+4u8ifyTlJeMtLbh/jlw4Ao=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB6101.eurprd04.prod.outlook.com (20.179.5.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Wed, 16 Jan 2019 11:48:38 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 11:48:38 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>
CC:     Robert Chiras <robert.chiras@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Anson Huang <anson.huang@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] drm/mxsfb: Update mxsfb to support a bridge
Thread-Topic: [PATCH 01/11] drm/mxsfb: Update mxsfb to support a bridge
Thread-Index: AQHUrZFrWbVkhF4Ds0mpFsy8wq0LDg==
Date:   Wed, 16 Jan 2019 11:48:38 +0000
Message-ID: <1547639306-19151-2-git-send-email-robert.chiras@nxp.com>
References: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547639306-19151-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0018.eurprd05.prod.outlook.com
 (2603:10a6:203:91::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB6101;6:j6wCWG4IFBIK/atFFWWxCkFCsoz+Apib1E6OoAcME7AqN3d2PcsAmZqBSTkjsC86Xod2RkPCG9bjC9c88Q66wBQQvOfNZ1rG5bhK1TCkSFQF62c60gL+okcrBnWp/n++mP8IJkijzLaBCm/12DS3gz7SjIh4IB0x2hcEfHwqXpyPqqhc5JZ71x6QO8n1YhDyce1MJzihRmlGQJdFUt3pz35Rx5MlSwP9IWFGAVRIeR1687k98Zi7v1fw3WggyHCJrXKVDdM8QwVaMj0XVENrAIy21OUN8lDEqbNYt/a/0Ee2HYrttBR26v0/sIOFAcjiG6cwU/2DbVmZb7b/Eu8/g7lCDdt9W4wFzH3YwoeL9WubcnDMmMYzCqVeTBVnYmUzEM8YkIJTO4khJhqa4zmZ2Z38ePBgx04Le0CANLzPo72IOPh9acE/avj6pBgh4E0kMwGXRlKwB+hC5BlauQqTWg==;5:0RbCnDSsu2t6/YjowLPgZkaXqUd5cyon58F84nwSBufyQUnoMiCw7GKAnzzEdBmw7TMylqwCjh9vN3yMcGD0ftGdcViITV7ySJFtORqztcijQUYhqIJEPJX0fMDcgS0HsHuaJ+4SgpIYo2RJ24nsQDplSdgaUPXWxjeQUH3rqXwQ9XZ5R+idOPlSIyKcuydbBg9M7tZ5ETiHkCQKiS6xGA==;7:QaVC+mikny2e3DTmiia77UuSs+gyX597HVhg4QyZ7CX8ClUA3aiKCWI5rDmNeExQs2c5AtTdstczmfk46N/w8eh7aPZHnYFLvTIMF+ReO2Bu9gcYvmu/5o8WIxpVk3pRR4hkhJ39TTNhN//0ofwdsA==
x-ms-office365-filtering-correlation-id: 6ed244eb-e190-49d4-21ef-08d67ba88deb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB6101;
x-ms-traffictypediagnostic: AM6PR04MB6101:
x-microsoft-antispam-prvs: <AM6PR04MB6101187A68AD5CFEEF733401E3820@AM6PR04MB6101.eurprd04.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(316002)(81156014)(110136005)(102836004)(81166006)(476003)(26005)(2616005)(186003)(8676002)(7736002)(66066001)(3846002)(50226002)(105586002)(305945005)(6486002)(8936002)(99286004)(54906003)(6436002)(106356001)(6116002)(86362001)(2906002)(44832011)(14454004)(478600001)(486006)(30864003)(71200400001)(68736007)(97736004)(5660300001)(53936002)(76176011)(36756003)(5024004)(256004)(446003)(14444005)(11346002)(25786009)(386003)(6506007)(6512007)(52116002)(4326008)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6101;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zl3bYlFxGYjhk7BoBQnOxgaeqW2zjYFe3JqrDy+TIwR1wXnjJtI66zES0ISsRVwIlvWO8DpJ8x6gtWPqzhbFkQzAjRIB6hfj9BV5y1q553d7XaGaLNAp1Y5FB2RY+wbN792xNq/vofgc2UQ5TXTuTGZhsEseJt6P3+K6/F0KqO9LI5RzonLeq4C68vLAV2+AOmziUFVzRYfuNKzg47UkfAGA1NNAQAytxYl0lXEG1uBlSBeGRdmH/MJTvICbxreEqL3UJUNaQsGwIt+qCXIy9f+BrR6g6yRetABnhOmdvYv0O/cSD5AolENoiAFhwBQ/Wym6LPPMruCwDb657/xG/+u5wL7UCvMW0M/q/CcyHQ9k5X02Jdm2dQxMpPts8ViacxUJPi1t0Ruhs69AOYkppbuhCXSPlFYuH89vxpLLPKU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed244eb-e190-49d4-21ef-08d67ba88deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 11:48:37.9108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the MXSFB DRM driver only supports a panel. But, its output
display signal can also be redirected to another encoder, like a DSI
controller. In this case, that DSI controller may act like a drm_bridge.
In order support this use-case too, this patch adds support for
drm_bridge in mxsfb.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 46 ++++++++++++++++++++++++++++++++++=
+---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 46 +++++++++++++++++++++++++++++++++-=
----
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |  4 +++-
 drivers/gpu/drm/mxsfb/mxsfb_out.c  | 26 +++++++++++----------
 drivers/gpu/drm/mxsfb/mxsfb_regs.h | 15 +++++++++++++
 5 files changed, 116 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index 24b1f0c..3210be9 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -101,8 +101,11 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_private=
 *mxsfb)
=20
 	reg =3D readl(mxsfb->base + LCDC_CTRL);
=20
-	if (mxsfb->connector.display_info.num_bus_formats)
-		bus_format =3D mxsfb->connector.display_info.bus_formats[0];
+	if (mxsfb->connector->display_info.num_bus_formats)
+		bus_format =3D mxsfb->connector->display_info.bus_formats[0];
+
+	DRM_DEV_DEBUG_DRIVER(drm->dev,
+		"Using bus_format: 0x%08X\n", bus_format);
=20
 	reg &=3D ~CTRL_BUS_WIDTH_MASK;
 	switch (bus_format) {
@@ -130,6 +133,9 @@ static void mxsfb_enable_controller(struct mxsfb_drm_pr=
ivate *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
=20
+	writel(CTRL2_OUTSTANDING_REQS__REQ_16,
+		mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
=20
@@ -139,12 +145,15 @@ static void mxsfb_enable_controller(struct mxsfb_drm_=
private *mxsfb)
 	writel(reg, mxsfb->base + LCDC_VDCTRL4);
=20
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_SET);
+	writel(CTRL1_RECOVERY_ON_UNDERFLOW, mxsfb->base + LCDC_CTRL1 + REG_SET);
 }
=20
 static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
 {
 	u32 reg;
=20
+	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
+
 	/*
 	 * Even if we disable the controller here, it will still continue
 	 * until its FIFOs are running out of data
@@ -210,8 +219,9 @@ static dma_addr_t mxsfb_get_fb_paddr(struct mxsfb_drm_p=
rivate *mxsfb)
=20
 static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
 {
+	struct drm_device *drm =3D mxsfb->pipe.crtc.dev;
 	struct drm_display_mode *m =3D &mxsfb->pipe.crtc.state->adjusted_mode;
-	const u32 bus_flags =3D mxsfb->connector.display_info.bus_flags;
+	const u32 bus_flags =3D mxsfb->connector->display_info.bus_flags;
 	u32 vdctrl0, vsync_pulse_len, hsync_pulse_len;
 	int err;
=20
@@ -235,6 +245,13 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_=
private *mxsfb)
=20
 	clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
=20
+	DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
+		m->crtc_clock, (int)(clk_get_rate(mxsfb->clk) / 1000));
+	DRM_DEV_DEBUG_DRIVER(drm->dev,
+		"Connector bus_flags: 0x%08X\n", bus_flags);
+	DRM_DEV_DEBUG_DRIVER(drm->dev,
+		"Mode flags: 0x%08X\n", m->flags);
+
 	writel(TRANSFER_COUNT_SET_VCOUNT(m->crtc_vdisplay) |
 	       TRANSFER_COUNT_SET_HCOUNT(m->crtc_hdisplay),
 	       mxsfb->base + mxsfb->devdata->transfer_count);
@@ -287,6 +304,7 @@ void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb)
 	dma_addr_t paddr;
=20
 	mxsfb_enable_axi_clk(mxsfb);
+	writel(0, mxsfb->base + LCDC_CTRL);
 	mxsfb_crtc_mode_set_nofb(mxsfb);
=20
 	/* Write cur_buf as well to avoid an initial corrupt frame */
@@ -310,6 +328,8 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_private=
 *mxsfb,
 {
 	struct drm_simple_display_pipe *pipe =3D &mxsfb->pipe;
 	struct drm_crtc *crtc =3D &pipe->crtc;
+	struct drm_framebuffer *fb =3D pipe->plane.state->fb;
+	struct drm_framebuffer *old_fb =3D old_state->fb;
 	struct drm_pending_vblank_event *event;
 	dma_addr_t paddr;
=20
@@ -332,4 +352,24 @@ void mxsfb_plane_atomic_update(struct mxsfb_drm_privat=
e *mxsfb,
 		writel(paddr, mxsfb->base + mxsfb->devdata->next_buf);
 		mxsfb_disable_axi_clk(mxsfb);
 	}
+
+	if (!fb || !old_fb)
+		return;
+
+	/*
+	 * TODO: Currently, we only support pixel format change, but we need
+	 * also to care about size changes too
+	 */
+	if (old_fb->format->format !=3D fb->format->format) {
+		struct drm_format_name_buf old_fmt_buf;
+		struct drm_format_name_buf new_fmt_buf;
+
+		DRM_DEV_DEBUG_DRIVER(crtc->dev->dev,
+				"Switching pixel format: %s -> %s\n",
+				drm_get_format_name(old_fb->format->format,
+						    &old_fmt_buf),
+				drm_get_format_name(fb->format->format,
+						    &new_fmt_buf));
+		mxsfb_set_pixel_fmt(mxsfb, true);
+	}
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index 88ba003..9a73564 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -106,9 +106,25 @@ static void mxsfb_pipe_enable(struct drm_simple_displa=
y_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
+	struct drm_connector *connector;
 	struct mxsfb_drm_private *mxsfb =3D drm_pipe_to_mxsfb_drm_private(pipe);
 	struct drm_device *drm =3D pipe->plane.dev;
=20
+	if (!mxsfb->connector) {
+		list_for_each_entry(connector,
+				    &drm->mode_config.connector_list,
+				    head)
+			if (connector->encoder =3D=3D &(mxsfb->pipe.encoder)) {
+				mxsfb->connector =3D connector;
+				break;
+			}
+	}
+
+	if (!mxsfb->connector) {
+		dev_warn(drm->dev, "No connector attached, using default\n");
+		mxsfb->connector =3D &mxsfb->panel_connector;
+	}
+
 	pm_runtime_get_sync(drm->dev);
 	drm_panel_prepare(mxsfb->panel);
 	mxsfb_crtc_enable(mxsfb);
@@ -134,6 +150,9 @@ static void mxsfb_pipe_disable(struct drm_simple_displa=
y_pipe *pipe)
 		drm_crtc_send_vblank_event(crtc, event);
 	}
 	spin_unlock_irq(&drm->event_lock);
+
+	if (mxsfb->connector !=3D &mxsfb->panel_connector)
+		mxsfb->connector =3D NULL;
 }
=20
 static void mxsfb_pipe_update(struct drm_simple_display_pipe *pipe,
@@ -231,16 +250,33 @@ static int mxsfb_load(struct drm_device *drm, unsigne=
d long flags)
=20
 	ret =3D drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
 			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
-			&mxsfb->connector);
+			mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
 		goto err_vblank;
 	}
=20
-	ret =3D drm_panel_attach(mxsfb->panel, &mxsfb->connector);
-	if (ret) {
-		dev_err(drm->dev, "Cannot connect panel\n");
-		goto err_vblank;
+	/*
+	 * Attach panel only if there is one.
+	 * If there is no panel attach, it must be a bridge. In this case, we
+	 * need a reference to its connector for a proper initialization.
+	 * We will do this check in pipe->enable(), since the connector won't
+	 * be attached to an encoder until then.
+	 */
+
+	if (mxsfb->panel) {
+		ret =3D drm_panel_attach(mxsfb->panel, mxsfb->connector);
+		if (ret) {
+			dev_err(drm->dev, "Cannot connect panel\n");
+			goto err_vblank;
+		}
+	} else if (mxsfb->bridge) {
+		ret =3D drm_simple_display_pipe_attach_bridge(&mxsfb->pipe,
+				mxsfb->bridge);
+		if (ret) {
+			dev_err(drm->dev, "Cannot connect bridge\n");
+			goto err_vblank;
+		}
 	}
=20
 	drm->mode_config.min_width	=3D MXSFB_MIN_XRES;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.h
index 5d0883f..71238ad 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -35,8 +35,10 @@ struct mxsfb_drm_private {
 	struct clk			*clk_disp_axi;
=20
 	struct drm_simple_display_pipe	pipe;
-	struct drm_connector		connector;
+	struct drm_connector		panel_connector;
+	struct drm_connector		*connector;
 	struct drm_panel		*panel;
+	struct drm_bridge		*bridge;
 	struct drm_fbdev_cma		*fbdev;
 };
=20
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_out.c b/drivers/gpu/drm/mxsfb/mxsf=
b_out.c
index e5edf01..ed0d8d3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_out.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_out.c
@@ -30,7 +30,8 @@
 static struct mxsfb_drm_private *
 drm_connector_to_mxsfb_drm_private(struct drm_connector *connector)
 {
-	return container_of(connector, struct mxsfb_drm_private, connector);
+	return container_of(connector, struct mxsfb_drm_private,
+			    panel_connector);
 }
=20
 static int mxsfb_panel_get_modes(struct drm_connector *connector)
@@ -85,22 +86,23 @@ static const struct drm_connector_funcs mxsfb_panel_con=
nector_funcs =3D {
 int mxsfb_create_output(struct drm_device *drm)
 {
 	struct mxsfb_drm_private *mxsfb =3D drm->dev_private;
-	struct drm_panel *panel;
 	int ret;
=20
-	ret =3D drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0, &panel, NULL=
);
+	ret =3D drm_of_find_panel_or_bridge(drm->dev->of_node, 0, 0,
+					  &mxsfb->panel, &mxsfb->bridge);
 	if (ret)
 		return ret;
=20
-	mxsfb->connector.dpms =3D DRM_MODE_DPMS_OFF;
-	mxsfb->connector.polled =3D 0;
-	drm_connector_helper_add(&mxsfb->connector,
-			&mxsfb_panel_connector_helper_funcs);
-	ret =3D drm_connector_init(drm, &mxsfb->connector,
-				 &mxsfb_panel_connector_funcs,
-				 DRM_MODE_CONNECTOR_Unknown);
-	if (!ret)
-		mxsfb->panel =3D panel;
+	if (mxsfb->panel) {
+		mxsfb->connector =3D &mxsfb->panel_connector;
+		mxsfb->connector->dpms =3D DRM_MODE_DPMS_OFF;
+		mxsfb->connector->polled =3D 0;
+		drm_connector_helper_add(mxsfb->connector,
+				&mxsfb_panel_connector_helper_funcs);
+		ret =3D drm_connector_init(drm, mxsfb->connector,
+					 &mxsfb_panel_connector_funcs,
+					 DRM_MODE_CONNECTOR_Unknown);
+	}
=20
 	return ret;
 }
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxs=
fb_regs.h
index 66a6ba9..c5b5e40 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -22,19 +22,31 @@
=20
 #define LCDC_CTRL			0x00
 #define LCDC_CTRL1			0x10
+#define LCDC_V4_CTRL2			0x20
 #define LCDC_V3_TRANSFER_COUNT		0x20
 #define LCDC_V4_TRANSFER_COUNT		0x30
 #define LCDC_V4_CUR_BUF			0x40
 #define LCDC_V4_NEXT_BUF		0x50
 #define LCDC_V3_CUR_BUF			0x30
 #define LCDC_V3_NEXT_BUF		0x40
+#define LCDC_TIMING			0x60
 #define LCDC_VDCTRL0			0x70
 #define LCDC_VDCTRL1			0x80
 #define LCDC_VDCTRL2			0x90
 #define LCDC_VDCTRL3			0xa0
 #define LCDC_VDCTRL4			0xb0
+#define LCDC_DVICTRL0			0xc0
+#define LCDC_DVICTRL1			0xd0
+#define LCDC_DVICTRL2			0xe0
+#define LCDC_DVICTRL3			0xf0
+#define LCDC_DVICTRL4			0x100
+#define LCDC_V4_DATA			0x180
+#define LCDC_V3_DATA			0x1b0
 #define LCDC_V4_DEBUG0			0x1d0
 #define LCDC_V3_DEBUG0			0x1f0
+#define LCDC_AS_CTRL			0x210
+#define LCDC_AS_BUF			0x220
+#define LCDC_AS_NEXT_BUF		0x230
=20
 #define CTRL_SFTRST			(1 << 31)
 #define CTRL_CLKGATE			(1 << 30)
@@ -53,12 +65,15 @@
 #define CTRL_DF24			(1 << 1)
 #define CTRL_RUN			(1 << 0)
=20
+#define CTRL1_RECOVERY_ON_UNDERFLOW		(1 << 24)
 #define CTRL1_FIFO_CLEAR		(1 << 21)
 #define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
 #define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
 #define CTRL1_CUR_FRAME_DONE_IRQ_EN	(1 << 13)
 #define CTRL1_CUR_FRAME_DONE_IRQ	(1 << 9)
=20
+#define CTRL2_OUTSTANDING_REQS__REQ_16		(4 << 21)
+
 #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
 #define TRANSFER_COUNT_SET_HCOUNT(x)	((x) & 0xffff)
--=20
2.7.4

