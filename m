Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A3BECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4052A2124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MrjalMXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4052A2124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387891AbeGMIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:16:50 -0400
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:49760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729790AbeGMIQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLF47i6aVXG2xDCbzGOXAd0C4dqRrfyl0IseWef8AtY=;
 b=MrjalMXIAOCXfBlKkicYN3pe2HF8RfMo7yxKoIBP/a+uea4SMVWU4twQ26ItKhTA61pACkOfTWXl/QSIlpDySGGymScMebNdagtLW6isRkmkkgszlse0s96ROPWWdVGJd+7ItBcKP+UMOO66eBsqb0U72jXVjza7TwbsUQqJhAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Fri, 13 Jul
 2018 08:03:09 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/3] ARM: dts: imx6sll-evk: enable SEIKO 43WVF1G lcdif panel
Date:   Fri, 13 Jul 2018 15:58:27 +0800
Message-Id: <1531468707-25737-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6563275f-a1f7-4b31-14c7-08d5e89714cc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:WVgTc0dk92QnauZEp2/Cftj1WRFv/RezcqTyijvdIDbxSwyu1isFZ4m+xZHnZrKyh7WET60fTEXGFFDEJOtwgwOZ0R7AmB9aSr8dE/GVxfXs6yJrx+hyaIoW/VvBacr1z7XAKuli+OLyR+ahf23dsgugJwqCGczg9MGUyY4k3F953uKqVWY2wFjI1m8hzoQEz2puE3AhZtbpSXYq4lJ3tr5TdNlRRv9XeajVy36HW8oCwcTvNG+Jd75lAebljIwO;25:Y10Ss53a35uRR2CrLxqXXbhGhQlTTZXWpauvXvZAd5nFer4HiNQn63MtTmpW5gWjlQ7DfGu7B496aUKJSUwloXhdXkRts6n5m4YdFv1bsJE6h0fzowVgPg5FRUDan/Aw2HR9xxXi71H23cqtHiOYwB5KqX3WnCLqK8WuFpRSleTKmwfqTNx4qLsC4PkkQCKSvYoEbDl6PRV6sBJMPLMVY8urtAgGfkoGq0pOXL74yBO/N0VqrPoj437f522RGg17L2WZ4mRHpjXtrVgILFioLMCgDTZOi0VkNyQ14vWJkFLKWU5eiqxpAmFqVYRwZTnH4yP1mHw7JRrP8odNvwjxfA==;31:JluJuw97z8/EVLjgTVdm9wOFtKXA+tsDB69N3vDKuVokOZwDwuVE/4ZyX+ifcKS85OOTrGTaD+WleCiB9OpiKULkSDkTmFsUAWOw7WxDpD0cSO5qr3AcXGb5SgOJIktxjNByYrOLLFWjqKLqLG+bqKNjwHjCL0GYzsF7IPGWVj3IQxSjDqSBXaYlTXAmYtdh6sAR+vCxeeAwKzWarDACPa6MUAfkJ7/XUHMOZGyeKn4=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:LCmpbHxbhcij+wfMMvnoeMOISGkLGdUktGWbVzpUqeDvspC+3DgzaQZKLaW+HNVhBIa6b9pdYfcv9vo24rirj11pkr0KqpueJq3nPmXUL/6eibd8NSWFUURvjhK9Z+muhuNEpiu+dFx+KneYiALTWROFOXo6h+fM54JQ/zBJ1f5q02rk7uM7V/RyDRakWhTyVIasi0IyO1idlAdsmhBrcOoBmumYcN9zs6vBc4KNwuebE1L++WpNZ2LxX3JexQKv0UvfDIxnGM6d4iQXfGLkl41hJCAvVvq8rIyBsiEz+vOJ4Q/92tixOIwrMxdWMiQ9LPjzJbWuBmOcNLqTyOY++RpCiTlnlWNIfS1yQSpksMTy9Dd5V0Z9rxwsitRZFUd7r3DYmf+7lzvJb8fFp8WhfBAtYyu04a5C58BuCLNXN1ZwStC9fp6L4O9fhP217kO6AxzJS5pVGqydtCDKXOyAbCTVA6RUuhbIkzVDCuPJ1ewZf1hJm9s3KcMgU8EA4Dam;4:g0DDdzD6BaKf6ljlh4CUXusMR1N8berzZV7gptmUCMfZFYo0GDOhryJRhB614Yh3xCXKwnXmPo+nGOHpfZNJYssEbuaf/1Xk879eHckth+YEKud3MTtQ8evtWWRa5haLxMSdAqEj4T6PtaGYBzbUHtzKxwu/oAojba2CIq3aw57VEcgtoZYwC9B4osnViZe4eork5ponvvmtKpWaoVbPseLB5QtR7JPZFcR0pcnOfDQwwUNIUUZG4wWgUOAqacIjmWRd13uV/FmThoZeNbaHv/W0/PtIxU1sHcABGhTMpoLMynreu2IGNN/e+b7fgp0k
X-Microsoft-Antispam-PRVS: <VI1PR04MB132710D369ADC697EFB4146AF5580@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(366004)(376002)(189003)(199004)(25786009)(305945005)(81166006)(86362001)(8676002)(97736004)(81156014)(6486002)(316002)(5660300001)(66066001)(68736007)(8936002)(2906002)(16526019)(7736002)(48376002)(446003)(50466002)(4326008)(6512007)(52116002)(50226002)(16586007)(478600001)(51416003)(47776003)(476003)(6666003)(2616005)(956004)(11346002)(36756003)(26005)(76176011)(186003)(486006)(53936002)(6506007)(3846002)(105586002)(6116002)(106356001)(386003)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:QRIglBDUFJPOIaGZ4Bffa5K1qNGCMdZRzyCqjt72Y?=
 =?us-ascii?Q?zXpozXeipuQLVKZ4tAnqmvWgxNkhij2m43vIcAj61QEfD4MHAy9I8HQaWdld?=
 =?us-ascii?Q?ZtcgAnYmiz8CQef2RVKiGIwPZpGdoQsbsvF/ycfHvVeOALmG+5yKeIYt8fT/?=
 =?us-ascii?Q?QigZZFNy928KAXgOluI4kSF/ioYXQvkNpQ6fRSOiJayTEp2tYrWhcPFE35BS?=
 =?us-ascii?Q?H7VEOZyYpX7Hadzo83jZlijnNEh7jmJbmiaBF0peFXW4W79UAd3+b03wlwuZ?=
 =?us-ascii?Q?G/ThDOHWeqMXM0Zxu6M4u/QWUTvdGEkXKezAH2XMAbVnxOmG25jtqxUhpdym?=
 =?us-ascii?Q?vsNzLgyfghyVOQ9km0PEc2n/e6TKl0+Bl5h+qvutmzikY+PLc60OjmuIxgYK?=
 =?us-ascii?Q?dQz93+e50j3sG13l5Co+fTr3PjxmhrsI9o+6L+vMJCqa/3u9NP4olTfDJclG?=
 =?us-ascii?Q?T4eHv3eJpoGN56RBhGde2URvIEMfPZkg3sAIgkm/7OaE8y8hnGWEnja9VzqQ?=
 =?us-ascii?Q?jzwUqRLZZwLL3+PD49lBBWsneNJBFGbISzBbNjt38wHWBaAwT9JmOmvaz/D8?=
 =?us-ascii?Q?HVC8xQeB4ztV8kruF18S0tNzw3d+i5f4gSPRYWZhZHpzKhr1jjEMO7vhkKve?=
 =?us-ascii?Q?aGXFbUKnfiUto1DEsyKTaluIK8Nn4j9ZZh8A4ZilK76l2hITBANe89Ds6HlV?=
 =?us-ascii?Q?gtM37uN0nj0yEg/2+K35V34h96GJkbt4kZPgZAw7eDfwfBZyQiaJEdKG1FOd?=
 =?us-ascii?Q?Pbp/a2jYz9TaGcJ3y6IUKO4W5H0l4x7x6pJRxzYnAbGdYdNDH0++Q6BP7KMQ?=
 =?us-ascii?Q?GyAuoy5/2EnqCqZyBFpMI/M6bybcEooG4hPk8WGfsNaPCvERgVjVtkL8Ruo6?=
 =?us-ascii?Q?FGpQ6PV1fdD3XrOL37xLG2sQqsIpeVfIO/hlJPWbDGunfMhUZYNY3wHON+x/?=
 =?us-ascii?Q?CvbK2GCS5RccbPZcwWXUPFgIJTdyJvApudvz0ox93Fe0tZLaxJZO+6NepMS8?=
 =?us-ascii?Q?iYdZNMAv8B63d4jyfqx+OaYiLHEt7jbMThPdvT5FtTXrF1ft+o2wqD9OBhwM?=
 =?us-ascii?Q?zfQvH5aa4rhwyC0572Dbu297BpJeB2wX/hzVayhHRX8CaWOAXb7sPOPOMBCF?=
 =?us-ascii?Q?H/0MJXVEB59ZjPlM/Hdzp/3HwpGAHC6SjBhvb0jWZRiD4cTdLrvQ9msSW7TP?=
 =?us-ascii?Q?OxrB9xqVprSQI4fPrc3WjI3fPUYMosyQ7NvkPLws5G64PpJXL2qkhq7qA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tN2pae6E61Xh8MmNAXtqCuOL9WiLzJtPOquQALB/gmYBKBWJcM9vYtJMEk6GBTXQBe8KnXuS7nyjOdBgRMtyf70JbW2vqVzsn5M7WzN2kvhg9upNQ65UYzrqF8fRSDza3UaujRhJIVG+MShCF+FXBJQ8D+XgVYExY0RZ/EaWITeBmztk+VNcShavlExtX46iMXhhgJcumOVemJyMOXrfypjv5UMDOmbJHrzd4wrt+5V2lvo4VTxI1a+uzLhb6uaD+dxY6km7/i3UwzOC9/s4b4FltYjM8atcxxsre9Ot4GQN+A8Bzq3G60FqH9CdEtWM1CmhPVGuVyClvAyVlMDndMyhCptJ0R67R6/O00vG8cE=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:dj7ZZSnVh8jEyA/rcqhpo5WwS6rOLw4RoqmmADWp26G7Ms1ISQS3o/9CREfn0dkghySUQcliKw/F2YzCkqoNQVnLnrWFwzWoex4kq1lM2WhHJPqBFKvgwBDFOkrJEOnlLv5NdB4F975AGj9JBcovp2t32eK/VMrbEcVCjzAeSkB+xXWjsi07JMmxfddJH41bUswSj3fN7YjfNqui3MA/r3MZOmk7DLos1T5j1ZHHpvl48ENFwoPnkkKjQeMJc0hzVzwR9e6GBWhdpwhpC8Lv00X7a7aLZfwJ3/UqYO2MkAge6cT+mZLRaz7LsGZC3pmb3Uq7djuXU7nR5THwF/NOkRoXFFjCi8e1nurRk+KutMOGY5c1TQZ8C1fc8UHfoP3NNN3gq9TgttL3q1cKm938vURyi1LMPujYuWEolYVz+gxj4kTN0C2WvaJPSIyQs85HKR6ez44P6fv+QUmWmQ+7rQ==;5:k6kV80f5C6W/CsDcdedwEKvgEGeV9945NgIw+eYedkxEiajv0w9biskDl7L7sYjbJ6f+L5RrxEB0eBpQ2niu8Emiz+/n5QudFtWSSWTlQoDMjXP5FzXzcbVautvYWYnXX6CakgIfYm9Jd5ZxY5E4z9/LhpI9Q3r7EHQg++I+oRw=;24:XAUvMm47269IHL8bEauUuE1jEC32iI4eyouTgqlJtOZ6ntYfkJTY7q3eyRdJeJlVrFtNwBx3kXwbtjYC/DwvJ5vhzqEWtk7eDFNwOyAl504=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:hMiVgAS0v/yHX0se6xfVe8jh9jW45zT2Zr9WqhdW7y/YqGLP7HoB1CCKIEZbVcnzrK1HDucTOMpRtHI2yy36FN+5TIz1fsNN6BlHHaozxcdBRxyAwD6WGavB+8LyJ4mkinaDYl0FPB6ql7ubhlohgU/RTUvQr0AmJ8ULv6MbMi43BfrfdVTWNU8lICtsdaIjrIsDIQmj16b/qMjOf4c9Vrv9r2zfnfi113ZlEQ2OEA0tm0INRojY43wxSfrUXZ6V
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 08:03:09.9210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6563275f-a1f7-4b31-14c7-08d5e89714cc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SEIKO 43WVF1G lcdif panel for DRM driver,
add necessary properties according to SEIKO 43WVF1G
driver's requirement, such as "dvdd-supply", "avdd-supply"
and "backlight" etc..

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 76 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 71 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 41e87e6..dc34da5 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -23,7 +23,7 @@
 		reg = <0x80000000 0x80000000>;
 	};
 
