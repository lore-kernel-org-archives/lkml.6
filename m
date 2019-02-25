Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F84CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5263820663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ju4JTy/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfBYN0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:26:49 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:32132
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727108AbfBYN0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEzK5phlpib4oVDmbwHn7ERuei4f3lDtTX1M7w5TjBY=;
 b=Ju4JTy/ydsgROevdu8jhOpJ4LexR/mgkIszVUp/cfMswDV/VZcyyF1kS+BH78PWagc/U3zyd+LlQWBlZkhuxILo+vSozLiwDwborBdmJSz9w3N7s93FSn1cy9sHfTyxSr0MCtZeuf8jaQuucw5RnxBrMq+JheaCR0f20XMUe9iY=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Mon, 25 Feb 2019 13:26:36 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 13:26:36 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Subject: [PATCH 1/5 v2] arm64: dts: imx8mq: Add SDMA nodes
Thread-Topic: [PATCH 1/5 v2] arm64: dts: imx8mq: Add SDMA nodes
Thread-Index: AQHUzQ27VwyrqBjULE6jzjMEsSVMiw==
Date:   Mon, 25 Feb 2019 13:26:36 +0000
Message-ID: <20190225132617.10987-2-daniel.baluta@nxp.com>
References: <20190225132617.10987-1-daniel.baluta@nxp.com>
In-Reply-To: <20190225132617.10987-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0192.eurprd08.prod.outlook.com
 (2603:10a6:800:d2::22) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 597d0d5a-93e2-494a-6845-08d69b24ddab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3485;
