Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D258C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A4820652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7QoByKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A4820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJWQ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:58:49 -0400
Received: from mail-he1eur01on0083.outbound.protection.outlook.com ([104.47.0.83]:53120
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbeJWQ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:58:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hfm+TVmoA6lE8U/P/0JPp8plNs9LYR0T0kZMuNXzUc=;
 b=d7QoByKdrwvJy+C13w9m1bdtzcQeHPAw4uGnmlS+k6Fnr1taTGSvi4ZgEKfMFhSre30OxIr5d7rd2fqPVQvUZYhAw9EOseB9n9CUO12IdgBJT0DZNaeaGzwTN/mHQ1yLrmqljm35ruPsc5xgVo8hJVH6GkaMjYHliTEUDhB2k3w=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB5077.eurprd04.prod.outlook.com (20.177.34.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Tue, 23 Oct 2018 08:36:17 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::14d:71ff:bbe0:a643%2]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 08:36:17 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH] ARM: dts: fix imx7d boot spi dma setup error
Thread-Topic: [PATCH] ARM: dts: fix imx7d boot spi dma setup error
Thread-Index: AQHUaqt3ioSACcXgGEGVITyY2hPSvg==
Date:   Tue, 23 Oct 2018 08:36:17 +0000
Message-ID: <20181023083356.17579-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:4:91::13) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB5077;6:/bcubWgkBzfcdqYR2FOCN1PDBNRpQKCMKXb6X2z3CrXJTip+T6v5wbICrhqJZsWgYglT7V1vsbissWM04UgBJdmAygTrinTY/WzrS9PqP4v+tiBnZ9CbXaLEQyfR212e+5YYWg7IEo2KO39cKzg0hXeDVSBlfYu3+jZjACiTOx4k0tJPETK6sJhfdy1LDyIoy4ecKMwWQfaREZs+2TtK/K7Trqgea/pU7TmmUopEeIOaxF+8T0igFTWfsncyuCQKzXEQV6IBcArLU9AWiuXYSpfWRowlUMve9/Q84dt4nOmbpcZXVxkgh2WhgzJIkwa+ET2UNWdWC/NQtNbvvQW0neARL/m2aSFE6qju+Gd0Vww2fxJFkNNBmaIvpmojU61d9/BZkmoOTWOIJ6oZWCVWzdRM/JySMEspGzPqISs6P3vXz3sb3UtJo2ROEYs7nGZDfQ/CUxJkcCDFuG/feFNlIg==;5:8vNtojcNaLASKsQJB15fADNNocAJQvR1CwmuL4ogbCSky80JOqMGRfnJ5lbqYuzgC11s6x7hqusmEcZXqzFuK0OE8rdLTzzFx0XWTS07lPHx3bPx+ej5g4dTdzDS/owKDnY5lbAAkZNN5pyOYQ8BwB9zu8yJPBeqAN8mJwKjluM=;7:0BzsSpTkY6wMGMC/Cseq7dz9Sv9r/n+ZnQOELqdkvnrkkwj8nOiE4iFx4cNDKPxazvsOzv9M0QV2nuRZoJWDBHpD2IUygV8hrBbSH+qzG9T1EMYWZRXefWsbjFcpJMunYeASj9tMdc+s+dm0Y1NgwD7TcA5eHNh5T7TPdWmN6kD5z4w2gP6qokNC8+17X5EHggxurJnMzKgKoY0pmI8ck65/LgNs+FpU0ny1SKhtHhCvxMN6wsuhChO3JM6dO/f+
x-ms-office365-filtering-correlation-id: 60ffbea9-cac2-445b-e8c0-08d638c299b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5077;
x-ms-traffictypediagnostic: AM6PR04MB5077:
x-microsoft-antispam-prvs: <AM6PR04MB5077659C8A21A1F48E76C018F3F50@AM6PR04MB5077.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR04MB5077;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB5077;
x-forefront-prvs: 0834BAF534
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(396003)(366004)(189003)(199004)(305945005)(6116002)(71190400001)(71200400001)(102836004)(3846002)(6512007)(2906002)(14454004)(2501003)(53936002)(7736002)(106356001)(316002)(105586002)(5660300001)(66066001)(478600001)(6436002)(2616005)(476003)(486006)(110136005)(54906003)(4326008)(52116002)(6506007)(68736007)(81156014)(81166006)(25786009)(8676002)(8936002)(6486002)(26005)(1076002)(1857600001)(99286004)(186003)(36756003)(97736004)(386003)(14444005)(256004)(86362001)(5250100002)(2900100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5077;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JPa1iFz9usJdNL9HOJ84AgWyscbFOI0YOFQQCpcrStnq6uRY2igE8K1ktpZBE0UfkASutIPcp2awVSMMRI6jo87ISnRsrGO1THSXvBLVC2DlLoT8dIABAqy0U0GVt2YoCplGgNLO0a/7Jwtmsav0WNJ1xujfkuVQXvYi9bVXL5MbJgVtx4zbyekcEYzNxRr1eyGxVZnhyU+5qeG1AcHQh1rOq1c24QxDC+9UkJ8t+TDdNHroDyrEexoJE9m9S/+Vjzju3EOOCOclk2vKnt1z82Q3fpxov3rfZjNuZyn/JP8RPFSv+1ZXHn8WIYXG9gq/qht1c7Xg96/FRr5lqjlYKrds10YtWfRt5Vt/j33zpso=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ffbea9-cac2-445b-e8c0-08d638c299b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2018 08:36:17.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmas and dma-names for ecspi1~4 to fix kernel boot error:
"spi_imx 30840000.ecspi: dma setup error -19, use pio".

Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index aa8df7d93b2e..043e39124c43 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -651,6 +651,8 @@
 				clocks =3D <&clks IMX7D_ECSPI4_ROOT_CLK>,
 					<&clks IMX7D_ECSPI4_ROOT_CLK>;
 				clock-names =3D "ipg", "per";
+				dmas =3D <&sdma 6 7 1>, <&sdma 7 7 2>;
+				dma-names =3D "rx", "tx";
 				status =3D "disabled";
 			};
=20
@@ -732,6 +734,8 @@
 					clocks =3D <&clks IMX7D_ECSPI1_ROOT_CLK>,
 						<&clks IMX7D_ECSPI1_ROOT_CLK>;
 					clock-names =3D "ipg", "per";
+					dmas =3D <&sdma 0 7 1>, <&sdma 1 7 2>;
+					dma-names =3D "rx", "tx";
 					status =3D "disabled";
 				};
=20
@@ -744,6 +748,8 @@
 					clocks =3D <&clks IMX7D_ECSPI2_ROOT_CLK>,
 						<&clks IMX7D_ECSPI2_ROOT_CLK>;
 					clock-names =3D "ipg", "per";
+					dmas =3D <&sdma 2 7 1>, <&sdma 3 7 2>;
+					dma-names =3D "rx", "tx";
 					status =3D "disabled";
 				};
=20
@@ -756,6 +762,8 @@
 					clocks =3D <&clks IMX7D_ECSPI3_ROOT_CLK>,
 						<&clks IMX7D_ECSPI3_ROOT_CLK>;
 					clock-names =3D "ipg", "per";
+					dmas =3D <&sdma 4 7 1>, <&sdma 5 7 2>;
+					dma-names =3D "rx", "tx";
 					status =3D "disabled";
 				};
=20
--=20
2.17.1

