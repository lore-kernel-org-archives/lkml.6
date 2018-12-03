Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE87FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE1F20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bVvD9XgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FE1F20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbeLCLcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:50 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:52592
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbeLCLct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enKct3KC3V5UYfm2sTvxkow8fEk0Lafv6jFHRzxlbrU=;
 b=bVvD9XgWwiDHp/aXlDZnVpiwe5XST/7s4QSccasLRYPlezWvMA2v/e2oGpSS1q0ZgJNDKOUo9u+KvqNpEiM2RdMwR4QndCwXMm02qpkMHnV3VexRwVhltQ/OyNuWy5LTbSjBo7SDCDlqdBbp7wE3rEJ69Yib5Zd1KJZuiuVd9Rw=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:31:59 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:31:59 +0000
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
Subject: [RFC AFBC 05/12] drm/arm/malidp:- Define a common list of AFBC format
 modifiers supported for DP500, DP550 and DP650
Thread-Topic: [RFC AFBC 05/12] drm/arm/malidp:- Define a common list of AFBC
 format modifiers supported for DP500, DP550 and DP650
Thread-Index: AQHUivvNKeBDbJPJl0CSbSfIg6+TSg==
Date:   Mon, 3 Dec 2018 11:31:59 +0000
Message-ID: <1543836703-8491-6-git-send-email-ayan.halder@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:rNmXtw+P8wXliSeZNShBoPrLzHbCYFi8Uoy61L5SCeAZ5tcUh701ON6j4IQsTfRPllxsS5iK620p8VHidrMGztMeVeM4bV9pCUxSzUwcPStIHBtl8si7ZQS7TlGcOw8RBhkHiD5N5LRpD2bFEV1PBNJCILFKrjX0HZMKgMekDwf1ARQA8WWJMDp3owGY9epfglie1ODoGDWqGFIf6Ummb+8Ii8d9SruclukkCiN4qom94hAEwDCusNuLHyFFJQ7LY3dRFkv5KLULtwufWokO5pmmRv98qRC2Su0WW2/NsaT8HBLW3Ys/XDzeyHeVdm8+5aVoaMXD6Gl4Wi8adGP/wDv4ng+32a1IziULxAyLAUlOfmXEngUY7lQtAJR/211P5OeHquikARH2+j7uT441G81Km4593ch8n+HEjQCQ1vrYSeL0ZHNTyLT9Wux0ruriGQeJmf3dnJ1lrs3drCQU7A==;5:T8KGSln/quWW4hTUuLllUyldzV1Nt6IpuEFie1Nm33lnZBuDzZdbWxuAuCEAR14kDmyGFanR49+EYSeOThbFdw1hrOs+CZ6N+1AG9R8OAIRKTyDvP47Ch8wcA9cwCHL26zMFRckkaVl2QtS2dMbSy9So5oVwf1wKCC/8VPDbVeI=;7:rr2qmZCO02dv8X3KtDC8c3MlI+2/B8vrSVo88VgTSFf7u0jLS7Eor39P+KgKSTHMVuvKyMe/qrdfgEzex8/XKsAzPmpZJZaFbFbjFmxQGrw5eJS1ZN824yoskSDyzNDYsEe2tMxnXc/RLOyvRW2EcQ==
x-ms-office365-filtering-correlation-id: 8bdf68cd-9009-451b-c71e-08d65912f020
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491477918BFC5B487507DCCE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(575784001)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HgcX7mF00IcPhsNg/y5PmuSFyYbpCbxoByE2PFG5zkAn40mdHDr8/+8efh31LD8tSsaJjOrHBXy1+qXesg0V2uuFvUKlPFtVHf71uUNQgRO2ymhOFknt99VANH89WkdOIZdklUz16G360btE6xYWjlut5/eB/vQcZdrgYXo18xCEp0MnkZ3C+1XBsFZ9YmAbUp49TC6hhEInBox2+Mh2NcYgTuWQwk1trY7RNjjdeQjH7saz960NLHXTK0j3ie6wlv9z07fT4ivI9Mwpo+Gs5HVer+bldmPysmlsT4C0n+i3aG0a0rz0UNln14i4u1mT2p48Or5v+PVsud/DIpti/l2iUf6llBa3BEy+86Gwr+w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdf68cd-9009-451b-c71e-08d65912f020
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:31:59.4568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to define a common list of format modifiers supported by each of th=
e Mali
display processors. The difference between DP500 from DP550/650 is that DP5=
00
does not support block split mode (ie AFBC_FORMAT_MOD_SPLIT) and DP550 supp=
orts
YUV420 with split mode. We noted these special cases by defining MALIDP_DEV=
ICE_AFBC_SUPPORT_SPLIT
and AFBC_SUPPORT_SPLIT_WITH_YUV_420_10 for malidp_hw_regmap.features

Also we have defined a set of meaningful macros to shorten the modifier nam=
es

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

Change-Id: I09fba2032a7474e6ce45af230e0ed18fc1f4c1df
---
 drivers/gpu/drm/arm/malidp_drv.c |  8 ++++----
 drivers/gpu/drm/arm/malidp_hw.c  | 30 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/arm/malidp_hw.h  | 20 +++++++++++++++-----
 3 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index 505f316..b8db92f 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -293,8 +293,8 @@ malidp_verify_afbc_framebuffer_caps(struct drm_device *=
dev,
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
@@ -319,8 +319,8 @@ malidp_verify_afbc_framebuffer_size(struct drm_device *=
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
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 87b7b12..55d379b 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -137,6 +137,32 @@ static const struct malidp_layer malidp650_layers[] =
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
@@ -841,7 +867,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES=
] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_S=
PLIT | AFBC_SUPPORT_SPLIT_WITH_YUV_420_10,
 			.n_layers =3D ARRAY_SIZE(malidp550_layers),
 			.layers =3D malidp550_layers,
 			.de_irq_map =3D {
@@ -887,7 +913,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICES=
] =3D {
 			.se_base =3D MALIDP550_SE_BASE,
 			.dc_base =3D MALIDP550_DC_BASE,
 			.out_depth_base =3D MALIDP550_DE_OUTPUT_DEPTH,
-			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ,
+			.features =3D MALIDP_REGMAP_HAS_CLEARIRQ | MALIDP_DEVICE_AFBC_SUPPORT_S=
PLIT,
 			.n_layers =3D ARRAY_SIZE(malidp650_layers),
 			.layers =3D malidp650_layers,
 			.de_irq_map =3D {
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_h=
w.h
index 651558f..27b907f 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -95,7 +95,9 @@ struct malidp_se_config {
 };
=20
 /* regmap features */
-#define MALIDP_REGMAP_HAS_CLEARIRQ	(1 << 0)
+#define MALIDP_REGMAP_HAS_CLEARIRQ				BIT(0)
+#define MALIDP_DEVICE_AFBC_SUPPORT_SPLIT			BIT(1)
+#define AFBC_SUPPORT_SPLIT_WITH_YUV_420_10			BIT(2)
=20
 struct malidp_hw_regmap {
 	/* address offset of the DE register bank */
@@ -390,9 +392,17 @@ static inline void malidp_se_set_enh_coeffs(struct mal=
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
+#define AFBC_MOD_VALID_BITS (AFBC_SIZE_MASK | AFBC_YTR | AFBC_SPLIT | AFBC=
_SPARSE | AFBC_CBR | AFBC_TILED | AFBC_SC)
+
+extern const u64 malidp_format_modifiers[];
=20
 #endif  /* __MALIDP_HW_H__ */
--=20
2.7.4

