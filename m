Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A0CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D475E2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XrOI52rF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D475E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbeGROS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:18:27 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:46816
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731656AbeGROS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIlnYdrAadbsImO8aNFxxZXKRHpSvI9h7NqBSB5OMAs=;
 b=XrOI52rFm+sw5vNHzdJ6xTIZabYPAmZZOFf2xkJRHtvYS8Ef1ichNY8MtZXVImNB5d+ENfTGZjH4eeAYVwSJWwmcEdlkr3RB96JAL2b+L84jX4KwiWTfa7bGncR23dS/eufynWIQfTcluKOQNxhtiuPveeiSuTOU5vwg1jWmdHo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
Received: from b29396-OptiPlex-7040.ap.freescale.net (119.31.174.66) by
 DB7PR04MB4219.eurprd04.prod.outlook.com (2603:10a6:5:27::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.19; Wed, 18 Jul 2018 13:40:16 +0000
From:   Dong Aisheng <aisheng.dong@nxp.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        Anson.Huang@nxp.com, ping.bai@nxp.com, linux-imx@nxp.com,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V4 6/9] dt-bindings: clock: add imx7ulp clock binding doc
Date:   Wed, 18 Jul 2018 21:37:00 +0800
Message-Id: <1531921023-18497-7-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
References: <1531921023-18497-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0090.apcprd03.prod.outlook.com
 (2603:1096:203:72::30) To DB7PR04MB4219.eurprd04.prod.outlook.com
 (2603:10a6:5:27::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc0dee3c-8ca4-4314-bf3d-08d5ecb401ac
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4219;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;3:QWzjnRoOLEpVGKOnjCy9rQ3SVeYJaXfOIUkW/i7DxH9Rj4ymLzB8AdDQtscHdxRl4wjTzE+omezwgVS4MbM0T50EJw9EsGmJ6Q4trp/h91cuLb047MYXyE3+f3vrTfZjqG9FAkcEVGYKry0cBwZSrw0J1fS4k8bks6YmkGdlUHEvgjZ5YtCsL+VEz36DyvTaOwAgWKp7s98jujUS2U2heIr3s77fw+ZPM1d/sgzkbvtU4RpQ9zk3aklLtv9sVpDb;25:ECjMSXnClCoMDcEGdEiYqn5+smPSKn23siopRxS5DcpV6+ZX6X3KbKiu3L0XOwk82/rLaHQy7QqA626v89TAMhWgp5zBqQVCk7DejGFix8DTKRgAYHfM35UWS4W/jWXrEEoAZsKnvKk+KkRVVkHg+MT4GV1BtIasGpznaJCrFQSAHHR3qlPevU9/xibhgDdMut/EWAMBmAK+hdbacqX7ZlL/7ZaTd9YYckwhxpYqroBT4r/KmuD2xKzBYcW4mwbVG/aHLY39kivUqaxHZnSxE4dFeEIKH1YXQ907M73Pz0F1A42yj3yNLA5ZePKPPZLLjidm3wa65m/ffLYxAeN5Fw==;31:l012ZS4PKRViW8wwko4+Imj6SdPHO4OGgMI1PtEfYPxYOY6zbKCWEBYdeM0Vemy41xzGyF6GrfB+F2G3SWN0uJ/d04WLDZLvwMm1aGSkgHweIIe15w7pGlwuyGbbEJLELd2FeRISZcvguaPv3jhRDTEs8Owj1RBm0fH3fGM9yJbkpSyA2Sv4wOfCUqxU7Q/wt9z2sGUDrW2Yu6kzuTjExWPx57yJkc9jcyVbG3RBpNs=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4219:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;20:L6kUooirJknvKjTOO4JSsLlRepTUt5FNIe9z8kPnHnNHh0NTlGw0S6HKZkNAJ20zqZsi/ArOYPkW3YOmHzOJ04mXU9grETOke51nRVI/35NLXhKCz71RgdZjU5W8sREBNeRlwv6ZR7JOV8QiKpDtNyd9fp4GdvugceNty/vSLd6EMMRW9ZZk+QRsAaTE+YkrZF9sNZ/SS2BYl2vMCI1RrBZUqKUCjrIljaD0i0laqp4S8cCDOkmacCoUZAapHG+y9o3N+qRUdX/FejhrQ4IqRDr7PvOuJOYjUeD3U2ky/c4AP92PQag5jlokfKb6LJYX7FZcs8jjmRPAj0QaBfKMTQ3BFzFkJfsOAliaPel3+hid6ZpDMVqJ/qMaKpxlJqxdS24EaVkrV5thkFjVpL7ytsYQFezzjEP2imDlnGFWBpZR2iyOBuhxc7CzTnVUF0j3s/2E+9VQFHd8VLlQiXJT5JjEBxIAWe4vjkdn57EzjeXdGNs7+226msIgh647Pyzn;4:lfgnVT4/+CdjApQ5kBzH0cFTqJdLUwKnXrnc48T0Nd9ToW9frDVRiLroqeoF7vQn6JNBbLM5znm/eh7j0+uhswq9PHmXwlBK1TQ/mDn6to9WQo6G7Aba3q5AkydfVe/4mRFnQfgwhBBjsBV9A4cpPugZlPmzvvCbb8LjMqcRdaddHFPo2F0b4oheIpg6R1ehQq47dPFnninuPb7ULtUvTPGZCpOyLgYVTonfCvgm3Nv8FTn2/1VLyJYviUIvKabcDaA5Q8TC/tBdihsu+ARXho5wlPORuL+Ui9dU/LPcJC3Se1Lk3ThaNo+2mjBbeYnBRjjI4Zjwd8JYKJq5pOdUuN72dtwuMvZ3rBFQvKPT2WM=
X-Microsoft-Antispam-PRVS: <DB7PR04MB42198540F3271233615C9BE880530@DB7PR04MB4219.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4219;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4219;
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(366004)(189003)(199004)(54534003)(47776003)(486006)(2361001)(6116002)(3846002)(68736007)(76176011)(186003)(97736004)(50226002)(11346002)(476003)(956004)(2616005)(86362001)(446003)(36756003)(16586007)(25786009)(6666003)(81166006)(6916009)(54906003)(8936002)(105586002)(2351001)(7736002)(52116002)(81156014)(66066001)(51416003)(8676002)(305945005)(316002)(478600001)(4326008)(6486002)(106356001)(16526019)(26005)(48376002)(386003)(6506007)(5660300001)(2906002)(6512007)(50466002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4219;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4219;23:UXo+yvHOowsdSJ8L2IRXhv4s9KsS/yOZ4HDCBmqii?=
 =?us-ascii?Q?QvyETFDCNyE+itEqiN7pcov8HUfiETHrKHtpyxRTsLMC1MC4/l9CrBPtkq0m?=
 =?us-ascii?Q?s8msKBEEb/vsUHN6YmGSiKOCuArL0hFPPMEq6uhYfeKDzFA6t8itYF1Oqjcj?=
 =?us-ascii?Q?AmzdZ1YtNPN5Xvq6f8JjZwZi/JW/mRqibmZ/43JWktykBiJ39fnoOnjIVxzC?=
 =?us-ascii?Q?y313sspMNRYmC6fIaUhp+CLDPI6eN4SBwWlZzu31agOHq83cUG1YR+FaYKsu?=
 =?us-ascii?Q?lAWNeYAl0i15i+eJ2yQiMuYsgMlJEVu2AzrqAl5U1E69+9S9BPKwx3bUzgwi?=
 =?us-ascii?Q?mfydQ9uxZrkKSiH0VhQ+r92TC6POR+KRUwrplKb0XI5OJO2iXej+qF0uO1fg?=
 =?us-ascii?Q?D1F7ZUHZbJeMRPeDE76s/+/sJc1tmS0AZOVFHo2alrjH4kax0wE72yd7IF0a?=
 =?us-ascii?Q?nODbNP2tKEP5SHo62BRD2f55HR579a8IEVvnkEzh0QufLMt47jM4kkDeDu2K?=
 =?us-ascii?Q?dxn8P2swCsNezJihnsS/CBmD+IWSGMca/u/YFcpWQlmRLU+tdQOJfzPjgetN?=
 =?us-ascii?Q?fRhilMy1zS0BeYloCHMnS90vz4C2Fmxn/yGtIwtnS/jzt4DRPwXFi/Lt8bG1?=
 =?us-ascii?Q?JrTjXON4Wrcp7nj+r2KU0SiB80gj/RKkDjYK+YVpIu+Ma87HWmzBa7jNNRYr?=
 =?us-ascii?Q?ZdryooABVKm/7Q6IAiLqTY+9ZXbyyihOPmlQ8+D/CZUqcgu7X3lElw4JGFfY?=
 =?us-ascii?Q?+q1PsHRthc5ZHc7+pafhhRvEtE4oJUIeB2y/a7GkaJI0LAGWlBGb5rv3Rxy3?=
 =?us-ascii?Q?Unmoz3zGLm0Sa37mbd0oGp+g1pfh/k+McvhZWXSi5UbHQZGFtDEYk/zXpTAg?=
 =?us-ascii?Q?9yn92IoAN/ndbOC7Dm8lvNhY1RuBFqL8sLV1s9+10l5EMx+F0jaL/rqydLGU?=
 =?us-ascii?Q?4OZIoXNzRPhXP4vhKRJ5dmd9KTBZNPsazC7foRj/hzCh4B8+bGiNDcI+yL42?=
 =?us-ascii?Q?dAG2pvvklmbE9yllQHr/D2XCA49Qd31JVU2KXt64sUbBfotTpbZscxom1H73?=
 =?us-ascii?Q?63LObO0mPjsAOojPrHy4EO/s3CUK3xhSB5E9ljBBYGxzJGSU6gJKdE0ZQKSg?=
 =?us-ascii?Q?4S7yeU5yRVENrmQRMiAa9R0+B0gASn0Za3PB8qOgSEugyoYgsqUK7s1cLSUz?=
 =?us-ascii?Q?3x+8tDRwiewofyUg1KHA6HcqhRyaYhbXgaRBsWTAxLjRU4gJMYd25eO7etJE?=
 =?us-ascii?Q?2zmGXw2wGHb20d/dk0=3D?=
X-Microsoft-Antispam-Message-Info: fmgvNtp8iOS2Grfx/gku6Js9I0A/7LmYfJMuaER15DvdQmMSwrLjTyrnI+5QnhqufEvAH5JA0XPuVsJVQ3FCUszF0zCzUN7b11IkB5sAlTPZfTIfCAUNHPOR5ddldOF7gxMTThdO6V0Dkwv1sfO26UjA40U/qYzqxU9B0Aw+afaUHife0N4kf3PzvXgISrHPjaA+KdCeccgf1xvoCYFq9Z3IDjgcmxK962FUNSEmRrcbNob9dFSrCn/Wh8dfF9rvIsNflYHabng3Y/77Gr/s+/aFW5GL/6jt/y43LwulB4rVxgLf7HrmtgadjsvgctfxhTsJ+JM4PGp7BklyQLjy+u56cacncxx4DzHlRZTkj9A=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;6:Y4BAOGWrA29jAwHZR2DKis954Xq+fruc1yWTOO0GcR0qBXExUwxpozSenBZco0EE/yOMm0ozDPcTBTwtrZm7INESlZOHTxjOdumnm12hJaveMvfac4sX5Djypq5S6UncYC4moeIRwY9VU70PZ5a/OrCBSo0EbLSaOjk0o4h4YdnC0UnNLBWzO9NqXG9cZJvmDfrPGEPqJbFW2769jNr5TFln2LwAIPNMNjRZmARr5dckM0cqFUhzcZzEsuBw5Hhh+/qnZwXwE9AL0n0fH+5ZtSc/b+UVeT+SNiqxiEpWDmhmtM8Zn8JgLkAgInllPVB1lzCde5VwMlAzjARx9j3/Z5q+GHpRG93NoPwSt4GLRNsI/CTUYQK1pU8e6n4ArzaO1WiATKZ1iCpoG83ZHEoC46W7Ihw4qTX0b0Z30yWhI9uO/B6apbF6P/P2XrA4ygOBwEIhYfpdUmVzCHJQHOu83w==;5:G0Mrtxhr3dNstef9iG6i2ln92WbDVszYJpFLbE2kDxDy9GgYpmdjpTCRNkE5UgbwvGme8u97xsPIe+PuzowahMFN7A0lljJGGIsHQl6bIW5ixMevMR2AfuwdEQ+Rp9qqySZnPhu0G4KeGm/23+rGnjEsROI+XsfUFoko6KBFKHE=;24:1mwzQWgWmfMxMMTChprLee7FmBMuODKsjFG/qVV0axoyb+RWaJ9hjYQXimoppivdqFsI7VLVSmdoOmhc6WTuHGKcetsXs2BOfHzf8GfcvCM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4219;7:cjqNbJC1Si5bVKL9VFBRMO3DX+pU45P+RJWhLTKYmmrJBY+j8cyoCbNioiAnJ7/X0/dnk6Y9llZE9m+tEly5gyUKGy5kh3Yz4RtdKinfc/yr+wA2mdd8fudv0siI7uIiNW9x2e1XtvRHIk8MFzsCXdg9Nq9MFxFg6BCjAHYHX5eBW1c2nBYcyhaw70s+Y6uIXJZ68LC3F2NzWG9d8aJT4hfRN/o/lkZROjmqHA5nGuMMwc4opgDXDDxZNT8jgGVS
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 13:40:16.1502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0dee3c-8ca4-4314-bf3d-08d5ecb401ac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4219
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

Note IMX7ULP has two clock domains: M4 and A7. This binding doc
is only for A7 clock domain.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * make scg, pcc separate nodes according to Rob's suggestion
v2->v3:
 * no changes
v1->v2: no changes
---
 .../devicetree/bindings/clock/imx7ulp-clock.txt    |  87 ++++++++++++++++
 include/dt-bindings/clock/imx7ulp-clock.h          | 109 +++++++++++++++++++++
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 include/dt-bindings/clock/imx7ulp-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
new file mode 100644
index 0000000..2239383
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
@@ -0,0 +1,87 @@
+* Clock bindings for Freescale i.MX7ULP
+
+i.MX7ULP Clock functions are under joint control of the System
+Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
+modules, and Core Mode Controller (CMC)1 blocks
+
+The clocking scheme provides clear separation between M4 domain
+and A7 domain. Except for a few clock sources shared between two
+domains, such as the System Oscillator clock, the Slow IRC (SIRC),
+and and the Fast IRC clock (FIRCLK), clock sources and clock
+management are separated and contained within each domain.
+
+M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
+A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
+
+Note: this binding doc is only for A7 clock domain.
+
+System Clock Generation (SCG) modules:
+---------------------------------------------------------------------
+The System Clock Generation (SCG) is responsible for clock generation
+and distribution across this device. Functions performed by the SCG
+include: clock reference selection, generation of clock used to derive
+processor, system, peripheral bus and external memory interface clocks,
+source selection for peripheral clocks and control of power saving
+clock gating mode.
+
+Required properties:
+
+- compatible:	Should be "fsl,imx7ulp-scg1".
+- reg : 	Should contain registers location and length.
+- #clock-cells:	Should be <1>.
+- clocks:	Should contain the fixed input clocks.
+- clock-name:   Should contain the following clock names:"rosc", "sosc",
+		"sirc", "firc", "upll", "mpll".
+
+Peripheral Clock Control (PCC) modules:
+---------------------------------------------------------------------
+The Peripheral Clock Control (PCC) is responsible for clock selection,
+optional division and clock gating mode for peripherals in their
+respected power domain
+
+Required properties:
+- compatible:	Should be "fsl,imx7ulp-pcc2" or "fsl,imx7ulp-pcc3".
+- reg : 	Should contain registers location and length.
+- #clock-cells:	Should be <1>.
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+See include/dt-bindings/clock/imx7ulp-clock.h
+for the full list of i.MX7ULP clock IDs of each module.
+
+Examples:
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+
+scg1: scg1@403e0000 {
+	compatible = "fsl,imx7ulp-scg1;
+	reg = <0x403e0000 0x10000>;
+	clocks = <&rosc>, <&sosc>, <&sirc>,
+		 <&firc>, <&upll>, <&mpll>;
+	clock-names = "rosc", "sosc", "sirc",
+		      "firc", "upll", "mpll";
+	#clock-cells = <1>;
+};
+
+pcc2: pcc2@403f0000 {
+	compatible = "fsl,imx7ulp-pcc2";
+	reg = <0x403f0000 0x10000>;
+	#clock-cells = <1>;
+};
+
+pcc3: pcc3@40b30000 {
+	compatible = "fsl,imx7ulp-pcc3";
+	reg = <0x40b30000 0x10000>;
+	#clock-cells = <1>;
+};
+
+usdhc1: usdhc@40380000 {
+	compatible = "fsl,imx7ulp-usdhc";
+	reg = <0x40380000 0x10000>;
+	interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&scg1 IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&scg1 IMX7ULP_CLK_NIC1_DIV>,
+		 <&pcc2 IMX7ULP_CLK_USDHC1>;
+	clock-names ="ipg", "ahb", "per";
+	bus-width = <4>;
+};
diff --git a/include/dt-bindings/clock/imx7ulp-clock.h b/include/dt-bindings/clock/imx7ulp-clock.h
new file mode 100644
index 0000000..008c5ee
--- /dev/null
+++ b/include/dt-bindings/clock/imx7ulp-clock.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX7ULP_H
+#define __DT_BINDINGS_CLOCK_IMX7ULP_H
+
+/* SCG1 */
+
+#define IMX7ULP_CLK_DUMMY		0
+#define IMX7ULP_CLK_ROSC		1
+#define IMX7ULP_CLK_SOSC		2
+#define IMX7ULP_CLK_FIRC		3
+#define IMX7ULP_CLK_SPLL_PRE_SEL	4
+#define IMX7ULP_CLK_SPLL_PRE_DIV	5
+#define IMX7ULP_CLK_SPLL		6
+#define IMX7ULP_CLK_SPLL_POST_DIV1	7
+#define IMX7ULP_CLK_SPLL_POST_DIV2	8
+#define IMX7ULP_CLK_SPLL_PFD0		9
+#define IMX7ULP_CLK_SPLL_PFD1		10
+#define IMX7ULP_CLK_SPLL_PFD2		11
+#define IMX7ULP_CLK_SPLL_PFD3		12
+#define IMX7ULP_CLK_SPLL_PFD_SEL	13
+#define IMX7ULP_CLK_SPLL_SEL		14
+#define IMX7ULP_CLK_APLL_PRE_SEL	15
+#define IMX7ULP_CLK_APLL_PRE_DIV	16
+#define IMX7ULP_CLK_APLL		17
+#define IMX7ULP_CLK_APLL_POST_DIV1	18
+#define IMX7ULP_CLK_APLL_POST_DIV2	19
+#define IMX7ULP_CLK_APLL_PFD0		20
+#define IMX7ULP_CLK_APLL_PFD1		21
+#define IMX7ULP_CLK_APLL_PFD2		22
+#define IMX7ULP_CLK_APLL_PFD3		23
+#define IMX7ULP_CLK_APLL_PFD_SEL	24
+#define IMX7ULP_CLK_APLL_SEL		25
+#define IMX7ULP_CLK_UPLL		26
+#define IMX7ULP_CLK_SYS_SEL		27
+#define IMX7ULP_CLK_CORE_DIV		28
+#define IMX7ULP_CLK_BUS_DIV		29
+#define IMX7ULP_CLK_PLAT_DIV		30
+#define IMX7ULP_CLK_DDR_SEL		31
+#define IMX7ULP_CLK_DDR_DIV		32
+#define IMX7ULP_CLK_NIC_SEL		33
+#define IMX7ULP_CLK_NIC0_DIV		34
+#define IMX7ULP_CLK_GPU_DIV		35
+#define IMX7ULP_CLK_NIC1_DIV		36
+#define IMX7ULP_CLK_NIC1_BUS_DIV	37
+#define IMX7ULP_CLK_NIC1_EXT_DIV	38
+#define IMX7ULP_CLK_MIPI_PLL		39
+#define IMX7ULP_CLK_SIRC		40
+#define IMX7ULP_CLK_SOSC_BUS_CLK	41
+#define IMX7ULP_CLK_FIRC_BUS_CLK	42
+#define IMX7ULP_CLK_SPLL_BUS_CLK	43
+
+#define IMX7ULP_CLK_SCG1_END		44
+
+/* PCC2 */
+#define IMX7ULP_CLK_DMA1		0
+#define IMX7ULP_CLK_RGPIO2P1		1
+#define IMX7ULP_CLK_FLEXBUS		2
+#define IMX7ULP_CLK_SEMA42_1		3
+#define IMX7ULP_CLK_DMA_MUX1		4
+#define IMX7ULP_CLK_SNVS		5
+#define IMX7ULP_CLK_CAAM		6
+#define IMX7ULP_CLK_LPTPM4		7
+#define IMX7ULP_CLK_LPTPM5		8
+#define IMX7ULP_CLK_LPIT1		9
+#define IMX7ULP_CLK_LPSPI2		10
+#define IMX7ULP_CLK_LPSPI3		11
+#define IMX7ULP_CLK_LPI2C4		12
+#define IMX7ULP_CLK_LPI2C5		13
+#define IMX7ULP_CLK_LPUART4		14
+#define IMX7ULP_CLK_LPUART5		15
+#define IMX7ULP_CLK_FLEXIO1		16
+#define IMX7ULP_CLK_USB0		17
+#define IMX7ULP_CLK_USB1		18
+#define IMX7ULP_CLK_USB_PHY		19
+#define IMX7ULP_CLK_USB_PL301		20
+#define IMX7ULP_CLK_USDHC0		21
+#define IMX7ULP_CLK_USDHC1		22
+#define IMX7ULP_CLK_WDG1		23
+#define IMX7ULP_CLK_WDG2		24
+
+#define IMX7ULP_CLK_PCC2_END		25
+
+/* PCC3 */
+#define IMX7ULP_CLK_LPTPM6		0
+#define IMX7ULP_CLK_LPTPM7		1
+#define IMX7ULP_CLK_LPI2C6		2
+#define IMX7ULP_CLK_LPI2C7		3
+#define IMX7ULP_CLK_LPUART6		4
+#define IMX7ULP_CLK_LPUART7		5
+#define IMX7ULP_CLK_VIU			6
+#define IMX7ULP_CLK_DSI			7
+#define IMX7ULP_CLK_LCDIF		8
+#define IMX7ULP_CLK_MMDC		9
+#define IMX7ULP_CLK_PCTLC		10
+#define IMX7ULP_CLK_PCTLD		11
+#define IMX7ULP_CLK_PCTLE		12
+#define IMX7ULP_CLK_PCTLF		13
+#define IMX7ULP_CLK_GPU3D		14
+#define IMX7ULP_CLK_GPU2D		15
+
+#define IMX7ULP_CLK_PCC3_END		16
+
+#endif /* __DT_BINDINGS_CLOCK_IMX7ULP_H */
-- 
2.7.4

