Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966089AbeEYKi4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:38:56 -0400
Received: from mail-eopbgr10109.outbound.protection.outlook.com ([40.107.1.109]:19632
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965255AbeEYKiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:38:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        linux-imx@nxp.com, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH V3 2/4] clk: add new APIs to operate on all available clocks
Date: Fri, 25 May 2018 18:37:21 +0800
Message-Id: <1527244643-10736-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
References: <1527244643-10736-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR03CA0069.apcprd03.prod.outlook.com
 (2603:1096:203:52::33) To VI1PR04MB4224.eurprd04.prod.outlook.com
 (2603:10a6:803:3e::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4224;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;3:DZJGLc6sAWi3Dzpo6wIGYcDfT9/gq396g1xmTEcCa6K3aE0As3mBhPaDYmu04zrwy8ie4NRkqfc30RGndMLtx9rb2vaMkupTPZu5QajkItu9JD7RdiUM6okuS6dnZyJCqVaVRK29qtGcEpf0MLbPMLkHyw9x6GpT2UQZPRQluHVTYQiK15ikNY9HfFvzMpzhmxY1X3YmKMdDsu/WYj88QErxGXOHsaXX+l9YYyVNpDS9J6p2cxamPeF109II8ebh;25:kxtG5nET9OUTJH4HOFsPQsS2TWrPNH1fIMltgwOXqlSej2j8P9++A+D/jA5FMRy6N1Bb/Qr6hCO4Upo2U51YNawj+IKecsWerPXDz3RjYc2SSkXxpt0fPVxhC7tRAoMh758dh1PF73UNzitAX5VkEdb49K2DiaxDxe1OhTv3rhNJGaeb/JLv2nKZS3jVSVT5AZn3j6noGcCZLQY354i/4dsVcMs8+YI060DPdA7yHCkG+gW2Q2zP7ZwWfzndG0r5Skxvc4GrIynx0mnrF1qu31B9dyue/S6mAOWp4YJsVtQyIcFaECuvHDRbZsoZiLInVW1U3Xava0ywC9CVHOMBqQ==;31:cpSy+ZSrqwq+K7V7HTUDOfiIB/ZbpvqEhBzDeloZfkbqTwVQzbockpOs8n6U2DGEWLV6CzT3hBXY5bH3FTn6S9otDfSdVGGRMnkq7UG5AV4ag77Dbf01g/Bx18nEfVe4jYcHEPj29mvwmS3fKgwwVR9VX32/7QS60uuVEzBNAmIqGDt+P55nM8/Z6Ce0rYJUgGd1wghNybATZ8mWkP7qUNPfSPtrrENw9LWNYX7dYfI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4224:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;20:UK4NrCi0GbvSzLJYfclB6gsvNxdOnkNe7Mta636DrjGUD58DXTpEXjQCzwORnZb44hRYZ+EWpucZa4wfoyYSEwuYxwnqPS+LgrQg0q8O9MbqJwDB3qUOkB5e5qUkncqrJP5SlPAr0UrwIrWWM0jYSiOanWKiJq+JsIk7W1lGQ5WpU6x4nxNZ+RGB3odB6g6sOtNiayzdjf8gNP3mFkqUHotny/a1NY0sor8kS4qS4xun0I8kpAPcW252YVBGyNTqtwqPG4K8LGnAcBciMNcz8OM2HJGIzpzCP/kYVks+DT8BpKcmIi1DVuxYQ8lFJIp6Jv9BQE9Tqup4kk4kNY3P0KcA4Rw2C+I5ZxF4SnfMw3+2pkM5sWy3p2U/T3fbX6hRKL7ENtuoa8Tlb3djxMkoJjFm0kUjT2Izz6kAxwnBLIkxXYcJzccka3rLNFlMp56SyBCQxm5FDVhBMWtovHguMuuSE9SiDaYloPIlXpzAANNe7NV6jNs/x3xb9u6hEE5v;4:1fZGgfy/9rNCOENUc7mjvBt3X64eexQyvvTQk/bipD+VdCf915NNiw+lOfVaMa0Kr0w02PlSjf2bAjH2wV5pyc6uYkf+a3JuszKJB/gw0rMJkzNxG3tczuNwInMcfoWnfwMcLWCNyoiG6LkhX33m3Y14FOqTzBgbsgbiFt9UaHCwGCe93rYqlHRVcr7MmZ7UA6jlIQUksVJ+LkrS9yk9jXNj+QnURHiBHmAhGDGmf7omigCoPpXcr2yAijhyyjG8SvLhLdpLXHzynPecjzGZ51UlZr/1qHzpFeCjx8eBNxW4aR7VXEOhV3EklOvJ1DBj
X-Microsoft-Antispam-PRVS: <VI1PR04MB4224AA5473311BA1B604B67F80690@VI1PR04MB4224.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4224;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4224;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(20776003)(69226001)(63696002)(47776003)(74876001)(62966002)(74706001)(36756003)(77096001)(77156001)(76786001)(76796001)(81542001)(42186004)(93136001)(92566001)(46102001)(64706001)(81342001)(92726001)(48376002)(77982001)(59766001)(56816005)(33646001)(80022001)(66066001)(76482001)(90146001)(89996001)(65816001)(87936001)(56776001)(88136002)(54316002)(74366001)(44376005)(87286001)(87266001)(50226001)(4396001)(47976001)(50986001)(95666003)(49866001)(47736001)(51856001)(50466002)(85306002)(79102001)(85852003)(83072002)(21056001)(97336001)(94946001)(93516002)(95416001)(94316002)(86362001)(97186001)(80976001)(93916002)(81686001)(83322001)(19580405001)(81816001)(31966008)(74662001)(19580395003)(53806001)(74502001)(47446002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB4224;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4224;23:1VB/lU5UZjxAylR/wzOaFYJUmBoKonsQHqu6Opk+o?=
 =?us-ascii?Q?jvN93gbsj4q3cQpfVg8T+GKZZKKDqQq/yuQiKVMxNvOahZIAnzUglI4vTm+D?=
 =?us-ascii?Q?dcNOzOwbz7z1UUQGg/mxCZHVkKZBKnhSlvMqLocOj06XgmzSjfhPe2v5zkIF?=
 =?us-ascii?Q?uWOBVN9ooI3b15ThdLZj2JVu5p5WyIA0vPXg8Xy75WdSI3e56T44jhN4iG9I?=
 =?us-ascii?Q?XU8q4KSzwbXKRY6iwncUTlASfTPtGcJY+9jwfA05V3GRpXM0hLLnJuLR2PJz?=
 =?us-ascii?Q?2ajijKEG3Cj/VDzP5Yko3ztkd7P9R+O35YEAv/E8Bd4sWh9+yOIXl/X5S/82?=
 =?us-ascii?Q?9gDyXl9DdLdOZKCmhUKsTCq/ASTxZzHEtrrFAR1CxD0+/ztqex7tTHcvlQRS?=
 =?us-ascii?Q?UgnSHbg7uNugONdoSo/BHa2m4ELWmphgrcV9QQXm+AJ/7sogGkgonjxDhXhr?=
 =?us-ascii?Q?rcVKn/ZKEY6od2IYPwWeFVYw8Nun4iGC3+V/6jcimoUK86UlkLLGJYu6bIuk?=
 =?us-ascii?Q?WUlsDGSIqKOdpj6vHNaMuqeHOxpYjR+fE2j+Wsx4KBqvraejZwQWIBBcKKdM?=
 =?us-ascii?Q?UpLwWIfelMsFVBZuWpxmHy96XKibTIp+d3TzwG697XTAtgbun1ygqm1y55qq?=
 =?us-ascii?Q?QNBjZSavUJajDP8Fsb3RsNCx+cbBpkDVstifM14KQgzeUW76U+GIfZ5vLMes?=
 =?us-ascii?Q?jUpTrwSChPfYnyZX+GOfx+Fy+XZBAPeKtgd0MGmgUgZ0YVk04FEnkKOhk8DG?=
 =?us-ascii?Q?K5nf4Urdyf12f8OqVv5Mi3P2H2KgBDOJZMBNFIC4VYzrVNUtm9YsC0ljjfAp?=
 =?us-ascii?Q?+JBTwuHDuyWI9HGU5dLzXQPto6WzIG0CpUc2clk/mtoWYBvEZbpIdE7Tq0md?=
 =?us-ascii?Q?Up/fGk17jeV0pmSn5B/W72TWzlzsDTcVsa/kpapw/t9QjecOSilxa64Zm1SP?=
 =?us-ascii?Q?OVx+l65StP+O6W81EpxUZ4JUAOlCCz2QR8UB3x3SEkfjWz6ywMeJbgr24ReI?=
 =?us-ascii?Q?FVn1erQQzvQT5+ikwZBtt22CgoRpxPWeNQpuuYf4g0Fa0mTkPl7YGkhgu1O5?=
 =?us-ascii?Q?ECi1vFhhZS1abW7HCe1mppztCajvJJdBr3YePs7uyuSTJw8aQV5d9m5maDV+?=
 =?us-ascii?Q?hPjqGrXXnYPFyBiUuOLaZz03ubehB39XjIaAN3CRaNY2jLHfQXD3DL0TfUOl?=
 =?us-ascii?Q?gikFXMGM2jcBMJgYe3Oy4YIvt3ep/LrNH3GtkifGF5KHCaG7aNG+mxt1E6Zq?=
 =?us-ascii?Q?w47DQ5Mmxh0pCgeajU8Lw52RYJb1jkPQ6F3EtdwxoKXYLc6UicW+X6RE2MF8?=
 =?us-ascii?Q?8zGT/L0O7ImDdEl8UqNtTM0gt2uT6l6zci9WACbXoG5GX4h4GrDzDRi26leg?=
 =?us-ascii?Q?0xTeC02ZMCO/YZnx/MZWxkjr/WsLAH2EV2YqrdXqex20O14GWpqElpeb7FId?=
 =?us-ascii?Q?XtXrJBD1S4Np/TOaPuox5xLV0H3gf2YrX31mCbZkm3wcF0rxlNtifELi5BHx?=
 =?us-ascii?Q?7C+KmxBMHKpFZQRzNlq0vEeUkbekclWlweOi1R7/tZ9sWVN19GxX65JrlBhC?=
 =?us-ascii?Q?Fx8Kn7Djgn7XZHvkZaVDyEn8/KlRzhrd/nDTNWtYMAAdRBD3RB5GlV3xK1xN?=
 =?us-ascii?Q?gqd2QAfopsyvpfVsjX70+QZVhGX4hiPUYb/A6cjo5OcPQc6dQ/KeXY7NuXqB?=
 =?us-ascii?Q?u8mVdqa2HWTgqjXupMtfmUK7vI5FkTngTotBjSu9skvfZSqjSZwbfyYr7Q7f?=
 =?us-ascii?Q?B82dFKdrGWAiMibUH4VoQdUiIRvelyEODYNFI2YTdsSvntxxjI=3D?=
X-Microsoft-Antispam-Message-Info: 7pcI/XC72TaXXHgESKc7O0mx4fZy7//i2Dd8cOBMaJG4/DHAtVoT3hISGnQ23vAstOUhcGsieq0SeNQlr4Wue7me+Xc21LDAzYZGZANwwSo8K+94yctrTE714MybkeZgVsVg7+ksLoW4v+CKzF5UOLg32mTqrfFNZsaPpKUxw5GzhgcQyCJbVkt3/RAkKKCY
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;6:QlQRnghDJXVDNjgkCx+qTBgEQ9EoZfwgEdQYyJnaue6imI64SBcD1ZHkErQuEWgPQyjf/0x9cbgc7ZNyfsYRqhtPYYONdLs9MQD/Q9GHRx+BFwwDrkgtZ7Nyc880KVlrxJ7JNR7Dtju/Lxqmo8cndx9yqI5/CfjNyaI9lDqszKsIVQCTd0k9b5yzn6kUEMJTsz97HYCEwCNU8qe1uO0elpQ2DroPCgqx9/ll/+ScoBhuHFfQiRgN1FNF83QH23lUJCq1r3IHZRVaaUeQpRZlLIPA3ghNSKboqPvzJ6iyuhBWInR/RplM6qegU2tBI6iYw+qtpLsp8fcBxsCMARw5Hc+WTN900InUKoCmsC5Dz0OGyq1fcxonduld+W39PDv03Hz8GQ+GhWYjM4jOuuT9gwvCgllzzPcxmE9nrOKyxPVGBf9hvoaSvywY1qGnOVux3hFnEsACXVq3sLYF+bVQ4Q==;5:/yD+QPz/AqxL2dDGkp5h0LELOQOqljuiQMwKD97U4fx8Zq+R6le1EBVc4V68j4AHNDvtZmcsF0JmvF4wvF+7TNCMbzTD6dRl0VuK+J9hsce9Mr40gCHZSeRJnKOoJ99rgPqSp3Ss9DPD1ZDheJDJaWve14lF32VpCfR9vlxfJeY=;24:MuH/65bwCtFYpvSQJadSR+cmmrcp0gAGhQe52Yh2/uUQUNdd+gYL0nv5cArUBPur6AhQL6JwPnVl6gLX4mr1xnrwlWeLhwAgvRNJg8ZWc/0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4224;7:bG0nUUH/xex6hWfW/wzhHd0IFFxKG+HZyLWZcaTdEWJDDDp2N5jgiJ5Dcj0o7lY5hY34CllTwT3drvw2mUtX8j+SOCG1rrUyC79L0dx0GshC/s8u1gfIDpfVw/O47neaF+ZK4gpNxR79Gc/D/3qzh5mCizrqu75n7g1uLPv10zmodIeJoQDar1ZasKPMhZTvoHWvndClrSlM/Wad36U5+OAU1I+2tg5cQYfdeafo70UR+1B2FlD1Rg2es8ogOmmW
X-MS-Office365-Filtering-Correlation-Id: 8d37d646-903c-4886-3bb2-08d5c22bb205
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 10:38:43.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d37d646-903c-4886-3bb2-08d5c22bb205
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4224
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces of_clk_bulk_get_all and clk_bulk_x_all APIs
to users who just want to handle all available clocks from device tree
without need to know the detailed clock information likes clock numbers
and names. This is useful in writing some generic drivers to handle clock
part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v2->v3:
 * remove #if define condition
 * use kmalloc_array
v1->v2:
 * make of_clk_bulk_get_all private
 * add clk_bulk_get/put_all
---
 drivers/clk/clk-bulk.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    | 42 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4460ac5..6a7118d 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -17,9 +17,11 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 					struct clk_bulk_data *clks)
@@ -49,6 +51,32 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
+static int __must_check of_clk_bulk_get_all(struct device_node *np,
+					    struct clk_bulk_data **clks)
+{
+	struct clk_bulk_data *clk_bulk;
+	int num_clks;
+	int ret;
+
+	num_clks = of_clk_get_parent_count(np);
+	if (!num_clks)
+		return 0;
+
+	clk_bulk = kmalloc_array(num_clks, sizeof(*clk_bulk), GFP_KERNEL);
+	if (!clk_bulk)
+		return -ENOMEM;
+
+	ret = of_clk_bulk_get(np, num_clks, clk_bulk);
+	if (ret) {
+		kfree(clk_bulk);
+		return ret;
+	}
+
+	*clks = clk_bulk;
+
+	return num_clks;
+}
+
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
 	while (--num_clks >= 0) {
@@ -88,6 +116,29 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL(clk_bulk_get);
 
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks)
+{
+	if (IS_ERR_OR_NULL(clks))
+		return;
+
+	clk_bulk_put(num_clks, clks);
+
+	kfree(clks);
+}
+EXPORT_SYMBOL(clk_bulk_put_all);
+
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks)
+{
+	struct device_node *np = dev_of_node(dev);
+
+	if (!np)
+		return 0;
+
+	return of_clk_bulk_get_all(np, clks);
+}
+EXPORT_SYMBOL(clk_bulk_get_all);
+
 #ifdef CONFIG_HAVE_CLK_PREPARE
 
 /**
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd088..a76fdff 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -279,7 +279,26 @@ struct clk *clk_get(struct device *dev, const char *id);
  */
 int __must_check clk_bulk_get(struct device *dev, int num_clks,
 			      struct clk_bulk_data *clks);
