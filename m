Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5465EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044412173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="OEmkOied"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfBZQVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:13 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfBZQVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6gk0G2D5Y+B6yPUp8J1Dg/PGed+C/xsOViJlHtL3Nzw=;
 b=OEmkOiedXUxYg97XV3IAGjUEvug1MqCinl2fA1WTeiul5K+7oqS7JNcsHmONNQS1y3JMlQWpX90XInruPAVSDc1vLGdnqD44hrmonVi8k83TcRIX0eIeNA7ll6Eo652lAgqaNDVADNs5eqqIHkQlatKFR+opLjfc368V/gZt1hU=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:56 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:56 +0000
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
Subject: [PATCH v2 05/10] drm/arm/malidp:- Define a common list of AFBC format
 modifiers supported for DP500, DP550 and DP650
Thread-Topic: [PATCH v2 05/10] drm/arm/malidp:- Define a common list of AFBC
 format modifiers supported for DP500, DP550 and DP650
Thread-Index: AQHUze9AAeTU5/Bz9EejMNz5yrsyaw==
Date:   Tue, 26 Feb 2019 16:20:56 +0000
Message-ID: <1551198042-4314-6-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 86f8f740-6fb1-47c8-9ff1-08d69c0662df
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
x-ms-exchange-purlcount: 1
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:TsFow9Yo65chTq6qKj7qN5xovMCL/jlB+0F8sC+NJlc3z0J2yiHaK8TJOKLmXbBdUZKjQTfb0MuR3dYUwJ47AUPxZM1Hf5Da+YQZ0mk/zwju+fQuQ+SqLgFHZdQqDoVauRRmWxfm2DoCse7YsoSspnzCn975qYtvSiJjEOx0yPs=
x-microsoft-antispam-prvs: <AM0PR08MB36824DB8B7CC325B7835AF21E47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6306002)(6512007)(53946003)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(966005)(81156014)(30864003)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L84x1WYKOtr6zyn9WN+VLv+Apt/JUaku++Pf1puajd8DEbSTttptOOxZKADLEQaZFDw74+K09Z+c2e7QZbUmuJL/fP9gz5Rvk96LftjzRmCLGZgpykE3wNDmauHuTcdi0b7O1OUtrXW7iy/k7d3f0yCeQExEo9jyaCzf3gpADhnJEsCvHC5kbpfzCilRaZv6f0+e//w4IlUwDwJFKsiYltaUxXeui1lAJJDips1UB+pNGuCyg3s3s2A8S03Nm3dylTlb9rgGbkVOo7Bjc3MMbhjoGyQw/kSxyfCLaQs9G2INPwCn+SgB1g+dr41hcqPoodw8ZlI/erOALfpcm56VUAKjN1pLfpHNvU3dLGTcHDpYHEd9+NS/FBk9GeNaPcjq5s7kgDYm2f5a3J2Rqj2xxNVZGQr/Z63dM4mHDqSPO38=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f8f740-6fb1-47c8-9ff1-08d69c0662df
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:56.0162
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

We need to define a common list of format modifiers supported by each of
the Mali display processors.

The following are the constraints with AFBC:-

1. AFBC is not supported for the formats defined in
malidp_hw_format_is_linear_only()

2. Some of the formats are supported only with AFBC modifiers. Thus we have
introduced a new function 'malidp_hw_format_is_afbc_only()' which verifies
the same.

3. AFBC_FORMAT_MOD_YTR needs to be provided for any RGB format.

4. Formats <=3D 16bpp cannot support AFBC_FORMAT_MOD_SPLIT.

5. CBR should not be set for non-subsampled formats.

6. SMART layer does not support framebuffer with AFBC modifiers.
Return -EINVAL for such a scenario.

7. AFBC_FORMAT_MOD_YTR is not supported for any YUV formats.

8. Formats which are subsampled cannot support AFBC_FORMAT_MOD_SPLIT.
However in DP550, YUV_420_10BIT is supported with AFBC_FORMAT_MOD_SPLIT.
This feature has been identified with
MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT.

9. In DP550 and DP650, for YUYV, the hardware supports different
format-ids to be used with and without AFBC modifier. We have used the
feature 'MALIDP_DEVICE_AFBC_YUYV_USE_422_P2' to identify this
characteristic.

10. DP500 does not support split mode (ie AFBC_FORMAT_MOD_SPLIT). We have
used the feature 'MALIDP_DEVICE_AFBC_SUPPORT_SPLIT' to identify the DPs
which support SPLIT mode.

