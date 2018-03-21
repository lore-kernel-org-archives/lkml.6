Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCUDUy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:20:54 -0400
Received: from mail-db5eur01on0048.outbound.protection.outlook.com ([104.47.2.48]:8362
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751883AbeCUDUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:20:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH V2 2/4] clk: add new APIs to operate on all available clocks
Date: Wed, 21 Mar 2018 11:19:49 +0800
Message-Id: <1521602391-30356-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
References: <1521602391-30356-1-git-send-email-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: KL1PR0302CA0002.apcprd03.prod.outlook.com
 (2603:1096:802::12) To DBXPR04MB320.eurprd04.prod.outlook.com
 (2a01:111:e400:9425::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a78da958-1e90-473a-45aa-08d58edab701
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB320;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;3:B4Fsq0XrKALkK1VXu9KuUAehOh3mastCzaZerBONpREPGj/6/DzmkXVoc4X8OWtJM9x72fbZ6vdLlz1LagxzgD6nx0LP2/Zh1nfiIQEVkVLLwwopeWdOJcNlOwwi9VJS10Zzszl2KJ7FDcLdCeDAcUSWsv8ylPoa0Imq9JYXC3w71mlPSMFP1MjGv6NjDyzIWMQfGIzo1SQb95WmVM0HeP0XXY0UdWZvMfcB0+wMPdVU+hnFr6HgEAbxRiz9J6Av;25:urBNEmG0hDS4WckekwJfM/ZCwiaQdw+c+KxjqmWCHT5DvYl3SbbUcQmgeAJM3XuQVIkU+XIws1MFq1t/LiFHUd2i18Hr8Gi2LtS5LnE9AojH3nEGiYfcVwAtGblDtLZZpDERek2CvPuzG9TBZlxUBPf58p55jB8EJFjJR7TaduvrY4W4jFNFpf3MyW/bzLyKFKswHfMlDMVD6o4odObVJzrOQdXRcMFc4tbc8BhGUJEVl2EPSDCG3f0t3ITnBB3vAjjLqKE5ax2l0bqFpSmN5nxbxHhbhbmseRNrCUhVAFkUB3CCOXill/znOUOJNaXq60cgBpJuDWS6Lee6tN4mlw==;31:1VNX1AEVpccafCfDdxGQk/pU+Sy54u4mFA9dpx4Fs9vlooAlfhqWGX3VNa9iQcxz4XCxNNcmqTCxAsomgXC+urs5Wd8S+sita12x0/VO2FwVbEYwCtNowl0Nk4bdpKgOcQEqBo0nzpzVkJMxBiTRsZeoMe/QW7R9tSzkc2q4mQ8HGtUMYQ4ejI1bS0WPIM0TxXa3AGEs21I673aLucykCzCiiGuLJfsBeUr94z752Rg=
X-MS-TrafficTypeDiagnostic: DBXPR04MB320:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;20:NKJtLH4rwU+Ive+lwwWt4Nl83khzK7U2QJdpP2yeAW+tufLvY1Op0bjBgMZEdTsjdJNh2Jw9yWQ847E2HDryR07+52YvD0lNXJBaoF0LqpIokcbPN+ejJJPaZCVPkLI1Qq2Zjdb3DEWu9SfTTexxhqkDYD/DSwVbebeUH91DvpKupRWYdv4wvy6Avwbq+ii11QEo13CiPV8biaQJRrAjneozF9keO9nuKmxMAU47fLYCBeqSQVs5oe0CnyE2IQv424GqdTc/JB4SuS3K5LSR5qXR+NAu2ICcu1CHz5mtHd0NJmfUm32nsemBLjhWTPSRRfEFSArZSvHvy5H/+EZhvBZvq8OoZoyK+J8P1L6Tb/pRnqZCRnhfky8dqf5VcvJM9TqRgO9jERpRdFo8IsTKmgxP2Sw8UPOaL5x0+7guP2Hal9T0ysl7GskI32l13uxF/H7/lt9vVZL36sZclMCAo/Juiw+Idt4gDmSfoB0ozrCgCT2f9clutf6PJi1t4DiW;4:TcPPsYYE5KmNJ/rDWtFlh2oORFwUEwUW5NuzeLvyvdpKArgZ+Owz2dNBN9stl02YlL2iBZy2Ks3BHoVI+/cjNW925asnf3Tl3QABy+O4IAk9MWq+29zV1qZNzXlLpjMGpxN5NK712ozNTw9QkCrRoPchCZmugMTMyXzw2jQhr7VNarRfC4DOx9qA2VI1yfFhDoKSdlwiPcrzxKvl5/ORkpOetEivxmwFSgxJmWlTjInP1RJ4GkJtgSMvCidqOxuSCEA+LdTppH5WD+LbwLMiANMhJwJ3gQK5TfeqXKzws7hmFuT3EpQ7DKbDl/9HDgbi
X-Microsoft-Antispam-PRVS: <DBXPR04MB32051D352BA03F6604B295580AA0@DBXPR04MB320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501318)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DBXPR04MB320;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB320;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(6512007)(47776003)(53936002)(186003)(66066001)(50226002)(54906003)(105586002)(16526019)(478600001)(68736007)(25786009)(106356001)(4326008)(6666003)(2361001)(6916009)(16586007)(2906002)(97736004)(2351001)(316002)(6486002)(36756003)(8676002)(305945005)(2950100002)(59450400001)(386003)(6506007)(3846002)(7736002)(6116002)(5660300001)(7416002)(81156014)(50466002)(48376002)(81166006)(26005)(8936002)(51416003)(52116002)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB320;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB320;23:LlAvtikE33K9AuFnwBrr1b3MNiOhPfOoj9CoUrQYCx?=
 =?us-ascii?Q?VTcbfXKtJzf5tcIfFNLhqHjZiECJy29tEb9OPGyXVfsLxNwSzTI99OOookpc?=
 =?us-ascii?Q?TcN/UL7myzJjCye6qwr2bykZH/jdTVhOH8HCX5KlW18nTgXpjj4S9fuXXMi3?=
 =?us-ascii?Q?qtk9VhE+n4toMIdkCnS34ltQAWutgeTQNDGCdYHAFNGH8UmWWmwd1d2QAOdj?=
 =?us-ascii?Q?CssWM+ZZhUVEQazcc/f3klPIehXS5DNEkuC4mv37dK90U0l6AQ7q2sCwMWdt?=
 =?us-ascii?Q?fIFEA8myMnOkhHTn921j3dsxOxm6BrLPg6uDS6VL158GM/QRlewPTdSpS/LF?=
 =?us-ascii?Q?Q5zXrOSaksfATMKkSSAd4Vy8A3Ghor7FP6ze5EnHfSeip+eUzE/hBKljfYQR?=
 =?us-ascii?Q?E2uXeNQNLE188sWTNtHJyEkgwX/wpgSrTRbZEE45ScJU3OEJIqTTsqG6X2xS?=
 =?us-ascii?Q?z1h3lbOlTbFtCtW5Unnk1LakcySOP7pA+V0tDGEVK74ZF2wn/OMUbhRavMRq?=
 =?us-ascii?Q?lpfB20d5F7Ml3nj4api6CkkEAG9KnNZLVbf93MInNq3F3nHilSDeXzZjBu18?=
 =?us-ascii?Q?FUx4f7fj7cwatrPSzFZsVvuDHLaTua8DpTBdC/d1vcx7PHJc7BY54W0KvNRA?=
 =?us-ascii?Q?ddFVqBPgO7gxYaU3HiIJTA1XX0TDqBwn4htqfxQOyl1wGGx+8zZnjAMpjfQE?=
 =?us-ascii?Q?/hPg80Thwzz8cI7pvaiT8O2Js6STjVYoAOS74B0e0QiYj7qbVifrBZyvc4eW?=
 =?us-ascii?Q?MGKmQ00/y6E1B2GfdXwNuF2NyETn+gcaM/mpMqFmFowFUpFV9PsPyako0L5l?=
 =?us-ascii?Q?30XjWc0EqIrFHl84qTfHKf59ESRtaO2qDTwNtA87dd59VXAjQilqN9BvHkVd?=
 =?us-ascii?Q?ui7OCyNZ+vp2I+8w0/OJ04yOgoKEbMLW1oAO9VoHSLYNrpIK0usNMoFCwhPA?=
 =?us-ascii?Q?yICl8+9n+gfnKLK4iYrPw1mCJDcnzAytERaFEKLBxT1ZF2a+oKQKy555wYRD?=
 =?us-ascii?Q?+KIxM2RxD8E3RREIjCnM0GGuXonaiArONh2b+gPCxTgxNnXJm+4jyV13Io7l?=
 =?us-ascii?Q?TIfAHzvqQQ6zsaaxo6HKMZiOmKyVB1fz5vzjVmm4Y6gR/WdmxTaSZpsVktwQ?=
 =?us-ascii?Q?o0EUEWA53T20PmmBJQJccJ5bF11wsEhwCuEjnveqmyoyhNRYPAKQn5B0NOcB?=
 =?us-ascii?Q?NdSjlZD5I3wcZeJRb7urOL5kOrsv5WuXSU?=
