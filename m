Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444D8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91562173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Vb5MglOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfBZQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:37 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:63296
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727823AbfBZQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w7Qe3Jxcwa+kcY8kwHI3Sa6EPOHf0mZG3k9bCGopMA=;
 b=Vb5MglOeEvjRdCQNPtHoPrt+nGBh8wxkI4N3NG+7i/KMDS6fMggMC+eQfN3NYgzCmz81oW8+yuuVK/AMflkQE0KxXhQgHF5ECEd6hLRVobjoO3I6ML0ZoUgrVJIk2EmKctBp/IS0FMiENV7WZ8rfOvl+CYHLna4uUu9MV3RCUVI=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:54 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:54 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [PATCH v4 03/10] drm/arm/malidp: Set the AFBC register bits if the
 framebuffer has AFBC modifier
Thread-Topic: [PATCH v4 03/10] drm/arm/malidp: Set the AFBC register bits if
 the framebuffer has AFBC modifier
Thread-Index: AQHUze8/MD1exiLeHEi++2SYE0JJWg==
Date:   Tue, 26 Feb 2019 16:20:54 +0000
Message-ID: <1551198042-4314-4-git-send-email-ayan.halder@arm.com>
References: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1551198042-4314-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::16) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3423f45f-216e-43eb-b553-08d69c0661df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:L+KEHuIq5aZrvso7s7IiYRmeLvz6tSuvAEgnT1iZgvFtpedYteukE4a+eQs4CJcUfZu/7lR3CN08kAoJVIK/lORE/o3RBRA+5oqnolwjTURkpMNa39a2i1VwaSYE06dkYHu8KZJ5IeZuANDMlmTTX031HxNhEmMkDfXQswXjKPs=
x-microsoft-antispam-prvs: <AM0PR08MB3682AF65B2601C3176EAF81CE47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(43544003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(45080400002)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(30864003)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HHcEBP0xp9h/KZVAH0ZE6P1yOSppmCbbiuPVf8uGW0shu3nIaBppFqMWNLJdyvQAlHXKPvBdzx/c784cbgG+aROyz0KXlp7wcp5acruCjTSIxHuoKMt/3FrNZeLWrKruiVhzjiwaXCGbOV7dVx/PNMsVxNK3U9vDgJMtQpYCAKmzQEeU8e6vRp4JbFFawH8paEN/UUqxvAxbQqGWpfCUVxUHY3r0wbBfqJoVJJl5jWYVPfX4IvT8RpVFltbEZAD5sqJ1M0ntUd1lEgdeCIJmwqOLbOSZbEoz8u8kvqV/jN07M5ECCnKYr26hxfRA2m9ldWpyD10tp48o6kwYnAFdpBvBHfzXTGbUN1cufBw2TTmgIgjkYZkZ6rCCO236XJ7o/xMfMBPAPyEF7XA/YCYPPmLAcpxvCUcQ19QvoMailBk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3423f45f-216e-43eb-b553-08d69c0661df
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:54.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3682
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Kumar Halder <ayan.halder@arm.com>

Added the AFBC decoder registers for DP500 , DP550 and DP650.
These registers control the processing of AFBC buffers. It controls various
features like AFBC decoder enable, lossless transformation and block split
as well as setting of the left, right, top and bottom cropping of AFBC
buffers (in number of pixels).
All the layers (except DE_SMART) support framebuffers with AFBC modifiers.
One needs to set the pixel values of the top, left, bottom and right
cropping for the AFBC framebuffer.
Cropping an AFBC framebuffer is controlled by the AFBC crop registers.
In that case, the layer input size registers should be configured with
framebuffer's dimensions and not with drm_plane_state source width/height
values (which is used for non AFBC framebuffer to denote cropping).

Changes from v1:
 - Removed the "if (fb->modifier)" check from malidp_de_plane_update()
and added it in malidp_de_set_plane_afbc(). This will consolidate all the
AFBC specific register configurations in a single function ie
malidp_de_set_plane_afbc().

Changes from v2:
 - For AFBC framebuffer, layer input size register should be set to
framebuffer's width and height.

Changes from v3:
- Rebased on top of latest drm-misc-next
- Some cleanups/sanity changes based on Liviu's comments

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c     |  30 ++++++----
 drivers/gpu/drm/arm/malidp_hw.h     |   2 +
 drivers/gpu/drm/arm/malidp_planes.c | 107 ++++++++++++++++++++++++++++++++=
----
 drivers/gpu/drm/arm/malidp_regs.h   |  20 +++++++
 4 files changed, 136 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index b9bed11..64c2ca3 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -94,11 +94,14 @@ static const struct malidp_layer malidp500_layers[] =3D=
 {
 	 *	yuv2rgb matrix offset, mmu control register offset, rotation_features
 	 */
 	{ DE_VIDEO1, MALIDP500_DE_LV_BASE, MALIDP500_DE_LV_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP500_LV_YUV2RGB, 0, ROTATE_ANY,
+		MALIDP500_DE_LV_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP500_DE_LG1_BASE, MALIDP500_DE_LG1_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY,
+		MALIDP500_DE_LG1_AD_CTRL },
 	{ DE_GRAPHICS2, MALIDP500_DE_LG2_BASE, MALIDP500_DE_LG2_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY,
+		MALIDP500_DE_LG2_AD_CTRL },
 };
=20
 static const struct malidp_layer malidp550_layers[] =3D {
@@ -106,13 +109,16 @@ static const struct malidp_layer malidp550_layers[] =
=3D {
 	 *	yuv2rgb matrix offset, mmu control register offset, rotation_features
 	 */
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
-		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY },
+		MALIDP_DE_LG_STRIDE, 0, 0, ROTATE_ANY,
+		MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
-		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY },
+		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB, 0, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
-		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE },
+		MALIDP550_DE_LS_R1_STRIDE, 0, 0, ROTATE_NONE, 0 },
 };
