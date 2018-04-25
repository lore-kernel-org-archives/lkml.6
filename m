Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751389AbeDYDfY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:35:24 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:20256
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750841AbeDYDfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:35:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Wed, 25 Apr 2018 11:30:32 +0800
Message-Id: <1524627033-535-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
References: <1524627033-535-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TYAPR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::13) To DB5PR04MB1317.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1317;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;3:4q5ZS8F7ijaPTSrpHNDyhte/1znMXtsf4rOB/ZZ+vgtwsCKp2CP8tCFWUiuzxA084dS5AYQlLjUAszFGvIu1PcWQK89TKrIU37554Fouujz/GdNklFJkmlo53q4lvvZqNOnXkqfzhDmtC2hbVKat/hAq+stShotWoomNEnLZtZSQCwyvv7S1jwwvmFRTKC2Qjoeunk4JtciT/G6q96ZKSmtKA1XPAAO5p6Cts3ylE/qtcVXAMbXxSQcFvzYdxst8;25:8t49J5afT4vCxkAdpdrcVRAPNQPBLlLrWZVROihYBrmO7NmMoVSvoK+Asep/Osaou1JWeY+36WRmS1S8eM/VnNRuX1jRxDxoddbHdEhS+TesFS6DWcvWMgbk2ziANujXbEJbvSAstU44obRABR06tG10EnyRXNHTf6pjp9cd1htg5Fo+lPVhcWcZ3GF/MrgZrrPIJFOYHFJp7S+QUpbjhY1hPHb3AimuE0Y2Ywo+qvX9essF4aORJeYwFou79tALNdC8Jriomcj/7HZr0bcqr7HxHlp/RP8W9QHUCRmyhHn2M7cPaoWmCYENvbKBrOsR4GgIXekFiG3oa1myCYZheA==;31:7RN5SkKtZ6cb9pFriLJFzKlFEf0+VZ5f+uWKDlB02PnmxZ6dcyMiOjqcuUM3KAOqa0YlgK8wXWQKDych0X22vhvuCYZsP8C/mc98qdkotx0bPxqPe0XQFcB5oDKrbEwJQzkYKkUiEUuydxI9/msRiBXo2m600VCuuXd7Y3FSPDMcFHNgEC8wc5eoyPCxaL92LbkreMpxUdlVdBsP+TVmoYLuaxeHy3R/WF9EL7FxfNA=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1317:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;20:9xvyOfGl2IngVzvZWsI2jh7iwUTXtQ8FaR92Zn+7HQ4lgviU6nSe7lYRL6yr7GKD7MtMczLNiN9zFmW02dBRhpWAt331AfuaWxCdQlLm4R1wZRn+c6PwyVk2mC6ZysNkaGaKofgRsQ2bUMMu6N5GJP9DLIF/IquJOXE/9nWj6ZIZMIlkM/vcIv+jvhuHEsl20D+FMvK8bVkKXrrvMl9HHKBwiVi2VFtbC0TxVqXI+G2vFM3Vdboq8kaet0dHym7m1RUJW9OVzcjKhCv/cLDYV2aqxLLj4aiccl5RNEaPfyDx7atB4B84B/AoACrpu9cMH6Njc1kOrfvTvCjn+15sF8/HljRHDWup6oVP5g8wQTG4TwjfkLXoZTx4xKK0pU3rXsud0UDo7ckoF/7WkWAui8NtsBuCyM5HG/GoBvRpDuPXS93BmZT+W5EkqqeZH8aQ8PF9Co9euJ7y5AxtpzSJOR1+FjX/vGsD7U9dGJrsXF9PNVPxN56yEF1Org4PUp0x;4:AFGmx1iSF9/vtk/Ty74Vb+owEck0LEdMc9xXW3o0R+VDwBbHh2svDlYGb+rlo1XKmvO/kGQTESMMQa5lcnF5VyzIO+zeTIY3Oua+ksMYts9x5OKpdhMYW5io3u+1GsqnXG8482qr2ohG2sT0nlZDi+jjBQfXsmD7Ml+56uqdTofisZuHKzpd5hJB6xzNzwrYU9wwjAdwTsRozHhyobzp58UpaUgANKP818NAmzYtRW+V6CFdhax1kfKS+qa9t2aCJArt7sippMPZGTeZP/kYjeXa6x5UT1E2VOut6sOL/NzwJFazhzvLGa7DNPK1tbgL
X-Microsoft-Antispam-PRVS: <DB5PR04MB1317FAC2ADB544C163C12018F58F0@DB5PR04MB1317.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB5PR04MB1317;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1317;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(346002)(39380400002)(396003)(199004)(189003)(36756003)(478600001)(97736004)(6506007)(386003)(4326008)(25786009)(6666003)(53936002)(6486002)(6512007)(86362001)(8936002)(105586002)(66066001)(106356001)(47776003)(68736007)(48376002)(81156014)(81166006)(6116002)(50466002)(5660300001)(2906002)(8676002)(11346002)(2616005)(575784001)(446003)(50226002)(3846002)(305945005)(7736002)(476003)(956004)(16526019)(51416003)(76176011)(52116002)(316002)(486006)(16586007)(26005)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1317;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1317;23:VFDqKWHMjiOU0n55LKpXUkJTxSPKpq2w59gaW1z8N?=
 =?us-ascii?Q?mNITsY/qnKEBwpZz6vMXsEKtzZ6zD+HiL0dr7nYVmVuJkYKisO5RMgFkpJa3?=
 =?us-ascii?Q?DK7GFOAePnsjhuwSHbh+KKlJOaMNg1dAxT3mSipJ8rFRpiLfcxK4FvKNzzCN?=
 =?us-ascii?Q?+NfuvUYFf1dez8nzf4Es84y8rh06Z27HSl9q7aFlqHrASBDI9KOS34JWVFlR?=
 =?us-ascii?Q?/DZ9+JEL/yoqUJBjfzAHmzdB27OtDLUKv5ZBAxAkSW2zaxKP3dS9j23vsKDM?=
 =?us-ascii?Q?ArNELmiAkSyPjSaw3ykiaeFxZBY2bckqyIoJw5q5Xab0VTzl2kt4abAXf1H3?=
 =?us-ascii?Q?Sev6wOsLNrGAzqsdt6piX1vWVHtMgba6aRJIFJPu5WRMCCWT4VCwt4CxSous?=
 =?us-ascii?Q?tVJt8iCkjf3isdt/cmJHodx0z7yFC5/7bIVz7Y+i3SzzlHZzleIGtzDylh+L?=
 =?us-ascii?Q?0azGJEoLx8+8rTqobKPTa4qH/q6fKr5M04ONEi4IbxgQ8bSHc2GaMmVSVJ57?=
 =?us-ascii?Q?Y0XYmbi/y9DlFs/7r+Ap6ziUphdUJ1c6lKuEPKFHPIbyIccZadapj9kxR3uz?=
 =?us-ascii?Q?as7XptZGoCFRK1Iktwosqhx2+bkhwRv5Aop33IjInYGGkjK51L2FkCOzH5eL?=
 =?us-ascii?Q?moeNKaOupWcSWL3G/QM0RVkE08wV03QRrjrtNg6GGwLNPKa8g5bk87QVuyp1?=
 =?us-ascii?Q?NMJLRDbS+EIHqlx+08YPDvEINJaVHNL5hnedvtoygREqBgrZNB1fL1MRC+hp?=
 =?us-ascii?Q?MFShWWMKFr7/Smjb7oOhTdZ0v2DtCWuXPrdmN02R27U+eoMnOQzyNHUOY9PO?=
 =?us-ascii?Q?4fxSgJp9KWIN8kMluX2zap+yfKcrKh4rHa94MnoPZA7aAAj5/rvEA//wT6gj?=
 =?us-ascii?Q?A+Sz7GkaEquTuEklWMnjxmJ9UZMvbmycPbGociqGZm4s7LaoM7Ylg6JIGNSs?=
 =?us-ascii?Q?PpZ2qNeqHWxWZjE9emba3q6c4ssGyo+0E466QM5RK5dtNOXnqTnAPmLNEpSs?=
 =?us-ascii?Q?KeZwgYqNUJBrVrhDjca1/wnfZZVtPydoo48na6gCLITagko4+WTJtCZAHhFC?=
 =?us-ascii?Q?UEyzJC7U94XXH+PCSM5S3CHX0xIxGbwtjow8qPza19xuy5Gy49r6hZg4kXlU?=
 =?us-ascii?Q?Uwu64ZjQwLeelLICDT0ZbVIosKaSjfb3xDE6rVKQ97d/o0JS3cNah6jXuuPP?=
 =?us-ascii?Q?JLL73lDHhx1k3dASMFu9590Zrof+eWMrrAjiF2OuzdfCJBdD4GAACp59g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: MB1GJaaVux5caa1edzFaVB/KsbNy4Ar2K/Wj4QkZIBRH58EXv32SGQM/4dCmBEh7anGo0oilcjdKRPVKsblNHA9PGfBKNQ5yPGHdPTX87SqoqbXbb/3JOHBhTnT0x0QShgzln0JIP9CKhtv/OPTa+TuFtHP2Um6x9lITBG+qlsOtIe5fWz/qE/NGXd/GjviW
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;6:/d1Vb+1MQRxIPoqMwUOwpcQHMi8Ok3sOOowT0YlejYvd0QJQN8rOCOT6RNizd8EciZrUiPCm1jvQxQYtQCoDG/G1D4DHlwVgsdeJ28XMsg5zqMplh1+dISqGdonq/piv22CvCzCt+/0mEYrqr04Icd2B3RZ8L+AATvjouuWyCgcaDrDGLm2G7rozlFdSBcdIsPAtUfWWcFM42t/1do9bv1VKh/JM/VVpH3g90F+n7htWjCybYZAzQWINhbZD8xPyY5sfjyTJMiM6Ukc6updoOZrrmhpg60ZNI4nISPHHAYjC+2PWtkCkGbqxX6U/c26WRp5lUaNFrLecYfsdAAaVODanHk2DvPpIVu+Kh6JQLXdcoEkFRAMakeAyqPIVKySYwNPA7XNaD6MH35MDCjAhEJld77QLfk1ONHRg/+TR69u4S18o19uoJGI4Z+TejJi+Ehvv422M/RjgsCo+urMs+g==;5:Fy+v8Z3Hnc6BiYzxvQfDFaXWYVsreDOo+kIjQEvnKFrifNTP53aZ719HEGra6zGk1lov9TREzV22AA9EtodK0UzcTKlIZVc0gpy5DCybbaZXX8kM6bDMfVkQ4FIl3OBm3HHIpCmyA07f3EU4W+zEIWA+AQvoKVeN6aC08LfP3SU=;24:3V/c1xeJeqoRZ2IDOoc9Z4RzLp1k5ttpTP7l7rFv8/kYxR9FjRnwBZOmlFNQmNv0i3V/CCC1lTMIH/IOjFqDxPB+2uGJHwZpJ7H1DqzVNW8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1317;7:a7qqCBM4Q7RlO79DBo/h9UbNwYic7bBkCRygQVf8UfkfN2VXIugkQcF0/CEPWTPW8MWGTHl+huqKJsOMOdsixcQVFo0wuo4fsuh8/28+fxrqhM+TePDmKeptll2GIgb/tz18GSNSzPcRi7Y4rtuEfpvQiy32hO6rujEEDNtwtUpRco4SD296wioutSVLNbAArczVSbl0jJ0CUOFp9P5wrgd0kV9Ob/TKLHjpMYdt4NP0Q4WQmld0iktULjSePbm0
X-MS-Office365-Filtering-Correlation-Id: e589abc3-7d45-4343-1829-08d5aa5d8d6b
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 03:35:08.7359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e589abc3-7d45-4343-1829-08d5aa5d8d6b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1317
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander
on I2C3 bus, add support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V2.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index d59084f..812f40b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -82,6 +82,13 @@
 			>;
 		};
 
+		pinctrl_i2c3_2: i2c3grp-2 {
+			fsl,pins = <
+				MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+				MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -272,3 +279,24 @@
 		};
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_2>;
+	status = "okay";
+
+	max7310_a: gpio@30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio@32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.7.4
