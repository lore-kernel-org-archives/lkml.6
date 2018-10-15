Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC39C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53D2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBHVl+u2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A53D2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbeJOVNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:13:06 -0400
Received: from mail-eopbgr10067.outbound.protection.outlook.com ([40.107.1.67]:30160
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726744AbeJOVNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERmtdMCJF/74RXIXCb6T9S9SL9hp0gw7JF5CKSO03v8=;
 b=CBHVl+u2LG4nN6ZObAd2qInp22iwYEES8jHFiP4xdLvxvBgcRBSmARE1IdombmBADw9w3oG+2cWB9mgY+0ZxO3keNLW79O7YoO5rHbHqt4Nx5zGgvqzuye3Rrpzj4Y6cTPaJnX/ytnXHJHJf5nkw10dDE9ZUZni6wKNrSmbkPN0=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4948.eurprd04.prod.outlook.com (20.176.215.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.26; Mon, 15 Oct 2018 13:27:38 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 13:27:38 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] ARM: dts: imx6ull: Add dcp node
Thread-Topic: [PATCH v2 3/4] ARM: dts: imx6ull: Add dcp node
Thread-Index: AQHUZIrXpSnoqva4ckO7zPcZi/AZVQ==
Date:   Mon, 15 Oct 2018 13:27:38 +0000
Message-ID: <9365e24504896e58294fd8786acb3c3d4a1a264d.1539609921.git.leonard.crestez@nxp.com>
References: <cover.1539609921.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1539609921.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM6PR0502CA0071.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::48) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4948;6:MNr7oYQWFNCerXT+X4v/h4FXk4fRuSfOGVeeSLCoYZIjZSwqCA00kUu+F3vRindO4eqNUZWXn7I0Gv9mEEhzEP0+gan8+RW+z/cFJT4UkeV44nB/kqapYB48fxgruWVEXStZGI8ogdacWuylvn0Y6pQJSf2gv6j4gqdjQPcymLB5AnoGedCtWBa5t4fb9NgQRi/NtH1K6qjcATPlqedDJnX1lud0ylofQSkcfVgxx7SLI3JRjNLP/vN8ngyXQympeQlUbLEl1VJaYjoYevc43gzF72A8CuFCDwzOhlm1BhI41AsYkKDXblHFEEmMLN++6zAtfNrWFQRcWa1a+fKv85wi1S81tSFkVz3mCHxHBt+KCioPjN7gqd5X28fQ1REVzzv3yYD8zWynSLBpzZYerSbkelZW6oGHB5xs/J5437ry7MR+9H+eiAzQpX5cybHXd3qm6yXcFZACBpSGW9mv8g==;5:FJIWhM3+gxDj4goBAXlr2lJDRqGgCc0xFEyYPg0n7+k3YksopoiwYH0C3wRYmX2LDEaWEgvGzWgohYaknR+8bK5eonXsZknZeFQG4yyj6zmLxUagbdffgJXZ0JlymORllYMA+3xj5N7yA7QyS7TxrPOHtsOA52r/NkaDN7PkOAw=;7:iBB5+57fx/JR81PQorAHty3OHNzE9POb+SJcwfsz0cePf+3hJ94926zHckbYfkZxby0iEDyO8axzAUvfSilVkLuwxeB79oY7cxnPWZT/p5tiScr6GKNWr7f0xh8ft1fcbce2ejXbf+vuvyBQECShSr6L46ffvPmRkSDy1CF/ItiVnRLbWSgm2ZOEpLoTeFa9Ltld17m1gmPqUkm8FbHvOHBIO5bh8IEDLsrJodcs1Go/VaCvYnScZdEhRHFLvz6O
x-ms-office365-filtering-correlation-id: 3e97e2b9-95a4-4e13-c719-08d632a1f9eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4948;
x-ms-traffictypediagnostic: AM0PR04MB4948:
x-microsoft-antispam-prvs: <AM0PR04MB49480A25F5F193162FD9A618EEFD0@AM0PR04MB4948.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:AM0PR04MB4948;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4948;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(97736004)(105586002)(256004)(2906002)(106356001)(53936002)(102836004)(52116002)(6116002)(3846002)(118296001)(36756003)(5250100002)(6506007)(386003)(76176011)(66066001)(81156014)(81166006)(305945005)(486006)(8676002)(71200400001)(110136005)(54906003)(99286004)(44832011)(71190400001)(7736002)(478600001)(39060400002)(68736007)(4326008)(6436002)(25786009)(6486002)(446003)(11346002)(5660300001)(316002)(6636002)(7416002)(2616005)(186003)(26005)(8936002)(86362001)(14454004)(50226002)(6512007)(2900100001)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4948;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6nepO2s4hCQ+YVjpvhp/hrezXD3NlUlhGV0cxmNf2k+cDnIFT7PZXa6t/5xu8EdQtLcMBhOsOX1fSw+uO+38/DmCYQr3dmKruAyqOXfqnIPx8g4PWEwiSfCwS4dYPXZH1/WBT1zVMrtRlI/IEVWkpNWarkQM0bJP87uq3Krh/LPzIqqsETO5kNGinQWLEnTCrZZPWfp4atiHrRY+jVs24GyPS5EaYAJOmoa0tdlsM7KX9rZgaq4H/gw5gCgCMd4+8fVb+dnAbudO/nB+qo0Ov6LeI4Dwm1paNQhBIAJAa82PvaVsBTX5IR92oSkhxPQbHGMv4ptCIms74sG7VkAjpYGw1Eey31JDVZqGF30QSck=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e97e2b9-95a4-4e13-c719-08d632a1f9eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 13:27:38.6367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4948
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCP block on 6ull has no major differences other than requiring
explicit clock enabling.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6ull.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dts=
i
index 796ed35d4ac9..be610339e933 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -37,10 +37,20 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
 			reg =3D <0x02200000 0x100000>;
 			ranges;
=20
+			dcp: dcp@2280000 {
+				compatible =3D "fsl,imx6ull-dcp", "fsl,imx28-dcp";
+				reg =3D <0x02280000 0x4000>;
+				interrupts =3D <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clks IMX6ULL_CLK_DCP_CLK>;
+				clock-names =3D "dcp";
+			};
+
 			iomuxc_snvs: iomuxc-snvs@2290000 {
 				compatible =3D "fsl,imx6ull-iomuxc-snvs";
 				reg =3D <0x02290000 0x4000>;
 			};
=20
--=20
2.17.1