=20
 static const struct malidp_layer malidp650_layers[] =3D {
@@ -122,16 +128,18 @@ static const struct malidp_layer malidp650_layers[] =
=3D {
 	 */
 	{ DE_VIDEO1, MALIDP550_DE_LV1_BASE, MALIDP550_DE_LV1_PTR_BASE,
 		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
-		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
+		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY,
+		MALIDP550_DE_LV1_AD_CTRL },
 	{ DE_GRAPHICS1, MALIDP550_DE_LG_BASE, MALIDP550_DE_LG_PTR_BASE,
 		MALIDP_DE_LG_STRIDE, 0, MALIDP650_DE_LG_MMU_CTRL,
-		ROTATE_COMPRESSED },
+		ROTATE_COMPRESSED, MALIDP550_DE_LG_AD_CTRL },
 	{ DE_VIDEO2, MALIDP550_DE_LV2_BASE, MALIDP550_DE_LV2_PTR_BASE,
 		MALIDP_DE_LV_STRIDE0, MALIDP550_LV_YUV2RGB,
-		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY },
+		MALIDP650_DE_LV_MMU_CTRL, ROTATE_ANY,
+		MALIDP550_DE_LV2_AD_CTRL },
 	{ DE_SMART, MALIDP550_DE_LS_BASE, MALIDP550_DE_LS_PTR_BASE,
 		MALIDP550_DE_LS_R1_STRIDE, 0, MALIDP650_DE_LS_MMU_CTRL,
-		ROTATE_NONE },
+		ROTATE_NONE, 0 },
 };
=20
 #define SE_N_SCALING_COEFFS	96
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_h=
w.h
index 40155e2..651558f 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -70,6 +70,8 @@ struct malidp_layer {
 	s16 yuv2rgb_offset;	/* offset to the YUV->RGB matrix entries */
 	u16 mmu_ctrl_offset;    /* offset to the MMU control register */
 	enum rotation_features rot;	/* type of rotation supported */
+	/* address offset for the AFBC decoder registers */
+	u16 afbc_decoder_offset;
 };
=20
 enum malidp_scaling_coeff_set {
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index c9a6d3e..181957c 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -592,6 +592,83 @@ static void malidp_de_set_mmu_control(struct malidp_pl=
ane *mp,
 			mp->layer->base + mp->layer->mmu_ctrl_offset);
 }
