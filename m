Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96369C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0E2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="NK3AAZBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C0E2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeLCLdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:33:01 -0500
Received: from mail-eopbgr20052.outbound.protection.outlook.com ([40.107.2.52]:21376
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeLCLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lZ19rx6NW6HVZDz+P5umcZxHL6dLRSBK296k+VrcoQ=;
 b=NK3AAZBAvqvruFhAweKcGtlugwM3Yqlv8O52YVQLDEDX74rCK7k2aVj5Bnq0fal2AIAIjxrfd+LtxsGFxf8jE0zMOCWX8JHpJqcKWuG234WJzmrnKPzBYUfHP+N9gME/HoByF0STdSxhzDexUuIEiiex8SSpRngbX/Y7KD3hB4Q=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:06 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:06 +0000
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
Subject: [RFC v3 AFBC 12/12] drm/arm/malidp: Added support for AFBC modifiers
 for all layers except DE_SMART
Thread-Topic: [RFC v3 AFBC 12/12] drm/arm/malidp: Added support for AFBC
 modifiers for all layers except DE_SMART
Thread-Index: AQHUivvSLomXscPgB0i325VFKObs8Q==
Date:   Mon, 3 Dec 2018 11:32:06 +0000
Message-ID: <1543836703-8491-13-git-send-email-ayan.halder@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:CsVb8wgtaGzlyYKk/imgC6yFLmA4Xdc+WNtWGe7ng3L+CEDoGspLIcHJLT3u/x51BBkprKQ6/frarKBgsIQg07EOiBCxiqCB4d44+Hmj767MGJv1Jw1bzA+fRNmw5sSsjA5ANx56moHwVX9E3i/Ngo4HHOTDfZ+ZrGPB0Azcp3gncoeHl5M+ejWnK8a+dJf/kbSk8j3ptyluLG8r0ePqHalv7i6T9uJKLaMEB1SyUFOVX7AdEM/CnjHTz63YGg/J+YQp0RXLcAwyGpc/9L2KYFzLBPN/anbaa75DvFVdfHy8ThDGIki5ouSycwtzoesGCFeprlV5le+obJdKZ4T3VUDoHitdgydLuPPiS9ffbUPsVPHgo2EOOoCVnyI5Xn+cdD3En3c8g5cL9NOFulyiGzr4gr/8HSAMpqwOHYXpjGYdQH6tAaFJa19JxFJRMF3OwVRAPajme6TuskQNJvHysg==;5:uNHRSODbZzm1hnI0jVxlziiSqIW3Npqqe01xpBw9A/a3fTQJbng+evHdtRcjCDVVp1nE+ogHzfCqKMeR6EYKqLpxbM3yz2my8nzBaARKQcQr/21MbGF/7S6nCGn5ZK34Wj8k5yJSiwI0cPqwtyKl0Z1ZS0pr8XATnfOW4Tddvxs=;7:P802OWlbHRZkzHMA4Dg7iWcru78Tj+VroGuRFSZDQ/GckQFCqJ8a/7ZHxCdnC2hFsqFbcDtqxsUr8V39AIQhobmELvqhxTfdD8a90ixx1RiSmL8lbJ9ybtw+v0yIEGVaT+ZluiIF2YalF42O+olhdg==
x-ms-office365-filtering-correlation-id: 05c9071b-0e5b-45cb-061a-08d65912f463
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB34912A39FD0327E1CBC66EB9E4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(2616005)(44832011)(476003)(6512007)(105586002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Q806ioVTDDfJp/rfq4Irj2xP0cjJTJBeVXzUmd9grXDkSIG37VjmBtCmA4mRMi2xnpY+l2uxKHNNl2XaVzkq6vTafWDLebeg3CRWpXkgdwhUgepwK6ReW5Rle06ss8gixPEkBLeDoGTdWjAQVAqcm0VvujOuZ0t6Xpx/pG1x9KiqVRd1vHj1H6nODqbpk7ghebm4rM6SCIjn9n980bG6IFMfGpS6pGNTLu5WhwgknxKelPjTlNFNHQ/dvwkXfujnbkPK/xt54l0V9B2YaeMYy8iRR38KKBmnnLHwZc31stkMJMlB+T75xK2T1PTtTGXxym+wMd9G2XxDS6FZ3XdIyh/dy8b9S3lZmX6TJFh9Sv8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c9071b-0e5b-45cb-061a-08d65912f463
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:06.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list of modifiers to be supported for each plane has been dynamically g=
enerated
from 'malidp_format_modifiers[]' and 'malidp_hw_regmap->features'.

Changes from v1:-
1. Replaced DRM_ERROR() with DRM_DEBUG_KMS() in malidp_format_mod_supported=
()
to report unsupported modifiers.

Changes from v2:-
1. Removed malidp_format_mod_supported() from the current patch. This has b=
een added
in "PATCH 7/12"
2. Dynamically generate the list of modifiers (to be supported for each pla=
ne) from
'malidp_format_modifiers' and features.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c    |  1 +
 drivers/gpu/drm/arm/malidp_planes.c | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index b2b97db..be45703 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -388,6 +388,7 @@ static int malidp_init(struct drm_device *drm)
 	drm->mode_config.max_height =3D hwdev->max_line_size;
 	drm->mode_config.funcs =3D &malidp_mode_config_funcs;
 	drm->mode_config.helper_private =3D &malidp_mode_config_helpers;
+	drm->mode_config.allow_fb_modifiers =3D true;
=20
 	ret =3D malidp_crtc_init(drm);
 	if (ret)
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index eec0442..01037d0 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -934,6 +934,25 @@ int malidp_de_planes_init(struct drm_device *drm)
 				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
 	int ret, i, j, n;
+	u64 supported_modifiers[MODIFIERS_COUNT_MAX];
+	const u64 *modifiers;
+
+	modifiers =3D malidp_format_modifiers;
+
+	if (!(map->features & MALIDP_DEVICE_AFBC_SUPPORT_SPLIT)) {
+		/*
+		 * Since our hardware does not support SPLIT, so build the list of
+		 * supported modifiers excluding SPLIT ones.
+		 */
+		while (*modifiers !=3D DRM_FORMAT_MOD_INVALID) {
+			if (!(*modifiers & AFBC_SPLIT))
+				supported_modifiers[j++] =3D *modifiers;
+
+			modifiers++;
+		}
+		supported_modifiers[j++] =3D DRM_FORMAT_MOD_INVALID;
+		modifiers =3D supported_modifiers;
+	}
=20
 	formats =3D kcalloc(map->n_pixel_formats, sizeof(*formats), GFP_KERNEL);
 	if (!formats) {
@@ -958,9 +977,14 @@ int malidp_de_planes_init(struct drm_device *drm)
=20
 		plane_type =3D (i =3D=3D 0) ? DRM_PLANE_TYPE_PRIMARY :
 					DRM_PLANE_TYPE_OVERLAY;
+
+		/*
+		 * All the layers except smart layer supports AFBC modifiers.
+		 */
 		ret =3D drm_universal_plane_init(drm, &plane->base, crtcs,
-					       &malidp_de_plane_funcs, formats,
-					       n, NULL, plane_type, NULL);
+				&malidp_de_plane_funcs, formats, n,
+				(id =3D=3D DE_SMART) ? NULL : modifiers, plane_type, NULL);
+
 		if (ret < 0)
 			goto cleanup;
=20
--=20
2.7.4

