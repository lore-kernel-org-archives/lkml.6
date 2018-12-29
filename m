Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C3AC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CFB22146F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 07:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="pKqiXAw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeL2HIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 02:08:17 -0500
Received: from mail-eopbgr40126.outbound.protection.outlook.com ([40.107.4.126]:48352
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728995AbeL2HIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 02:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vttgkot6py7X0umJ7OFAEroIqmztlJ7OqxP40/0h054=;
 b=pKqiXAw+YsmObnGdeeFDOt77tBWWUmg4wF5E8eNgokXP80LjDEXdBad0aYsSLMKjz1fAVypsm5eVdoynw8TMBHfB0xFx3Vn+rw05sZA6AfiY5Ll1azDrecTXYRiQ9fhHHeimn5NaZsy7cWNkO1zMYoSydOXmDP9Xqt25zpZeuRw=
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com (52.133.34.148) by
 AM0PR0202MB3459.eurprd02.prod.outlook.com (52.133.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1471.20; Sat, 29 Dec 2018 07:07:45 +0000
Received: from AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422]) by AM0PR0202MB3267.eurprd02.prod.outlook.com
 ([fe80::cdf9:e79c:8ad0:7422%5]) with mapi id 15.20.1471.019; Sat, 29 Dec 2018
 07:07:44 +0000
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
Subject: [PATCH v3 5/5] drm/bridge: lvds-encoder: add powerdown-gpios support
Thread-Topic: [PATCH v3 5/5] drm/bridge: lvds-encoder: add powerdown-gpios
 support
Thread-Index: AQHUn0UxSwSuD12DD0+0q+RswKrSuQ==
Date:   Sat, 29 Dec 2018 07:07:43 +0000
Message-ID: <20181229070649.21308-6-peda@axentia.se>
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
x-microsoft-exchange-diagnostics: 1;AM0PR0202MB3459;6:BKBBY6XX52zs+9T4KDHYrnleUq179pgYsqqIn0ud9BUvkrOYWWca0uA0LocTOteVZ0z4WWODKqBlkTCTYScADx6GiInuB7XAVjIsK45dd5YTtg29D5Wvw2r9Mw5CcY0r3uZzycy4C3h9fXmM32jvjO7GKGHht/jD9p9+clPT1iHI/0Ku6vPCLM9o2izVPsRIs+9sA6dEwRgrjzJS3/W7PLFMPbjcalC+ZIwkybdPt0vSRtqYUF1f8M7QNOtigz/7Xup+xJ3CzWOVIj0moiPaDfKwmJzWC8LBuV9B6Ceeu4z++fW0yEXJrNai0McfzcrWgzeKfD9KNhewSJZTf+IPmVepUXeUu15LLUo8ap/3yOzcKsY1c5yXk8N+f03KyjCld0O+L0CwUGp67J4AeXPThnKYdwWgaWXW2oKranODhLrt2XgqKQv1KsBDrOtoJz2mCSqMjUETdqeRyzX/RSbTxw==;5:Pr90yGa1JDAdFONxZovoZQyh4LeLYnHUcpCttqEZaGCg5rk8Tcbldj48ffKuazajlnmV3K5zKzXNGy4k/a+e4Xpl9zLOSWj+a7FwgzKwFEdU8TkJrMf2wBANrKQ6XkP4JwKcpNRPg4mFNOqZLjNDIEj318KCGNJ7hRfyU4DZvI0=;7:IWbTaNjfXdmx6MW5qgyarrfpvmyTkT4dFvwIUY5zqMutQr1eaM0GQT/mPyEOLHX/RpVeAQWYqtm1XZ2VwaPRuoV8Vmh1TxIspDXtPFIUvkP6iGf4wDGQkijBnkE4j8I/tJ+qP6zBBKLcCeuzeaotKw==
x-ms-office365-filtering-correlation-id: 67490965-1af6-4c23-1ec0-08d66d5c537a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM0PR0202MB3459;
x-ms-traffictypediagnostic: AM0PR0202MB3459:
x-microsoft-antispam-prvs: <AM0PR0202MB345909AA7EA3DB589ADD4BD5BCB00@AM0PR0202MB3459.eurprd02.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220055)(2401047)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:AM0PR0202MB3459;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0202MB3459;
x-forefront-prvs: 09011458FC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(346002)(39830400003)(136003)(189003)(199004)(71200400001)(71190400001)(66066001)(6916009)(5024004)(305945005)(99286004)(8676002)(81166006)(106356001)(6116002)(6436002)(81156014)(14444005)(7736002)(2616005)(1076003)(86362001)(2906002)(6486002)(8936002)(476003)(74482002)(54906003)(3846002)(256004)(446003)(11346002)(486006)(68736007)(50226002)(186003)(5660300001)(316002)(36756003)(14454004)(6506007)(6512007)(508600001)(76176011)(2351001)(52116002)(97736004)(26005)(4326008)(5640700003)(386003)(25786009)(53936002)(102836004)(105586002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0PR0202MB3459;H:AM0PR0202MB3267.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B4UrawAijtjhW34RsdYmJeJ4TER7e5O9MPeZcfAwgGbLctjj5dgDMVceOvxXIKQOKAnlBYTVYPaR7je0MCUKkeIhKIAFRv8fZNQ49BvABeWbUKvFKTwOMJV6Csp7nKxx/4YT3+D7CiTjbJclFuqBAMDV4XF2eXJSha8zW8WYVgHFznSGKQ18wkCe/gy/Mb4pqLjXrMpnGea8owu6H1PJyYtVIIMOtLmgm+frin34Bfd7t8TS47M8Rw8erHjqHp/Czw7tsYRakrNkIVWQFGDEg1kq1NyP6OWKV1t6xNFXQwwEuot+oGaP2zRtI7/bvbEY
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 67490965-1af6-4c23-1ec0-08d66d5c537a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2018 07:07:44.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3459
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
index f6770e83d49d..36d8557bc097 100644
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
+	struct gpio_desc *powerdown_gpio;
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
+	if (lvds_encoder->powerdown_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
+}
+
+static void lvds_encoder_disable(struct drm_bridge *bridge)
+{
+	struct lvds_encoder *lvds_encoder =3D container_of(bridge,
+							 struct lvds_encoder,
+							 bridge);
+
+	if (lvds_encoder->powerdown_gpio)
+		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
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
+	lvds_encoder->powerdown_gpio =3D devm_gpiod_get_optional(dev, "powerdown"=
,
+							       GPIOD_OUT_HIGH);
+	if (IS_ERR(lvds_encoder->powerdown_gpio)) {
+		int err =3D PTR_ERR(lvds_encoder->powerdown_gpio);
+
+		if (err !=3D -EPROBE_DEFER)
+			dev_err(dev, "powerdown GPIO failure: %d\n", err);
+		return err;
+	}
+
 	/* Locate the panel DT node. */
 	port =3D of_graph_get_port_by_id(dev->of_node, 1);
 	if (!port) {
--=20
2.11.0