-	backlight {
+	backlight_display: backlight-display {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -69,15 +69,22 @@
 		regulator-boot-on;
 	};
 
-	reg_lcd: regulator-lcd {
+	reg_lcd_3v3: regulator-lcd-3v3 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_reg_lcd>;
-		regulator-name = "lcd-pwr";
+		pinctrl-0 = <&pinctrl_reg_lcd_3v3>;
+		regulator-name = "lcd-3v3";
 		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
+	reg_lcd_5v: regulator-lcd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd-5v0";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -99,6 +106,19 @@
 		gpio = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	panel {
+		compatible = "sii,43wvf1g";
+		backlight = <&backlight_display>;
+		dvdd-supply = <&reg_lcd_3v3>;
+		avdd-supply = <&reg_lcd_5v>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&display_out>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -213,6 +233,18 @@
 	};
 };
 
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcd>;
+	status = "okay";
+
+	port {
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
@@ -287,7 +319,7 @@
 		>;
 	};
 
-	pinctrl_reg_lcd: reglcdgrp {
+	pinctrl_reg_lcd_3v3: reglcd3v3grp {
 		fsl,pins = <
 			MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 0x17059
 		>;
@@ -388,6 +420,40 @@
 		>;
 	};
 
+	pinctrl_lcd: lcdgrp {
+		fsl,pins = <
+			MX6SLL_PAD_LCD_DATA00__LCD_DATA00	0x79
+			MX6SLL_PAD_LCD_DATA01__LCD_DATA01	0x79
+			MX6SLL_PAD_LCD_DATA02__LCD_DATA02	0x79
+			MX6SLL_PAD_LCD_DATA03__LCD_DATA03	0x79
+			MX6SLL_PAD_LCD_DATA04__LCD_DATA04	0x79
+			MX6SLL_PAD_LCD_DATA05__LCD_DATA05	0x79
+			MX6SLL_PAD_LCD_DATA06__LCD_DATA06	0x79
+			MX6SLL_PAD_LCD_DATA07__LCD_DATA07	0x79
+			MX6SLL_PAD_LCD_DATA08__LCD_DATA08	0x79
+			MX6SLL_PAD_LCD_DATA09__LCD_DATA09	0x79
+			MX6SLL_PAD_LCD_DATA10__LCD_DATA10	0x79
+			MX6SLL_PAD_LCD_DATA11__LCD_DATA11	0x79
+			MX6SLL_PAD_LCD_DATA12__LCD_DATA12	0x79
+			MX6SLL_PAD_LCD_DATA13__LCD_DATA13	0x79
+			MX6SLL_PAD_LCD_DATA14__LCD_DATA14	0x79
+			MX6SLL_PAD_LCD_DATA15__LCD_DATA15	0x79
+			MX6SLL_PAD_LCD_DATA16__LCD_DATA16	0x79
+			MX6SLL_PAD_LCD_DATA17__LCD_DATA17	0x79
+			MX6SLL_PAD_LCD_DATA18__LCD_DATA18	0x79
+			MX6SLL_PAD_LCD_DATA19__LCD_DATA19	0x79
+			MX6SLL_PAD_LCD_DATA20__LCD_DATA20	0x79
+			MX6SLL_PAD_LCD_DATA21__LCD_DATA21	0x79
+			MX6SLL_PAD_LCD_DATA22__LCD_DATA22	0x79
+			MX6SLL_PAD_LCD_DATA23__LCD_DATA23	0x79
+			MX6SLL_PAD_LCD_CLK__LCD_CLK		0x79
+			MX6SLL_PAD_LCD_ENABLE__LCD_ENABLE	0x79
+			MX6SLL_PAD_LCD_HSYNC__LCD_HSYNC		0x79
+			MX6SLL_PAD_LCD_VSYNC__LCD_VSYNC		0x79
+			MX6SLL_PAD_LCD_RESET__LCD_RESET		0x79
+		>;
+	};
+
 	pinctrl_pwm1: pmw1grp {
 		fsl,pins = <
 			MX6SLL_PAD_PWM1__PWM1_OUT   0x110b0
-- 
2.7.4

