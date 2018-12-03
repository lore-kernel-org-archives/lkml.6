Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF48FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A705E20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="eUyuGtKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A705E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeLCLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:32:45 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:52592
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbeLCLcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9JsVZ5oiolUFI99c2zQw7ujCuKqwNxn2TN5ijSmAbk=;
 b=eUyuGtKY60yBkCTCQwN8ZI9u/zYu02jwrX9VbG3ZworiX6Fnu98kopAHDrVpgQ/JMO1wlxz+xT3NXDP6YkQVuGC0lLQuT6OFV+fkTQW1WWLWce8y3XkMeIv95R00L8iUhOSJ01KwhuH0XEhrfEroD06qBewLFZ6FOjwZcLll9WI=
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com (20.178.82.147) by
 AM0PR08MB3491.eurprd08.prod.outlook.com (20.177.108.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.18; Mon, 3 Dec 2018 11:31:56 +0000
Received: from AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa]) by AM0PR08MB3891.eurprd08.prod.outlook.com
 ([fe80::896a:710:2a8c:e2fa%6]) with mapi id 15.20.1382.020; Mon, 3 Dec 2018
 11:31:56 +0000
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
Subject: [RFC AFBC 02/12] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Topic: [RFC AFBC 02/12] drm: Added a new format DRM_FORMAT_XVYU2101010
Thread-Index: AQHUivvMw0fkI81aLk+YLdXH7Jrm8w==
Date:   Mon, 3 Dec 2018 11:31:56 +0000
Message-ID: <1543836703-8491-3-git-send-email-ayan.halder@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3491;6:E1XxOdVAQf7gGOzmnaZzkme9qaT2RmwazknFQCglaDO9MF0WvRa+RKJAS1sJzsUtBIdsy3AScstIex6a7vGjIruBVp9Ae+GVaoWivqqk+HpIc+yCTZQcub+tbE3ZawDNypsL5m+4Dv73i2HlWSydJ9c1DTwL/y4oWDElx3muteaH5+2E5KGTDGSvBvso2WAmBzXiVz9K39q7JdldKtkLeqWU6a4OfSxwa1bhfYtSoOXzI+ce25jHR0enxV2UFE8d5LB2e+qfVVGjBUEIoYr0uIoRKbsI3Y+hUHpJx+bRdprz4KHRrOPS6JHCw9r1v9cZeq1FJv61gLAwtB46m+WwlHwPGzo/SHPbzX4OYZQ1BXn0ctnk09B7TKo80UIBWECQZWgsCb9JLfSodO8yVr1bUvMKGzaBTRpLkLk41PwENIKMUIrXXfBCRUoQ/YKaQbP2JMXF+tBV69KxLmfFma1k+g==;5:Zu33OZ1UJ2ySMiAtSn/cMlIlSHM/GEcGdTsYuTjl/XyR1uZ/VRlh5JTTvVPOM4Eb8Mo3PKPNn8KaigcSftazSau3fr+ju4k3zK+aPg2fsTdkKnQZquln3MZP4je+BaJR9Cr89WUeRDW4qHNgxnKcodVgUfAdnG3GAFsPCqZY30g=;7:ikK2ZfXo719x/cfSTsZez40AC3jJN9F8Jq60baYNhRVf4HOxCTOaZTvMqrCdn48PWpuyGJmfVrROZZEjZjZBNjhhKEkU5WidhQQfVyODrClseuiIJtOlQk90yCQYsdLIZqG5RmbNvzBCY+l7K64XsA==
x-ms-office365-filtering-correlation-id: 4295012c-d6ec-479c-47f6-08d65912ee64
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3491;
x-ms-traffictypediagnostic: AM0PR08MB3491:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB3491B8222F8879B0FEBABE8BE4AE0@AM0PR08MB3491.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231455)(999002)(944501493)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3491;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3491;
x-forefront-prvs: 08756AC3C8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(366004)(199004)(189003)(99286004)(4326008)(71190400001)(97736004)(36756003)(71200400001)(106356001)(6486002)(68736007)(72206003)(256004)(14454004)(66066001)(478600001)(7416002)(5660300001)(81166006)(8936002)(7736002)(25786009)(2201001)(81156014)(305945005)(3846002)(6116002)(26005)(102836004)(316002)(186003)(6436002)(11346002)(486006)(2906002)(2501003)(8676002)(2616005)(44832011)(476003)(6512007)(105586002)(217873002)(53936002)(52116002)(446003)(386003)(6506007)(86362001)(110136005)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3491;H:AM0PR08MB3891.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5yCdjpAfE7gA2AJIraoYbN3wX1KE3Y9sEXd73iM9cobXBWsHJal00y2bdmnI4vxxyrovDkvqTnvrzi0ZPUg9bw41+U7v8RQqMvD88O1TaW6QkFR87+uW3be9HOVy9YYJN2DwvEFlmFAPk/mxV+jYK3hF+JejnSLVCKk9J1xMV54TTDu5MewU3u+wlyJuuWDaqwDec1qVOOLMNFuTPxSP5oTFhZDVZhgyoV27yEIR85EadKHcPgwGYcg/QFYZPTkqbqU9pw1MNVPq9IVOs3XIt+djalWLQN/+uUMLLLTOzmvGwfZy+h88Ksk4HfCfrPIbZJ+K/Ou/fBnLCctl8wqDU+eDekG2XA9OkeZkDKpb+Jg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295012c-d6ec-479c-47f6-08d65912ee64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2018 11:31:56.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have added a new format ie DRM_FORMAT_XVYU2101010 which is supported
by mali display driver.

Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 6b7a62e..d31e1ae 100644
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
 		{ .format =3D DRM_FORMAT_P010,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
 		{ .format =3D DRM_FORMAT_P012,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
 		{ .format =3D DRM_FORMAT_P016,		.depth =3D 0,  .num_planes =3D 2, .cpp =
=3D { 2, 4, 0 }, .hsub =3D 2, .vsub =3D 2, .is_yuv =3D true  },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 71b2bc7..75c4b5a 100644
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

