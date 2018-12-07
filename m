Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9A520645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hn5rWXYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9A520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLGKDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:03:44 -0500
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:11808
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726108AbeLGKDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H87oSW9GctHOjtNMx+8dMErdLK7VoMvzFgDf6maq/pw=;
 b=hn5rWXYT/dMzjOyyJ5UQNbXtyag6SwdqqLjHpSz7IEURoNdL+8JA0g77sKsRxjDvEIMA2v2JjnJfRTD0BiWx5nypu//cAcT3GiH8ePoVDqHNkD0prd6IQcgrURnFuJX3IZWF/W5SxKJEEoMdizSj/lIVAJr3phvxZRFZbQVd8Ls=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Fri, 7 Dec 2018 10:03:39 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 10:03:39 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 3/3] ARM: dts: imx7ulp: add HSRUN mode clocks
Thread-Topic: [PATCH 3/3] ARM: dts: imx7ulp: add HSRUN mode clocks
Thread-Index: AQHUjhQgPbL1bIRVAESyGO0FuLOoKQ==
Date:   Fri, 7 Dec 2018 10:03:39 +0000
Message-ID: <1544176659-32022-3-git-send-email-Anson.Huang@nxp.com>
References: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3946;6:nDUJSFBlBvzgJN53PNkWYfC41pLiaQULXU4vsUSOYR51yp4SjOI20uYtE9UWkwOUpkkIaMYvxAYVm2vB4nM0GT0z5i64oY/n+LVbL4JnS9GcooTOodDAkPmiJuYACcIN/sLHfxnyes91uRYiIq1QrPytZ+ipWQ01KSRB8EWZq1msFd4GHUQiG7qUfuCbTd9sgLleYEB1v7dPZ5JMrBVeRReGnVZvXo8H26eZGqcgxk/EBVCYAd9Kz/tx6yTWi7Fqyk/z6SNFjj4vgyRexTnldDl6PBg65QyB1oynafhOIqa9jeMrvv4gyHYnX8fhFKZhWvFjSIvum71b2gN8/9LGCDE8aAcrQbvO0/2L1b41xxeAy+gIXlDF2Z4fBg82DLtBsclkK+BTko3qYo3DrxZyzdgBwX8YsUj8+YNI7n0Obg0JfD6RSHIR23RGp2YWwxF3Mtpa3kx3gvBAxh8l6ZJXdA==;5:VIrHYDA4v9w4SsYUrK3ANM6FgcNjZqYFDxUrEZ2RIjDbY03sqrEufmJHic8fbh55QtekWa7QUdDZi0KmcMLzyYLN5oadkt0ScFa87S7dyK1sYfKPRc/OTwOPjLbNWJZ1g+MzMQgckhxJCAOW6mz4gso2BZl/NdJLWYyCDMIXNdU=;7:Vw999RTR3WSJ4RyHyT5LPyNLlCVLkb3i+7ZLyGWMnNWHbSNjH9bkt0VB4JjHIqRtMi9+isaaxc1BTxf+UEJmMGnJO4YShLmeAL7Up62OZnU2zgWsAUHcZxvbp5WLHIuVxysaRPxrCLbj/A33MbgI4g==
x-ms-office365-filtering-correlation-id: d3eca6a3-01ab-4af2-e16b-08d65c2b429d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB3946C7495C2A6FE13BDB981FF5AA0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3946;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3946;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(189003)(199004)(99286004)(305945005)(66066001)(7736002)(81156014)(2616005)(81166006)(446003)(102836004)(11346002)(476003)(26005)(97736004)(71190400001)(2201001)(2501003)(4326008)(36756003)(25786009)(478600001)(7416002)(5660300001)(86362001)(71200400001)(110136005)(316002)(3846002)(6116002)(68736007)(6486002)(2906002)(6506007)(6306002)(6512007)(105586002)(6436002)(53936002)(186003)(106356001)(8936002)(14454004)(8676002)(52116002)(50226002)(14444005)(76176011)(386003)(256004)(966005)(486006)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e8uO46bOhm4BeG6uQIxvERzLWN+Rhs5087daCV9ZKDjMSLcGlg8t6xamb8L5EhgavyI8TqRexCly9o0odmrmasgExGSLpdNSOH3HojkPt2w2haLrAwlhp+snHzXr64MSeu8kZE05WruMpeO0rTrTmtqdyEYgzdzwvSgcU0mKFZHmbxzV0AJjh9ENojUp+2Kl0s7twcLTPIMEYZeUAlDQa2VWVHm7b4lRxbsKcCpwkE7amtCNDkQ5eyOqI6KfTC1PlfpK9hOoVVUIV653R7ZYq+pdiPbIe4kGnnVAQ7TYjEDZ8qgUyeC05L/B65i24QCquo5IKTQsCQ6ZDrJ0XW74lWfnxTzCzY/GIwOJpAp+FOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eca6a3-01ab-4af2-e16b-08d65c2b429d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 10:03:39.4849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP can switch CPU between RUN mode and HSRUN mode
by programming SMC1 register, different clock sources
will be used for CPU in different modes, so SMC1 can be
abstracted as a clock controller for CPU clock switch,
this patch adds support for it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
This patch is based on top of path series: [V5,1/6] dt-bindings: fsl: add c=
ompatible for imx7ulp evk,
https://patchwork.kernel.org/patch/10677263/
---
 arch/arm/boot/dts/imx7ulp.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp.dtsi b/arch/arm/boot/dts/imx7ulp.dts=
i
index 931b275..b86daf7 100644
--- a/arch/arm/boot/dts/imx7ulp.dtsi
+++ b/arch/arm/boot/dts/imx7ulp.dtsi
@@ -199,9 +199,13 @@
 			assigned-clock-parents =3D <&scg1 IMX7ULP_CLK_SOSC_BUS_CLK>;
 		};
=20
-		smc1: smc1@40410000 {
+		smc1: clock-controller@40410000 {
 			compatible =3D "fsl,imx7ulp-smc1";
 			reg =3D <0x40410000 0x1000>;
+			#clock-cells =3D <1>;
+			clocks =3D <&scg1 IMX7ULP_CLK_CORE_DIV>,
+				 <&scg1 IMX7ULP_CLK_HSRUN_CORE_DIV>;
+			clock-names =3D "divcore", "hsrun_divcore";
 		};
=20
 		pcc3: clock-controller@40b30000 {
--=20
2.7.4

