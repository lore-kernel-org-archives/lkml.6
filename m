Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeEFGcN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 02:32:13 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:38240
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751739AbeEFGcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 02:32:07 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, fugang.duan@nxp.com,
        haibo.chen@nxp.com, yibin.gong@nxp.com, aisheng.dong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V7 5/7] ARM: dts: imx6sx-sabreauto: add wdog external reset
Date: Sun,  6 May 2018 14:28:11 +0800
Message-Id: <1525588093-29994-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
References: <1525588093-29994-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KAXPR01CA0043.jpnprd01.prod.outlook.com
 (2603:1096:402:1a::29) To HE1PR04MB1323.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1323;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;3:XV+UQoMRDxkLfx5F3ScxegNflBHHYDPau45hpP30Vf+VTRtlVyOpm8bemMv1n0cjgFQ2dFTAMpqKoW/FEXUsWQow5YVuUImrtmfygxP+TRYhDyWBKAXeq9wtAPYxKOulOJyonfkVVK/SkUCE+DpL/8YAIEqhqqsK47eE3OezK6Vlk7NLryZqFG3KVeXI94SZJmgHO6j8KovAcNHaSK3PoxlhTDKMp2Qwknn3TByQ6aVMggKgj1KRF4Cb/cXgU9IK;25:Bed6C3qLJOVai33adOfrA8LiJt2PCLKzcDBjAmuhhxo/GU5Q4s+8XkPC6aWXwpsikWgll/Vgv4MO9m7V9W2YC7bsEAGPS8mjq45PkBqogtcnBRzZXjX6NkqmdfFzGI2Aff/92jS+oZ/PGclyw2IedvhILdoLtXtD02trs7H48kNWhdTMjMIvOmz5E9hWyHULv8O5V13z/FfoKbfMddjhws7pJSN2FyeEHAP7b6yv12fuXIAJaLugdyQdQVY33vLxtbAsCqEAwkmYPenzwpAiIJIi0BBANHy/t4J1Hla+u284OcSx9lnqoa1fLb3dcbwFr4mR6pgl2tfVV7EFkmb0AA==;31:fqPFk2QfRveZiE6oYQwo2tsS+dKjOMa6VAMIja5+vlD8GkjYqyZKx2BdbJOSFhkD2dtu9HzvTJ7m7TVpzL+e6E8AYW1gCDnLI5vajGHiZI9onMpywT9/BJTs7WfWOSe0VwEciTtzqrxu0emVbdGjwNWSUxRe9s4YnqsKcOdq3EvlKJeI9oEX4cTDSCfbiUfPgMI80BYrvi6aQzd9/l6yO+fGwB2owk8BXR/T9PqlQ98=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1323:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;20:XnIiGN8NYWSLwQfQYmtpTfZ8n4yQGpJRN+tu7uudS7Im1q9JhWqaPXOGAk9H8t/I73RU1b3O94GbvyfMw1XQUrP3gjtR+/3lSbeczcoWp5Xlp8mbBLr0bEEU7708nRi4IzDeiNZubmW6HBLr6ZzVS+aSfLj6s5Z1TjuXTOmVE4Ru/jnWVQSByHmi6MPFNKf1E4K5z+aXpFOZf+nXX0UW8YH0vbU1a4ZoZn6Khj/Ke8NEzAGt8vAcfMLjF+T89k/HGp4X1HZtaA9x9+2ZIr0T4uFM7F4hgHPZccHk7s5DaLxkzYT4XTr4McZKap7CxUMR/eADVJnHD1CJQbuZ5wyG5rKT2a5UW09pGLsmCXNzzQYzXTOxtUaoNoBTiFoglpAu/gDC1Cv94sc8N9cWWRJPUZ+mdYRNQ8dYX7mbmNjeGLKFCg9G6mNhSHuHE+sLiFN7K1I76rEWyL5Bk+xUCeIPI0nwZoYanTKLmw8Ojt40D/bOkSt6avGyVFIF07tkyKCx;4:CD37Vl6754Qsqzrnhg7rsOfcDPTfSWzY/IF82AQe7/Josn8Kax5ZqfeHGy8l5XbABbAqb9ue6DbeYYX99pBqNoLqbtpUx37lA41HCr/NFEJ7C3ZkCttK6vWeS4BBuBR93AWXW1uvp1ao6mFTdeFpFiNX1lBwlKXr4R65hPcSD7R2M/WDI3c5+5xzSTdtcTzHqsg3s4fHDLz0Lo1EID0Y3yw2nKOwOI0Ka4rKdcnftIxHy8/Lt9YeDhL3r8n1VxL0NYAaQVHBniBmKyd2YHOnhJwnKkqH6UseIaQvT3zgYZ2eRxfBoF4hif7TVsGRAQzG
