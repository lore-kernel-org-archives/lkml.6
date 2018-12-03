Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC889C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E7620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Lk8pboFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E7620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeLCLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:52 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:52592
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbeLCLcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6drDhfkvq8nS3oZxav6jhfnEcxitoDa29CcdfJF95I=;
 b=Lk8pboFDQbvVUI9hxqx6NS1ZEiECNZg3x9L7CbyfmLLMprSSApfjoqUkhtvyo/PMWcRyJ2wS0xelBdP8tGC5VDaNFywzELipIAcWXHIr2TmxNM8eYWbh5Q8REgrq0qqrKKnmKoh6/aU8Pl3GkqjXij6wSOp2vZyJ738vQ2i5hIQ=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:32:00 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:32:00 +0000
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
Subject: [RFC AFBC 06/12] drm/arm/malidp:- Added support for new YUV formats
 for DP500, DP550 and DP650
Thread-Topic: [RFC AFBC 06/12] drm/arm/malidp:- Added support for new YUV
 formats for DP500, DP550 and DP650
Thread-Index: AQHUivvODNv595J0pU+YPcE059kyEA==
Date:   Mon, 3 Dec 2018 11:32:00 +0000
Message-ID: <1543836703-8491-7-git-send-email-ayan.halder@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:7SwkAWzQ7mi0Ht704PRLrDUzkVfUtOkg63EXBtqHu5NNI5qvcUIxDCLiUOg9GWxRIUYKElK5VUkmKTje+uw3CV8S0PvBdEAZ5yJBl9nouRaS6Aeiv44Nsl9U52N61+Fzgah3ZMiGt1veTU/5NRgIPj8V42cPvP4LSF/jdG8B4PN6kpIQMIsJGOt3+7nImlZgZF0y4RX5RPSUkSLcRhXCI4Kj0H4WMPYXsvQyUEz58Uiu58UdqFQEe7EbDYRrvEridLkjJZyWada/Fzt4FGMAlYAfxIUENW0J4h68khPCm3SBeJpH4pcW3ofULeUc538WYCMHcRe76fBQO3X3P/JMA6Xg0yBfEyRb+pPIxivPqi6BqIMdfAonetlejoSQtc2NkSBFLWA7VFlhwkQKwe9Co48uNh2IXFlotyCqRWfJ5v27HOPB25GxlBF+VxNPCWZVRTmiRcAJr8PK6930cY3q0A==;5:UBMOOopCUizkpgi7uBUdTJYnA9UdGm62ozlyH/0jFJ8VQrkNHsDjU8WvWaPI/t49G391jMbdTFWrlU9c68JB14jLkXooefwBFwRmYNT2I7Tv65RfooGmzXV2pvIrgG0X5/z3pB9kd5j+BGsHYqVYEmUk3VyIJVHoUz2Do/D4Ir8=;7:vtdlW3XW/APY8GN6mS6LF1UWT7dh00Z3seLhpDpAwKpc0aL9hNi2q2N+MV1Q+Op9uRp9QRNMW6ljZ9LI19qoxTZGuS+Qfl1vea7DqK0DZcBDWpLhoKTEobObxh2Yxb7QYI2yJYtd4OWBJsknDLOlyQ==
x-ms-office365-filtering-correlation-id: ccb35a34-a322-4e35-6537-08d65912f0af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491CCBCA71E984BFDEC5F4AE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(14444005)(575784001)(966005)(2616005)(44832011)(476003)(6512007)(6306002)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 8e3avU2jIBZWCZ9uZ+qXH1RCkWpnEXYw5l2UbY0Wq1dDazXXl8oamz+M8W9Yuupm3hNPIL39mLfm3UiIaB9sNJbzhAhWBcIbSuFH3acICqYWyf9BBv9k8efdE329+phufX5TBA7S2CseerkYcctrmoYLa6lA3hxZvNKJIXStYUMx3RUnsqYWJtbsTXSQP2Av+3u3crc71E/IaYJmmO4jMLvoLnIlTHXibGy1vVnlYjsTpe6FQalR3wVOPqKxv2l/STK4g+F991JPuodeLxcvk1nMu1kxHvFgnM6Fv2/s1BcXAgqeb/0RdbsS7knsBCOeSTpZNSuQA9GCuqG89OAwMH7pzoO4d9IQK5YVQzTuEPI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb35a34-a322-4e35-6537-08d65912f0af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:32:00.5366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added some new formats to be supported on DP500/DP550/DP650.

Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>

Depends on :- https://patchwork.kernel.org/patch/10460063/
---
 drivers/gpu/drm/arm/malidp_hw.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_h=
w.c
index 55d379b..25ac5890 100644
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

