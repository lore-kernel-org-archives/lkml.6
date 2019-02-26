Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7D6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63272184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MCNGuFz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfBZQVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:17 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727663AbfBZQVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwqI9k+TLX3Wnu6gI4iZJqhjO4mR2/DPIObe9ce62vI=;
 b=MCNGuFz+xz2S4FhImfe57NW1MpIW+EVFkYbTVbeoze3x3fFaAPVJXS35caR+cPh5iRQfoXbczad3+xKWJf4P7DjqZCwIS1bPntnA3WbSPeMaWH/xlI6SKmWkjmTonY5r3zrHbYqnz0NE0Gw74kELCMZDNNvyS2vZFrsunmNlpA0=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:21:00 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:21:00 +0000
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
Subject: [PATCH v3 10/10] drm/arm/malidp: Added support for AFBC modifiers for
 all layers except DE_SMART
Thread-Topic: [PATCH v3 10/10] drm/arm/malidp: Added support for AFBC
 modifiers for all layers except DE_SMART
Thread-Index: AQHUze9DveUn/JDwq0e161+Jd0pH1w==
Date:   Tue, 26 Feb 2019 16:21:00 +0000
Message-ID: <1551198042-4314-11-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: efc12a43-7e96-4075-c73f-08d69c066576
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:uoESJx+v4GNtI1B3B+ghWq1ySgfZ0U9F+dexkKlFp0n+w7s8+3YJstxLIf1fuACXKAMuaQulg8TVEpqL41N5W8390crfyHZdnl5mprS75UHUZumK8Vh6dJFiFapk8go9Qvj2YNnVcEtmDh06wFkqcsyjsYv4idOUqVgJkM4tDGQ=
x-microsoft-antispam-prvs: <AM0PR08MB3682EB72D57D35A8C0861F86E47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lqqlbzY8VwFt4yRTGkNXu7K9hvQl19k8w08ATnAcEscLt7XjHIO99jVu343tEttDrIoDG+chfbKC9F4B6fYT/plt504XZECYpv5y5wUuj/Ev4gSopkTqURUui44SP4k6VD4zQt100ftX3VmCufRc/qL+jvNj03PmprfIgVvmZfQoZTHVIWWseaFJE84owVtGpkTTZ4kRdPnfhF9r5TK6aRL3MI6+agpank+C99T/fcZoL8AASqZ8y9Ted1deUCc32eVjNP7wANGvoJUlwfpQu8VZutsIYU9DZ7NZvWMfv2q/JwrdxZld1hsaWgYYw9ncIycXtQJayvNlUYUXkNQEbeJCwzHFz7Fp47sqeHp4ZERFX+s7S9l+voC/taIGPNaRXIQYd+YPl23xEqsFibV7dD+S6Qv9PfZYPfVO4s6aD0M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc12a43-7e96-4075-c73f-08d69c066576
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:21:00.3602
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
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_drv.c    |  1 +
 drivers/gpu/drm/arm/malidp_planes.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_=
drv.c
index 4106f5d..21725c9 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -391,6 +391,7 @@ static int malidp_init(struct drm_device *drm)
 	drm->mode_config.max_height =3D hwdev->max_line_size;
 	drm->mode_config.funcs =3D &malidp_mode_config_funcs;
 	drm->mode_config.helper_private =3D &malidp_mode_config_helpers;
+	drm->mode_config.allow_fb_modifiers =3D true;
=20
 	ret =3D malidp_crtc_init(drm);
 	if (ret)
diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/mali=
dp_planes.c
index 044bf7f..d42e0ea 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -939,7 +939,26 @@ int malidp_de_planes_init(struct drm_device *drm)
 				  BIT(DRM_MODE_BLEND_PREMULTI)   |
 				  BIT(DRM_MODE_BLEND_COVERAGE);
 	u32 *formats;
-	int ret, i, j, n;
+	int ret, i =3D 0, j =3D 0, n;
+	u64 supported_modifiers[MODIFIERS_COUNT_MAX];
+	const u64 *modifiers;
+
+	modifiers =3D malidp_format_modifiers;
+
+	if (!(map->features & MALIDP_DEVICE_AFBC_SUPPORT_SPLIT)) {
+		/*
+		 * Since our hardware does not support SPLIT, so build the list
+		 * of supported modifiers excluding SPLIT ones.
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
@@ -964,9 +983,15 @@ int malidp_de_planes_init(struct drm_device *drm)
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
+				(id =3D=3D DE_SMART) ? NULL : modifiers, plane_type,
+				NULL);
+
 		if (ret < 0)
 			goto cleanup;
=20
--=20
2.7.4

