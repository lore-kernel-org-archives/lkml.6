Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1393FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8A1214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="K6Td3zqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfAJPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:10:39 -0500
Received: from mail-eopbgr80120.outbound.protection.outlook.com ([40.107.8.120]:41917
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727753AbfAJPKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fubxctBDBF6kkbNS9MWkCLsoSWq6LbrnhCguLwzDgVc=;
 b=K6Td3zqaVkb5ckYSB7372Ie/eMSWXZRUoD1iuL8eCh/dK13VUyaCs4CPzeVTv+qv4n/typexhJHW+XMCNJq4+Or1f8VDtM8b7W+laiLaj+1wo491+L628CNldKhiTRP87rPyryJvMT8SgKNR9gL8qQaqJYdWUPIhC84cL+djqLA=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB4037.eurprd02.prod.outlook.com (20.177.112.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Thu, 10 Jan 2019 15:10:34 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.015; Thu, 10 Jan 2019
 15:10:34 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/4] drm/atmel-hlcdc: rotate planes counterclockwise
Thread-Topic: [PATCH 1/4] drm/atmel-hlcdc: rotate planes counterclockwise
Thread-Index: AQHUqPaiL7m+2adSdUCQzjfoCW/2Iw==
Date:   Thu, 10 Jan 2019 15:10:34 +0000
Message-ID: <20190110151020.30468-2-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
In-Reply-To: <20190110151020.30468-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0257.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::33) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4037;6:2Xh8ocU8hq74UnJQI+/u/oXxTu1L84X2SRxf1AVaUX7Qj/hp6rsmrzxjv4/QnbPkYXf/uon8HXvnr6QqfI2+CkR33PFW42PezcuW7zu/PVDE8AOVc8BHr7iBJCuaagfSxLP6k8TxwFM7KKjtuGzm6rcd7J3mQ50mTdDdV+xs7txCe8biS2BIR4ct9fK0Rn72+W5hWOsT0vmy/GRt8eCgFH9UhmH90UR6g7fP/3WywVvSTVMvrkrhY4haZXtX/RCwjG4yCo+Vq6wETFRWGiustPBG1wPdeeKFHDbDsMqwtjDCcyrnRd62uaEAPPoBNzEuJNhid/LSvqq4oNh8KP1PfhahIl2L+bxlIpLOMrjgp9jaS7yCdMjtGq2NatoDGffd0IY7EvQpwuqbpU+UiIbW5fKNuPYdRNBKNUB1vyjH7yRiLJjjheqeizy8gWeuh/VmziQYWT1chWfAfOprQr0Hhg==;5:7lUZ57Srx8wPHx7f9iz/nyXEtodaSuoxsKDQhpeEQI55A+wDbWaFxCN/7Fi6RSvzMw5mMWrPxUv4Vz6ll2qyXqMEUWo7tqmbK8sZuY12y/xQ9u7E+sKEeshEeJs/G6zCykB1pTFz6cUIGbWRAdH+t2pT5lD6MSru8TMmpmI7uJWQK2R5ArklrZasPigFUBWRPb5yc6226i4B4P8heWuteQ==;7:1yWWUaGNYTgUaMVGqR2OIC4f81xmvQXIEhgp+qObBZerGMfdsONCq1qw7inQ0h8LTdRGarfD3BhWLMPH/UOVN4h24J8JP0bzBYCMC1LirkZIs1nYVK1OMBE6KDEpeqL/LMvfC1YFLqWNWbXHSL0Yrw==
x-ms-office365-filtering-correlation-id: 14efde95-ab2a-4925-919d-08d6770dc4be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4037;
x-ms-traffictypediagnostic: AM6PR02MB4037:
x-microsoft-antispam-prvs: <AM6PR02MB403797CE117F3881FD6AFF41BC840@AM6PR02MB4037.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123560045)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM6PR02MB4037;BCL:0;PCL:0;RULEID:;SRVR:AM6PR02MB4037;
x-forefront-prvs: 0913EA1D60
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(53936002)(316002)(36756003)(6512007)(97736004)(50226002)(5660300001)(66066001)(186003)(386003)(4326008)(6506007)(446003)(25786009)(26005)(256004)(11346002)(2501003)(476003)(102836004)(2616005)(6916009)(14454004)(71190400001)(71200400001)(106356001)(105586002)(2906002)(68736007)(7736002)(486006)(5640700003)(1076003)(6436002)(6486002)(508600001)(2351001)(81156014)(99286004)(81166006)(3846002)(8936002)(305945005)(575784001)(6116002)(8676002)(86362001)(54906003)(74482002)(76176011)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB4037;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qJ2Q/8/QthtF9E8duURiypdCxu2wV0p/Fb987Ipu4/e/oEjJUalwSgU9NdlfkAch63rK178NC/pp1bgLDzXKThhsGKBDeuE4m5f6k6UU0t0STfHSG5TmD0MigDxqSrx8jUGkotxC6KpoGiqATlkuAzRECsSFzEj7utPnxulMrbkxqIb/RhE+Z9O61h6Wf3c11xdIG4TZZmviqDACSFMZiZxVPBegiTESP+UDs2r/fFYAbzzZC4EIIxp8iPuYbC3ZCw8vShHRbbFXCcuUeKOpmcdYh3IU9zg+VUoMCHhQYHFCKUun5/jXy+cfdZZOHfVz
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 14efde95-ab2a-4925-919d-08d6770dc4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2019 15:10:33.3554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ouch, the driver rotates planes clockwise, which is simply not correct.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 30 ++++++++++++---------=
----
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/=
drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 47e0992f3908..ea8fc0deb814 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -691,13 +691,14 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
=20
 		switch (state->base.rotation & DRM_MODE_ROTATE_MASK) {
 		case DRM_MODE_ROTATE_90:
-			offset =3D ((y_offset + state->src_y + patched_src_w - 1) /
-				  ydiv) * fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x) / xdiv) *
-				  state->bpp[i];
-			state->xstride[i] =3D ((patched_src_w - 1) / ydiv) *
-					  fb->pitches[i];
-			state->pstride[i] =3D -fb->pitches[i] - state->bpp[i];
+			offset =3D ((y_offset + state->src_y) / ydiv) *
+				 fb->pitches[i];
+			offset +=3D ((x_offset + state->src_x + patched_src_h - 1) /
+				   xdiv) * state->bpp[i];
+			state->xstride[i] =3D -(((patched_src_w - 1) / ydiv) *
+					    fb->pitches[i]) -
+					  (2 * state->bpp[i]);
+			state->pstride[i] =3D fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_180:
 			offset =3D ((y_offset + state->src_y + patched_src_h - 1) /
@@ -709,14 +710,13 @@ static int atmel_hlcdc_plane_atomic_check(struct drm_=
plane *p,
 			state->pstride[i] =3D -2 * state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_270:
-			offset =3D ((y_offset + state->src_y) / ydiv) *
-				 fb->pitches[i];
-			offset +=3D ((x_offset + state->src_x + patched_src_h - 1) /
-				   xdiv) * state->bpp[i];
-			state->xstride[i] =3D -(((patched_src_w - 1) / ydiv) *
-					    fb->pitches[i]) -
-					  (2 * state->bpp[i]);
-			state->pstride[i] =3D fb->pitches[i] - state->bpp[i];
+			offset =3D ((y_offset + state->src_y + patched_src_w - 1) /
+				  ydiv) * fb->pitches[i];
+			offset +=3D ((x_offset + state->src_x) / xdiv) *
+				  state->bpp[i];
+			state->xstride[i] =3D ((patched_src_w - 1) / ydiv) *
+					  fb->pitches[i];
+			state->pstride[i] =3D -fb->pitches[i] - state->bpp[i];
 			break;
 		case DRM_MODE_ROTATE_0:
 		default:
--=20
2.11.0

