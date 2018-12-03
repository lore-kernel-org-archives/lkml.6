Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99B920834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="VoT1TVLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99B920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbeLCLdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:33:46 -0500
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:42465
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726238AbeLCLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrUs/D63bVzu/tJ1hs067Gl1Vd6nbkROUbmQaMHsVEY=;
 b=VoT1TVLPmahnqOfEAlpAEz34OEhWTLvQha1Ce4TWnjzM7cZtvpmuHeywNgyyZbyy0cRoHbhQpcXRsMOiUEJpsmHlVXJfSj/4jRKq0eOUyi6lus88soQZg+MZKToavsIrBN8AE2quERulOFOSG81rCqgz31Z9GxWYAfO2J/QKCkk=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3268.eurprd08.prod.outlook.com (52.134.94.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Mon, 3 Dec 2018 11:32:01 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:01 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
CC:     nd <nd@arm.com>
Subject: [RFC AFBC 07/12] drm/arm/malidp: Define the constraints on each
 supported drm_fourcc format for the AFBC modifiers.
Thread-Topic: [RFC AFBC 07/12] drm/arm/malidp: Define the constraints on each
 supported drm_fourcc format for the AFBC modifiers.
Thread-Index: AQHUivvOJrCqCbxuBEiiM4l9ViXVPA==
Date:   Mon, 3 Dec 2018 11:32:01 +0000
Message-ID: <1543836703-8491-8-git-send-email-ayan.halder@arm.com>
References: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
In-Reply-To: <1543836703-8491-1-git-send-email-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0279.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::27) To AM0PR08MB3891.eurprd08.prod.outlook.com
 (2603:10a6:208:109::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.55]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3268;6:JFfs3o75eVlVZY6OcK7a5ayZ2gQhRDzXMA3mzTH2r2vaNuMkHu7L2Kf+tMcALSm5VrmNPEz23suRUdDIYMXbmy4wN97My7SuL8tA96bDZo5wCTbqNSJgbTygu7Dvy4nWSfr5NgMkwAJE1Gn8Rr+UHRT5ksfY6zShcc5o12jiwz9AulHVQBoXd8Z6xTpQ05TB+mxO7/czhPVnqdkA9LASZvI2eti2WnElXxu0CDbkeJT7JCqbFJkQIyyWm4PIbJw7nRi0fXR0bzxnAwZdxDgBBqjgi3Qq/fCUAFmb7Y4/VV31ZbaV2jqawwnh93iHBLD3RYqCYW9XNO8XnC23PKWaWd2JO2THkNMUwzVObpoDFBz0I9R4DeHv9pBFH3sGGzpH3/69gZjZwbQhhTdE9J1cZSTGMF3ECUxX2ZHrJ30D0biwVcFZErXVpPYTQLz/Rl6qE+12PMXPFs4QxmCCUShRgA==;5:EEzrpv3lMLYYbkAVXxgd5QR7FcqFvQaEtvsMyjdhX062UmZ5YwSeRg8P1aJXxIKdhJSIwRfi5cv4bEcg4+pIx2zAjBAUb1h4kD/YM8s95Jxa++tkw23EPVhV1/J6GClhxYvTcu6rjIIGjdzSCg7KuaksJi+pVYP8+oKaPCj/hDo=;7:7sIfua16uG6xdLSPsd400NHhJSz5BR4X/jzoQF58eYJicyfrM1k/Pz+TW3YicE0M9izFeHgyu062nkKJCC89NsBqw2Xb0JNG6DpZVTGdwgamHhVi1U29DkWORnJWR85UP+JQPVRsHF25LDOXumzdCA==
