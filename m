Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F456C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BE321848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="CjNb6xk4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfAKPTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:19:23 -0500
Received: from mail-eopbgr70093.outbound.protection.outlook.com ([40.107.7.93]:61900
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388293AbfAKPTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB1NMfq4FVO+e+ZbWUt3Tcl83AUy/jPSzD3fj36JWXI=;
 b=CjNb6xk4BT5CoZ7DiUoBE7owOopXCrOyjORTqZmGx1etplETSl8R7Ka+RYab6hs91kltSXjWOKvp4uacwTeb6j0a8vVJVvpeHl4mWr5EfNArtD9OttxWdSejLgxFzzS5GvsH4piDbx+NysEHcAWEfbdq8DhAW1IzXzlCTs4nEQY=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3735.eurprd02.prod.outlook.com (52.134.113.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Fri, 11 Jan 2019 15:19:11 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 15:19:11 +0000
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
Subject: [PATCH v4 4/5] drm/bridge: lvds-encoder: add dev helper variable in
 .probe()
Thread-Topic: [PATCH v4 4/5] drm/bridge: lvds-encoder: add dev helper variable
 in .probe()
Thread-Index: AQHUqcEAzPFcqEwkg0i7hxnCwqBC8g==
Date:   Fri, 11 Jan 2019 15:19:10 +0000
Message-ID: <20190111151843.11114-5-peda@axentia.se>
References: <20190111151843.11114-1-peda@axentia.se>
In-Reply-To: <20190111151843.11114-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR07CA0035.eurprd07.prod.outlook.com
 (2603:10a6:7:66::21) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3735;6:NC4DHMn33byVV4p2aypkNqxAZ9g0yy5pdW5uHxY0Sx64XFavQNmyaDGGRf6PqxqAq+StO6rFPT/2rVFsSCdd7fjZQVxLWRL96dkSfKjBfwx/0NGgTczQZL7DynjAYnKuEweB15Nlvju30/F65PjrRZxwLGC0pF9OtpE8VKv6SX8Mn9r3HaCJHVmZCCn/9GWfiUAPGjWqxQKj1ixfkS/d9c6uRrZZJY2+CxqPIu18nEi0WHdNyF/W6FvCgnxjQ0eNsF+Y1CyEwJtiug0pSGIbUzKvs+7W0Ru9YSnCUFDJlFSTzCz5bqD5LpoJsShp4taq8WtCxTprM0sPDNijpXXT6MdCJvsJj84/yAmaOWQrqmOHJ4wewTMB8miE4dgZOUJz5IC1sXmcdtKGUKir72XdLRat5f5LkucJ2cP5udPdSUkLYqUoUC6g9xCQvgQ8BJ8x4bg430ihQV5TEh5sUSDaig==;5:x0/1C/XdtqdafRfd8oK/4cfTX8SqfKPnNs3H7pmQg7lhRaYPEqjaRfKneYrzj5kP+J8lfXje5bZXZn6r2h9nkO5fYMOVyGGzQb0hlhxVSmJmdxNTn9Y3BOlkDvzb/XbVS5LyfzMWErg1A+8qgpSsfXYSvxNb3I/Ef28kZE46ZYTyFMt+6qUwnCD0XnyOCRqk2IxjeAu66bTJIIKIQkKphQ==;7:sI9bQgbe8C8yoA/Ohe9WLvNq7GcwiKgF87gBYpmDOeNF3ZzQ8RZnL8FHAz1N19vWSkG65EhD0QDhBlqebpt8pVHBVKkdBE87T4/Ku8JW4w8vgi2nH9Sgifnx+ozdK8xiZfJ+gcMh4q/Wo0G1CEjvjQ==
x-ms-office365-filtering-correlation-id: 6f6c1386-730d-497a-ef80-08d677d82305
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3735;
x-ms-traffictypediagnostic: AM6PR02MB3735:
x-microsoft-antispam-prvs: <AM6PR02MB3735242F856D9413774DE598BC850@AM6PR02MB3735.eurprd02.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(346002)(136003)(39830400003)(189003)(199004)(2501003)(1076003)(14454004)(99286004)(54906003)(508600001)(5640700003)(68736007)(6436002)(97736004)(2906002)(71190400001)(2351001)(106356001)(6486002)(316002)(105586002)(71200400001)(86362001)(575784001)(386003)(6506007)(102836004)(66066001)(6116002)(52116002)(76176011)(3846002)(6512007)(53936002)(2616005)(11346002)(476003)(446003)(74482002)(8676002)(81156014)(81166006)(186003)(486006)(5024004)(256004)(26005)(50226002)(8936002)(305945005)(7736002)(5660300001)(6916009)(25786009)(4326008)(36756003)(142923001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3735;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TkcZfvtRRMm05BV51USo0p23BUQVaK8b7F6pSEd/+5hg9aeWwJMhMFIt616LXO54RlLdj+/+BfUfTrZ2h5ekq5GKSQl85xV4c8tD1LcPA17cTXTAd4xVMFsZfE9v+XyHnlU1MgqAE4cx6T4qybm4ThP+NSQUGDw29RudR34onqEEL16l55ANkn+O0j8Z5F84s1PhA8lE6NxIvmyoIzgexb/R1Z9SRfSw7xWVmk2JAyEweqUFp9a/0833QLEswJwZ9flk3iwqiSDjRyum8zWHUtIR/0XJNKlNT2/OzpDiha5y4zpC+IemNRbYd025aupHUnc+DuKAX0gYjxoE5MO3fhPYLpaAE0y7peAA56yChLFFIxAQ6OuTjj+6XJ2behOyE0iQFSANq6jzHRo5uW03ci7SNKoNmRfTIIuq1gSafz0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c1386-730d-497a-ef80-08d677d82305
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 15:19:09.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3735
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

