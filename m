Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349F9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2ABE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cuRo8iuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfBZQVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:05 -0500
Received: from mail-eopbgr40079.outbound.protection.outlook.com ([40.107.4.79]:57182
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbfBZQVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu81Di/72k+btHLFtW6ZZJlnAqaBLanchGWoz5Xk/dg=;
 b=cuRo8iuKYAqcLaIYNWtQn1DiHaxiWSx2YsTZXJ/5kdbH4+GRJh6SX2uYtz47WTzKPZTna03qraZo0D60ynAzGPoGHieA+QaQVFlS/M/Y85NodeelsJ7P46Bca8/O6wYyTCQoC6BKd+kDSNEEpZKNJ1/hFh6QG5UfP1Zxyq4A67s=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3010.eurprd08.prod.outlook.com (52.134.90.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 16:20:57 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:57 +0000
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
Subject: [PATCH 06/10] drm/arm/malidp: Specified the rotation memory
 requirements for AFBC YUV formats
Thread-Topic: [PATCH 06/10] drm/arm/malidp: Specified the rotation memory
 requirements for AFBC YUV formats
Thread-Index: AQHUze9Bh/b+bVjqx0Wl/9j35oZQcg==
Date:   Tue, 26 Feb 2019 16:20:57 +0000
Message-ID: <1551198042-4314-7-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 444f8a8f-2634-4dcf-ebdc-08d69c06636f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3010;
x-ms-traffictypediagnostic: AM0PR08MB3010:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3010;20:Mc6J51GdRrr5D4mbi+frPBp3OTJImDI28sS4ekkQ1aMdtXxENXgrsGhOUr9MBJT7q5T7wTBear6D2Id9xmDhc223U2hg8twUArmzCezjqhOBTUhR2B799vmGLlZrTn3vJfHK5W1rEJPkFDVseF7ntnyOnjQL9mb2k2c1i0G2Jhs=
x-microsoft-antispam-prvs: <AM0PR08MB3010D2D0A6E086CEAA7A7A79E47B0@AM0PR08MB3010.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(110136005)(53936002)(316002)(6486002)(6512007)(4326008)(6436002)(71200400001)(71190400001)(2906002)(5660300002)(76176011)(86362001)(14454004)(256004)(26005)(386003)(102836004)(2201001)(6506007)(478600001)(72206003)(186003)(105586002)(106356001)(99286004)(446003)(81166006)(2616005)(8676002)(81156014)(476003)(11346002)(305945005)(66066001)(3846002)(6116002)(52116002)(25786009)(36756003)(8936002)(68736007)(50226002)(2501003)(7736002)(97736004)(486006)(44832011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3010;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X8E5ShsqjHTBInLD65s2lVzmWjlRerUKODsFIccEPe9r41JxJB7vLDACr5J29YgW0usZvrchwUvsUg3isMSZbvbKWEi9P1e9U1kqLBu+i2qeNRjFM2P6zu9zCX9Ms6crxkplh6b188KuBNWfG6wi+8JBTuTRr7f/Ur5TSjVfZ/LbTABmIGGGTZNHo9Xo35ah7XOenXhjCutBsOLpyIXUtkv2EI/rwW53b+LIr9XmTWx9meyNTOV3/7psVrMuHGbnLlUECjDrUMF4bId+4AjbFPCuNvHrzLv6oZfdueTRP14TifxTFZOsKm+iBDD5HEeolfVBQiDco71SuWgXn4V3wolosBKYCERMu3eneHh0RZ8bY9u3GsuHYw3rKPFOvoyY9W3K98VUmcZ29piEaAmIAqlmH7fU8Mwxxhzu+IbLtLk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444f8a8f-2634-4dcf-ebdc-08d69c06636f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:56.9278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ayan Kumar Halder <ayan.halder@arm.com>

The newly supported AFBC YUV formats have the following rotation memory
constraints (in DP550/DP650).
1. DRM_FORMAT_VUY888/DRM_FORMAT_VUY101010 :- It can rotate upto 8
horizontal lines in the AFBC output buffer.
2. DRM_FORMAT_YUV420_8BIT :- It can rotate upto 16 horizontal lines
in the AFBC output buffer.

Also some of the pixel formats are specified in bits per pixel (rather
than bytes per pixel), so the calculation needs to take note of this.

Besides there are some difference between DP550 and DP650 and these are
as follows:-
1. DRM_FORMAT_X0L2 (in uncompressed format) does not support rotation in
DP550. For DP650, it can rotate upto 16 horizontal lines in the AFBC
output buffer, whereas in DP550 (with AFBC), it can rotate upto 8
horizontal lines.
2. DRM_FORMAT_YUV420_10BIT :- It can rotate upto 8 horizontal lines in
dp550 and 16 horizontal lines in DP650.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c     | 101 ++++++++++++++++++++++++++++++++=
----
 drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
 drivers/gpu/drm/arm/malidp_planes.c |   3 +-
 3 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 0ac2762..8df12e9 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -380,14 +380,39 @@ static void malidp500_modeset(struct malidp_hw_device=
 *hwdev, struct videomode *
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FU=
NC);
 }
=20
-static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w=
, u16 h, u32 fmt)
+int malidp_format_get_bpp(u32 fmt)
+{
+	int bpp =3D drm_format_plane_cpp(fmt, 0) * 8;
+
+	if (bpp =3D=3D 0) {
+		switch (fmt) {
+		case DRM_FORMAT_VUY101010:
+			bpp =3D 30;
+		case DRM_FORMAT_YUV420_10BIT:
+			bpp =3D 15;
+			break;
+		case DRM_FORMAT_YUV420_8BIT:
+			bpp =3D 12;
+			break;
+		default:
+			bpp =3D 0;
+		}
+	}
+
+	return bpp;
+}
+
+static int malidp500_rotmem_required(struct malidp_hw_device *hwdev, u16 w=
,
+				     u16 h, u32 fmt, bool has_modifier)
 {
 	/*
 	 * Each layer needs enough rotation memory to fit 8 lines
 	 * worth of pixel data. Required size is then:
 	 *    size =3D rotated_width * (bpp / 8) * 8;
 	 */
-	return w * drm_format_plane_cpp(fmt, 0) * 8;
+	int bpp =3D malidp_format_get_bpp(fmt);
+
+	return w * bpp;
 }
=20
 static void malidp500_se_write_pp_coefftab(struct malidp_hw_device *hwdev,
@@ -665,9 +690,9 @@ static void malidp550_modeset(struct malidp_hw_device *=
hwdev, struct videomode *
 		malidp_hw_clearbits(hwdev, MALIDP_DISP_FUNC_ILACED, MALIDP_DE_DISPLAY_FU=
NC);
 }
=20
-static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w=
, u16 h, u32 fmt)
+static int malidpx50_get_bytes_per_column(u32 fmt)
 {
-	u32 bytes_per_col;
+	u32 bytes_per_column;
=20
 	switch (fmt) {
 	/* 8 lines at 4 bytes per pixel */
@@ -693,19 +718,77 @@ static int malidp550_rotmem_required(struct malidp_hw=
_device *hwdev, u16 w, u16
 	case DRM_FORMAT_UYVY:
 	case DRM_FORMAT_YUYV:
 	case DRM_FORMAT_X0L0:
-	case DRM_FORMAT_X0L2:
-		bytes_per_col =3D 32;
+		bytes_per_column =3D 32;
 		break;
 	/* 16 lines at 1.5 bytes per pixel */
 	case DRM_FORMAT_NV12:
 	case DRM_FORMAT_YUV420:
-		bytes_per_col =3D 24;
+	/* 8 lines at 3 bytes per pixel */
+	case DRM_FORMAT_VUY888:
+	/* 16 lines at 12 bits per pixel */
+	case DRM_FORMAT_YUV420_8BIT:
+	/* 8 lines at 3 bytes per pixel */
+	case DRM_FORMAT_P010:
+		bytes_per_column =3D 24;
+		break;
+	/* 8 lines at 30 bits per pixel */
+	case DRM_FORMAT_VUY101010:
+	/* 16 lines at 15 bits per pixel */
+	case DRM_FORMAT_YUV420_10BIT:
+		bytes_per_column =3D 30;
 		break;
 	default:
 		return -EINVAL;
 	}
=20
-	return w * bytes_per_col;
+	return bytes_per_column;
+}
+
+static int malidp550_rotmem_required(struct malidp_hw_device *hwdev, u16 w=
,
+				     u16 h, u32 fmt, bool has_modifier)
+{
+	int bytes_per_column =3D 0;
+
+	switch (fmt) {
+	/* 8 lines at 15 bits per pixel */
+	case DRM_FORMAT_YUV420_10BIT:
+		bytes_per_column =3D 15;
+		break;
+	/* Uncompressed YUV 420 10 bit single plane cannot be rotated */
+	case DRM_FORMAT_X0L2:
+		if (has_modifier)
+			bytes_per_column =3D 8;
+		else
+			return -EINVAL;
+		break;
+	default:
+		bytes_per_column =3D malidpx50_get_bytes_per_column(fmt);
+	}
+
+	if (bytes_per_column =3D=3D -EINVAL)
+		return bytes_per_column;
+
+	return w * bytes_per_column;
+}
+
+static int malidp650_rotmem_required(struct malidp_hw_device *hwdev, u16 w=
,
+				     u16 h, u32 fmt, bool has_modifier)
+{
+	int bytes_per_column =3D 0;
+
+	switch (fmt) {
+	/* 16 lines at 2 bytes per pixel */
+	case DRM_FORMAT_X0L2:
+		bytes_per_column =3D 32;
+		break;
+	default:
+		bytes_per_column =3D malidpx50_get_bytes_per_column(fmt);
+	}
+
+	if (bytes_per_column =3D=3D -EINVAL)
+		return bytes_per_column;
+
+	return w * bytes_per_column;
 }
=20
 static int malidp550_se_set_scaling_coeffs(struct malidp_hw_device *hwdev,
@@ -984,7 +1067,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICE=
S] =3D {
 		.in_config_mode =3D malidp550_in_config_mode,
 		.set_config_valid =3D malidp550_set_config_valid,
 		.modeset =3D malidp550_modeset,
-		.rotmem_required =3D malidp550_rotmem_required,
+		.rotmem_required =3D malidp650_rotmem_required,
 		.se_set_scaling_coeffs =3D malidp550_se_set_scaling_coeffs,
 		.se_calc_mclk =3D malidp550_se_calc_mclk,
 		.enable_memwrite =3D malidp550_enable_memwrite,
diff --git a/drivers/gpu/drm/arm/malidp_hw.h b/drivers/gpu/drm/arm/malidp_h=
w.h
index 0859302..207c3ce 100644
--- a/drivers/gpu/drm/arm/malidp_hw.h
+++ b/drivers/gpu/drm/arm/malidp_hw.h
@@ -184,7 +184,8 @@ struct malidp_hw {
 	 * Calculate the required rotation memory given the active area
 	 * and the buffer format.
 	 */
-	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h, u32 =
fmt);
+	int (*rotmem_required)(struct malidp_hw_device *hwdev, u16 w, u16 h,
+			       u32 fmt, bool has_modifier);
=20
 	int (*se_set_scaling_coeffs)(struct malidp_hw_device *hwdev,
 				     struct malidp_se_config *se_config,
@@ -326,6 +327,8 @@ void malidp_se_irq_fini(struct malidp_hw_device *hwdev)=
;
 u8 malidp_hw_get_format_id(const struct malidp_hw_regmap *map,
 			   u8 layer_id, u32 format, bool has_modifier);
=20
+int malidp_format_get_bpp(u32 fmt);
+
 static inline u8 malidp_hw_get_pitch_align(struct malidp_hw_device *hwdev,=
 bool rotated)
 {
 	/*
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index 79e00bf..3dc8a6f 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -597,7 +597,8 @@ static int malidp_de_plane_check(struct drm_plane *plan=
e,
=20
 		val =3D mp->hwdev->hw->rotmem_required(mp->hwdev, state->crtc_w,
 						     state->crtc_h,
-						     fb->format->format);
+						     fb->format->format,
+						     !!(fb->modifier));
 		if (val < 0)
 			return val;
=20
--=20
2.7.4