x-ms-office365-filtering-correlation-id: 3a128bfa-6cf4-4b9e-cdaf-08d65912f159
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3268;
x-ms-traffictypediagnostic: AM0PR08MB3268:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3268D18F5345476C64664D05E4AE0@AM0PR08MB3268.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231455)(999002)(944501493)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3268;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3268;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(346002)(376002)(366004)(396003)(39860400002)(199004)(189003)(2906002)(71190400001)(71200400001)(76176011)(26005)(106356001)(6506007)(186003)(66066001)(102836004)(5660300001)(386003)(575784001)(256004)(110136005)(86362001)(6436002)(476003)(2616005)(2201001)(11346002)(6486002)(4744004)(99286004)(8936002)(8676002)(81166006)(81156014)(7416002)(68736007)(52116002)(316002)(36756003)(105586002)(53936002)(4326008)(6512007)(217873002)(44832011)(3846002)(6116002)(446003)(2501003)(14444005)(478600001)(72206003)(25786009)(305945005)(7736002)(14454004)(97736004)(486006)(921003)(1121003)(309714004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3268;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2xxWgvOolQpZkqZni7o5MT8wL/X80sIC5HQDY4DArbQa6VOOqLvZNEosBPrGCxXkJOrKMNDM8AaONtyvS5LhbubPxz/Hcq3shx9EMvIRvBal8r1CB5+3LTaiRtjTPwN9qxlgmuCVcI4pzvCddnDLgovbPsg8vZJp61UGd8A0+f6GbM9vyhMvKNvO0nuy5UZ7mUm/dgBXy/L5PswAN4fUUqV8xn4hBURhEfBE1sWepBEChGanLLpQDFaGr65E3pk5/v5xrMCq23VkjPTtYXf2S1wi/nik2/O8HrNgOE+CmsD5KYkBRq/Mi2+POmjrmHWLHQ1aerIaHlxepathh5YwOWv0z+0DBfbkiP6XzJSRrG4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a128bfa-6cf4-4b9e-cdaf-08d65912f159
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:01.4822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3268
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraints are as follows (for Mali-DP 500, 550, 650) :-

1. AFBC is not supported for the formats defined in malidp_hw_format_is_lin=
ear_only()

2. Some of the formats are supported only with AFBC modifiers. Thus we have
introduced a new function 'malidp_hw_format_is_afbc_only()' which verifies =
the same.

3. AFBC_FORMAT_MOD_YTR needs to be provided for any RGB format.

4. Formats <=3D 16bpp cannot support AFBC_FORMAT_MOD_SPLIT.

5. CBR should not be set for non-subsampled formats.

6. SMART layer does not support framebuffer with AFBC modifiers.
Return -EINVAL for such a scenario.

7. AFBC_FORMAT_MOD_YTR is not supported for any YUV formats.

8. Formats which are subsampled cannot support AFBC_FORMAT_MOD_SPLIT. Howev=
er in
DP550, YUV_420_10BIT is supported with AFBC_FORMAT_MOD_SPLIT. This feature =
has
been identified with MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT.

9. In DP550 and DP650, for YUYV, the hardware supports different format-ids=
 to
be used with and without AFBC modifier. We have used the feature
'MALIDP_DEVICE_AFBC_YUYV_USE_422_P2' to identify this characteristic.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c    |  23 +------
 drivers/gpu/drm/arm/malidp_drv.h    |   6 ++
 drivers/gpu/drm/arm/malidp_hw.c     |  71 +++++++++++++++++++--
 drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
 drivers/gpu/drm/arm/malidp_mw.c     |   2 +-
 drivers/gpu/drm/arm/malidp_planes.c | 124 ++++++++++++++++++++++++++++++++=
+++-
 6 files changed, 199 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index b8db92f..2f0b553 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -264,29 +264,8 @@ static bool
 malidp_verify_afbc_framebuffer_caps(struct drm_device *dev,
 				    const struct drm_mode_fb_cmd2 *mode_cmd)
 {
-	const struct drm_format_info *info;
-
-	if ((mode_cmd->modifier[0] >> 56) !=3D DRM_FORMAT_MOD_VENDOR_ARM) {
-		DRM_DEBUG_KMS("Unknown modifier (not Arm)\n");
+	if (malidp_format_mod_supported(dev, mode_cmd->pixel_format, mode_cmd->mo=
difier[0]) =3D=3D false)
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
index 25ac5890..4a774be 100644
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
@@ -887,7 +889,10 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICE=
S] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_S=
PLIT | AFBC_SUPPORT_SPLIT_WITH_YUV_420_10,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
+				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
 			.n_layers =3D ARRAY_SIZE(malidp550_layers),
 			.layers =3D malidp550_layers,
 			.de_irq_map =3D {
@@ -933,7 +938,9 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES=
] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_S=
PLIT,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ |
+				    MALIDP_DEVICE_AFBC_SUPPORT_SPLIT |
+				    MALIDP_DEVICE_AFBC_YUYV_USE_422_P2,
 			.n_layers =3D ARRAY_SIZE(malidp650_layers),
 			.layers =3D malidp650_layers,
 			.de_irq_map =3D {
@@ -982,19 +989,73 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVIC=
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
+
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
index 27b907f..52188f0 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -97,7 +97,8 @@ struct malidp_se_config {
 /* regmap features */
 #define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
 #define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
-#define AFBC_SUPPORT_SPLIT_WITH_YUV_420_10			BIT(2)
+#define MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT		BIT(2)
+#define MALIDP_DEVICE_AFBC_YUYV_USE_422_P2			BIT(3)
=20
 struct malidp_hw_regmap {
 	/* address offset of the DE register bank */
@@ -323,7 +324,7 @@ int malidp_se_irq_init(struct drm_device *drm, int irq)=
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
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_m=
w.c
index 91472e5..0484744 100644
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
index cd60f73..0765cee 100644
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
@@ -145,6 +147,117 @@ static void malidp_plane_atomic_print_state(struct dr=
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
+		/* However these pixel formats need to be supported with
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
+	while (*modifiers !=3D DRM_FORMAT_MOD_INVALID) {
+		if (*modifiers =3D=3D modifier) {
+			/* SPLIT buffers must use SPARSE layout */
+			if (WARN_ON_ONCE((modifier & AFBC_SPLIT) && !(modifier & AFBC_SPARSE)))
+				return false;
+
+			/* CBR only applies to YUV formats, where YTR should be always 0 */
+			if (WARN_ON_ONCE((modifier & AFBC_CBR) && (modifier & AFBC_YTR)))
+				return false;
+
+			break;
+		}
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
+		DRM_DEBUG_KMS("Given format (0x%x) is supported is linear mode only\n", =
format);
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
+			     (map->features & MALIDP_DEVICE_AFBC_YUV_420_10_SUPPORT_SPLIT))) {
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
@@ -153,6 +266,7 @@ static const struct drm_plane_funcs malidp_de_plane_fun=
cs =3D {
 	.atomic_duplicate_state =3D malidp_duplicate_plane_state,
 	.atomic_destroy_state =3D malidp_destroy_plane_state,
 	.atomic_print_state =3D malidp_plane_atomic_print_state,
+	.format_mod_supported =3D malidp_format_mod_supported_per_plane,
 };
=20
 static int malidp_se_check_scaling(struct malidp_plane *mp,
@@ -406,8 +520,8 @@ static int malidp_de_plane_check(struct drm_plane *plan=
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
@@ -469,6 +583,12 @@ static int malidp_de_plane_check(struct drm_plane *pla=
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

