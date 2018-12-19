Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCD72133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GJjqF25i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbeLSMdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:33:51 -0500
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:63643
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729530AbeLSMdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Im7sJ8ngHGkldSNCp7raJ2jeRbEu+0PBBxyp+azpZo=;
 b=GJjqF25i4B9jN/qrpODbGPEap6zMrPaV3fKRDRrG9VcFEOUCsKoKHzDBdjLbx4b58UzaNs9caO1+GsUsZdtnfGxsAvPLVTVhIQPDtwCEJT79jwA45ieOqnPAzv+mMFA2wIsn1pXhOBSoYN6A3/VW+lLTyYKLEa2M85lmbelPvCQ=
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com (20.179.35.149) by
 AM0PR08MB3924.eurprd08.prod.outlook.com (20.178.118.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Wed, 19 Dec 2018 12:33:43 +0000
Received: from AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db]) by AM0PR08MB4483.eurprd08.prod.outlook.com
 ([fe80::1dff:434f:5905:45db%5]) with mapi id 15.20.1446.018; Wed, 19 Dec 2018
 12:33:43 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
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
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 4/9] drm/komeda: Add DT parsing
Thread-Topic: [PATCH v2 4/9] drm/komeda: Add DT parsing
Thread-Index: AQHUl5cUt9ULts/t3UaAJkdKdzOFrQ==
Date:   Wed, 19 Dec 2018 12:33:43 +0000
Message-ID: <20181219123147.16090-5-james.qian.wang@arm.com>
References: <20181219123147.16090-1-james.qian.wang@arm.com>
In-Reply-To: <20181219123147.16090-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYBPR01CA0132.ausprd01.prod.outlook.com
 (2603:10c6:10:5::24) To AM0PR08MB4483.eurprd08.prod.outlook.com
 (2603:10a6:208:145::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR08MB3924;6:+8fIjqU9TaqfpHt8JDh4l8BfjY9pN1vKC3hBmfSw92mCq926J9UKCTrYgEljHtseiGKE17mqCvhfYa5Vbq2dW1fG4nw7SJ8I6OZFf8UH7iAcEVV6EhpuDV6kjp/slvMbT66AgjG9+CvhRU4MwLcZDChVxh2WbEXCgsi9gXiCIFKyshcwd9/2Hs4DehWCDsGVPPqiBsyxuykYzbVp2XvpiBOI6lPF0s0ate+hQCClj/hgbYgd7qly4eu2Zj91CsU9oRisCjsmRxwH/ZvqWehn7Nqc3YYOk3Iy78fu1Nm5rDIKvMf8j63gkd2IsrzSjnADr/Os8gxDJNScCkpULMm5DUllcglVFfIqNj0tnDf24YI+UXdXsSwpRE7hkHRilfQRiNu9qy1uC6kccxqfjnL3dxo7O3jVTgIVgegahAYYX5+vjZY3/cFr/C2ESMncNoyKM4w9AS863HzRuXUBmmY8hg==;5:v2nDbtW9hQAuJ3KJaYyh0D+EoIgocf3R5EmXRyEceudxGpoL6yo+mskpfd1ABFzfvu/yoXIhb8dqt2OM1cHKJU9ZbBpDyzFKZF0pqd+tXCbEfc1kyUtAw4MDUXwUe3dCpacLMIqrlja9ihjbM2IiD0JS+pdt1kxEtxQ0ZHm7vk4=;7:OEfnRJHhRQBufY+tRunVKVUeigzhpnx/ZurwheRgl2xwc0zo7OaBToOQFIqYARo0VYvFPgzLSfAGS6y9PYQ/EDcrRsQv4a2GeF+9ODfBxrKOaT9/FOKBFIUicV2xJfTaaedMzU7VMSciEZqYVtncIQ==
x-ms-office365-filtering-correlation-id: 701a94d2-96d8-40a3-5514-08d665ae367f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR08MB3924;
x-ms-traffictypediagnostic: AM0PR08MB3924:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM0PR08MB39243F6418188C3CDE819407B3BE0@AM0PR08MB3924.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR08MB3924;BCL:0;PCL:0;RULEID:;SRVR:AM0PR08MB3924;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(316002)(8936002)(103116003)(37006003)(1076003)(71190400001)(81166006)(81156014)(11346002)(446003)(97736004)(36756003)(54906003)(256004)(2616005)(486006)(6636002)(99286004)(71200400001)(476003)(575784001)(86362001)(8676002)(106356001)(105586002)(5660300001)(3846002)(7416002)(6116002)(14454004)(68736007)(6512007)(2906002)(4326008)(25786009)(6486002)(76176011)(52116002)(53936002)(186003)(55236004)(102836004)(26005)(6862004)(6436002)(305945005)(478600001)(6506007)(66066001)(386003)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3924;H:AM0PR08MB4483.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: l89mpEenLD+s/Tp08B2a1ZcyGzBBnAeQt86+uyIYu/E5021jZ+s5i/x/nRwubpmNHIxt5ozTV262j/ySFPrqnCffKsJuO/UphFcSgdojH/sFiZtcgMFd7O4IH1GzmkQoRBQpaMZSS226LIEV2iGUHYvLLGoJcGPY6DY+wG7tC3YKstBmJXrohwPAAttItMLFJQD5eOvjUtVPi25FrnSlUOqwgnj051pCkbiCSIeD3EYmBzH3nyzfBSUhFuHfBMID0L0ZrSDrgZ85d+dCRyVWN+C7tRlbSngS69ZqqfviC4uPXqw3JkZqAekYsZzdPBAe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701a94d2-96d8-40a3-5514-08d665ae367f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 12:33:43.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3924
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
index 887a17005367..214ef75e0e24 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -12,6 +12,74 @@
 #include <linux/version.h>
 #include "komeda_dev.h"
=20
+static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_nod=
e *np)
+{
+	struct komeda_pipeline *pipe;
+	struct clk *clk;
+	u32 pipe_id;
+	int ret =3D 0;
+
+	ret =3D of_property_read_u32(np, "reg", &pipe_id);
+	if (ret !=3D 0 || pipe_id >=3D mdev->n_pipelines)
+		return -EINVAL;
+
+	pipe =3D mdev->pipelines[pipe_id];
+
+	clk =3D of_clk_get_by_name(np, "aclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get aclk for pipeline %d failed!\n", pipe_id);
+		return PTR_ERR(clk);
+	}
+	pipe->aclk =3D clk;
+
+	clk =3D of_clk_get_by_name(np, "pxclk");
+	if (IS_ERR(clk)) {
+		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
+		return PTR_ERR(clk);
+	}
+	pipe->pxlclk =3D clk;
+
+	/* enum ports */
+	pipe->of_output_dev  =3D of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTP=
UT, 0);
+	pipe->of_output_port =3D of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPU=
T);
+
+	pipe->of_node =3D np;
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
+			ret =3D komeda_parse_pipe_dt(mdev, child);
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
index 10378df8e5a8..2f36b6bd8282 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -55,6 +55,10 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
 	clk_put(pipe->pxlclk);
 	clk_put(pipe->aclk);
=20
+	of_node_put(pipe->of_output_dev);
+	of_node_put(pipe->of_output_port);
+	of_node_put(pipe->of_node);
+
 	devm_kfree(mdev->dev, pipe);
 }
=20
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index eea1e64c4624..e097d4fcb2c5 100644
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

