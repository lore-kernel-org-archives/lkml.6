Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbeCUH4B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:56:01 -0400
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:12512
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751626AbeCUHzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:55:47 -0400
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
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V2 3/4] clk: add managed version of clk_bulk_get_all
Date: Wed, 21 Mar 2018 10:54:53 +0800
Message-ID: <1521600894-29919-4-git-send-email-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
References: <1521600894-29919-1-git-send-email-aisheng.dong@nxp.com>
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131660925450075236;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(7966004)(346002)(376002)(39380400002)(396003)(39860400002)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(51416003)(105606002)(356003)(47776003)(77096007)(26005)(36756003)(106466001)(86362001)(305945005)(85426001)(336012)(76176011)(5660300001)(26826003)(54906003)(16586007)(104016004)(6666003)(508600001)(6916009)(2950100002)(2906002)(107886003)(53936002)(50466002)(81156014)(81166006)(48376002)(68736007)(8936002)(50226002)(8676002)(4326008)(450100002)(2351001)(97736004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2767;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD006;1:v22cTTxS7a5Hu+C7qd4gpw2RfIl9PmddLmmgzlvsvpN7pIDwe4rGmfKJJ067jHpN7dxxIwrStuXcAdmfySozmbSwzNyqwK1fjwkzchtaxs92qjwm/w2rnTy90t88Wufc
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69787362-9198-4051-6e9a-08d58f01269f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:MWHPR03MB2767;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;3:GI0OXUtolYwnZtaWJ8+Vf8NnhKSjcbiMN5b/WldQaNbQl1oBaZsl6A+eMTD1x0GjBRQmb5w46/6AAoJSd+LQl2gmm8VN8524RBnztHY7fCrS1OMVOdHH6GqqcqbyDrTa9HT4lIVW8bFVkoBfNhx0KUhJyW0izZCMyp7BL6G+345lnHGPohUNQCCh0vVVzdItjOxTxoWE5gJwiYsDOLg6fWT/jbhAK8S0qxj+z+Ez4L3tsQwjVwGfCt0xTZiQOD3mpnKwN0DZjz+79p7HjPHp2XqOLI6BSEG2H4W8HFsOAZzmuReb0ey4jtmMxZ82lhBFNV2pTEx+lbKl1WNJe44cf8N14kott+/vNOxdWOXBqVk=;25:3OeiojTUuKxfg2FmQy3D1B/gIR4/3WXOPSGo2mK7BmDiLrgqjp0EBjPUw2LLdozDDV9ipzcspHGXwYuABywuAEklEXslXCVw0DpUU+oOCx7ZTTdPp5z8iBL4mAyVDIoXQAeiOtyadNytx7+OnQdO12RLh/rzQmK3qIIpo4zrCZk2RRYW3JAJrcUKvgRKHNGhA5c+/NihAnMeyaKiz7DdvFHiSrtoav5aFhX8NqQWmQeRJTNo4h7FAVLcWg6YMxnAMPWiQN3IaZhXFc8636DXxToKHmibYu75LEApZzvhxHk9HghjCgtl37o+KvFInpxI9iggaCkPvWkBKgmz7yN8rQ==
X-MS-TrafficTypeDiagnostic: MWHPR03MB2767:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;31:/V2zcXg+zAPkKzuqQ94wCeDS96/FnKdKr42JiEGKPU4QqLsF4bUsAxCbtk99Nv82tje5R4bGnAvgUjepLYOKVnrFWVb6qkczlavhXEiWSmo/+d49YdOh1u04o+oFMCS747ELFXTLgbfTeG3EfRFahX0g4NqD6osRkvsbP/3gsX3lA/klSMcAmnLhXfMShbOBR8CdyDwnmQDKpDhPZ8FfRQqpzq7W1ZraXc90xnyw+Ew=;4:AWlHVHDzyEa4D0RquIVxYJ31f2K0kzfchyTrnaVAyM0+4680WxPnjQfVfV5VCtwfV0fCWVXrQ4qapmgwO34k3o3J2JESDfhKCTjkT+EbFvshyC5/Eo/mj1axXfopXt8p6VoWSiBb5O5l6KMJaDUqfaC9M2A0Dtv56I6PVNzs/rBL65+2WOzvK4WdP3a6cnSHbJ8Lm2YPVc4LtiGYxOYr0lFsy5Z5XnAyOJ0xnjkbnIDGKKlvtMsYgKktZVm9KEJmvlZtdgMN9dBHv9VA4aDXaOAl5S52OLUAuBhnpe/pOtCDv4tvTL2TYx8b6LKABfhw
X-Microsoft-Antispam-PRVS: <MWHPR03MB276760E0C8ACE9823F1286F580AA0@MWHPR03MB2767.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(8121501046)(5005006)(3231221)(944501320)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6096035)(20161123563025)(20161123565025)(20161123559100)(20161123556025)(201703131430075)(201703131441075)(201703131448075)(201703131433075)(20161123561025)(201708071742011);SRVR:MWHPR03MB2767;BCL:0;PCL:0;RULEID:(400006);SRVR:MWHPR03MB2767;
X-Forefront-PRVS: 0618E4E7E1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR03MB2767;23:pjuSrsahxy/lWkytQv9h5hffNFyNxSkvQSildVQp3?=
 =?us-ascii?Q?23GMEQNY6NpPgRDi7i4iTnAEXAm7llTcCRvtaTyosB0deEQyN3LL2e2e3X2k?=
 =?us-ascii?Q?uoO8OdTLYfOOjaXGvXLQYvv1UM+oDw9X48vv1VeLQriYmV9M6T4K0L0WbOAb?=
 =?us-ascii?Q?JYBkju3ThJpOghJT3bcF3e6G96CZGZ4r1zJ+p6y9Wip+jhL04tjWkinMx0lp?=
 =?us-ascii?Q?Vk5L+9tDp+7zZGHrZmLcDFNv1KGmq2DBruJ4MIGtXsGUXnu0hm9ItV8jzFaw?=
 =?us-ascii?Q?jgxWRoh5QF4YHsk4tLQoMNupJFoTh3qxWbraRQrTmkMjZJTPqYbhPooqDJpd?=
 =?us-ascii?Q?GBhmZhgOp5ropru+o5lgSweZu3O2423xyjztMKlcmpLs++3Z+vtsy0kRKLkq?=
 =?us-ascii?Q?EEBTr3+kQ0EL3uTwNdqJooy06YfwOIBUWu+0HWs5/ZkF8C3HSVZn6O1EWICv?=
 =?us-ascii?Q?2BSYAd2veY4hYW+wZjUw4fQm4htU7JymiylIbIOzhk8Aixiz1sLG9V3Grk/W?=
 =?us-ascii?Q?79K/XEBryuknjCAZy56quBZpA0MM3xMgzeWa+Wome8I4K6mHFtM7xjwTNt0j?=
 =?us-ascii?Q?3kKZ1HJ76b/H28bVXl7XpDdmR9OLLvajj5m2kfNzedsCecBMa8ck1Y4jymHb?=
 =?us-ascii?Q?ViNruBdDe1b9bZOpnGS6Q+TdWm0TFsEm1gwyesVmfO0e94W7bpulq78WIXzA?=
 =?us-ascii?Q?MOUh4a3nc8RY+gQEfwrWRKq96vqivfUCTUVEue3V5MVT1pE11+KyO0sANWjh?=
 =?us-ascii?Q?kYOQk4cZixuuml3Q6ChE4xVZrR0p9ovVZFzJxA7JoQ3YIE/urqEvO2S3mGrp?=
 =?us-ascii?Q?4fsoytk9/GhM6ROI/f03Z32G1b6n7QcKk3tOwri1FOS0BNootACcYhSQIrAb?=
 =?us-ascii?Q?qNimK34QtlkjfuDNCqbJE1q1BhTW1nUv2Aq9rhXyYMCYBhPME2z8TyCKcYG0?=
 =?us-ascii?Q?GLz+W2r3o0z4etKW4KmXknkolmQqaXkdEiPhB8dhiYUbQOyO+1/UHpgrypwf?=
 =?us-ascii?Q?qBqiV3KdjvBqxyFmq2kcFJxAilka5SmKWz6HkvgbHPQv8DF6SFBkNA3fW+gC?=
 =?us-ascii?Q?jKbXQ7LD8n+4a5MVJS4ypnqELaJq7sSr/7FiLskX8ixQXvIOjFz4TI3ZbMzo?=
 =?us-ascii?Q?jDASQdqK2/DG9SRKG8bpg5x8dW1Pua6RjyQW2xWknaSTkUAslofYQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Zl8MGjVrm5DazmATnn97sRzzKiQWQA6wurysm0bL/DD0r1XO+qPbzEJte8RtvjdmE24xmFfhX85xQa6Dj67bIOeuTmR8ZdtmB7jvFI34lLzaIeeoUxN0sEhEvAa0l+j3HbcvqElyOLp/xQ+y89UVHSFPrP9LOgLhIJl39PgSWiDdD0g957e/lkTQmrgmqtD1
