Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6FFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143CD258E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lO9pxHmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143CD258E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeF1BJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:09:53 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:54720
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750946AbeF1BJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enl/khcAOGu/25x6NiZTye0MKUOeQsgo/9cf+FcOlM0=;
 b=lO9pxHmIXCkcfQxweEsUY78inKYQq4hX0bxeYor1/8RVdhqk1sEIIzXHyvMF+v9IOks3g9SMPzhx1LB//P+0Xlb8QHVzN9yIPdyD9uapLEYFIpuKmYj49W1kx/g5tCANEe3WhnTdRAAbSwoaeG5K/kI10PlefazFb0TiYZkKphU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1316.eurprd04.prod.outlook.com (2a01:111:e400:586f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.23; Thu, 28 Jun
 2018 01:09:43 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6sll-evk: enable usdhc3 slot
Date:   Thu, 28 Jun 2018 09:04:27 +0800
Message-Id: <1530147867-24159-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To AM3PR04MB1316.eurprd04.prod.outlook.com
 (2a01:111:e400:586f::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 694e20ad-59e6-49a0-e1c1-08d5dc93d708
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1316;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;3:HEJ2G11I0R+Qjpdu3UBjybNXPM4pjenuPgMk4WdHl2E2wj859GxRq3E7g7jF8MEwtLYGuQWEhfpXelOvqjCB5OZipZoRO1QLuxJkvvmlbUc58Mxh3Z3ciXiB3FQBBWypkkhS0DR4QQgkKcsVxKutgYQCZAAJ6U3QB2TsU/iyN3vBCrKRK+Yaz/7OH2SLjSSuv9dNUg5TFsOhHtF7TKotRnjDSNxz8WlebcKKedtktSkvSAHqpTEo1gB/OEsyjLJ0;25:z4nrG5yxDot3Vinf9QIreBfs0+eP1fz07EnoX906HCquVI+5ORMMoX6IxR/VW+T8KJ4KW9L+oBnAOhy+Vpj8WERj9SgfTSoTjVakle8EwtVlzFiUSvw2Y0IZzjWgLz2VOiXaWP2vdO3sZE8AEgmGRkhDHBAfQgSBfFq6FrofzoEVyHZNqrT3K3XGBOnBRDeQoTd+R1jgUm1+Yh/4rMHZrCyTc/UkLQt9U0M4ROREXJRnFTcliOu1ImpracF7pQcMmBQG/R0+CaIEeOVLDq2s6JJgf7Ms3kIGIloLAW6xkNnAA7dIjYnV4sTU9VFgROqzdY9DaIEb3LvOJioTiQZyaA==;31:S32gBON7AWwySvVmZ29OIO6bVe/I+YGs5wSvdzB0h9pcZ5tVNSVbmdcYT4TKjeNS4+VkYWGgRqRKD9ghD5LORqC+SupLWurZQibv5nsUVji+7IctTLrIosfeI48XkyzI+l7YEPAUZlAguURjTmymD+aiSpBC/l0XsTzS4x8AC6XbQ6ezGEZd4oDpqCHZfnmJTmYJyWYEvtdrgfp0FG+JIur9d3OUFzCURDCCvgeRIuA=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1316:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;20:9Dm2OqGBIgs6NgWTtwle5Ear4qRANsz+hhbAWP/8BkhWTnMdLOcz9yDf+FmL3UYuqdhOU9qPyHtGiKuC+7P0XkUN5SFOpVezA7bs27BdKBz6SHnCGDIUjJWlLT1GdchB9XjuJEO5y22lQW5s41KOO2eowf0KcaPMGaOBiqBRlhuVBFuTtlpSVjD5oh6xEUZh4K6JHyC0PfJVA8ZRNZhDpRuKRl5FxFHRyFFfZuTTfcamUwDN/s2a84PJijLOp67af9VXf146DjjqTa1QIu9n9fG/vdg79km2HXgTacvmt6hsGcXPVdSDHxl7qOshjq/Kqt931tZe143+vtXFbWMBLzloQu6Ixfvpd1NHR928JX0fuwYUZg+Co5y6fatRoQLjAj0FwxbvZPpuHk1xnSEu+1fot5YJzmrIJj48Sr3oEG9cBfP88cfvsfrYosvkchtxlV8a+ES5iNyVMv3RuZw+305vg8j6NlGYYKQ/2OuEojQLuZPpUy39rXgbYb9oHMRh;4:ywcrmuhMZAzUnOQKKUqbs9BbqIbNn+MEZhpDmFkRAkDDKcDEo0oGx2SUmVwlBDNZLze6uU+4sosEw6XbRnxjK+IUQozSEuaelxW0suGY2Ualud8EQCHog26kGOWr+6K08081KoMlx3GOBM9dKv2MiE7aT0EZLCi3vSAgsZyreRo1uTJ5OFnjpsz+Ho5pIJp/NrOH+63YwY6QbDoaJaLqH+2HMOD3SwAO7J+wdX7fWTvDQAeAgQa5g38im83Jl1gYsA+JtysMX2YFJ3TTdcwfdeOeQR9NR1Tkjjdj35/TJ9R9vIfjksC60hEcQxifTsKH
X-Microsoft-Antispam-PRVS: <AM3PR04MB13166E31673E115DD4F01195F54F0@AM3PR04MB1316.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1316;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1316;
X-Forefront-PRVS: 0717E25089
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(136003)(39860400002)(376002)(199004)(189003)(36756003)(2906002)(50466002)(48376002)(50226002)(81166006)(8676002)(81156014)(8936002)(4326008)(25786009)(53936002)(68736007)(14444005)(7736002)(305945005)(86362001)(97736004)(478600001)(51416003)(52116002)(26005)(186003)(106356001)(16526019)(6512007)(486006)(16586007)(316002)(6506007)(386003)(6486002)(5660300001)(3846002)(66066001)(47776003)(956004)(2616005)(105586002)(6116002)(476003)(6666003)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1316;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1316;23:TqcxoEGKIp/8IO8rxrLqIVJVDzFDKV9gikadwbni9?=
 =?us-ascii?Q?mKi3ADCv/CZ9K/GwOT1nnfvJXhNevY9Bpvb8qQ8DntF8qA17ff5IUxGwHnc/?=
 =?us-ascii?Q?iL1DjYt2CAhvPewBphUafN0bD2w9Joc5jbZnrEXgqSHHzi9tcJ7cEX91gHHc?=
 =?us-ascii?Q?AgivYWmAhkAUF309t7p4vT5p/FMm41zpbv/OyGAp9DTlfhbfjluwdbFGNF7y?=
 =?us-ascii?Q?BBOYiOThzdT9k4F8D1UMZWFjg2Rn1JMNB3ufzicp1RudIjXwRtrQ+Zo8Digj?=
 =?us-ascii?Q?oaVV/Jk6f14xmHSVyutEA6CTPtdYKAraapTZCTNI8OT+/Mf90jhJ5YO+pSDC?=
 =?us-ascii?Q?g/rmNM+4YYoLw0fsTtsaj8MPgUkAq31+lwKuqFz2yVI8JrfCp0sLfKo+cL7a?=
 =?us-ascii?Q?oELl0SAlY00vg15lgdOkA/cRApKCcwx1mSiJy3zvVfWTPFyn57MiV8CI3iov?=
 =?us-ascii?Q?4Ap+9xXV05RU8/Zn+ko7lA8kYsGQZMrRUsKgkc2ejZ1i1OZgRdOWTbVj1S/y?=
 =?us-ascii?Q?gZihoe5Lt/hMjPOp4GRdYRVsFw2Evzh/mJyRLnWHxhTm5hmlWRe/EkGqFkF9?=
 =?us-ascii?Q?bFf9YEhgK8hQqQChrZ+rW41ILIuN+Uiv/HDJp4FUtAZq6Lz92fNQieGmVseq?=
 =?us-ascii?Q?RME6hRmMwDGeRHHoNajBUZzmvlWP6sYlEr1F+dIbHfwNugC0+0kdT+eLa99G?=
 =?us-ascii?Q?uJ8CeCNncabb9mS7CKiYd+PGLq9fag/o4AcWZ1gKN2VJTZhGWqwSJbKyoSVP?=
 =?us-ascii?Q?sR7GlhCATPcllsXWEw/ecvnc2FjZUEyE+Ddqx5+bkNbCVkjCZ3KtCH3c8iPs?=
 =?us-ascii?Q?Jbn03615eb8LsXm923j71AVOfOw5bXnMVQ4sCSEhRZelWpsn1QfUwW5qa8aG?=
 =?us-ascii?Q?dvcuSyrJKO4HI9B4YbGvZ2YkzNrlALrIFQML7XzfPCaatO7Izsc/pLDuCqEh?=
 =?us-ascii?Q?0PNP3Ay7rtdgN+xaZPLeu7uB7FC0FYw//mD/a4mcmVUVkR2m8QgOY8mqHwgZ?=
 =?us-ascii?Q?pQFw03q9NGKY5R+YyNYWEsbRrezc4As4oVhEMpdkx6o5/QIy+dUAr1qLWi46?=
 =?us-ascii?Q?KL+duWDZgFp/YxXu/6ri6GOU4RMOaWt9Thn7yDi20LpNXf8+sNTzrv8OrFPP?=
 =?us-ascii?Q?7MDh1Pb8xSQ4x1PpEmkFKbCtimYGBIwrJtsQOiU/xbfTNtvxJM+Eg=3D=3D?=
X-Microsoft-Antispam-Message-Info: ePEKZrgr7EXGAdF8tGRynb8S4oOplgzwc88o5/Zefd+qu0b0/vJJ/2iB1ejJBtz/uj1P7Fm26hOVgNpnGDavvv7KME+iAtn9S+2IVSliWQoQrn/mCgj2vWuoqxNJXgDa17VZPBgRm7086icet+UcxhP9X6iu2XyAnn6Ks98/cdPMs8b6O1jwzP1RMVGWw2nRiK752oLOj7UzuqDZtv1th4/mQgdAxrH880gCV87t7NjW69H/fqIgBupE73+LppY2TGVGUzYZzDl/YkosBTOkVPTnqn8gGtm3eztZr0w4t7xHour2Zb70fLjNIXSEpnPx1gigWiB4r2haM+bsCaWvoOC6n0aKYhDVKc7T4c5iyfY=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;6:07oDRI3oL8E493BE95vFf2ZI0a//Ze6WWX9JP6UiNOHPIyBM6NMyE8eVIqeq8MT/GSebHFyOLwzCNb6+pTtp+bAqEUGuYlnOQIRhs7+o+EGNhmnNUVC1w+27kVAROwr8QcKWk0ZH/Z8h+4Dy5WEGnCcFxjX4C2dycEACmo+R9PhnZBnuDBOfV4cjuJ5mgt2oxUBX97kGZwpvhfkJYlMzVyPoYTkxDPszW2uio1/jLRG3Dc65hwx9nOQEyH5+1A/HR8Ix7vRdQSViket0tJ/sqMiprbP023MPvLTflG9GNQTJwcuL/V7jvF+3t+eydKkjTEwXIVnC36N/zmsq5wUNW38QvzNKAbK6tGPWsg27pazjMKy+0Rz2A/IIA+5t4vrIv799vhejJefspPltvpjuIbEhwoMxi/uCxQWykAvh+jhAx6UVTBuDn3w2mZ0ibWuJSsb010zp/k5wo0lG7JTvUg==;5:I7LenqXUJ8ROPBXnVmgi+jKMUWuEwTas4Ws03A4ThL4bTd3XPzCd74blxKTO9iNYnwt2otrtXczcxKsKeAyIu1zGDMyOtojHjOmvYFzQkciI+HLHbukjBEwHLtSJPUDVrLlS9q+f9sEWISDj0wrB0k/bph4hmZ2rSsELW4DIWN4=;24:xFPQQahgflDABJUlX/CtxrWTf3Nh0bKPdTr12ybWYtA0y22y6oBcEE8vpGLTpajDdM7W370xTwCrQH60l2f/1PuWRGHbfunHkAmqfEHbvCc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1316;7:ssh2Buz0kagjpcpH63gikkg/K9jkBz/fj4qvXud2zTBxZHuGgPsqodLXGBguzOWzeOqjb923Sy604RYmqRxcLaFmbeeT2BKCGFtbjyQzHzT1VlsnOM85e7jo4IJbiD9J15IkCDcMGUh/glCcVAHbBYvK0MgHSXBQnClZu+WVu/FoAVnmB8A9NauneL7FkHt+BUog8KGoinPlMSHfLN7JkY1dbvG5ly1ubAE740RrSfyB0m+wi4rvhXII04am7meC
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 01:09:43.8134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 694e20ad-59e6-49a0-e1c1-08d5dc93d708
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1316
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.MX6SLL EVK board, SD3 slot can be used for
WiFi and other SD accessories, enable it.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 65 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 2217c40..1a60c8d 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -84,6 +84,17 @@
 		gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_sd3_vmmc: regulator-sd3-vmmc {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_sd3_vmmc>;
+		regulator-name = "SD3_WIFI";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+		gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &cpu0 {
@@ -236,7 +247,25 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	keep-power-in-suspend;
+	enable-sdio-wakeup;
+	vmmc-supply = <&reg_sd3_vmmc>;
+	status = "okay";
+};
+
 &iomuxc {
+	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
+		fsl,pins = <
+			MX6SLL_PAD_KEY_COL6__GPIO4_IO04 0x17059
+		>;
+	};
+
 	pinctrl_usb_otg1_vbus: vbus1grp {
 		fsl,pins = <
 			MX6SLL_PAD_KEY_COL4__GPIO4_IO00 0x17059
@@ -307,6 +336,42 @@
 		>;
 	};
 
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x17061
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x13061
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x17061
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x17061
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x17061
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x17061
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x170a1
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x130a1
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x170a1
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x170a1
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x170a1
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x170a1
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
+		fsl,pins = <
+			MX6SLL_PAD_SD3_CMD__SD3_CMD		0x170e9
+			MX6SLL_PAD_SD3_CLK__SD3_CLK		0x130f9
+			MX6SLL_PAD_SD3_DATA0__SD3_DATA0		0x170e9
+			MX6SLL_PAD_SD3_DATA1__SD3_DATA1		0x170e9
+			MX6SLL_PAD_SD3_DATA2__SD3_DATA2		0x170e9
+			MX6SLL_PAD_SD3_DATA3__SD3_DATA3		0x170e9
+			MX6SLL_PAD_REF_CLK_32K__GPIO3_IO22	0x17059
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			MX6SLL_PAD_I2C1_SCL__I2C1_SCL	 0x4001b8b1
-- 
2.7.4

