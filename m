Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C8420859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLglQeCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfAIOOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:14:34 -0500
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:52304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731154AbfAIONy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTxiNN4K75P0UgFjFXwQjoXBW78lkays8VkdIl6QiXU=;
 b=BLglQeCY54yvJ7Vk++KbCkCO1IwsxJ22Z4M+qTBGvpvYzN4YHxiUSme7eeyLltFlAnQiKA1/KTAsjSZaSutYltIj0OE6DBKb/fQesACC+i43fCUcNjCuCKDoIV48KsQN6C04zKq9PSnuhKQUgJdfRlGfW7ixiwakDZpSMzkrBjI=
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com (52.135.161.10) by
 AM6PR04MB5157.eurprd04.prod.outlook.com (20.177.34.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 14:13:43 +0000
Received: from AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9]) by AM6PR04MB4007.eurprd04.prod.outlook.com
 ([fe80::65e5:2a3b:b9a8:3cd9%5]) with mapi id 15.20.1516.010; Wed, 9 Jan 2019
 14:13:43 +0000
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
Subject: [PATCH 04/10] drm/mxsfb: Update mxsfb with additional pixel formats
Thread-Topic: [PATCH 04/10] drm/mxsfb: Update mxsfb with additional pixel
 formats
Thread-Index: AQHUqCWHiZxUaxPuCEmEAD96l6mvlQ==
Date:   Wed, 9 Jan 2019 14:13:43 +0000
Message-ID: <1547043209-8283-5-git-send-email-robert.chiras@nxp.com>
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0015.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::28) To AM6PR04MB4007.eurprd04.prod.outlook.com
 (2603:10a6:209:40::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5157;6:+G3yQveP2sOe7p/7955Z8GPxckY51hCQr/QOAwHUqW4P+sOmCoH8qDv0pxdOZpsMtEl+Iro74hDdpaFKyte7ZMfkm+7gt86gmop+yLBtbIIqjppD0bJ/adFO6et760wLrEQQja8G3dmC8skiuvVEAyqv9eWMqZXpNLaJK2WRaMMuRkKREoTk2KCF5e3R9vSOQgjEsIjD5ZTgep1wbZWUnHF7D3MiDchyzVAL7njo8IBbadenMg1Pltmleq52hVgv2wyjWRjfBZiuBQkzGD+ff6X9SQtDUX82rhxtJzZn997BTLWGJgUDdQlzMWz3tV+yDrevwL7No6qbdtd+fpFQkqxEZyP/G6tOlrLYhTPEW1iGF/5xNbTh5fwPsuCT7GBZYyALI9pJXvq4Z+8wdTIQu35dPaFHIs0B/HZUq5BTo6d85lHlF+mpAO+dTM9Q2y0eeB1EDWSzNHh+LPtsi1ZHMQ==;5:p+cojcgCWZRG45R7aZRdXlFV5KgSSjGqXrkC77iqtNeAJ+yaTS07QMxiCz89yIGD0jbmT7fDSRx0N+euuiJm6gt2w/jnAwrPDhU5rrPpShclc8k0jTwwkWkN+vQwX8/U86QUSzfXmVGo6fdUfj59uwZY+aeNUKxyXHFfgQGgAXWIMZf5JyZV0F0k9EatBtmuNm0LXohgE26SniDIDAdTGQ==;7:EjEWqV5BoX7EpQAa3SfIKotXwBcXYDc8FI5Jiqk5Mkx+ELxfExM2GCQcc1MGJnIBLOApl9pXmdsDG1WCsyPapbTnPnXBG0ZfskbKIbCvD1ucT2EvIePv2TrVfkGM7tkGRZjzTsxdQcXXDtxW1la0CA==
x-ms-office365-filtering-correlation-id: 302a07d9-d572-4787-feb6-08d6763ca97c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5157;
x-ms-traffictypediagnostic: AM6PR04MB5157:
x-microsoft-antispam-prvs: <AM6PR04MB5157A6011B097C6771E13843E38B0@AM6PR04MB5157.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5157;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5157;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(136003)(376002)(199004)(189003)(50226002)(99286004)(11346002)(110136005)(2616005)(575784001)(256004)(316002)(86362001)(14444005)(54906003)(305945005)(7736002)(8676002)(71190400001)(6486002)(71200400001)(446003)(4744004)(8936002)(105586002)(97736004)(81166006)(81156014)(36756003)(106356001)(476003)(25786009)(486006)(6436002)(186003)(3846002)(6116002)(478600001)(68736007)(53936002)(102836004)(6512007)(14454004)(5660300001)(44832011)(53946003)(76176011)(52116002)(386003)(26005)(15650500001)(6506007)(2906002)(4326008)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5157;H:AM6PR04MB4007.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9ysWAW6Gs3bev9rXDPXPVGYTwU10VsDp67ipQEI0rYGj+6QY4I1u90bkuD01p2RrZqhbCH7ny0ocO04fnE7LtBCLNiflqD6QTLldGs6yi+erbOZKjfLIlj2ZUBDjO1Ucgx05IffLPrPu90EtEct2U6y63QccgbSdMtrQ4CwcVbvWif8DVWhQ3xUxBwD403emr0ASjvLydb7A7vkeulJDPt7Ep6BB/8cRVA2VRxtUrchOOK3Cx+LRUOiNC+/KDsvdzdEHqFsX5xxI/8rCVNF0uxEV1MwKJ3UB0c47j4ryT3keLhTWNLiHJ75XSsNYyqTS
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302a07d9-d572-4787-feb6-08d6763ca97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 14:13:42.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since version 4 of eLCDIF, there are some registers that can do
transformations on the input data, like re-arranging the pixel
components. By doing that, we can support more pixel formats.
This patch adds support for X/ABGR and RGBX/A. Although, the local alpha
is not supported by eLCDIF, the alpha pixel formats were added to the
supported pixel formats but it will be ignored. This was necessary since
there are systems (like Android) that requires such pixel formats.

Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 108 ++++++++++++++++++++++++++++-----=
----
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  |  27 +++++++---
 drivers/gpu/drm/mxsfb/mxsfb_drv.h  |   4 +-
 drivers/gpu/drm/mxsfb/mxsfb_regs.h | 100 ++++++++++++++++++++-------------=
-
 4 files changed, 169 insertions(+), 70 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxs=
fb_crtc.c
index f0648ce..6aa8804 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
@@ -48,15 +48,35 @@ static u32 set_hsync_pulse_width(struct mxsfb_drm_priva=
te *mxsfb, u32 val)
 		mxsfb->devdata->hs_wdth_shift;
 }
