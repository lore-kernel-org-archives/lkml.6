Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E87C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A9920578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Mwjgj7dT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbfACLlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:41:36 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:59711
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726609AbfACLlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbMZWodhfMdOgLLe8xR84nBa37ESKxOYSSM9uUpSBMc=;
 b=Mwjgj7dT9kYB2HxatwV49ZPI+btqHDnetF8ELqZTPEStzj5cJqkJkc5aT0VAThEQ6C+J8qJGypPuyZzRw669v+ZxHxe+/svZo5eYqSPSuU8BVnx0Fm+lKzVW5U1gA2uaJJ08EF7HaUD0OEcMh5arlPrCXKxX7K8Z1zPTPqeIj4Q=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0659.eurprd08.prod.outlook.com (10.163.189.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Thu, 3 Jan 2019 11:40:38 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1495.005; Thu, 3 Jan 2019
 11:40:38 +0000
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
Subject: [PATCH v4 4/9] drm/komeda: Add DT parsing
Thread-Topic: [PATCH v4 4/9] drm/komeda: Add DT parsing
Thread-Index: AQHUo1kmKGPq/oAJfESPJvTFzFb1bg==
Date:   Thu, 3 Jan 2019 11:40:38 +0000
Message-ID: <20190103113841.15403-5-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0659;6:2wMoWyioxlPCtmSpHXbysnBVuKnlHZINhD+uuk1jkCUz4xrpaj7/wN3FCsNU/Li1PsmqOyU5RPR/DtK93xMsE2GOeysVlWOwzW0VD/6DI4yYNXohFymAIApV0PvGj228BCS52cdvpOH1rP84e4iJsnAK+U6CaE6pekxs31tHliqmyzVEYu8SEQXph8bo8yGg1dy1fBPEmZB8yiT8AiIkajhb/bIhlmxHRTkB4ZsRzTFGY4GXdW56qqIPsg2Hf4cbAp6bE6o9gT5kGJ0p9dtnF76/v3MsesLuflP38F+iYCTeMx1O6F8MgK5xsPe1hxlhgeBUwCv97PDtQuAdxcZ9shI+Z6bkNk/UC6puyV0VxIjMUJiOq5t0/5U+hv2lV5lK9554Xkq2LdoSuJ3Aw9p+zuUx7cIhf2B4aKqNRAp2P1ZL6K5G/2MJJhjmfEZN3xFVDMUkrRe7vt3zkBtEvRW9hA==;5:AEuhXFOPHFsT3qbZu1Zdahvw9iUi7dFnXCg1sAEtJpiCezY3bSGfbEc5r1+I1qiw7/RuaT4j7Tcp6iqWwvajJpIoLT8dIunFXQkLUnc2D4FhOg7Z4TUGqhcUE2EfuDNtMDcgj7nf8QqQbnUlW2myUB6HxI7lRbgztXI1v1lFZTfs5+d+96TYyg7//FGMWAc/8BOF3IbUcpgYiSrHH36w9g==;7:4h4VBvWNiI9t1Lv+IQAytm6xEDLPYcPjEVIGeNi1zHkkg41smf5EKgCR78yQtsdbFZaiu5Ps/c2jfh5h1loMNG9vCaWcnSWGDxKtzJ+d2iED0t+oRXIY8H84MJ5R1NV0GoiMtwzvIXy1jdzt4gaGLg==
x-ms-office365-filtering-correlation-id: bd89d39d-3521-459d-caa0-08d671704840
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0659;
x-ms-traffictypediagnostic: AM3PR08MB0659:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0659545C9CC1451CB7BA5283B38D0@AM3PR08MB0659.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0659;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0659;
x-forefront-prvs: 0906E83A25
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(396003)(136003)(189003)(199004)(575784001)(76176011)(53936002)(52116002)(25786009)(106356001)(4326008)(316002)(103116003)(386003)(6506007)(55236004)(71190400001)(102836004)(26005)(2616005)(476003)(446003)(11346002)(7736002)(1076003)(14454004)(256004)(66066001)(478600001)(305945005)(110136005)(8936002)(99286004)(81156014)(54906003)(81166006)(68736007)(8676002)(36756003)(5660300001)(6486002)(6436002)(2501003)(6512007)(105586002)(97736004)(486006)(3846002)(6116002)(86362001)(186003)(2906002)(7416002)(71200400001)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0659;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x+6nV/auBa6wbz0LmggnwoOo739B3chCAaKhAMIUOXen5JFv/LcF0b8JXoiu0ZS0QVkMtQ4lfD3pVpZxm7j9dIkpuOTOf5YIpsZ1j7PwC8+1+bMZZ3n9qAWOSOKLiGvpz5TIDCBEjU7JMrRP4SKbai6hqKW4zC/sRfAXEmkVxqvMOoMV5kTtPV6HIIP/jF3x2IxK3sWXLgYfNWHPWbOs9yHCaGxSSAO2LJWOQ0XyZHGlFNF27Nlu7IPX1Rel4mOz5D38dI6W85WHZMst+zu+CYL00JE9Okjix6g8mRRHPFLVIDSaIPcbWFWdHDBFFwa4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd89d39d-3521-459d-caa0-08d671704840
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2019 11:40:38.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Parse DT and initialize corresponding dev/pipeline attributes.

Changes in v4:
- Rebase.

Changes in v3:
- Fixed style problem found by checkpatch.pl --strict.

Changes in v2:
- Unified abbreviation of "pipeline" to "pipe".

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_dev.c   | 76 +++++++++++++++++++
 .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +
 .../drm/arm/display/komeda/komeda_pipeline.h  |  7 ++
 4 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_dev.c
index 4dec259cecac..7257248463bc 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -9,6 +9,76 @@
 #include <linux/of_graph.h>
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
+	pipe->of_output_dev =3D
+		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
+	pipe->of_output_port =3D
+		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
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
+	mdev->irq  =3D platform_get_irq(pdev, 0);
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
@@ -71,6 +141,12 @@ struct komeda_dev *komeda_dev_create(struct device *dev=
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
index b48d711071be..9c43565fec2a 100644
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
index 179122fc93ff..edb1cd7795f9 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
@@ -53,6 +53,10 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
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
index 7daba0e1946b..d2222e46b10b 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -288,6 +288,13 @@ struct komeda_pipeline {
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