x-ms-traffictypediagnostic: VI1PR0402MB3485:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3485;23:cJRr27zSCwqGb0+hWzL/9fJ/MtsU+CWCx754c?=
 =?iso-8859-1?Q?mlLz95mELaNsLs4zKpEM26qiLXU0Eq+PojvVV4yYsKY8beGWpP/GloyfLl?=
 =?iso-8859-1?Q?jXnca7QIlKJ7jhCzOV4WSn2fK+QD/8UA8d9OEqprSNphsykb4S5Yrj9Xgs?=
 =?iso-8859-1?Q?bq7kISntRx6y+EGlAsFsxKHCXHSHWIAPNQ+qwQofhmBc/0+WPdQMm0uVp4?=
 =?iso-8859-1?Q?WjzVmRJQBcWTKSuj36+PloSKXrXn1akP486L3jlpZeH7XNqBz1z++Cgg4W?=
 =?iso-8859-1?Q?7Zv4xCn52buWeBH3DcHyLqt18smFkMogmhv0k3P4rOT8DyK0DV57n9+UGx?=
 =?iso-8859-1?Q?tSv+q+gA3V2TMEtWTqhW/nXcld3G/BoWfRoXYTdt4NO5yL4zi8LZkyDpf7?=
 =?iso-8859-1?Q?UyFUkLgd6fIa8Pz7ANbSXk7NNpR0F3RlHIQflaEjqhcQuRi3f6EEGIwYYH?=
 =?iso-8859-1?Q?VGqYFCpm3lD+/Cup07Mq6J8MspqkMfOt6bGy1JBl5BZxBKdLaIfh0u6tTN?=
 =?iso-8859-1?Q?oz2q3cv7Kv+2Fg9W1gUIJGmskdrr4ERDyWErj7F+TxMkwYt2hZqCz2oTmS?=
 =?iso-8859-1?Q?x2GxdpOfNj4TzlwOxGGS7bP4vL8FgJGMaT7k9xhP08diNgwdK6E3XfdFzD?=
 =?iso-8859-1?Q?rcTI5CqovTbNXUJkmCid5aA9QhlN+ouSPpvEYdsdNWFcRZSRPJRc+iTr6l?=
 =?iso-8859-1?Q?9BcgdFCB9BVKAMr8/+wAESlYo/+JyFTUIlQt+ieWLirt6tQ0qPVf9zTAk5?=
 =?iso-8859-1?Q?UkUMWm4R0fDC9ZbdlZGf5JxqTpszgt+pzsGdrVRbzgQsO+NwKkAkJ4+vO8?=
 =?iso-8859-1?Q?S2gmZOBtdwbQOqfsmYtgYth2Zg/Go8HkcDve++VlHrS3cTpYn3Rtqcg3MZ?=
 =?iso-8859-1?Q?aMCjd+qE5m2FTdgV/gQWqvz+pGMdde7OQhfZnbntt8n+A0bfSMk6GjTy2V?=
 =?iso-8859-1?Q?Bn9fjfbhRtlvfIuF6NRw35qQzxArfce6y+eK5Xhu3tGq5+nY2vUbCHRocg?=
 =?iso-8859-1?Q?NYAEHF9QfUe5qnzArNk7rrZoSJcP/VUhbx8Acflme1m+U2PyvHi3ExiHq+?=
 =?iso-8859-1?Q?AiK3AIS4JdK6lWf+twBbW/txorPvwU/NqR9mV4MgQHwNSp2NDONG1AtyJt?=
 =?iso-8859-1?Q?m6kXeei/laFMDsgJBi5Y1CWOjw7JOITjBcj7PwwWPLRdwVqSwi30VfbAJA?=
 =?iso-8859-1?Q?aTe1CAWrozOnqvzsYYuo3oXbPjODNzAz11us0rtX/ReBzvVHnbsXinMHCV?=
 =?iso-8859-1?Q?rBHDZO1ue6bQM2bp35zSua88CCTI5bPh/OzzV7gunyzbdP4RP+Y4H4ku2U?=
 =?iso-8859-1?Q?sheyHbpokpKDwPs0HEy3rKpSEzxiRkzrCA7LpOWfDtwYh6uXBpMYjRwp7A?=
 =?iso-8859-1?Q?HTNPNsWQF1EfHF7nq7d2e9D+j5d/LKPiioykskcAwbX8pcDxL4STg1xLsq?=
 =?iso-8859-1?Q?Jj1Ih0hoJmAEQbUE=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3485F5F4E842AE7D7547F527F97A0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(366004)(39860400002)(199004)(189003)(6116002)(105586002)(106356001)(5660300002)(81166006)(71190400001)(81156014)(2351001)(97736004)(1730700003)(71200400001)(66066001)(478600001)(8676002)(14444005)(2906002)(3846002)(305945005)(86362001)(14454004)(7416002)(7736002)(6486002)(6436002)(316002)(5640700003)(6916009)(6512007)(36756003)(256004)(26005)(476003)(54906003)(4326008)(486006)(2501003)(50226002)(446003)(68736007)(11346002)(44832011)(99286004)(52116002)(76176011)(2616005)(1076003)(8936002)(53936002)(102836004)(386003)(6506007)(186003)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3485;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6zHg7E+XNnxGApjc7DVdzr/I9UEj+a5YAxmFIm99Ifosj/WQZynkxSptkdVBBelWhI4gcYyepxC1VksjEOzfp9KWfKaDS7IUBgcLEvKdvzQmYjN6CQgeQMehLaxetAmuDiS5TTupPPbim60hX4CUIK/g/kZvpaLhKJ+lyIk5K6nN5g9TH54xz/LKYiTBw27DqA8B9t/s0E7Bq8RL3NSfqVZSZ9buFNgCDr4aCyneZvI8lls6/5omGukkulRwgkviMW856awyDE1mzsxecNpQps12WhCI9mbY5iLtqZWCaOOLiXKAlYPz8XL74S1AfzU21Cvm0Egzoc2clEy7KGZzdbXPhLZsVJrSzWA84uUXQNgee3T1f209GgP3h5wbh2un1iITUBsx/MBboC5FQaeyC4eiNyAOMroGFqxUkEd8UcM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 597d0d5a-93e2-494a-6845-08d69b24ddab
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 13:26:35.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3485
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDMA1 is part of AIPS-3 region and SDMA2 is part
of AIPS-1 region.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
[initial submit in i.MX internal tree]
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
[adaptation for linux-next]
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4784eb..8cafec17726b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -234,6 +234,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma2: sdma@302c0000 {
+				compatible =3D "fsl,imx7d-sdma";
+				reg =3D <0x302c0000 0x10000>;
+				interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA2_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			iomuxc: iomuxc@30330000 {
 				compatible =3D "fsl,imx8mq-iomuxc";
 				reg =3D <0x30330000 0x10000>;
@@ -575,6 +586,17 @@
 				status =3D "disabled";
 			};
=20
+			sdma1: sdma@30bd0000 {
+				compatible =3D "fsl,imx7d-sdma";
+				reg =3D <0x30bd0000 0x10000>;
+				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SDMA1_ROOT>,
+					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
+				clock-names =3D "ipg", "ahb";
+				#dma-cells =3D <3>;
+				fsl,sdma-ram-script-name =3D "imx/sdma/sdma-imx7d.bin";
+			};
+
 			fec1: ethernet@30be0000 {
 				compatible =3D "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg =3D <0x30be0000 0x10000>;
--=20
2.17.1

