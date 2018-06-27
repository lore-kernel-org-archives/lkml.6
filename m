Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF97C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840FC26970
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="w+efKK0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 840FC26970
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbeF0BfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:35:21 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:61148
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752049AbeF0BfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=istnHCKWn8BHiQomo8j+aPMmGIR8axgG2LB2lKsy8Po=;
 b=w+efKK0lPF+lOXl6JHC9w7Ex8zvjHx1bH4uaWo1XFUSFYffWKA/+/lIzv8MjvnC2bhrGCCcH0P/qXjIiPIOrstvx2wnAH65Nab0o88gS/0INdJfnf6YnQf9vq6Xn+jqSV4zWHlZinrJaxyGPlRt3tETGFfXbS/c/hf/K8UqFpqA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1324.eurprd04.prod.outlook.com (2a01:111:e400:588a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.24; Wed, 27 Jun
 2018 01:35:10 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: make pfuze switch always-on for imx platforms
Date:   Wed, 27 Jun 2018 09:30:55 +0800
Message-Id: <1530063055-25914-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0014.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::24) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9d91b43-27b0-4ed9-4dd3-08d5dbce3aaa
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:r47bf3I7vJ+LVL3R00NH4z9XHs2gdrjMYqB85Pp+6Kc+ULG+0m8yAr259hhJng+Y11U2fu/hqop96T9XVIDYP09L4huQit9zndKM9QJtRm1cMibAgN4uNUslqtjOZr5rB9TiWIrtHZ0pJjx+F0MYplYOF1/5tMdCQLEHzK7QGb/akgJh27fo5NzUTA7sitU/nc3hdmtonakF6wfRRdafAh1Z76YSFRtAEmo3zbJ8ibpxI2tUW/QJdHV6AmyGQnRq;25:/0X/RGbQxPGbAyRJP7fIfJdoCTVApGZFl2GPTgZhDq3TWaOfqHDL9JcM92Cv1o6qId3tI8EGHjWWhhkVp51lQgyVb4Pu5GLyNlXF1TNP4pDIDzO6SAQdpF3yJg8ejbZoRIAe4tRmIfz4EOPiWkNheuIEtG3J4Tfgzm7dpOaRQNiyoVYScOAcWsB5GpvkIV+oIR3eb8Ptod95NZu/BMyxRovy05EUvO70zPDRUKnO/EOfkoLp1R3DrKfaM9lTgiGMkzqwMGYn7ddKep3XAyiEh7Da0qSFY3d/7xRjy1cuaXow1496OgJgtslq06RLAhdZC9AJM/Tw5nKYGtguSE/spA==;31:/HaaInuux5RLfOvX0tahET0V5YjMIW2oICbfR5tS6vAWyOmmW5nQNztlE8CQD/NKWdrGcqI66wYyhWMWAcwvfQXVXOrM2qB7chhkNu/4a3jSkgEjz49IQR3C1CcP6DA4M+aFkBrLJfZWSAfO1zsdSUA9oU1u0wUeHSQStZENkOSu4UH3gJ5eUO5zyn+pOFiZvRqVZ0n7In7j+PIZq+i9AiE0jN+25EaUOMYuxEVVnK4=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:n/7gWd22ZJn72RX0miBy+39VSPL6MrnyfFofZqFy+2sqEwSHi7x1KnC3e5MtnR/6/Xz0KaLXSlbOrzpwPsJ1Ec29Lf2QRFRw2u06Y97QaJNK7fS9VR7S/MEPUOGLJoqw9W5ttu7cWhiO7x33gSVJxGyYFt92Nzz4+CtdH3WS8sZd/jc5OQFfXSdCIkZ15HtKFYSD0EuOvm1RELhPkQLBsVKB30S4lFhDdcECCKtfcnX3zYaQE2LENsfRetsdz6F0D1OVyCFFkJOHxW6zs87knKmZk9X/KUUQV5fNB8tsW/u5w/7vxj0K6wE6KGg/STdwsxY79lGHxcmx4qO5lgd5k7nfs4ZKl9Itzk/jMHRggJzKwAmXv1sT6zISXE5UR9YnAZ1q8AebX6FfJr+gFytxwU4xt73e2p2/B0OMEBonp2FclJjmfURlhm+v4PPB2NWgkgnciBfO7Ys1eroDIsOo/ywJRNfrBOjLtKIA5fwTUsKgo7fR9cYwBLNpvlrDE6uf;4:1zCdruTEic65+lyIFFsw61SkgQf38VZ7KOZTzJiZe3lZ5/pkCYYHVq9umtn48XOuwKiqL34X9ZF4HANpBw2zFgn4nspzGNuod7lIyhYR2eYGQFbsGgVeXHcJn+AohWvqTcfe6nTxbPMhQ3gOBYcDeaz2Rmt3plPiINhpbBAieySKTebWHd9Gj68jYBkh4uSVCxk8bU8ObIBlgEeYCo/y60hp3uYzihOWkFUzk2NHRzFlJeCdXCqSJNRom5p3ao2IRvxbZgEtsaVOUSmjWVf2AcpMtbjVgOYKg/QsyFCaZJsXXPVerQyzGi3j3q5SM7ZJ
X-Microsoft-Antispam-PRVS: <HE1PR04MB13242CD5B559B92626E1A274F5480@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(366004)(189003)(199004)(7736002)(478600001)(53936002)(105586002)(25786009)(50226002)(97736004)(106356001)(48376002)(4326008)(186003)(47776003)(36756003)(16526019)(66066001)(26005)(52116002)(50466002)(51416003)(6506007)(386003)(68736007)(16586007)(316002)(6486002)(6666003)(8676002)(5660300001)(486006)(6116002)(305945005)(956004)(2616005)(476003)(3846002)(86362001)(81166006)(8936002)(2906002)(6512007)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:B0bvXayDC6Q7P1Do12dNRyx5OLMYcVLYYRa1smjmg?=
 =?us-ascii?Q?teswtwBAH9LcYGu4H2KgtBo+qx0qsUoas4SKj8yrMB7Zft4rKt0fMC9jieGz?=
 =?us-ascii?Q?crOq/NZTudytzqXfzI6/Kv/K1SUMnUZiSVb5DSFaF1nR5ZS47iEMmzXmlM+f?=
 =?us-ascii?Q?N5NjLNSJRZpqRtBJsotD43oat8jzS9sG6kNoRjAdX0FJJEEi/GnCNxdUyDpz?=
 =?us-ascii?Q?XYtSlhEVK+cQ+qDl1A02RzAz9xFORfxY7sy/PENsTQHfgyhwhsSzqjQfGXJB?=
 =?us-ascii?Q?cDGN9U+oxCBL8KxEPgrwe598uAl2Td92IFpFZyKzsQZG2Jb4aUj5sesXbiiD?=
 =?us-ascii?Q?eeAmQY7Ario4k1JW2rfgvWJsokpdPYyAFHP9x4kwjKw/NEKhzoy/nl+B9sgu?=
 =?us-ascii?Q?zFrmNb71Mk3JrUkchn484lBvunEKH02ktxciK2uQ0RTct8l8FWQUqn5DKMqJ?=
 =?us-ascii?Q?pjQxf+eD6tplq0AY/9MC95L2yxvLc8fGQ+oJlniAdbNGqhihnFtQ+1u3dzJ9?=
 =?us-ascii?Q?DKVEzE0t3Lwc8D69AosKFArWzpDUxGaoWlTF2IdMO8wgDtJBSN/NXVVrEwdV?=
 =?us-ascii?Q?qDQISBaeNbcryTO9fm7x0jnmooYJL1a41yLj4+/52X7LS6sAG9TbUZM2zqDu?=
 =?us-ascii?Q?+f6YcazuI4d3xnQqYyHAH9TfRnTUKoxEqPpks0Wm3UuLd3B20Jw3L6Suq8WW?=
 =?us-ascii?Q?kDgo9vGIq5pIz0mY8B+/kk/p8RCHKbM4bXKnWIlnt70k5h3rMEGCjJ8055LG?=
 =?us-ascii?Q?DvwJGGS5981SE79N+/6LfwU1aYFfRXWnqYp4uQqlpYTJUKsF/xE6YbBo6pD1?=
 =?us-ascii?Q?4xx9NgkmjDeZBEnGeH+gPUcTaTOG5UWPBsudRDkYOzhmtfC9M6kiTgJbL3UL?=
 =?us-ascii?Q?N0xc3Zan+e35ozohJg0vF5ghz0ZbeL62AUylagRe9wAseuoSiFCl+P/tuLr/?=
 =?us-ascii?Q?C2/5tM+cM0pEJvf0xlnU9lFW3b0217d689xCG9f2yUXwH7JaCxpqiaj6feG8?=
 =?us-ascii?Q?3ue7ho9szBj5gGDrq9IGkcbAy5Yp6gu4wb2a/b0RgYtq3zt0eCl3CsYCKqJ4?=
 =?us-ascii?Q?0zyMKN0yMMMS//tUwCcv65d5BX21is3JHhwvXtQWQTNdvexvA=3D=3D?=
