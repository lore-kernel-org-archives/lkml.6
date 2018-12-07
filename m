Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E5CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CA820645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SWLGWxu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CA820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbeLGKDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:03:33 -0500
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:47202
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbeLGKDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXAXhkLcWCtuuI3C5EtxzAx2pQtas8IeX4SR+uKRMS8=;
 b=SWLGWxu5WPdEl5Pbbrnz1pyQj/df0pTmx5ZSEqfyLsP5ABGnpboOS1T1K3AKfS02uiRj/mPwMal9Fav3FNOFbrX2J/hoGFEonXthJL+JSUvqCYRaASxW2sqFBTY6rIckgz+BH5ViRbQ/P86ocRM3cU+HdXamOr/FD7+G/4w5dj8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3867.eurprd04.prod.outlook.com (52.134.65.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.17; Fri, 7 Dec 2018 10:03:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 10:03:29 +0000
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
Subject: [PATCH 1/3] dt-bindings: clock: imx7ulp: add HSRUN mode related
 clocks
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx7ulp: add HSRUN mode related
 clocks
Thread-Index: AQHUjhQaduf1RtS3MUW4pR8M5WEZVw==
Date:   Fri, 7 Dec 2018 10:03:29 +0000
Message-ID: <1544176659-32022-1-git-send-email-Anson.Huang@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3867;6:i47DbSEfZ5OCdEVhIYq9IBG4/71BCkRokMEEwjk46FazE2AQebFNtEGMiDRRCvJ+eM3Tx5h9EYcamCDucANH1QDkAmdQx9/4NeX8zh+m4r0pkwyhluSAmql/gx9LnShxJn200RQHjNTVvEU1NURUkW5s43fiPLXCSvBTRjSihnU2uTGrsVShOgmi1eGtowtiUkurAQo8DO/1PdCZjBL7X31DQ1vZ06gUs2ZrF7h7h7SbNO3tZiAB3TsC8ZraxSGBj1mOm3xZnR+9/+h7DqjWx9PBcwSlRjbkudoBOBCHBesdaCP1+afbuAbaNqAIF4KtfqPCDaQOtA8OTWmwd8W8V0UvoT2ZzjEb42Qlx9ERjccDlo31J4BH3Ez86Z6Bsa50C+OsnLl0sVBkyoZhYmO7EhM89y1VHwPa+Y2a2tm/sb8bl2NaCjyXGg5wcQX6GLhRXCVDbIc0l43v/+XycEstjg==;5:CAp+khk9HjoxcddFd7X6frivYEB40P2wVrPJFGK9uBJFQeVgUSO/CZHPHfUJCLb/b1Cvim3THOqHGvWFRYvUnr4EH2yNBe6kLzZZGsKFcTVEL5XaUpEMcM64eZqglbFTM5ZmnQmcPD1C9HKoP33bbvr9xQhOnPFAJm7X3+hX1MA=;7:UJ6O9kl+y/b9XicYnFXTKjurQdCTZxnSljx4T7qeN+tWNLB2aL38TjLiRG64Vfp74snZ4JHRy/7GXLDZDaPlpasJmDjTK/RUmbEcNnNAic9Dz+JpXOVWhxnqkd9e+xSpZCANzd4H0Mb9ymPCywR+TQ==
x-ms-office365-filtering-correlation-id: 637c10ad-1c73-4569-0a54-08d65c2b3c59
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3867;
x-ms-traffictypediagnostic: DB3PR0402MB3867:
x-microsoft-antispam-prvs: <DB3PR0402MB38679879D8A4D54D9879E645F5AA0@DB3PR0402MB3867.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3867;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3867;
x-forefront-prvs: 0879599414
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(2906002)(97736004)(5660300001)(3846002)(106356001)(6486002)(6436002)(6116002)(105586002)(4326008)(7416002)(6512007)(14454004)(305945005)(66066001)(53936002)(7736002)(186003)(386003)(476003)(102836004)(2616005)(26005)(6506007)(486006)(71190400001)(71200400001)(68736007)(256004)(14444005)(36756003)(478600001)(99286004)(81166006)(81156014)(8936002)(2201001)(2501003)(86362001)(25786009)(8676002)(316002)(52116002)(110136005)(50226002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3867;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fxpF+XVs4zVjvIHWPXeYSOrn70D3BWZKRGWAYYhsAhS7dGGISjFzkrAX82fk+qWkpdvd2lBC3TtIfwSbgn4QFFWeCPyXvd+scPEa4+O4Hthpg3e1PjCfCanVhonyMhImFrfFiET+cPRoDKje9pRVEvdDnYOwu6LuSbBAj9I1wTzMElLtamMZrAKWDczny57C+C+nMQNGVYI8k0nIeidNnNyyIvr/Ux3jCzdJk0IJh3CrXXr4ge+Qc4dm9LadRpezKmJcKRoqeffw+WxeyNvjTu+4uh8S/gPCGXO6vbUYCh78iDesSMTWR3GLHLYYWWtd8oRb1bbbevGUo48Sjcsqsx8R99FLc3hKeFY8l6wdNe0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637c10ad-1c73-4569-0a54-08d65c2b3c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 10:03:29.1685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3867
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are HSRUN mode clock mux and divider in SCG1 module,
and SMC1 can control i.MX7ULP CPU to run in RUN mode or
HSRUN mode, the mode switch bits are actually a clock mux,
add these clocks for clock driver and dtb to use.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/dt-bindings/clock/imx7ulp-clock.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-binding=
s/clock/imx7ulp-clock.h
index 008c5ee..21d872e 100644
--- a/include/dt-bindings/clock/imx7ulp-clock.h
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -54,8 +54,10 @@
 #define IMX7ULP_CLK_SOSC_BUS_CLK	41
 #define IMX7ULP_CLK_FIRC_BUS_CLK	42
 #define IMX7ULP_CLK_SPLL_BUS_CLK	43
+#define IMX7ULP_CLK_HSRUN_SYS_SEL	44
+#define IMX7ULP_CLK_HSRUN_CORE_DIV	45
=20
-#define IMX7ULP_CLK_SCG1_END		44
+#define IMX7ULP_CLK_SCG1_END		46
=20
 /* PCC2 */
 #define IMX7ULP_CLK_DMA1		0
@@ -106,4 +108,9 @@
=20
 #define IMX7ULP_CLK_PCC3_END		16
=20
+/* SMC1 */
+#define IMX7ULP_CLK_ARM			0
+
+#define IMX7ULP_CLK_SMC1_END		1
+
 #endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
--=20
2.7.4

