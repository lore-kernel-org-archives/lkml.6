Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46767C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1FD20874
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cAI853HA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1FD20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeIXRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:12:27 -0400
Received: from mail-eopbgr50070.outbound.protection.outlook.com ([40.107.5.70]:64635
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbeIXRM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkzLnxln/eM1dgawK1A1Aqswt8x5zMffupoLOmJN2Gc=;
 b=cAI853HAsrbm79qDJ0WvtRpXANHdAc34idBIvp7q9OH49xs2NuIqh2zillL1PX//84bUkJHoAGYmWbmfMqTwT5Zq3kDptd4UkM59o52eUGNSVaXt6k4AF/NDhFVSPqetQ/J5PHjdyIYfFxX6TVOLLiami0BAhGDFyh4EYQPoKGE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Mon, 24 Sep
 2018 10:40:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Mon, 24 Sep 2018 13:39:53 +0300
Message-Id: <1537785597-26499-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To VI1PR04MB1616.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af3618b3-5bfa-41e5-74f0-08d6220a2c80
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:dZ3ksnft/I8Qiz1StADLBRdU56mv3dYWPZu0z4ae5ijP8JYxoeGRx8hEoc61jFYnJHmeERWNTCXaq1tWJWUq0RywSZKVnAWw7fsuLiHFD62T2E2OYYAvHApKp1TvMy4mDKNzghZ8I13ohBegLMMo/lkXz6lAzRcOk3TM3k4nbVsNwLWgI7mJIeTeM2oOSC8HbaVq3TQpjVgoe6FHZPPFDvuGOle9ohkL2hZnVyaN6dtc3W+FaKvQs5dN4wAAzzC7;25:jDvPwn2FKactmfGPs4YIoFHXsojsqOduRkAqRc+qTiPHIjvCZJW4+wrzLjSq7pYXLMqsHOy91DiBjAuNm8Cxv/Xui5HvdqFxFWP44E3I6k2+ugIYEjkal9X4mr37NQBt1N9/XAjZ1jhjoG1eTNngJ1LjA6nn6zRam1UaZ9StwTaP1qIIEEDER/mk/nUD8RLqzJ3GsS/OThY/anDCt3EJwI0sjv5RYMwq3TD0NH0xwaqcqtdNZWhHP18ks7PZziYGDpiqFLgUl395g6cmpTMyAjQr2SmT7f+zjVk2X/DwmL7q4OsNVVHyTdEFqAv6hmeW196UeKzRqk8zwpJuxvpQ30jJ+hEAeoLo117p8sozhXQ=;31:Ck9g75tJ79Imh4b1uaWNQDbMjWdwBOErirJhz9S0mWqpCpfeQ+5c2JFgYtC0qiqBDN+ePC4grgFFuMntBgoO9bAnICX7LlW4J3yn0P+IGtepQmVZF+HAn2weff0qLiK2UmzD/Z8ZWms5DTH8ZmuX5Lg/CB5kYTHD62oucloQGA+C63jCa2Cm+M7r9wRQbsTvtcyWqzYYGdNHFdbsBy5G1AWg/rKeJh41PYMab6DEslA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:JERKoJpTS4K/G9EptsJb+n3csjXWPoPbIYk+WtsLYFW6Q5NH67JfsEUb7ZT7X3QVSKQ6TQ6yyXLAhyqLfbIxGvs6V3NdyMTWCpaAc+yvA5X2hZg2rYwjQt8c6zcJoa1NsFqNyCyPf71/OZv0WeB+UgjvthEbyMdwXnuvBprfgX6ADf56lOKB7gwqrO86qw+7x5sLAwDBhX0pn3NSznFt6iagVz349ZBk/RuRzvsTOKzyzzYZxSnawTve75yQA+/7ZOywr5Ynzql9G/qkVOTk3qOenLZPrOi6usvX6uRsLVXkrHs5BdUyP1jfD7dUr3YD5j8pOcWwGCUkj9qlHqwfZVy/N99BpDzwfH2Cj/DAnCjS7nDe0aJ7tqZoAlTWIdkh7puAxZXeVAELm3kCTWXSHVIR86xw18+Ib/rcofGG3c06jxtLIRfAOyT26wSepKyV7p7dUZu5Dr5lDQHbPEUQrcM/W78Uo0q3FGyfWqkr243ENdnLunI1R3JocsV/8MhL;4:XamlSPTVXRYQIBls24BaZ2Jo1XdUDCNowKMraAHkCt77hAj6XrSLsTH68i/n3CnoTduRI6WRmoTeC57L4T2kWw5PlNYqrDr8M83haxogcUJonz/4DKmucaEB7CwO58BFpTiXjafdXyeNSTTPVRvj2BdIE0gUcoANdQDhZnTNoGW9KoTTGLepkCHC1RGnxnrmHdifShkn8m2hkTLsdqC+iKjKsmAVtTFwpy1iStuwMRh90o80TLpBb2r/fFdXX8C+ZIHX5pEL4NQDWi0BZPoX/k8QErTuX/PGUZ5mx3bYcNhJvgDYJmZ0+AY2BpiGPqnX
X-Microsoft-Antispam-PRVS: <VI1PR04MB1616E8DD068D4CD3FBC3FDF7F6170@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(52116002)(51416003)(48376002)(50466002)(36756003)(76176011)(53936002)(6506007)(478600001)(44832011)(4326008)(6486002)(6512007)(25786009)(26005)(186003)(16526019)(386003)(11346002)(446003)(486006)(476003)(2616005)(956004)(8936002)(50226002)(2906002)(68736007)(81156014)(7416002)(81166006)(8676002)(47776003)(66066001)(105586002)(6116002)(3846002)(305945005)(106356001)(97736004)(5660300001)(39060400002)(110136005)(6666003)(54906003)(316002)(86362001)(16586007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:wSlEIm6+yhzMtuBI4Lcv+0eEJt0pnPEiljjXd+aco?=
 =?us-ascii?Q?2WldA+UtvXUC8jiIpHphNy6Zja5lOzucjrlX/FK6go6TYa/ax3LJsCULEb8m?=
 =?us-ascii?Q?RAAqpJtSXv++dj/X0TzsGJzAJh50QP64Wkg5zeQPEgSRJQgPJ0BwB7Vtyqcu?=
 =?us-ascii?Q?j92DNKGwAWec4vZcOEDtMM4IrW5MK5Qei4BsjA2I8G88QR6qpcknJD8XN2CY?=
 =?us-ascii?Q?iLqviDoqfbng/2WRlXycbkL0w4uN8vyLxS11jpYgWUd/jnZoI8IBI11bQdhU?=
 =?us-ascii?Q?Z+qjmtKM/dXKiWGyRJ1EVRxp8ifgKomFanys8TCtbQpxfy0r1shZNJ7AcqvX?=
 =?us-ascii?Q?U3Qjgna/nOF2nl3T8s1+e1kFUmx4EmuqRrRaIxCT29wv+HwwhWteH6HhIrtF?=
 =?us-ascii?Q?I6orHHR5QCQ1SNY/1Wj3XsDTqOhnkx2zm4TV1lXuwGFsDLpvak6eplwcK6EI?=
 =?us-ascii?Q?whBGookZ4DRvYSNzX3PH41EopqTjBZXIrk7CdEXtBXEKQTxjN7Hw7ajZIF+c?=
 =?us-ascii?Q?EQhINm3RsYg7JIGphyAyBe0q2lk3LJxmq4qytKpCSUfgsbiqxUuwxbLwBR7p?=
 =?us-ascii?Q?PlKqA+dJYFXcmFYAI+dOBp2piHyHUa+J4kKvys14sphsls6ue0gh8+icWmZn?=
 =?us-ascii?Q?N+RnLVnb4Rfutk8ovPEff3jg57ij2RUzEd3kyTOd6Ucarn7c/k4rHIzla0ZF?=
 =?us-ascii?Q?Pq6eCrkQ0C+W/xnBsLIwyHXdqK6Ap5ck3QGllw7Kpcr2ACdm229JR9uyw/Ti?=
 =?us-ascii?Q?Z5pxDS1U7tsFJ5y9+9laMrWJHikOSHvWIRUZNN663lCKpwTUi3I1jY63D0ym?=
 =?us-ascii?Q?IDoRmur7HaHM83mfVXDmivpciGov7Zg/9FelNj+pmbMHs36az3wPRRWQYWks?=
 =?us-ascii?Q?zO4pPyvT48bTDIMJBdkSVStWL1WsEetC2AiU7BF3fBfQZ/+usrEgmMveCbgg?=
 =?us-ascii?Q?faHVJF16zmH/4obPlRGcGbshvcj2HEQnbE29ll0otE7hq7MxederYPJXb7D9?=
 =?us-ascii?Q?vkvdkbffpHTOZtct4hoOCM2ABjghFJMP2DNfKCngJWSuTzEVL0AiRo06IyKu?=
 =?us-ascii?Q?StbmtUkLIb64v9GghaStx2dmqICOPWw5c53L8R5E6NS/TFUAI4SvDrcSKtWF?=
 =?us-ascii?Q?qzOIjuQeSKiEN3tqiDW+FwgkdcasuKMT/Jnm1SpyaMSTzXwWYopSkW/GDf42?=
 =?us-ascii?Q?VajgWG3H+ghIT8KgzgNciM0WwjxZoBsMiJLrYh2umpoqta7Q/o5mVVklSjV3?=
 =?us-ascii?Q?N+kE55Y/D+gXYr0L9Y=3D?=
X-Microsoft-Antispam-Message-Info: 6qltc2PKzVCEdRTCkVqRhDT0Y/ruKqnEUnsjAKv1AGYqDb6MfUZFZEsfEGkpndAdREFJoO/orABmSz9SZMkMwfcKlSl9dybfd0GRqD3ObdJieezsfr6vdYGpIE12ASz/sqJXaw/HvZ4kYLvrZI3qoIBzEUzI1Ee+Shwac7gTuUn7tCF88MOwM2jdfNxWMp9fI6lC8sPThIqVqhefuXjO+Ofp5mU0UOzvDZsnuBvDy6mVKk3TyELTIZByAAd3lE+2a5g3dmO6+Fp2jEYuyvXkp0bhkBvxdT4qv3WDxN2tzZBKjZpD+wj7+6RAECJx8OrKZjzwIukjLg+VULGvlxECB5z3AUkuQ5FdTESSn33YADg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:V5XRSjStqxWxJ4ehsywm6FPVitmJdZrk+C0IlMErnYc6dDLeZAdoq6Kxh13wyZSwJkGMcPv8+TOHoIFRKDEQt3WCyBWaGYC2Szr2SFnuZRMJtucUkOR85tskB746gWVHPJdE0XZgAMKGiW6kquoDtvTzCxbaaRqBEcWu0+TfJcJvon7Vw18/2RrFY7KnXfo2LqUYMFcRHZtDIz90pKc7UjAf7L5UOeLEBtjrbGVr2Ggln/Y37/RIwjydOi7QgPsFGGEEMEwS5kCoGUxyLzNAcC85jhVeMEx9sS/Op7h2yZUAFgv4HdXiPlxoRe7hqEF3YislHYsvD4QqPaGtYOu6yRAWJL8o49XbsFPP6cJ+PUhbK7Ac7MIhoTQKjQkp4F1lOfPMV/Uen59HhFRLyHj3HTOALexkQHmYDIlSzOXR7f5NBwODrOykKqChuM9umELS6IB3Zau99HW+A+4vKS6vFw==;5:dSOuRKAWhxiJP0VM9IrSJlplCrfS6LoSxPxd/bbNXexiTp6ytkAPYHhtLGr5Mgfn/OVn3WsjXtRjFMxJ+xczTlmGix/QKz6r8Ev6hTjUdkqXL7445aQz2JZV101IPkQfUVk1iyyfu+nuA6wy9m7RHu5UKVyQ3Xe9vIw4kEJ9jxU=;7:CbhN2ePYAHQOyG4Mr+eOlbTBJcM7eIhxGfSAL9MRowm9OaHNiKfKPXPNVemFq814Fn+aEj1zsfLdT7/HJZEmyHBpQH+p9Nc3sgwfiOtoJY+IJWOs0/LfkFUsnSAJki2gThg7uBEWNX1kf0nWCLAQzt4TG7qlDLwo3rK4sJyeLKGEgKeaY1/6W31ao9uS9ACHvLIgxiH9fGZ1+QCCgLvIG3d/VAXvmASazjTc8hTLIIrBsPgE5CFYKFSMjobJjTL2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 10:40:40.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af3618b3-5bfa-41e5-74f0-08d6220a2c80
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the binding for the i.MX8MQ Clock Controller Module.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/imx8mq-clock.txt     |  20 ++
 include/dt-bindings/clock/imx8mq-clock.h           | 395 +++++++++++++++++++++
 2 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx8mq-clock.txt
 create mode 100644 include/dt-bindings/clock/imx8mq-clock.h

diff --git a/Documentation/devicetree/bindings/clock/imx8mq-clock.txt b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
new file mode 100644
index 0000000..52de826
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx8mq-clock.txt
@@ -0,0 +1,20 @@
+* Clock bindings for NXP i.MX8M Quad
+
+Required properties:
+- compatible: Should be "fsl,imx8mq-ccm"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of clock specifiers, must contain an entry for each required
+          entry in clock-names
+- clock-names: should include the following entries:
+    - "ckil"
+    - "osc_25m"
+    - "osc_27m"
+    - "clk_ext1"
+    - "clk_ext2"
+    - "clk_ext3"
+    - "clk_ext4"
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx8mq-clock.h
+for the full list of i.MX8M Quad clock IDs.
diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings/clock/imx8mq-clock.h
new file mode 100644
index 0000000..b53be41
--- /dev/null
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017 NXP
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_IMX8MQ_H
+#define __DT_BINDINGS_CLOCK_IMX8MQ_H
+
+#define IMX8MQ_CLK_DUMMY		0
+#define IMX8MQ_CLK_32K			1
+#define IMX8MQ_CLK_25M			2
+#define IMX8MQ_CLK_27M			3
+#define IMX8MQ_CLK_EXT1			4
+#define IMX8MQ_CLK_EXT2			5
+#define IMX8MQ_CLK_EXT3			6
+#define IMX8MQ_CLK_EXT4			7
+
+/* ANAMIX PLL clocks */
+/* FRAC PLLs */
+/* ARM PLL */
+#define IMX8MQ_ARM_PLL_REF_SEL		8
+#define IMX8MQ_ARM_PLL_REF_DIV		9
+#define IMX8MQ_ARM_PLL			10
+#define IMX8MQ_ARM_PLL_BYPASS		11
+#define IMX8MQ_ARM_PLL_OUT		12
+
+/* GPU PLL */
+#define IMX8MQ_GPU_PLL_REF_SEL		13
+#define IMX8MQ_GPU_PLL_REF_DIV		14
+#define IMX8MQ_GPU_PLL			15
+#define IMX8MQ_GPU_PLL_BYPASS		16
+#define IMX8MQ_GPU_PLL_OUT		17
+
+/* VPU PLL */
+#define IMX8MQ_VPU_PLL_REF_SEL		18
+#define IMX8MQ_VPU_PLL_REF_DIV		19
+#define IMX8MQ_VPU_PLL			20
+#define IMX8MQ_VPU_PLL_BYPASS		21
+#define IMX8MQ_VPU_PLL_OUT		22
+
+/* AUDIO PLL1 */
+#define IMX8MQ_AUDIO_PLL1_REF_SEL	23
+#define IMX8MQ_AUDIO_PLL1_REF_DIV	24
+#define IMX8MQ_AUDIO_PLL1		25
+#define IMX8MQ_AUDIO_PLL1_BYPASS	26
+#define IMX8MQ_AUDIO_PLL1_OUT		27
+
+/* AUDIO PLL2 */
+#define IMX8MQ_AUDIO_PLL2_REF_SEL	28
+#define IMX8MQ_AUDIO_PLL2_REF_DIV	29
+#define IMX8MQ_AUDIO_PLL2		30
+#define IMX8MQ_AUDIO_PLL2_BYPASS	31
+#define IMX8MQ_AUDIO_PLL2_OUT		32
+
+/* VIDEO PLL1 */
+#define IMX8MQ_VIDEO_PLL1_REF_SEL	33
+#define IMX8MQ_VIDEO_PLL1_REF_DIV	34
+#define IMX8MQ_VIDEO_PLL1		35
+#define IMX8MQ_VIDEO_PLL1_BYPASS	36
+#define IMX8MQ_VIDEO_PLL1_OUT		37
+
+/* SYS1 PLL */
+#define IMX8MQ_SYS1_PLL1_REF_SEL	38
+#define IMX8MQ_SYS1_PLL1_REF_DIV	39
+#define IMX8MQ_SYS1_PLL1		40
+#define IMX8MQ_SYS1_PLL1_OUT		41
+#define IMX8MQ_SYS1_PLL1_OUT_DIV	42
+#define IMX8MQ_SYS1_PLL2		43
+#define IMX8MQ_SYS1_PLL2_DIV		44
+#define IMX8MQ_SYS1_PLL2_OUT		45
+
+/* SYS2 PLL */
+#define IMX8MQ_SYS2_PLL1_REF_SEL	46
+#define IMX8MQ_SYS2_PLL1_REF_DIV	47
+#define IMX8MQ_SYS2_PLL1		48
+#define IMX8MQ_SYS2_PLL1_OUT		49
+#define IMX8MQ_SYS2_PLL1_OUT_DIV	50
+#define IMX8MQ_SYS2_PLL2		51
+#define IMX8MQ_SYS2_PLL2_DIV		52
+#define IMX8MQ_SYS2_PLL2_OUT		53
+
+/* SYS3 PLL */
+#define IMX8MQ_SYS3_PLL1_REF_SEL	54
+#define IMX8MQ_SYS3_PLL1_REF_DIV	55
+#define IMX8MQ_SYS3_PLL1		56
+#define IMX8MQ_SYS3_PLL1_OUT		57
+#define IMX8MQ_SYS3_PLL1_OUT_DIV	58
+#define IMX8MQ_SYS3_PLL2		59
+#define IMX8MQ_SYS3_PLL2_DIV		60
+#define IMX8MQ_SYS3_PLL2_OUT		61
+
+/* DRAM PLL */
+#define IMX8MQ_DRAM_PLL1_REF_SEL	62
+#define IMX8MQ_DRAM_PLL1_REF_DIV	63
+#define IMX8MQ_DRAM_PLL1		64
+#define IMX8MQ_DRAM_PLL1_OUT		65
+#define IMX8MQ_DRAM_PLL1_OUT_DIV	66
+#define IMX8MQ_DRAM_PLL2		67
+#define IMX8MQ_DRAM_PLL2_DIV		68
+#define IMX8MQ_DRAM_PLL2_OUT		69
+
+/* SYS PLL DIV */
+#define IMX8MQ_SYS1_PLL_40M		70
+#define IMX8MQ_SYS1_PLL_80M		71
+#define IMX8MQ_SYS1_PLL_100M		72
+#define IMX8MQ_SYS1_PLL_133M		73
+#define IMX8MQ_SYS1_PLL_160M		74
+#define IMX8MQ_SYS1_PLL_200M		75
+#define IMX8MQ_SYS1_PLL_266M		76
+#define IMX8MQ_SYS1_PLL_400M		77
+#define IMX8MQ_SYS1_PLL_800M		78
+
+#define IMX8MQ_SYS2_PLL_50M		79
+#define IMX8MQ_SYS2_PLL_100M		80
+#define IMX8MQ_SYS2_PLL_125M		81
+#define IMX8MQ_SYS2_PLL_166M		82
+#define IMX8MQ_SYS2_PLL_200M		83
+#define IMX8MQ_SYS2_PLL_250M		84
+#define IMX8MQ_SYS2_PLL_333M		85
+#define IMX8MQ_SYS2_PLL_500M		86
+#define IMX8MQ_SYS2_PLL_1000M		87
+
+/* CCM ROOT clocks */
+/* A53 */
+#define IMX8MQ_CLK_A53_SRC		88
+#define IMX8MQ_CLK_A53_CG		89
+#define IMX8MQ_CLK_A53_DIV		90
+/* M4 */
+#define IMX8MQ_CLK_M4_SRC		91
+#define IMX8MQ_CLK_M4_CG		92
+#define IMX8MQ_CLK_M4_DIV		93
+/* VPU */
+#define IMX8MQ_CLK_VPU_SRC		94
+#define IMX8MQ_CLK_VPU_CG		95
+#define IMX8MQ_CLK_VPU_DIV		96
+/* GPU CORE */
+#define IMX8MQ_CLK_GPU_CORE_SRC		97
+#define IMX8MQ_CLK_GPU_CORE_CG		98
+#define IMX8MQ_CLK_GPU_CORE_DIV		99
+/* GPU SHADER */
+#define IMX8MQ_CLK_GPU_SHADER_SRC	100
+#define IMX8MQ_CLK_GPU_SHADER_CG	101
+#define IMX8MQ_CLK_GPU_SHADER_DIV	102
+
+/* BUS TYPE */
+/* MAIN AXI */
+#define IMX8MQ_CLK_MAIN_AXI		103
+/* ENET AXI */
+#define IMX8MQ_CLK_ENET_AXI		104
+/* NAND_USDHC_BUS */
+#define IMX8MQ_CLK_NAND_USDHC_BUS	105
+/* VPU BUS */
+#define IMX8MQ_CLK_VPU_BUS		106
+/* DISP_AXI */
+#define IMX8MQ_CLK_DISP_AXI		107
+/* DISP APB */
+#define IMX8MQ_CLK_DISP_APB		108
+/* DISP RTRM */
+#define IMX8MQ_CLK_DISP_RTRM		109
+/* USB_BUS */
+#define IMX8MQ_CLK_USB_BUS		110
+/* GPU_AXI */
+#define IMX8MQ_CLK_GPU_AXI		111
+/* GPU_AHB */
+#define IMX8MQ_CLK_GPU_AHB		112
+/* NOC */
+#define IMX8MQ_CLK_NOC			113
+/* NOC_APB */
+#define IMX8MQ_CLK_NOC_APB		115
+
+/* AHB */
+#define IMX8MQ_CLK_AHB			116
+/* AUDIO AHB */
+#define IMX8MQ_CLK_AUDIO_AHB		117
+
+/* DRAM_ALT */
+#define IMX8MQ_CLK_DRAM_ALT		118
+/* DRAM APB */
+#define IMX8MQ_CLK_DRAM_APB		119
+/* VPU_G1 */
+#define IMX8MQ_CLK_VPU_G1		120
+/* VPU_G2 */
+#define IMX8MQ_CLK_VPU_G2		121
+/* DISP_DTRC */
+#define IMX8MQ_CLK_DISP_DTRC		122
+/* DISP_DC8000 */
+#define IMX8MQ_CLK_DISP_DC8000		123
+/* PCIE_CTRL */
+#define IMX8MQ_CLK_PCIE1_CTRL		124
+/* PCIE_PHY */
+#define IMX8MQ_CLK_PCIE1_PHY		125
+/* PCIE_AUX */
+#define IMX8MQ_CLK_PCIE1_AUX		126
+/* DC_PIXEL */
+#define IMX8MQ_CLK_DC_PIXEL		127
+/* LCDIF_PIXEL */
+#define IMX8MQ_CLK_LCDIF_PIXEL		128
+/* SAI1~6 */
+#define IMX8MQ_CLK_SAI1			129
+
+#define IMX8MQ_CLK_SAI2			130
+
+#define IMX8MQ_CLK_SAI3			131
+
+#define IMX8MQ_CLK_SAI4			132
+
+#define IMX8MQ_CLK_SAI5			133
+
+#define IMX8MQ_CLK_SAI6			134
+/* SPDIF1 */
+#define IMX8MQ_CLK_SPDIF1		135
+/* SPDIF2 */
+#define IMX8MQ_CLK_SPDIF2		136
+/* ENET_REF */
+#define IMX8MQ_CLK_ENET_REF		137
+/* ENET_TIMER */
+#define IMX8MQ_CLK_ENET_TIMER		138
+/* ENET_PHY */
+#define IMX8MQ_CLK_ENET_PHY_REF		139
+/* NAND */
+#define IMX8MQ_CLK_NAND			140
+/* QSPI */
+#define IMX8MQ_CLK_QSPI			141
+/* USDHC1 */
+#define IMX8MQ_CLK_USDHC1		142
+/* USDHC2 */
+#define IMX8MQ_CLK_USDHC2		143
+/* I2C1 */
+#define IMX8MQ_CLK_I2C1			144
+/* I2C2 */
+#define IMX8MQ_CLK_I2C2			145
+/* I2C3 */
+#define IMX8MQ_CLK_I2C3			146
+/* I2C4 */
+#define IMX8MQ_CLK_I2C4			147
+/* UART1 */
+#define IMX8MQ_CLK_UART1		148
+/* UART2 */
+#define IMX8MQ_CLK_UART2		149
+/* UART3 */
+#define IMX8MQ_CLK_UART3		150
+/* UART4 */
+#define IMX8MQ_CLK_UART4		151
+/* USB_CORE_REF */
+#define IMX8MQ_CLK_USB_CORE_REF		152
+/* USB_PHY_REF */
+#define IMX8MQ_CLK_USB_PHY_REF		163
+/* ECSPI1 */
+#define IMX8MQ_CLK_ECSPI1		164
+/* ECSPI2 */
+#define IMX8MQ_CLK_ECSPI2		165
+/* PWM1 */
+#define IMX8MQ_CLK_PWM1			166
+/* PWM2 */
+#define IMX8MQ_CLK_PWM2			167
+/* PWM3 */
+#define IMX8MQ_CLK_PWM3			168
+/* PWM4 */
+#define IMX8MQ_CLK_PWM4			169
+/* GPT1 */
+#define IMX8MQ_CLK_GPT1			170
+/* WDOG */
+#define IMX8MQ_CLK_WDOG			171
+/* WRCLK */
+#define IMX8MQ_CLK_WRCLK		172
+/* DSI_CORE */
+#define IMX8MQ_CLK_DSI_CORE		173
+/* DSI_PHY */
+#define IMX8MQ_CLK_DSI_PHY_REF		174
+/* DSI_DBI */
+#define IMX8MQ_CLK_DSI_DBI		175
+/*DSI_ESC */
+#define IMX8MQ_CLK_DSI_ESC		176
+/* CSI1_CORE */
+#define IMX8MQ_CLK_CSI1_CORE		177
+/* CSI1_PHY */
+#define IMX8MQ_CLK_CSI1_PHY_REF		178
+/* CSI_ESC */
+#define IMX8MQ_CLK_CSI1_ESC		179
+/* CSI2_CORE */
+#define IMX8MQ_CLK_CSI2_CORE		170
+/* CSI2_PHY */
+#define IMX8MQ_CLK_CSI2_PHY_REF		181
+/* CSI2_ESC */
+#define IMX8MQ_CLK_CSI2_ESC		182
+/* PCIE2_CTRL */
+#define IMX8MQ_CLK_PCIE2_CTRL		183
+/* PCIE2_PHY */
+#define IMX8MQ_CLK_PCIE2_PHY		184
+/* PCIE2_AUX */
+#define IMX8MQ_CLK_PCIE2_AUX		185
+/* ECSPI3 */
+#define IMX8MQ_CLK_ECSPI3		186
+
+/* CCGR clocks */
+#define IMX8MQ_CLK_A53_ROOT			187
+#define IMX8MQ_CLK_DRAM_ROOT			188
+#define IMX8MQ_CLK_ECSPI1_ROOT			189
+#define IMX8MQ_CLK_ECSPI2_ROOT			180
+#define IMX8MQ_CLK_ECSPI3_ROOT			181
+#define IMX8MQ_CLK_ENET1_ROOT			182
+#define IMX8MQ_CLK_GPT1_ROOT			193
+#define IMX8MQ_CLK_I2C1_ROOT			194
+#define IMX8MQ_CLK_I2C2_ROOT			195
+#define IMX8MQ_CLK_I2C3_ROOT			196
+#define IMX8MQ_CLK_I2C4_ROOT			197
+#define IMX8MQ_CLK_M4_ROOT			198
+#define IMX8MQ_CLK_PCIE1_ROOT			199
+#define IMX8MQ_CLK_PCIE2_ROOT			200
+#define IMX8MQ_CLK_PWM1_ROOT			201
+#define IMX8MQ_CLK_PWM2_ROOT			202
+#define IMX8MQ_CLK_PWM3_ROOT			203
+#define IMX8MQ_CLK_PWM4_ROOT			204
+#define IMX8MQ_CLK_QSPI_ROOT			205
+#define IMX8MQ_CLK_SAI1_ROOT			206
+#define IMX8MQ_CLK_SAI2_ROOT			207
+#define IMX8MQ_CLK_SAI3_ROOT			208
+#define IMX8MQ_CLK_SAI4_ROOT			209
+#define IMX8MQ_CLK_SAI5_ROOT			210
+#define IMX8MQ_CLK_SAI6_ROOT			212
+#define IMX8MQ_CLK_UART1_ROOT			213
+#define IMX8MQ_CLK_UART2_ROOT			214
+#define IMX8MQ_CLK_UART3_ROOT			215
+#define IMX8MQ_CLK_UART4_ROOT			216
+#define IMX8MQ_CLK_USB1_CTRL_ROOT		217
+#define IMX8MQ_CLK_USB2_CTRL_ROOT		218
+#define IMX8MQ_CLK_USB1_PHY_ROOT		219
+#define IMX8MQ_CLK_USB2_PHY_ROOT		220
+#define IMX8MQ_CLK_USDHC1_ROOT			221
+#define IMX8MQ_CLK_USDHC2_ROOT			222
+#define IMX8MQ_CLK_WDOG1_ROOT			223
+#define IMX8MQ_CLK_WDOG2_ROOT			224
+#define IMX8MQ_CLK_WDOG3_ROOT			225
+#define IMX8MQ_CLK_GPU_ROOT			226
+#define IMX8MQ_CLK_HEVC_ROOT			227
+#define IMX8MQ_CLK_AVC_ROOT			228
+#define IMX8MQ_CLK_VP9_ROOT			229
+#define IMX8MQ_CLK_HEVC_INTER_ROOT		230
+#define IMX8MQ_CLK_DISP_ROOT			231
+#define IMX8MQ_CLK_HDMI_ROOT			232
+#define IMX8MQ_CLK_HDMI_PHY_ROOT		233
+#define IMX8MQ_CLK_VPU_DEC_ROOT			234
+#define IMX8MQ_CLK_CSI1_ROOT			235
+#define IMX8MQ_CLK_CSI2_ROOT			236
+#define IMX8MQ_CLK_RAWNAND_ROOT			237
+#define IMX8MQ_CLK_SDMA1_ROOT			238
+#define IMX8MQ_CLK_SDMA2_ROOT			239
+#define IMX8MQ_CLK_VPU_G1_ROOT			240
+#define IMX8MQ_CLK_VPU_G2_ROOT			241
+
+/* SCCG PLL GATE */
+#define IMX8MQ_SYS1_PLL_OUT			232
+#define IMX8MQ_SYS2_PLL_OUT			243
+#define IMX8MQ_SYS3_PLL_OUT			244
+#define IMX8MQ_DRAM_PLL_OUT			245
+
+#define IMX8MQ_GPT_3M_CLK			246
+
+#define IMX8MQ_CLK_IPG_ROOT			247
+#define IMX8MQ_CLK_IPG_AUDIO_ROOT		248
+#define IMX8MQ_CLK_SAI1_IPG			249
+#define IMX8MQ_CLK_SAI2_IPG			250
+#define IMX8MQ_CLK_SAI3_IPG			251
+#define IMX8MQ_CLK_SAI4_IPG			252
+#define IMX8MQ_CLK_SAI5_IPG			253
+#define IMX8MQ_CLK_SAI6_IPG			254
+
+/* DSI AHB/IPG clocks */
+/* rxesc clock */
+#define IMX8MQ_CLK_DSI_AHB			255
+/* txesc clock */
+#define IMX8MQ_CLK_DSI_IPG_DIV                  256
+
+#define IMX8MQ_CLK_TMU_ROOT			265
+
+/* Display root clocks */
+#define IMX8MQ_CLK_DISP_AXI_ROOT		266
+#define IMX8MQ_CLK_DISP_APB_ROOT		267
+#define IMX8MQ_CLK_DISP_RTRM_ROOT		268
+
+#define IMX8MQ_CLK_OCOTP_ROOT			269
+
+#define IMX8MQ_CLK_DRAM_ALT_ROOT		270
+#define IMX8MQ_CLK_DRAM_CORE			271
+
+#define IMX8MQ_CLK_MU_ROOT			272
+#define IMX8MQ_VIDEO2_PLL_OUT			273
+
+#define IMX8MQ_CLK_CLKO2			274
+
+#define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	275
+
+#define IMX8MQ_CLK_END				276
+#endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
-- 
2.7.4

