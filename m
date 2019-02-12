Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2476BC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA0020821
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYlOIuKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfBLMLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:11:19 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:57438
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbfBLMLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7na6WwPdNhNLYWqdrKqMz9wgkBZMFr5WaJcaZiTOuLQ=;
 b=lYlOIuKLqvr7mitrS+pBjy0cah5nWn+f/vnJvzcdm0j6CkWqkvszFrlS2bUqoPnP766enLIG8uYY+mRb8DSisOHMAb1KoTrOMh5ClT1E1Ufs1OWeuaX0E+UHUDaGRYlQ8VwO8tkQaqkMIv8qviWXywmo2XRiccWZcbieWU8bPkA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6323.eurprd04.prod.outlook.com (20.179.36.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 12:11:02 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:11:02 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add cpu opp table
Thread-Index: AQHUwswF0jCrGFVmyEmVHUYdS4x2MQ==
Date:   Tue, 12 Feb 2019 12:11:02 +0000
Message-ID: <1549973439-26706-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0077.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::18) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB6323;6:phQZR894/LNjRfPmhZIF5yH4ApBXePIc+SOWPfLVT1cQ9emLcfeZJxisyGVUgLaAIjuhmlXues7JghmLgttzct6SGyiJr661ccnBGnYs/55ZKbxXKL+RUQjbhSSyrSHMVfFnwxPT00NfjDprPjYk/GCsDH5GCLlCpTz9vDbqzlaf3p90W+dIsVlL6SAhpOIBK4lvFfu2Njo6j82+NsawSYEIJY5BQlzuRRp7BDMZ0DVdTVnI17QgWB3ZcMi2Tc+RltH/xT9CTYbhAXt5CxQvZrpws/Hbc+F89aA2FkALRoLwWvyiM4D8w1B6WYPWA4iMSRshw8olmpO0Ovv+hBVCSCEUCIQ1JlM5AZu8zYtciR74i+I+Yw68HECjFS/hG4HClZvAKAU7biKe3gblRRV8U/4hX0qLs7tqfzyNH+0so3C9F3Mab24w3ce6OYcyczKj6bPucmqRTjQJAqeYkouMww==;5:czntZSPWwsPKaA5+dvnb9ljZUxfPAqglCg3XI7kra6prRkhAndlsQHRz8GHq7ZC9iCb8+X/MJPFJSy0a2MDLcr18u+ck5Y2L/qJE/n52YBHVjJH/JbSH4eMC/YdF2oE5BwANi5i4wiy2T2/R55HqQH0A+DPm0zfnuQECjCYOYdml0gck1xMkbO5WT3zcBnkSWY/wGFJXvBlyVVYiuKsTxg==;7:sRgcL4XQ47wXSfMJ7dpdmv9RZ8/Oa9w0fijyAsqHRmk8t7OQMnQP6WnKIZ8VxKMUmXx6LphZ5u/bihUfqnOU/efVQ2B9/nkgARyEpnBNgPtZPWlAFDrXp/K3UAYSuhFwBYO0GfZ4hrM8CkSsTcDxCA==
x-ms-office365-filtering-correlation-id: be0eeb5f-2f75-4218-40fd-08d690e327ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6323;
x-ms-traffictypediagnostic: AM0PR04MB6323:
x-microsoft-antispam-prvs: <AM0PR04MB63233532C742B046660FFE24F6650@AM0PR04MB6323.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(4326008)(4744005)(25786009)(36756003)(106356001)(71190400001)(6436002)(68736007)(6486002)(71200400001)(6116002)(2906002)(14454004)(8936002)(3846002)(7736002)(50226002)(102836004)(97736004)(86362001)(186003)(6512007)(478600001)(53936002)(256004)(8676002)(2616005)(316002)(66066001)(54906003)(81166006)(110136005)(81156014)(105586002)(44832011)(386003)(6506007)(99286004)(486006)(26005)(476003)(305945005)(52116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6323;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fYSUxUw4qvxiW1nrN71dBbt+lkOxx/ybQHsvsabhtieYRi15sul5kUXG7KYpSWwqIGSP1C+KmwDgcMzp/3PyVuQYQ6HaNLIAOO18KYy77fcQJhxpelNFuxFuYf3MT3VGnuolZ0KJXg9qWlxO/vP9RoPZ6eQd1mFFTktbCNjkPqdmY67Kb4UJExpphIb6nTq1bIKa9lqIYVxkhQHz+NlaEiJVBSaUOX5akq6oKLNJeFAvh4GoqG7jr6iWenQ4AHS7trF0SBdZfNhPKd000ZXnwNyZCm1Zfi+k48Ni/TctLYg76Zh/iroDBu0TidNuH09I+T9P13Mxf60AbDiSKNVdxOCgKs/pPlee4qjFRw2j92o6w6JJdWpgAqYqsIhET4yFJaYqMilreu1SypOWHOS294r0dP+eivaQF0MyL5yxhrg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0eeb5f-2f75-4218-40fd-08d690e327ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:11:01.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ cpu OPP table info for cpu-freq driver.

Signed-off-by: Anson Huang <anson.huang@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9155bd4..579015c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -672,3 +672,17 @@
 		};
 	};
 };
+
+&A53_0 {
+	operating-points =3D <
+		/* kHz    uV */
+		1200000 900000
+		800000  900000
+	>;
+	clocks =3D <&clk IMX8MQ_CLK_A53_DIV>, <&clk IMX8MQ_CLK_A53_SRC>,
+		<&clk IMX8MQ_ARM_PLL>, <&clk IMX8MQ_ARM_PLL_OUT>,
+		<&clk IMX8MQ_SYS1_PLL_800M>;
+	clock-names =3D "a53", "arm_a53_src", "arm_pll",
+		"arm_pll_out", "sys1_pll_800m";
+	clock-latency =3D <61036>;
+};
--=20
2.7.4