11. DP550 supports YUV420 with split mode. We have defined the feature
'AFBC_SUPPORT_SPLIT_WITH_YUV_420_10' to identify this characteristic.

Changes since v1:-
- Merged https://patchwork.freedesktop.org/patch/265215/ into this patch
- As Liviu pointed out in the last patch, we can pull the checks outside
of the 'while (*modifiers !=3D DRM_FORMAT_MOD_INVALID)' loop
- Rebased

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c    |  32 ++-------
 drivers/gpu/drm/arm/malidp_drv.h    |   6 ++
 drivers/gpu/drm/arm/malidp_hw.c     |  96 +++++++++++++++++++++++++--
 drivers/gpu/drm/arm/malidp_hw.h     |  24 +++++--
 drivers/gpu/drm/arm/malidp_mw.c     |   2 +-
 drivers/gpu/drm/arm/malidp_planes.c | 126 ++++++++++++++++++++++++++++++++=
+++-
 6 files changed, 246 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index ab50ad0..c697664 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -264,37 +264,17 @@ static bool
 malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
 				    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info;
-
-	if ((mode_cmd->modifier[0] >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM) {
-		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
+	if (malidp_format_mod_supported(dev, mode_cmd->pixel_format,
+					mode_cmd->modifier[0]) =3D=3D false)
 		return false;
-	}
-
-	if (mode_cmd->modifier[0] &
-	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
-		DRM_DEBUG_KMS("Unsupported modifiers\n");
-		return false;
-	}
-
-	info =3D drm_get_format_info(dev, mode_cmd);
-	if (!info) {
-		DRM_DEBUG_KMS("Unable to get the format information\n");
-		return false;
-	}
-
-	if (info->num_planes !=3D 1) {
-		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
-		return false;
-	}
=20
 	if (mode_cmd->offsets[0] !=3D 0) {
 		DRM_DEBUG_KMS("AFBC buffers' plane offset should be 0\n");
 		return false;
 	}
=20
-	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
-	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
+	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
+	case AFBC_SIZE_16X16:
 		if ((mode_cmd->width % 16) || (mode_cmd->height % 16)) {
 			DRM_DEBUG_KMS("AFBC buffers must be aligned to 16 pixels\n");
 			return false;
@@ -319,8 +299,8 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *=
dev,
 	u32 afbc_superblock_size =3D 0, afbc_superblock_height =3D 0;
 	u32 afbc_superblock_width =3D 0, afbc_size =3D 0;
=20
-	switch (mode_cmd->modifier[0] & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK) {
-	case AFBC_FORMAT_MOD_BLOCK_SIZE_16x16:
+	switch (mode_cmd->modifier[0] & AFBC_SIZE_MASK) {
+	case AFBC_SIZE_16X16:
 		afbc_superblock_height =3D 16;
 		afbc_superblock_width =3D 16;
 		break;
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_=
drv.h
index b76c86f..019a682 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -90,6 +90,12 @@ struct malidp_crtc_state {
 int malidp_de_planes_init(struct drm_device *drm);
 int malidp_crtc_init(struct drm_device *drm);
=20
+bool malidp_hw_format_is_linear_only(u32 format);
+bool malidp_hw_format_is_afbc_only(u32 format);
+
+bool malidp_format_mod_supported(struct drm_device *drm,
+				 u32 format, u64 modifier);
+
 #ifdef CONFIG_DEBUG_FS
 void malidp_error(struct malidp_drm *malidp,
 		  struct malidp_error_stats *error_stats, u32 status,
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index b4a0e11..0ac2762 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -60,6 +60,8 @@ static const struct malidp_format_id malidp500_de_formats=
[] =3D {
 #define MALIDP_ID(__group, __format) \
 	((((__group) & 0x7) << 3) | ((__format) & 0x7))
=20
+#define AFBC_YUV_422_FORMAT_ID	MALIDP_ID(5, 1)
+
 #define MALIDP_COMMON_FORMATS \
 	/*    fourcc,   layers supporting the format,      internal id   */ \
 	{ DRM_FORMAT_ARGB2101010, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2 | SE_MEMWR=
ITE, MALIDP_ID(0, 0) }, \
@@ -162,6 +164,32 @@ static const struct malidp_layer malidp650_layers[] =
=3D {
 		ROTATE_NONE, 0 },
 };
=20
+const u64 malidp_format_modifiers[] =3D {
+	/* All RGB formats (except XRGB, RGBX, XBGR, BGRX) */
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE),
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR),
+
+	/* All RGB formats > 16bpp (except XRGB, RGBX, XBGR, BGRX) */
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_YTR | AFBC_SPARSE | AFBC_S=
PLIT),
+
+	/* All 8 or 10 bit YUV 444 formats. */
+	/* In DP550, 10 bit YUV 420 format also supported */
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE | AFBC_SPLIT),
+
+	/* YUV 420, 422 P1 8 bit and YUV 444 8 bit/10 bit formats */
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_SPARSE),
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16),
+
+	/* YUV 420, 422 P1 8, 10 bit formats */
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR | AFBC_SPARSE),
+	DRM_FORMAT_MOD_ARM_AFBC(AFBC_SIZE_16X16 | AFBC_CBR),
+
+	/* All formats */
+	DRM_FORMAT_MOD_LINEAR,
+
+	DRM_FORMAT_MOD_INVALID
+};
+
 #define SE_N_SCALING_COEFFS	96
 static const u16 dp500_se_scaling_coeffs[][SE_N_SCALING_COEFFS] =3D {
 	[MALIDP_UPSCALING_COEFFS - 1] =3D {
@@ -866,7 +894,10 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICE=
S] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
+				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
 			.n_layers =3D ARRAY_SIZE(malidp550_layers),
 			.layers =3D malidp550_layers,
 			.de_irq_map =3D {
@@ -912,7 +943,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES=
] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
+				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
 			.n_layers =3D ARRAY_SIZE(malidp650_layers),
 			.layers =3D malidp650_layers,
 			.de_irq_map =3D {
@@ -961,19 +994,72 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVIC=
ES] =3D {
 };
=20
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
-			   u8 layer_id, u32 format)
+			   u8 layer_id, u32 format, bool has_modifier)
 {
 	unsigned int i;
=20
 	for (i =3D 0; i < map->n_pixel_formats; i++) {
 		if (((map->pixel_formats[i].layer & layer_id) =3D=3D layer_id) &&
-		    (map->pixel_formats[i].format =3D=3D format))
-			return map->pixel_formats[i].id;
+		    (map->pixel_formats[i].format =3D=3D format)) {
+			/*
+			 * In some DP550 and DP650, DRM_FORMAT_YUYV + AFBC modifier
+			 * is supported by a different h/w format id than
+			 * DRM_FORMAT_YUYV (only).
+			 */
+			if (format =3D=3D DRM_FORMAT_YUYV &&
+			    (has_modifier) &&
+			    (map->features & MALIDP_DEVICE_AFBC_YUYV_USE_422_P2))
+				return AFBC_YUV_422_FORMAT_ID;
+			else
+				return map->pixel_formats[i].id;
+		}
 	}