X-Microsoft-Exchange-Diagnostics: 1;MWHPR03MB2767;6:DpOltBQKa6rplgAOFmvnBKC2VeBfYpDd4Q+cfMGYjrRdSGPuwINfLbURUFhgCxsfCrRFb1kyESLUIJs35k7Nbh8MF+O7jzhxy1/FYCC1gvA2lpa3vZkyxGbwWHatBKPBlJ2oHVJjDiJfAiD+ABzqWKd69Bcr5EbP/Kzwe8UDnu8y2h3pKUDhkbXm1wqsZl1pD24vhTEBd85TWdauB1T2L3zvU22ZWhDFpwXrHG897Ca7q2fMCMT3LZiG/O0V6qFLf1i2oND8yz6bHG5oJP7D7l/z1imSlIMAGrEGhQmdrvzQTBJlPHJHRmP5iV4+ukXg38G+oGlbylXm+UT3NYr/1hrHnnaFR+4SU3o5s1oOoT4=;5:dqdqMlEumwlZRtXjBjSvFOiB/KWz0vrHcrfgR9cMvmhB12/ORXmG1rLhQDaj9z9RtK9N+oIm2djCHcl0c4MkBb7ygL8yjYuKYwecyMpeE5oYE4i9m1TSjaWjpT7FA878buhWMWp4i2W2GiZWidQgtMKaHd6T7DVc2k27un28mrM=;24:7Lkdxbnx3gbsGMtbANoSzKOQYyd6dp50OSySGffgKHWAUOoSsQYtZkdOWzmyN6+5kLRrArEpS85Jq1LcoNSF9VAZtxUAJqj1hU1GrN1RpmU=;7:FyNRNx+u4gOy40OAJLkH2nqwF/OdnugjlEmsZG7TIdK9jKD5f5UGiMmM+NTlqKpNgBwGH47kw0/sn7NU1OT1fuvNqRxhNkK1H8EpXz65xf7bRoG99dy2hrzKogSpfukPyVUkLBkSmvG+nOxWsdkN8xqe9BL2k0BftFaXDT27U1fPMjeL6YfXyJPMudGzG89oul0gqLgSUAFfHp/lhKUsMkRw5Y+IrCkw3/9DlRjAG3NXa5dI+Mcesk45qEZ7TLJB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 07:55:43.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69787362-9198-4051-6e9a-08d58f01269f
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2767
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the managed version of clk_bulk_get_all.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
v1->v2:
 * new patch
