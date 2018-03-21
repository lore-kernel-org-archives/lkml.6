Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCUHzw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:55:52 -0400
Received: from mail-by2nam01on0040.outbound.protection.outlook.com ([104.47.34.40]:21739
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751615AbeCUHzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:55:46 -0400
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: <linux-clk@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <mturquette@baylibre.com>, <hdegoede@redhat.com>,
        <b.zolnierkie@samsung.com>, <linux@armlinux.org.uk>,
        <linux-fbdev@vger.kernel.org>, <linux-imx@nxp.com>, <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH V2 2/4] clk: add new APIs to operate on all available clocks
Date: Wed, 21 Mar 2018 10:54:52 +0800
Message-ID: <1521600894-29919-3-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660925449139230;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(346002)(39860400002)(376002)(396003)(39380400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(97736004)(104016004)(106466001)(2351001)(8936002)(8676002)(50226002)(81166006)(105606002)(81156014)(47776003)(48376002)(50466002)(107886003)(36756003)(4326008)(53936002)(450100002)(2906002)(305945005)(54906003)(356003)(5660300001)(508600001)(26826003)(16586007)(316002)(86362001)(6666003)(2950100002)(6916009)(26005)(77096007)(68736007)(336012)(51416003)(76176011)(85426001)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2757;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD006;1:+dVGxBPoEL7NeYepJ5cVqoKJdZ0sAg/OWXPwUoHPgyViD05JbE+jbDwwNlHwx8Mx8ZgaIg7VfZ9w+u80TIP+YAO51QBR4pkSvmEyq5KWRrN9arsl6C0P6Z+guxzS3Ip3
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 033de075-bcf0-4f45-92bd-08d58f0126a6
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:CY4PR03MB2757;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2757;3:vo4exdxuuzYw0wTAGe9hsuq1Tuh0RX+eTNYiMzDRLEdfLAepOoK7smWIrd7/ln7NynZnPYhxK/e1RYIat5Ckpz3/mTVlri56luXmIgohSwoo3/TL1gRTEVWhArb4xaiU1x4AD42iXJmZ3cE+ZSHEwUnYe5auCBLBaEHdveTUEwSZ8m/NE8V5r+y3w/cyrQC7+oCwYDVZBuyhkmzU6F0C1gSUA1NuoEZKpSEj2yacsfGjbd32dM1DScMngoNtSgxVAoy4Yxj/SP62VyYh3hjFC4EqgbFD3colkarQ9ffK+3lqEPdcH252yhWgMEEAtwZTYZww6ykYMlqvmf050kIENfRbHv6fcjwnJ3ch7xnhdY8=;25:Vz4pQO9FQBQGJmmTlwIztjJZV/Eec5/1qT0zXNkjThURKAi6+Kz9Kw5AMBVD3T3THt8IE2eESVVcLpfDSbs7MPqeaNCaGgsJpE0HTmbcfatIqPjM3cCtVTigNO6Q8BvadyA58J2yP+trA252V2rvRuW+S0PECxdOVMQeZYQL5L9zZFCJaMchmD1Q4y/jZ3emNQBCiTC80G7I4PRyLfy+NlfTy5k66DnEGZqiK/s+d9fQsutZtq2cs7vgMOSCFvqTPi+rmG05tafJodz/ZUaeis8oztk+NLIOg8mt8FgCUlrgc2Fl14zBVtg2h2HEHc1VmZCWThkHXhtZFtsoU67c7Q==
X-MS-TrafficTypeDiagnostic: CY4PR03MB2757:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2757;31:qA+mZ41MVZylYAPsPBkhZRFIMLcdoAxexwI60elcrBKIkZiyLXT48ENREwzok4BTEOdUt5BmeANEMK08OdyNTQ9jfxdTd4Lg4zIWLfGi2LdNQ3BUZF1H4epYzRa7FsMLlar4ZY4gSi2cv/6GtR6tk8HF059ilwALVDLRS3sE0PhPl9tQCjyzA+M9xDEJ7MxOwc0oX6PLOuUMnoa+70BDokGSj8wIRPQxg11JLVhptoU=;4:ZWs0/uhXzHdri7q2cBgH7UfrSkJz7JGY1zUJ75GfGkLnEaHvgmfxatfEs7pXR5ffNUXcEztem4KGfEX49vmiwNvxGlU7r4juGwnqGIYjMMnA7tZckp+BkOdw0jV/6T4zZZRIHljpxMuEocM1Czy00LggjT+16w81ThI/Q/Ol3xs7/06gsmqCl86P1jMQiPP5W/3VHvMVK2o2XGUm+ugEzcRFUsgP7HkEs8YPQRmglEmdfkF89UzV134P99udiqA9UHu9CtAtk3BkWwYMj3JNdUtBuTHqIPylHtyGdcf4vIdkNLCXYcf32rdSCl06ywjR
X-Microsoft-Antispam-PRVS: <CY4PR03MB27574A35827C442DACCAAD9080AA0@CY4PR03MB2757.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501320)(52105095)(93006095)(93001095)(3002001)(6055026)(6096035)(20161123561025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123559100)(20161123565025)(20161123556025)(20161123563025)(201708071742011);SRVR:CY4PR03MB2757;BCL:0;PCL:0;RULEID:(400006);SRVR:CY4PR03MB2757;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2757;23:mslF6VyCVUIIoC+Kf+v1zLUpJfy7ADGqu2JGy8Rrj?=
 =?us-ascii?Q?iDTQuARB69EyYtxwqzhFRK+OsmQoaDyPY30IcLgA677AFE3k/wH8Egmm50V3?=
 =?us-ascii?Q?who0v4E5hHnq/8DnBp7/JeoM/voQSvbyMaZJKSkQ5dntxo9qXyXc94GkU08A?=
 =?us-ascii?Q?lDJR/XXesDtSMuGZrd+QTL9s/enegIayEu3I1cMU2i36ApoAVA0h9C2YtTI1?=
 =?us-ascii?Q?Ig1/3uV/ZGcauWLBgSzM8kKqmabP21VosS0tCBZ5gG3DrbOUz8aA9RNvsU2O?=
 =?us-ascii?Q?gHBskSVvbV0AX60CzrnKNFNk+QWUK8UnMGzLNroEQfgPXTuoUsfOI1BBwJZ/?=
 =?us-ascii?Q?7a9Q+AYNbZAz8XzoWEC8F7LmHCdVPo4XiY7XR77sprB2//A0zDLCMhcaHRrk?=
 =?us-ascii?Q?8+2HkjjrrUrB1dOCHo/IOSX6DR99YMaJWbjEbANcVR9tYWac/b8eU2AwxlwP?=
 =?us-ascii?Q?7Cv9cekzrryIN22CjYGyh0uXYT6ladcEQaTGuJSHoRgkZu8q8XZdX1K3W7Vb?=
 =?us-ascii?Q?jisImCcrrQd5rD+gHW5A3iDTepiM+JG6l3fUJwEQvpB8NlTpq53emyca1spc?=
 =?us-ascii?Q?F/R0yEM075bj6vCnmvEq5Yjog7EBYxToFD5VqOXL3b9jNr0c1g7x2fVezemn?=
 =?us-ascii?Q?XRnpYgsWxjmEJF8sRXyHEg1lyavXKRNl6rrFTq/yQOs4Iae7AMtkeU7akCyH?=
 =?us-ascii?Q?kSUcIKn3fp9ddpj1YbvQ4FZCzAwz7xzlh45+tWsM8kLA44sxabaZ68CdIrjW?=
 =?us-ascii?Q?KwnP8Jsofpeys4KhdPsMmLBYqaff82Cu+p4SnWAvw9wIp0hPn+1KlVlK43CY?=
 =?us-ascii?Q?N4vPMuGx7iwuO01EiZ01gfPJvYuD5N3Wf2+2Rt1mqwpykzXT4qWDopRfcpmx?=
 =?us-ascii?Q?80iScJpfBHtcmk9+gsDkA7xTbzFtjLFAmjm2TFO51uZ49afqHPOSIK4D8Kmh?=
 =?us-ascii?Q?NJTfZeVtW9lgphNsnNWGghRgObJaG9e4z4VFBRqt2to0oYbYSr7QSjt9eQzb?=
 =?us-ascii?Q?eqr0g4qVf4vEpdQnZr7VJK7+WhZYHJ8q3MXh1lCu/cUvuqMCrAje5olgAcvV?=
 =?us-ascii?Q?Fj+CtzmhcXA0mO4p888F2TsCZOurrqWcU7cpIUSHDSRoMHadj9iLlftACyh9?=
 =?us-ascii?Q?CbhOUq/NZ2CafV+R1FKBnsERUQhnkxf7AEpUZMxCUH6tQaVSwCyFFPzxPyts?=
 =?us-ascii?Q?5ojkMZFv1e6dUs=3D?=
