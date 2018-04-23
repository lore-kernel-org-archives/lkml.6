Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeDWDvm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:51:42 -0400
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:6050
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753988AbeDWDvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:51:33 -0400
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: imx6sx-sabreauto: add wdog external reset support
Date: Mon, 23 Apr 2018 11:46:59 +0800
Message-Id: <1524455219-6736-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
References: <1524455219-6736-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2PR04CA0088.apcprd04.prod.outlook.com
 (2603:1096:202:15::32) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:PML8vWCjZlx0ZuU6kNgV0/o9fftT66fzyPoj8i9IoxdPhPS7iOxtRLEn6oSkbPTLYBgG/FB3sXTd4OIylHHRPTutD6LNpXYkePpGoUIR3uHl63x0ZnWiNf1L4frzcCTN2jss6+cJf3ndVdi9raM89vAGGAAUgtoVivThyocf66CPErYKR+QkZtMy+6tvcG84KDLKEXGi7Tb1GCj/j5tECv2N5LXpZ3euMSmZ81NboznT29Vr+QyAYnuD25bKbx/I;25:sAiyp80FkrmCPWSOXtanZ+LjG/LlBe/2CpQ8mAOLGai0v0hQzRKOdrBOSXKZPpawvXwZjxYnAqTFWgspzOeYDj7867mmKTxP7EaqWdTQEyYKz1NopDN3BL4S6QEGJVmNnvzai0h+x4ZwFIPGH79PYZzh9HdLgthctOzRUZJgi8tUCAsAhMacbIjO9mV9krTLINZ9zM+g/qDfsXpnOtoHCH09oC1QK3jbBCzPxf+NK/QFcI4nxf8EBpg63d57215ebY7ou9oF6dyB9xvdFw2YGs+ljaCAlYkN0uDysOyqFDrRx3Kv7lWEgIiylq8SySFzQprxzZ6J9605e3FfPP3gaA==;31:6KpAjI0ShhFRKNTqTdY5lJmT8etEWpTh+5bO/oZQko7875dw/O/JyO3UaR2EEAJEs174WJ2huTA2InzC5Tawn1ibe8yq0jUhnWS9TvTS/3AIERv498rytMN0Ej/bWFmtDQ/GZf6H2Rbp7QXuB4NitD/c/J0GfJqKmjHfrkOs3PQSkvsak0GamfAbyBUy7+ZE4V6MkUfW2o63d3uUDY4h0J7mibSuSUdWijChlIkU9uk=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:VNI2Wn3glS2MbBrW1bLpC8qJVMdbKA6RVKEmMZmUcAl4EuZBJqhXOak4Yu7vbiPOh+lB0nyZMAYUF+j51L9a8p1g9SmnCqQYgMTW+gF7EJ2TcJPwGuGffmM0Zc5nlPS1mviBttNGvLLU4pFSM104O6+dq/X9hFG2Ab9ETDPhtpBv9ZvgwuXlFj2X2lB5YyiSNot/6RfSjaurGVTr7QfqcTNhaHSicdW5K0ZN8Yl48+UyWOH6UHbWuRSrkrEfc3+Sy4tgC5qnFEdodXhVnWmdzRCneq91LdqnqdKbqpoR46795jlhHm0jKoJDs26mzqPZOIGrx4TQ7tfT1kqRVOc8zDEJVfJ6Rw3iQTRaSmhkTO7jkwwO4m+aPPSU5UNLQmtG9etbTafWWyrpy0/fJ/zX4IbEcu0fJxcdiIuQ0iyTzEIl4hqTqQTIG4jpgIj8Nx4yqGkfrzDeWc4+pXem4ydOPo4xDgz1piXCCa8FRqw2LcTthsOapWGKzJiXmu2Qb2ZO;4:QlseLbGdHc+WlpZ4oeI4+J2SxwnqgJARVXxQF1/dEbYoLirBTspCWtaisNY3Bp0TWCHwJUhjGb9Mtw1af3bJaHaIA6LM2UPaoXW5IWbkK4AWcKpgGOjvU9oqM5wqXseUqiusuNNWkfG0SPis5XEO45Tu+K7GUeJdpJMeyFmzWEVJdnOXgVG1ed6NaZOYuUCTZLWQwHgg1JBTfLhRWtwS1dKSl+VA2NTIF29N3OBlrxQNseqyuTCGqClljGZCyMarn82AJFn4l1Vn3m3kCo18G+5Q5VLEUs3fvayOFVh6vtL1LfANYXiugXsnDqlj82gD