---
 drivers/clk/clk-devres.c | 24 ++++++++++++++++++++++++
 include/linux/clk.h      | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index d854e26..6d3ca5e 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -70,6 +70,30 @@ int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get);
 
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres = devres_alloc(devm_clk_bulk_release,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret = clk_bulk_get_all(dev, clks);
+	if (ret > 0) {
+		devres->clks = *clks;
+		devres->num_clks = ret;
+		devres_add(dev, devres);
+	} else {
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c = res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index a76fdff..fe48e01 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -313,6 +313,22 @@ int __must_check clk_bulk_get_all(struct device *dev,
  */
 int __must_check devm_clk_bulk_get(struct device *dev, int num_clks,
 				   struct clk_bulk_data *clks);
+/**
+ * devm_clk_bulk_get_all - managed get multiple clk consumers
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns a positive value for the number of clocks obtained while the
+ * clock references are stored in the clk_bulk_data table in @clks field.
+ * Returns 0 if there're none and a negative value if something failed.
+ *
+ * This helper function allows drivers to get several clk
+ * consumers in one operation with management, the clks will
+ * automatically be freed when the device is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all(struct device *dev,
+				       struct clk_bulk_data **clks);
 
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock producer.
@@ -658,6 +674,13 @@ static inline int __must_check devm_clk_bulk_get(struct device *dev, int num_clk
 	return 0;
 }
 
+static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
+						     struct clk_bulk_data **clks);
+{
+
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
-- 
2.7.4