-
+/**
+ * clk_bulk_get_all - lookup and obtain all available references to clock
+ *		      producer.
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * This helper function allows drivers to get all clk consumers in one
+ * operation. If any of the clk cannot be acquired then any clks
+ * that were obtained will be freed before returning to the caller.
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * Drivers must assume that the clock source is not enabled.
+ *
+ * clk_bulk_get should not be called from within interrupt context.
+ */
+int __must_check clk_bulk_get_all(struct device *dev,
+				  struct clk_bulk_data **clks);
 /**
  * devm_clk_bulk_get - managed get multiple clk consumers
  * @dev: device for clock "consumer"
@@ -455,6 +474,19 @@ void clk_put(struct clk *clk);
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks);
 
 /**
+ * clk_bulk_put_all - "free" all the clock source
+ * @num_clks: the number of clk_bulk_data
+ * @clks: the clk_bulk_data table of consumer
+ *
+ * Note: drivers must ensure that all clk_bulk_enable calls made on this
+ * clock source are balanced by clk_bulk_disable calls prior to calling
+ * this function.
+ *
+ * clk_bulk_put_all should not be called from within interrupt context.
+ */
+void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks);
+
+/**
  * devm_clk_put	- "free" a managed clock source
  * @dev: device used to acquire the clock
  * @clk: clock source acquired with devm_clk_get()
@@ -609,6 +641,12 @@ static inline int __must_check clk_bulk_get(struct device *dev, int num_clks,
 	return 0;
 }
 
+static inline int __must_check clk_bulk_get_all(struct device *dev,
+					 struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_clk_get(struct device *dev, const char *id)
 {
 	return NULL;
@@ -630,6 +668,8 @@ static inline void clk_put(struct clk *clk) {}
 
 static inline void clk_bulk_put(int num_clks, struct clk_bulk_data *clks) {}
 
+static inline void clk_bulk_put_all(int num_clks, struct clk_bulk_data *clks) {}
+
 static inline void devm_clk_put(struct device *dev, struct clk *clk) {}
 
 
-- 
2.7.4