X-Microsoft-Antispam-Message-Info: M4WOX5wGZh7vLrJgN/sFFvT/1iO0/ZyR3Vk9Rlywys+ACl2t5DbAudAOHU9vLZmTon3eqy5MMgagf3XbasI7FcAvLD0YJrAwMe9JId6LinpZkMs7iD1yOgO2YgivGAEc8F5U3S3r5jJLnZrS0UCopdLPor1OBkvbaJtR07IU4pyI94H5rCsaAYcoMHnqY79K
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2757;6:soi605DomdrCE8dQZZBq4kfHVtVoVVcvcgox44c6uJsKpsLlmOLZR/olk5j2Cub/oGxgZGl6uVHIviwvyCYlZh9Up/IRd2yFXRf1crFp1RjHQfDsX7uCWRhGSGImxqmmM1Oh3j+2hPhLcjSJecv6i3nfl/QKLDwGFNjejlHbKFGKWF4fX1zQ6/KEtMoM7JTqRNuyYp1Q6ELmWPTqrsXFy5V4PTGZVqWhZrZLaRW968xKIrEqUmC5xdFGPsN6eSL41aBLoRyv7/W77LVftIeiKoAMuECDv5T+q1N6iA+QxgT9hBWCrTxNZ1t1Eqep7RzuuCWPffAyeExApyU35cSnPTK3NUvVML1iQU1Z51fZL3k=;5:Gk3XdO/ZbMd+2bkYymdgufc5GjsqPAWwsTdmANWGOSQdmYI15OMHv8Q060KWGyXcKCnVejkSIz3W5hoOMnAs+8xKQ2ef+DbfQ8H9c9pKqN/El7w4nZFw5Mz3wI7Jtsnsqd9XdxcdoqPUsf1z0Jb2geEfyGfMn1PoIlZcRiy5y/4=;24:xklDPb/bV1WFQBhVSPD5Qj7fqw2/KakgxQlBsCwzmGmJIjBOTvVt4jRE0DX9m27zhJiqfHBLCf5pO7VDJ7bLpR7Kdv50RYfEZfhckRNkA1Q=;7:ROaUNGa8By2ZBGhNFMM6NfYq9gQFhVhht6IjKFXGpCat1EeQvplx2usDNi482L7oXFIcIpe+XbuwqkAvucAWtm40tHTDJEUSbIXWz9/Cn3uMwxRqN9+4F1YMxHTatqFyDdWkx2HjwO+0QkBwpzP1qcU58fNnN/Qj2Euy0V/sgzmg/XH1Jr8Cmg2bDmZYV30cS6+Orlfj9S0eZFIElYUBv4gyx0n2oS9OlKPwt4LXmCsouK2Y0PHKYpSAkYPM397P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 07:55:43.3851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033de075-bcf0-4f45-92bd-08d58f0126a6
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2757
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
