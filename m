Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41951C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C9C21479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kFmjwtXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731277AbfACLlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:41:04 -0500
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:38969
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfACLlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:41:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvKvtBvxyP8OPVtdEgKSOrUJF6rwoxVN5Dmesvwz+Vs=;
 b=kFmjwtXNUrAgjMypvHeyZ+7jr2PpY0/Hze5ceS9k41pWDX3/BGhf2QYdLL0oosod3puNvNaS+BRsJ+BRMR+774YYrxX0pWi8VWyBjDlcnChFQupu1ztSxi3vFqS6d2Oj9erFfdx9yBHehZARAO9I8JLhOCXXd4pyU9gGZOFUWjo=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0181.eurprd08.prod.outlook.com (10.161.35.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:40:56 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:40:56 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v4 5/9] drm/komeda: Add komeda_format_caps for format handling
Thread-Topic: [PATCH v4 5/9] drm/komeda: Add komeda_format_caps for format
 handling
Thread-Index: AQHUo1kw24NG9IMXp0WfNNgZsbBRxw==
Date:   Thu, 3 Jan 2019 11:40:55 +0000
Message-ID: <20190103113841.15403-6-james.qian.wang@arm.com>
References: <20190103113841.15403-1-james.qian.wang@arm.com>
In-Reply-To: <20190103113841.15403-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SY2PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:1:15::34) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0181;6:au7KmUnaugNlcbZqy008/o64X3Gg0w8O2SMDBFvrusK05X+ci02qY6SJJXhkaNCn+fqKl9THV+rrNE30MG63xRwdbbN/dFo9Hq3sHwC279Ioz/AEQiX3nWrdfU3hmFg52Heg+f6xGUS+bBxcsAkUIjYEKaEloYyqsTpsY/Z6/K4DW5vVuabU8kSlIVp2kEaRiOahPbgUXouBMMut1MYfsznNP8Rg0GHFPjjY3sABVIr07Owbi2SMBkeAomW5CwHENTjEQLXkdVVSFDcWVz/pcWBtS14lUbXHaccUWsGCUj6gWf4U2DZY+oaLe3bfTOeece/8xlGAiyP4Ylz1rXIKY/815H12Sq/gdCzDdEkUxtQ3M7kx8TS0rEJxS1ydDN24uzN69M6Scu/8V/lLP9Viy4yFjVo5DrYCCoW31olC8EL1ujlGnuZILv9UeRvC37oAXcDuIB2rt/Huiof9v5DNcw==;5:LniTud8+UFNddIER3E64J7om9IUY7XwLEX8W4IYGvQi6IsarTzeesT3JYgvh+wjjjxzxr58BAG4TLBAh6TNniDGjyyTwg467BWtYwcZQktLS5P3+xJ2fzJrH7u/yW9cxyHA2tAOwcj6qrm5WE48kXCCcRhINElZ4oa/brXe2oy30WtGVsNpbMSawBS9zTSwM1zLLnAJF8ExEsjg9lHQDwQ==;7:8WL3XJsxJgxF8HpYqh4Zf4FB2QpMF4hspQ7vrpsg7Rm49apVBaXQYePJT3gNW5akffGVwBveryu4oqk5Z42EaRLVgeB3LzvVxjZm+K/vBCyCWc1uqrkHKFvgBMrcQ7w8/ZJKV9rD/ciaVYjgQV0FEw==
x-ms-office365-filtering-correlation-id: 0ac534ce-3ab5-4324-40ed-08d671705292
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0181;
x-ms-traffictypediagnostic: AM3PR08MB0181:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB01813BD2F2C22BA6D6F55C0DB38D0@AM3PR08MB0181.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0181;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0181;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(189003)(6436002)(6486002)(1076003)(68736007)(2501003)(66066001)(6512007)(103116003)(36756003)(106356001)(105586002)(11346002)(478600001)(97736004)(14454004)(486006)(476003)(4326008)(2616005)(575784001)(14444005)(256004)(386003)(86362001)(6506007)(7736002)(102836004)(316002)(446003)(2201001)(8936002)(26005)(7416002)(3846002)(81156014)(99286004)(2906002)(6116002)(81166006)(71200400001)(186003)(71190400001)(52116002)(76176011)(25786009)(5660300001)(8676002)(305945005)(54906003)(110136005)(53936002)(55236004)(4744004)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0181;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6Um0X7qzyzK9rjwRG7z2M2UhAtmbWxXh3XeXqzavjXte1fnTq0RpotlhAquX++mJrltYaxwvnLiuDdQet0zhJCDuTf6uTDAsxJpBNzzfzHz/lhManHCgpBL/nYtHRLCEzkOkQYkK6gOE7rTVbU7ms5rELTJ5+TkHRd/TXnID3SC6Esh/3GL+nuLEn1bC1TquSPQg/myJhtUWfXFPUVWZZKQZkO6RSV7PWf/wYWjBUoLBSCosi79b6TrlDCbyyLl+kV1cCwnuQqCSfQFu06foA0pMCQMUcCum2CEYKL+DSL7vuoxlbo74zvrUXzLkO3qx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac534ce-3ab5-4324-40ed-08d671705292
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:40:55.9239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

