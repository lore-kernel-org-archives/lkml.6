Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0010C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nz4IstFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE1F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbeHaMFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:05:05 -0400
Received: from mail-eopbgr20060.outbound.protection.outlook.com ([40.107.2.60]:39256
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbeHaMFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzMndaF4xGT6eld6fXIK6h76Pb5pFd0efM5JocJQduQ=;
 b=nz4IstFw1E3zBdJwHJqaNjC1ZcxL9zwiL6nRO1g4d6+dOI5H6Lgf/UJNyIM6HmXEipNUXz+EkG1zmIyuTXHv7AeNvRJSRdk3WKYAGC6t7HM17C7lanHLqkjcLV6gAu+V5gLzXJxOZWSixe4IVSAX2BSusKqerLgGFKXX4zmG6f0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM0PR0402MB3907.eurprd04.prod.outlook.com (2603:10a6:208:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.17; Fri, 31 Aug
 2018 07:58:41 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@kernel.org,
        colin.didier@devialet.com, clement.peron@devialet.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, shengjiu.wang@nxp.com,
        matteo.lisi@engicam.com, michael@amarulasolutions.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 7/7] ARM: dts: imx6: add mmdc ipg clock
Date:   Fri, 31 Aug 2018 15:53:18 +0800
Message-Id: <1535701998-20443-8-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
References: <1535701998-20443-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To AM0PR0402MB3907.eurprd04.prod.outlook.com
 (2603:10a6:208:f::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82b88c12-fc4e-49ec-303e-08d60f1795eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3907;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;3:RvWG7NR9NQV5+wvVOvUs1i+rDXRwDhnqsSAGTBIa4CdjV56BOKVFukvxSCDmMaYG0T7kWyxzULrhLnfc0tNzGPiIaJa7c5hSkDjX58f3L0X44ZnByNEzZogUMjEH/L1d6aa5RYw+FPodotwVRuGnCaibRAor3aBChj48UZZmCQqid8wQmcK9KCo43XqIC9J89VwkseZYrp4suEe9Tr5qg0eA3VGZR42cfNk1fX5ohT8bsHh4L0owtng8MC1FxnyY;25:agasHsmYN6555MAhc3Mpc4plcJYp89dUDc33JdKhDFZJAkCQ16E8mZofAmq34K1JS2x3DdDk9yVuzV+dBP6wGfCQtl9j89VpKcaN70oEAC0n2/EdC2nK9vKIynlH2BvNdP6fNDbpcpBBbYMw+K+tW+4wXbltudWcDVhcBQenVD0zewT94RlMUY2wIeUHSatB163fuQl7Crpz21Q7pF5fxHGY+0go2IJhG2X8o0P68uUHO+jBCRl0mF2y+juV91E6PDyeKaW2HuWFF92Eyg0EM9XkgjA5DvwRAOWcFHLxO0/wiLqT/2AeYNfzvz10Gx32Gbl/8JsnLnVhGTlILFRthA==;31:vH7jcHuXQFgidRyf2jCqRKhJloloufjqP24g5uzgLLF1fCXug5QFsSfKuqi8k70he9sOUCj55U3RofKBN77y8P9qMqYKXLvgTtWZMdLPsTs1/XehIbrMuNpVrexsP752za/FrZKI4LVHopQQr6rhHUEVlJYPtcCsBLzowg6YMxICNzc3QNwzCH7eiAT0kPp9pkuSlHww4Q8g0uX9odEzbLDF3N0feTLf0RxkSYqrWPs=
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3907:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;20:bc5rwXrHC4Gm/FwuaARvp1vLSiwUCg7NSOZxJFLSLWVHdjPBbQHlGuWju3S7Er9ZZNjy7tmIokjKtfCILJrlQwKn3G9eyLuNjrCAupfb//e80iewcNZ0vp5FdxXg+k7mMrnIpxzDg/X6L0PBdiHINH5YGTMF0RlNxzWJZxcVmdqLbaAYAOiT1VdhqNlR/JbTGvE4/HEDrRy432UOtk2RziK3SfQ+ucxA8bb/US5O9PXSouF6+gOIFcHQF5lslaReeI2B7s8O+WcpguDndG4d4IouOY75UTT4ObRDXNMn+uJXst2mti/XPA7nVKd2VDsicJ9ynQ2hgKQ+y/ydXT9DrX29xLR3VjlG0007fXfBNVL1lI3CG/45sjXkimuGqjiZI3bmgkYhwTxxvvJR5W+2KBL33T1BypgVWRyMFiMuHHhfSbUpV0ecmKr5qGHOdz06xZGjvlyiybSpdVOL44L49ieO9Qz6duqupnkz7+ZSlqUwlyhvvSsJmvB0R1PKEi7a;4:bK0eHnvkOsBwMzxkjSNC6Tgk5uwn0GMY1VWWRCHlatb2aU2NCJxpLahD3sa0u0DUaqptRWY327njBrRZSJZexxvoaw5FiXiY5wa0V9GyQp50DaDZ7vmC6rLjfzpQs3roU9VMJAtmJLFkhP07UqmSdwaF1LhrCYZaIo6jJfoI1fRQIJiY8TUcBjbESkCaSKC9tuHH9KEQJeOmf5Zl6QfTuEk8GjiXUpX91hKHwa8+K49TDZMSoWEh21cmLmKjumA3OzZM1z1TbiHiJNiH19j7e/7UCIg5kHlQqJXGAa8OO/Fr/JZEW4rzvopKRTLEcw5n
X-Microsoft-Antispam-PRVS: <AM0PR0402MB390776738F79074118F440DCF50F0@AM0PR0402MB3907.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR0402MB3907;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3907;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(199004)(189003)(106356001)(105586002)(86362001)(48376002)(50466002)(76176011)(478600001)(51416003)(52116002)(316002)(16586007)(25786009)(2906002)(5660300001)(305945005)(97736004)(4326008)(386003)(6506007)(7736002)(53936002)(50226002)(186003)(16526019)(68736007)(36756003)(8936002)(6666003)(26005)(6486002)(6116002)(3846002)(6512007)(66066001)(8676002)(47776003)(81166006)(81156014)(476003)(2616005)(486006)(446003)(11346002)(956004)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3907;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0402MB3907;23:8DV20CYt8qg8BnizbekKNCXazMvfKqGiDxRSddF?=
 =?us-ascii?Q?dKyK08B526Dv28d1EJZ8P+Z9PWJJY9x3dSAFGBrE0zxpGkBAjz4wqWWs9S9N?=
 =?us-ascii?Q?EMZ8KX+EO9CRXEwszj/yCwZVBLYctAmPSAVKmDsURG49O+sJuP4+pplAS9lq?=
 =?us-ascii?Q?B1OGv9Zgx8tklaC1f0i1VudAXaj5c6PQAGGEaADErajguPVmFRqnREf1mFqA?=
 =?us-ascii?Q?aBXDya5nReADaNJHpxmgSyoakhEAj33qTEYynSf4RN4H4oxLEv110BOmwBvZ?=
 =?us-ascii?Q?C1CfJ9dUlmZnsGjuDFEObgWA7JHmJEJVrz8Za9QhFu7OSrMwysQax/7wtEbB?=
 =?us-ascii?Q?69xDcV7m4jTDxUgyh5+eLGE8lZCZzyy4+8/SPAxqlVKAVmiB6/fY2NCIC/IB?=
 =?us-ascii?Q?fg7smIMAUwABmyAPl38soGWP/e1xY8QA1hgAF9jE/FxGX/XDQHJ5UemQld2/?=
 =?us-ascii?Q?IzInCLWFGoWe2EQ88p9xOB1b39n/OfFAkflpNYjw26XAZXTMljbEETe8O2ot?=
 =?us-ascii?Q?NbmBOOH+TkROxSYMlChbyohca5MoXEV4GWDJ4XGw9Mdrv8s7dhRqQWWbdd8c?=
 =?us-ascii?Q?ATi+aXLBPqdKSYqmimBgJFwSOlx78zM64Mc4uomKPTtDNgtMbPenC9R8xX+0?=
 =?us-ascii?Q?Zj5242t8rMx99CF7WNMvf6kfjPkl29D/SPe8epP2ZSJnn6CbnVebXJmbkgXn?=
 =?us-ascii?Q?erZa+R79/VN0aMVO5BohUVfFpKx+qy9iM4GTYCjvojRqft8QYte+QtCLw5ho?=
 =?us-ascii?Q?coIlIWHyjZsd2ImnKKndc/tfMhWAhQesLjWJPweFYGjHsUoGkAGwlcYZuaGk?=
 =?us-ascii?Q?KmCJtypC0gflb/jZi53jya9C2wa8S19q7bqLzrx4nj/bGO5AgKoAo0n3J6vV?=
 =?us-ascii?Q?GVWIJKZuxARaDXqmvWuAM43PH8cca01D3Eutw1V21zEohEIOYZwgeVWRMsVE?=
 =?us-ascii?Q?bsB0O9o1u9bKHRd3dS1Lj58tsOTZzjQfv/ueSE3hfsXGrPbzqnzL5AD4AxUk?=
 =?us-ascii?Q?ojtY6keaWcKWgssJ21XPtcNDqdVNpIg3sFQZ2g5BQeJeAtDXhnmfT8Mfx1fv?=
 =?us-ascii?Q?MUX4pEe0bWL6jW5sMrxI/WeiFEvtF8Hr3AAlmWflTpopQjIVmpy6tZvOokJn?=
 =?us-ascii?Q?raHob9Z5QulvAJVHmXDirLcpuTNbZPDlRUuxBt2vSW3hL4RcnsP5FTTGxxMP?=
 =?us-ascii?Q?0louGHB8wSG0nEvx8NZ5sZcOHTowQJWE0Z0YL?=
X-Microsoft-Antispam-Message-Info: bIOLDh9R8YfZaFtA/hRR6WDij+Cf2WX4N2xnyH523U70lKog6AMjKJfjfmWuu5LanqnnsUXB/qzsUJ9HbU/VeHQ7bAXzMDXzoxsXCs4uah6cvatFLPM7f1AGnMu6A1r4NTX84mOMO5znDVCyx1O3mESuHUg+M8HqF96PQkHFHByzmxWb4/wEAvvjQs7E85v0UQAMc9cqzyrMBGlkRGl4RwO07P96EZQKrJBT8mKblaBmxjOthfQ4k6fL1PerGNDHlogdOMWMqc4JdP2ljW/Xl4pFRIeiGlwcIUn5ob3KTa61XCjA7EzK1KxNOcX5D/8sQbuy07juHurlYiaE8YhH2yHzZcjkYthYrcjt5OVkfLA=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0402MB3907;6:4wh8Rnq1rKQKgd8DXR8uSjWvWpEpm20nNM1mVtFmzMS2kCBZQqnWZhlwRxyzWGtA9wTxn2yYiBhH6P7RW4Ji1r+rjSzZKJV2M2OLg+NSmWvGMaUfRsnlUUtD7tqv8jljIkBEtJd0JZXMHS4oE8NToY5+L0kaCQVMBuRnSMC3qZANmKMrIUAk9G8V7oF0+4H09ScG/lmc6Ag9G3U9epKnOrjLdXRg1Y2EHLm4W4ncD67NdcRuWpbpyKLBb2IeMA9zQAb8Y4kw1ViH1gwr7G90jYrMf6m8qy6PRdgY0CWcHnLJWn9vbvZXgoqreQocaArP3Lo/JncgowUQHazKs3xLoJfMCmyUay38tCYHrlKCXR0mpAgRusP5B79PqU5PuWu29zhhWZxUfsUJkljLJ/uq0W/hcnN9s38K7G4xfB+dw25v5JTLWRR3N6LivhpRMd6U+dYS1jFYKAQkStpuUBlcsA==;5:9hfqiPxolhoj/ehKseAmaPMrgTop6DIEQT7zfbuqKpCz59kt0NjelnkhOcMHZyA+umPq3Bp2exzuryLyLJYILv5S3QhA5iuseufd1ghLzRhT3ihmhDxPuUxW0rktvnuftR+gmGvQKWNM8xP2c48ookBLuIVqkBj4WKCPOK4XgMU=;7:E52XcaqW714Zd2bynUdHHc7viIYVNYXBoHabv5Y/yNmEZZ/pKDNg355J1w62DebWrhID6M76nX2fNfdWLHY78fZwXwY9Y84An7Zrkr5ZM7R0i2JT7AvWXJGOdFFWiyIWodV5pqEu3YGibPcMNx1aABEXNio4u5gY6aTdUO006Qc0ZbNeVcO7pfsRIpWoA7dhB+gcH7UafJLBx9IIFGbTm5ejPL4hxj1ft2QA4hWDL0KBAHY+hcK9uDtGmBfbx1K+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 07:58:41.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b88c12-fc4e-49ec-303e-08d60f1795eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3907
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6 SoCs has MMDC clock gates in CCM CCGR, add
clock property for MMDC driver's clock operation.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 1 +
 arch/arm/boot/dts/imx6sl.dtsi  | 1 +
 arch/arm/boot/dts/imx6sll.dtsi | 1 +
 arch/arm/boot/dts/imx6sx.dtsi  | 1 +
 arch/arm/boot/dts/imx6ul.dtsi  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 61d2d26..5d33729 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1115,6 +1115,7 @@
 			mmdc0: mmdc@21b0000 { /* MMDC0 */
 				compatible = "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
 			};
 
 			mmdc1: mmdc@21b4000 { /* MMDC1 */
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 7a4f5da..63a18e1 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -921,6 +921,7 @@
 			mmdc: mmdc@21b0000 {
 				compatible = "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SL_CLK_MMDC_P0_IPG>;
 			};
 
 			rngb: rngb@21b4000 {
diff --git a/arch/arm/boot/dts/imx6sll.dtsi b/arch/arm/boot/dts/imx6sll.dtsi
index ed9a980..e462f76 100644
--- a/arch/arm/boot/dts/imx6sll.dtsi
+++ b/arch/arm/boot/dts/imx6sll.dtsi
@@ -770,6 +770,7 @@
 			mmdc: memory-controller@21b0000 {
 				compatible = "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SLL_CLK_MMDC_P0_IPG>;
 			};
 
 			ocotp: ocotp-ctrl@21bc000 {
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 844caa3..ba4ab79 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1002,6 +1002,7 @@
 			mmdc: mmdc@21b0000 {
 				compatible = "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6SX_CLK_MMDC_P0_IPG>;
 			};
 
 			fec2: ethernet@21b4000 {
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 448d765..2019ad5 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -916,6 +916,7 @@
 			mmdc: mmdc@21b0000 {
 				compatible = "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
 				reg = <0x021b0000 0x4000>;
+				clocks = <&clks IMX6UL_CLK_MMDC_P0_IPG>;
 			};
 
 			weim: weim@21b8000 {
-- 
2.7.4

