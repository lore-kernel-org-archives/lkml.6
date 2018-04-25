Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbeDYFky (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 01:40:54 -0400
Received: from mail-db5eur01on0048.outbound.protection.outlook.com ([104.47.2.48]:44888
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751334AbeDYFko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 01:40:44 -0400
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Wed, 25 Apr 2018 13:36:08 +0800
Message-Id: <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;3:7KsWIH3RzJHGgUFnsV3SNLXvw5aiI2tDsYcu4joxYk4EuAfBWkgRJY8NuMKSxnDt5mMwI2eMiMeyX/5VTv/iRpBm/p4crzBr7oDdU1gVNhgCBhlbFnj1K0BOTiGt0qk9FMbvdxpoovOZq0QBp6Tx9UTgg5wipiw8yGRaLxYKx4LPhAcFRFa1vh1UKEmd+ma3eY4SxRxGuzKDIG5hjFPhNggv1PkTTFoh/4924lWOvrp3NZZClas23Dah5aQCasV2;25:kT4sTJCuXGJGN2PkGFAsXuoIEp0eJyAyyFnilQf3HdBiDbzlxnNzb5qpXPWdmOSXkLA16sijtHNZ8fA12hZOIu8s8a/3L/CvdLtdCU97tmXZncMj5G+axTHVRdIjTFPD4HVU2V3ypCxp0MRfBYbE5O+4/ngBSc8WVW06rrmM5abg5qg5lQhPXEKlPEsl/G2y+s1y9GURLvzmtOGjlwfVyyCCIayFDeFrMfsk/+uYgjLK6UYp8vv0RDRVg7tlT/2WaWhvSrQclB9Epfn2lJ715ik7RU9Rw9b5FiJWa5elbXJ0XesqGeBgOkm0cWdLNPeHOpALGtVFwuqQzBR/HTXhjg==;31:j6E3o2QoMz1arwgkvUa1UEQePKO181JY1GPWoY6Gemb5T88Wek2gxxRLdBd1ZeapVCQUcCm7HBS0Ul2bq4TPv1L64VqhLHhiFPY7J4dnwlm5S3YOaCBNSkvKnlX2drtgrq9y0VcuWKSe15C1vXBilGYHNUy+8PGzufICA7VsjoRF1N4b36dK1Z5bYQZ+zEDvJT1YlFxH7IsigNyK2q+JftzYqz4oEb5Ndm50IXjIQMk=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1319:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;20:a7vZ5OZ2WH7fFaITH5xiApJbO/nyWiqgHhkCEbVgxrEDjYqjGCEkK0+qdCah0yt/Axj8KmPbPXjlWGXc9R8n9zIl7SiOmxTmFG6rE1jHfrLNUmQSKO0sPeptzEqQwpSVX2v7GMFOTfUpXDWGZqbdQH5xzv85OWsoZAlg/0fvQbR29On9vD1W7OlUcgEB5HNo4mStM3fpEtO6t/xA7wnjPVY4IazUG+tuqX6uK5Kn5+aDYNHJEbQdn18QbgQK9Qhxwal9x84fBfxQYazFpi0huETQomiJteIYAgutmKZHh611n5oQ/bbkkD6PJ3DqsHmf0Je22yTEwSmaVSPtQYD8UwXaNYHjRJsRhrccx57zLp62h6ChLiFEMFRhbi1GSuNSG/SLwKH3i4OmUSmstzYs0XU9TmQqRyOckgvnovxNqaX31XbPHnUn3txqPebPKMW3zopVjRHON2TbrQG4SdRPxDpz1wdaKEIzShVi5HYVFIWXzVxHoLfnzXvWBi4ZzOfB;4:cwrA+jVsaq7bxTsIRgrwgSm9LnRNVLSIwIeiLQtWLD6U0yodL9gpKgea7lUe0rm/2A5To6IA7TGIgYL8e/4MCzTqsU8eesZNTTLWqXyka+WxuT4dJyrwnN+IeRT9VliFH/jdt+SQ+wuar4wRasUvJrfcCcdyf/Td6ECAzdwbxhdEfCt1FIWTCh/ueXiYTip2stjHL+Jlb8JXkZ+E8ibT4rNG1FHM5HvF4CxKI7uRgBBaJy5J3Vrmdhnf5Xd91xE7O0t+xYfZa+mYTJ1G5HnbMqfdmcLC0vsx2ZgAYqkuJC5kFTenu7Qznx5JpdvW8IaE
X-Microsoft-Antispam-PRVS: <DB5PR04MB131900B7A7105087BC94E280F58F0@DB5PR04MB1319.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DB5PR04MB1319;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1319;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(199004)(189003)(76176011)(478600001)(53936002)(4326008)(25786009)(16586007)(6512007)(51416003)(316002)(6506007)(386003)(2906002)(8936002)(81156014)(52116002)(50226002)(81166006)(106356001)(50466002)(36756003)(476003)(956004)(446003)(2616005)(66066001)(47776003)(26005)(105586002)(97736004)(48376002)(3846002)(186003)(16526019)(6486002)(6666003)(6116002)(68736007)(5660300001)(575784001)(7736002)(86362001)(8676002)(305945005)(486006)(11346002)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1319;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1319;23:35Upnl/pJ0xiIs5dJztS8AZs2Q9wfcACcJzFFdheZ?=
 =?us-ascii?Q?KfYkKjMkQkq09z8D3EDio4sqFqlTR8sOnSkKpLtnHLSJ0OPSFQ4khv/P/Bag?=
 =?us-ascii?Q?E1xlTGEWT1WxEyw2OclP0KdFqT8SuyoVbXEu0KjdeDFWzA/6pXsu+7bO5FG+?=
 =?us-ascii?Q?DNLQ8trqoL5lu3IkgEpNOq/HpAzMWocaxoZsirnvSpecN5dVtOrIjnMx/b3l?=
 =?us-ascii?Q?FFabP3L5973LtnLFngLbU35HrHQ+rncAs7bbj2lY34oqZuq3XQ/zPhvfDgOQ?=
 =?us-ascii?Q?Ap51YNHJXcapnvqg2caUhRRpryvtAHCIfbqLkFqOKcEUujvRMN3FRSu61N2M?=
 =?us-ascii?Q?Zu/D+bU5IOTL0eKMhS0+vjiSCCgbas7Xn5oSqthFDZ/jWhZ5YkSuZ+xpANnY?=
 =?us-ascii?Q?97oRKexagyAgoboHcg7cZpN+lfOHrtuNLqEj7LrWdaBElodOUT+UZ3VnUBRQ?=
 =?us-ascii?Q?xax2Oy46+kSDNXT1Y0s6tAZGLE6/D/udxonX1gTZo4Kv978IUYGE95qYqnwo?=
 =?us-ascii?Q?ABx7AyuAfIyd0FV9qW6uCML4jadAYRBViN0LWuNs6tqTpi1XX1uR6/cTFoGK?=
 =?us-ascii?Q?vF3JbBI0/ZIXGQg/bYbNzv8B1ysC1AdVr2JkS2xxxLiThHPmjY/1YAf2RhnI?=
 =?us-ascii?Q?mxgLIkealVhmv2yR0Oxv1nhmS3aLsm8g9QzQv1lYJdOp5n224nbY+0XShiBc?=
 =?us-ascii?Q?gvLv6eeKGBiIHLhQsPxGUXDwNnRyWP9HcoBKFhvbf27ZY554k9qdaf0RLzGe?=
 =?us-ascii?Q?d9Emy5OnZ+mpata9wYKncB5IFsAu6ONIL8+zMMTyq14ungyY6fi9Jrsfjly7?=
 =?us-ascii?Q?U0ThuEUZCoFKnhn96ZDCl5eizNpWDkIC2yxJ5MYJkUvYoBZPoW4Sc87tmi2x?=
 =?us-ascii?Q?TeZvGidrUpbhAygNTFmEzFjGmSztf9vFjPdi0lDp/72zX71FkIgEUo8KJhYW?=
 =?us-ascii?Q?OY3HdQ6a92+dbM8ByxhIYVI5+v/uSpILmpzQ6NHgM+Svc7uQmmK9fEEJjYGh?=
 =?us-ascii?Q?HHhVEmAuLVmBmKeNKLTDVH97kDq5roSS1xMkWiSuSkXE3dgA1VE6krEFprHH?=
 =?us-ascii?Q?ZyUTihJoQNpjdqYBcZz5NOmfG962mEl1jRSl/9bdtA0rJfhaSW+rTiX5pJEl?=
 =?us-ascii?Q?rCuwjgQzK1EiZy2LH+bLkNLpDnaOIhgNq0Or5VvIbK+5KvzhpCTFawU0nphF?=
 =?us-ascii?Q?FCPKITeEXS21GBis6bUV6jif2KPWfTh/qGo1cvgBbiyZgQhFSYUtUkS4g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 7eJY+wkk/lkuhxFnAsOu1iI/ZO0H9DGOykf9hO7ZtJFWEXeksQJPzjJGAAd63WpHNEBp9ZcMm1r4xVkvSegeYgiHP88aSKYE/6/99A/i8tFr0xj5w0IYH5jiAkybp/K/qQKuc6clpzhUgUnAubnbUsVLaL2xkessHdklxIpx55xnELokXtkonCHW2IeHfbAx
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;6:Aj8bVaA+9ulpWgMDL/tCt6ggv+RLpoKYuAVtDzDw+aNDLHdCwG88oblLYuBnSbQS0eYJru9SjwIHItpeZDQUEodILDbjMMdUFAja9xgCTUTmJzuIXCBdhoi3D5mSD1i2ISfwE2LlhDvev1rSJHvz3aFQPtrKkJWXldeZxWI0Zewvs0b0Mlh1F2Tv1gktfNCx2bRF6WgsG0qQbWVdHWp2YeOLTIlccf1cvdJ//YCJ6SyqKlXqP3rixQObpFFf7WB8CZRZCaeKlsSgtbpnncjCuysFHjLnY3v9h1nE7RhYrpR1BJo1f6TzLVU4nVlc4ljlct9GkF7gyqXgjfLIGCPObf7oZd2uvb6lFybh4ODNR3ImUAmec/S5gBjyeYM2B0coJ+kYO6cP3Q1pKoptNaPrFLZA6cdBfW/6IP+gIwoG1JvNRJhkgj0msVXVKjOpHJn4NdTVaae0isgiRMg2+hmSLA==;5:hEtM51+DiHX0AIDsqdezAUYzP7d6fXnOkpMrOtFm371YhbhWit8nF4xuNj6XwKzXVVOYO+3qHHYaI7xCZ4Hwb/CKu6jwQrC3vVh9IKCj0Nee7EgVM6zffrun94C5KMwS32qCjtcGmfteRoawsYmq0wkZqJSsXVYlkO4rY0Xdtbg=;24:js0WJE2//aDy3YrQqeUYmGoKTORgnmz/BAumaOKogYvolKhRSiLUN8yz3kdeSwBDSgQJZGdB6BzVr872eJKyoCJy0wEgYqQY1lCPwiNA/4k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1319;7:6XNcv1ficrKhQ1RXcEn8kFMKRa4iezx7oZVpFvC9tSMLS2fHPJobhDChSIER20PMKJF/t5qbPTdL1o6m0PIBSxXMmlw7Xqb0HbtuHi2WgDQHscvtxmukaxO85kp1kHnWsZbbTs/X1cQ6UBGD1DkIA7J4BBbKRYaMHVPHXnGOS+NSVFZKtB520UQ5CBTCEqPcoql1+vw+xwWlfXj8rFAxGG7BE6eb58LsLehjE5COoYL7rQj0HjRneGGDsU/lyRQ7
X-MS-Office365-Filtering-Correlation-Id: 5fdf38b9-2848-409e-9c6a-08d5aa6f156c
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 05:40:37.9229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdf38b9-2848-409e-9c6a-08d5aa6f156c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1319
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander
on I2C3 bus, add support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
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
