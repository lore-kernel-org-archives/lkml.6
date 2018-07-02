Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C225C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A97256DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ILZZeTE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A97256DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932775AbeGBCJN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:09:13 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:58877
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752879AbeGBCJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04uvHTTltYarL6sBNg9eYWVX+pubbRFoDw8vjulR8o4=;
 b=ILZZeTE+mFP13h1ggobB9xa8rQxhASCCYju1y/kuOOtIfmY0G6+sA9+AuWIRzR2+vS7EjnJm99z+oNE2ZWlYdq+h0/FsKoRSfqrTAypvARYU4BmfuYYczqJC7rCfh01Uu6djlP9usqUC1kpXszBttIr5FK3KZXhYzbu1cfSvUx0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1320.eurprd04.prod.outlook.com (2a01:111:e400:51cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Mon, 2 Jul
 2018 02:09:01 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.stach@pengutronix.de
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: dts: imx6: correct anatop regulators range
Date:   Mon,  2 Jul 2018 10:04:36 +0800
Message-Id: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:203:2f::25) To DB5PR04MB1320.eurprd04.prod.outlook.com
 (2a01:111:e400:51cc::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08d698f8-49e3-4dac-fa3e-08d5dfc0ca34
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;3:RY9u6Pw34Dp6N/ylRYXQbtrfS0Ggjm3FU2CDrOvrCFLSbbkBF9ggioz64hjJ2mo4s01dfqTk7sV6CMJgEv6EfFsngel+1ZQFylZ1pcyblrCo6C0fQ+HE1YxsHZjY+k+/rJ8yL6ncJQKmFUuF2JoyBPdi2rrlchwD84ilqekH1zDxKEMKLGSTHJI8X7B4PVhf17SrD/ERnenlD+HlOBPS+u1g9ax2a9CxHlVOOotrqI58wy5ijQ6jnrntJF4DsxTJ;25:5WHBsbbt6sIEapxZpUImLZ9L+3bmQf6IpNvGd6FqX3gEnD03EMPBFtE56zt9n1JL28dpj5eMjUUw5SccGLZox8kvn4UQ0JVk8Rwy+29EpBjJb27u/JmaPr+tj67mqszSIDDthDAFczHHlWIa/xuj5bYBs0trBX+jL7z4KGu/vg7Bee47M54svs6PCSD+4lb1l6+jEZd1mw8Adwy1piQGZ9ElMG9T4/zqFVWuMuFuRYnhJ3P/FIPJ0vcxwYBWXICOiG6cBXVlIG+h4lFhtzlHhRZCE7vTQU5JYtKCU7XO/m1dtfHmWYLFRYurnkK1yiBSMXacFXOXj/d73TaAxmy7gQ==;31:DAvXrCg58kHbaeKavT0ANdyWxPNbssGpL3xX1flX3pxMVykAjk5JynpzUIf27Rgx9M21BGwtEmkJTMTx14CUIJqw4FsC25awv5KUI7OS2rnN3O6Kkd4Hu4IjSC/LBsAuYnb5Jca7FpusrvBf0u2t57l9O7A7qdBb7zJ1Bfgv0ZXd6QlXFixB7QwOddkW2Ti4hNqX9AfQpdMH5GBOIuATRWGWugSsNur7QyxxUNQh6xk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;20:R7cvcRQn2OUAZAr5V+s8Q31WfdHO700RTUNFuq8j3a00O4Y2LlyP+vEUzbrhzEH5M6rHdIGD+mwklLSdpuenTygQJv0AnDSaIrDRXETCSpZKZ9rRtHzKVMrnvwucSe3Zm80mWU9XhS83CfcQVq85mkdopjDY1bad7mlJRymkzKvks7aPGuhdpBPiPEKQfifzCda+ahvhlG+5FqB+r7u0rHPWUM0IcM8fOGNjCvkwQNrUyur5wYGJygLDprqx34A13HaB0+JrP8dQPlp950LL3ycOI9MTGM2UOvfqSw5vK3Jx3czNygZi/qpaJxdV0em/DMsob3Rh4lRTxHYn0lVGVLoFCK0w/8k2UGVdw0kvt64QgJBlXGdEo2uWCd1ASiZ4yaNgNeiY+eKgj8KP+z6ECrNVCRPbnqDx8OAX5AAPBrh+2BJcvGSC6FPIc9l9T3gmL64kErw/i6as4d/Nez0DuCvlGd0rkvrnZlPzCplRWybCftjWunLS0AC646Gxc4Lz;4:JQ56kXR0my7q7a3UaGZMfJ71Qr87uh21rDuFxdkCGMHcqO/hqy46ahfMpW+CoJvxi8f2uka0dZE94PpJnSg2PCmVkF6twDRIAmc62aMUseV/OMh6y2WcSyftjDYArgfgT+s2Q5HyTFGrefHA0I7hZRdATeKWTSTm9w/+NqmLldauDEEusKIrkTpaBmlZ+mzQWWjT8roUJbQD9PrcIxH49vOtYpNAhu5FBcAk7Vre67RxxdbV+JPqQbO68s9lXt+dgLf66U86AysSp4JIzN+IzH4MCz5ELar/r2+GkkDg8P/lF2M+ERRccnkoiz3nP33e
X-Microsoft-Antispam-PRVS: <DB5PR04MB13209308961731CFCC293307F5430@DB5PR04MB1320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1320;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(136003)(396003)(189003)(199004)(48376002)(47776003)(66066001)(478600001)(50466002)(68736007)(2906002)(5660300001)(86362001)(6666003)(25786009)(97736004)(53936002)(50226002)(386003)(6506007)(4326008)(16526019)(186003)(36756003)(7736002)(8676002)(305945005)(8936002)(51416003)(52116002)(105586002)(476003)(956004)(486006)(2616005)(106356001)(6512007)(6486002)(26005)(81166006)(81156014)(6116002)(3846002)(316002)(16586007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1320;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1320;23:sQX9UXh590p6zkvtWcuT0luLS0v2rRySpIc/2NiG7?=
 =?us-ascii?Q?BVYCtX5bibZIB7rAwE4axUPbsj2X9Gs2qnucl/iQ7D9Vb4pEIM3k8Z0KeRRf?=
 =?us-ascii?Q?usXqlXvCSouqqZJiOx0ECrp4/EmnZAKvn6mveGc3UG6PgZmQqotc4ULod9nF?=
 =?us-ascii?Q?ROCL4cUtKJAW5bKWL2fv9lJ+nRRSPjCWIoLGzzBgHf9+qnBghvFexNFwDFOW?=
 =?us-ascii?Q?j0fhQ5SPoubzs2MsblJMl70hosvoOdhgXOAX2cUJsQWVjkL5jqP3F003dNcO?=
 =?us-ascii?Q?OIv9pAHp8nvYPHTsPDuo0FvW8Y8WJZxKjS/021Ltetb4KJZc4abDUW1fd5rT?=
 =?us-ascii?Q?/zIKnpGgAyOW0LAsQHTHUSjMNQu8FpPbVbpdGvlSp07HE+EIzvFOznjZrZD2?=
 =?us-ascii?Q?XEimaQW0Xt3QkyFWoCFTMC3X6ngYM7OIKtxOPTY8+TvroIr4sZhkc0C5/Dya?=
 =?us-ascii?Q?wx9KJjaR4JehjxPmeO3dA60PcbP5WvDpDgM2a1Yf828HNtu1hB15YCVXX0L7?=
 =?us-ascii?Q?pCAkhrQ/kXCBslDw66yi4yX5odyTdPvkV54rilzwj29w3BpdmgEhqC7OebVA?=
 =?us-ascii?Q?Eb6i4D4AeDwHL4ehWr1xByy/anSTYvVU2SOsxo/iakh+lONhgRPmsWDze1LH?=
 =?us-ascii?Q?sygbZJkTyqr9jI/Qddxcx4tokO+ll5WCMdDOPcfWkWyQ7PldfQdvbbwi6Pko?=
 =?us-ascii?Q?T+pku92QxCilOM4C0yTmeovQ4wf6T25ovmyUUfe1K5sRDdLc03QNSpJBGnqP?=
 =?us-ascii?Q?iygcLCNZo6t+c6wdXq6Q7uEOvlpeRHGDxY6VFejva2IUsjWXaI3Y4j3x7/W7?=
 =?us-ascii?Q?OY+Iy9vdaVzrsbtD7yDLaGqtyMaNcvkYuN6tKjFQYuYCEQexfXq4GXB2vNJH?=
 =?us-ascii?Q?+vrLyqQz5lYQYDTVRJZcKp4SEn2Cs9L9koysRdIYohAw02F4jEA7RadZeKcC?=
 =?us-ascii?Q?sTW92T/rNwB/qIqY7H60926C6iXly7zZoac2ZsMYYnKRhFZv3QQxhLj07M90?=
 =?us-ascii?Q?FHo0wmUiUf6HIWPAvRvweUtSIhO/0cFMDQfTETKsm08ozSIMGB7yGx07Pd2e?=
 =?us-ascii?Q?Lky+j/zG7GWZwQyPj3bqi68RoA6jZJyULUZnhdKpTFY4zMGSDuF4p5JyqR2Y?=
 =?us-ascii?Q?Sziqtz8JsY=3D?=
X-Microsoft-Antispam-Message-Info: ut4UTnj0+H0rGCwkciI2P95lU+zlimNPIJp54TvTQ9PD+By8hD0suc3Cyg+2EOOJzJL8clYNS70TeYi+1jwn46lalq2eNMOSrAHS9x7g6QASgejr3KVBBZQYFLDDimHV3fFxDa3mDMn8HqyDPz8LeFJvHEMADqhPNIEvNkOKh6ThayT+t4HsF88pxXuUChYAd3S9qCM+5RNxbYofKnMEpK9rSosN7X2CKakIiTaAF5H/GPSl6HDuEsGYesp/6X9UOdYAVxYM6CXwH53LpzJlYDfYPNU0m0NulBCIRDONfa/49JgqBmYg9sPz1tPurxkOP7l7TdfP75xianJUmL9zImmoaMknnprfqHktWxOY4sU=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;6:mJ3FHVn22tfg0fnU5klyWvPgZzrgMpCxBeaK46HyroYhjw3Y6DfS3Am6JERCSg5GODqi+9iAvrRK81JF9/1W6/U4ltmgkutmBoZOXUPrZYi0O8CYnhjUU3mtRNHvWCeaFtM1Rmg0S4QV2QVdsRkvAx73hJ+G263C7nkcQxhJQDCQLJn7I+Z1uS8sEiFAbSzdJnIu/RvkVlwPDkpgS1S7e5Icy8vg7UzTFsCeVQmKV66d4p7c2yQEvj2zsztO+qwxRA/q9KrRW6HWl2R9/P2xBRUIQ2FvjowzZSSOV9ttK3TqsAlQf/FNwHOZqyw1BPbAOUqHwoqpct6UvpbgGeLJ07e0VSkbtaiGnQHDMawt2ZVQWbJgRYD0WZeu8kM9FDOt/pxiZIummqrkWX7xl1DuPGVPdpHErKrIxXNE2wmGB5/vzTHuTuLYp/SBpq7mL/KAO/r84aRN1SZLl/idYPXV0g==;5:dEgjm+5Fz/+uiRShZUsEYgxkW1FQK+LvXUuesgfLlheSBP1aqLS1nXQHFqb9lKbd87Tsq/nyhYb9SmuzsjEOgfQKqVjGRcBHFGu+15hjfzJDJ0ROXMf5umCAVKemmS+t8ZNckTR+JZ6AezCZeQXCNM6iI9q9bXejO6NhwXqiWgo=;24:+gAWr8VTRTjlvG4SiUr+mK00tQ224z1ia9xPCOhqMPJ9DIHh7IDAiY39gwFp5hvpKdIrR8Uz8DBs+K1nI/+iP43dB/OCIKYI6ytR1oSAngs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1320;7:ZD/LgToH2B7kO2dp8I1/P4kYIeup4n0waX7HwezPcUyLEx6f4xI+p9/HeMsFrfz4WD0B+cxDH9tTlt769U8ObjH56K4Tw/DIFgFs2f5B7bCTl0jfzHkZ5CRLVtx39ebiBvlfaOCnz3rrOfkbbWKZsTM5UeyNUJfAxM0716tVOZtR68YfaheCxT6ZDsBzQatViMf0qd05QzLGl20rnVMa1YJRI/hxyi1oNez/IIo2XicYFeysfbaSKcK9K/daLefh
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 02:09:01.9822
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d698f8-49e3-4dac-fa3e-08d5dfc0ca34
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MX6 datasheet, the LDO_1P1's typical
programming operating range is 1.0V to 1.2V, and
the LDO_2P5's typical programming operating range
is 2.25V to 2.75V, correct LDO_1P1 and LDO_2P5's
regulator range settings for i.MX6 SoCs.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	Correct the regulator range according to datasheet's statement.
 arch/arm/boot/dts/imx6sl.dtsi | 8 ++++----
 arch/arm/boot/dts/imx6sx.dtsi | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 81f48116..c64bd90 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -524,8 +524,8 @@
 				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1375000>;
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x110>;
 					anatop-vol-bit-shift = <8>;
@@ -554,8 +554,8 @@
 				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
-					regulator-min-microvolt = <2100000>;
-					regulator-max-microvolt = <2850000>;
+					regulator-min-microvolt = <2250000>;
+					regulator-max-microvolt = <2750000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x130>;
 					anatop-vol-bit-shift = <8>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 7130ab8..596763c 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -592,8 +592,8 @@
 				regulator-1p1 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd1p1";
-					regulator-min-microvolt = <800000>;
-					regulator-max-microvolt = <1375000>;
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x110>;
 					anatop-vol-bit-shift = <8>;
@@ -622,8 +622,8 @@
 				regulator-2p5 {
 					compatible = "fsl,anatop-regulator";
 					regulator-name = "vdd2p5";
-					regulator-min-microvolt = <2100000>;
-					regulator-max-microvolt = <2875000>;
+					regulator-min-microvolt = <2250000>;
+					regulator-max-microvolt = <2750000>;
 					regulator-always-on;
 					anatop-reg-offset = <0x130>;
 					anatop-vol-bit-shift = <8>;
-- 
2.7.4

