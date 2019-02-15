Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F270AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B83A821A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hLF4A4Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387849AbfBOSHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:07:35 -0500
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:62496
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387563AbfBOSHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsLwe/ux5qHYYcijSKkda3JKbWuNB0QqRFnikmhCpBM=;
 b=hLF4A4JbR+IT2MxW4E5ls2bEPsSS86ZERPIqQCadd2f9HtBeVBQQZ26k261UYC/xhjbUoga3x/I8StMr9Au5s9Eu1L9HcO6LYwQHOdyV2eUf+y2yPyuodyqKti/cdh8KALPgEm8v08kC8DcBTUcnq4/1bd/Efpt2nvX9r52+FS8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4385.eurprd04.prod.outlook.com (52.135.149.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 18:07:23 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 18:07:23 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: imx8mq: Add the buck vdd_arm regulator
Thread-Topic: [PATCH v2 2/3] arm64: dts: imx8mq: Add the buck vdd_arm
 regulator
Thread-Index: AQHUxVlMid01fUo1802jjVCZ5QXkdg==
Date:   Fri, 15 Feb 2019 18:07:23 +0000
Message-ID: <1550254032-16451-3-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 8ae8c690-eaf9-43fa-d425-08d693706f1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4385;
x-ms-traffictypediagnostic: AM0PR04MB4385:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4385;23:EIobiVJ462uZUm61og3MaNDh8ggkUCJBR4iMKe/?=
 =?iso-8859-1?Q?vBLEQiUmPrg432ac91WjATpbwXhe7Ohbfr85iDIzAMaFAd7wdwjsO520hT?=
 =?iso-8859-1?Q?hojeyvZ0pLF/uK9K7jvlvKwVs88GnkYCNGG5xwfp6voYf29IXVBgwz0Ylq?=
 =?iso-8859-1?Q?7pR/GiIdMwePbijtRWoR+kUk8Gsi84sOI0mUpI1P7droYjHN2gT+ppyXCJ?=
 =?iso-8859-1?Q?IIGrh2FwqEHa7h030CdGKFt9KgH1FZ4RFecMNSEa1Dy2Qc2T5nqzrsv7Wh?=
 =?iso-8859-1?Q?O9hycGTujVfKsIfZAKVDtAg3MwcA5F27UTrBgrUfN60+OnsgVyEUExUVm+?=
 =?iso-8859-1?Q?dMWvxTRa1dio3mtpVSsfRWSS5R8XM+Z2La8gG9pcog0L9RPM0xjlvjK/eM?=
 =?iso-8859-1?Q?VEx37Tg1KuzL5YHFFSFc05k2mfPF+D/0CKZCMf2Vl7tRje/oy1oACTQqvm?=
 =?iso-8859-1?Q?Hasn3WVsCm+ujq9FLBH7ycPPPPyS0AbvZTursjvbOINnb5KowQAAkf6bvN?=
 =?iso-8859-1?Q?5jSDou2ZG7lAO+ttHo9Al19jgibuqgGTiudsiP8BCa443gikIGPvpy4wE1?=
 =?iso-8859-1?Q?MJpWnVrTKfl4ha56W+HuEUeilduOdLmQCSO4TGitT9DaBtepw74QXhDl97?=
 =?iso-8859-1?Q?ksLZs83DmmRXGnjWequ+XeSdvxtdQD74dAaNGpZ7L14OAF//nwN2C7slyH?=
 =?iso-8859-1?Q?FP/Y6wfbQRgtm7/ScnVV9O8TXuiasAxxDOu6AX3R3Z+f4dGTqX1SEOUAcb?=
 =?iso-8859-1?Q?BGXkx1PBL46ftHhmgj0rQZq66n4c5S2xmdOLYEaOpKr4Id6TZca/LMSFwx?=
 =?iso-8859-1?Q?arhWFy//7qHKRvGsSBGw1W0WVMo5/o/bRdXkl6b4aoJh9An4385y19XvxX?=
 =?iso-8859-1?Q?KIsS2XQJRxROH6tVZY6XxU1reriib03bc91nEcuWaQ9r6xIYKjPLBIPvHj?=
 =?iso-8859-1?Q?xN9NxQzaWMhy8Se6fxojFnjJjHb5t79MAr/GG2quyG5s9jvo1LiwSxG0+l?=
 =?iso-8859-1?Q?X9f8GGGUp+8LLZiGxRt2r/c7Kk1CR0pmpaEwjCsC+GsLI0pnwR0XAfh0vP?=
 =?iso-8859-1?Q?ept5Zjn+V6SPy8KMhL2ryFpJs9tizsFYY/sRHSgLx0DZrVWO6DFMK1d5rw?=
 =?iso-8859-1?Q?/IVZ38j8sLLrzpz6HlcoG0axQxIrVRNHs+jbeEUygFjdY/TGPVmFDbaE0d?=
 =?iso-8859-1?Q?Z5xm/HXnP2dVHNfix6wzSDX5lS2rn1KurBTg+Q9RsPcAtDDU6Boxu7U8Gj?=
 =?iso-8859-1?Q?g2uEliFjECct4n9sbEAMb4a2gfZpPQtIiHuVWIzZhdRnvYDGw+V35f6fvT?=
 =?iso-8859-1?Q?RA=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB438526C4E5C969C87640B3C1F6600@AM0PR04MB4385.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(189003)(199004)(305945005)(86362001)(97736004)(71200400001)(71190400001)(446003)(102836004)(14454004)(66066001)(478600001)(6506007)(6436002)(386003)(2906002)(7736002)(106356001)(105586002)(44832011)(8676002)(6116002)(81166006)(36756003)(81156014)(3846002)(476003)(486006)(99286004)(52116002)(2616005)(8936002)(110136005)(76176011)(256004)(54906003)(316002)(26005)(53936002)(11346002)(25786009)(6486002)(4326008)(6512007)(68736007)(186003)(50226002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4385;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5CEGOCCBFjxYa4MS8DUA+L6xQdQSP0k5vdHf3J8pDh42UPdnTsQf3bvee3V1oJ7xdf8h6QthLr0o5ujN5TsDhgXlfDObA+TZ2MyxcU28shqNvFTwyqOQpy2v9HBHIrFuo6abZLICOyff6lZy1bOVbY5UO5jyUq80ifiKIwdF2XfbipRLAbN70L/1L/bxw+vGDCvZx/+468hVDfDTNNiVjOTxtnXdDq0fg8WJ6hcC9z0rmjJfdXrIeikBELT+d5l2XvG/aUUVbc1BbgtcA85Xko3ZrpiWdSrVBPsvenvQVB30zuqBHWNpvmO25guCymrXbuyy0U2sKTAzV7WLSoVhfttVNDx8T8Gs8gAD/uBuExjXRd6GhPOIisczbVmuOCB71mNIPJC7Q203bYVpBp7aEf/5aFaQFjD01dLg4BPIKRQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae8c690-eaf9-43fa-d425-08d693706f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 18:07:22.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4385
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the schematics, this is a MP2147 switch converter
which is controlled by GPIO1_IO13. When set the gpio is set to
high the regulator output is set to 0.9V. When the gpio is set
to low the regulator output is set to 1V.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 36 ++++++++++++++++++++++++=
++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf..e5da3dd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -31,6 +31,35 @@
 		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	buck2_reg: buck2 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_buck2>;
+		compatible =3D "regulator-gpio";
+		regulator-name =3D "vdd_arm";
+		regulator-min-microvolt =3D <900000>;
+		regulator-max-microvolt =3D <1000000>;
+		gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
+		states =3D <1000000 0x0
+			  900000 0x1>;
+		enable-active-high;
+	};
+};
+
+&A53_0 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_1 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_2 {
+	cpu-supply =3D <&buck2_reg>;
+};
+
+&A53_3 {
+	cpu-supply =3D <&buck2_reg>;
 };
=20
 &fec1 {
@@ -203,6 +232,13 @@
 };
=20
 &iomuxc {
+	pinctrl_buck2: vddarmgrp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
+		>;
+
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
--=20
2.7.4