komeda_format_caps is for describing ARM display specific features and
limitations of a specific format, and format_caps will be linked into
&komeda_framebuffer like a extension of &drm_format_info.
And komed_format_caps_table will be initialized before the enum_resources,
since the layer features description depend on this format_caps table, so
we'd better initialize the table first.

Changes in v4:
- Rebase.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |  1 +
 .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 78 ++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +
 .../gpu/drm/arm/display/komeda/komeda_dev.h   | 11 ++-
 .../arm/display/komeda/komeda_format_caps.c   | 75 ++++++++++++++++
 .../arm/display/komeda/komeda_format_caps.h   | 89 +++++++++++++++++++
 .../drm/arm/display/komeda/komeda_pipeline.h  |  1 +
 7 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index c03d6876ef75..394fc2aa434a 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -7,6 +7,7 @@ ccflags-y :=3D \
 komeda-y :=3D \
 	komeda_drv.o \
 	komeda_dev.o \
+	komeda_format_caps.o \
 	komeda_pipeline.o
=20
 komeda-y +=3D \
diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index af3dabb499cd..edbf9daa1545 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -13,7 +13,85 @@ static int d71_enum_resources(struct komeda_dev *mdev)
 	return -1;
 }
=20
+#define __HW_ID(__group, __format) \
+	((((__group) & 0x7) << 3) | ((__format) & 0x7))
+
+#define RICH		KOMEDA_FMT_RICH_LAYER
+#define SIMPLE		KOMEDA_FMT_SIMPLE_LAYER
+#define RICH_SIMPLE	(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_SIMPLE_LAYER)
+#define RICH_WB		(KOMEDA_FMT_RICH_LAYER | KOMEDA_FMT_WB_LAYER)
+#define RICH_SIMPLE_WB	(RICH_SIMPLE | KOMEDA_FMT_WB_LAYER)
+
+#define Rot_0		DRM_MODE_ROTATE_0
+#define Flip_H_V	(DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y | Rot_0)
+#define Rot_ALL_H_V	(DRM_MODE_ROTATE_MASK | Flip_H_V)
+
+#define LYT_NM		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16)
+#define LYT_WB		BIT(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8)
+#define LYT_NM_WB	(LYT_NM | LYT_WB)
+
+#define AFB_TH		AFBC(_TILED | _SPARSE)
+#define AFB_TH_SC_YTR	AFBC(_TILED | _SC | _SPARSE | _YTR)
+#define AFB_TH_SC_YTR_BS AFBC(_TILED | _SC | _SPARSE | _YTR | _SPLIT)
+
+static struct komeda_format_caps d71_format_caps_table[] =3D {
+	/*   HW_ID    |        fourcc        | tile_sz |   layer_types |   rots  =
  | afbc_layouts | afbc_features */
+	/* ABGR_2101010*/
+	{__HW_ID(0, 0),	DRM_FORMAT_ARGB2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 1),	DRM_FORMAT_ABGR2101010,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_=
NM_WB, AFB_TH_SC_YTR_BS}, /* afbc */
+	{__HW_ID(0, 2),	DRM_FORMAT_RGBA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	{__HW_ID(0, 3),	DRM_FORMAT_BGRA1010102,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, =
0},
+	/* ABGR_8888*/
+	{__HW_ID(1, 0),	DRM_FORMAT_ARGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 1),	DRM_FORMAT_ABGR8888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_=
WB, AFB_TH_SC_YTR_BS}, /* afbc */
+	{__HW_ID(1, 2),	DRM_FORMAT_RGBA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(1, 3),	DRM_FORMAT_BGRA8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	/* XBGB_8888 */
+	{__HW_ID(2, 0),	DRM_FORMAT_XRGB8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 1),	DRM_FORMAT_XBGR8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 2),	DRM_FORMAT_RGBX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	{__HW_ID(2, 3),	DRM_FORMAT_BGRX8888,	1,	RICH_SIMPLE_WB,	Flip_H_V,		0, 0},
+	/* BGR_888 */ /* none-afbc RGB888 doesn't support rotation and flip */
+	{__HW_ID(3, 0),	DRM_FORMAT_RGB888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
+	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE_WB,	Rot_0,			0, 0},
+	{__HW_ID(3, 1),	DRM_FORMAT_BGR888,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB=
, AFB_TH_SC_YTR_BS}, /* afbc */
+	/* BGR 16bpp */
+	{__HW_ID(4, 0),	DRM_FORMAT_RGBA5551,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 1),	DRM_FORMAT_ABGR1555,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_=
WB, AFB_TH_SC_YTR}, /* afbc */
+	{__HW_ID(4, 2),	DRM_FORMAT_RGB565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Flip_H_V,		0, 0},
+	{__HW_ID(4, 3),	DRM_FORMAT_BGR565,	1,	RICH_SIMPLE,	Rot_ALL_H_V,	LYT_NM_WB=
, AFB_TH_SC_YTR}, /* afbc */
+	{__HW_ID(4, 4), DRM_FORMAT_R8,		1,	SIMPLE,		Rot_0,			0, 0},
+	/* YUV 444/422/420 8bit  */
+	{__HW_ID(5, 0),	0 /*XYUV8888*/,		1,	0,		0,			0, 0},
+	/* XYUV unsupported*/
+	{__HW_ID(5, 1),	DRM_FORMAT_YUYV,	1,	RICH,		Rot_ALL_H_V,	LYT_NM, AFB_TH}, =
/* afbc */
+	{__HW_ID(5, 2),	DRM_FORMAT_YUYV,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 3),	DRM_FORMAT_UYVY,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 4),	0, /*X0L0 */		2,		0,			0, 0}, /* Y0L0 unsupported */
+	{__HW_ID(5, 6),	DRM_FORMAT_NV12,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(5, 6),	0/*DRM_FORMAT_YUV420_8BIT*/,	1,	RICH,	Rot_ALL_H_V,	LYT_NM=
, AFB_TH}, /* afbc */
+	{__HW_ID(5, 7),	DRM_FORMAT_YUV420,	1,	RICH,		Flip_H_V,		0, 0},
+	/* YUV 10bit*/
+	{__HW_ID(6, 0),	0,/*XVYU2101010*/	1,	0,		0,			0, 0},/* VYV30 unsupported =
*/
+	{__HW_ID(6, 6),	0/*DRM_FORMAT_X0L2*/,	2,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(6, 7),	0/*DRM_FORMAT_P010*/,	1,	RICH,		Flip_H_V,		0, 0},
+	{__HW_ID(6, 7),	0/*DRM_FORMAT_YUV420_10BIT*/, 1,	RICH,	Rot_ALL_H_V,	LYT_N=
M, AFB_TH},
+};
+
+static void d71_init_fmt_tbl(struct komeda_dev *mdev)
+{
+	struct komeda_format_caps_table *table =3D &mdev->fmt_tbl;
+
+	table->format_caps =3D d71_format_caps_table;
+	table->n_formats =3D ARRAY_SIZE(d71_format_caps_table);
+}
+
 static struct komeda_dev_funcs d71_chip_funcs =3D {
+	.init_format_table =3D d71_init_fmt_tbl,
 	.enum_resources	=3D d71_enum_resources,
 	.cleanup	=3D NULL,
 };
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 7257248463bc..84fdf707f210 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -135,6 +135,8 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		 MALIDP_CORE_ID_MAJOR(mdev->chip.core_id),
 		 MALIDP_CORE_ID_MINOR(mdev->chip.core_id));