=20
+/*  Print Four-character-code (FOURCC) */
+static char *fourcc_to_str(u32 fmt)
+{
+	/* Use 10 chars so we can simultaneously print two codes */
+	static char code[10], *c =3D &code[0];
+
+	if (c =3D=3D &code[10])
+		c =3D &code[0];
+
+	*(c++) =3D (unsigned char)(fmt & 0xff);
+	*(c++) =3D (unsigned char)((fmt >> 8) & 0xff);
+	*(c++) =3D (unsigned char)((fmt >> 16) & 0xff);
+	*(c++) =3D (unsigned char)((fmt >> 24) & 0xff);
+	*(c++) =3D '\0';
+
+	return (c - 5);
+}
+
 /* Setup the MXSFB registers for decoding the pixels out of the framebuffe=
r */
-static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb)
+static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private *mxsfb, bool updat=
e)
 {
 	struct drm_crtc *crtc =3D &mxsfb->pipe.crtc;
 	struct drm_device *drm =3D crtc->dev;
 	const u32 format =3D crtc->primary->state->fb->format->format;
-	u32 ctrl, ctrl1;
+	u32 ctrl =3D 0, ctrl1 =3D 0;
+	bool bgr_format =3D true;
=20
-	ctrl =3D CTRL_BYPASS_COUNT | CTRL_MASTER;
+	if (!update)
+		ctrl =3D CTRL_BYPASS_COUNT | CTRL_MASTER;
=20
 	/*
 	 * WARNING: The bus width, CTRL_SET_BUS_WIDTH(), is configured to
@@ -65,31 +85,69 @@ static int mxsfb_set_pixel_fmt(struct mxsfb_drm_private=
 *mxsfb)
 	 * to arbitrary value. This limitation should not pose an issue.
 	 */
=20
-	/* CTRL1 contains IRQ config and status bits, preserve those. */
-	ctrl1 =3D readl(mxsfb->base + LCDC_CTRL1);
-	ctrl1 &=3D CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
+	if (!update) {
+		/* CTRL1 contains IRQ config and status bits, preserve those. */
+		ctrl1 =3D readl(mxsfb->base + LCDC_CTRL1);
+		ctrl1 &=3D CTRL1_CUR_FRAME_DONE_IRQ_EN | CTRL1_CUR_FRAME_DONE_IRQ;
+	}
+
+	DRM_DEV_DEBUG_DRIVER(drm->dev, "Setting up %s mode\n",
+		fourcc_to_str(format));
+
+	/* Do some clean-up that we might have from a previous mode */
+	ctrl &=3D ~CTRL_SHIFT_DIR(1);
+	ctrl &=3D ~CTRL_SHIFT_NUM(0x3f);
+	if (mxsfb->devdata->ipversion >=3D 4)
+		writel(CTRL2_ODD_LINE_PATTERN(0x7) |
+		       CTRL2_EVEN_LINE_PATTERN(0x7),
+		       mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
=20
 	switch (format) {
 	case DRM_FORMAT_RGB565:
-		dev_dbg(drm->dev, "Setting up RGB565 mode\n");
 		ctrl |=3D CTRL_SET_WORD_LENGTH(0);
 		ctrl1 |=3D CTRL1_SET_BYTE_PACKAGING(0xf);
 		break;
+	case DRM_FORMAT_RGBX8888:
+	case DRM_FORMAT_RGBA8888:
+		/* RGBX - > 0RGB */
+		ctrl |=3D CTRL_SHIFT_DIR(1);
+		ctrl |=3D CTRL_SHIFT_NUM(8);
+		bgr_format =3D false;
+		/* Fall through */
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ABGR8888:
+		if (bgr_format) {
+			if (mxsfb->devdata->ipversion < 4)
+				goto err;
+			writel(CTRL2_ODD_LINE_PATTERN(0x5) |
+			       CTRL2_EVEN_LINE_PATTERN(0x5),
+			       mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+		}
+		/* Fall through */
 	case DRM_FORMAT_XRGB8888:
-		dev_dbg(drm->dev, "Setting up XRGB8888 mode\n");
+	case DRM_FORMAT_ARGB8888:
 		ctrl |=3D CTRL_SET_WORD_LENGTH(3);
 		/* Do not use packed pixels =3D one pixel per word instead. */
 		ctrl1 |=3D CTRL1_SET_BYTE_PACKAGING(0x7);
 		break;
 	default:
-		dev_err(drm->dev, "Unhandled pixel format %08x\n", format);
-		return -EINVAL;
+		goto err;
 	}
=20
-	writel(ctrl1, mxsfb->base + LCDC_CTRL1);
-	writel(ctrl, mxsfb->base + LCDC_CTRL);
+	if (update) {
+		writel(ctrl, mxsfb->base + LCDC_CTRL + REG_SET);
+		writel(ctrl1, mxsfb->base + LCDC_CTRL1 + REG_SET);
+	} else {
+		writel(ctrl, mxsfb->base + LCDC_CTRL);
+		writel(ctrl1, mxsfb->base + LCDC_CTRL1);
+	}
=20
 	return 0;
+
+err:
+	DRM_DEV_ERROR(drm->dev, "Unhandled pixel format: %s\n",
+		      fourcc_to_str(format));
+	return -EINVAL;
 }
=20
 static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *mxsfb)
@@ -97,9 +155,7 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_private *=
mxsfb)
 	struct drm_crtc *crtc =3D &mxsfb->pipe.crtc;
 	struct drm_device *drm =3D crtc->dev;
 	u32 bus_format =3D MEDIA_BUS_FMT_RGB888_1X24;
