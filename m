Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26DAC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7577E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kZNNpIJc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7577E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754260AbeFTMYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:24:25 -0400
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:59456
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753880AbeFTMYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPi4av5Fi3nh1Nk9ceHCCuMTkwkPVqYjyRDkPBXziCM=;
 b=kZNNpIJcZQwNJtFlrlPSpBWAS9iGorm/b+zKnHNjFhCNWvPA60T9lN73r4TC2SslloyJMk7C1LQ8QAAqSnTBGIZe1QuuqDrASwOUenDDAjfuyonwXS/F49Rk8hPVDKLXlfB0YqZxZDVTsHFfszsf+wE/qY39A0WvTds4EPKabYM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 12:24:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Date:   Wed, 20 Jun 2018 15:23:48 +0300
Message-Id: <1529497429-8576-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529497429-8576-1-git-send-email-abel.vesa@nxp.com>
References: <1529497429-8576-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM0PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:208:55::43) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63af7bbf-2728-48d4-ccdf-08d5d6a8bcbf
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:9Pyb3iJSo1wShvNBoa//zMMyBZRuKF+kuRWCz61gqVwgtiRnxB6dePJDscWvJGzzxv1ExXiODiQahKgFXIubfbBKcpi5wp6KK7J9Q4Na5YS/9J1z6ACyG4mquY6R51Y4K8iMVV17FmYChQOsy4nt9wDN2yuN3Q+Og6S40re8Puxi3k5KmVp9hjDwQ52K3UCSadRnadwpHmZ1eFqMbqkJJHqvxmHmH33vfCa+NeIhA6MKBZ2iP1gAZQDorYu02mvE;25:rzRwQ5aUg17Z3ybDl9iqxRZzdFbF9IZ0wXijkUmmQRNSg7xO2Uc4BbZdMAn02fA4pzZi94Yn7jEhaUvxm7GM2xlbmaUd3ixLWW/5fS6Wj1UqUMFhH4zdBymo2JDC1nYtlGC0lxDNNjlvIN7zWRHS4YvZiOS5EJRY/8ZqJAizXgKDeV526MhRvSjYb6M7L+YO2hsQQl/aFmB+7p3AbHSqf50XNQJ2bmwfuACdoNMylNiA6Iiv7EAuq3lT+SCj1YL17obZ2919s/GxEz6jQKtgLrY3f9GUEN1a1U/QTYVJ4rSbAiIC9XByNoypzYk88+gIvt0tnHGnmT1fqOaBP2Ujvg==;31:aMuZ6KUu8/d0QXjw0hKhS9kgVdKI827VQJUBdfceAIkai3oy/p5bB3F7y5p2EnQqaVaSvkbNHb7Nvcnk+pCtapFFnWg8W8I+5l8oB58wZsIIrLOhZFJe567GpJnkfeTPubk7HAlLrAxc2UqmqlzxT6hKMKjOL+UYNWja7LAe0HK5eSqpfFRjlV2nB4XJ/ik6WJMrEOMvgjE1acepDtOmNE3aZEsrUkFHGANEpppHuEY=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:9PQgSvljgjIe/oZKKk17FpnQEZ5S7b4cDy8HKvNmqa8KUPSw09QY03FpsbMK6W3qTQiak+lYyxsjkixx6HjMazoDTjjYWE3SRgj1a12qbL1iRj3jEPmxHidzVvkwtRkV11f7Wn82sL16uMyyeALrB0ga+QLC48LIfr3qtHDBZEzfuKueuIgGcogbc2c3IPmNQy3I9TxP1ZOmN6g05JoJ7fOKgZ/isE2JlwolQmhA9/AIz1FIDEU7e+bNVyqKvw+V25b/7UJ3GTJV54KeGJcmB1E1Ct18LM1TZp590T/NlaKmg5o5SGZMFjMDQirdqfg1t+eaoZBKpKEoHQZls9kq1OOhCibXLMWT5VYmCJcoZ7ld2OX+TR1zJdKcpmjZ8lsgqXZyALgtl/iOPYQEMTknsWa+V3JihDl2k2CxuciwN0IxL/bM0ElG5HaxS6JQ9v1ew6P1RYKvCWlmrluCtCwwG/rWJWLQsDiBkP/5D/LWMQTdOA9TC/a3MVOSIqGjCvTx;4:dyFot11gqpBjx0cb9RsQdEyuJFyo8ONRMbKc5h3toKfLeywei2euljggFb09OWInLa4ybSDwnkqiFWYR5tl9F5H3qxR8mxAm6AqUQakbisL1KYohjbtgIpG4i5T/u1L2L7tio6BejZNVV3s97fgIddJdvci4sVjDrEJGRtKDUGLXFiUlrrw/jVA4Z92H1mh5QlFn14ELG6UCT0UBNBXax+jrSbYrmeOLPLO0hEQGnJNFvnlyH1VlM1N8rDBgA9x7yjX6yBOqmG1Hu2gpeLraBG5v0EVhWmJBGBS9qSt58V5pwXrxjnr9qcD/gTbZtu6m
X-Microsoft-Antispam-PRVS: <AM4PR04MB16011E12B609A4C18F9B4E9CF6770@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(39380400002)(366004)(189003)(199004)(11346002)(486006)(68736007)(106356001)(4326008)(5660300001)(956004)(446003)(105586002)(50466002)(44832011)(6486002)(6636002)(48376002)(2616005)(36756003)(476003)(47776003)(66066001)(478600001)(6666003)(7736002)(2906002)(86362001)(8676002)(81166006)(81156014)(316002)(50226002)(3846002)(97736004)(6512007)(54906003)(7416002)(8936002)(305945005)(52116002)(53936002)(6116002)(76176011)(186003)(51416003)(386003)(16586007)(110136005)(6506007)(16526019)(26005)(25786009)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:22s4SMb0E1/0vbAQ+Bq29pwY1bOWWXV9JNTRQIu+Q?=
 =?us-ascii?Q?75sRRQkD0Pblak8LL+OwD1+D6RNYyvBnu7Ez7V17JICQHqMHDx1p79fDRIDW?=
 =?us-ascii?Q?KgI1ay4tefZrGuB5o4PjVa239AZ4NgShA3SKh8hFWloXFf2e6GgiiNxMH+TF?=
 =?us-ascii?Q?w8ZtSXKuNyGm8hfYIAVri4MnB2fmcits6eWn1qdw2hBvRxdZ1D30J9KMmpy/?=
 =?us-ascii?Q?k+DaopCuqoETuChcTOoC/j4WKNAjb51p/ysWXsc+G803oVSlGxIDvcOQXWp9?=
 =?us-ascii?Q?G4+cKalLc7+LiYoz3ZZUHwMLd0r62T+rjRAWdL/bVt54SZEvtu/np4eszwNd?=
 =?us-ascii?Q?/kQrbkXx+clFSQ5CfmajeNOc4Kak5NOgzGwZjYKWxlZUbcwugTSbYrqGOf57?=
 =?us-ascii?Q?l+ZG+N3fBNHc4Y0p9rcOIprMVXV7SlD4plR+OOb6gZZ51VlgDFx1sDi3iLmS?=
 =?us-ascii?Q?OfwUbMskEW5ACaw/05jgK8vexJrDqSTVRIl1RVGulFRerBV4kSV8/194pDum?=
 =?us-ascii?Q?jKJx5Mfzxy2r6EdvAhv4KNvHj+75MyYZrLGXVWEIUIKg1zi9TePid6FWL3QK?=
 =?us-ascii?Q?9vkYLFfjGvqs01QgJKz0zxTky+xU7VKhvEZjFjQeWAGr1tHyAmuJk+cAignq?=
 =?us-ascii?Q?VoeAmzdIjCXcKbmnDmHb0PNIJw61TF2a7jwYymTIz62k86rDRmi8bRxhnLYs?=
 =?us-ascii?Q?cGRh4mB593th0KSsLvBvQVbjh6nXoS6Z1x+I5+O+iwVzCZePArR5XEvaa/v2?=
 =?us-ascii?Q?/QsVmd85BV+pCPX/OJn73IJmnMx+86beR5UeZ1d0UzZErMVSB1IuJ+HcNoNU?=
 =?us-ascii?Q?FRL7mPyU4kL3KaceNp4bvwUvsFfUM3yWl7zqBK1aIFJKwBiwnmyVETW8QZ7n?=
 =?us-ascii?Q?7w8T0exbNzmcmdfkw7XIozLcNPYbJRSAiCQlEjlVAdfTMxdw6FrLyRbJ/IM1?=
 =?us-ascii?Q?ALdxx9Oh7QOhZrnOaCYxqsemeU0zXiuLxdNDb/elce6YeLb3ncAB8EsobQmW?=
 =?us-ascii?Q?VJFDnal5SXkjUMHw8drAWArKzX+KLNw+1D1pRLVSbMUiRFSAgVqtG4hXBYJO?=
 =?us-ascii?Q?JftFmhyIx5avOHUyzceq7No+O76E1Y8Xkhgay0aluggDDB4rV7rt7rNRuQNX?=
 =?us-ascii?Q?HzStk4U8N6j4nQtA/ZMw9SyxDy7RXHxOEp6paR8UBkLlBN0zq6+3uzpVLf17?=
 =?us-ascii?Q?qFj/2WN1kpfL55WBAM/TgtXVv9hCiyixhbccXYQoinwTI7c5Lnmkr806Df5Y?=
 =?us-ascii?Q?oGHh4ctAHyiuNMHYJJt0Rpvt0jhOMjjya6kXWjx8ylMbj38b0aFYq2E3IeUH?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: DiXX/kNBja724L99X54fOcqBCn0ExwpowvG91wJSzJDQ9tXxq63qiLubICosHJ6KBDN22NIEB4I/0RRPadpmCA3byYEX/N1rrQ81InTw5ULL10pGEcwgUUgx4ZxpzQpTLhtu1t/l6ckJ01X9HbLBlPCQ0zJeZpTlqYw7IvbyBhVs6dR1fhb0dboAJbUTkGN/IQuwPTWlNcNddbHcvoK90yLjqfXGbCvdQzbXlq/LYwBQ58OnkX1YUVZwHvJc58OU4RpP6iEL+FeqbIr8XB8ZR4WjeF+4BZADMUNU2kNcmfRrkLmX4VzcYS5UKUlIbEIx
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:OUxrLFh+61S4MkYcpy7TwXftIMQbbGECKsmvpMGTobehlPZbk6LbbA2Zp4vOK1vxkS2qWjvm8qZT65Scz/OwCYAgc2yJ7r785LPGWdFuZFjKTnhjHHi57axmqh+KgZ0djOFtBCR/6oga+OFYUNwlFGO+Fr0e0dzA6KvaL/gcFZzypw6IxTBmGxqLjfGs0Tmz2Cv7Sao2+FWfd0fiSbUwanedFTn95Ajllq6oxNpChGJ5LUfuj2MTY+HB4RnBrebLxTHC1zKc0/wkXlXVrifQ+X+zYY4nzOeCYcti5jX0mb+2I31xdWm1rZPN32l1/d6fKf7i8ov1LiO08TMvcZysGiRQBK55QZwVLxXiJMWSEmKZ/sp3YEzW1pCqmOn9NFR85aGyXHS0XHFJQ4if/IWzh0RERubzlzFoGMmpLLMcTLktKL0v5trgynhgizU87qemttsfcw92W7h8+24txLQkHQ==;5:bZ/fLdzFB2pfhQpYkOjy30LcePNodnMOdQnLPT17ijMwZ1VK5PJeJZlHDV+ALhmzRUrNFQa4cm3sePAGv/z8Deu7G28eId73r1IiPOnRUpexTXxdHsR9K9U14aBvzjC0xGD7xRP5JiQA6p/CVbVevJPlbKiQ32NY1ouwjv9zZP4=;24:bYcileSPvaJGHBLNOxwCTH7Pq1oTsELWTO3IUxSMPmdU7VfXJnx+O1iloRhEIR0IM/mN9X8LsNaIKjRpb2Sz5Ccjy9z1s4WWPu9QkNAzOiU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;7:j0esFKJr8T4QKvX6TJg73+JWsTQbCXRqfaaSErukw/+RzmSocn0FU+h5DYpibh98BHR1DcKzPhUgIWzZliR3cQPHvRqM03DlKimgdCcV1/d9FzPuI5AOLU3QMTk7JMs6iDPLV0X1fubc04BgJCiGNziuRngYRPbfa7YzJJnGCg0f7cUfj+k10vKflvaKOL8iIiHudfsXjjWQQT/w4nbaYuD8wO9NrWSy5WuRFduYgyiQLogdGQz1bK0nEya2h1YP
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 12:24:14.5984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63af7bbf-2728-48d4-ccdf-08d5d6a8bcbf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding for the i.MX8MQ pin controller, in the same
fashion as earlier i.MX SoCs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
new file mode 100644
index 0000000..f11a3f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
@@ -0,0 +1,29 @@
+* Freescale IMX8MQ IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+for common binding part and usage.
+
+Required properties:
+- compatible: "fsl,imx8mq-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx8mq-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Quad
+  Reference Manual for detailed CONFIG settings.
+
+Examples:
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_uart1>;
+};
+
+&iomuxc {
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX 0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX 0x49
+		>;
+	};
+};
-- 
2.7.4