X-Microsoft-Antispam-Message-Info: ieKp05FnqjYzMVUrSYBXyHi1b+VFRfRy7M+ZQG9jmQ9RAmHsjodu63HvppY+D+lp6efMngsyKWAYX6DMHaRqkn3+fJ/HpZMYsR5QCn5YHxunmV9Zbxl1WlJoCQY+24yi4MSyG4De5f1NSApquHE6dk/LQYaqmN1iyDlYgjUxpwYV2rgF6GdaG6WZmmCHAuHDtfz7kOFr5iNh0bMAn+y2T/V4GDVAHQPylOeWzSVsVOjqM023ApQXdRuGQpwU/92LRWMzCp/qFrtoXwtsJb69XLJzMaew3GZbI9IPq7kF7gPvCiH2QPvSzjq04y7JWlw0Hlf2KeNavsKIu/W4JmlXTGitM7q07OxH2PBcgKTYwfw=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:6Md36zx6E6aqV6Dzwq1dezIbXq/zNRrNvr6JI18SJ6WaUmkzK/21hAxjGNsg3WdaqoutZlZyItGVCVeAdnPdKXP77IGrK/cp85EEdz/3ApTuoWJJeTX0WIDxDukP+wrucyNBjHpzsgo6nXgt1+iP3nxli87M/wBE2135/Jn4znwEPwYlc+3FakK4EXLkmb444rZYfYF6PgzRe+YL+UYmnk/AWS5TuBcOn5Y9378GWgz+ge4UVjtReY9qwZbPv2vOSbjenV3vEcomA7J1xfX8q8flwRUp36F8Pwy4Ih3qxHb0H3kBW8CHcWAQZweahAGMu8LY6gR5bkp0NXj0/yrTOrbEXiuRt+q3OXlyU780PIKZp+vEPM7XwjE2gaX2tpDdSC2hEpkvwIykD1zcJaDc0OELM8bTOi6YJHxpowW5LwL3zpGu6sX0efHiwCpeoo1mADp82VPpCe8yCH0MfG0ZjA==;5:QP3dwIfVT57fPGtlbpi1HGlIVxlPeui0+Z9U8/sHfONUW9UEg2dDT8s7mmgB5WfZhJXsSCydyml/l8DpbTgQferPy0Y5ESbIHkJLxeb4BwHvno2azYDu8kCRdkHM0QHhgXefvOnRssCl5+rLVSb5QUnlN4J/V/zV2kE/Cr29B3A=;24:tXTkvRtNMx5SozrnfilEJEGD1tMoKKYCsYtakS4a/NK+lRkIWqCWdd2p7j2PX9JmtoMExkrnNTTRLwEOnHBa51bXDqVtw3l/R5VJ/VvjRmM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:7CN5nSKTdAKAz1e90dBRDgNdq0cwan5tu821T1R+e1XiflUNSyzBaEZXoNSz3UMTV/tvXcNOXHBmYopv6LN9T+03+bj3REvbE+EEX6eR32crXUg9PpWENtK0tr9keKI2uPAptYv78M9n+nA9Uuu6O5qXp92bXuQdoyQSRAO4Ypk26JYVl24acyA9AOyrbFGzMvXZX7iKHUL0VmDxLVnplucIt04pMaCNmwJrsc/dVaEs5lWxiVmok1LIq3Ktix8O
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 01:35:10.3859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d91b43-27b0-4ed9-4dd3-08d5dbce3aaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5fe156f1cab4 ("regulator: pfuze100: add enable/disable
for switch") will cause those unreferenced switches being
turned off if "regulator-always-on" is NOT present, as
pfuze switches are normally used by critical modules which
must be always ON or shared by many peripherals which
do NOT implement power domain control, so just make sure
all switches always ON to avoid any system issue caused
by unexpectedly turning off switches.

Fixes: 5fe156f1cab4 ("regulator: pfuze100: add enable/disable for switch")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
changes since V1:
	improve the way of referencing commit, and add fix tag.
 arch/arm/boot/dts/imx6q-display5.dtsi  | 1 +
 arch/arm/boot/dts/imx6q-mccmon6.dts    | 1 +
 arch/arm/boot/dts/imx6q-novena.dts     | 1 +
 arch/arm/boot/dts/imx6q-pistachio.dts  | 1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 arch/arm/boot/dts/imx6sx-sdb-reva.dts  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
index 85232c7..33d266f 100644
--- a/arch/arm/boot/dts/imx6q-display5.dtsi
+++ b/arch/arm/boot/dts/imx6q-display5.dtsi
@@ -326,6 +326,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
index b7e9f38..e6429c5 100644
--- a/arch/arm/boot/dts/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
@@ -166,6 +166,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index fcd824d..0b3c651 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -341,6 +341,7 @@
 			reg_sw4: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			reg_swbst: swbst {
diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index a31e83c..6ea09f9 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -253,6 +253,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a1a6fb5..281cae5 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -268,6 +268,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 15744ad..6e46a19 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -341,6 +341,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
index e3533e7..9cc6ff2 100644
--- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
+++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
@@ -63,6 +63,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