X-Microsoft-Antispam-PRVS: <HE1PR04MB132445B2CC5E6155E8F235A8F5890@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 06515DA04B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(8936002)(6666003)(26005)(186003)(16526019)(386003)(7736002)(6506007)(6486002)(2906002)(316002)(16586007)(478600001)(76176011)(52116002)(25786009)(4326008)(86362001)(36756003)(50466002)(6512007)(53936002)(446003)(11346002)(956004)(2616005)(3846002)(6116002)(47776003)(476003)(50226002)(305945005)(5660300001)(81166006)(8676002)(66066001)(48376002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:4yikVh+wftCttsDESj6reMgDfGHdYWLGlyfo+E/F9?=
 =?us-ascii?Q?Mz2BnnSDhUULv1al4JU7tQHU/+IFV6SS6mwmcHY3DlHCyRGymNOwblH1K1CH?=
 =?us-ascii?Q?qNLJ04K9+VPos1MmSLKfBbCTl4LZ6fm7f2OFKWFNyO8QvORK9HMOQPtHE1+V?=
 =?us-ascii?Q?hHwYo3dmUrGiNMNoD3oQq9hA+uogpxMPnOjiBYIPL20mHFF0xB0/ekPQq2PV?=
 =?us-ascii?Q?8CDFuXfklbQR0V3bCJ3BBnogDGkJEV+uNpE+hTYLn7j5VRC+Ga/LFaOmNSnZ?=
 =?us-ascii?Q?05JpdhQB1GivVr+6uA12yVUsN1AVTOQDvw/TuQ19eQ9mp9qRgUoP8AU6oBQr?=
 =?us-ascii?Q?qCdnadmMeCJYf6xePXPEaneHlQ024FH1CY3/fyhNfteTntWTyp3Kt+KYB7nJ?=
 =?us-ascii?Q?+KU2daslZIaarK7a7uVjYRWFqhmjH+PZLpNjIUbvou/3uLIp5JYmKFqPZtBs?=
 =?us-ascii?Q?edtWC8Ibgg/01k4PC2ykhuTF5J32CntC/CRnYrhiHXJqHKdAPuAJHjBftigb?=
 =?us-ascii?Q?b1jeq8ZSlPH/iESfq2igBg3C9L2TuNTaMydr7ft86T/NAY1P5C533RbEOryz?=
 =?us-ascii?Q?WZaufboFXqtuA8qfOpKAwFu4Po9WILpboOyiUsq3zfxgkRcEe2on97CniR1q?=
 =?us-ascii?Q?985Dqdty69xArDsrujqfcPC7FUY51+yRx2+ScvMPjx/TUW+ahATdsQb39X0O?=
 =?us-ascii?Q?FZip4/agyoLX1xn56zmtL8HR9/lbzNemSalHfidbDQq2GF6P5FmdlAJk4ckF?=
 =?us-ascii?Q?eHTMUioKBVhzjtMzEtZvpwD1ox16FWDApKN0IX5Pdq+K+qJqAQkP0ybALuO4?=
 =?us-ascii?Q?P/RscmAp/MMnF4jL+229OejXAZFtrV7poYb65MkM2ys1f0zlbMxpiV1qY+2y?=
 =?us-ascii?Q?eR2H8NUIKHrCGoAXi2tABC7MloBk0b7jlcbd9Y1A+hm/ktYY+DvM/QEy6wz4?=
 =?us-ascii?Q?vt/Ev0djMpn/MorxKFF/xV8maYswICFFcA0Zeue0nRuqcR4u3xU80vCrUfQt?=
 =?us-ascii?Q?U1fVKgisUdnjWl8djoumR9o?=
X-Microsoft-Antispam-Message-Info: PyfhIzcMc/6VvUdvOxz9wrPQaAsxs7uPC12Gkx4uMIiXPulmbfEVPxLjLhTg/6vMAOdLYpGdccDvD9U19ObJJ03JqTOy5e9NJA91Kgr8AMflEoTX/ogDu2kp+J8e6ReZ+kABYLSVWfho6iiRYVyRmNUZ8/B0WLRqE/js6s1N6JJ+uiyLJJkxtZK0SPeqfLj+
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:ibKGcfQmEXYTEXB65wikrWeJiuI0qs1YdMusP5Fb32g3vqzNYwmYfYfwlC6yQ162fpmJ8lAdPJVHdKas1tpT+RyeN/OlEFF9H08GjssS0qKtq+lTagVG6wOXblDOedxHDmAJbrZW93lQAgBVKDkjnCO60DZhr86BOsPB/l6dYLj+ruEiNBoPusds5+Gn/hsF6dC4G9UHRe4hAMtOwgrgLJbXTC+mtOuoONquTsLqV3OXi/paw39Jw3AFmozl2eyJOzgNfNzFUCcicXYW7aYddWFZ42RGiUaSyzBGjqeuAR3/EQ09IGX9NSupZ702czRTJV+2In9HOYruR9/mS2XJ55PPkyy3e7jhi78R7AquB6g76qQkV+eEWfAnczw66m2TgyFsVW5qIKhWAf3Vdrq1/FBrCVjEVdy+SiBZBZW4V56pi3W/BZ+J0esCJ3c7zJ27xkxJDPiLjhKlregR24mYmQ==;5:iLjsfgz+XEXLbVC0x3vlAsTyZlV8r6N9/D3DVwbzp2rsQOfjl035g3mR6A2+gJ5kKRTJFNixQTEyZpzl3PL2TnmuyAEgVhemaQby/pUcqx5TJNx8XnsQplu9ZBPI6mJwuX1mNqAudIPk5RxS50M+nK3kacFsuAuh7Y6sEM88bUI=;24:t38SODxaeBxW4dLFQmdHEHVlm8YDyHZwXlGbp0UdbOTBjWOxePQoAq815jA1Wp4kiWB/pFsWsRCbEztCPjacZsWmXT0zIfXZ6N991xzVJcs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:yH3MzdGDZ/xJ/gjr03In03IP7CxzSf/tPztvUhj8jZU6yy+uwTlKd7eLIrwkPXEpsmGuFcM5yudMhZ8nme1pu5HVxYkSdLcLZOpZeErlhvKqMB/f0rHIreOffo5Iuwt+6nUPRJq15KFpUEgFYQRCFqKQQda0MVHpOBj6eUJON6ZT3ov1sp3dHEDlCogtNehEj8sRytFbedJyY3VlapZ3s0phoPFqz22RhWD32NbeXlnYTcWkfhLOvB+iJ4xMmWBy
X-MS-Office365-Filtering-Correlation-Id: aa9bb85c-0ff7-4531-8f01-08d5a8cd7f00
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 03:51:26.5766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9bb85c-0ff7-4531-8f01-08d5a8cd7f00
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index eadd483..bf19f4f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -231,6 +231,12 @@
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
 
@@ -370,3 +376,9 @@
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
