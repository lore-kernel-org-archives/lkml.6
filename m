Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1842FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDB21217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="qPpDgLlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeLRXTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:19:40 -0500
Received: from mail-eopbgr50137.outbound.protection.outlook.com ([40.107.5.137]:37442
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726422AbeLRXTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rp56nUICYW3bwFtnpZHkL20fPwZeqEStXNNeB/GkzK0=;
 b=qPpDgLlBg7z+0/ABJj2wdU8b9RLjlBQ+Qii/DjJ6f4pf20Mz84vyLTJr+JOfjqsLEfbEl91OhWQl7ePbR+AzhfSf0GN35Tx5eGRrvCZxjPSZWlLFDpnesOkc/j5reek2vLrJkgLrxqFE8RY3b8dRlcX+bvzNYdAO0h9GixH7GvQ=
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com (20.178.13.204) by
 VI1PR02MB1293.eurprd02.prod.outlook.com (10.165.231.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Tue, 18 Dec 2018 23:19:34 +0000
Received: from VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8]) by VI1PR02MB5119.eurprd02.prod.outlook.com
 ([fe80::11d9:9fe:f412:46a8%5]) with mapi id 15.20.1446.015; Tue, 18 Dec 2018
 23:19:34 +0000
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
Subject: [PATCH 3/3] drm/bridge: add pwdn-gpios support to the lvds-encoder
Thread-Topic: [PATCH 3/3] drm/bridge: add pwdn-gpios support to the
 lvds-encoder
