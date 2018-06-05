Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeFERLl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:11:41 -0400
Received: from mail-eopbgr50065.outbound.protection.outlook.com ([40.107.5.65]:19319
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753742AbeFERLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:11:25 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com;
From: Leonard Crestez <leonard.crestez@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>
Cc: Robert Chiras <robert.chiras@nxp.com>, dri-devel@lists.freedesktop.org,
        Marco Franchi <marco.franchi@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Date: Tue,  5 Jun 2018 20:11:06 +0300
Message-Id: <b75a4dc8fa208ca9f9009fd0b0c9789a8b1f28c6.1528218001.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
References: <cd4ddc544a27915cab58a218223723eb18525c21.1528218001.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR06CA0023.eurprd06.prod.outlook.com
 (2603:10a6:206:2::36) To VI1PR04MB4301.eurprd04.prod.outlook.com
 (2603:10a6:803:3f::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4301;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;3:mx4kCQ3O0XMptLBtkdyJkR+7d1i+Evm1p85Hiy0zfZwxRTmbDSTsl0NwOfqQYTcD7b3YSsNwFNfF19OUZhV7uB2tTK+jgvPi5lzZ8V9/KI3twJTlECDrONNFJlHSxCNCX7iso4TmZiKD3AbL32wpEdVLY3HEeecZfbRYYeROrnyL1+mJQJjkoxslnnML8lPwJt0aSrKL0Z1u415HhlsBNMvQ/b/zOhSV5o018tteSlVdXFHdug8IEfl46A/UGYVa;25:uHoeTqT25w+W++kvtP0L5DhhqeUCH0IqHVrZZ1tMoDyPYIBi4NNo7iwuA8NiyHna3rNTY+QAHZD6sBy7k/lFCCYAShmR916Xht1Q8nJdrMzgf9lBNCk5QvxwhmNAoaaxX9/m7iV5yk+FHTlciMjpATX0RMFdyxx/1VvAu/tMa0ZhkP9qRZ2gMW34uOfGNS1z7gA/awV5EO834TzmlWDiqI+n9HDeO+/I50TkyDgaoceIoVxmNGU06NAp7NGM1TIfeZHvjiUBicg8pkiutr+EjfnXxgN9TcJZw57Zu1n2fTslZDBWPaP3RWrY4kZ/xmUpWFzoAaj0qnmQczj4UVob/Q==;31:dSjTG6JXjDeHIehzpRJX066oylWh+i97hHrUvKyZcX7FLjElpGC9xsjcxGK7qLH/g7ELqrPTN0Mfb6zxV8/faAKsoMwAu2QRJdIrVa7IfWpHnCkrjoy40auRLhPoGmZHqCod5tgNSH+AIIxUL0AAn97aW94TWTr2lL8HqObFj+IhkVlEke+eKx88c2BkAhE+4KPhTQBUvCDPJZBSgnwwqGakdzA/1W69Sm451FCMWzA=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4301:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;20:GlsO+LbSJluldjIuPOk8et0J/K3tx+fgMh1i2KaI1JXqeOhPslldUxxUKX7XE3uCWJEfjHcxKD7+F7N/2sAapov+KdquswRjxzf3WCRjBQo1qv6wZoXE75GjPbxyLbTH2zzHmluihvBWfbzDa69Atobd/KNHg85jq6EAJO8SFTDnu/4hkDGGSH/ekdEbXZObzGXHx3wLECEVRTW9HV1veTN/ez6lZvBo/RL2bgLUm0d8dCjJ/AA1IhmV9iJGK3uEoY2HUPzBqP6rsQP0SX95hf7AuoFm+PG3p12pTv8Y/yadTDLdMpZO4aw0ToSP156YErlvtwxGbj4L7NYZCkkWWDWevYKmJkxmgNIwCKGF+h0RyFbBqyQ0HHN0syYUC3zOS/gNa2tnY7FZUauZy7k1netGFyA61TZgmNS42v4uj8iYIoBMlfQCK17/yE3od5uS06B6LT4a6EEF2/XkAcx28gi0vnpvrgfbrd6OiOEjBXJPft1ls5I5FqwZP+HWp4Aj;4:385diFjRdJQ6h4Sw4ngwYNgbfCKRkusswe63BNd/YOZxwgQC9g9faC4FYMB5ttkgDjMjiEWDcugfF5Y299QqfZeQbZ8QIN74M7nH+7mNjhZaShxr1aai4qVqZKbsEIev9QYlt0wi9hgCA61mOkSJf296ToaGKo43AxW/Bmep4a3Sh3qN98MiaoNe+0/kj9fC6H2i1RXOT7v8ExcW3uGRQng/Lfjz5MyU1y2pYfEoyfAKVUskMeggQLsmrr46GOXW5Ls7dwQKophPwpfyAOFLctrm0HHPmYxCmPUoRMqTOqiHdk7d+zQLKRMlEAUeUlZ5
X-Microsoft-Antispam-PRVS: <VI1PR04MB43012CDF1A779F617440E793EE660@VI1PR04MB4301.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4301;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4301;
X-Forefront-PRVS: 0694C54398
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(396003)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(6486002)(106356001)(6116002)(5660300001)(26005)(25786009)(4326008)(3846002)(97736004)(7736002)(186003)(6512007)(110136005)(50226002)(54906003)(16586007)(86362001)(16526019)(68736007)(105586002)(956004)(446003)(11346002)(2616005)(36756003)(81166006)(59450400001)(386003)(6506007)(486006)(48376002)(118296001)(81156014)(478600001)(305945005)(6666003)(44832011)(52116002)(51416003)(50466002)(76176011)(47776003)(476003)(8936002)(316002)(66066001)(8676002)(53936002)(2906002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4301;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4301;23:0yagAMBAZwZcAdEMUCOWRjEIXOhtmaS4Bh82W0W70?=
 =?us-ascii?Q?6YRCWlwhjD1/cH6XP4W7NWkzvkx9l2Z0mEXdhzaouYEQ+Ljkn3CjUnMABSy+?=
 =?us-ascii?Q?0Q6vYt61CKCSYQ8m8Td2RJBANiPoeux+rZ8l8Q+gy/VIkEU9m20kWoAysLG2?=
 =?us-ascii?Q?AWQgK+sU9lP8TCw7r1Bq2cdNiAZCsXkHeGYS1UOlKyJEY2jC4PONT1Mq6N5Q?=
 =?us-ascii?Q?67kMxdF0VB3l+kAl4Tiosr1oIdvdrCiMkHP7yfLlwOJuLfGXksLgktUK9pME?=
 =?us-ascii?Q?hA14V7d1vQ0oxul1U/zhyuIGCFk2cFsy70ETpwZNG20+DUcgIfjuBpkHigPG?=
 =?us-ascii?Q?mIa6wpeC52nvv/FWdBkUa8afZiO5qkLoSqLWeKBJzSCht7Qtvbd4Yjp6mw/r?=
 =?us-ascii?Q?VA+BJc9BHjpXu8LRnUol/yqRSpYRue3wwRsKmAN97XYXt8wHJyl/E6nFJmO8?=
 =?us-ascii?Q?xS+4dyXRNoePwbJQ1zumyAK/yTSqS67wwmh29xeVmQ+6xOQ7RWs6v7luecco?=
 =?us-ascii?Q?samw3/vgPrNmuhPu4SISnyB9us/VvyuOyD8PD5oQcPjDemJeXi03E7Fz2jfn?=
 =?us-ascii?Q?jYSHD6zBli76zAYHvLBcYU+oS7ThMT1u0qXchxs4DrQOHdgU8fTA2ZC/os2q?=
 =?us-ascii?Q?+CfTsOsKZZG1JOfBejbEnOqf5oewaCDXGuAEFwA+FtVxJAL2eOm8mud3iwxC?=
 =?us-ascii?Q?maAin8ghAyG0we58lFMWpt8yqOIxzuo+8Hj7itChKURprm+RnlFajKZCUycF?=
 =?us-ascii?Q?6QM3sRPwvdf/DYJIrfneCMf0X+LO3kCyuVFAr3Tyut4C9pHd6tH83J3kWMX4?=
 =?us-ascii?Q?drNbbR8O0qJMdr4w2kFdXdk9CWdaaP0H7WTQ7dPpBO1HazZnHNTK5hcKrXL1?=
 =?us-ascii?Q?h637illJZQpxDbmz+KhDDOu1IyrtYIPDS2PqrFZHPfszXuo15ub/lrcrkWPQ?=
 =?us-ascii?Q?wUsfGsSAp2U8rUru3EfvDxVBW7ykprijnvP3GaHkNA/6BCAxsv5af/mErk/g?=
 =?us-ascii?Q?eNyx72Psk97irOVA71e6aRepA16y3VtCz4+o9tenq8kTT5NZw8nc8+OcugSF?=
 =?us-ascii?Q?J7QvFe9r+MAcvQSHDXq+Bc4ZQMXKlahBebcL45A9yYTD5thjjki+ucDieEvO?=
 =?us-ascii?Q?42jryD05zOLj6+Amm2Je8ESk3ntozYh3SzBhaC6/91QqSs77VxPak37K6EVa?=
 =?us-ascii?Q?d8IPWTt3rDG2VfoTj0wE7sQNxjB+XjKDOU03ZsiPOIaur7QYYpJzApyHheKt?=
 =?us-ascii?Q?dZuqOudIEPdzTVOtjxqVeOcQMI2jZpn2jFc25DCWtyq5QAKPaPmapZ8c7ATX?=
 =?us-ascii?Q?/OqdkkoDG+6TBnfx/o9TkY=3D?=
X-Microsoft-Antispam-Message-Info: a4HyrRx0n6zl9dltMgGQdTxpI7HU0aSnFTW50Fnp8wR5YDWMOfT2EqV7NKLX4m8W6RJrWC0OkXzk6GCSSBGWu27wW4Sl75OaeZWhhYFit88wh5LXqq5HOgntzqYnexZHRQ8ExX2gXhkmf079GDtiTKae2GfqmRi1M4uNvz24XcWzTO1S97ByuafIc2cVQNGa
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;6:x/FQi//xjHjQfdU3V4yAWcPZLpKj/bHqsidhWz8L+7X29sPfigk8ZR26Gmn8CCOK69LqSIi1LqGiDCvU195ohvJchKZ67OMz7RUpx7uYuIU23Vj2A0vn2Gq5elSOHkuYtOV0NbfR6RN659kDlOLSR7DdkeUNqcH8hemxfEEuCNT8IChyGyh018440mV1/itOdkmggdyeiGhx8/1iGfgSH1rMVH2/sNR9gFosdLtcSmNh/9sNT1AJRWla0QbK8M+ABEQZiK0mNOoZ6oCLf1pFlBPeOPiSdWFJBWe+ge31TYoseJiVDA/cSltjTZAUVdxm0IFOn9mhXrFRXhhMTnbYUqfr4DnGFUQ3jBJP1wRbv0c5/SX+TITUNt6Rc+og24bUBOo1x/1YnbWira3brWLQOm4lkiouVWn2talrDcjRegdaL/lk2a3aGvsX1/Ky/wjLqWplSEqyKcvRVh27ub5j8Q==;5:QmWVHmsogp4DSpxvDI5OCVvhUB+5xrftbghgZ6VLOmwUHoY+iG+G0RK+dwf29TJGlZcRcQcuDx1HkpMlLkkT3XQ+d8c9oJLHimn6AVZFicoW93CMM1wSgsn3G6/GEbTsXQQt6gJIHF903jABQ2lVsnE3PSjF3nD4nM4To+7KADw=;24:Amhom+TgJdOmKpb7GOwqq1wl5TuLkNSzHpLZcC+NCfM29cuTaWuq8IJi+KZugiLwYU6G8BB+rHFedaGeDxCryYLfYLBAbURUdmFlqeJ1n+g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4301;7:9vXg4ismvLP+x8b3IHO1F3BtWN5EIllX+yazOMPLfwu2vN/irIJdY8ny8sm3508pBFclTTtIedWyhqN3+2Yg3Z63XhdD4d6eRujHr20BksXhtHydrH6hEODqHhz1mQGm3Fmi539GQd9+On2K4aCr3ESoIuszs5OG5eyNaYX8q6XR5DuqXNCN9zxA1Z1f3htuOqT5QoDJUEI7Bflp12B3nMwBoFASLIQUT6E9Uv9Oo3iqov+j3cMJLoUdI5GMgdF+
X-MS-Office365-Filtering-Correlation-Id: 21ae76f8-0357-4bf8-3bf6-08d5cb075b4f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2018 17:11:18.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ae76f8-0357-4bf8-3bf6-08d5cb075b4f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4301
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
the DISPMIX domain can't actually be referenced. The pd is still defined
and pm core shuts it down as "unused" so display can't work.

Converting to new gpc bindings by adding pgc nodes, also reference
referencing the newly-defined &pu_disp domain from &lcdif.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

There are erratas regarding dispmix on 6sl so this might be wrong

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index ab6a7e2e7e8f..9982874fa39e 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -694,14 +694,42 @@
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				pu-supply = <&reg_pu>;
-				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
-					 <&clks IMX6SL_CLK_GPU2D_PODF>;
+				clocks = <&clks IMX6SL_CLK_IPG>;
+				clock-names = "ipg";
 				#power-domain-cells = <1>;
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_pu: power-domain@1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_pu>;
+						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+						         <&clks IMX6SL_CLK_GPU2D_PODF>;
+					};
+
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SL_CLK_IPG>,
+							 <&clks IMX6SL_CLK_LCDIF_AXI>,
+							 <&clks IMX6SL_CLK_LCDIF_PIX>,
+							 <&clks IMX6SL_CLK_EPDC_AXI>,
+							 <&clks IMX6SL_CLK_EPDC_PIX>,
+							 <&clks IMX6SL_CLK_PXP_AXI>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr@20e0000 {
 				compatible = "fsl,imx6sl-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
@@ -752,10 +780,11 @@
 				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
 					 <&clks IMX6SL_CLK_LCDIF_AXI>,
 					 <&clks IMX6SL_CLK_DUMMY>;
 				clock-names = "pix", "axi", "disp_axi";
 				status = "disabled";
+				power-domains = <&pd_disp>;
 			};
 
 			dcp: dcp@20fc000 {
 				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
 				reg = <0x020fc000 0x4000>;
-- 
2.17.0