X-Microsoft-Antispam-PRVS: <HE1PR04MB1323E6437F149B4347D0B8F2F5840@HE1PR04MB1323.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR04MB1323;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1323;
X-Forefront-PRVS: 06640999CA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(376002)(39380400002)(346002)(396003)(189003)(199004)(6486002)(16586007)(6636002)(6666003)(81156014)(8676002)(50466002)(25786009)(81166006)(47776003)(66066001)(5660300001)(486006)(86362001)(316002)(68736007)(6512007)(36756003)(4326008)(2906002)(956004)(186003)(16526019)(2616005)(26005)(476003)(106356001)(53936002)(11346002)(105586002)(446003)(48376002)(6506007)(386003)(8936002)(50226002)(6116002)(3846002)(51416003)(305945005)(97736004)(76176011)(478600001)(52116002)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1323;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1323;23:CeYTORni/Nc2fYnsEuGi6t2jiSs+Vq1Qgs34oSpmK?=
 =?us-ascii?Q?4qO9gq7j4v1LseYjilnIXaX00v9urdUCD6lNv87KIU9ssPzFHjDqk0BcATyh?=
 =?us-ascii?Q?sEka6G9nIZIIc8R26S2czoWB/Urom1RuTgDa+UP2gA8lXsz8HkFYLNekqgf3?=
 =?us-ascii?Q?pjo1plvyIhNuwyU0RLhZubTzZTyPrCFbg9f1M0rlbhf1A8XRTTrEUtXWXgTF?=
 =?us-ascii?Q?42Dovn4q6nGOJfjZAD09H98uEXFdE8Fda4XAEezXVbA33bB1Z/xFMyZ42WYw?=
 =?us-ascii?Q?McheDfxO2LiHEhLBADvJT24WD/ITs02sEOSiQRBZ6FCwkKRwFzKrWbAp2Cyf?=
 =?us-ascii?Q?IJUKKHJ16TU/2VC+DC7ck6wNgJdV/2/jCZsrXx3QOuhhqfRk/l/rBndpSZhT?=
 =?us-ascii?Q?5lxUNb1c6M1PLaed6/a8tu8ebHKcYAsU4cID/rK8DTjDEoOGKsDI6BuoJDhl?=
 =?us-ascii?Q?sI4NApilkStqr91/KTf/eP57ANpJeQtq4eE6+8XMJN0NUCQTPKB6v1+p90XC?=
 =?us-ascii?Q?owPExa0V3KyLvU4MiaJ/LCihoPHI2OupAWl8KhNcSJafeWrIXkC5uWPWiMM4?=
 =?us-ascii?Q?BAXDXO3Yfqfaaizut9hkNxLHNouTuLjSg8fdkioCP25+4XJvp4vsJnj9rwAX?=
 =?us-ascii?Q?ZxDovWTIRg7H5/m8ZkaqDj0kHpBCPafEErg/K3szqY3LOo5tP3mRX5/1RDzC?=
 =?us-ascii?Q?aMXmLt9fA6UPXW3gm0F43dzMi1WT/YLgw+/i1FgwEs/Dy0EqfXQsTV0z6jg2?=
 =?us-ascii?Q?ZUj2nG9pXcAVDNwC9gmeeluTMtNaKbf5vatRce87SmOs7mbOchebXsiOCOxw?=
 =?us-ascii?Q?3/29Ef2pzv3Fct4jWkidrp2AStNua/EkCO0ojEAmqBMRK1rzZrEHQnKcSFFc?=
 =?us-ascii?Q?Acn5OcL9cpCAfQU0z1wQxapPD5bf6flnajvbYX2FL3kMoIbaeD/mFsxqTPSL?=
 =?us-ascii?Q?uV7Nkswj97dEQLlJIs5g5imcEdSssUh8jWp+HzQkNnD8c7gJi+S5f+PB5Jyg?=
 =?us-ascii?Q?+NlJbFUtV2FSYExkY+6WmveDigRXykPU24M/Xu1alVr/bgfO3fTos5v/BJGc?=
 =?us-ascii?Q?Dy+Z0E+Ie3XY6JBUV7ZQSLbA4XSU3LDGmlSzhW6nScYk8OFYKnIOYkBE/HUO?=
 =?us-ascii?Q?Oapoc8qRjKLhBMOtLKhCjN7uZN0D4JWAwVn1uPoYY4WtDkrU+eGVAUUIeJjU?=
 =?us-ascii?Q?seVya3it9TmM5GSy7s5fYrXiZ8GkfYueYCF?=