=20
 	return MALIDP_INVALID_FORMAT_ID;
 }
=20
+bool malidp_hw_format_is_linear_only(u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_ARGB2101010:
+	case DRM_FORMAT_RGBA1010102:
+	case DRM_FORMAT_BGRA1010102:
+	case DRM_FORMAT_ARGB8888:
+	case DRM_FORMAT_RGBA8888:
+	case DRM_FORMAT_BGRA8888:
+	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_XRGB8888:
+	case DRM_FORMAT_RGBX8888:
+	case DRM_FORMAT_BGRX8888:
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_RGB565:
+	case DRM_FORMAT_ARGB1555:
+	case DRM_FORMAT_RGBA5551:
+	case DRM_FORMAT_BGRA5551:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_XYUV8888:
+	case DRM_FORMAT_XVYU2101010:
+	case DRM_FORMAT_X0L2:
+	case DRM_FORMAT_X0L0:
+		return true;
+	default:
+		return false;
+	}
+}
+
+bool malidp_hw_format_is_afbc_only(u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_VUY888:
+	case DRM_FORMAT_VUY101010:
+	case DRM_FORMAT_YUV420_8BIT:
+	case DRM_FORMAT_YUV420_10BIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void malidp_hw_clear_irq(struct malidp_hw_device *hwdev, u8 block, =
u32 irq)
 {
 	u32 base =3D malidp_get_block_base(hwdev, block);
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_h=
w.h
index 651558f..0859302 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -95,7 +95,10 @@ struct malidp_se_config {
 };
=20
 /* regmap features */
-#define MALIDP_REGMAP_HAS_CLEARIRQ	(1 << 0)
+#define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
+#define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
+#define MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT		BIT(2)
+#define MALIDP_DEVICE_AFBC_YUYV_USE_422_P2			BIT(3)
=20
 struct malidp_hw_regmap {
 	/* address offset of the DE register bank */
@@ -321,7 +324,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)=
;
 void malidp_se_irq_fini(struct malidp_hw_device *hwdev);
=20
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
-			   u8 layer_id, u32 format);
+			   u8 layer_id, u32 format, bool has_modifier);
=20
 static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hwdev,=
 bool rotated)
 {
@@ -390,9 +393,18 @@ static inline void malidp_se_set_enh_coeffs(struct mal=
idp_hw_device *hwdev)
=20
 #define MALIDP_GAMMA_LUT_SIZE		4096
=20
-#define AFBC_MOD_VALID_BITS (AFBC_FORMAT_MOD_BLOCK_SIZE_MASK | \
-			AFBC_FORMAT_MOD_YTR | AFBC_FORMAT_MOD_SPLIT | \
-			AFBC_FORMAT_MOD_SPARSE | AFBC_FORMAT_MOD_CBR | \
-			AFBC_FORMAT_MOD_TILED | AFBC_FORMAT_MOD_SC)
+#define AFBC_SIZE_MASK		AFBC_FORMAT_MOD_BLOCK_SIZE_MASK
+#define AFBC_SIZE_16X16		AFBC_FORMAT_MOD_BLOCK_SIZE_16x16
+#define AFBC_YTR		AFBC_FORMAT_MOD_YTR
+#define AFBC_SPARSE		AFBC_FORMAT_MOD_SPARSE
+#define AFBC_CBR		AFBC_FORMAT_MOD_CBR
+#define AFBC_SPLIT		AFBC_FORMAT_MOD_SPLIT
+#define AFBC_TILED		AFBC_FORMAT_MOD_TILED
+#define AFBC_SC			AFBC_FORMAT_MOD_SC
+
+#define AFBC_MOD_VALID_BITS	(AFBC_SIZE_MASK | AFBC_YTR | AFBC_SPLIT | \
+				 AFBC_SPARSE | AFBC_CBR | AFBC_TILED | AFBC_SC)
+
+extern const u64 malidp_format_modifiers[];
=20
 #endif  /* __MALIDP_HW_H__ */
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_m=
w.c
index 041a64d..28cd351 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -143,7 +143,7 @@ malidp_mw_encoder_atomic_check(struct drm_encoder *enco=
der,
=20
 	mw_state->format =3D
 		malidp_hw_get_format_id(&malidp->dev->hw->map, SE_MEMWRITE,
-					fb->format->format);
+					fb->format->format, !!fb->modifier);
 	if (mw_state->format =3D=3D MALIDP_INVALID_FORMAT_ID) {
 		struct drm_format_name_buf format_name;
=20
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index 181957c..79e00bf 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -52,6 +52,8 @@
 #define MALIDP550_LS_ENABLE		0x01c
 #define MALIDP550_LS_R1_IN_SIZE		0x020
=20
+#define MODIFIERS_COUNT_MAX		15
+
 /*
  * This 4-entry look-up-table is used to determine the full 8-bit alpha va=
lue
  * for formats with 1- or 2-bit alpha channels.
@@ -145,6 +147,119 @@ static void malidp_plane_atomic_print_state(struct dr=
m_printer *p,
 	drm_printf(p, "\tmmu_prefetch_pgsize=3D%d\n", ms->mmu_prefetch_pgsize);
 }
=20
+bool malidp_format_mod_supported(struct drm_device *drm,
+				 u32 format, u64 modifier)
+{
+	const struct drm_format_info *info;
+	const u64 *modifiers;
+	struct malidp_drm *malidp =3D drm->dev_private;
+	const struct malidp_hw_regmap *map =3D &malidp->dev->hw->map;
+
+	if (WARN_ON(modifier =3D=3D DRM_FORMAT_MOD_INVALID))
+		return false;
+
+	/* Some pixel formats are supported without any modifier */
+	if (modifier =3D=3D DRM_FORMAT_MOD_LINEAR) {
+		/*
+		 * However these pixel formats need to be supported with
+		 * modifiers only
+		 */
+		return !malidp_hw_format_is_afbc_only(format);
+	}
+
+	if ((modifier >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM) {
+		DRM_ERROR("Unknown modifier (not Arm)\n");
+		return false;
+	}
+
+	if (modifier &
+	    ~DRM_FORMAT_MOD_ARM_AFBC(AFBC_MOD_VALID_BITS)) {
+		DRM_DEBUG_KMS("Unsupported modifiers\n");
+		return false;
+	}
+
+	modifiers =3D malidp_format_modifiers;
+
+	/* SPLIT buffers must use SPARSE layout */
+	if (WARN_ON_ONCE((modifier & AFBC_SPLIT) && !(modifier & AFBC_SPARSE)))
+		return false;
+
+	/* CBR only applies to YUV formats, where YTR should be always 0 */
+	if (WARN_ON_ONCE((modifier & AFBC_CBR) && (modifier & AFBC_YTR)))
+		return false;
+
+	while (*modifiers !=3D DRM_FORMAT_MOD_INVALID) {
+		if (*modifiers =3D=3D modifier)
+			break;
+
+		modifiers++;
+	}
+
+	/* return false, if the modifier was not found */
+	if (*modifiers =3D=3D DRM_FORMAT_MOD_INVALID) {
+		DRM_DEBUG_KMS("Unsupported modifier\n");
+		return false;
+	}
+
+	info =3D drm_format_info(format);
+
+	if (info->num_planes !=3D 1) {
+		DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
+		return false;
+	}
+
+	if (malidp_hw_format_is_linear_only(format) =3D=3D true) {
+		DRM_DEBUG_KMS("Given format (0x%x) is supported is linear mode only\n",
+			      format);
+		return false;
+	}
+
+	/*
+	 * RGB formats need to provide YTR modifier and YUV formats should not
+	 * provide YTR modifier.
+	 */
+	if (!(info->is_yuv) !=3D !!(modifier & AFBC_FORMAT_MOD_YTR)) {
+		DRM_DEBUG_KMS("AFBC_FORMAT_MOD_YTR is %s for %s formats\n",
+			      info->is_yuv ? "disallowed" : "mandatory",
+			      info->is_yuv ? "YUV" : "RGB");
+		return false;
+	}
+
+	if (modifier & AFBC_SPLIT) {
+		if (!info->is_yuv) {
+			if (drm_format_plane_cpp(format, 0) <=3D 2) {
+				DRM_DEBUG_KMS("RGB formats <=3D 16bpp are not supported with SPLIT\n")=
;
+				return false;
+			}
+		}
+
+		if ((drm_format_horz_chroma_subsampling(format) !=3D 1) ||
+		    (drm_format_vert_chroma_subsampling(format) !=3D 1)) {
+			if (!(format =3D=3D DRM_FORMAT_YUV420_10BIT &&
+			      (map->features & MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT))) {
+				DRM_DEBUG_KMS("Formats which are sub-sampled should never be split\n")=
;
+				return false;
+			}
+		}
+	}
+
+	if (modifier & AFBC_CBR) {
+		if ((drm_format_horz_chroma_subsampling(format) =3D=3D 1) ||
+		    (drm_format_vert_chroma_subsampling(format) =3D=3D 1)) {
+			DRM_DEBUG_KMS("Formats which are not sub-sampled should not have CBR se=
t\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool malidp_format_mod_supported_per_plane(struct drm_plane *plane,
+						  u32 format, u64 modifier)
+{
+	return malidp_format_mod_supported(plane->dev, format, modifier);
+}
+
 static const struct drm_plane_funcs malidp_de_plane_funcs =3D {
 	.update_plane =3D drm_atomic_helper_update_plane,
 	.disable_plane =3D drm_atomic_helper_disable_plane,
@@ -153,6 +268,7 @@ static const struct drm_plane_funcs malidp_de_plane_fun=
cs =3D {
 	.atomic_duplicate_state =3D malidp_duplicate_plane_state,
 	.atomic_destroy_state =3D malidp_destroy_plane_state,
 	.atomic_print_state =3D malidp_plane_atomic_print_state,
+	.format_mod_supported =3D malidp_format_mod_supported_per_plane,
 };
=20
 static int malidp_se_check_scaling(struct malidp_plane *mp,
@@ -406,8 +522,8 @@ static int malidp_de_plane_check(struct drm_plane *plan=
e,
 	fb =3D state->fb;
=20
 	ms->format =3D malidp_hw_get_format_id(&mp->hwdev->hw->map,
-					     mp->layer->id,
-					     fb->format->format);
+					     mp->layer->id, fb->format->format,
+					     !!fb->modifier);
 	if (ms->format =3D=3D MALIDP_INVALID_FORMAT_ID)
 		return -EINVAL;
=20
@@ -469,6 +585,12 @@ static int malidp_de_plane_check(struct drm_plane *pla=
ne,
 			return -EINVAL;
 	}
=20
+	/* SMART layer does not support AFBC */
+	if (mp->layer->id =3D=3D DE_SMART && fb->modifier) {
+		DRM_ERROR("AFBC framebuffer not supported in SMART layer");
+		return -EINVAL;
+	}
+
 	ms->rotmem_size =3D 0;
 	if (state->rotation & MALIDP_ROTATED_MASK) {
 		int val;
--=20
2.7.4

