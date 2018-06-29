Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A90C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895F524ACF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f04X2Xvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895F524ACF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934252AbeF2H6s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:58:48 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:12560
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933949AbeF2H6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRmKfuhJjrahfrT7JXGKatVQ55f4iI1PR01BCu1fjsM=;
 b=f04X2XvvxE2aCa8zbXSvuXEkZ+ySEpVQ/p6ZvX27Ha+4N47bzVafLdSkakv91j5fGYeAsoxqfM6BQK5ygwPFUoeRQkRjWUz4HLlFtUCAJpYp4LTH8psrSIay6vmztTU8fvubD/eAIILs+2BKhe8Lr5mcuB8Q8gMTPY5wDrFPNS4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1316.eurprd04.prod.outlook.com (2a01:111:e400:586f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Fri, 29 Jun
 2018 07:58:39 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] ARM: dts: imx6: correct anatop regulators range
Date:   Fri, 29 Jun 2018 15:54:21 +0800
Message-Id: <1530258861-11666-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0089.apcprd03.prod.outlook.com
 (2603:1096:203:72::29) To AM3PR04MB1316.eurprd04.prod.outlook.com
 (2a01:111:e400:586f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 647ca41c-7c38-440e-cabd-08d5dd96226e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;3:IrgjZUkJwp/h4k6jMHbfMIktDQcMgtZ6EffezP8E3N85GML9lUhLZnAw8eYXh3wpoHCGlnkoxH1UaooZEzLShtVRaaCEYDbywPx5Zn0t2n5bTur3MzrNCKNuD2pR79k0iWVJIlmvRfR3aekPd6rjDr1urcUOYWivJgvwkcajfV3SoT37DjJRsElVHsvC1FZXo9zrtWuaAjwX5BAMdiEcVfQjc7Yrz2tD6pQ9E4l4mFCOH3UjCkoy4CJpxDMujrji;25:CFqJVV1p1NLSFI69XM1eyV0u57TkvsPy9jOnKYWeZusNKj6S73vUasxFhRDDszKVPdaGYIl2USK4HrK8ACzwb9cFp0LUKHSLxbu7Y7j9WoAzJ08/JQyM+B0hG3JmV5P1EX4eQFG03yeK+xddGTK1/aeeucA5m+AsQDFNN6k35B/DvVn/Ycsp8dUFgkgsRZF2f7A3GiueDdoDDsi5njMKkwIln2il6Hfpsc7uYBAm/wW4bMMwViU+CPOWJRKwmqtPlCT4+ZniXHmCyZtz/Il5KgHNb4IP8hBIThOu9OmiEQcdoZMMv9YhKyLaiM3XUSYi+8GAfB48RZm6EeXmd38loQ==;31:pzUbgHdKQoojFncS56gcaHejHIM/Zum5Zfri2WdsvgmM7ngDmiJGM4H03Xa7MDm/Xdfm7+QrHM4QCWNcNb/hF9sTRohE19T8SOBKZMZO0tCJ6bqgobnDMms7Sg6X97KtR93vJJMkULpLBUVjj0Q+W4UKqDwuGD8Rom9DSSOxMSsw0F9uD2ZKijgBGJrcjwKoBJsYUVUu0wWKust+cboDfkhUDYGpO57UyM6eILCKQXs=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;20:mKDUWKEpYbYB7HWU+WAeCo3B7se+MW+kf2gIiaAReGRLU0uGVt3FO9wa35oOHk7WfrqUquXgCFAHAY6Y3GtLAYUximjldYLXGkJf1hP7bHPN5pqbpYzAT86Bu+RVGaBFrf/XRsfwyYzn+gzyQhSC0cpPiwiMJmq1/vTfQsaR9pTIfRoc1AVznle6d1JlpsM7ug3lyek5Q/PBw5YhDtDQcvhkxsemGnHZrxwD33LdG5Ykf9e4AUEcyLAXNZjttzscovLm0uweXWCTSvjL79gyY9oiBrnLX7m650f1ktix2XV+q/qJ/0pe1S5Mxq3sX92gpcQ7gairygkQLjG04XAvcJ70FVTQ8bYEr/XFMNDe0e2evUacq9TFkK+oeqkM4hXvJdYN7Ew2j4nKei0l+gm3oBVM1i2ZRS3lysrxhjZsBq4GboW5CUoMU4hp9MkFGN/6d2bqY81MRcLAydLJvDiSAAykebQfn/u2aNEXl7fKuL90SGNBAoyZAZBR/kOPt4oo;4:qibcFWKtAzSqmVSalZuFTIdKnH11JX+AZMq9Qw2dMHOtnUzMGatKgT8+Bn0WEG3O+JWbrJa/JTXLSzwRQFo7HEKFYVc9dRiare9QRstrfEiZRV5oxntJMwY7E0JegWicB1YTq3q/ZQHYq1TNND0OXv427M00sc4fQQQVYp03YzLudbcj6uebddQkrzaNtKwiKd+VNBAT8tBkuIsdEuyrsBgJuS7hGe73bNIjR+uJtJGbJwPIHYAmG/BAfEWDUd4HRf96N9pc5n13Pn4h3rHBevbOKKOHdQdBWHhFjuLlbF/ilLlhYakbDK/2w/pdGG0Y
X-Microsoft-Antispam-PRVS: <AM3PR04MB1316D67C8FF1775E3FC5B5F1F54E0@AM3PR04MB1316.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1316;
X-Forefront-PRVS: 0718908305
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(6116002)(97736004)(81156014)(81166006)(186003)(86362001)(16526019)(8936002)(305945005)(478600001)(26005)(1857600001)(6666003)(6506007)(386003)(486006)(50226002)(52116002)(51416003)(2616005)(7736002)(36756003)(48376002)(956004)(476003)(8676002)(50466002)(5660300001)(68736007)(4326008)(16586007)(3846002)(25786009)(53936002)(105586002)(106356001)(316002)(6486002)(2906002)(47776003)(66066001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1316;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1316;23:x7aNwcDukwQNHyLdnMecn80ADaCbH8S/scuyIoA1D?=
 =?us-ascii?Q?2BHpJ2cN1n0eqyHK3zSQ0dq7uoB3C7hChdHGLayTByf/IqW9AV7a1FSyLp2C?=
 =?us-ascii?Q?RSIXzl/OXMV3rwVVPQD2vZE6JvRkoWZy1o/0u6aDtKSjyZ8nagSpHsju01i+?=
 =?us-ascii?Q?e+4p4N8GbfPC0dSd9lsASdJcUM2k9Z+mLj+JiK6/Clw8VrQvUjeFBSbYJ8Kq?=
 =?us-ascii?Q?VdKqf6DGPiGCZ6winrrjgMHUc+Bh9r6cTQT/dUKCg7ilpMuKFP8UpyikwPRk?=
 =?us-ascii?Q?MFCq5216UsZzagdzEGyEZbh9WrYsuUVGHpFJYfW6l5TaleqgEfGxU/RSBhb9?=
 =?us-ascii?Q?CYOb/p22OrpuS3aFWYCBP9IA3v0t4/gfH4/BiXPi81UIM/OxBllDUcgl4a7L?=
 =?us-ascii?Q?ual/F8iJfnQ9DhCfg6dU35KES6X4DsHkv8hHm5M/jUFWs4g2yH76ReoXKb/B?=
 =?us-ascii?Q?g+A0zBWYFbX2UksuwP2Rt3mXOiStUVLLeu9N2B57/WgmjoQnGZEjJvtiwEia?=
 =?us-ascii?Q?XcfQ28E09J0mbJYi/5S3tGDbnk1xtJFccAZBZBFDqwF9WMXhCGuXYu6f3TgS?=
 =?us-ascii?Q?mtWT/NN7lmii6I/G6dVC8DLGQgT+dADATL2YDNz8QhK7jW5JFhru8Ap8+kYW?=
 =?us-ascii?Q?HeBQzIVXavU87kD/k2PceSaf38aeqm0AMvg28TvrcGVxlSY4d4wMX5Jw7Pl0?=
 =?us-ascii?Q?WXnMJTyCUzh0gkpp+ubXKQXrg1esJLuMMuvMoLLubXcN0XQw1Ksy67mRJJJP?=
 =?us-ascii?Q?B40Q+SYDx/Pa1ipMiPCstJs8IdAPBHVic/BjTxIw6K4sSj67wfJCDh+Q8uSi?=
 =?us-ascii?Q?HGxXjetqbp79sFaOpCTAG8EgKECGoAUK6x/9V2MSs/X8Ob9aF6Nn2gOq3ZM6?=
 =?us-ascii?Q?9zZ5QgzdFbwzu2R6kKlF8CYOcZKQ83vOX6+Xc81laEG++D7Z8T1rOql9+0YW?=
 =?us-ascii?Q?BgBFnPTIcqwEhIYOF5HtJCRH0ABjlYOUrBQWX3dXST50Ngff1pbFzvNEkTmV?=
 =?us-ascii?Q?pOutv5LakyPCpZmQdFnTeXNOlBIoF4DvCbjnw8q0khhPWbP8as3AOnGRQtzZ?=
 =?us-ascii?Q?NHF3mFwi2F+8ft+1+YyWsYlSVrTUsT2THx4WX8hmwNTBV0ObtSV+OATCUI0l?=
 =?us-ascii?Q?4YeK4QysHU=3D?=
X-Microsoft-Antispam-Message-Info: 432kVYoYK/1F3vUORHhhv7pcWvVfjRAeYqsCrI4ANBIkJQBw9ka9iY01mf/9OHHlYQqU+RdiacTZkLC4KcWJjAV9Fvx2Qay2Y33Hp6biKzap10kHpbiYNFZuo85FH90VYzmUmhDYVvsGcThWELKzS9InYuMlGNjRfNBe34ZxVFo0N6uQMD5irRwEODCd9CwdhenjEYokGyWmKZixkfLt/CoEsbhrCIbtfoCgpmxphuLjpuWxrnK+UWabhzwSTnkm/Yz46lHz93k9UljJ/0Q8TDAOuXVVqr8sMbvKLl24kKodnVDblBejR/HF3mnz2G3L9T6qfeWQzeg6rpoijBbNgJ614boa5gYKHe2or/THkms=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;6:Jh67ZFZYyooFlQYdyxQ9paCMR7h22l+E1Pp5QK8jR9p321bbwCMQLOWOkJIwVHHeh06yHRq9U0yzI9dHSqu3sABm7JBbzHdfZJfJw1roL/5WeO9kfA1USjmO8TT7Sv1DthOfZozOA3XZxPcz0ZEVFTuPd/DDG5Xa2N4v3dgJaQaGeOwNxnvJORJec1+qW/Rsfkvsa8xaTw+CulNvyrh/w6392XEq2eDh5VOpU2cLkQLSf9sljb0dh1DP/ZEG0fAAvuIwcglMdHJdnbi5UyHzhZV427dhWsQS5+eihYVxSij1Flbu5EMbcSHwhSA+llMGODf3WyBN2a+jK244hEqwU00qq3otSLuv5vbIvaA6mp48EOcAI+wAT/mV2x9VEoVaMG8phhiu1Yy5aMf7U24BA7yd3rDUUNGKKSPuXu9danbe/TsBiK8RX+vvNccAhKUt605CXSycRwRzAtOAxIEiNQ==;5:z9eblVsJUYc2O4YGf6Isj5HVJwPbHM0p3s7Ryzv6XeAeVkjNq93EAXofUq3w9/Uu1hl0UBUNAleTCGEh9d92tgmhjDZcJieZK6oMfU/mxaeelffwu8YzcaDM1gLvnYRJ3dWdvuvMVVZhxvxIqkOx4VWPTIjAEj5DL7+8Ox6zrVk=;24:mJLf+sUn8PhH7kaH4LaiY9NNwbLMDJKn3InTBLv7GxfJgV9tffsgpaUkeeYzEX/l0RY2kD3AqFHH/S3HdJqEUJ+qKhC5Q79uSt91LY4QXjs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;7:dL52nhHfKul3L6Nb6SdBN4dRyL53ATNN5/ACcCgz6XZ+LEZ5Z86qg1hIiPbhA1r8/HXes/0vcvmIQEXIK8FGtn54PQ1rzhllpX9MLDUka1my2FPEzu5el3FS+m9pMky+Ft6GCz393aAgwr/lLLXIsH4kUg07vvUnWO+SxjUHWRZ2y9xsUmy6/B1D+GzRnNpt0jy8DvH7BD+Kx3A1fnXrqtkHW9KzwqauUszK3+DFoL6sYLLsEqMp/8W6LAOxi1nK
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2018 07:58:39.8932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647ca41c-7c38-440e-cabd-08d5dd96226e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct some i.MX6 SoCs anatop regulators range
according to reference manual.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  |  4 ++--
 arch/arm/boot/dts/imx6sx.dtsi  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 911141e..d9f98dd 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -689,8 +689,8 @@
 				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
-					regulator-min-microvolt = <1000000>;
-					regulator-max-microvolt = <1200000>;
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <1375000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x110>;
 					anatop-vol-bit-shift = <8>;
@@ -704,8 +704,8 @@
 				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3150000>;
+					regulator-min-microvolt = <2625000>;
+					regulator-max-microvolt = <3400000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x120>;
 					anatop-vol-bit-shift = <8>;
@@ -719,8 +719,8 @@
 				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
-					regulator-min-microvolt = <2250000>;
-					regulator-max-microvolt = <2750000>;
+					regulator-min-microvolt = <2100000>;
+					regulator-max-microvolt = <2875000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x130>;
 					anatop-vol-bit-shift = <8>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 81f48116..3d7931b 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -539,8 +539,8 @@
 				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3150000>;
+					regulator-min-microvolt = <2625000>;
+					regulator-max-microvolt = <3400000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x120>;
 					anatop-vol-bit-shift = <8>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7130ab8..f26f611 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -607,8 +607,8 @@
 				regulator-3p0 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd3p0";
-					regulator-min-microvolt = <2800000>;
-					regulator-max-microvolt = <3150000>;
+					regulator-min-microvolt = <2625000>;
+					regulator-max-microvolt = <3400000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x120>;
 					anatop-vol-bit-shift = <8>;
-- 
2.7.4

