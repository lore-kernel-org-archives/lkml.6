Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774BAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FA52124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OJPLpHNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FA52124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbeGMIQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:16:44 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:49760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbeGMIQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skcg5MAFxS9XctYJyPOQ8KhYZpQCdIfbDPCHrK0VVQU=;
 b=OJPLpHNBGHsVoqnLQ18DTq1brnxf4MuuAhYT9AHx1eIJ+qqCjdixhhfDqbeqPgstsdYpbgy2F5ROTGS/JkaMDHRHe4Oh5GGbVPzt+z9wjcg8j+u6Z8pfPHg+94Z9tJvZn7e4S0Co9O3+UdlRIKEHTTH52YZ0EiQ08sgSSBK8vyQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Fri, 13 Jul
 2018 08:03:02 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] ARM: dts: imx6sll-evk: enable PWM1 for backlight driver
Date:   Fri, 13 Jul 2018 15:58:25 +0800
Message-Id: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c167e172-51da-41fb-fe76-08d5e8971053
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:G0clXzkP1x7ZNQ/gEyfpVG9jZgzK1rSzd8Lxpla57+0SL2R1a4Kg/dAnmKGEU7+H5/I95R6g6slQW0v3++0feiX/2rbMih2T38Yf7X1sPl0/kmISGYQulSd9VxlKQquWYPcpAqo85u5VOJ0X5tlSXRy3mxhPre9M1u9cta6p42tnEgs29gQRxQvafDTi3tLcfuNkWbPHyJOsR/nDlhCTtlXbk+x4YgaREV1kP9mvkNb03ojf0SGtmFXEcEHOfTZF;25:SpmTXy3+qBxBkQhkt+4vZ/QWTosae+kWCLrqNxggs0HXYH5l3KDw7dgRX+1jlI44LLT0Ksrz+Mk9CMT7WvoBT5fT4xbksdOxTsQo0Z2vbBcELG6zx/U8BwTAgbE8QyB9REQMo08YdrkNSV1uyFv3cXgmFw0hqAl58si6L+8+0pWJRif4ComfgJfCgUMHcRiMTWHDVbKZMSMII5RAIFtgDJSsOIZuxsHkWFBU2YvpQdjgR6UDe4CjgIisMwPFxlgnK61TNI8wffVEsEthxc0fUbiOhiS/LVBqrvYcP315zAMulO1VgdlrpAQBMYeZk5OF2aJ1wNczbw52+XwM5nLHrg==;31:IZJNODGbYTn5xbAahftwI50EsstRoHp7pN2bEBqhMJ8K9u7nYQCDZTOsZ6KGfx8wrpfQeQnlgwBn+b40Xf6Sq1MmHtWjwvdjQahP+emz5ShKKI4CegHks0FxBrELcYOCW9D3VMu6mN1KFHCqYJa87AUcUioQuphXAsd7t1WbWyLFK1zJmVrjwzhv8GJhxdvNptIxoEZg8c6FmZfhKdVA9/e4Pl6TH2LI8TuBP0t3NT0=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:4u1g0ikX+aFA2HjtcDGm0EOYKSQ1qdZKTtbFoIZ3igZkQYji3s9s0UJcJIVwVGTemhkLvTsMy5anInXlW8LyRBtMMGa65WfzKCrO4E43/tB9p0nr0iT8wKqoH9Ued9IVFtV8SAhEMfxMo2dnU+7cPi1mkDqnJeWHvtcmYaqVZLaesJLR2z3/qWhEjxLgmdM/jKX6kqOuCHZgzifAPwl4QexSgXYzlC1r2bGYh6gqsjv8ljRjH5DA3qwtCc/pZsrGWsyt4Jpp49zlq9vFYjA4SAlsekA9NXjEjDATAd2b4DZC50W/D9eaZHawQTBRPTWNCFRrI8+PR/FTMuvrCJsZgq+shRscn1oDyHicjZtMAQrHOvh0T0nRUrN7pmwKojmkd5Jh/Xd7Wd8mlh20ww3ZAXoOUSrGNa7zeNC5m3PI5vh5ICWrYT+5TweWqZdc3/0kHMcrAbMIsDsYu3hPR2P+oH5lLMSCZe3t453Fq0hCR2B4IFjpZH1bWgsEId5n7wRv;4:mWajvMkgN1sFDMxzRCcujppFEnWnjP3cot0CZsAWD1U0KQ5qIAtFlnW6l39rqsjjZrzuuuKdeo0D1mex7KLtfrIWzGOgPacZdVoYMSgDiytiDr1dlYCd7aczLiixmVC/zSI8xS+qbvtiYUwABiCzVFhHCsyhrRzx0Ue+0to08liRDg5NHFjspfzX24RVbrNX8azHyWHB4u/cHlzSs1VHtO3aSjrxyWdunQM5QOQ4kfJnvRdMJnBz0sbMu28FooG2nQ8PeoCJXH9dZBv4/CBoPPO9JLz9GhdT1bkQD8UNdZBKx5BAJONz42CyJF6zArGF
X-Microsoft-Antispam-PRVS: <VI1PR04MB13278120627646392A614703F5580@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(25786009)(305945005)(81166006)(86362001)(8676002)(97736004)(81156014)(6486002)(316002)(5660300001)(66066001)(68736007)(8936002)(2906002)(16526019)(7736002)(48376002)(50466002)(4326008)(6512007)(52116002)(50226002)(16586007)(478600001)(51416003)(47776003)(476003)(6666003)(2616005)(956004)(36756003)(26005)(186003)(486006)(53936002)(6506007)(3846002)(105586002)(6116002)(106356001)(386003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:qO+6oB7GgvVIhx5tIOyN3WQb6tn9ZKHnf8S9mxttE?=
 =?us-ascii?Q?ACZ9GUqoxBBgFBGLow/9qwPkpZOoisEgtGf4i76brnZfczpJRFnApP4HFxyl?=
 =?us-ascii?Q?cBXWisZPDQEEaCQVbc74K5mYoIt0sJFPId+fKBahXHH8yeDTk0JNmIWe1s9X?=
 =?us-ascii?Q?EiI3UR2E2D6nn4ZO6KCIf2uG3EY03w9UXqLugWNVW8Atx8Dn9jdr/3NgcGqE?=
 =?us-ascii?Q?jkSOa6DaW8SuBJYfyhWOqiTLlXO8qWIKll6XvNR0Yuwb6s0poXf5gXOhPBz/?=
 =?us-ascii?Q?kZRxteQZR0L+h6W7prl/MurXnZzLL4mK7JhKnSKlKmX5LpVOYOrf4MguYRsI?=
 =?us-ascii?Q?vgSqYV8Modf8sr4oRRLn+ENrQKlmxpYqVE4AAog5VnbPjHjznzcHGMjdT4mo?=
 =?us-ascii?Q?3zBRVlPkxvmR5LBCCCPn9Xgb4JKLPZSQRkOaHYOsu3/M/DqEVgxVFCKxFLfS?=
 =?us-ascii?Q?PtiPg1iJirbQD2NxnX2RofatN1aUL5I/3y8olyTnTBDTFgUIc0/w4LOps1ei?=
 =?us-ascii?Q?FV5nkWDCxoro/s3gJs8BfwMgVsOvwooBg/pfg80C2aOjJAvSc549Ms6f9sCP?=
 =?us-ascii?Q?35O5N93SNpWkHTNOA8EGt5b4dg82Zgs2UU5L7xVzBL6tWAUtuzkBWpgVu0Wr?=
 =?us-ascii?Q?b6FycWBocrfDtfmaTZg/SeAnpRgZ02U4zem6tk1C/sI1dZ3DmD7w+44HeF0B?=
 =?us-ascii?Q?Mncs2kQaPdbNScKPXp7HW/ufX/dEszRz+7b/Cd/iH3gl2gAqk1JX5bZ3YFqq?=
 =?us-ascii?Q?wNctjp9P75kqGPPQIFFhsgiPWvdoFJ803XPpIn+J/zr60R0NYAgptjMztc3Q?=
 =?us-ascii?Q?ABwEE6JfWKwiBu1nAcRPtDXNsqgqbOC8lhLyf/YhxfrS8fG/6Lbgq4dNsa01?=
 =?us-ascii?Q?iAo2ycf4b/XWw3AkUtZtcxMTFannsfz4wBQSrrLlIX10JkEzz7zo+3WnQq4+?=
 =?us-ascii?Q?8upWebiHNzdJmeuyzBTGHB/r5DMYSOLkycifu2dGSUJjRZ+GqlHZBy6AToIQ?=
 =?us-ascii?Q?hxir72FZTVOPGtAkYxc4tfHmy7qaK9mPOz+2HmnLfXPi4Q5d+TLQVk3xr7jm?=
 =?us-ascii?Q?TnsemI7X17e2SifoVubD57RtShlDBk4P28SvQ27Sa2Tku3H6yAwJzyuePQBV?=
 =?us-ascii?Q?mucJ0l3ZWWuGUJ5xHrnUgisLGC64DZW5LwfLGfCx3blXp/30jz9AA=3D=3D?=
X-Microsoft-Antispam-Message-Info: Zjro7XLAZDdA+ibOxcc5CvX5lLiigKYMCPxhMmIVMX4vhS7FM9cDps8ce+UEhE7sKK6lJEGr71huZVlJa2RFgRemo3HtMgEY7QcAbc+xiECOpN9jTFauHGljIu0z2L8qNCZJ2SWyoxcXAOZ8Izrl8LgiDn/uvqjbOQlPFozCZ3m5WY6GdOhXzKbnSBjRJM00x6h3D9paKnfaa/55AlxhPZ8qe7N2QDdjDoedJFK5XzNfAbMc3jYoTuT1RV1cz/poDB/aFQpOfriJdoidO1JO1j5f75totBcR6h4ilSBgJnzJBcDbZul9tqb+8aHi02L/JBfTsiMkFx0/oFqs3SJger8q1sJuc7EqroZjBH1llq8=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:mkjZEU9kRh9VrQEugs9SnRWcRsp4KwflvvkHzeScLIbOpULnKgT3oTpZjv3kqK1QnNT/olnq9K1KQRaGHzBsoqgWmHlQmU7THRE4OJ4ad3/c2nF5SKeFI182JxrNMnvfXs8j60wa3yvlolPRggX7rhIYfI/79deheMK06OUvnqdpbge5evYXIalfEDiOVZggJPBq3IztqLNc/LLEVqKjNz6CIVlqQMCXs2QJM42+nFItolYSeQLVH7eqNYfYbiTvamZejH+QtBhnt98mh+tyBxtr2XWEdvc7maCRLYDDCiZIaxkzASHfKkeoutaBGsui8Rkw/xRlKwth0VpAy40WWbjljFjrawfnwRhIk++LkSWEAnQv1q93yZdosroRGOXeJg6zY0MjWk8k+lVu50CQij36sgtbD3bDfHJbPgz6d52r5nI6up1DZdeiOMSICXGS+ojB6G1NfX412SuAfBRjsg==;5:FwBnFyStWBzOvXJgbMDOO4yoo2JPnQAL7ZPs/gLvbPDWAO4XVv9BheTbQl9nz+rDdP64/PdB5efwEbrWe6EoJEEgajv4bGRbMT0+kRq88TKWUgF+u2BOvsDwsmFJwfgXznBkDMs++mul7oClODgofqAkAMhaYIgpIVWR2YlGhKM=;24:iMrmHm9Hxu+Ra94DaCuljHPFERTK0xYVmwpqiTC6/L5QG2quXH2wnjxfKgFJC8gRF1clJFfh1M+3E70PkjanGL6DGsc2BxUxj2qyDYzo/m8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:3x+RHltvopM6UhFiD73GbtttYCIYVnSdBApYQpfNzXNvTrZ47JQxfZHQaDR/O9MOH+Gt55T16yqNLXC3o8SfLSPTMx0lL7+tDoe0U9ZVvmmXUTcZkk7oTBwYQELm+zmFUlyUif282FyZN+9vq7eqhHuIwpOYiz3SoL/c/jwVIDqxBL3YPxZL9C8Z8iAOXCgX4osggZxCDoowhVOjz6/5BHRWVjHv5lIK7jHc+Bc5YoaXFM2zUNI0FEsUpLzMEQz5
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:03:02.4261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c167e172-51da-41fb-fe76-08d5e8971053
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pwm1 module on i.MX6SLL EVK board to make
backlight driver really work with LCD panel connected.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index bc8d155..cc5cf5e 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -213,6 +213,12 @@
 	};
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -381,4 +387,10 @@
 			MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001b8b1
 		>;
 	};
+
+	pinctrl_pwm1: pmw1grp {
+		fsl,pins = <
+			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
+		>;
+	};
 };
-- 
2.7.4