=20
+	mdev->funcs->init_format_table(mdev);
+
 	err =3D mdev->funcs->enum_resources(mdev);
 	if (err) {
 		DRM_ERROR("enumerate display resource failed.\n");
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 9c43565fec2a..a0bf7050037a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include "komeda_pipeline.h"
 #include "malidp_product.h"
+#include "komeda_format_caps.h"
=20
 /* malidp device id */
 enum {
@@ -44,6 +45,13 @@ struct komeda_dev;
  * Supplied by chip level and returned by the chip entry function xxx_iden=
tify,
  */
 struct komeda_dev_funcs {
+	/**
+	 * @init_format_table:
+	 *
+	 * initialize &komeda_dev->format_table, this function should be called
+	 * before the &enum_resource
+	 */
+	void (*init_format_table)(struct komeda_dev *mdev);
 	/**
 	 * @enum_resources:
 	 *
@@ -66,7 +74,8 @@ struct komeda_dev {
 	u32 __iomem   *reg_base;
=20
 	struct komeda_chip_info chip;
-
+	/** @fmt_tbl: initialized by &komeda_dev_funcs->init_format_table */
+	struct komeda_format_caps_table fmt_tbl;
 	/** @pclk: APB clock for register access */
 	struct clk *pclk;
 	/** @mck: HW main engine clk */
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.c
new file mode 100644
index 000000000000..1e17bd6107a4
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+
+#include <linux/slab.h>
+#include "komeda_format_caps.h"
+#include "malidp_utils.h"
+
+const struct komeda_format_caps *
+komeda_get_format_caps(struct komeda_format_caps_table *table,
+		       u32 fourcc, u64 modifier)
+{
+	const struct komeda_format_caps *caps;
+	u64 afbc_features =3D modifier & ~(AFBC_FORMAT_MOD_BLOCK_SIZE_MASK);
+	u32 afbc_layout =3D modifier & AFBC_FORMAT_MOD_BLOCK_SIZE_MASK;
+	int id;
+
+	for (id =3D 0; id < table->n_formats; id++) {
+		caps =3D &table->format_caps[id];
+
+		if (fourcc !=3D caps->fourcc)
+			continue;
+
+		if ((modifier =3D=3D 0ULL) && (caps->supported_afbc_layouts =3D=3D 0))
+			return caps;
+
+		if (has_bits(afbc_features, caps->supported_afbc_features) &&
+		    has_bit(afbc_layout, caps->supported_afbc_layouts))
+			return caps;
+	}
+
+	return NULL;
+}
+
+u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
+				  u32 layer_type, u32 *n_fmts)
+{
+	const struct komeda_format_caps *cap;
+	u32 *fmts;
+	int i, j, n =3D 0;
+
+	fmts =3D kcalloc(table->n_formats, sizeof(u32), GFP_KERNEL);
+	if (!fmts)
+		return NULL;
+
+	for (i =3D 0; i < table->n_formats; i++) {
+		cap =3D &table->format_caps[i];
+		if (!(layer_type & cap->supported_layer_types) ||
+		    (cap->fourcc =3D=3D 0))
+			continue;
+
+		/* one fourcc may has two caps items in table (afbc/none-afbc),
+		 * so check the existing list to avoid adding a duplicated one.
+		 */
+		for (j =3D n - 1; j >=3D 0; j--)
+			if (fmts[j] =3D=3D cap->fourcc)
+				break;
+
+		if (j < 0)
+			fmts[n++] =3D cap->fourcc;
+	}
+
+	if (n_fmts)
+		*n_fmts =3D n;
+
+	return fmts;
+}
+
+void komeda_put_fourcc_list(u32 *fourcc_list)
+{
+	kfree(fourcc_list);
+}
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h b/driv=
ers/gpu/drm/arm/display/komeda/komeda_format_caps.h
new file mode 100644
index 000000000000..60f39e77b098
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_format_caps.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+
+#ifndef _KOMEDA_FORMAT_CAPS_H_
+#define _KOMEDA_FORMAT_CAPS_H_
+
+#include <linux/types.h>
+#include <uapi/drm/drm_fourcc.h>
+#include <drm/drm_fourcc.h>
+
+#define AFBC(x)		DRM_FORMAT_MOD_ARM_AFBC(x)
+
+/* afbc layerout */
+#define AFBC_16x16(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | (x))
+#define AFBC_32x8(x)	AFBC(AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 | (x))
+
+/* afbc features */
+#define _YTR		AFBC_FORMAT_MOD_YTR
+#define _SPLIT		AFBC_FORMAT_MOD_SPLIT
+#define _SPARSE		AFBC_FORMAT_MOD_SPARSE
+#define _CBR		AFBC_FORMAT_MOD_CBR
+#define _TILED		AFBC_FORMAT_MOD_TILED
+#define _SC		AFBC_FORMAT_MOD_SC
+
+/* layer_type */
+#define KOMEDA_FMT_RICH_LAYER		BIT(0)
+#define KOMEDA_FMT_SIMPLE_LAYER		BIT(1)
+#define KOMEDA_FMT_WB_LAYER		BIT(2)
+
+#define AFBC_TH_LAYOUT_ALIGNMENT	8
+#define AFBC_HEADER_SIZE		16
+#define AFBC_SUPERBLK_ALIGNMENT		128
+#define AFBC_SUPERBLK_PIXELS		256
+#define AFBC_BODY_START_ALIGNMENT	1024
+#define AFBC_TH_BODY_START_ALIGNMENT	4096
+
+/**
+ * struct komeda_format_caps
+ *
+ * komeda_format_caps is for describing ARM display specific features and
+ * limitations for a specific format, and format_caps will be linked into
+ * &komeda_framebuffer like a extension of &drm_format_info.
+ *
+ * NOTE: one fourcc may has two different format_caps items for fourcc and
+ * fourcc+modifier
+ *
+ * @hw_id: hw format id, hw specific value.
+ * @fourcc: drm fourcc format.
+ * @tile_size: format tiled size, used by ARM format X0L0/X0L2
+ * @supported_layer_types: indicate which layer supports this format
+ * @supported_rots: allowed rotations for this format
+ * @supported_afbc_layouts: supported afbc layerout
+ * @supported_afbc_features: supported afbc features
+ */
+struct komeda_format_caps {
+	u32 hw_id;
+	u32 fourcc;
+	u32 tile_size;
+	u32 supported_layer_types;
+	u32 supported_rots;
+	u32 supported_afbc_layouts;
+	u64 supported_afbc_features;
+};
+
+/**
+ * struct komeda_format_caps_table - format_caps mananger
+ *
+ * @n_formats: the size of format_caps list.
+ * @format_caps: format_caps list.
+ */
+struct komeda_format_caps_table {
+	u32 n_formats;
+	const struct komeda_format_caps *format_caps;
+};
+
+const struct komeda_format_caps *
+komeda_get_format_caps(struct komeda_format_caps_table *table,
+		       u32 fourcc, u64 modifier);
+
+u32 *komeda_get_layer_fourcc_list(struct komeda_format_caps_table *table,
+				  u32 layer_type, u32 *n_fmts);
+
+void komeda_put_fourcc_list(u32 *fourcc_list);
+
+#endif
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index d2222e46b10b..35dc71acd7ec 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -211,6 +211,7 @@ static inline u16 component_changed_inputs(struct komed=
a_component_state *st)
 struct komeda_layer {
 	struct komeda_component base;
 	/* layer specific features and caps */
+	int layer_type; /* RICH, SIMPLE or WB */
 };
=20
 struct komeda_layer_state {
--=20
2.17.1

