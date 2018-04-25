Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDYFlE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:41:04 -0400
Received: from mail-db5eur01on0074.outbound.protection.outlook.com ([104.47.2.74]:26432
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751436AbeDYFky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:54 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/6] ARM: dts: imx6sx-sabreauto: add wdog external reset support
Date: Wed, 25 Apr 2018 13:36:10 +0800
Message-Id: <1524634571-5914-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:604:b::25) To DB5PR04MB1319.eurprd04.prod.outlook.com
 (2a01:111:e400:51cb::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1319;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:dFsadqsGy6gBdwC+UqUAAwvfrLfeGueQQIpT/CX1f2O0W83PKlyMyNf00G61khdq6hAP6NmCLxnNh/Ad0JzFa2lM3YrJ1hCmiy0y9ChvnUK743mpbI412Q4R3/q0eDR3JzMpT+XGNBsngQvFl/u+Cbaq2YKM7/p+H3yDmADRXiHFOHA88v1bDIbqiNoJktncQWLOowVb7VSe0Br6q+jo4m8cvucCSD64iSRCw6i+GHSxVnu4InF/9+WhRr2R8j0q;25:3/sWSttBk1hR9ULhFF+ItuGPLcEaqinoL3uKy8y+FLKHQgQ5Iu/wC6DEj8gWx8rEIbFVgCb23EAPCrx8NywfJD+Rm3u0FADItY4UE5uEKWzn9DK22ZpIqazNeICB0Xkclf7siBviXQdgKWrxrTtFMGfs1Jg72Bxk7yv+p0ZcrsPe4dt9uULzdrzLwN4GOkd4e7T1zfbM2vvS9Tq0WpmhUcmn9bwmTHSMC68hjjN/xYMR7MxqrIRrkxWEU9de0VYwnCO2h6l3MWernznFVGiHF1DcCaNR9Twpb9GfQVpATJivltE+7LJ8QGvXzSHZBiiFuoZkGlL+wK+4ezdQxYf2Xw==;31:HRi7Ua6uV1xonxD+UJ4oXswdBWVkCzi5mO1HfEKNYlCmqhKeJX2qRfuUJcsKjFYYZMSBVlHpTMLo6J81WPX4msNJx56K//Lp5SM45khXdkRI1JQQzXX3+zxekqr02t5eJUMA2I49XgwjAwFMR7dSq/LSUtaHk0xxnV14g8UBlGc4i54yTHvKNrknuUbCfohn8igx5L7X77i2/oJThayC9Z9JaolSSCghf1nrhyIT1Mo=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:uyIiVomKJgcO1qg+cFjpM9mYgfI+gwbip9WuBgfRZtaWP/Vc4wY2d/u8GbP311Ik2ti9hchCa0j7Kf9jGJWUcb9GCT342PEvm3Ies42ru8KHXRLmWOk1NkWuskPS+T2OREABYi0Yy196DZR/FeVsauWGQBN8CNEBO1R6BhFrcgX1hXj9sku7bS88fBs/9wd50Na0LIpEqXtU7aMHQoRRpSRxiGahlSv09CA7T3KUc5U9vnSoNE0njYDgWp4YIihWDmPtqa9WwIOuH9HVxQ2bECYsRXmjYesLiec3PV81msB3fwtVZ2mJS+KApIW3XzN5yfK/3JjAPhK5Frn/V1GXFtWkicdVPm5lSSr15NSsvcSrAApX5vApKgyWZ0qZGlL+SateuBFtK42QaxGcBzU9RMTnBOue9pTi9j2xnpmzby/UM95+ZyURZzxFKIVHAfrsizNl3lW1iSdN3YemVt5faCaM0LyCzF0vPfVI5dqn3jlqOXYr54fpxCYnswBnrfK0;4:Fw3cKkrdYLZ/vwHvyVATnROWvQmsH4b5HSOD3TJmFguqpZwnbRWrJjDQq8cDNXTLV6DETdUxeQGnlTqGnB+hyY0HJsCNxFeM4fPHpMfzcah9dUMY59+pw7m6v6jvM39pc/BCoWMN1wz4GokaHdNbEsNEU3QV8ivF7zDmM6wHTwOzYy/SOxM+obXu3ypQFwJ740CC79FXBkV0xyTEVLoGnY49F56cI/xjd4uLE7VlqDywzgwhXQBVgpscwLO0ejmU0PvYw4VrHl+eXW95UFXVWzHSMAEPRt5Cu77fYWyyxz8u6ehipTnZ0h8LjUmz1LD8
X-Microsoft-Antispam-PRVS: <DB5PR04MB1319A522F8DD130817C2B22FF58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(76176011)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(446003)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(7736002)(86362001)(8676002)(305945005)(486006)(11346002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:sRD+ygjTWEp0PDWlxDMNsM8EhSphu3Tc+QWXNKsPK?=
 =?us-ascii?Q?LnNfWmgzmIoBD2TGO82gwxRYNnf8K95vcE8FDbeulQSrkfIFLPCOLf3eV3tM?=
 =?us-ascii?Q?oCFwPTvgxFcYGPb2sFBRK1ZHsOgMMEpXv6k8Yk3QQjF3uDjKkVz+VNs5kBPP?=
 =?us-ascii?Q?jbsTVDwP7fYBhEa+Aq/kC0ab5KrC+MuxRlqc8EhBLBXeLEAK8/OSqrl+LPbK?=
 =?us-ascii?Q?BOG2l5ua4BZkmCzFVzWJEzMkzioMQvbtbAt1HX89Yvzwisk1NZHPl+XvXwxg?=
 =?us-ascii?Q?PpRkroA1fN/jp9vp6XDY3xJe4ovDcNbMTrW4YZTJCmh7g6WxMgYPjgNO5nYC?=
 =?us-ascii?Q?Na+ui0YDiDN7JX1YYzEG9G9lQMZ3yAtuedAo2M55qoAokqfc9FIPN/McS2fg?=
 =?us-ascii?Q?dWAhZyxAVgwlycoSp5kAdDRzzEwrI9kJt4DoNDJWJ4MITqdGsbmkCjFgh2cK?=
 =?us-ascii?Q?E2yq0w83/sFwXMpiEYa9K036ZRyUsLxPSa+orBIDoOKRpiOQhfcPp1otKdUG?=
 =?us-ascii?Q?bSugte5jvk1kVlygqVuIkQyA9gCI6gmXIOxcug2yeDJ9D/UpA0alYcYgdtkp?=
 =?us-ascii?Q?IAauTtJoHtHjX1/0Uy1DRgxo3EH+2kyjofz8fvQZPVZ5L96SKMXs2N4shBhK?=
 =?us-ascii?Q?OlXRrn0g7z7dCpkmxv8uTSnoF3CEK8OxDkMJ3CwX1/7Xjdv9Wpkcvx6lH1Td?=
 =?us-ascii?Q?Ag4GZ0JoCQe8h+1YLreyu+hLnBs9oWF/PQgRXLjHuTiiOrcrNOubcEkmmtJ6?=
 =?us-ascii?Q?1VvBq6VA8X21X1u3Qz1s6nWUNd72RSQclkeEZhFN5LbgvLKyOG90KJg0Owwj?=
 =?us-ascii?Q?eoQi7LB3d9QnDzI6W+CLMdoprj8FFpjyGYIu7rJm89V+gtSwi6zthb2SiZZm?=
 =?us-ascii?Q?oWfCeGuaYgkyurVfaYBTsltgTsc3aNNziRTt+7h47LiXmtb/+JAYEEGz9vZr?=
 =?us-ascii?Q?OTht5ILViRh1dxlcvM7meCnTrl7HMDApb+IOLayQ75DVz4a/Bq1v7CRKRIvF?=
 =?us-ascii?Q?9y+Xvc/3AfbFgnXP19omEN3mjNqiTD+JdikQ4oX1O5+srHKjo/td9u1A8CLV?=
 =?us-ascii?Q?oe+sEDE01kauNrcD4VVHpccjlssvIZcMWpGK3mCV0CQsT4yg4FNMPiSzpryy?=
 =?us-ascii?Q?r+nK+s+QWuQTDHGl5oTmY3JsR2DtAti7ksZHXd6fIwDiWp3tuEEPRyYoOG+G?=
 =?us-ascii?Q?BtnH3VxmAxaSIEg8njsEm98VzGByYmb2rUL?=
X-Microsoft-Antispam-Message-Info: 4AdpI1YWLIr0OUA6JZPnyziB1xuj7yWR9W2aU6GRKqRSOzcWdJaosv8XMVS4ue0KMaD1Ay8Y9Md66Ma+rtdYk9q6IPH1ZKLUOcYgh0G8MpzRoU6QFRl0/4hsHrT+eeSC+ipDDLXHMD8mfROhvzLJ1dQiWnsePnnD6vA+y6PJzj9Opg2SB3OORzBX/auaRbu8
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:QIVw+J/z4SXsjjpXAzu5hxkpYCL3u+bCrMnRsip/VqHXEM9f6LQFw6ACWcw8tyddYYrcFyz6YN3VQ4lfLfTrB0Ukjy8eEebS+SDyB6kAvDwPl1H5ravBgQRjkPhZJ8ktcL5wSrgCs699LVO87XjW5FxJhIxr3LSvM1Utovaf0Hfhdyb/mvsykWUtqmrdUb2bHxLtz/BInSyA2PyHpdENhj1E3xzHnfCwjCfRf5C4R80stNDfy03FkJXQeJv16vzMTZCo0HIWOL/ZRIwRsyot/pidTDK5yVXomG5vGVi41eRn3iUFIc7+i8t4yOkI4pu6LuGX9slxrbziUqBl+l29SEdnKQ8JfaCtrRU0WhF2mEdoNymqQWb/TSVZ92+tIBpR5hA4mKAQUXgZMNA9H/u2w8SmYzN85v5EZ/R7fflrKIt2a5r53dUIoTO8D71yrRgJMdRooJ7k7B0I9guJ4yp9Tw==;5:UhmZHWkw3TzlPYumoYfIBVnJz12LG36vXrXRVRvkwfqgu7Y9XNa3KOlZMfNTnjnbAlwQiesbAhJv8kX1tK026dqISEq3GmI1r80br8pBA2Ntmzb1h+7WAi6Wqil7qEkQlib4vPGa+Rk+SqCpBMQrfbO6BOgMnTn1dQTzH9JS+Tk=;24:unV+qQZQZ3y/PH6eAtmu2igkJDSPAvWdFnm89O7JG0IOn4gCD4wfdNjh5Yb9l7Ok5GtwQx3Kg/EtS4WXdACGNOSNzWjBq3i5CVSr99yJgoY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:E5JZpTY6IokdcetqRRim4SlmHYxG6xzc/x+9sdxZkvj4ClB+ox4y88MuiV4CWMVWn9utRfkxEnbirfqNk0PE4wyOaQeG8K39l9tuhRCjYHq4n5vLGhOdxTrluAz+8K/lhc/QeGX0wyuNj7HrmmzivUyIluCDGN++ySzA7bugwWWS8IyibBJ239fBx90Ue8rKlgsORRyFV4UAm2n5xVsddbHxNPCk520Z4guKyJKXLY+I0/06f2z3yY8X3x8jmjso
X-MS-Office365-Filtering-Correlation-Id: 67ef73b8-735f-4683-03cc-08d5aa6f1afc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:47.4232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ef73b8-735f-4683-03cc-08d5aa6f1afc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index fdc642f..ccf1cbb 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -230,6 +230,12 @@
 				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 			>;
 		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY 0x30b0
+			>;
+		};
 	};
 };
 
@@ -369,3 +375,9 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
-- 
2.7.4
