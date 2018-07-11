Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE17C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDAD2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jH48CUvt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDAD2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeGKMR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:17:28 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:14816
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732320AbeGKMR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjmPFZT0su44VxoW2AwyaqtHo53nOGrhEyfESWCiV1I=;
 b=jH48CUvtICjkhp1Q++YSGbF5BDa4EeXh8oHrBj0hqIhIaFqM4shBkI+XE9etsmlSsGdb39eb9bFo5rHzS5kI6X7ny4dxRMeIixLTVEYrgR/dG1LuehSFFBQKTLhi4CltkSV7Z1XvtOCjk4ERQ69Rf0QrS4HAXQl2NSV3hsIALrE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM6PR04MB4295.eurprd04.prod.outlook.com (2603:10a6:209:4f::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Wed, 11 Jul 2018 12:13:15 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v3 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Date:   Wed, 11 Jul 2018 15:11:17 +0300
Message-Id: <849ea1c3434c87316f15953089633854e01938d6.1531310547.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM4PR0202CA0017.eurprd02.prod.outlook.com
 (2603:10a6:200:89::27) To AM6PR04MB4295.eurprd04.prod.outlook.com
 (2603:10a6:209:4f::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 398ba0d7-89b1-4d16-0a22-08d5e727aeb8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4295;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;3:InoPbKVbqWyPnfujaTYOCVKzgmJ01YupMrxMxAlLibXfB+veaV2IgDSBlvgglEAJoII9r7XDfwRDufEWVi7nTR07gpoqwY7RPvqztwP7xoKQg3nSIpA/8VBFWYJ4FvwU4IC8M9VBNxzh2g8EP2l1su7IFrhrxvuK1KgBtQndDnJGszIaSD9va2VXScexTTY1cRig3UXEVay6vqI6P6cyKbbkzIyVXp5OmpNTZcHL2mMjwTruxtpLfWqsh0fJ17na;25:KTSPsN8d6UArhfzBl6yrLqkhwfyeEbzGuftv3L9oeD2xjBhYdN+0TQLUFH7UGk0a2aIHfF4OUVq7HDpyfF1AwM7bkdm5jlswBQCRsKFvGi3NPOQfaArRpVLjvsDKm56Ti4prUoxYEVUXGXJyYAOuSUdyieNq4xqgitpAsK8iT9TZkY2eOCsm036LMeXPFroage1sromE75CyA+hxgyXx1Qk4ZJPbvi638d2124TNbOyeq0jmvDYUEDvyR+BoUdRYGGZjgcgHYw+c2aUPdaQnw1j6Chu5edTJy2A7x0UyL/MIBeHq7mtpBw+FmhMjdL+/QF2orIMzTnJzEt7cUe8WEQ==;31:XdR9BNdBVpLIb7hoBzlWE0SoCnjY+S3THx7EtnwvZhsq9ql5KGcb+XALXuUL2DOMGGHMiYT5yj7DlhVTT6tgoM+07KWnyaoIeGeAIg+w7DJ0fWrW+CfYkVvt6CiGjNHDcUxK7HwY8Pu8FxJiEZDavqZPzUpRpmIBI8CvTXN57IA014qRjkz3XG2kg/8ihUkO2A0a7mfBFAMoPynL+xmSDaPS7wBIXYALkfFBjW/UXXs=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4295:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;20:vfq/bfKWz8n/wBJeaj6jeuELjvciMG6VkO82mMwmpeEKWIMxAm/rhpA9GpeYCIwQcfsynOcAR8Ft0QYMjAQQuj9Kex53Qc4dbXIAHu1raI1S13PX6qmBCvV6xlHaXMdeCIpVnapKtf5nZugByNxFol6yVqyM0+JCX0SobV1dQBP13H+pKRlN+uW35irSB2YVMr6//e1gQKBoyZ0Hcq6LlCgCzGjaAnCr+UNAQrDqeEtUBNeDTP4I4MBGyuMK0ZP0HHyu/Z1Dcq1HPgjRYJ4VMl8uiQc83iViQjIwJd0JbYtuLQXMUhGxSS356uVdwfE4YyUsJcUPTP8x8LOzOzRKvxCNSLHGhv2MRHVS+3/Rf1OSq/V6azvewTCG5axUe9AWgRXqi+xNoejtn9/t+ls8slMdMmwKESKqMnYL/mYkEF5537VVZ3LggJ9efXnv+b6ozYYeLrhs/BdBzUBapwCSZMk8xBe3JaYXHm/K7BrKjiLbb24F8nuOt5Rlev8pALRh;4:+SPGERvXNRT7lg97LwczUOsUWYn7bD2DHmebhzeobYrRTuETLF9r0KPNNlOQMVJ4YyGp3q6CF6ZUq6aLaahG5dcyBWAJm1PWOSM2cUCg9zXIaZavFjMJsLBftJmGCko7GblhUm8WWRJLBrtZnfwubsLv0PDBchsMtRvO7gHlGuhj6Plouavn1TSGOsQw8CmlEJAFOkxL95WUltuZb98o2ZM7AMgeQrW/4c7Xw7JM+h7QM4EeDaEK7BK2XGAXrydVQxqZq0NSjoMAErgOVc6ZLWS6Oo/ee1KIeaLaFQXnG8PTdsVLuFHN0AyUuxdT1WBe
X-Microsoft-Antispam-PRVS: <AM6PR04MB429554DDDACD27D9B4CFED21EE5A0@AM6PR04MB4295.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM6PR04MB4295;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4295;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(136003)(39860400002)(346002)(396003)(366004)(376002)(199004)(189003)(316002)(186003)(50466002)(16526019)(26005)(105586002)(53936002)(86362001)(4326008)(25786009)(14444005)(110136005)(51416003)(6506007)(76176011)(16586007)(386003)(6116002)(52116002)(97736004)(3846002)(48376002)(7736002)(47776003)(44832011)(2906002)(11346002)(956004)(2616005)(36756003)(118296001)(6512007)(486006)(476003)(446003)(6486002)(478600001)(68736007)(8936002)(305945005)(106356001)(5660300001)(50226002)(8676002)(66066001)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4295;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR04MB4295;23:FbkwN+9CPSZEPUvHY+56AL09jVR3bIvXEzdVodSx3?=
 =?us-ascii?Q?/rUxVgtZCrVeLm/+0rAnAuW2SQZpN9IAEmQ+LunfhMuBS6nVbPWO04H3Vs4c?=
 =?us-ascii?Q?aIx7rKHs2LwWqgcpzYenNzMbvtGLoX9nU7ztBGerln2V5vC7A6x2tNk1FvFR?=
 =?us-ascii?Q?OPYS5zBgbtiLvioBj53vnrq6kAnoaDmlqt49QNI+DqU084YU6n+JZ+QzIbwy?=
 =?us-ascii?Q?K7hBHh4RJph73uoqD0cW7SSli0hp7mebP0YtHK4Z1HdjQmGi8A/H+dgxDKt9?=
 =?us-ascii?Q?qVIJKKAYwIcSGwcoCRt0DxUw+zmsOef/P6dUWqJOl8H9BSv0an6vx4YQxwj4?=
 =?us-ascii?Q?3xicUglxpr3FT7XSH1qC5iDq+A2e/plz2iAtSLB2HD0lmW7XoAbpFx1HIdvx?=
 =?us-ascii?Q?t2O0GMSHyObX8nMRYvLNom2haWnWkapUeIvik48r2XGR3MslMbd1hcilKP4R?=
 =?us-ascii?Q?BvIhdW0Bu76G+7ctCv3Mct9pJfOzZ8aeg9K7BbRMZTm0+TLLoBnfC9grOV35?=
 =?us-ascii?Q?N+Ms/0JldghqiT6w5ZY3vUzygnw4ZmBzaT70C+jUKCQJqT5Sf96ncS5D9p2A?=
 =?us-ascii?Q?2Y/zKH0mzT1f1BZ9EjmfvuoJsOMV55C2DDcTS3SiBtbMfNpnVP5F0zkoNNVB?=
 =?us-ascii?Q?pVCIdq3LpSnAW+Rib5MVfbQXFdIzFcVxIFueLcnNELoEXNXrxkF4utt3/BSI?=
 =?us-ascii?Q?qrsqa75dJBVdhPGCKx9WFN/KbOhtdRDTfOEuavLZQ9YsWAyAPhz8sHjrhAB8?=
 =?us-ascii?Q?CU7b8YtxXJ1/MJ8sMxdOfUQbWV4cWefkz0Wj/F5/JAeJys49TiU+keqvieaF?=
 =?us-ascii?Q?d9yg6wFoSbcFvGH1wr3HvvhhWVTockcsDvKDK7/85htGrpxIfiwkAyLd/l78?=
 =?us-ascii?Q?wa6D8in1iISc154HpJ/1NFYsw876X+FZxiki7iSZCrq3ZMxSlXLx48FOfhL5?=
 =?us-ascii?Q?8cTfoTOM1stg7Umibg8x+PB90kDD1JBWm53jU6GESA5Yr8LMR+btNlN98YS5?=
 =?us-ascii?Q?uktsKt4ThFGbcrJMQsuBV2l1EJaU8L7dbglc9luo2ATD/vaHxq3bTlLusm50?=
 =?us-ascii?Q?H6E60G+4k/KQQ30QmI5UsmhMo3J7hDE7OBCglDQYXoFRBfK0zOvBWzoMXYRK?=
 =?us-ascii?Q?PmcBflqZN1N0qLn0X9y/l0QcK4m8OlTRslQVH8NgSZ1hA5/EOQ3UDqdh5WUE?=
 =?us-ascii?Q?IrrAXmgEL0qz+WfZsGlJcrmsXfsB4EI1K8HTCYHLnBSRyQ70hBpVqmtTdwu6?=
 =?us-ascii?Q?aABAQidNE8gLSwHbwA=3D?=
X-Microsoft-Antispam-Message-Info: dSg3CqPq/dqPJyt+ft6dwNdFNkXpeXFNSERaD0r5oQzBbebnrYFIrgzyydqtHiSOStH3z0rvajTq8wZvWxAeaxvbVOW0Y5PEcvVFp0hW5hgk7b0alaUWhAmTBBTmWHLGxE/OzmcD03sKcBnfvbNz8bTaLcdfZmMKcxcByNfJJBgige26NU3Z9hLV82GDYLmaXApnntN166KeDebhsf8YfqFxq05yJ8afrbCoWiztF93vP/pIZCpbKe6plvQL06Iqi7EDmKiT+1HLU/OC7MtZECcUVbiKvOQf1Xe0vIk436sxvHF8WdJ2JrAOC71giMzkK+UsFFbPJjOLsPx1VmUHbI6TSLYpQiCvpK1nKd7g43E=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;6:wuo7Lysqb5E0sQaR+xUWtOiKxNxXq9fgV7CxBjMDy8BK8U1WCfTlAOy7sgv0RYcBaljr7fWtmqmaoEENILXbu5EZSYmVuY8O6k2aSWm1g5hUlhC21hMQnVu9u0/+F3yKjs7nxcE/4OHwXSU/zBX+Zuz67NANceAZB2QfuFc3T6tcmXHwKDlGrxzI57/YeqILflQe/7gd3yObRMsoTt8Eg+2yeh6pgS/jw2P6h/RotfTTSax/MRmJ0y8mhFYw5FpbIWGS2BEpFJTpOHpFjJIaizO9//UbGEtB4HEfSYfp6LDX3gfrUJugO/bCeJTeG16wiVycWSz177wNXN2BQIJpY9lu4SVcaAYXSiXqqS/Kh2ykR/+tVQtnpMdT2POJgTNmb3n/iXb/dosOj8rR4li7ySAS0d6G8KWproIY1KmQD4AY6JM/ZzwiW5fD5TR3FaZO9IlfQkbJYTUGl3f63sh9dQ==;5:/3k3y7vMXBERF9fBA/ReS+5BjcWZcehjOa+Pprv9+YKk+0lQ9MauZwJy2hfArcsjRVZl1V5j88BnSq6nZcopn3YzYoHID3wM5mhJwKjrP6J+UxJyauS88Zistk8j8D66vwfnHNN2T9jYNe1KO4mZm1l6hMbQqTv1OaeyDPQkOB4=;24:rvQ1DWUNRhDh4zniFs8loYCAxzpAkRtIH9jRkbXX/TggpHqYKbEPOtVd0gSw2/vHDtzR/5kNUmPNve/bQfLeVvh6k4rS8dtUKbqrs3P6pR4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4295;7:cemlqLMxKId/J202NZ0XI4tBSjgad2/sFt0lujxjwypHQtFyYz8xRlX1/+695UiRg3SMsvGyxsKBOwYcjlvNND612a8VqaGQyJ78F7oQiC+01DE00Mu6XHR9c6vO2AYwvqfYQ71qOniDm5AJqBDqKswA2e0fOeXUDml9hrXwS26OShK1DCBKdVwMO6VhdR6I/uPz3pQmtQvP1IQS/FL5FZSbxqvGXRcu8LW7yC4G8lO6Yb0d03l4BNMh5vL25lau
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 12:13:15.9077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 398ba0d7-89b1-4d16-0a22-08d5e727aeb8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4295
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
the DISPMIX domain can't actually be referenced. The pd is still defined
and pm core shuts it down as "unused" so display can't work.

Fix this by converting to new gpc bindings by adding pgc nodes and
referencing the newly-defined &pu_disp domain from &lcdif.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 102c575a6025..49a56b4fd393 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -698,14 +698,40 @@
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				pu-supply = <&reg_pu>;
-				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
-					 <&clks IMX6SL_CLK_GPU2D_PODF>;
-				#power-domain-cells = <1>;
+				clocks = <&clks IMX6SL_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_pu: power-domain@1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_pu>;
+						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+						         <&clks IMX6SL_CLK_GPU2D_PODF>;
+					};
+
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SL_CLK_LCDIF_AXI>,
+							 <&clks IMX6SL_CLK_LCDIF_PIX>,
+							 <&clks IMX6SL_CLK_EPDC_AXI>,
+							 <&clks IMX6SL_CLK_EPDC_PIX>,
+							 <&clks IMX6SL_CLK_PXP_AXI>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr@20e0000 {
 				compatible = "fsl,imx6sl-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
@@ -756,10 +782,11 @@
 				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
 					 <&clks IMX6SL_CLK_LCDIF_AXI>,
 					 <&clks IMX6SL_CLK_DUMMY>;
 				clock-names = "pix", "axi", "disp_axi";
 				status = "disabled";
+				power-domains = <&pd_disp>;
 			};
 
 			dcp: dcp@20fc000 {
 				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
 				reg = <0x020fc000 0x4000>;
-- 
2.17.1

