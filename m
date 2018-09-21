Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF503ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453C721523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="teEH5x1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453C721523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389867AbeIUSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:01:52 -0400
Received: from mail-ve1eur01on0062.outbound.protection.outlook.com ([104.47.1.62]:58107
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388850AbeIUSBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkzLnxln/eM1dgawK1A1Aqswt8x5zMffupoLOmJN2Gc=;
 b=teEH5x1aqLXHazwBnSetuwDymz/KcJ+YBlycOt51n5ppNYxFn5sIHB/5+yEQtvE/yW3bcpxFlOS+MQfVjugiNVCZW7eWXwbJvlo7pctXmvOiNr5RMefNu9xHczvs8yH8VY7gT9RWWzDpDunwKd0MMHa+3+Qmm72YJ33v/a0+Bd4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (2a01:111:e400:596b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 12:12:03 +0000
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
Subject: [PATCH v8 1/5] dt-bindings: add binding for i.MX8MQ CCM
Date:   Fri, 21 Sep 2018 15:11:30 +0300
Message-Id: <1537531894-18499-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
References: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::24) To VI1PR04MB1614.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19cbc1ff-afc5-46f2-3254-08d61fbb7163
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;3:bX8YTBfwbftHtq7c6XWFzm0BSVk2e5eok+SlNvUmlT46BbgmtFU/PTR8n156C2YTSizFRbwH2zwn3L5OZQspSEmsZynw7i7ykExFW1DJ5kfGyL+gIxwvFdMdEl5XjE2DjJxGmxsHB6F/n3KtcEwbzH1bnkouq7YYgmOyxV2YElruoGapzHC5pG4CqhTSPe6s46jvTqFvNAib4aa+D6BeujW9eF14CFDJMqho9/hq8ymmNUui0rx93hRpZzqQN2rt;25:npzR62zlU/16c3ijNwYpzjh1rOt8VYbNfvOdp9BsI3SLsodQll7GvfW1vvYMvV4nIT6glebTkOxowyjUpvwYJGQUFO9B/Egj6Ikpu3EN5mUHVD42+fKfJJf8gLTVZLd50nfgkG+GJoS1t1Iib1qw+g+7LoyqaeI/blv0kFqRi6/f8KbssU0uvpk3hczXEkyoZoR11FL0LCPvxaRzOTJIm4HGi7MX+mNIIFUtp4FIev8GUPF/Ha7kFQ2NPtp81lPZteQ10miaAGB18EoBBZ6/IBFheMWJj5Cy55U3qSjMn/09JNjjbmw4hvbd2wxXcULn3rou8hF5Ut9cVR+q5+pAqA==;31:bnDOkTdTsrR50ZdnxCeGYFZU+mnwJyeLtX6Rp241Zn1l//+pn4BwAfMXuFFPjWK5iKvfqud515bkE9m+PDzL9Ok1+1lji/kfnYJ234wsRYfWT2R/Pziu5Wo4SLZj08xncZ13g7EkLrQGJNsqkpZq/twqkfssm12Ge6yYO4ZlAUMIrbEqxGq545jkxLcczNfJCJb1T80Jm+9GaeESTEjeh2VS7c2yTQdCQ5ySq1xNzAE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;20:Dwg+Fv/CM+Gk3I0PdQmQCeeQ1NKmq/J19+VtyV9FVAMbnZX3OpL1Kor012cp8Ygfu9ce+8OmKCMZf9Qzmk1ip2dLefssl9C6Tsobh4tp1ctaacL6ZfFXvVYhv5PiH9TRapPTR2Z2vf0uRLA+NSN6NwtUxV1mxXmx+5bEgRICd7ZMy+5+i/imIPoyN+tMIpxL9AWB+3yh8R2tEchJhktIG/m1mrscM9M4aus8c5h/UHMIqjDa8aLKxAneGLbZshUse7Yuz+pmvdBrirqgL4916fPM0x+LlzoRfQGw/p49BHRHUUecy0m6fO2m9qfoipgRGk1j5C/ZMrTBnGwnocKR1QvalDNCXk2WkXgn70OahSgamSmxnpq7JP+EN5R0J1qdBj/OZKtZeNVlYhoNs/cNAAcoJcsB4G5/2qwayhfj8jTvTyB4TekE9VM3slhf33DzrwBBS4C6hRHoY2YYDtDhIOxkNHEMvUOf5x/QB+B8G0/7kkVlvOy37lFn7iVXlod8;4:wpwcJR9EM7TPXO9/6gGBbN4mbat4m6A/k8AYeK4dDlaI7mCEejRTBjT6Hafyt+Mb0QcepVdytH5BznZB0CgRCuRSTOOCaJaxcHu0G2gEkcrC14877LW3dHSLx7JIzBOMX2HTA7mK7lA92INHCG7K7KOEeuMjBJKrh5XxwlhAWv3sppumXOSXSMxze0bx+XRbv3jDdC8cIVrHcAk174RgKlS9G8UZyimYEhSB/49XxFn1d9EgYgWIJ2qSAAgTFqNjKns1sUUyuwospLkGqLCMIrtqlGhYB3DA35EyGunKMDqDaupBOd/c2W2G+7DwT5vZ
X-Microsoft-Antispam-PRVS: <VI1PR04MB16145D25B23B1FA6CBA52167F6120@VI1PR04MB1614.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1614;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(97736004)(36756003)(4326008)(6666003)(25786009)(6512007)(186003)(16526019)(2906002)(47776003)(8936002)(81156014)(81166006)(8676002)(16586007)(66066001)(50226002)(6486002)(6116002)(478600001)(54906003)(110136005)(68736007)(3846002)(51416003)(486006)(76176011)(26005)(7416002)(106356001)(386003)(6506007)(44832011)(52116002)(86362001)(5660300001)(316002)(2616005)(956004)(476003)(105586002)(11346002)(446003)(39060400002)(48376002)(50466002)(53936002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1614;23:QeMyzYa//DzqS0gwHZTCEyxAieCAauTpEk/+DGvqU?=
 =?us-ascii?Q?5u69+CiWqyp+bvzVZV3Vij4OtN8jZKLalxE/s1ValUbroSeSYykafE+d1zKw?=
 =?us-ascii?Q?BG40j+Kg7TojxTtACwlWd4XfWf046lIXM0QHofeiqHhhpZvqz12Kn+2CoRy/?=
 =?us-ascii?Q?O6ync+FFnoW9Xg/CXHZNfq9u0T0cHVra2vRD8AGcNwXI4Vq20SMouOy9n7JC?=
 =?us-ascii?Q?D/WpUAekLhHXPNyPwTeJ7p/Uq5tfQnUD+Uj8eD1/U3Kj7ZcvNXKXzn8JoMiv?=
 =?us-ascii?Q?rOte45YPZn/asZCejsZGOPjuSYgRGocUDVWKPiJKu/+RobcKLrajqwymodet?=
 =?us-ascii?Q?xQ0pTIXWK5koyR4hTLCMJZDXQxE2/KVLSCf94gnRAbyeIG6Rfa6u60rl+Fua?=
 =?us-ascii?Q?y2Tz39iEJEr96DhqGPaWY6VdiEIFGOLxzm+gs/5VMsimVcKiRRpY7p1Vrl2/?=
 =?us-ascii?Q?uGUIT8gB3fnw4lX9NaiJSvlOUnZHCas8GnKf2h1Q3n2oFxPEl9/Wv9ESNbjz?=
 =?us-ascii?Q?WqP0W90mmd6sFj6rx8oc7Z+uKrHeiuIawRI+Hw6oyBeclieI7cEMdLy5X/cO?=
 =?us-ascii?Q?TMz3Qe7XsAdFof1WTEV+FP/zK6UXsp1veGJIbJS+tdDKTU5rUxMBfzTnNNNK?=
 =?us-ascii?Q?hfiyiX40cQcwRvAAsmGUxEspScP+3bx9LsNajn8uySDdhMskVRLqhdmkHfYN?=
 =?us-ascii?Q?o4BSUx0YDJGL2JGLYZ5st98Li0kY6Podaaj2rdxWCcBlJNqZ2js770q0nqfI?=
 =?us-ascii?Q?GsvS1ihf5mD7o578tN5AgD1hpXd/pH9QYEnX8+Od+6UJSWXIkunGG/RjNRmm?=
 =?us-ascii?Q?Vkg6ii2B16/h4jHjdr2OnrWHi+MGPfzqUjIG/WjNTIxbh4WOv4tQGVZfGPRe?=
 =?us-ascii?Q?q7cr0KFF5PzYWceYFIp4+aXc3tYDo5pBVwR0hwT7TcWCUwmPK/ZjkBSmtLhk?=
 =?us-ascii?Q?FTHztVEhsyCd7yuF0WcW2vRASkqWKhTglkLkaE7kU1pnf+iPvmW7quyWeDQK?=
 =?us-ascii?Q?sKmPCNhPutZcZpIlp663RscykI3EB9Z6q6EJbcmVPcUc4OHmyLt+QDMayLky?=
 =?us-ascii?Q?1Std1C4uW5oPMrMuHlhE5VsigmbtSBDe710AXlasLymVAkS5vW52nu2ywpUO?=
 =?us-ascii?Q?pm5dnNrjy83dhcasGNZH2lMYQgPrbRSs3t6/PXWFys2+ihmdmj/faw0OTMWs?=
 =?us-ascii?Q?b6XCFIrc2QlsirBA+H4r+UxfwHvIylRwA2wuv1ivHMDW+3S6oMH/P4u56YK8?=
 =?us-ascii?Q?p5Wt1ju6gz0L2nQnaM=3D?=
X-Microsoft-Antispam-Message-Info: uIYcitLP0bsxM9yey3Bp32EyBZXePb4DbX2ZMEiGRdiCMFBx4xmFrStJ0t7P/I41yHMW7VX6wn0oFGpq1VlOGMCLIG1zG8lJ2HAmFEG2RmZMRpHUCFJ4vpzk6C4ruOrbnkrtbnScr2tjIonkzdo7xdWkL+ayuxd3BUZg1wM9/XWin+JTsQJo2VtwTAS+loTwK20WcIDLlsrmCZ+96k9TnZxDfXPd098Z72ypy895l8SuFCJ47yii0ddxzFBaNBurpPyM3zFPUcBxqLzwdFz4o4bBnQD01s2MHEosxC9NSdoiKBk7bZavyX+VnskAlbkHr+m8VMV2OXGxuGDHlbtRGhwOhDQQgqFIbZ8UYE9xgxM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;6:5DalwrRcVleWSiu+2P/vG8TDf7PdXAAq45By7fJWsYK/T3LAu3r40gB4Tf3f/tk4FoQESSne8VuBuF+qkCGBlO7jWe/guazlaRoMvfr476NbSxwA7EwoehEiWxzCPjeYHnViDZifXeNsldErQKSRIz7EEpLoHVv96AQOMlG/uYK5MZ+8Xb1MduVb/B7ZRT4Pv/e+Ms0wcETgOO5XAutbV3Hu3323Q+y1QKqYxGMjVsnHdOIyjTUFe1uLdneer5sAnlz808/T4w+oCDqZALj3akjFuOm6uuvwRPBTCtDSdgJjkW8meGCAnV0jjtV4D4uy7GIGJrkNAbbzRbO/Ds21ZbZycGO7unCoBPNbhI0XyIjZAWW8vcwSByOqJhUKhX8SUOHQLNpT6/jbr4JhSizxk6vsy5EGcC8762iuMwzoT//eXDNFBCpo/3qbS2nGuvkdam1t1/3s6huFcz4Mp4qRBA==;5:sGT28uBT0guAAszz0vmOAzWPt5vHB0LwN0MKkWjWn1tKyA3M6djPgT/qjQO7/Pg1DmEpLmhTn6pswJ9rzkWeEZmEoQJeOzlZo/W6dTmF5mzAEZYjc+O6pz/cK09muV5QnspNljH7tzHAcwYB+Xljp5DcrzESkkVfHSlKTjqTlWw=;7:S56NJ3uU2/HhSVE9KtNLwrdjJwGxY5meEvU4h5GRvXAqRToQQzwizWfEOua4PxPP4kxT5/DHpVUG/Vgx1aUBSjq3Wt0+y6O1aqFsEJoXWiHqDJ8XS4g78F6Dps8kk8xO03fbt5bQo1Zc0/6rGe/wi3z9w0uXXshpMGC1MadX2mFRI+qQ3GBBx7Nyri3+fQf/fa1DTme6m42ELJ8qCcdL4qgluJgFl1d2p+PvMTAmJisissv7gjV2Mt7vP8ywua95
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 12:12:03.4300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cbc1ff-afc5-46f2-3254-08d61fbb7163
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
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

