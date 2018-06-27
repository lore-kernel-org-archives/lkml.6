Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6B9C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF75265F2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cs+NMjyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF75265F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933651AbeF0IlL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:41:11 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:35191
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932234AbeF0IlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhwTbNuQTMysHrzRkDBA5UWHYXq2S3eg5lTu9Uu0Fl0=;
 b=Cs+NMjyoqeJaM4Wfh54Fa8ug0vBi/iRjSHNr3QtdOQF6T3664ipEUP5jOc5x+yrEhr6S6itNn1Cr+tmAjyhYvIQruMHJhmofMiiQPfuaypLOKvsMrHwtFj1zOnFPgo+g/p1ciCu90e3DsYXzawIsQU+oqxAjhupu0OkffVxyJMU=
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB5PR04MB1319.eurprd04.prod.outlook.com (2a01:111:e400:51cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Wed, 27 Jun
 2018 08:40:57 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6sll-evk: enable usdhc3 slot
Date:   Wed, 27 Jun 2018 16:36:45 +0800
Message-Id: <1530088605-9264-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: SG2PR06CA0164.apcprd06.prod.outlook.com
 (2603:1096:1:1e::18) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cc11415-de58-46db-1dd8-08d5dc09b5d1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:HDfmlzGwO3hG1ujyF9IkLgOPDe69hrjnXdglQrNOfoDnqjx8dPQ7mHOsTE379vaFqyPrRH1fQUtOLdYQUCOtXrS519EYn5M8Eb53eX0dgbGvE24lwnATH/x9hEeZrGgp1t3EmeKfSBqiSbXpAurcHPRfDzXTXQVzR4JCnd3d147rcdSMuPzMsmYl8z5xrRswAqJAjkUVULGH3FaRMCxIQ3DOV5qvBX6UNLGOUlnDTPTWZSihKzDLGWI+aegqJpRt;25:gQBx2lxWDccmsO3aZHlenb28EomtfPuQTq89xJLMvKI43gLoPG2QKbpUqP6OUUQG6n8sAqPkvc31oUqU0czIdfROYiZJEqDK+3+IvJ8TwMJDlv2WW9nY40SZlQ8wDtQihfAANGUwg90Gj97JjHyCd6uZ6va6bI2d9wTOliYhxw5vcTL8+olfX2kIrKUHKxD4lbRn1GhGfzmYKjvA+/a5UNXJ482kmWIQi6MhkyhzbbuuDYKfRCdRf2FkcpYvJLePMVDKx9gi/KhGJ/xZwhkbBd++jYczqKnPvLTnC72nvWXlxl7Ez5ml6viOnICfkUbriPEci2EXSCDyo0Lcn0IJyQ==;31:oviqZ1YMJKYlvNd0C5nFVq8Cqc6RbYD8bV9ghgTEZgOUSRWc3FKQXC4sr9OTppzF/uovG7pug88nHdqAAwhe76hE46eSMxCy7tfuwSiEVlGaEpeBSBuk2l0gXUsFT4Mra4AVKbwwHq58++0Gm49ezdgLsk5emwjGQNadwQIBBqCW+OG4hzJdk5HwyujLNbmVpUPjB/l3TsctEkcmPyuW4mE8ctF99kNMM+W/DO3cfKE=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:7LrfY+eh+aE66N5h0EJX1sjIP82Bm6yLuUyJJQCtMMhT5XXjKdwDQb2nOx2Mk0xiL2E1DV+WmRcw29VIy+bNNLVTmSJSREihLiVm6tDwO7wvAOFeTh6CFT189CenEAEkEe/a+uOqB6UbDkzvNiiqCKk4brNaSB2DrfEMTQ9agjccOmMMiWWPQFpcAclyUjWFrJ3b8vp6ZnBxYgKNARQirl4mOSQIYEJYxz5gUXduCrEeQA9VwmNN0oCAmEOF/petW0jvBVBb6aOS05lQos9xmNVSSaA3G3JQcYK3Dq45RzH9NgXVrrdGqZMKHJYYYuRAW2wEEaPv111YzHdDx+ATnOgPpjfiCsX2DxcrK2dQ4O9uTiHKJDX1FT6mHZSMwKlnzGATmtSgxNz27Ao6kfV9a78/VXMQkmoscpTE3N+4W6pXMoswN6mA5ULrOkNcucqt06Ia6Xo95fUpp8uNu5gyxWzl+iBNzVe7NrU/5EihOugdTUlai+pxcHZyLq7Fqvwp;4:vjdQkXtpUGBwO+rQcYIz5akPpVSBalHZLvljrCsKCUSgzNX+Y9bbn8VayKRAb5wRln8d9pAWHqBPAnumAOCc5y3d1pRJTLmRBA3TZfpJoSok9on/zhMvth29o7Rer+P8ZtjNAkzWQKE9zMuafZQ9X8YHDC7qtK1aRIKiQ9jki7NlOp497lMqCTVWbnhKa6FcdN8Eo5W+GcLneUN37LSme7USidzq1IEzPyyvEDrUsXTxy1YI7paAB4a7iZ25c/hJ2sm68SgocR0SUvQ7i5z+N1wkocRv+SWH6rptG+E8/iklPAtJM60lxMiy3uEz0k3Z
X-Microsoft-Antispam-PRVS: <DB5PR04MB1319C17EC1405BF12203D5FDF5480@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 0716E70AB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(47776003)(6512007)(52116002)(106356001)(86362001)(575784001)(66066001)(316002)(105586002)(6116002)(3846002)(51416003)(2906002)(1857600001)(6486002)(5660300001)(26005)(16586007)(386003)(6506007)(50466002)(4326008)(48376002)(53936002)(16526019)(305945005)(478600001)(6666003)(186003)(6346003)(8936002)(25786009)(68736007)(97736004)(8676002)(36756003)(476003)(2616005)(956004)(50226002)(14444005)(7736002)(486006)(81166006)(81156014)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:Dt63xUm9SlCxFr/pa5+eWPrbSZiQET/7z1k8s+z1P?=
 =?us-ascii?Q?yTL29TLHVgjkSsih6ACO4I25VklNCWqhFdWlWdLTRCsgUb0Kf3a9iwUtRY2G?=
 =?us-ascii?Q?iqULpuFvDDRW0AR8zxWaMUJxa9J9gHSM+p8+gfFYdv+KUYkSFyPIZyigPcW9?=
 =?us-ascii?Q?inPXssWJUZSPTFIL4UFd/NszTHpl5FlOLlLl6Nryv4/rkecJr8GaVjsR27fI?=
 =?us-ascii?Q?vbnyQLB0uuDp7PO+0G8NeJUoZaVV2Gs+otY7QCxfsnXh80VTUnTFpMxL39LH?=
 =?us-ascii?Q?orzSf87/y5C7D2t38PTuI52FfGfeVi5WpNWdUKE10+G/hM2BOT8ogbBZzX6m?=
 =?us-ascii?Q?3eKPfTbL/wAqpBZwC8+7PDynzhmHqFbCj8OcTygIn4KGOu6+jvvqPJaJoZ8g?=
 =?us-ascii?Q?wmXrEwnuFXUN/L4D5Hxdt9QY+okX/QFz1HXLbrW1s/YGCITqJ93S9pEiA/z0?=
 =?us-ascii?Q?Yd8BA/qf+ZeJNJnos39YVfM1N5HP/SQ2Ndu1H5HXHv3bOAP6cZxq9L1rGgP0?=
 =?us-ascii?Q?bNDOlyB1XjvIHPPXS11jCEsm77GHeH+cqDNOxLjQ5LdsMfyN7t3VM0UpLsoM?=
 =?us-ascii?Q?Z4Vifl3KrgHJc0wXpqJKmm3cLnA0Cm56IyftyDUrpS3A8gXA5TyzoRJHX4Rg?=
 =?us-ascii?Q?nHG0C8nm2uuR50YpNXJhtUAWRwCI+EFrXUWxw+ooYeNwcChorjZLFm8EUQ4+?=
 =?us-ascii?Q?w87XbuKZxDzQ3Dvcqg2iGOitLI//ty4f4sfPRwetujstQHTc/4EviQ95e1Rl?=
 =?us-ascii?Q?VFD92Gu08al2I73FqC4UtitN1Ekgiw8oMlVe6VOiKyUoVddhJ8YQ4C4Q5QnK?=
 =?us-ascii?Q?23JV479nO8BCpDbvgFSTU5dIQMzX2ppF2JEv3qd4EQMdKzs8pfoR36TyGP3v?=
 =?us-ascii?Q?rGrKV4mB5O93EIPmJuKUg2lKTMFmW6gr3kfSk2meKwpp05VlFMYdkJh68kzP?=
 =?us-ascii?Q?dNE1T6Y6cOeQcUr4EvXI4+JEoF5AnuCCpx2x/5u4XodNcD6RcySFddFYG8bE?=
 =?us-ascii?Q?fitKep5hr020z+pr3GYZ/7xtlCBhFd9d3jOQHe/oScX5GQW29e9jxSF7l9fp?=
 =?us-ascii?Q?mOKSNW/DotqRHLzr2EUznwbg2oKeWi9+t0GOjf9Vq+nV/QzallkR71vbcgXB?=
 =?us-ascii?Q?8UnlRyb7IL6+ho6w7FqIwHlh7e15IxizMWfTuuEeSVJDygzkORZAMjKFLMNx?=
 =?us-ascii?Q?iS0wIR+SDDTU8/P5YHcnibcnOfaBcwlLqMFHefQ5HTO2RV3PSOVADto5g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: KMnkaWhA0sTvHSIgSszKen30dA8pPqlNLhB8kexRCMIsHvrvet/zbXAVnbFZElvO73qk2ZwijdQsFEFaslTDirV+oD7yKsMTsk90WIxNweZLPr+Gfj5DdbqaScNh7obtrbLiQwcJ/MqO4TvpxsLlCj2D9q1s4cYqK1amT1eWwsGiwz4PmfZyozKiCv4DPGtiY8KmKyCIzCrNnQY01YgwMkazJd2isq0gyriGaqnesfBXPqZRD45vs83A0Yo9auHvydqXM3LM9RtvBumnXPDBdJTPGrh64RBcPg7uxK66qHMAljbd8nLi0h1UsGBhuUuOEevKtYWWHI7y2WTDOKNoEU9AP88NsgaUIZ2iMiVLubI=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:l7DAw89YxDWpUmnN1ihitAf5Jva4TFI4KSr3MYhzbPa3+mOGTPktQhE8NHFXm703IfBbvxHTKq+QspoPKJpFx4Q28Z/iU0W2wYtT78CmpYWjKSSdEXTEslnkMysRPn0Fw00b7M9qFUEzxYfufPJoRuecvDhiQmnKv1A2oRQFDFPZFO3WFlWQewMffMLpaziwg1+bfRUC36UPNT42K8O559oywoUzmvHKFKDjsuAshYEGLD8yt2DcbKWnwnJlsJdgbqZ4W+EG/ZdZckS96CFnRKqdPG7OFQyCrASceSCKlPQuj+ed+gELb1MqocxWEF8K71IBBztumVvRQVwKlUgjBtzGpBJDuXCxSZUz5HLL12xLl8Mz1NhgCMM9jeUXUF1BnAQamfOnwSXqGDZTfI4SHgeQOkaWrSNAWFq+2mdLXQ7RdVCiVUSS9v7ta0wOUCT3DpTMsBwkZzA/TgsuSo8XMw==;5:OnL9pM5xJO0OhdifSwyoNzbDmtaqZsXajTnvb1PMA1C34reJftcrOVb1sQVu18nLdTbxpJ+GKWn0VDiMo+EJVsiqNN7JxSUxeeAJAAUnqxZgZREIEv0m1V74rTgtDgXnwmq58u9OjVFnjKnS/WlRTdju+IGv9j+wVa3a3fOWh0I=;24:mpSyph7cBRQlCbtBiuBEWcusDW+jfazR3PY0SSrJbbAISSOJGkVKk2cTGOV9CmSCFZoLLHmQ3e2oxc2onTx79F/rpxXtMCm8CcjSEL0oHqw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:fYC86609QRiRAbPob5XfxVpIJgdM76ZN7OwRjKhxbrn4B57g8Cqt+0aB2YVh++oHe+wgbT835ZOmyMq6TwJBOaWNpC+Th2hoOAozQ+2OMhFPcV3Q3YJEK7XLBxJwBWCCKtcnNydVRjxxYiwXqO8mhpez0CGXcCvKY05iAWyxGGfMVenpdlgHEtz5NGWoLfRNtIb5Wkz7YCDqeMxFkyb5eIycXksqPxz1vL08lgIhlMBCp0aYpEOd7OSz+sGWAelN
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2018 08:40:57.3363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc11415-de58-46db-1dd8-08d5dc09b5d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
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
index 2217c40..9013f03 100644
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
@@ -218,6 +229,18 @@
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
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg1_vbus>;
 	pinctrl-names = "default";
@@ -261,6 +284,12 @@
 		>;
 	};
 
+	pinctrl_reg_sd3_vmmc: sd3vmmcgrp {
+		fsl,pins = <
+			MX6SLL_PAD_KEY_COL6__GPIO4_IO04 0x17059
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
@@ -301,6 +330,42 @@
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
 	pinctrl_usbotg1: usbotg1grp {
 		fsl,pins = <
 			MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
-- 
2.7.4