X-Microsoft-Antispam-Message-Info: OyV3/IINbe2lnylezd924be6gtALieV7oXJKax1yoxQe7SNNWYwwlskBK8gFbifHht0zda14dQSG5gHFMgwp7aEX4drJhdt4DqXtJkf6JrPfYbxZ9cH4oYbUZG5indzbqs5jytFvAzi7cQ+xLDOERRqCpkTOG1RCRQUD4Xpuw9lWlF/gBFn6a6y76G46xs0Z
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;6:YT3GyQNtie5EuqPJ564sTQ/es6Csz1vBtDJVJv6GwNPYZlVfebYOaiHJTcY8rWk7qJSZZKTPe/wqlg3NGSpAVJPMsplpzGxV3RWXjX9dneqbhKH0iTPTheno+7fLap5FgrjLYXDW2f9whbCQloFETVdHW0r9BhI9o7aUwj4pdOd/FmEzrSIK7hpRXBdsYehwIEdqTkJL7GbxctrTLPTAdWqCZzL23d+NQBt4hqNqrMeUZlH5yncJhuTZ4ctTqp43rlCD/eCPf/guDmhNi8Ru/pmAqxYxW5C8KwZ2HicGOP6GeiF1qpTlFZhe7V3Q9juIzvkmx/lJygyDMA198RBmOBJs0LlIjgItJ+V/IBrFjqRP0xX/AODS1C7lfB5JgsQbu6auc8yCrpAH63MkiBt62pt36BimdcrCeiznYMCWTN9+3gKNjemJjEifN6ZULMB6PtY6Kt3x75d5+9yTBw1RxQ==;5:5YrCen4XadrbUX828Ic70jC/w44sKUBR7kRis15MTL03cyswUWQHJCArd3CgEp2KtkM16quHZjlyNLO8Fkf4t+vFxXuj1zW6+UIAD3nhoWZf0h6H6eSyF4WtQQjGNrD/JD2TgFjZgONfWutXKVtsR10S8vifahAikAcUWXek1kc=;24:Dn8ZG1UwMPG2ngOOI7t3tnr9e1b3ActodjTzSBSgWLK+ESb20GRxUcUWekYYAhayv6WknPRBr8NimppKi4qvcmat43jyukYPQOFpPXDgl2A=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1323;7:ffNAUapcvk5uDB6gn0fEvUHCFUhjk9FvVhy2HrC/xuQ2+zAH9oP5c2ND7uwv0Yd+RBebykLJPAi5sp2TvPvTfwfYUuQ78uQLPoLY4EzzWGcK+r7nYjWwOZkJCCCdgHfzg7JdgNEqXyAc0CNttKxyCa/I4C1FzARX2xSkUAIYFL3MQ1cn5yELkjqjXLRShOOo7xJ6PlwzNfZyCmSqbdkU29bPM7FpyfX8qEaq4Q4qPob3NfwcF/J2YEOeTRh75ijM
X-MS-Office365-Filtering-Correlation-Id: c0f500a4-7881-4cdf-17d2-08d5b31b1455
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2018 06:31:57.7526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f500a4-7881-4cdf-17d2-08d5b31b1455
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has GPIO1_IO13 pin can be
MUXed as WDOG output to reset PMIC, add this function
support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index fff0081..146d5ab 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -221,6 +221,12 @@
 			MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
 		>;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX6SX_PAD_GPIO1_IO13__WDOG1_WDOG_ANY	0x30b0
+		>;
+	};
 };
 
 &i2c2 {
@@ -359,3 +365,9 @@
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