X-Microsoft-Antispam-Message-Info: 8YDu5qj4OakyISNdstqMZD964R8ZC79CXM1ITrPwKyw1WGxNk2RJT9fFyemr3W1CAjk4I/XraZN00Dd60p/Hov5HZ0rSoTyArFZTGVRcz4EhIJslodsT1B1d3KqATBb9k9Fw0WFo7T9cbNMVRB4JPUQHBPkR7Ix64zWQl+N/JnX9xni1wNdrPC8hZm+pfWlc
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;6:zcFjU9kheD0v6dLxHkiJK6SSSZvNRexrVt49ZCFON9hpNHNrDFQ70+3CXENyD0P6W2IoM+vlJVQiowuaBOgjNayjDfpGBAdAMHlvim2nk+KWRZNUs4fm9FuwRl/NX6+vVztly+yeHckkCWqAkJFQz0MV73YgjF/J/nwAKtb52vXm4tRGM/VBrdEYXN53E2bFmofDhveB+I5O9AcK8sIlF1IyUZ3CwkUBSIIEikHv9UEhxiF9uxqRBb05DefPrdcY3NAwehpfODvIEtfnEHv806SwUsDV7o5wF7j7uswrpB61kOsZINkqbxVHy/T30+hQmB5+jSpruQ6DFVC3oqZKV1lhso8Mhg1tekereulBKcQ=;5:AP8rQEtOkbxRMPAJfkBF2X3EDUJ/qivD0ARkdrA6RpavrM2iSMYiQsXQ5rHOB+uWqmxhkDtYrW8jKQ3HBMN8ML+M17Ri2OAqcv9xDLgSXSBp7m8ixQ3nf21x4xYakqLED2q6iPkVGlRax/chnua6i+7BYn2wPFThPtmPBiMoEXM=;24:bVQ4oHVBbaNo/tLFFDxJAeRRCtUJD723akL3ziQKbzKa961Mw6JK/Xch7XAm4uUPO4NFVv7teUxCmef9Tldbo3dzuSf9q4uxhgJPtOSqzHU=;7:hpTScac0a3iibzUbxITQB7pWJTWYbvAKZGS78YHQU/5DT8KGCN1hA76ipl1QeKpHIr9mZhELhnIcEi+E2mx8ii8+iJNs6FdDZbMhq5iT1vZR+MhKnszXvq1tCJr6SBP5S0zcqh4pqtwmD10j+BA5HKNJWSYBWloctj9BdPdz5BYRqcVv9LlOYbkOo8l/c+RNOtfpzs3wos8yuDv7lkc4LkHGQcYVk+JsfGXo5fsKTSSHwjI78wGRs7581o277Eiw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 03:20:32.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78da958-1e90-473a-45aa-08d58edab701
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB320
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
v1->v2:
 * make of_clk_bulk_get_all private
 * add clk_bulk_get/put_all
---
 drivers/clk/clk-bulk.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h    | 42 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4b357b2..3293c6b 100644
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
 
 #if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
 static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
@@ -50,6 +52,38 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 EXPORT_SYMBOL(of_clk_bulk_get);
+
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
+	clk_bulk = kcalloc(num_clks, sizeof(*clk_bulk), GFP_KERNEL);
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
+#else
+static int __must_check of_clk_bulk_get_all(struct device_node *np,
+					    struct clk_bulk_data **clks)
+{
+	return -ENOENT;
+}
 #endif
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
@@ -90,6 +124,29 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
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