-	u32 reg;
-
-	reg =3D readl(mxsfb->base + LCDC_CTRL);
+	u32 reg =3D 0;
=20
 	if (mxsfb->connector->display_info.num_bus_formats)
 		bus_format =3D mxsfb->connector->display_info.bus_formats[0];
@@ -107,22 +163,21 @@ static void mxsfb_set_bus_fmt(struct mxsfb_drm_privat=
e *mxsfb)
 	DRM_DEV_DEBUG_DRIVER(drm->dev,
 		"Using bus_format: 0x%08X\n", bus_format);
=20
-	reg &=3D ~CTRL_BUS_WIDTH_MASK;
 	switch (bus_format) {
 	case MEDIA_BUS_FMT_RGB565_1X16:
-		reg |=3D CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
+		reg =3D CTRL_SET_BUS_WIDTH(STMLCDIF_16BIT);
 		break;
 	case MEDIA_BUS_FMT_RGB666_1X18:
-		reg |=3D CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
+		reg =3D CTRL_SET_BUS_WIDTH(STMLCDIF_18BIT);
 		break;
 	case MEDIA_BUS_FMT_RGB888_1X24:
-		reg |=3D CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
+		reg =3D CTRL_SET_BUS_WIDTH(STMLCDIF_24BIT);
 		break;
 	default:
 		dev_err(drm->dev, "Unknown media bus format %d\n", bus_format);
 		break;
 	}
