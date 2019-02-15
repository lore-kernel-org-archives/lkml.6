Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1093C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FBA222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZB56Se3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387981AbfBOSHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:07:39 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:62496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfBOSHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TboPlUQ5SZrLo9jg+s3YP+TgOxztLWLaU5uOPbWF2Q=;
 b=ZB56Se3hmnYr81vPKBcUfliiOemKtNleCAO334/nSA+57GMnLMJnj6SFnSEiSmjfs3NTJU/CiVldPeAUHyPI1G45YTBPqCGQErMwE/hJFKqb78iFftQESf0UUAz4JYqvJEo89YxyA8A8NxmXh4Sn2KG+yKGjijZRMlvhV0/VHd8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4385.eurprd04.prod.outlook.com (52.135.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 18:07:24 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:07:24 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 3/3] arm64: dts: imx8mq: Add the opp table and cores opp
 properties
Thread-Topic: [PATCH v2 3/3] arm64: dts: imx8mq: Add the opp table and cores
 opp properties
Thread-Index: AQHUxVlNIq31A6OcskGGyy1wv+2NnQ==
Date:   Fri, 15 Feb 2019 18:07:24 +0000
Message-ID: <1550254032-16451-4-git-send-email-abel.vesa@nxp.com>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0043.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08f99247-b403-46cf-8468-08d693706fbf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4385;
x-ms-traffictypediagnostic: AM0PR04MB4385:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4385;23:564rBYTdU9PwWlgHfuPKe8gH9yxRnbv1widO1C/?=
 =?iso-8859-1?Q?n4gN4uiy7EWMtKJVwymZJWmJQrXAHwEnYQk6LqgXto3vix1pbd8OVke7jG?=
 =?iso-8859-1?Q?ax+TDahiBvpvh6wWdq52yt2fGV1cYNxHQ+abpCVrfX1e3icuGINnklOTMk?=
 =?iso-8859-1?Q?UHucJtW3TjYfb9iGS0s/ch1nL8qbIle10xb3nwLv9cnfD7WjgHbTjv9KEO?=
 =?iso-8859-1?Q?Y7Zr/U3vHIt3D5ebZtg5303x/E2TOYlrJdPzxvkiT/qOKvPUkq8gPqwHue?=
 =?iso-8859-1?Q?y1Fw5RswClyw7OsQwUieAcPxuPObrhhK3fEepRmNyFkdZ9sP04QHVdCubF?=
 =?iso-8859-1?Q?0esBztaMRl8asE8jFCasFPYdwm6uKkcZlmB2BMu2b9+Szoj1GdWzo7KGE0?=
 =?iso-8859-1?Q?WpugR9gFPDoWhU7rhmG7nEIOcr2G3UMqt5UqPnWmqPW6QSqwQA7AzqHdRS?=
 =?iso-8859-1?Q?yY2omYQZrwM6Y3y669kiGJNhxxW6mMbmzpgMyzjWMHCHyfCSQyR0/eoVbr?=
 =?iso-8859-1?Q?C7bKvd+g55XbmRXKl79un7f9B5bUqjAYS/eRrRu7XPJzZsU/I61OP0uBR1?=
 =?iso-8859-1?Q?pO6IqoUL/jsgOI0pQ6an6tuIgEdp/okjpBSrpyJzikNsFbruDuz/LgJxiO?=
 =?iso-8859-1?Q?u3TN2k+GPN/zehnp5tpyJYf7kOYmFppgm0gSaUT8VCqRHyfv4NSC2JlUMo?=
 =?iso-8859-1?Q?2i3Ii3S25+f0BKAKzwqWBQ4j8dBqE8arI1ZoWUJt9/ixCJUOQZPUc+qrAs?=
 =?iso-8859-1?Q?NplTyEDjZXFIOyCMXxOidFDWHQbykw2OwD6UbdIuLwUv19iIxZrXcP6wkB?=
 =?iso-8859-1?Q?ir7bQxQVu3yOTPf4pO64XZYJYzBwmVLDFx0R0MfRSn8yLzQZ3O0W3KIe/e?=
 =?iso-8859-1?Q?JL8K+NNYNptGmAhk8hxwm3eLQ6ybruXZjfR595fMQuahG1IZrxLYtDdOHg?=
 =?iso-8859-1?Q?vAFjHOtNORQbOPt/B6aqVTt54Ac6fqxoHHmDXSeElJUqmjutv3sZNi36S7?=
 =?iso-8859-1?Q?H1VPm/vK6oUQPAf+dleC2RYm08ZesXMAo22wUZf9sxtScR3Q3MaEQTqR9T?=
 =?iso-8859-1?Q?fkeSO+uW+Gk1nWwjjlezdfQ7LzRHm9EcfCiUljAjODZz5F4pIqXvUt1OMq?=
 =?iso-8859-1?Q?8TWa3MyetFybzkCKx8pGiWQD1EC77Oqq0OviknJWpAiE0w6rl5AnoHBjYE?=
 =?iso-8859-1?Q?NfXCyPUVgWYbx5Ud2npA8cZ/3QA0C+Mn8SIbk6NVyvittwizZuygI2Kq4h?=
 =?iso-8859-1?Q?s+7eHH5LilScosH07DL+CsBiGuBbPOF4odwyo5H8Q0aCbXpnZz0KW/jGY6?=
 =?iso-8859-1?Q?jw=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB43857729EF68A320CE889860F6600@AM0PR04MB4385.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(305945005)(86362001)(97736004)(71200400001)(71190400001)(446003)(966005)(102836004)(14454004)(66066001)(478600001)(6506007)(6436002)(386003)(2906002)(7736002)(106356001)(105586002)(44832011)(8676002)(6116002)(81166006)(36756003)(81156014)(3846002)(476003)(486006)(99286004)(52116002)(2616005)(8936002)(110136005)(76176011)(14444005)(256004)(54906003)(316002)(26005)(53936002)(11346002)(25786009)(6486002)(4326008)(6512007)(68736007)(186003)(50226002)(6306002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4385;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QdHryt1tHu7gfRUKU6jqhC1L97Jdb7F0WfQJ1UK1abKekVQ6ssCWJbK4m8fgGR6cKw/4r4SvnSSZHekUxeWg4ta4oy3eGvd3lw1DrTXLmtLCfjdORAqlLhvRLxYPvohiFxphoHtudqvmt7a+sXqbEWYQth836PQFTYk4beSTqbqHyldot8EHOWMIWtiudyzAYqQYP03FaPzhzsAgIWo7LmK/QPBjdWfa2U7/LLEfy82684iIV++2OAHL+j9AwBgZfSxQJt+/u1Dj4RTVU2NpXl/bKqEHpzoH0JmkZK2lK40uJ+OkagPnXtFD8QwF8aZbL9NQJGJAsjEEzDJwUy+IPGMJLygRM23sAX9m8Yhi98WLaNaDMIJDwLYbfjVpq0Ng9/Ad539Bh8vvbm9LcpiApvBa4b49BoGofHwfI2SJcd4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f99247-b403-46cf-8468-08d693706fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:07:23.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0.8GHz and 1GHz opps. According to the datasheet:
https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf
section 3.1.3 Operating ranges.

The 0.8GHz opp runs in nominal mode with the regulator set to 0.9V.
The 1GHz runs in overdrive mode with the regulator set to 1V.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 1a89062..ebdec9e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -91,6 +91,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_1: cpu@1 {
@@ -101,6 +102,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_2: cpu@2 {
@@ -111,6 +113,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_3: cpu@3 {
@@ -121,6 +124,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_0_opp_table>;
 		};
=20
 		A53_L2: l2-cache0 {
@@ -666,6 +670,25 @@
 			status =3D "disabled";
 		};
=20
+
+		a53_0_opp_table: opp-table {
+			compatible =3D "operating-points-v2";
+			opp-shared;
+
+			opp-800000000 {
+				opp-hz =3D /bits/ 64 <800000000>;
+				opp-microvolt =3D <900000>;
+				clock-latency-ns =3D <150000>;
+			};
+
+			opp-1000000000 {
+				opp-hz =3D /bits/ 64 <1000000000>;
+				opp-microvolt =3D <1000000>;
+				clock-latency-ns =3D <150000>;
+				opp-suspend;
+			};
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x38800000 0x10000>,	/* GIC Dist */
--=20
2.7.4

