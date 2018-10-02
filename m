Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D42BC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D1A20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 19:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NcKObXfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D1A20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeJCCDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 22:03:21 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:51904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727675AbeJCCDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 22:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWvJWLcOyGvIt56G20/Af55k7zJslMrKrbFgh+NeQYU=;
 b=NcKObXfcL66La9M5gcAVACHyR4eVQykqBcBSMolGI0k6macyHkJ8zG5/pIRB+rO2hNc0Az3CAdymuXvnAsalNot8/yVmmygjB1ja07qFhDEu7Bmu8guAe2CDs+LwoA9WlSYV8aukL/DSSpXQ528TVsz3fhR/RbSbBQ6IiTRqxY8=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4593.eurprd04.prod.outlook.com (52.135.149.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.18; Tue, 2 Oct 2018 19:18:24 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1185.024; Tue, 2 Oct 2018
 19:18:24 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller " <davem@davemloft.net>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ARM: dts: imx6ull: Add dcp node
Thread-Topic: [PATCH 3/3] ARM: dts: imx6ull: Add dcp node
Thread-Index: AQHUWoSwp1WitF/BKEaAP1vFSULq+A==
Date:   Tue, 2 Oct 2018 19:18:23 +0000
Message-ID: <57caeb7b5a221476d4c43eccfc5f8e8faa6c61c3.1538507155.git.leonard.crestez@nxp.com>
References: <cover.1538507155.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1538507155.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [95.76.156.53]
x-mailer: git-send-email 2.17.1
x-clientproxiedby: AM5PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:203:91::19) To AM0PR04MB4290.eurprd04.prod.outlook.com
 (2603:10a6:208:67::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4593;6:A/HxSi2x//UHzcBGRvbY1i4ClshMcWZKVxgMQBd+mav1ZvAyR1o5LcsZUfJP+UhV/jCOAhgtuMZk70/ADWaF/2MNY2DycRaQbTOeu/l5Zaz0AlW4RjSk458rrtbvQ50iqQbQgmKXVWeVCBrlMk1PcbvdC67i+gQcj5HIyIUoV1WnmCGCwZ4R2sbXZuhkvmGDl9UPvbp+qXQZA+7iIjGAD/EOTQRawtfUBkfE5jWT2F/vwLDf75Sv7DWNA8uIV6I4Lsxzhl1YMaZCPxgSm74hM2AXVDz0Y/fXqwh/JPR7/8NvUbfHbDjYYWURTueYYBlcvbtrDsN815tRUHZCtBr1EuZ9VuJEQLbCENZmOaTf1ylyRG6cmi12I2DNGoF5ePDi37SznguAf/Gt1CzdY1Sm2EnzSckpOLNiyXR1xqBAm1lTLUMnhDPeiDizunA2otprnO9Gmoeb1B6pkR3Nwsbd9Q==;5:G7qsPRLYe8Pv8DL5aIHcqS2FnW25KnmISWVcxhB8XPj89bCjgQQ7QJMI8HqHLOMcamRHF+MEsLYT6RC48gc+cSWvQccq8ljtm2JqhLBz1lJRfj35zlsrrVz99XvURJu8nxmfErKd5yiTZfKOVxEyRKFChgXCz+zzel3KZKNH/xU=;7:OHLtsSfLdiV9pPDzagyVx3zPPYVYuBN+Toan9gP/5JGJjNLLduoWxViRbRNlsMIokPT9oZ7BQHEwIIMEooBLW4He0mEx/QTI8Cil+0PJGicDFAlm851cUESOQ8myx7ulTcEjOE0NY8+k3l6Lcno6wYKd4Wt+2KbpKvgQfTezZc8UHfnzlJIZlO4KVauM2Spu+mCWNEVXmc1C2xq7lqvPaAKVdAQa0Bi6L5tBOY9sKwKE9aWESd5tN8sjnodYEXsT
x-ms-office365-filtering-correlation-id: 84975feb-4f13-4054-8ed6-08d6289bd27c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4593;
x-ms-traffictypediagnostic: AM0PR04MB4593:
x-microsoft-antispam-prvs: <AM0PR04MB459333EFF176D3967182DBB7EEE80@AM0PR04MB4593.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4593;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4593;
x-forefront-prvs: 0813C68E65
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(6486002)(54906003)(8676002)(81166006)(478600001)(5660300001)(6436002)(3846002)(81156014)(486006)(110136005)(97736004)(44832011)(53936002)(5250100002)(6512007)(6116002)(2906002)(8936002)(68736007)(39060400002)(186003)(7736002)(305945005)(36756003)(50226002)(26005)(76176011)(71200400001)(386003)(6506007)(14454004)(316002)(71190400001)(2900100001)(118296001)(11346002)(106356001)(2616005)(66066001)(476003)(6346003)(446003)(102836004)(99286004)(105586002)(86362001)(4326008)(256004)(25786009)(52116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4593;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-message-info: YWvUrE99ypUgWm/GynXGcbJplpmCXXz0vqlYwVjrV2bHNBGQy/41xKYq+S4qT1Myu2tqFR5mAQ+vduRXguhRvlj8Rs7ISq6/Oola4t358PpC8ulPX+RBp/2V6xNm7CQgXtvV67tuFn2z7euxU54GaTKQ0L6m+ioWm5eSOb/z9hyPZVOLqJcPNcMIkNwrlBPpYXhYscDQz8n4A82HlB0OQmKMeTZtA2gFG+81GVrMn2XACVaT4tnToyuG52fWEsX4mcY7ONpVmnWCcu4zmW+Eh9pJRb39rCzU3H7gr3+fAF7WbPoWYknfMDa8UMVUl7WCtgVilPwdWMu8lnnemZ45jGwbwE2xZ2XNXRkOzGOr98Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84975feb-4f13-4054-8ed6-08d6289bd27c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2018 19:18:23.9296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4593
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
index cd1776a7015a..e3e3528068e9 100644
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