=20
+static void malidp_set_plane_base_addr(struct drm_framebuffer *fb,
+				       struct malidp_plane *mp,
+				       int plane_index)
+{
+	dma_addr_t paddr;
+	u16 ptr;
+	struct drm_plane *plane =3D &mp->base;
+	bool afbc =3D fb->modifier ? true : false;
+
+	ptr =3D mp->layer->ptr + (plane_index << 4);
+
+	/*
+	 * drm_fb_cma_get_gem_addr() alters the physical base address of the
+	 * framebuffer as per the plane's src_x, src_y co-ordinates (ie to
+	 * take care of source cropping).
+	 * For AFBC, this is not needed as the cropping is handled by _AD_CROP_H
+	 * and _AD_CROP_V registers.
+	 */
+	if (!afbc) {
+		paddr =3D drm_fb_cma_get_gem_addr(fb, plane->state,
+						plane_index);
+	} else {
+		struct drm_gem_cma_object *obj;
+
+		obj =3D drm_fb_cma_get_gem_obj(fb, plane_index);
+
+		if (WARN_ON(!obj))
+			return;
+		paddr =3D obj->paddr;
+	}
+
+	malidp_hw_write(mp->hwdev, lower_32_bits(paddr), ptr);
+	malidp_hw_write(mp->hwdev, upper_32_bits(paddr), ptr + 4);
+}
+
+static void malidp_de_set_plane_afbc(struct drm_plane *plane)
+{
+	struct malidp_plane *mp;
+	u32 src_w, src_h, val =3D 0, src_x, src_y;
+	struct drm_framebuffer *fb =3D plane->state->fb;
+
+	mp =3D to_malidp_plane(plane);
+
+	/* no afbc_decoder_offset means AFBC is not supported on this plane */
+	if (!mp->layer->afbc_decoder_offset)
+		return;
+
+	if (!fb->modifier) {
+		malidp_hw_write(mp->hwdev, 0, mp->layer->afbc_decoder_offset);
+		return;
+	}
+
+	/* convert src values from Q16 fixed point to integer */
+	src_w =3D plane->state->src_w >> 16;
+	src_h =3D plane->state->src_h >> 16;
+	src_x =3D plane->state->src_x >> 16;
+	src_y =3D plane->state->src_y >> 16;
+
+	val =3D ((fb->width - (src_x + src_w)) << MALIDP_AD_CROP_RIGHT_OFFSET) |
+		   src_x;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_H);
+
+	val =3D ((fb->height - (src_y + src_h)) << MALIDP_AD_CROP_BOTTOM_OFFSET) =
|
+		   src_y;
+	malidp_hw_write(mp->hwdev, val,
+			mp->layer->afbc_decoder_offset + MALIDP_AD_CROP_V);
+
+	val =3D MALIDP_AD_EN;
+	if (fb->modifier & AFBC_FORMAT_MOD_SPLIT)
+		val |=3D MALIDP_AD_BS;
+	if (fb->modifier & AFBC_FORMAT_MOD_YTR)
+		val |=3D MALIDP_AD_YTR;
+
+	malidp_hw_write(mp->hwdev, val, mp->layer->afbc_decoder_offset);
+}
+
 static void malidp_de_plane_update(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
@@ -602,12 +679,23 @@ static void malidp_de_plane_update(struct drm_plane *=
plane,
 	u8 plane_alpha =3D state->alpha >> 8;
 	u32 src_w, src_h, dest_w, dest_h, val;
 	int i;
+	struct drm_framebuffer *fb =3D plane->state->fb;
=20
 	mp =3D to_malidp_plane(plane);
=20
-	/* convert src values from Q16 fixed point to integer */
-	src_w =3D state->src_w >> 16;
-	src_h =3D state->src_h >> 16;
+	/*
+	 * For AFBC framebuffer, use the framebuffer width and height for
+	 * configuring layer input size register.
+	 */
+	if (fb->modifier) {
+		src_w =3D fb->width;
+		src_h =3D fb->height;
+	} else {
+		/* convert src values from Q16 fixed point to integer */
+		src_w =3D state->src_w >> 16;
+		src_h =3D state->src_h >> 16;
+	}
+
 	dest_w =3D state->crtc_w;
 	dest_h =3D state->crtc_h;
=20
@@ -615,15 +703,8 @@ static void malidp_de_plane_update(struct drm_plane *p=
lane,
 	val =3D (val & ~LAYER_FORMAT_MASK) | ms->format;
 	malidp_hw_write(mp->hwdev, val, mp->layer->base);
=20
-	for (i =3D 0; i < ms->n_planes; i++) {
-		/* calculate the offset for the layer's plane registers */
-		u16 ptr =3D mp->layer->ptr + (i << 4);
-		dma_addr_t fb_addr =3D drm_fb_cma_get_gem_addr(state->fb,
-							     state, i);
-
-		malidp_hw_write(mp->hwdev, lower_32_bits(fb_addr), ptr);
-		malidp_hw_write(mp->hwdev, upper_32_bits(fb_addr), ptr + 4);
-	}
+	for (i =3D 0; i < ms->n_planes; i++)
+		malidp_set_plane_base_addr(fb, mp, i);
=20
 	malidp_de_set_mmu_control(mp, ms);
=20
@@ -657,6 +738,8 @@ static void malidp_de_plane_update(struct drm_plane *pl=
ane,
 				mp->layer->base + MALIDP550_LS_R1_IN_SIZE);
 	}
=20
+	malidp_de_set_plane_afbc(plane);
+
 	/* first clear the rotation bits */
 	val =3D malidp_hw_read(mp->hwdev, mp->layer->base + MALIDP_LAYER_CONTROL)=
;
 	val &=3D ~LAYER_ROT_MASK;
diff --git a/drivers/gpu/drm/arm/malidp_regs.h b/drivers/gpu/drm/arm/malidp=
_regs.h
index 7ce3e14..a0dd6e1 100644
--- a/drivers/gpu/drm/arm/malidp_regs.h
+++ b/drivers/gpu/drm/arm/malidp_regs.h
@@ -198,10 +198,13 @@
 #define MALIDP500_LV_YUV2RGB		((s16)(-0xB8))
 #define MALIDP500_DE_LV_BASE		0x00100
 #define MALIDP500_DE_LV_PTR_BASE	0x00124
+#define MALIDP500_DE_LV_AD_CTRL		0x00400
 #define MALIDP500_DE_LG1_BASE		0x00200
 #define MALIDP500_DE_LG1_PTR_BASE	0x0021c
+#define MALIDP500_DE_LG1_AD_CTRL	0x0040c
 #define MALIDP500_DE_LG2_BASE		0x00300
 #define MALIDP500_DE_LG2_PTR_BASE	0x0031c
+#define MALIDP500_DE_LG2_AD_CTRL	0x00418
 #define MALIDP500_SE_BASE		0x00c00
 #define MALIDP500_SE_CONTROL		0x00c0c
 #define MALIDP500_SE_MEMWRITE_OUT_SIZE	0x00c2c
@@ -228,10 +231,13 @@
 #define MALIDP550_LV_YUV2RGB		0x00084
 #define MALIDP550_DE_LV1_BASE		0x00100
 #define MALIDP550_DE_LV1_PTR_BASE	0x00124
+#define MALIDP550_DE_LV1_AD_CTRL	0x001B8
 #define MALIDP550_DE_LV2_BASE		0x00200
 #define MALIDP550_DE_LV2_PTR_BASE	0x00224
+#define MALIDP550_DE_LV2_AD_CTRL	0x002B8
 #define MALIDP550_DE_LG_BASE		0x00300
 #define MALIDP550_DE_LG_PTR_BASE	0x0031c
+#define MALIDP550_DE_LG_AD_CTRL		0x00330
 #define MALIDP550_DE_LS_BASE		0x00400
 #define MALIDP550_DE_LS_PTR_BASE	0x0042c
 #define MALIDP550_DE_PERF_BASE		0x00500
@@ -258,6 +264,20 @@
 #define MALIDP_MMU_CTRL_PX_PS(x)	(1 << (8 + (x)))
 #define MALIDP_MMU_CTRL_PP_NUM_REQ(x)	(((x) & 0x7f) << 12)
=20
+/* AFBC register offsets relative to MALIDPXXX_DE_LX_AD_CTRL */
+/* The following register offsets are common for DP500, DP550 and DP650 */
+#define MALIDP_AD_CROP_H                0x4
+#define MALIDP_AD_CROP_V                0x8
+#define MALIDP_AD_END_PTR_LOW           0xc
+#define MALIDP_AD_END_PTR_HIGH          0x10
+
+/* AFBC decoder Registers */
+#define MALIDP_AD_EN                    BIT(0)
+#define MALIDP_AD_YTR                   BIT(4)
+#define MALIDP_AD_BS                    BIT(8)
+#define MALIDP_AD_CROP_RIGHT_OFFSET     16
+#define MALIDP_AD_CROP_BOTTOM_OFFSET    16
+
 /*
  * Starting with DP550 the register map blocks has been standardised to th=
e
  * following layout:
--=20
2.7.4

