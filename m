Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E465C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A5C20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="LwHMXB75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeLCLdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:33:19 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726439AbeLCLcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVT2l6+vvsPZ4FRF/AnKfcGC5jNsldyhxmNg5gGYMt4=;
 b=LwHMXB75d9xH1VZJFPp1kV/DCttiFr30OGb2Xt7eQrX4HI2eTwK6JFHKXkx1tNYjOjNyHaPajNmfAhZYrp0kW1YM4nVqBmjty7FKSjFW7tFkT0jsD895xRycGVIO0Z6n4Sxl35LdczxiegsSo90rI86lqtP6z0E0iKrcljoQD9g=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:02 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:02 +0000
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
Subject: [RFC AFBC 08/12] drm/arm/malidp: Specified the rotation memory
 requirements for AFBC YUV formats
Thread-Topic: [RFC AFBC 08/12] drm/arm/malidp: Specified the rotation memory
 requirements for AFBC YUV formats
Thread-Index: AQHUivvPzQJfI8D9iUy5lgsE4OxoLw==
Date:   Mon, 3 Dec 2018 11:32:02 +0000
Message-ID: <1543836703-8491-9-git-send-email-ayan.halder@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:rCS6QDsbjMR1bnhypOsMzAWLrqAUZyErYekHDohIoXUhdy4zBV9Xsr/F4+9Zn04iywMMh19cJ+DWUpsQsy2EslTaHmQiiKikaLl44dQcAOCQz4osaEJeeyVvtfztqhEMk85jVMV3fCKT2083/iFmqafytkW3EEKx+0h5VOpnzdwr8k8dZkb50Guz71yLl7eJFEGukw9/wgs5u7aFMFckw1GuLQfdsPtdAIGCLslGOMdhS1gQVa5EVlbeJlJTNZizoc17HZW8MNuahjTMnnlAxmFrAFEw5FAPtkaarxaofKjxrS/qebHNOHWaUai6TwlGMlXTGVVbElURphORtthy4RXAedXB11KH3z4rHsEFGN+uHtbGVO2euuXGNcJe+bz2VJDX1yvDbHvkpDI7sEiNpcHDViW4aucmvhqe6sqAfhWcR4pQvDLdCNuXzdID9QsoXR9pzMVurbqyoLcF+rH1Lw==;5:aVwJdj8lwBbI3p5B4dGVy6TMmTsme25IouN5SpyjzDG0EWwEHzQvWa5goIS95yChByx+U/UWM+V2oXNXJ8CH8qBtQwEKnyQxJ7gE0BZM4BVnqzj1htlIYgIVtWGzdJRRyn96FwGbL/pemROhZ6RCRCkZcabE4cOSg48FUOHmocQ=;7:SK8RQ2qtAoVw3IdXg4N+4tAnf7B2jrOdnKSasSII3gOtgtWOF5tQpL+8GZ56AxZyOLz0CFtROHwacFDgvu9q5GmDJ/kG1q/Hixk2jvL0/W98rMVdAYCR3i+wO3nfpKFGktIl342agPid6TXk2hMqww==
x-ms-office365-filtering-correlation-id: 543222fd-5086-44e7-eb0f-08d65912f1ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491DFA0ADF01D56BD2900C1E4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(575784001)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Hvn5Hqr6TT7LEk7FuRwIWa716egxwjmkMfsa599T6oNb69vBhhR7BqO4bkI78JlPXb3vSvnpc9fjBu3V2ZdYHbxus7cJ93kmcblptx9BhIuhYvZOB5Pmm/kNwSekereuBLv2Eag+ifdAvEfX2Zzg/qRcQeRE3P+peczjRaceKcXTyG/Fr6bE3Z3mwxwgIBz+7scfwaT5ICMUMqV9uQKa2kSeuSFyiLB0Tk/SzKdWWmrPfjDNOmSnFMxO/9tsNuPWwMQ4zI7XQBN1Th+FZ6dAkZj7Ht4QwqCXGAp9M5Dbz4bT0qLRmLCb2LORYX3M/ySWMqN6Ibb3nIWaTbXaPkb09eG1BFmU5m5z7rtzUzROOHs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543222fd-5086-44e7-eb0f-08d65912f1ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:02.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
1. DRM_FORMAT_X0L2 (in uncompressed format) does not support rotation in DP=
550.
For DP650, it can rotate upto 16 horizontal lines in the AFBC output buffer=
,
whereas in DP550 (with AFBC), it can rotate upto 8 horizontal lines.
2. DRM_FORMAT_YUV420_10BIT :- It can rotate upto 8 horizontal lines in
dp550 and 16 horizontal lines in DP650.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c     | 101 ++++++++++++++++++++++++++++++++=
----
 drivers/gpu/drm/arm/malidp_hw.h     |   5 +-
 drivers/gpu/drm/arm/malidp_planes.c |   3 +-
 3 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 4a774be..d9866a8 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -375,14 +375,39 @@ static void malidp500_modeset(struct malidp_hw_device=
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
@@ -660,9 +685,9 @@ static void malidp550_modeset(struct malidp_hw_device *=
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
@@ -688,19 +713,77 @@ static int malidp550_rotmem_required(struct malidp_hw=
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
@@ -979,7 +1062,7 @@ const struct malidp_hw malidp_device[MALIDP_MAX_DEVICE=
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
index 52188f0..e89a06a 100644
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
index 0765cee..d0a00ee 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -595,7 +595,8 @@ static int malidp_de_plane_check(struct drm_plane *plan=
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