Thread-Index: AQHUlygj+VZIUCB5IkOlsrsBprD/VQ==
Date:   Tue, 18 Dec 2018 23:19:34 +0000
Message-ID: <20181218231850.3572-4-peda@axentia.se>
References: <20181218231850.3572-1-peda@axentia.se>
In-Reply-To: <20181218231850.3572-1-peda@axentia.se>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR0502CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::15) To VI1PR02MB5119.eurprd02.prod.outlook.com
 (2603:10a6:803:b7::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR02MB1293;6:D4WtamXi4NPljBFaxKKAp9pOc6S40rcCWajJo3XlxJvR70Yx2S5omHfybAsYEC5T06xHfjBJdslR03E9gVrUrb2baRAXex0VP13WnQv8yK0qKw2+N4+NLacRAKVywoSauj1UHaUYuRlKdfNMfB5hWOZVyJHaMp51alNs1U50DsCpczhI+e8nltEie49g3jPpW+z+Fe4yXahmp7uPGl1KamfRkOJf70s0JzA3Oxb5x8QKzRLsWwirHbTQxCCER6IFqUyNM2iwjwBYoQtfrjSrjrOTonEbBgcma78e+g+26y8t7qJZTLFS5AlxulgdlfZCi3bqkhP6yOyxmZ17Q4SoTJWzRHC7bNLq38DfjsUUgQQQOEP8RLfFDEByvfSgjCEVyFv2+dN8t+DYWohPAjKDcioJSyVNWavgR7g8QIjCfZ6b7XdLYNB0iHaTkRnZlJ8+0HTJh6I8wW/F7oCJCFDP5YBCPUpAy6vtXk0GF7X92SY=;5:wEiw05adye2jDsGtkPE557SxE+kcBgjiD7z9bCyeZVn6/DUySdvxGF0aZCNOwGNO87d4Tt5CKJ/7gstMskX+naupCod7gdXK6NhS8pGM4z5kWYo0QhreIi3dH9NA6Vx4TiK8PeebLfbkmnfcMjgvCWzZDepQDOm3s/PnLNJpXT4=;7:8gjJ+NRRmLkIxWScHNhR75HLjMEduId8ojSXsMSQ0s4TNfSyjndYaV2SPJIZD/LihsIt67JDjILFpFoXWWxAy9AO2WQS/+IL/uyBV8TukUxkZZIyWruc1wNtStPyj+cwt9o0kWN2XujpYbrL8A4shQ==
x-ms-office365-filtering-correlation-id: 15480188-0f26-468e-ebf4-08d6653f457d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB1293;
x-ms-traffictypediagnostic: VI1PR02MB1293:
x-microsoft-antispam-prvs: <VI1PR02MB12932A2AA95341304D5ACA3CBCBD0@VI1PR02MB1293.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB1293;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB1293;
x-forefront-prvs: 08902E536D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(396003)(39830400003)(376002)(199004)(189003)(2351001)(305945005)(2906002)(105586002)(106356001)(7736002)(71190400001)(486006)(71200400001)(66066001)(54906003)(446003)(14454004)(50226002)(508600001)(5660300001)(81156014)(6512007)(8936002)(25786009)(476003)(11346002)(575784001)(6916009)(86362001)(53936002)(386003)(26005)(52116002)(102836004)(256004)(1076003)(8676002)(81166006)(2616005)(14444005)(68736007)(5024004)(6506007)(186003)(4326008)(36756003)(5640700003)(316002)(6486002)(6436002)(74482002)(76176011)(99286004)(3846002)(97736004)(6116002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB1293;H:VI1PR02MB5119.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oxbD86KgeJGblCmVuTKrPyKOlcXld9QIrLTndUsRu3jzK2uK9qpCVowVtqjxXIO3BGqefEHe5EALlyhX09VHmE7P6A3c4Dj5G5ck+05w6m121F5ROQ7kYJQ9WG6gWYz2dGu9ncm8HOrNTJ8mw4+D5leu/GOXcXmwLvOsrDlOwTWjAYC2gqmtKW9sZrJ3YxnlzHdhoKireitN9hVX33yQURPAMKMp3lz6cXWaQpUWF6BZyZ5rrEft9lL8N2BjJg8yRslvzg2eAoyNXzXwLE+qcN4IlPsNUiJh68JZw1lDzo9pU2N9cBva85QUJamkB4js
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 15480188-0f26-468e-ebf4-08d6653f457d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2018 23:19:34.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB1293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optionally power down the LVDS-encoder when it is not in use.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 34 +++++++++++++++++++++++++++++++=
+++
 1 file changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index 75b0d3f6e4de..43d584a6a6b9 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -11,11 +11,13 @@
 #include <drm/drm_bridge.h>
 #include <drm/drm_panel.h>
=20
+#include <linux/gpio/consumer.h>
 #include <linux/of_graph.h>
=20
 struct lvds_encoder {
 	struct drm_bridge bridge;
 	struct drm_bridge *panel_bridge;
+	struct gpio_desc *pwdn_gpio;
 };
=20
 static int lvds_encoder_attach(struct drm_bridge *bridge)
@@ -28,8 +30,30 @@ static int lvds_encoder_attach(struct drm_bridge *bridge=
)
 				 bridge);
 }
=20
+static void lvds_encoder_enable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder =3D container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->pwdn_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->pwdn_gpio, 0);
+}
+
+static void lvds_encoder_disable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder =3D container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->pwdn_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->pwdn_gpio, 1);
+}
+
 static struct drm_bridge_funcs funcs =3D {
 	.attach =3D lvds_encoder_attach,
+	.enable =3D lvds_encoder_enable,
+	.disable =3D lvds_encoder_disable,
 };
=20
 static int lvds_encoder_probe(struct platform_device *pdev)
@@ -45,6 +69,16 @@ static int lvds_encoder_probe(struct platform_device *pd=
ev)
 	if (!lvds_encoder)
 		return -ENOMEM;
=20
+	lvds_encoder->pwdn_gpio =3D devm_gpiod_get_optional(&pdev->dev, "pwdn",
+							  GPIOD_OUT_HIGH);
+	if (IS_ERR(lvds_encoder->pwdn_gpio)) {
+		int err =3D PTR_ERR(lvds_encoder->pwdn_gpio);
+
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(&pdev->dev, "pwdn GPIO failure: %d\n", err);
+		return err;
+	}
+
 	/* Locate the panel DT node. */
 	port =3D of_graph_get_port_by_id(pdev->dev.of_node, 1);
 	if (!port) {
--=20
2.11.0

