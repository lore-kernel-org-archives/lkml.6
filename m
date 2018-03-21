Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbeCUDUp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:20:45 -0400
Received: from mail-db5eur01on0052.outbound.protection.outlook.com ([104.47.2.52]:36757
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751833AbeCUDUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:20:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com;
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, hdegoede@redhat.com, b.zolnierkie@samsung.com,
        linux@armlinux.org.uk, linux-fbdev@vger.kernel.org, linux-imx@nxp.com,
        sboyd@kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH V2 1/4] clk: bulk: add of_clk_bulk_get()
Date: Wed, 21 Mar 2018 11:19:48 +0800
Message-Id: <1521602391-30356-2-git-send-email-aisheng.dong@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e06d26b5-f539-4ab7-b717-08d58edab427
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DBXPR04MB320;
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;3:YIy+F9+2ejBy8U9g1RQ381cKJvdt4csOXl1XFJwH1frOAvrG0d0YQBklubV+1l9ZLDeJ12iNYaxRTUPDTS9sQWD/860hL7X3wWgot7fE6hq4bzCPmtt7daqktF/RALcrUOvRWHWaEs/DTRAyG4zr3Hg4jy3yZ8smUcbZ8HMx/qINtvdfzcGEKnbuuekax4X4Escx/7L5R1gZ3T6kp5WnOWGLp/RZ3Q25olt6/PjSvCEy0+ksPF2Ak52H4yOmlaBu;25:C9Ta9YP8CWHXj7NAw/+d8rl167tjje4ZKMt8se/vfSinksRRf1p9YGey3+qje3AhduPhllocSss5CBgRP8bJijlmVKf41Xs0n40CyNm9PtRB7rk7QC9fUi+Reoii6Lzi+b96zVwcFgOZiB9/ChVrwQy+3fA6OMpYCRuujLkKL/UsOekNp5Y9FhLxW6nQ23CmoL6M5Onq9gqfymzPQ+AVwpNlh5DcDMNoOqylBRQI9sM/lmb83CELqVrE76RV9BpOtaPnJaGwWENY6K1o8Vvdlbu2p+dRw5Fyi6mEV1Aw2gBIxl4zj1nWygxjMic1Xr5chTaxQyNYah6ImmlY/AXnqA==;31:ppa2Lk5n63o1Doa4BcwRNZNpl7RG3FFCfOeJrjnAzQFjPA0xDToDbNmvkLJzBjufkjXB5/MdidOddaljdradyw5OL/88bKq400dTgmRHg0o3d7zgDYeqXj3kTOYipnZBRIMmaeEsF2eULxMvOjqYY/uVn5vW6Wmv33Jxkihrjb091obYZbwS+l9EFodBntbrLhYwTwxCmbcrFq0XWFkwi8nahAJ9BNtIK9O4rvcijlk=
X-MS-TrafficTypeDiagnostic: DBXPR04MB320:
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;20:e96x/+K598yR4Mjkpy6tWXkSf1U2YjBC3jf4gqwgw0ZOdN5tEK4R2OWTtENbEObGEVD8+lXPH9tAUjpCtj4WRGqjKm28W9lKyWYPZa3dRz+987syiIydm6BkKrL2ktbRgYttZIUSD9+nCfSB4wC8Zvjs6xCs9B7DqWigbQdPO9zVkRR9v5PqfCllg+IGINi3/9OWHQ5hnyw+OyKhsiI0JGxkBn5tMr2X5s2sdHbAkxj9lijsCmQjUUQgC0R9d3Q+2jpORqqPSHOvZrU5FP1ZbvWLaFzcXaqn/1cHIAcWZ4LYrDehuMYnAAfZtOQK9qPYFaA6JXYakbWVq6vSQSW4DQn2WYaRHRyqg7RR5Wi+gTsfYIBv9vBKXwseoRrKJ23dRcCVaV9VkRsi43XUfubTmZgcX8dcZM4Qjjk5UCgg6KZdMHm+jDHy6D53ntwgDzZMXPFaXcScPn+QSVLJc05KatOGQ46DOOq8RY4htn6nOPrazjzGosMqU11B9+vM+ljP;4:7O7aIbYY/TWPy+J4wxS/AO4odYlcCmKXQeb8++VtblBTd8itaQmxAf+5TG4p7SKOqe6L5G3keJJ9k4LDcby/IvTdddEHzf4FrnB7lBFsD/lMzP+GQW8zTAy8TPt0eAKCVAxrdajSOrY/0/nEzMtofIzXey4CCn8CTSuvSPWB5zV3peSAxVQfddK6uaBlToU3+m2SN3/i68hOPC+AO2BdRTcXpsIEyQqFySHpxbDseDBfuCZ7iCq5GNTeDS10NZ5pltrQdLeVM8yeBigtOMuBG/dMzPXvompyqkkoU6TVKPpMrcYMFxxdkhRH5CmGP0Nd
X-Microsoft-Antispam-PRVS: <DBXPR04MB320DDF421EAB3C46A3E48F180AA0@DBXPR04MB320.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501318)(52105095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DBXPR04MB320;BCL:0;PCL:0;RULEID:;SRVR:DBXPR04MB320;
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(346002)(376002)(39860400002)(199004)(189003)(6512007)(47776003)(53936002)(186003)(66066001)(50226002)(54906003)(105586002)(16526019)(478600001)(68736007)(25786009)(106356001)(4326008)(6666003)(2361001)(6916009)(16586007)(2906002)(97736004)(2351001)(316002)(6486002)(36756003)(8676002)(305945005)(2950100002)(386003)(6506007)(3846002)(7736002)(6116002)(5660300001)(7416002)(81156014)(50466002)(48376002)(81166006)(26005)(8936002)(51416003)(52116002)(76176011)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DBXPR04MB320;H:b29396-OptiPlex-7040.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DBXPR04MB320;23:msuu3HKPfMzChsa0HqE0AOUzyBNNlt8mL/jnJ8QBSq?=
 =?us-ascii?Q?JU2EJyIpNPNdM3ataJY2pZrWznjYWeVs5eRiboRqFdim9zazPQ+aoERy6vgB?=
 =?us-ascii?Q?f6mIfZ0d/peKMnDgsZkVJ3PN/J93ViB6EG3nEez0k0oenGn5OPE7ESMoqJbP?=
 =?us-ascii?Q?SJcusazViGhz4I48o3710GTcyJXM+fjNQ6oMLlzEpp1R8Zqf2S6/qMTKi7vx?=
 =?us-ascii?Q?cu0la0BjDjnkJcYRrBSoQfg92xFEazGFOUMcmwEIwasVWkwt2lhv8OkpX7ja?=
 =?us-ascii?Q?VIp32aPUaIXYQyY2xCJPElWiiEdclNjMRBFGdLHLBq7MTq/WZ1iHzmsDCCSB?=
 =?us-ascii?Q?lDT3fNX9dyZ9AqVVXSCjOj+OpzdgC9xne6mFxmA8lIp+CxenFMzsNgILcAY4?=
 =?us-ascii?Q?KDHYzDgeA6DaAGtLlJz5WyJgzoLv/Bt89HBmMTr6nju0hHQvH3pa0+C09K7B?=
 =?us-ascii?Q?CEGms1wNmgVNEpG+avADBP9PiYqkEDxjGkjFU0U515ZCpk0ra6Bx4rybQkli?=
 =?us-ascii?Q?I9XgLFqi//VJoRx2Kb0x/mvM1zrUelZcEP1Dvy0Du7FSys+BKxAY6YlqBOow?=
 =?us-ascii?Q?KWUx1964MIuoZQOMFJ8EYQLWnOwq7KvnMUcTAXFqMQQl/cRjxewF/jMlc0MW?=
 =?us-ascii?Q?pw8ssiO4plyGCKXtrKh0GBI84NkBcetojzkyuMjLni10dqZCVnSIA8F4H5Xl?=
 =?us-ascii?Q?j+9xdjAYgxWc6BRVoT5hRlSbMoOfdYMZVlMn5/dUNhy5rSNB2piHDV30C7BN?=
 =?us-ascii?Q?6Ai75OfpNb46uxVyDt/YYRx+cMpbwxBlh3yp0n+JqsJznlxUB2v9yw+EC5yh?=
 =?us-ascii?Q?jCT5nTUSrKQzNlA1IMNKdL22O/mAHg6jek7nb4zl0ZzWvC1A2MMkfGFKOTNe?=
 =?us-ascii?Q?urRGS43U9ov7RJxoHVQuEerQE4ah8r7CEoQo1aHuDdWlVIS+5T/rv860Z+kS?=
 =?us-ascii?Q?yGD0Z30hGcqZVaNhG02CGo3P613jrqiEs1IYtSKTRV0bMEKuvxrSUvbK/2Bm?=
 =?us-ascii?Q?8YDwC610xse7uuCAtZd5WQS/KlcWZWVlxxXQRklkxR8+Ouro8f42ed7SKeIS?=
 =?us-ascii?Q?+eMohkOIT/CD7wJJDcbocfIycV4jtiMc4lrQCfPtOg9mDUfhKIxWtqygC+dM?=
 =?us-ascii?Q?dX9V1vvBNzLg7wEfcJ7yQJ4uNInpZhvNU5uTatg5patvm/AFqhZouqsCmin0?=
 =?us-ascii?Q?2oGZuGb7ytF5I=3D?=
X-Microsoft-Antispam-Message-Info: vF8tb7v/58r4GFfsoDAj6FEfXbZmGEAsZtyQyprdKTWz+Xr+iT8VHmrh/bDlXzBVMUTusb0x3GD+k4eaOVWK7Bd2ypmWOyUIry+LoRdrQ7pTYF9+f3mjydoEoliyatFAySZPmsCmigh30tRUp7tsXZwwJ7CG0/+j4BSdUP3la93XJqzS9ynftRpC1vPjbUm+
X-Microsoft-Exchange-Diagnostics: 1;DBXPR04MB320;6:jTTBfVdDC/HgGfS1DBaZHr3eFG2Stxh5ra257JxrjtRO4P9noWi5dWhCFAGA5eI17jGikr+8FZteYnAQfPel5Jqsb02TtrIENKiW+zzq1hvy+ozHmq3Wc+E7LcT1LZmFtGlo+7OT//lgQSqAVBlwAf2Ny31TDFhXAolZBdXnmL+JMYmFCEOe/hF+StaadvWYa4RI+RI0y4WMZlI8TB+wnZA6uZY44SvNwXBcAlGzatBOQG/prrqC3NzCESBC1XwdEMAB6h9TxIvcFhER7uFp+/uRVFtBgxrbbTg8dPapJVfdBkoAmy/sOy0Om8T7dNZWgO/jVWFu5oFGy4pYMnVD85JjGJZ21jG/NGBK6cQim4Q=;5:BvfHgNcZ6UnI94btpFk/Kz43F4A6T2ajR8KqbOVrucUU+k4oxRmXy0wioe+ZQxAC2+cJksxR2oCQ6Q+blqHyT9M8k2BfTFrKXGDT3z6y3jqWbhxKrA605/ETcnGq/W4Au3giz6IIzA4TKj6J67azVej/FDMFn0+2nioEkO++2uU=;24:btn4HHMgVNl2OBGpjBP7WWQaVKw8rLdbS1zuQu2T3eu186R4qIjbDX/fiuFnzGBvvlf7ooAANu7A4h/sxTVgua1cDPZiDwYbbVrVxQSmajA=;7:CYMGLFm748Bco3MOwh5hfbu5Dhwxy4Fei/C0HWiquzVIdWnKoXgi/SSVlqqTmQ1jPzul+L8QTIeDzKXDpRYnHtQPn6voW1aRw9C1HN7T5dyO5i2O5rb+ANAZnwiCpy+dxKFHUO4SJEEO9Hi0xwov3XsX994KyRrhYqDRhZBTE6Pj4wLubvQkbrwxY8/ip4CqU5JToQeBWuEcSoOMcCnpWu6Lfb5dXbBTGdC4D0Wu6+5PkbDCb0hh5qLUSEh4PKaj
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 03:20:27.9622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e06d26b5-f539-4ab7-b717-08d58edab427
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBXPR04MB320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'clock-names' property is optional in DT, so of_clk_bulk_get() is
introduced here to handle this for DT users without 'clock-names'
specified. Later clk_bulk_get_all() will be implemented on top of
it and this API will be kept private until someone proves they need
it because they don't have a struct device pointer.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Russell King <linux@arm.linux.org.uk>
Reported-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/clk/clk-bulk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index 4c10456..4b357b2 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -19,6 +19,38 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include <linux/of.h>
+
+#if defined(CONFIG_OF) && defined(CONFIG_COMMON_CLK)
+static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
+					struct clk_bulk_data *clks)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < num_clks; i++)
+		clks[i].clk = NULL;
+
+	for (i = 0; i < num_clks; i++) {
+		clks[i].clk = of_clk_get(np, i);
+		if (IS_ERR(clks[i].clk)) {
+			ret = PTR_ERR(clks[i].clk);
+			pr_err("%pOF: Failed to get clk index: %d ret: %d\n",
+			       np, i, ret);
+			clks[i].clk = NULL;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	clk_bulk_put(i, clks);
+
+	return ret;
+}
+EXPORT_SYMBOL(of_clk_bulk_get);
+#endif
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
-- 
2.7.4
