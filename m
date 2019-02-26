Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CEAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7535B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Q6BHx77L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfBZQVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:04 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbfBZQVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruVvM0J4P4I2Wu/nCk/AfBsZTtJ5FqLjJ5N0xmyVuII=;
 b=Q6BHx77LrbjPdOqOLlT36/T97y6iFdNIUzMob0YxPKPndMHjYH4us61xS15TPmwc5d8947j/Btcu8Jwsq7kc/+8OouLwifzsY6wF7I08NQnaLsE85iIKiGyDT2cAm2uCNlComV5DXyrtZxDuHvEOXwFT5rw1s/rEIMFQD09ZdwI=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:54 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:53 +0000
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
Subject: [PATCH 02/10] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Topic: [PATCH 02/10] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Index: AQHUze8+QNVmzAWD10CnntYCVatIyA==
Date:   Tue, 26 Feb 2019 16:20:53 +0000
Message-ID: <1551198042-4314-3-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 0b88fb1f-a35d-42e0-32f7-08d69c066157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:whL0hJDX8UK63Rs3W9HwUr9sbXdLjN4foY1lXrAqwuHCIAN1dBtj2SQDjA7ZmbhFUjyxjnVH8UhmJQ9zerojaYJuccmd+scaqPS+6wXJ5Q2aXaTbsL3UGrMEOOYUeospbtPDLccOiqvCm6Ldvqq/MMRQKcZYJCB9pnZ7A/10dL4=
x-microsoft-antispam-prvs: <AM0PR08MB36823CFB6E1AF40671B94DEEE47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: agmNpi8Rppmt3/EubcN/+bsnhcOB8iBumHg3tI4OtTvg2VVlNUHClDE8GSg1/UhCGk5kkrtLl0ZMn50w83et+issJtykS2+Sl14G78QN9EjBPTiIE7UANr82aQ1oIcRQcFCmv6cqrE2uPofhBGjchmOOU3vFLbFw8TtgznQLQhBWT36dz2ulJX7hWe4c7g3Ekm+PCp/GDM3307PLoz7swmixUiZb/ptewvWQ+U41QqDJ1sZVyYWPvhF9SIn6Wu67P1Rt+B0AxYfxLWVXM8z/hXyni5el1a1oeON5UQ0uP/jw7QccDiN8E+eeGeUvn3nOQTT797W2Cm6GdbN8WthDe7J9xQlCmDOOHmqIfHcZ9Ju3cGd9CjDxZWD4YXt73B6WRTdFEuRrE2jAzdPiIuU282rX9crCR+gLLawTEK2wjvM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b88fb1f-a35d-42e0-32f7-08d69c066157
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:53.4484
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

This new format is supported by DP550 and DP650

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 0a3efa5..8681f01 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -229,6 +229,7 @@ const struct drm_format_info *__drm_format_info(u32 for=
mat)
 		{ .format =3D DRM_FORMAT_VUY888,          .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 3, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y410,            .depth =3D 0,  .num_planes =3D=
 1, .cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .i=
s_yuv =3D true },
 		{ .format =3D DRM_FORMAT_AYUV,		.depth =3D 0,  .num_planes =3D 1, .cpp =
=3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .has_alpha =3D true, .is_yuv =3D=
 true },
+		{ .format =3D DRM_FORMAT_XVYU2101010,	.depth =3D 0,  .num_planes =3D 1, =
.cpp =3D { 4, 0, 0 }, .hsub =3D 1, .vsub =3D 1, .is_yuv =3D true },
 		{ .format =3D DRM_FORMAT_Y0L0,		.depth =3D 0,  .num_planes =3D 1,
 		  .char_per_block =3D { 8, 0, 0 }, .block_w =3D { 2, 0, 0 }, .block_h =
=3D { 2, 0, 0 },
 		  .hsub =3D 2, .vsub =3D 2, .has_alpha =3D true, .is_yuv =3D true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index b4fb674..5fed518 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -153,6 +153,7 @@ extern "C" {
=20
 #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:=
Cr 8:8:8:8 little endian */
 #define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:=
Cb:Cr 8:8:8:8 little endian */
+#define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X=
:Cr:Y:Cb 2:10:10:10 little endian */
 #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:=
Y 8:8:8 little endian */
 #define DRM_FORMAT_Y410		fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:=
Cb 2:10:10:10 little endian */
 #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed=
 by U then V, 10:10:10. Non-linear modifier only */
--=20
2.7.4

