Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40460C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F72204FD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kUs/8HjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4F72204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeLEKTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:19:23 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:27448
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbeLEKTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1yR6DTheOpz8Q/b6Cgx9OQqfWa8oeT/chpt40o5cao=;
 b=kUs/8HjRI0HdoAlsYZk3+5M2vKOs+4YZdPbiyktm2dF9N4jYTTnl2kWUGOLtpCEirsKA5NZYfz4y1X4A7oIsG2ULjx1j43JJlCweqGVSwmRJAefcwixXAHSd1J9DDHVJLpNJv/vo7xsNVV6v2/TpDUs5hU4K3D6h+FzwUIwttlI=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0644.eurprd08.prod.outlook.com (10.163.188.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Wed, 5 Dec 2018 10:19:18 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::38d5:d5ee:b90c:901c%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 10:19:18 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        nd <nd@arm.com>, Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v1 4/9] drm/komeda: Add DT parsing
Thread-Topic: [PATCH v1 4/9] drm/komeda: Add DT parsing
Thread-Index: AQHUjIP71MecA6xAJkeKeKkHTLmw7w==
Date:   Wed, 5 Dec 2018 10:19:18 +0000
Message-ID: <20181205101635.7696-5-james.qian.wang@arm.com>
References: <20181205101635.7696-1-james.qian.wang@arm.com>
In-Reply-To: <20181205101635.7696-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYCPR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:10:31::26) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0644;6:UFKqqwcRjop+E1pr1X02tGjA12tSOSQINTTEqUVDdKo0OJS8b1W6k4NqjVQPc2EiYYffq6warOuOyut8fsVk7ulxLPW6JEXMxQhGN2CKL0tE0cAWi87DO5En8OLI4f9zmwbLYXGCirooP7ZQBsu8vsq9gv+L9Xbob2UoZpdmRBL5YjmTKZtW8ezEKT3vKejD36PQ4d7KMkeSxNyE90CiC5MXWvAKJZKmYli2n/abp/jadcHkkPs+JZPgsAF9NyRpvC+5Lx+zwSfAnSMUmXJTOj2I1mAksu2rizUVvG9pUGW87aoZC6RD4kaYBwVs0wo7/GGqEETZvUXRMd0YOL68LEqctcIhTlm3Mf9x8a1qCe3UvAxsptSzMCbTUycABPVoOVycy/oB3GS2YHEPgdXMnLMVzZna3aqm2IOPd9sxFi1JzxiGIev2OCCJfK94X+BhW/+y44IuoWZadSq0EgUQwQ==;5:EJ/aAtO4lEW7xZXxWlkg4ZIzoI2M9pWydc89SgCVjnlN6vrDP3ALyP0Q6qKql0Z8/drCa7Ui9vua4gSiWocmLgxlCnM3dz+0lH+F5sAixCbSLyN702Jfu7xLHnxiqv+qcephlLP0qVb5QbmoFGpi1+rrcy17tUFKs7qV/D6Jk8s=;7:1xlmSMe3LYOrVV2P3a4BYrZA8iDEh53n+oA6IT+YZF1gQsJ0mSeCTX7g8Vp6Xr0Jthr7ReAIO8LU09w4wtNMh9tH+JeNkdFFIDGniCoqKl/N4kSz2igZfM+o0/qaCeQ+EzhXa+oBIl/7BPkrKUsKjQ==
x-ms-office365-filtering-correlation-id: 6af885a5-25e3-4e66-92f9-08d65a9b1da9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0644;
x-ms-traffictypediagnostic: AM3PR08MB0644:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB064409AB9F7F337A089D4354B3A80@AM3PR08MB0644.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0644;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0644;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(189003)(199004)(305945005)(6506007)(55236004)(8676002)(2906002)(6636002)(5660300001)(68736007)(102836004)(86362001)(71200400001)(71190400001)(66066001)(386003)(36756003)(1076002)(3846002)(6116002)(26005)(256004)(186003)(14454004)(99286004)(486006)(11346002)(6436002)(476003)(446003)(6486002)(6862004)(4326008)(6512007)(53936002)(76176011)(478600001)(103116003)(52116002)(37006003)(8936002)(105586002)(106356001)(54906003)(2616005)(97736004)(25786009)(316002)(81156014)(81166006)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0644;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZSGYE6c1X9x3R7ahGBfe9x5lrzyslXRMqf4VdmbRYqaSFagtIMdCN7aXjd1GS/rRF4UDyMEuqJoEjtg9KJRS189dxmG+DBXigXgmeZRJFqn/mXQhtJ1RynuF5bSYwwkaWjbNHKQp6Vj7eGOwbnqXsypcDtWja9Y43yErLpy7Sdz3sXaQpmOFeK5v9TW+v1NPr3LFbPKMXC9k4SpPiNGel7iGXkBAnLPRrJwRGCzxGIIv4hiV0z/urzWj2eFtsENMqusWwm238qAIRDvyn52pRW/W9XEocj55Hq0T5E7stXq1RA5sRbJ147QqyYttMY1gL5cgiJqGrN0J2l2qjhtcIlOZhGDZng+M8LmPa8GpTPc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af885a5-25e3-4e66-92f9-08d65a9b1da9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 10:19:18.7740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse DT and initialize corresponding dev/pipeline attributes.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 74 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  7 ++
 4 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 887a17005367..ace2db84cb1a 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -12,6 +12,74 @@
 #include <linux/version.h>
 #include "komeda_dev.h"
