Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A06B218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="V8aAk2rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbeL2HIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:08:12 -0500
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:48352
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbeL2HIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB1NMfq4FVO+e+ZbWUt3Tcl83AUy/jPSzD3fj36JWXI=;
 b=V8aAk2rgv+H8fm1WLfQM3EF4hTfoeZnIhXoOWQwEcN4neXmJTIyykpYm+afYzN/WLB8X5MjFbhClYX8g+LRtao4NuIRLD4NXjCZQMBdk7Ip5XtNSghD5t9QYzdxLzZlhkx98PmHSjkLJxphLGxqLEY/EiiIM2hJlFPhTmUOTThQ=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:37 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:37 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/5] drm/bridge: lvds-encoder: add dev helper variable in
 .probe()
Thread-Topic: [PATCH v3 4/5] drm/bridge: lvds-encoder: add dev helper variable
 in .probe()
Thread-Index: AQHUn0UtgZZip4D7Y0+gDT/zYJbnWw==
Date:   Sat, 29 Dec 2018 07:07:37 +0000
Message-ID: <20181229070649.21308-5-peda@axentia.se>
References: <20181229070649.21308-1-peda@axentia.se>
In-Reply-To: <20181229070649.21308-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0002.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::12) To AM0PR0202MB3267.eurprd02.prod.outlook.com
 (2603:10a6:208:5::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:CADVE5MvwxUF8NS1560jT3gRBGoNfUBak1IShl81Uip2/LRk6EecyHRQ6DxTZsaKUPUHdeVuamYgHIvFwDjtr+IEy4Rlui9zyJP+YyIKL6S7Pp9SxxHh6GMGqYqad2ZG2Iex7gwvcUfPC/6UMMsvzkYiLYF3FCWtcTXYxrCfNuYbbykH8emXlIir1WPXO838v4TFLHAWjBEXFRgs3vk0wS3EcbN4HBSm90VBL5oIwruUuWuCdcZE5lRQIC8tI2lL0MgqfWSLHBpq8BpbwPCW5R4iw8HHG8NBen5odJ4Uo/MlpGMWQgoy9Po8jBlfUzMGRZ2hbSKGX3j3lVSAv31/rFVasg/3o+OeNfRwntLwjolmMFaudWDHtCPlfPvkJ8GqQCGDmcQNh0pFCAedYK1SO7A/GQC+i3hZxnODrHx7DtazBBgoUNg3bBj76SfZ72oS3M/IpdqxFA1oC4B+tNzshg==;5:+mudUt6wyPi8820lxQwbmu+/OMG2aOuuKMmVPJBz2wdsursr0eAmVvpCtN4ehMcU25BYpuXydbt0XvR0IyLGTk4V9qYWfBQFbwLB28j+M7EOVAfmNy5xx6+JDGxs4dmhgT5PpurDvK0Ry+ByXodAkhoADcaP50b27090iXEbHZw=;7:h2xBzv8Y656PkZQf8nYSOmcTpUCURT8gGtSu/KRP1GdAToG5f2jP+g73EZMN2d8l9XigW7p63gh4Hyog3zL9bi950kcSgHWSm48UtrSDQncPIAqxOFuf6gPRlgfsfVGzO0Rsfei1+YCdQy0sbzSSYw==
x-ms-office365-filtering-correlation-id: c420e574-c896-4e11-d79e-08d66d5c503a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB3459763D0B4312B4FDFBA036BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(5024004)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(7736002)(2616005)(1076003)(86362001)(575784001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(446003)(11346002)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(76176011)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ezQzJYeJEX44jZcxTit++2WidcgfkmBM7jmNqTgncC5nVSv1PlBSi4Th5yhimeel+GzsbESVdlhEZhL50tgLTS65HanQ0jtGwikpEmjOl3ThI4ZR76wBhyfMRKhZeuU5vkDBCkdEcOI11FjF+PVlr9X75VRrg5RHWuxDpBycnXHVCRrrwjDTIX9ObnpM6CnfvFXPcjqQwat1Vdy+AfNWurpuHXCAVWAGDCzeqBzhNiB0nZIvxHRhLqmN3lzM+WUIg3gKNEOX8f4oS4uiJJZgV7fzob1+2qOH/MY8IdLBtuQcUMJ7MPMp5YH6f2vpEx2z
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c420e574-c896-4e11-d79e-08d66d5c503a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:37.3278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the code easier to read and modify.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index 75b0d3f6e4de..f6770e83d49d 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -34,48 +34,47 @@ static struct drm_bridge_funcs funcs =3D {
=20
 static int lvds_encoder_probe(struct platform_device *pdev)
 {
+	struct device *dev =3D &pdev->dev;
 	struct device_node *port;
 	struct device_node *endpoint;
 	struct device_node *panel_node;
 	struct drm_panel *panel;
 	struct lvds_encoder *lvds_encoder;
=20
-	lvds_encoder =3D devm_kzalloc(&pdev->dev, sizeof(*lvds_encoder),
-				    GFP_KERNEL);
+	lvds_encoder =3D devm_kzalloc(dev, sizeof(*lvds_encoder), GFP_KERNEL);
 	if (!lvds_encoder)
 		return -ENOMEM;
=20
 	/* Locate the panel DT node. */
-	port =3D of_graph_get_port_by_id(pdev->dev.of_node, 1);
+	port =3D of_graph_get_port_by_id(dev->of_node, 1);
 	if (!port) {
-		dev_dbg(&pdev->dev, "port 1 not found\n");
+		dev_dbg(dev, "port 1 not found\n");
 		return -ENXIO;
 	}
=20
 	endpoint =3D of_get_child_by_name(port, "endpoint");
 	of_node_put(port);
 	if (!endpoint) {
-		dev_dbg(&pdev->dev, "no endpoint for port 1\n");
+		dev_dbg(dev, "no endpoint for port 1\n");
 		return -ENXIO;
 	}
=20
 	panel_node =3D of_graph_get_remote_port_parent(endpoint);
 	of_node_put(endpoint);
 	if (!panel_node) {
-		dev_dbg(&pdev->dev, "no remote endpoint for port 1\n");
+		dev_dbg(dev, "no remote endpoint for port 1\n");
 		return -ENXIO;
 	}
=20
 	panel =3D of_drm_find_panel(panel_node);
 	of_node_put(panel_node);
 	if (!panel) {
-		dev_dbg(&pdev->dev, "panel not found, deferring probe\n");
+		dev_dbg(dev, "panel not found, deferring probe\n");
 		return -EPROBE_DEFER;
 	}
=20
 	lvds_encoder->panel_bridge =3D
-		devm_drm_panel_bridge_add(&pdev->dev,
-					  panel, DRM_MODE_CONNECTOR_LVDS);
+		devm_drm_panel_bridge_add(dev, panel, DRM_MODE_CONNECTOR_LVDS);
 	if (IS_ERR(lvds_encoder->panel_bridge))
 		return PTR_ERR(lvds_encoder->panel_bridge);
=20
@@ -83,7 +82,7 @@ static int lvds_encoder_probe(struct platform_device *pde=
v)
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
 	 */
-	lvds_encoder->bridge.of_node =3D pdev->dev.of_node;
+	lvds_encoder->bridge.of_node =3D dev->of_node;
 	lvds_encoder->bridge.funcs =3D &funcs;
 	drm_bridge_add(&lvds_encoder->bridge);
=20
--=20
2.11.0

