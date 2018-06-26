Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E34C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8239626537
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gaPPiLKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8239626537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751549AbeFZGMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:12:24 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:32544
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750942AbeFZGMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8wdoikmFGrlz+XHnSCekSWMpjmyijPlJuyl4SRklvI=;
 b=gaPPiLKq95YRuFZZyAaJUfLeLcs7CKTSlX61gg83COm2tHDyJr6WkGGgLCA596+1xLUqahE+6pCXB2jDq3kAp8kkrEiptm0/5BHMoNheQjtOGgzJhyydpWzo+v00a39jzXWJ2t1K6Ajv0z+pMNpUOPQVHCTmmXA0nDoDx1XCFWE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1325.eurprd04.prod.outlook.com (2a01:111:e400:5187::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.884.23; Tue, 26 Jun
 2018 06:12:13 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: make pfuze switch always-on for imx platforms
Date:   Tue, 26 Jun 2018 14:08:03 +0800
Message-Id: <1529993283-32396-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::21) To VI1PR04MB1325.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8392863-8078-405c-fd85-08d5db2bc436
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1325;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;3:noUy1VZzITTpxZ/n7ZMbEzcMek7ae3STkk2PK1LqoPEma3io9TjxsiE9c9ik6Gk4B26lDlnlxMEPh0Ord2aKpoo8EQ2dX69qXRL2JGqKu3yEJnTRAT3FApdG/r94BeDNWHNDvGwZtCXlOm14HkQhrcvw7EOd4t4XOF9MSoXsqI8pOLqU53xHLA1wUUM3Hy7JXEI5nhuo8dyO29YM+Q7hqPpcL7AyuedzJ4CqHJdy60iJnpeD+eqqbNeT+twr5cLz;25:M8XRD/EMIaAgnNJk2Uwd9fM1iWmw2plgju/9L8TmNLYtc8AiDOz8lMUmfhAsw/cS+8YYSzF50aJQTi9+RbR4+M9BJKErUffpIDgrZrTuK12Sz9VgtG2lOU96RVsb3SuMHfmYyOqfnrlmxQoCp6fTmRyRRzgJuF5+o9rjgj5bW/rdXVHJUssl5uhBdf4nh7ESzXGJmp1eXWJSzs9j9RexRS29/qXeae1HpjbxwrK5em4zlVaSlbXu0FgSm4hm1Y6wzGO393ijJP0qPFXk63BUxEtfZ8R6BqyyIzLMiZSmZDyqr1iWlzP2WPUPs+gJfuzU/Cl2Dnld/kDTk5ma61XSZw==;31:k6DSz3maWYkmpt2PNkxeRamqco2L2CQ7LEKGJhTowoJ9/OeQUGYHz3hgvDI8ATDjl+prehDjGy8LL35+mhLIx3XbDDDPlwzfY4FkCicwfuZy/dzxdXqsjtDaXGgl6sZkwMglW+u6sDl8hDSs2S3Yd/GbjlN3AY37BhmwukfKhiwUlFUz0ZUG/hP72+RGxHdmJ67E26J6oTiO4QpZ8H8INWjsjuXTvHf5kWg2Jn0acds=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1325:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;20:jTGWKTsLij0Yg7LOQ4pkTOfMouu8nzqhku6K4MR2FgCQW+GRdX1USuYn856FwmAc8fXBPqPZnoNuz3nNn57dIQT5Ii/hoQ7wBmQ5gzj1Amm0ZamFTvFPxYcWYTv7rLf16twzlYA9LG9Gfy9Kzc9mNvXFfOVuTmGNr7Y1H56d4+AW2lJYvXMFisuMw75P6X5aYX7bBicX4Kn2kLr9I8YzMBTaHV/57WZBT7FhPQXmylwJTjgc9W/v8NoK/nkukOHTfgl3LfPbsNLN3Ip/4op1W0OqXG4EwUUhcaVOQCUE5i7TJm/i+10Ldmrm73IqKjgeA3U4/WQwj1iSDOVywUoyddOrl6fm7xeiZBQuunqXoTkp7MJLhnE6NiFDmcxkU7MTWUz9Ahyi6vwCKWGjyKmMWvufG1fiQLuYvxtX5vWIfWiqndKQ348bQB5imFs/7bOdQaLHjzMugbPMOzHe/tnSqVvGmxqtnyZax7YYd1XwOlXjZUUGdw9pLsTnlEvLNnNN;4:sZu69wluK4l2TfySLBQ2Zr5Tgo2doE6MlS+/QkoFCck09YIRsaU0SS2eVILmnVvoh/iohqVrIdCFiW4WkTsivG4Kj2zSew6wO31jY92hqRv95RB2naPghMkU5XSYJdxhlFzqkajFhBzjnAq0C8kk9QztzX6hNAoctfuG/V9EDoNB+T77h/I5/XXdjL7SCVYbthswaoJu6YlEwX0cy7K5YoureXpgCfoVx62QZh7ptRlyVjgx/7eWGr6e7AduIkdSrXraFsJjeowd6A0r8GAfFDuKkc9rI5Ei6BuxCVwU/ERxCyxZ3iJ1x4b1LmOEwEKa
X-Microsoft-Antispam-PRVS: <VI1PR04MB1325A34178DB5170F3D160CCF5490@VI1PR04MB1325.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1325;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1325;
X-Forefront-PRVS: 071518EF63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(346002)(39860400002)(396003)(199004)(189003)(97736004)(36756003)(51416003)(2906002)(53936002)(26005)(8936002)(6486002)(6116002)(50226002)(106356001)(16526019)(3846002)(105586002)(52116002)(1857600001)(5660300001)(8676002)(16586007)(47776003)(316002)(186003)(386003)(50466002)(478600001)(7736002)(48376002)(486006)(6506007)(86362001)(476003)(2616005)(81166006)(4326008)(956004)(25786009)(68736007)(81156014)(6666003)(305945005)(6512007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1325;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1325;23:EHMKXDwRzbuOafiOMg/DojGk2TN9m0TCDXp7Zfkfj?=
 =?us-ascii?Q?XJ6CpXWOerltd6d2JOf3vaRpDPcVJxQuGKrREYwAdZeWM5j5idxxd24QckFL?=
 =?us-ascii?Q?lfb+5yhuyr+B6ld/D0x4AduRRs83xCSAFJ5idBVqhWVp0BvNgsg62O2pJ8Nk?=
 =?us-ascii?Q?QMeJnreat6u8XlzGIVXC2jb7VAFS2eJkAvz4nckW6wjKRqIk2RE7hMjNphTJ?=
 =?us-ascii?Q?ztRuqkoCk6aM1BguIHGfjx2zZfLMFl0XZvrra1xiWHwGOdIXqPskDy2LkIbq?=
 =?us-ascii?Q?ZPBS+XUPJfhMpq/KA2EzVnSUY7ud8tyMYWU6TkEEm0gpMoio83woswGk+Du4?=
 =?us-ascii?Q?f/dna118wv+pJhNHQUtX4wzEOw5T4XaI+C/KnMSLAXcQTK6hE4hoCKF68HCM?=
 =?us-ascii?Q?BHNIn9Oq4OpLXsNpyv7Lme+d/g79Nz9Lf15oov1tMtylfV4JvwYjiwQVyHsH?=
 =?us-ascii?Q?vyCHXET5XmpYz0F5ZLS1eAcCHlxZv+3w1cHZLDTCo55BNshaOOBy0C1ptzZt?=
 =?us-ascii?Q?eSr0pPV7mleUhMm6iNK32icPhe6iPURKlF3abtrgArOJX6Gfvsgn0Tvd18n6?=
 =?us-ascii?Q?Sojhu1vHvvuBSmKaUYjFUnA3TZI1/ww8InQNppxp0lD1yzhPmG9RNShaqA3i?=
 =?us-ascii?Q?YPiXKerKwIbFSePKgMYPhT8hCbQeF6MBxzvAXgupWNI5+UuqRMbg6xJ+Sk5u?=
 =?us-ascii?Q?AUzT3qE9y7xZxR4QCktGmWD/RGfihi7EIY9hqw8DqLR/7SpqbnK1DCPnxq74?=
 =?us-ascii?Q?HUsFYE0ipgAmFy61fx+7YJ7LCI7/P+P9e+6HnOV+YXKDtGuf8xvTjRdFrpis?=
 =?us-ascii?Q?MfHHi1de+n15HSQ+tDFNezApO72RZ4HY5MC1DypVJSV+WbIIEk5nYNMExlA8?=
 =?us-ascii?Q?D8FMKaTCfhPr6Amsc+ZUEF8HUiJ2+crKILksEpdbkx1qC/rqHBQzfESsNYUP?=
 =?us-ascii?Q?vnCe55j3T8lA+yyCcJv5DUw2n3SayXESLqVV0bZ0QVb+ty9ayYsCv2f/Y33B?=
 =?us-ascii?Q?uwYONss6D/4Dhg15QDvPhPlZ5By9GdsrG7Dyvc9T2oCoMSY5psnH2zraTha+?=
 =?us-ascii?Q?20aW475gkKxsNNvMiya9KqpXCbWiEhm5ji08GX51M1VvhGwnbXKWmbi2sRVB?=
 =?us-ascii?Q?L+Ay/EU0S0=3D?=
X-Microsoft-Antispam-Message-Info: TbO2n9WevQyycrpaM+Hz759ZuUVvv+Dxwe6ipntacPcH7OWTQSipKk4IEAhZVkWkUC/Wscl1zeVb6BxkkcOS/T4zLm6K4N13+w1D8Jj4TEaEqDpm7mNzSQ/iWnTPOuif0YM6IqHPSodwp2acCdHJnNLVfrdFnnTOQMrQLeGDk9Ay8ZILPYWibfS6MI8TYBxMmq0cWNVqSQ7GHUDyOZK9rl0THqVS1uLI8JvWNnPk7taCOYN5IRyE8CrbGvbMWxlzq15OaZZqHzzNH4SvZD64FKkU8OaX9s2aoWf8diNv2jas8nE3MvVyZm9iiWwXH4/DR3sQpEXnEUWEuD3GxY7Wfd3jV5WGpkKmFqmMdLCYvp4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;6:IPO7ev2Q47Z06YCJFVAl7leBdl/PgNd4IXNbd0n9D6gU6uIudAA6G0EjEbEv3eSrcDGYWB9YdrWxo720xoV0o4tYKfKztIu70h4nWZjwOT0IgB2oFcGzooUfOy5ZUlepDb9SxqudiU0LN7MwJ76z2SwZTiVEwWJmQXsArZD3maNQofr2MuAvlF8nJKVcCQatqHiwrTMGFujesIPUfi6ygLMrUyPChDxQgV2guHj/xI+ILUaqun0GcIHxobzgXE0+07dTdZETvngzwmW3ZZ1lJslNmsjZ9yIm9PUZBAd3ZRQU60zrlgk3/Yo1XPOMUf5oU8atIJ39/jYcDrYVIwtzbKjvz+m1dK5HS3kEThS361xZ+4+8Wh9zQhT03ipfb4mRb7v8JmbjQ4iIHo31c4pWBa6v/tq1sJczvCw1t+slQtXSwFd0zwUgVeoUH3gUwCIHM+BVCVTeUb2u1UIWmPDPjg==;5:tElgn5q6zQaWJqCcJTL7efFsGlZtwSDq01IBJB3TTZ29i0d5tNNPJaZKWfbRSBH0ROX9yp3dXWfTLs4GnCIJlxfNz90qCssOI0Lfe1+agJe0triaukMzFZ362X4aWwStMFfQWvuJKdzWO3NFNePL/u7x841djNJzXclWpMFonfI=;24:YdfRWJxERnOsvPZQC0lNwBw5Yl1ITRaIRqGjTjG4ZCAJfaHn0Ne9gvMSVIuS0c4+H57DogiFSHQyJNVC80Kae78A+9Kbpob7eDWVt04X75A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1325;7:66+8gw9ZRco2ckAqGLCDbOPSSAGm0CpK1VQ3LwTdwXbhGd5/isOZcpc2L3n/70esdApk/5O3zLIJ/dKqG8yH0HiQRQ0xIm99yWWb2U+QNw1JBlUuRslqBv4uvl75ljKiTgSCcSVGnI4yXKUU0VsJEeU7e+8UXIllEyEi3HxWVfAxZdEFRC7tYEJ5jHewMct6NPRAPhclgMw5dj4mJKzOKHx0SnNnBOsYPnFQIcjpW/yLAxJvSskqogYC89md1oP/
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2018 06:12:13.4493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8392863-8078-405c-fd85-08d5db2bc436
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit (5fe156f regulator: pfuze100: add enable/disable
for switch) will cause those unreferenced switches being
turned off if "regulator-always-on" is NOT present, as
pfuze switches are normally used by critical modules which
must be always ON or shared by many peripherals which
do NOT implement power domain control, so just make sure
all switches always ON to avoid any system issue caused
by unexpectedly turning off switches.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
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