=20
+static int komeda_parse_ppl_dt(struct komeda_dev *mdev, struct device_node=
 *np)
+{
+	struct komeda_pipeline *ppl;
+	struct clk *clk;
+	u32 pipe;
+	int ret =3D 0;
+
+	ret =3D of_property_read_u32(np, "reg", &pipe);
+	if (ret !=3D 0 || pipe >=3D mdev->n_pipelines)
+		return -EINVAL;
+
+	ppl =3D mdev->pipelines[pipe];
+
+	clk =3D of_clk_get_by_name(np, "aclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get for aclk for pipeline %d failed!\n", pipe);
+		return PTR_ERR(clk);
+	}
+	ppl->aclk =3D clk;
+
+	clk =3D of_clk_get_by_name(np, "pxclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get for pxclk for pipeline %d failed!\n", pipe);
+		return PTR_ERR(clk);
+	}
+	ppl->pxlclk =3D clk;
+
+	/* enum ports */
+	ppl->of_output_dev  =3D of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPU=
T, 0);
+	ppl->of_output_port =3D of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT=
);
+
+	ppl->of_node =3D np;
+
+	return 0;
+}
+
+static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct device_node *child, *np =3D dev->of_node;
+	struct clk *clk;
+	int ret;
+
+	clk =3D devm_clk_get(dev, "mclk");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	mdev->mclk =3D clk;
+	mdev->irq  =3D platform_get_irq_byname(pdev, "DPU");
+	if (mdev->irq < 0) {
+		DRM_ERROR("could not get IRQ number.\n");
+		return mdev->irq;
+	}
+
+	for_each_available_child_of_node(np, child) {
+		if (of_node_cmp(child->name, "pipeline") =3D=3D 0) {
+			ret =3D komeda_parse_ppl_dt(mdev, child);
+			if (ret) {
+				DRM_ERROR("parse pipeline dt error!\n");
+				of_node_put(child);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
 struct komeda_dev *komeda_dev_create(struct device *dev)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
@@ -74,6 +142,12 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
)
 		goto err_cleanup;
 	}
=20
+	err =3D komeda_parse_dt(dev, mdev);
+	if (err) {
+		DRM_ERROR("parse device tree failed.\n");
+		goto err_cleanup;
+	}
+
 	return mdev;
=20
 err_cleanup:
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.h
index 680e3e2cf100..4a27a44e2ec6 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
@@ -72,6 +72,9 @@ struct komeda_dev {
 	/** @mck: HW main engine clk */
 	struct clk *mclk;
=20
+	/** @irq: irq number */
+	u32 irq;
+
 	int n_pipelines;
 	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.c
index 9a33f9d68bde..c1665c6dccc0 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -55,6 +55,10 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
 	clk_put(ppl->pxlclk);
 	clk_put(ppl->aclk);
=20
+	of_node_put(ppl->of_output_dev);
+	of_node_put(ppl->of_output_port);
+	of_node_put(ppl->of_node);
+
 	devm_kfree(mdev->dev, ppl);
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index 8759f54a4e09..506e5d1acf54 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -286,6 +286,13 @@ struct komeda_pipeline {
 	struct komeda_improc *improc;
 	struct komeda_timing_ctrlr *ctrlr;
 	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
+
+	/** @of_node: pipeline dt node */
+	struct device_node *of_node;
+	/** @of_output_port: pipeline output port */
+	struct device_node *of_output_port;
+	/** @of_output_dev: output connector device node */
+	struct device_node *of_output_dev;
 };
=20
 /**
--=20
2.17.1

