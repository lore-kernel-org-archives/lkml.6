Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50741ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3552098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gipisb39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3552098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731139AbeISLqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:38 -0400
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:57760
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbeISLqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wleMOc+4TlOyTh23tAsxynUfRqYTjp1lwYonkBlXMCs=;
 b=gipisb39OWO7Hqae3PehpkUxFLqZONWYAZIYgwunuYxheEdZE/Jzc1VePElShVzzTeSH0jm7XuBT3NguLvxAm0fTp9Q0a75uId0bIU5WWvaFSRE/bnG1nqYM+20EqZ8IM3hTOM62HvFxri/gVYFYg5ahfvJkhdyxO0fHTFtEztA=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR0402MB3919.eurprd04.prod.outlook.com (2603:10a6:803:22::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Wed, 19 Sep
 2018 06:10:05 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 4/4] ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
Date:   Wed, 19 Sep 2018 14:04:48 +0800
Message-Id: <1537337088-28819-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
References: <1537337088-28819-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:2f::14) To VI1PR0402MB3919.eurprd04.prod.outlook.com
 (2603:10a6:803:22::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993136da-0de4-46a0-8d05-08d61df68e2d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3919;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;3:s1DA9Eu7kizEN7emvTrrlnJdn/OhFp8b8J0XIUyWAMKL/zs3Y2yoFUYLSXa0wIAdVoYDkg8gdpfH8jL9VV12UDhva5ZRSKY3wuiV8DShJKAaXt6pfgdJKhTdhXezXj3Cc3TCXZqdOfepq70C0lAg1ssXMAyjoXZwu1Me3xnTcF6ZkLWOKLApkzoyQvaE8zFU4hSuJOEcGS9W7ix30Y1PJjC9b71U+5nu+bjcVkwDxJFLuFc3V8y+MV4i4s68UgVP;25:iLiYgpHKSdTMERGToQrj2CXcBR1IcVSd6j/Wkj8L9F5W/DvTXTmEDl41EPGH2+/hIqH9Jamsp7fmei+YuKvmKM9qRYSrazSHRycdZsgndjQoI88WhSLBeyT5aTCA6+WnjtoZ+NbwmLBn7+u7xB5zCAaWcBO2szxIzqF9WusubY4yRzSY0/KRV2MwCXXNke350rwoQfXHtgmlS7OXM+v0f0ZzjudsQEU2hj5Mz1MrHfzXdugIU/OQBhf2ugEzxqRtohI3WWVxWO71AuyVX2mPKX800ED9CLmK9LSy3eniYZ1N7EX7BoR93sDnAYU5/mz1LId6G7MUTseysZIwIFW6vA==;31:XLeqLysvuaBsUvjjIrGF1efvwF9iN3C7O87z7LG9aRYgMHzyEQYJZcIcOho9ynVMtwa9f0iO/Wg9LY5yfnSJvFo8Py7rb3CyfD1uTODWGLvTpZjQECLWsu16ZA7x80+aEwGqKcwzf+IwT8V4cSypz2GULR9CoqDnDCGsG0pdJCO1y74Kkt6ImebkqL8mn+xHJdg1DBs2y8qwa/NFspjkcGLMNZSoA13XBTlBBu/xDjg=
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3919:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;20:7O7ukwbH7sNhTnYb8lq/oHAtywJ4Adxauus9karnalNS7WpdHHsBkxcTXEcm5XontBlsdkMumILW739oF2OX/dKeLXEXplF2pWEjDq1+wacdFviPSuEcRnH1tdZFLeNe85r8SeAVr7hVl4x0re3awJ9CangBsmSmhAXY6/N8NjMjFjmv3U69lLd08+wyvOpXL4ZXJu0j1vVlXCU3y2V7IMfsAXv7AyeLkAYM9HkhTHFo5qWu2vDGYHn35z42piZZITVJ/7/0S8jBCcN2jeWmIW7Qmslb/ahSZDj39Z21Y6yDilurcYZiS5ysdLMCobLmNI9hLEH3BY8KdlffKNdOLLELdkwSl0AjwbbhKin0ZGTnzirJXJRbkZl/J2fLgDjG1BT+tN+zKeBc1/0JV81X1V9YGfeMdwLh2U2fyZvNGfTuQbU/iB+23b8Bho5RV3FmBVWkFDrFKytvl403u5qfpAqTvwyqYj8JxNKSvisdovhRt5cdaGVCVPW0ThRvw2/A;4:3i5E7+JO+QXqORcWexoeA1Wcp/Sp6g2zv82moeJdsFdlWWJLUivmKlN+qi60me90a5W+Vy+AAGYiwJu3kgalwI94vAQx7uhG4PaJdftUFkzAK2AYG8hfwq22ZO3E2bOgyihdIybu4RS87FQaVK5N/4K1UPOrLmIYEXyhfFkCsFUOG2KfFtM8E3IkSaa1ZuxVntl2wXQd7a0yuovjjd5ZkTG67gr4HjuKLltjXpvjDKfEhgHItjQL552Y5QMwCJ2KUeiTNJbLLwfL4eZLlQNXnBFn19tQ4XGqHTM1NkKu/8BoViOtNQckKpqjQ4CwS4x5
X-Microsoft-Antispam-PRVS: <VI1PR0402MB391917B607593B04A1FC9307F51C0@VI1PR0402MB3919.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:VI1PR0402MB3919;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3919;
X-Forefront-PRVS: 0800C0C167
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(6506007)(51416003)(26005)(486006)(4326008)(16526019)(36756003)(52116002)(476003)(956004)(11346002)(105586002)(25786009)(6512007)(386003)(53936002)(2616005)(47776003)(6346003)(186003)(68736007)(81166006)(81156014)(446003)(8936002)(76176011)(50226002)(66066001)(106356001)(6486002)(5660300001)(6666003)(86362001)(305945005)(7416002)(7736002)(478600001)(2906002)(16586007)(6116002)(3846002)(316002)(48376002)(50466002)(97736004)(14444005)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3919;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0402MB3919;23:iarr1I/FkNt87KGJLCSqROgs+mfNp4oNu+Lg5R4?=
 =?us-ascii?Q?tcTT21teX2MWh6we65QPj6sy+O0qWI0eNMtqzaDP44dIltuz0dodvsiOxGkg?=
 =?us-ascii?Q?N0skpSHhH0gz3wzQr70GGMxZmgQz04iwdKm/LPCEerFhir/Sx0uAG+2iDHPE?=
 =?us-ascii?Q?cfHRe/gjmR5085zxmjuyqlKWU4lJDbzLNWYtMuVauScXt9JDvV1RtCczcxSL?=
 =?us-ascii?Q?lInyt7UQopW0L1ePF4V8+R8DEaJWM6jgkOAXqaPjwuKJOhSdgp4urlUQsUyV?=
 =?us-ascii?Q?KswGwIquKmk8BkDSz/MV3XVVetJcNgskTXD7Q7uEfaEPmYb/G+RUwboghmeD?=
 =?us-ascii?Q?46xRIM2m3aN4VcXPY6qSbvQhHfF+OSEhVIw+Zwn/ZvoVNb/gMFsgSxKVu3t/?=
 =?us-ascii?Q?ckaPbgEav4A2iabpqSUOfWwQ0JCIDUEw+GPCiReQprybpCSpc4lp8hxlwhSR?=
 =?us-ascii?Q?Ge+aqjY6RUPvkWyZIzVktrcg+XqLeKDBM3+9qYZfJ2t6AP0lzcRzTyn/KdTM?=
 =?us-ascii?Q?nLllQmwo3VNkSP4wWiVpeV7gGOPBaIsORdx7UE2wWqM3zok/ao8BkIMnxuMf?=
 =?us-ascii?Q?6yi0VLV7rN24b+PfHMDLHXwN5WQJd3VmFtgOMAhIsgMiUFJJDRQOF1mJKRxO?=
 =?us-ascii?Q?Jqj1Nx4rXh1nQjCViREKLmPvAnIc8+rHhyghrEcivoZnkFSJR2R2pZKwYwXw?=
 =?us-ascii?Q?g4jE8ePteqQqluiOsWqSDyLEBqshzgWKO8XU9Swy8qfBcYgxKb1fiNpnWNcg?=
 =?us-ascii?Q?8qJAHBtGSu2Dg43ks45gYbfbmWt85loCj8Uwfvevq7vvs2nNFe92nvrR/ISo?=
 =?us-ascii?Q?ZpoKTE2FaHWNSnS1bijiEVpCaLci1+SuYcrgVABf3iZw+GpX5k363TqApn1S?=
 =?us-ascii?Q?KfRdm3uJ2yojjNUhlxLiF9jvJ6Fb+1vhlMhhJ6MDqAyRoxR+YBlJJv04Gflk?=
 =?us-ascii?Q?X5WXtEHn91E1s2B3o0ye6FE1539qfU/Ennc0XPZ2bDtv9vCVG4djCAds/hQq?=
 =?us-ascii?Q?wQuqRZzPQDrB8avHAJaz5mug67yfuUOZuiWCkMKLACsu9Tsq44K3n7Uy0DB6?=
 =?us-ascii?Q?8j+EEo495WX9grkXYT4/U8sGVClVJzSt2uJXVSRjmeIZyIYOS3t0a/SaVY9B?=
 =?us-ascii?Q?gGv22NYbG6SATAsnUsnJHRFoKaOhan0Mp0qlqG1h+m9jWwisPDnKd3mA3gQ3?=
 =?us-ascii?Q?WOC1qE26uuUkMk/0LAnrQuzitHoPLnOPc9qZnDPqeGhu3wsBdlmxDeY+7LES?=
 =?us-ascii?Q?QMmJZ0SzNyR2Wn/m/2Gc=3D?=
X-Microsoft-Antispam-Message-Info: nSDqkkYVlONx5XlcR4Yi/f0C8441j5lzPj7PXNTrI7O6hI1Ja3THs6qSI7D5+FRmWepdTbZlUfd/Bfw629Yt6C/c9t8D45pLo5VU13Uwi/AeYeUWaHzBxsmipXi/Dt3oTH5LiOgujK/+qTAED+7hOpJe/G2PcQO1KvtSpUVHDkqxY6UCsyoJhWNrfBqfvHTUkIVjQ1HEJRAtpln02Fqk6F2bCGqVfVCKvkJD1RIoiD/WL3R6oUpUphWw2Or9FsdUh+RfWF6eXFExopqNT8HtIwe0dOrsB+Lw+zUOqNJ8GSWNzkEYA96XBgLca3HMKyVgQsdwd+KxZpqbwdHzmy7h6ibRGtZkc2ExUygFgCahvcw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0402MB3919;6:f0OcSC58f4tc90CTF0QXNAcnE3wEjbnCrIpCyTHWp4EWstw4GVFoGwUNSl9n7zzpOSKrmxoNoW8G3E1A83/zu+8MYnrWNHmfxTh9ayDfBBUFp4x+2Wyms57AepFcxA8cuP77hICyifapP1NTIQv9BQjEDN08xZUyMWhWfC2nvpR0yh6CZtnMfzkpg/dcia2pvMDD/qnHYsAuCFJ6X/eUR4jWWRhMlXac8XMvw3d4qWXu2Op/CBkz2u1x7MjAt63/f/p7lKH+ZPaKwU8jJqTm5kUUscYfNYoOJshEM+O8tQdsP2Whx5tibCITS2fvo0sv3DAVDWEzzRR9cct7wqqzeQ3wQpVcAyUrCkqMGmKuCOUK/1ZQXDu+yPfEeOzuqedN9CbE/NFIJSk6cMEIm5pO8BX98XWnMg+nd3qWINCUHbd2Cj7VZJ906Xo7kK0EMl9h1MH3G677eKY6s59zocInfw==;5:RpkEckFJ8aQQ8KMROrA3VXefKKnDPb6UDmnViCdOEY3s0gPluC+97NvzjGqTOZou/6FgHr/O35JtQtWNGWfrgXNuAIKrtfQdX4ZCenRndzwNMJ7XCqmyg9DpqPBRbTG6UL6575ZJfcrsQZKj30XWnHOmnt6x1RUMEoKQGyAjYDk=;7:2w/0JuTDyqhu+wUvX2OKE9ZIoogfjt/j6BjxMy7ozOHqT6rJcqJnL83yfdtFvshNk/G5uI5pSJkHDtQla1D3pRPaQ4yjb5DC2iHE5X+N+YNfQPSWm/TTe5/bFOz8uISVP5b8iuk2T8ChrlFegCtFGyM/D8layjghsHhCLEzpuVUB1qnij4wL8MJSMFfvnlC6bd7pe6HTJE3+KcjrTHfNYs5/po7JR1c08+X9vjnLJ/EhUVM9ZmWPONGArkeUH1+5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 06:10:05.6710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993136da-0de4-46a0-8d05-08d61df68e2d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ is new SoC of i.MX6 family, compared to i.MX6ULL,
it removes below modules:

- UART5/UART6/UART7/UART8;
- PWM5/PWM6/PWM7/PWM8;
- eCSPI3/eCSPI4;
- CAN1/CAN2;
- FEC1/FEC2;
- I2C3/I2C4;
- EPIT2;
- LCDIF;
- GPT2;
- ADC1;
- TSC;

This patch adds support for i.MX6ULZ and i.MX6ULZ 14x14 EVK
board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/Makefile              |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts | 20 +++++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi          | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b3ec70d..d7268ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -560,7 +560,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb
+	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-14x14-evk.dts b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
new file mode 100644
index 0000000..e2d67a3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+/dts-v1/;
+
+#include "imx6ulz.dtsi"
+#include "imx6ul-14x14-evk.dtsi"
+
+/delete-node/ &fec1;
+/delete-node/ &fec2;
+/delete-node/ &lcdif;
+/delete-node/ &tsc;
+
+/ {
+	model = "Freescale i.MX6 ULZ 14x14 EVK Board";
+	compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ulz";
+
+	/delete-node/ panel;
+};
diff --git a/arch/arm/boot/dts/imx6ulz.dtsi b/arch/arm/boot/dts/imx6ulz.dtsi
new file mode 100644
index 0000000..ae6d7e5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+#include "imx6ull.dtsi"
+
+/ {
+	aliases {
+		/delete-property/ ethernet0;
+		/delete-property/ ethernet1;
+		/delete-property/ i2c2;
+		/delete-property/ i2c3;
+		/delete-property/ serial4;
+		/delete-property/ serial5;
+		/delete-property/ serial6;
+		/delete-property/ serial7;
+		/delete-property/ spi2;
+		/delete-property/ spi3;
+	};
+};
+
+/delete-node/ &adc1;
+/delete-node/ &can1;
+/delete-node/ &can2;
+/delete-node/ &ecspi3;
+/delete-node/ &ecspi4;
+/delete-node/ &epit2;
+/delete-node/ &gpt2;
+/delete-node/ &i2c3;
+/delete-node/ &i2c4;
+/delete-node/ &pwm5;
+/delete-node/ &pwm6;
+/delete-node/ &pwm7;
+/delete-node/ &pwm8;
+/delete-node/ &uart5;
+/delete-node/ &uart6;
+/delete-node/ &uart7;
+/delete-node/ &uart8;
-- 
2.7.4

