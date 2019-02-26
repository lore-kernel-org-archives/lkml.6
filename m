Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED682173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Ji5QTJKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfBZQVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:21:39 -0500
Received: from mail-eopbgr10070.outbound.protection.outlook.com ([40.107.1.70]:51841
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728630AbfBZQVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8L3Y06Z0Qj5UP8Z0QDnHomdNqoRgwY9gUjLk0/QxhY=;
 b=Ji5QTJKKQuYJg+JRT2ajcRml1xbgKm6Gq7oSJ2IjcNCfkHFvbgdZLOjQ/YRvwobXd3RidtWToTWlM8xCo71EZRN1xKZevoF4sh5Pu7yuIsJUqefCb44UprLc2UvJn3J9GzNGA0I+ioyx4WG8yZL0fXv4R2QjhYkzK9LErEm8etw=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3682.eurprd08.prod.outlook.com (20.178.21.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Tue, 26 Feb 2019 16:20:55 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::910a:5553:5cd9:6b41%4]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 16:20:55 +0000
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
Subject: [PATCH 04/10] drm/arm/malidp:- Added support for new YUV formats for
 DP500, DP550 and DP650
Thread-Topic: [PATCH 04/10] drm/arm/malidp:- Added support for new YUV formats
 for DP500, DP550 and DP650
Thread-Index: AQHUze9AwBfeA4eEU0aDv1m3i68G9w==
Date:   Tue, 26 Feb 2019 16:20:55 +0000
Message-ID: <1551198042-4314-5-git-send-email-ayan.halder@arm.com>
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
x-ms-office365-filtering-correlation-id: 84d9ef6b-cd91-43c3-3560-08d69c06625f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3682;
x-ms-traffictypediagnostic: AM0PR08MB3682:
nodisclaimer: True
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3682;20:4Bkdvz1w+xEhxa/Lpt4G4aXHndvIiW96ziAUUkHqMjoTj5Bho5us9SCxZx2PQXt9k5yB5aPuOFTc5rrlZ/rgNk50R/oAYAcKQPBdMB6epq8qbQmViGcWLKdETMSCwIrZrGWzWBOLMyE3KtfWCy6aoW+NBsWBX5cuSuCm/FNj1RU=
x-microsoft-antispam-prvs: <AM0PR08MB3682F44072659E72232013FDE47B0@AM0PR08MB3682.eurprd08.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(6116002)(8936002)(50226002)(76176011)(2906002)(99286004)(36756003)(25786009)(2501003)(97736004)(52116002)(3846002)(4326008)(68736007)(11346002)(256004)(14444005)(6486002)(446003)(6436002)(478600001)(44832011)(2616005)(486006)(476003)(26005)(105586002)(186003)(53936002)(6512007)(66066001)(7736002)(305945005)(102836004)(316002)(110136005)(71190400001)(81156014)(81166006)(71200400001)(386003)(6506007)(14454004)(5660300002)(106356001)(2201001)(86362001)(72206003)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3682;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K7GNTMgCv9GU9ie+zCym7pCsiD+PKs2FOgXq2fkk62rhV+4nf1A8I90246qR6XdM3RtD3kCvz15aZlfaq8IbobS1cl2AU2BEDwMnDmsK1w4rPWDE5tbpi1ITCVhIZbkHnhFEbGrBLj1/LuazbPGU//YqI1jl5KuQ1rCaBkXr+QSrVU74hfueOS9zDAHRhLdkNsGpy7e7GDG9LCO9Bdry8Pjl/HRv6Y2XfYvX4EpPldPCby2wFryZvYoAnPQwzZgcrfGPKusf7CKUs2ZZewYLXNzFXH3/I0hK5LeBlpmx8FiHn/eu0pu1mgT1b999Bl6L1PgY5crLqCidmBW+hOrRXQskK9EIVgn2Uh9AHStOqPZ58HahIvYzIEVkR+MRypdQX+RRkIIS721hv3UHULN9Opa3ldp0N/U0AofeE+1rtrk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d9ef6b-cd91-43c3-3560-08d69c06625f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 16:20:55.1756
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

We have added support for some AFBC only pixel formats like :-
DRM_FORMAT_YUV420_8BIT (single plane YUV 420 8 bit format)
DRM_FORMAT_VUY888 (single plane YUV 444 8 bit format)
DRM_FORMAT_VUY101010 (single plane YUV 444 10 bit format)
DRM_FORMAT_YUV420_10BIT (single plane YUV 420 10 bit format)

Generally, these formats are supported by our hardware using the same
hw-ids as the equivalent multi plane pixel formats.

Also we have added support for XYUV 444 8 and 10 bit formats

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 64c2ca3..b4a0e11 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -49,6 +49,12 @@ static const struct malidp_format_id malidp500_de_format=
s[] =3D {
 	{ DRM_FORMAT_YUYV, DE_VIDEO1, 13 },
 	{ DRM_FORMAT_NV12, DE_VIDEO1 | SE_MEMWRITE, 14 },
 	{ DRM_FORMAT_YUV420, DE_VIDEO1, 15 },
+	{ DRM_FORMAT_XYUV8888, DE_VIDEO1, 16 },
+	/* These are supported with AFBC only */
+	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1, 14 },
+	{ DRM_FORMAT_VUY888, DE_VIDEO1, 16 },
+	{ DRM_FORMAT_VUY101010, DE_VIDEO1, 17 },
+	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1, 18 }
 };
=20
 #define MALIDP_ID(__group, __format) \
@@ -74,11 +80,25 @@ static const struct malidp_format_id malidp500_de_forma=
ts[] =3D {
 	{ DRM_FORMAT_ABGR1555, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4,=
 1) }, \
 	{ DRM_FORMAT_RGB565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 2=
) }, \
 	{ DRM_FORMAT_BGR565, DE_VIDEO1 | DE_GRAPHICS1 | DE_VIDEO2, MALIDP_ID(4, 3=
) }, \
+	/* This is only supported with linear modifier */	\
+	{ DRM_FORMAT_XYUV8888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) },\
+	/* This is only supported with AFBC modifier */		\
+	{ DRM_FORMAT_VUY888, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 0) }, \
 	{ DRM_FORMAT_YUYV, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 2) },	\
+	/* This is only supported with linear modifier */ \
 	{ DRM_FORMAT_UYVY, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 3) },	\
 	{ DRM_FORMAT_NV12, DE_VIDEO1 | DE_VIDEO2 | SE_MEMWRITE, MALIDP_ID(5, 6) }=
,	\
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_YUV420_8BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 6) }, \
 	{ DRM_FORMAT_YUV420, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(5, 7) }, \
-	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}
+	/* This is only supported with linear modifier */ \
+	{ DRM_FORMAT_XVYU2101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_VUY101010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 0)}, \
+	{ DRM_FORMAT_X0L2, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 6)}, \
+	/* This is only supported with AFBC modifier */ \
+	{ DRM_FORMAT_YUV420_10BIT, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}, \
+	{ DRM_FORMAT_P010, DE_VIDEO1 | DE_VIDEO2, MALIDP_ID(6, 7)}
=20
 static const struct malidp_format_id malidp550_de_formats[] =3D {
 	MALIDP_COMMON_FORMATS,
--=20
2.7.4

