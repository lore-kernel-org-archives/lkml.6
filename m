Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD8C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B83222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eH9Q5oCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392159AbfBMTF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:05:28 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:5779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388403AbfBMTF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w189ljzm0VaqugtVo9tpZPHp05AlfHj0Dcxzoa0eJr0=;
 b=eH9Q5oCq+airz8iKbJ3BkcSFSK20XhEBWq6Ck0UHQpck8BK+rrk4AZ6giT2gJlmATZ1X6LQz1MfhmVOZk7ZHJXLQUmeHoadZ6mSJpCcSAmE5CRr6ruQxs1qI6G70n7sxpjd9RiaNx14P0ZYofiX+qpPsq6rC2XhMhUb3ZOZIAZg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:16 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:16 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 4/5] arm64: dts: imx8mq: Add the clocks and the latencies for
 the A53 cores
Thread-Topic: [RFC 4/5] arm64: dts: imx8mq: Add the clocks and the latencies
 for the A53 cores
Thread-Index: AQHUw88Oy8jEtYT5Hki/orEOIclb6A==
Date:   Wed, 13 Feb 2019 19:05:16 +0000
Message-ID: <1550084693-9797-5-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: def1328f-cf01-4140-3ac1-08d691e630b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4515;23:hbCO6OASkZTxkdaZQqTMSr7iMsuKqmLYBGbPrGS?=
 =?iso-8859-1?Q?BE+bcVP73f5nzew1tUgzqnD65DNaZxooyKgU1fIsD6bmCsF+KCVoDYoWF9?=
 =?iso-8859-1?Q?uDlbmBdSf2ijoJwLj+2muYdLvuO0U6MtNsvhm/q4AkJwvpoLm+kZ3jG7by?=
 =?iso-8859-1?Q?bcGiAQnTgZg3AaxcEpdy3vyCBqPxkVBJ9m5H+q6kOAxhiocPraN+eTnJv+?=
 =?iso-8859-1?Q?xApnP73BXTt0I4xTS0dHEVKDDI2EpuXyc78kHWPFWGnnsl4DVdN1upTNx+?=
 =?iso-8859-1?Q?itQ28Xs3WKK3y5IhtasPh7ZIRgYvAU2cCNrDggHyPL3fOx1AZ7U0JXBVH/?=
 =?iso-8859-1?Q?M6vkzcntfruJq7nSc+KbL+6SsAx8r2C5xjlODV8+c90y0QpXe0DOz+oCm7?=
 =?iso-8859-1?Q?IFJeggznmcHA0/jQIEaOvCnYjejT13xuBEuCdcAWzxRbuK44+IZyFEwbZU?=
 =?iso-8859-1?Q?f38vyJ8smEp0YtI/6sLxVAq73bb5KWYv0RwsohA+4Tu7gt3J3JQ4Bh2ckT?=
 =?iso-8859-1?Q?ZxfuTmdud+gmhnqBnfYRXNKOiZHe5CKGYVJhJgY2pmgUbI/6vvTA7UpO2g?=
 =?iso-8859-1?Q?TxdeXV0cjfatRDRkpUFsT/3XVUgdGvYWkR857OkOxRWfyN4cUpKvcyC+4s?=
 =?iso-8859-1?Q?dVTofLFUrJ1IbFYtBPyRrROqNLCHuwsZC4KSmIEd+1EnmbK+FsxoFyFEvb?=
 =?iso-8859-1?Q?Ha3vBp/R9LESoQ3+Qm6DH9tvfceCKqaoQYpUJW2WQa5CYnUwDbpCdPtyv9?=
 =?iso-8859-1?Q?ISzy0L634IgEuw5JyOkUwwLICn3KYVuUqIdrumTt647kbSCRxVHxJgu8kB?=
 =?iso-8859-1?Q?TAv1zxG8uW/rVUOd213s29Fvmskb2W7MVRmumE6XtoMyvT/FKws+RQhI2r?=
 =?iso-8859-1?Q?H3FunKY8kBbeWHhkQs+unhvoNmPRMkFcH1uGh2JIotu0lju8X/o7HAn3CR?=
 =?iso-8859-1?Q?9TKm+4JWYcJPceGyDXqMMMXhQ8fE4m3iBhFgNMeb7jagCRdW1NeekgbF/M?=
 =?iso-8859-1?Q?xa42Wasz9IB15QXqomtacGnhzyytsTyrUGH4K4EcnRFxiWNoIW5iFey8o2?=
 =?iso-8859-1?Q?kQO0pYQ6/mqlgxRqlIG3r2nfMWLO76rxQ62OEhzeIeiCZAIgWmZwFub+SN?=
 =?iso-8859-1?Q?XCEWqwQ8paTVHTrzampKmDlqgGKp3WvLD7hGelaHbkXjmAccqFz18HC32t?=
 =?iso-8859-1?Q?z2I1IHpQg6sPHHypLQAAa1i6H79JvXOzGyHnm00Enlh5jqbHYo/mJvjgM9?=
 =?iso-8859-1?Q?DBol1VTdaXVSuuxfvZfGqbELWk1q7vgOwNnguDQAuDyKQ34rdNVkwgOBQ9?=
 =?iso-8859-1?Q?OQ=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB4515A45BE44CEB4611C000D2F6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(256004)(26005)(102836004)(11346002)(446003)(71200400001)(71190400001)(7416002)(6506007)(76176011)(86362001)(386003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SWR63O7TzqYtMk0CndDvs33B49uc2SJGZy/5l26dYsq8WaN+uzJttmL7GJeJjOxYKr6O/jjKZkhVCIbit9g0BBX8M/toVvPPKWUm96Enmop9ew5eeLAsUv0ulgMuD8ken/x5gv1nyP92PvXMbP4Z11bEblxzutgJz7WNYB3Dra39J/UM0kxmScbPnV6pegXsF0Iszd47wtNH7MMB8R8frVmbdiddo8knooJYiwxGpAdKgvsPbBmJQpIF9mUTHUOPDBZe//tosnoYO9rSDPc+tnk/vbJEtWtRGDMVcqF2QNcJ3nVYNLb++lRkqClIaR+zPita5hoVNqvDrUxzHGkEn+0jExqdmK5lvOtPXClMouaps/zRgexsi7ZsnykFoktwT/lDfv6AOcFUzrLaojWtzvWbSPGG31GMr2CguZqf3ds=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def1328f-cf01-4140-3ac1-08d691e630b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:15.8005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks and their latencies will be used by cpufreq-dt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4..1a89062 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -87,6 +87,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x0>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -95,6 +97,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x1>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -103,6 +107,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x2>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
@@ -111,6 +117,8 @@
 			device_type =3D "cpu";
 			compatible =3D "arm,cortex-a53";
 			reg =3D <0x3>;
+			clock-latency =3D <61036>; /* two CLK32 periods */
+			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
 		};
--=20
2.7.4

