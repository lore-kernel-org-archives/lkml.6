Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE56BC282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9177E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HVWA+2+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfAaPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:01:28 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:17694
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730283AbfAaPBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuQOZWGsRr7rS+oYAqGc+QrgYSxz3R3vO2uWvbsVWUM=;
 b=HVWA+2+xuJhsO8EvylaIsBeCmpa3JMKsm1x0nYm0wZMhnGfRZ3SlPOkg+fqCx+GZEHt4hULHbrXHEF2G71ZhqyDqH30L6DMZnGmI05IKzvXl6zGh85nPdY6LshCrbDPbyy1gu+0J5dKw0QYRhQi4cgALSagcJWPAc9qe+0FAUEU=
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com (20.177.49.225) by
 VI1PR04MB6270.eurprd04.prod.outlook.com (20.179.26.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.21; Thu, 31 Jan 2019 15:01:22 +0000
Received: from VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f]) by VI1PR04MB5008.eurprd04.prod.outlook.com
 ([fe80::2d2c:455a:16e9:cd4f%2]) with mapi id 15.20.1558.025; Thu, 31 Jan 2019
 15:01:22 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: Add RTC support
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add RTC support
Thread-Index: AQHUuXXUGM4Vx5l/AUqyV5hWGw71pA==
Date:   Thu, 31 Jan 2019 15:01:22 +0000
Message-ID: <1548946870-29037-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::26) To VI1PR04MB5008.eurprd04.prod.outlook.com
 (2603:10a6:803:57::33)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6270;6:MfrPFZQk4idghzeJIk+XoHJTGWJHJ/ys0l5xN9xJJ7ofqKTpbop0EEbPVg4PqK2Am5CALHfs4ge8CU5filt0P4E/Fg5SDDnYrqaUFI7gElcc87nRhR0rVO3JCdjUNJvB4LSnULZe92V3vSVpk+eYGPBMsCe2NQ4scFdWsATQCk6opS489c89PNOvsz2vnJgbDzJBQhJ9eArRC0J0BoBPglpQC3G5hu8ugphHATSMY7RfyTNqWaVu2WKAjoxifjyuS1rsT0cPyfBp6lYyKmbvdyBWxxNfQFlf2ocPEnKJ8LUt24CMzYDI2jyZTdTxsCEmtHckqXteTuaqLv//wlKrGcn/87/MwGPn9VPeIU5RBNvTPn/BVdBvprW3NkW7n1yb8Glh8IZ7jyECD+eN2cnP7eJm1AsZdjpXjgOMRUNuLIa35IYy2WjxOR6XU8KXL0PKsN/D9HxrtHTNg6wZ2JR5Yw==;5:KQeMKQ/IeZnLbayhIQNDPWLxr0Xv3mFULRxEsIsELPN3XbBGFxpCtPW72gYWedfVgDFBx0gpDzHlBL+Bb7Jq5RZs43sGNIt4i96FOGNpLXJunmIID0qT0B9B4uwsK/8vixp1P1L+QAzl43p8FRNILN0ZHxFerBvqZThi38Do69r6D3A/jDUqkxB0H93UUsdyruk+VSV/MzLadPgKmVhR7Q==;7:uEQDZZn8m6mqe1DbHtU/nzv0xlxrbzCg2z7M5ernTxbXwwG0XI71yT0fXdyC0XyqPcoUdQPdxpkRxNsqun3GOzhdswOWKQkcF9Da5v4eSMOLaNF1/hxj5OQUib3U+zy9R0C6ZKyUoKUU5nd/kvCm5A==
x-ms-office365-filtering-correlation-id: 5ceeadc9-1af2-49be-61a0-08d6878cf689
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6270;
x-ms-traffictypediagnostic: VI1PR04MB6270:
x-microsoft-antispam-prvs: <VI1PR04MB627031B238CA00E9927798CDF6910@VI1PR04MB6270.eurprd04.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(186003)(14454004)(6436002)(386003)(105586002)(476003)(26005)(4744005)(106356001)(44832011)(68736007)(86362001)(71190400001)(102836004)(486006)(71200400001)(6512007)(53936002)(97736004)(256004)(2616005)(110136005)(6116002)(25786009)(7736002)(81156014)(316002)(3846002)(305945005)(6506007)(54906003)(50226002)(6486002)(81166006)(8936002)(66066001)(4326008)(2906002)(478600001)(99286004)(36756003)(7416002)(52116002)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6270;H:VI1PR04MB5008.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FWiyzVRj/LuOsln3/ywbIgiAC1WNE04br5b2TSGdK1VWQfNesM4w89sBsEgamnhfQ/JVJaZe97pJ2JuEwF9nN8T6bF9Ei5ZpesMdBxUQwr8lfl9w2eGe0NJXswpwHh8jpyX9DTT5YxA2tpJFBEob4PLsMhpRXq4eFImC+yG0I0cN8t15HfQzO0c73Iw2smeEowLWfm2s937iTFVxJczspkptG+etbjLC2hA+uqF55bWgTegiqN9BFtMrmAl4Ar2EBT7cotCCknafSkKqO4jxd059wbsleB7ipGZ+7VoLPt3o+pvz/MPjhwEKWo0LRxpOM+lViL3mO+gRG0lzcJ7pb18j3Regix/E+HbJ9y1fnws4c2nUm1MxMWfcUSgjCL5Zbl1p6BjfHgog8bNwsubb4M3mnJTWSCzUK3lbFp50WGE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ceeadc9-1af2-49be-61a0-08d6878cf689
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 15:01:21.1029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6270
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RTC support for i.MX8MQ.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 892063a..49b14af 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -240,6 +240,20 @@
 				interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			};
=20
+			snvs: snvs@30370000 {
+				compatible =3D "fsl,sec-v4.0-mon", "syscon", "simple-mfd";
+				reg =3D <0x30370000 0x10000>;
+
+				snvs_rtc: snvs-rtc-lp{
+					compatible =3D "fsl,sec-v4.0-mon-rtc-lp";
+					regmap =3D<&snvs>;
+					offset =3D <0x34>;
+					interrupts =3D <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
+						<GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+				};
+
+			};
+
 			clk: clock-controller@30380000 {
 				compatible =3D "fsl,imx8mq-ccm";
 				reg =3D <0x30380000 0x10000>;
--=20
2.7.4

