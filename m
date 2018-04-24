Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932832AbeDXCJy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:09:54 -0400
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:12000
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932775AbeDXCJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:33 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] ARM: dts: imx6sx-sabreauto: add wdog external reset support
Date: Tue, 24 Apr 2018 10:05:01 +0800
Message-Id: <1524535501-8567-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
References: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:dvmSu5jAgvY0InBVxLDsr8DeHmW0X7dhjQtAR5Lkw4FTzTv3O+2LWavC5n/2D/kKbbx09c56xi4gUiMrbZQSmQS4gXZIW6EYLbCcWRfKan8yGP6zUCBE6LO3Cl/ctY/Z/hj4LcEuyEGQCItKvw2soMYNrhtpGrNbnffga26wIQGiqjg1GlXUW51ZVm4tE9Wx6A1Sbx+Xcutbs1Ml24z6fpOaCTSENvDkWsR1HhsEwaOYSawExoTDRs5kfNWuV7F2;25:JRuuCmUYP7/ib5yeuqGkDi7fh5UEJjT99/jRcKZIgjch7JWOrG99V/KGlgbDg9322o4Q6YUHispEE+/zZsTwKMTsJ8kDYYP7jNXydDN9BUJr6GrPiahcQk0HwwzjuAMT0bpRKl9KPVAg5yVX6EUPaZyBNuuVsoLRsdJa45L80t83YdtAt/sSWwCZMsbJOnOkd2WMnuS2MxwJ8sdwcnFB+FxqHIXjM9z9+Zoe1Xt/LN+G1Z+kgZ8fKBO3Tx/ox9hD3ZfcKuqfjz5ien0rj7pHxNVqZXuiv71tttpZzpmiVlWPSIxftP7JLlCrsktMLruJUJIpx4NJjb3WZWdSa+NygA==;31:BpGWqZ//UOOmEqgPqRsQcUuMwJHAzwQs8had7tKcaWYJbQK3iyUVXK53A8XjoaJCzLwSc1gQPPPYqr5tvI8lhd65NHzNQhBPlNSTJJuJXZ25DEfLY47D+AQfjmaHaa9vpSpfeUesesq0qCd4K/RwdD4V9OobRBpWmNVakZuKF8FSrW+Qpco7J49fn52edA4QcX8H6pJ/Nq73URpM2kEDPJmwoPlugVQB9Ec+kIJLTvs=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:TcRJCpC4oNpl/QXOE6HJRxfLIIKr+Q1NFr2lOQNCXRThUFSlLpu8TTv2fO4ULHFx0O9iBAmxTImmi4udbjFLBIog8bC6CpaQmS4hjhusejEiuWkY0mH0x4D4hVkqANOxtLWP7h+vLopQ8iAzhQQTeaOuVf/RQ0V8i6Gdw4xBjEud6xbaw6g7OQ9rkUJ45iNE8f+82W9a18X2hmr1Dmh2NGnkSfimkSzUi9my8IOwHVb8Bbn4+TLnmT73Vz2Bf+ARhWt/G/uo8f9y29SpkcVShvjLv2JhyuqpIgYC8l6APApX3mSCt3zyWfU134Ay72lph74pMYXiUDUlMS8jKXKEQmoR9ELNGMfbVDss+n5/Xy52Wkj2VQiPRURfzp4/ueFyFE6k1TBVWL/cYFK690w9T/5fJs2KsJRxECNIlGAcK6pVzuAqt7nsrvbx0zvvy78c2iNER9ZhGMgsUxA0IiXtY/v7taKhDLquzYeKV75VwBEutJGbKZ9F/XpriQlRqdgR;4:dtOfL247lE0iC8Hj0HTuvOF7RDU+CKh6p1qbBGMxMwdIL2ZnnqTSIak3b6wgX8TsgYukr4Q95uKNOMKE8BUuZdSD2tW+hSugWhAXzEti2JnEnni47Tw1TW85U019HwBvZc7Ndtz7eiWMg7iMej40Duy76MpKVwQlFsA/wBKVNHarsHYsfbiKVyRTUlr8M9O6e+Erpv/qIRP5Y4bi+J9kdXXvtWf+2g/YPdlQNXCKquGw5f+Henz8eWOoPWq5HCWAk7ikpez3Ihvl03qnixRiMLjSf53ijkZpriR8VvwGeO3cFy8BSuTNEIhpNkPkPvcB
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315D677C146CB340935F9A7F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(346002)(396003)(366004)(39380400002)(39860400002)(376002)(6486002)(956004)(305945005)(7736002)(4326008)(50226002)(86362001)(6666003)(8936002)(25786009)(47776003)(66066001)(8676002)(81166006)(50466002)(478600001)(5660300001)(2906002)(36756003)(3846002)(316002)(53936002)(6512007)(16586007)(48376002)(6116002)(386003)(6506007)(51416003)(52116002)(26005)(76176011)(446003)(11346002)(2616005)(476003)(186003)(16526019)(32563001)(473944003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:pi20j66pbZuMBOUwhBchSrMp7tUObj6BfnXIyskx9?=
 =?us-ascii?Q?av4Qkz7HVmAmTj3Lr+W9kftFacy1ftOcNK/Aop++kbJRISQ4mrrq+aog/WAl?=
 =?us-ascii?Q?gveFOtZuK4L0mgyZYS+A0aepW72hyBWOMffZEc75RLJjqHV7x/DxALBVS2tG?=
 =?us-ascii?Q?KYGg0DkWhwXTlrj8rRCpT/iHfNus4o2rFMySIxnLZ4vIua9088fBlmSWnYQn?=
 =?us-ascii?Q?TGNDiYSx2v7vMl5tIDaLPObcqUZSjXejyrP5SSH/LbCTBy8TDLWHOKfxRoXv?=
 =?us-ascii?Q?QKY6pSai/JvJ+S2RRo7yvQ2i0VL+TqgKZoS52ZWSV8QstN6bhrEQgT8zhyEr?=
 =?us-ascii?Q?8lnONcB3rBc3x8j/dLWXBDYYLWFdHkBy1HU4nd+hleDjsILoJCnfaULUu8Bh?=
 =?us-ascii?Q?QpFfm2FQOXbiKPSDk2bXg2I497R6/gIkdljuk2lht6RLCWqZ0DMWxCqUR5KG?=
 =?us-ascii?Q?hji+8JcB2A9F41HkWXZk8fI2aG7muLgZxTN78HJJ0xO58VOiBVnYpeBBlwJn?=
 =?us-ascii?Q?z+UrHXwoHuDCz8tgYr4FrfmD5T2jj5KLbxX9L6n8DQx3PmHKEewh4dxUiquH?=
 =?us-ascii?Q?ru3NqQtZsJnr+/wYBQKserGfbSedTns/XL0q53Yj54FYaAfl1FyVHpiSdllA?=
 =?us-ascii?Q?m+EWhSbk1P7nOrtjrFhVWG8QinWbvV2zXklE+BxILavGBfcNV9RgpLZMHhMy?=
 =?us-ascii?Q?ljzg6mW8S5Jn8oFYQlrznKscmLL4miiNoZGkCWanehZ0KrguMh1XQ5ih5fau?=
 =?us-ascii?Q?HzR1WiANcKtuoldHH+e0BRrJvav+he6z1Dktx76Yh9UL+6IRsi21u43/COFd?=
 =?us-ascii?Q?6ercKrgK2HZ+ZGGsjuirLZH67KAt7TeFTlZg6YJuLilAdOb1zWtvqxPQE0ir?=
 =?us-ascii?Q?tq6dYfUlS0ZxsRP+ssIic4Fnt6ACPO3hLiHPsKie1r8H91MiW6rFsDnTtYzn?=
 =?us-ascii?Q?HAAuYCWy4JmICxu31/iJ8LzDaZ3MOF6My+RUayAUEZwF+cYtnTWQhZqyI6uu?=
 =?us-ascii?Q?wTzJbTxEKzOE962Yh+bmRohWQpt0aG0C8VAVb9oXpc9N5z/iG+2dcQsU62S1?=
 =?us-ascii?Q?UBAoQYz2TLNElWLZoPOBtjHQAkNYxLsJydJaCpqJ5lkleVBzFz589YhhhdG/?=
 =?us-ascii?Q?PuHk++rY8T4Tc5N8xIs0ona6JkyoXmh?=
X-Microsoft-Antispam-Message-Info: OerwfND7+KdASrNa5J2staWdoG0uXnok+4VRWibLM5lE5VEQxiXKA63keUAzBOqRUKF1Vi6yIHAkrnrtQRgPTwREbRd9psd3Rw5hhmoIhPAoOuwcQMZ82jN/Vuhj4qLwSaxQ5lIOjWcOViTfpfBJ4ixI12ZUfKGGz8uLGv57Zqx2Bez1X3ZrzUsDY1j0fg8R
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:F4sJMoldKxyzoleO4HltGx0Or86Qz3X8451qNnvFRxC5gCgbcgYtQDaUEGm/uhZn+v5x6wGtlYyViI23wjJPn9PuBdc06KPBbFh+2rwcvCbkff2Tbme+RvAAmp1kLhKYD6nxy61jngs8zU75Gtt/YcJ0O1ulMNAoxsnzQC0m9K+5ks8a5aDMENtQ8djLzs4rf0PBwPGgZ6jHMjj+5geOhtlApvQsLQuTT04lR4wqJTO3xubxJge9L8Ps94P9jJuxVIYtM/YatxtnZh0qNT6p8jssboVg141Pxb2Hm0BU1sJRDlk4R2sE7pC3buaSQi/r64FslmtT4wI14AcWDTsRXLfAk3dSzQPTIf9QvqZJXZv6UO4pwIQ3YI6dag0QVn+ZESJCR2YNKBuM4eHyItotkbXJoy+AT7nb1tgqdjpM8kDiBYXfiWzHqjXlvqiTSz8p3aWmJMQpu4pe6pbnsrFQYw==;5:pmNa0P2nNinDyj6uilcxJPKsJzF8OllEQCrUfs0MT4gy9d1P5RJXPfA7yj0wNDOmbtpTUSGrlcJBoeVxQldoHBEPjqIVWDdUVIl5XDjp2qpmwTjVD/QEnNWTuhUnSR+NOu3fJ7B5ZaSP/9wuj+91ITgNJJO1o2WYhp6bcyl0uD0=;24:iLCDY0TzpY5UHJZvp+1BMnrvbRyAPCxflXIK1GKbzY6/fRduIe41t7KKwzRrR68nRRnCUBpLfnhwcZCFjhVkm0tLBhhO24GA7G6oxnTgsHo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:GZSRzVFsfbbvP1BiUdR/6vyMAWmVcN/wfBSotqj/ygh6TpjY7Mbd21T5Gva8nRV0/L5ibSaXKLMkYigIL2Z7G5s4U+kmEmzObhofBgPBw2xGK5FcxA9F3l7DeQchus8i2dexIa4B3JUTl2MAljSJUkKaKTcfukLbmE7axXGX/B4jOX/bofDuhn7hjloFtipthqDbLxn8Q4G8d0MrAWdc2DUylR/nrXeggNX+piXQm0xfzsfZ0CrIsKsOeDHkH2+E
X-MS-Office365-Filtering-Correlation-Id: 7c9d51d0-80ca-4b23-7945-08d5a9886981
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 02:09:26.0915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9d51d0-80ca-4b23-7945-08d5a9886981
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V1.
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
