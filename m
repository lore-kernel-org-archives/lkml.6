Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7744DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0CE2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVLmR+gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfBZHI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:08:29 -0500
Received: from mail-eopbgr40088.outbound.protection.outlook.com ([40.107.4.88]:21797
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbfBZHIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+NVjQ5W4YBNYBcdkZZgEi3CaQg9mWST4R9OGsHO+J9I=;
 b=UVLmR+glXfQEb8lef7y4UTFbazqV2afMK0p0qSkgNChb9H5x2RRfvwuKx+8K+6SU2kn5AzMuFR1/qqBWKHrEzi0JFMxTBDIPUw8x2xooK0ZQ3erlqgaBrASHLdDOu0jnpuo9mhSBrVYo/xVOjgrrsfN1L6xfz4tZnHrrEM9dm58=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3741.eurprd04.prod.outlook.com (52.134.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 07:08:14 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 07:08:14 +0000
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
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 3/5] arm64: dts: imx8mq: Add SAI pinctrl configuration
Thread-Topic: [PATCH v3 3/5] arm64: dts: imx8mq: Add SAI pinctrl configuration
Thread-Index: AQHUzaIKxBjJrciaq0Gs2Sxh8vcUYw==
Date:   Tue, 26 Feb 2019 07:08:14 +0000
Message-ID: <20190226070742.30551-4-daniel.baluta@nxp.com>
References: <20190226070742.30551-1-daniel.baluta@nxp.com>
In-Reply-To: <20190226070742.30551-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0102.eurprd04.prod.outlook.com
 (2603:10a6:803:64::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14b6ef4e-1838-42d6-2062-08d69bb92ccc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3741;
x-ms-traffictypediagnostic: VI1PR0402MB3741:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3741;23:81NqAi89z89DbcEZMeRn7vI7V5ioMaKoab0Mn?=
 =?iso-8859-1?Q?cU9S8Gv54jbMa6+MBUlKo3PLe2YnlwdNKfF1eOJ9eD4JV415Z+mgGwoD0/?=
 =?iso-8859-1?Q?iWFSUo4IlkU7ah7XoXfxhuOBfZniKV89WKa/3gEekJkRF8B1Gr2cwbfHs6?=
 =?iso-8859-1?Q?QG2vwXbIacapnMdtQ4R1Adwp3UPmbyeEcCzYe6rh6uAG8Znv22QoVc/Ips?=
 =?iso-8859-1?Q?nR1qgWWx6Emj7jZgOaYaZOjqm9zFa20uClRX/ug4CIJ6ypwXLJu+2kD9UU?=
 =?iso-8859-1?Q?bO/E9cPPV2/laXzzst7mBVnyZYa/oUlOBo6n8aqeN7HHhbqTt7FD9zPmSc?=
 =?iso-8859-1?Q?l8A8u96KQ8Dxc9OH2Zc2syCPvBydssOlpHwrR1UhlIHvNBmDGYcrqmVcPo?=
 =?iso-8859-1?Q?2MSUgz4RrTXyT9hlvb4eyJzKbpiL+rTVqeriRl19pky35WV1T3fZVI43UU?=
 =?iso-8859-1?Q?pKwuTb1i6q7eGPPZJWe9n3ai3uLRlx84rqYIXSvDL+7yagQEvd1hYpLHcd?=
 =?iso-8859-1?Q?A2LsuOAoI/pZ25ezqIcXEmsRxqMhiLevkPUfbf7SS4NLf6aQBacSJwy9wl?=
 =?iso-8859-1?Q?aIr6/9yme/fNCNnfUaAC2waa3bdHYloXN30Gyu3AW6W3hOG2HDyk5rSqI1?=
 =?iso-8859-1?Q?C0qKMXhj994S2z94F9nXD1E36ye/0fsLY53q2eNt9v/FxBxw2XCGfkNm+R?=
 =?iso-8859-1?Q?8ooBCZWc1HVESb9gmm/lcxri1OSa9S/dgZKQULmPtHS24e+x2A+aQjV4W5?=
 =?iso-8859-1?Q?bMYvHgE9LqFHM/exxN9DHb8Pjgo+0y+UT/PYYjYqC0JZEwISBj32r5ZW8L?=
 =?iso-8859-1?Q?cGyDeqhJW0wgZYB7+MZ4cTjAXPl/z4Nlp/fSXGTIMbSj3EhGnrfNY0BVa6?=
 =?iso-8859-1?Q?ov5s73Zi5o0tlQ6I2Zu3QqEhooYRW4zgURYA9BQhRruOaMgls6/FAjMKAY?=
 =?iso-8859-1?Q?tFW65mNXVpvFN0UNhsjlPeOzAZ3ONnzpa+aDlKxVTps8yqPDyMWxF9Jco6?=
 =?iso-8859-1?Q?FytbOYof9y+DAltL6yLMD5nPl9XSkjvuTjk3dhWscRow2JOD0w+NmMOs1S?=
 =?iso-8859-1?Q?8N1j0ekTMSA0J+S2tUPN4GHi02KiiLtjFnxZH73oiM/7kRGPoRLgixejPu?=
 =?iso-8859-1?Q?6TWAna8jPKOYe+mu2f5p+W/1RMntXRDmH6fgPjiNKpEYvdV+AO7DFTJFMe?=
 =?iso-8859-1?Q?iE/1RrF2zo+Bgl6zECZFq4NKzAb8rO9jtoTQ4xLlvD9hz8dLoWQs6GFkR1?=
 =?iso-8859-1?Q?uhiioo8iFR+d4NKdFsSPDZj1A5uVeMs7VSsIIRZf46Ucwzk0PdFFewSCMX?=
 =?iso-8859-1?Q?GE4zJwGbOFHFhTtQs8+DDJe6JbZGrX9rwdbqIw7tUUBxAzzGnYuq3lbNWB?=
 =?iso-8859-1?Q?AeJDwcuD0oIJ14CKzBGzUKorrJNTMl+1fsyCfkC1UXXLP/OyQF3h2HYKQQ?=
 =?iso-8859-1?Q?+I2YwWba80uqsHIY=3D?=
x-microsoft-antispam-prvs: <VI1PR0402MB3741C86251549319C94A13ADF97B0@VI1PR0402MB3741.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(396003)(136003)(346002)(189003)(199004)(4744005)(3846002)(6116002)(305945005)(7736002)(6486002)(6436002)(1076003)(2906002)(71200400001)(71190400001)(54906003)(8676002)(1730700003)(50226002)(316002)(8936002)(81156014)(81166006)(6512007)(53936002)(5640700003)(66066001)(478600001)(76176011)(486006)(7416002)(68736007)(6916009)(6506007)(5660300002)(2616005)(386003)(11346002)(476003)(2501003)(2351001)(97736004)(36756003)(86362001)(99286004)(4326008)(186003)(106356001)(44832011)(105586002)(26005)(256004)(14454004)(25786009)(52116002)(102836004)(446003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3741;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vUUq0gNVlCTVRN6qHMxGyJC5bbPrkM2ER6KYMjj59cYdR+1dEc0iNhM6Jux0yEv0A27b9Fd6fpoM/WaPHRYffR8/2aF3kaaC+0ooUsZX1YZYT2B3ZHdW2wkfgbBlQDqjkX3S9EqXPSrAqGsd+Fr5GxcciQ5JrTvbsLswMj4oOvdYw+/W3vVwI3hRWIQJVU7MEfK3VNpv9LiCg+TFTn4L6jtvAGLjA4XAPgKGuXfAVnHmsm6bNIL39XBmWUHdWA0iaZMfHBSKnCDsx0LepwnLJvJdaWtJJd9HATFZBjw5+ad5tsMqDlXTmhrZF+Kwt0Acb/jzpXV+GPP8XPtNnDS+QTaXuLNCtzXn1FAYKdkJrZsDeIdzfojEODwsR8yJFH9ttnCYTVEpBq6voceNmsJ1B9wIDwA8T4stNSURKfK4NsM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b6ef4e-1838-42d6-2062-08d69bb92ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 07:08:13.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This sets the pin configuration for SAI pins BLCK/MCLK/FSYNC/DATA.
GPIO_01 is used for mute.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mq-evk.dts
index 54737bf1772f..d21ee2a5312c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -223,6 +223,16 @@
 		>;
 	};
=20
+	pinctrl_sai2: sai2grp {
+		fsl,pins =3D <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC     0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK      0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK        0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0    0xd6
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8       0xd6
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins =3D <
 			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
--=20
2.17.1