-	writel(reg, mxsfb->base + LCDC_CTRL);
+	writel(reg, mxsfb->base + LCDC_CTRL + REG_SET);
 }
=20
 static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
@@ -133,8 +188,9 @@ static void mxsfb_enable_controller(struct mxsfb_drm_pr=
ivate *mxsfb)
 		clk_prepare_enable(mxsfb->clk_disp_axi);
 	clk_prepare_enable(mxsfb->clk);
=20
-	writel(CTRL2_OUTSTANDING_REQS__REQ_16,
-		mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
+	if (mxsfb->devdata->ipversion >=3D 4)
+		writel(CTRL2_OUTSTANDING_REQS(REQ_16),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
=20
 	/* If it was disabled, re-enable the mode again */
 	writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
@@ -152,6 +208,10 @@ static void mxsfb_disable_controller(struct mxsfb_drm_=
private *mxsfb)
 {
 	u32 reg;
=20
+	if (mxsfb->devdata->ipversion >=3D 4)
+		writel(CTRL2_OUTSTANDING_REQS(0x7),
+			mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
+
 	writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
=20
 	/*
@@ -239,7 +299,7 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_p=
rivate *mxsfb)
 	/* Clear the FIFOs */
 	writel(CTRL1_FIFO_CLEAR, mxsfb->base + LCDC_CTRL1 + REG_SET);
=20
-	err =3D mxsfb_set_pixel_fmt(mxsfb);
+	err =3D mxsfb_set_pixel_fmt(mxsfb, false);
 	if (err)
 		return;
=20
@@ -322,7 +382,7 @@ void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb=
)
 }
=20
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
-			       struct drm_plane_state *state)
+			       struct drm_plane_state *old_state)
 {
 	struct drm_simple_display_pipe *pipe =3D &mxsfb->pipe;
 	struct drm_crtc *crtc =3D &pipe->crtc;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.c
index c0b6198..76230d7 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -48,6 +48,22 @@ enum mxsfb_devtype {
 	MXSFB_V4,
 };
=20
+/*
+ * When adding new formats, make sure to update the num_formats from
+ * mxsfb_devdata below.
+ */
+static const uint32_t mxsfb_formats[] =3D {
+	/* MXSFB_V3 */
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_RGB565,
+	/* MXSFB_V4 */
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_RGBX8888,
+	DRM_FORMAT_RGBA8888,
+};
+
 static const struct mxsfb_devdata mxsfb_devdata[] =3D {
 	[MXSFB_V3] =3D {
 		.transfer_count	=3D LCDC_V3_TRANSFER_COUNT,
@@ -57,6 +73,8 @@ static const struct mxsfb_devdata mxsfb_devdata[] =3D {
 		.hs_wdth_mask	=3D 0xff,
 		.hs_wdth_shift	=3D 24,
 		.ipversion	=3D 3,
+		.flags		=3D MXSFB_FLAG_NULL,
+		.num_formats	=3D 3,
 	},
 	[MXSFB_V4] =3D {
 		.transfer_count	=3D LCDC_V4_TRANSFER_COUNT,
@@ -66,14 +84,11 @@ static const struct mxsfb_devdata mxsfb_devdata[] =3D {
 		.hs_wdth_mask	=3D 0x3fff,
 		.hs_wdth_shift	=3D 18,
 		.ipversion	=3D 4,
+		.flags		=3D MXSFB_FLAG_BUSFREQ,
+		.num_formats	=3D ARRAY_SIZE(mxsfb_formats),
 	},
 };
=20
-static const uint32_t mxsfb_formats[] =3D {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_RGB565
-};
-
 static struct mxsfb_drm_private *
 drm_pipe_to_mxsfb_drm_private(struct drm_simple_display_pipe *pipe)
 {
@@ -250,7 +265,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned =
long flags)
 	}
=20
 	ret =3D drm_simple_display_pipe_init(drm, &mxsfb->pipe, &mxsfb_funcs,
-			mxsfb_formats, ARRAY_SIZE(mxsfb_formats), NULL,
+			mxsfb_formats, mxsfb->devdata->num_formats, NULL,
 			mxsfb->connector);
 	if (ret < 0) {
 		dev_err(drm->dev, "Cannot setup simple display pipe\n");
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsf=
b_drv.h
index 71238ad..c15b4f9 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -24,6 +24,8 @@ struct mxsfb_devdata {
 	unsigned int	 hs_wdth_mask;
 	unsigned int	 hs_wdth_shift;
 	unsigned int	 ipversion;
+	unsigned int	 flags;
+	unsigned int	 num_formats;
 };
=20
 struct mxsfb_drm_private {
@@ -51,6 +53,6 @@ void mxsfb_disable_axi_clk(struct mxsfb_drm_private *mxsf=
b);
 void mxsfb_crtc_enable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_crtc_disable(struct mxsfb_drm_private *mxsfb);
 void mxsfb_plane_atomic_update(struct mxsfb_drm_private *mxsfb,
-			       struct drm_plane_state *state);
+			       struct drm_plane_state *old_state);
=20
 #endif /* __MXSFB_DRV_H__ */
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_regs.h b/drivers/gpu/drm/mxsfb/mxs=
fb_regs.h
index c5b5e40..4904fdd 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_regs.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_regs.h
@@ -48,54 +48,76 @@
 #define LCDC_AS_BUF			0x220
 #define LCDC_AS_NEXT_BUF		0x230
=20
-#define CTRL_SFTRST			(1 << 31)
-#define CTRL_CLKGATE			(1 << 30)
-#define CTRL_BYPASS_COUNT		(1 << 19)
-#define CTRL_VSYNC_MODE			(1 << 18)
-#define CTRL_DOTCLK_MODE		(1 << 17)
-#define CTRL_DATA_SELECT		(1 << 16)
-#define CTRL_SET_BUS_WIDTH(x)		(((x) & 0x3) << 10)
-#define CTRL_GET_BUS_WIDTH(x)		(((x) >> 10) & 0x3)
-#define CTRL_BUS_WIDTH_MASK		(0x3 << 10)
-#define CTRL_SET_WORD_LENGTH(x)		(((x) & 0x3) << 8)
-#define CTRL_GET_WORD_LENGTH(x)		(((x) >> 8) & 0x3)
-#define CTRL_MASTER			(1 << 5)
-#define CTRL_DF16			(1 << 3)
-#define CTRL_DF18			(1 << 2)
-#define CTRL_DF24			(1 << 1)
-#define CTRL_RUN			(1 << 0)
-
-#define CTRL1_RECOVERY_ON_UNDERFLOW		(1 << 24)
-#define CTRL1_FIFO_CLEAR		(1 << 21)
-#define CTRL1_SET_BYTE_PACKAGING(x)	(((x) & 0xf) << 16)
-#define CTRL1_GET_BYTE_PACKAGING(x)	(((x) >> 16) & 0xf)
-#define CTRL1_CUR_FRAME_DONE_IRQ_EN	(1 << 13)
-#define CTRL1_CUR_FRAME_DONE_IRQ	(1 << 9)
-
-#define CTRL2_OUTSTANDING_REQS__REQ_16		(4 << 21)
+/* reg bit manipulation */
+#define REG_MASK(e, s) (((1 << ((e) - (s) + 1)) - 1) << (s))
+#define REG_PUT(x, e, s) (((x) << (s)) & REG_MASK(e, s))
+#define REG_GET(x, e, s) (((x) & REG_MASK(e, s)) >> (s))
+
+#define SWIZZLE_LE		0 /* Little-Endian or No swap */
+#define SWIZZLE_BE		1 /* Big-Endian or swap all */
+#define SWIZZLE_HWD		2 /* Swap half-words */
+#define SWIZZLE_HWD_BYTE	3 /* Swap bytes within each half-word */
+
+#define CTRL_SFTRST			BIT(31)
+#define CTRL_CLKGATE			BIT(30)
+#define CTRL_SHIFT_DIR(x)		REG_PUT((x), 26, 26)
+#define CTRL_SHIFT_NUM(x)		REG_PUT((x), 25, 21)
+#define CTRL_BYPASS_COUNT		BIT(19)
+#define CTRL_VSYNC_MODE			BIT(18)
+#define CTRL_DOTCLK_MODE		BIT(17)
+#define CTRL_DATA_SELECT		BIT(16)
+#define CTRL_INPUT_SWIZZLE(x)		REG_PUT((x), 15, 14)
+#define CTRL_CSC_SWIZZLE(x)		REG_PUT((x), 13, 12)
+#define CTRL_SET_BUS_WIDTH(x)		REG_PUT((x), 11, 10)
+#define CTRL_GET_BUS_WIDTH(x)		REG_GET((x), 11, 10)
+#define CTRL_BUS_WIDTH_MASK		REG_PUT((0x3), 11, 10)
+#define CTRL_SET_WORD_LENGTH(x)		REG_PUT((x), 9, 8)
+#define CTRL_GET_WORD_LENGTH(x)		REG_GET((x), 9, 8)
+#define CTRL_MASTER			BIT(5)
+#define CTRL_DF16			BIT(3)
+#define CTRL_DF18			BIT(2)
+#define CTRL_DF24			BIT(1)
+#define CTRL_RUN			BIT(0)
+
+#define CTRL1_RECOVERY_ON_UNDERFLOW	BIT(24)
+#define CTRL1_FIFO_CLEAR		BIT(21)
+#define CTRL1_SET_BYTE_PACKAGING(x)	REG_PUT((x), 19, 16)
+#define CTRL1_GET_BYTE_PACKAGING(x)	REG_GET((x), 19, 16)
+#define CTRL1_CUR_FRAME_DONE_IRQ_EN	BIT(13)
+#define CTRL1_CUR_FRAME_DONE_IRQ	BIT(9)
+
+#define REQ_1	0
+#define REQ_2	1
+#define REQ_4	2
+#define REQ_8	3
+#define REQ_16	4
+
+#define CTRL2_OUTSTANDING_REQS(x)	REG_PUT((x), 23, 21)
+#define CTRL2_ODD_LINE_PATTERN(x)	REG_PUT((x), 18, 16)
+#define CTRL2_EVEN_LINE_PATTERN(x)	REG_PUT((x), 14, 12)
=20
 #define TRANSFER_COUNT_SET_VCOUNT(x)	(((x) & 0xffff) << 16)
 #define TRANSFER_COUNT_GET_VCOUNT(x)	(((x) >> 16) & 0xffff)
 #define TRANSFER_COUNT_SET_HCOUNT(x)	((x) & 0xffff)
 #define TRANSFER_COUNT_GET_HCOUNT(x)	((x) & 0xffff)
=20
-#define VDCTRL0_ENABLE_PRESENT		(1 << 28)
-#define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
-#define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
-#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
-#define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
-#define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
-#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
-#define VDCTRL0_HALF_LINE		(1 << 19)
-#define VDCTRL0_HALF_LINE_MODE		(1 << 18)
+#define VDCTRL0_ENABLE_PRESENT		BIT(28)
+#define VDCTRL0_VSYNC_ACT_HIGH		BIT(27)
+#define VDCTRL0_HSYNC_ACT_HIGH		BIT(26)
+#define VDCTRL0_DOTCLK_ACT_FALLING	BIT(25)
+#define VDCTRL0_ENABLE_ACT_HIGH		BIT(24)
+#define VDCTRL0_VSYNC_PERIOD_UNIT	BIT(21)
+#define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	BIT(20)
+#define VDCTRL0_HALF_LINE		BIT(19)
+#define VDCTRL0_HALF_LINE_MODE		BIT(18)
 #define VDCTRL0_SET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
 #define VDCTRL0_GET_VSYNC_PULSE_WIDTH(x) ((x) & 0x3ffff)
=20
 #define VDCTRL2_SET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
 #define VDCTRL2_GET_HSYNC_PERIOD(x)	((x) & 0x3ffff)
=20
-#define VDCTRL3_MUX_SYNC_SIGNALS	(1 << 29)
-#define VDCTRL3_VSYNC_ONLY		(1 << 28)
+#define VDCTRL3_MUX_SYNC_SIGNALS	BIT(29)
+#define VDCTRL3_VSYNC_ONLY		BIT(28)
 #define SET_HOR_WAIT_CNT(x)		(((x) & 0xfff) << 16)
 #define GET_HOR_WAIT_CNT(x)		(((x) >> 16) & 0xfff)
 #define SET_VERT_WAIT_CNT(x)		((x) & 0xffff)
@@ -103,7 +125,7 @@
=20
 #define VDCTRL4_SET_DOTCLK_DLY(x)	(((x) & 0x7) << 29) /* v4 only */
 #define VDCTRL4_GET_DOTCLK_DLY(x)	(((x) >> 29) & 0x7) /* v4 only */
-#define VDCTRL4_SYNC_SIGNALS_ON		(1 << 18)
+#define VDCTRL4_SYNC_SIGNALS_ON		BIT(18)
 #define SET_DOTCLK_H_VALID_DATA_CNT(x)	((x) & 0x3ffff)
=20
 #define DEBUG0_HSYNC			(1 < 26)
@@ -124,7 +146,7 @@
 #define STMLCDIF_18BIT 2 /* pixel data bus to the display is of 18 bit wid=
th */
 #define STMLCDIF_24BIT 3 /* pixel data bus to the display is of 24 bit wid=
th */
=20
-#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define MXSFB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* negative edge sampling *=
/
+#define MXSFB_SYNC_DATA_ENABLE_HIGH_ACT	BIT(6)
+#define MXSFB_SYNC_DOTCLK_FALLING_ACT	BIT(7) /* negative edge sampling */
=20
 #endif /* __MXSFB_REGS_H__ */
--=20
2.7.4

