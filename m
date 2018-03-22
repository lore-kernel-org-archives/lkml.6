Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755694AbeCVNwd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:52:33 -0400
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:18080
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755641AbeCVNw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:52:26 -0400
From: <harinikatakamlinux@gmail.com>
To: <nicolas.ferre@atmel.com>, <davem@davemloft.net>,
        <harinikatakamlinux@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinik@xilinx.com>, <michals@xilinx.com>, <appanad@xilinx.com>
Subject: [RFC PATCH 2/5] net: macb: Support clock management for tsu_clk
Date: Thu, 22 Mar 2018 19:21:37 +0530
Message-ID: <1521726700-22634-3-git-send-email-harinikatakamlinux@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
References: <1521726700-22634-1-git-send-email-harinikatakamlinux@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.812-7.0-31-1
X-imss-scan-details: No--4.812-7.0-31-1;No--4.812-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131662003412362721;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(396003)(346002)(2980300002)(199004)(189003)(82202002)(6666003)(426003)(61266001)(446003)(6346003)(26005)(105596002)(5660300001)(47776003)(63266004)(2950100002)(50466002)(305945005)(356003)(59450400001)(54906003)(110136005)(7049001)(2906002)(106466001)(336012)(450100002)(76482006)(83322999)(86152003)(86362001)(8676002)(316002)(73972006)(8936002)(2876002)(76176011)(50226002)(498600001)(51416003)(4326008)(9786002)(16586007)(73392003)(81156014)(55446002)(48376002)(77096007)(2201001)(36756003)(107886003)(81166006)(5890100001)(87572001)(107986001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB306;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;PTR:unknown-60-83.xilinx.com;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT004;1:y2rwUKS6fshR5dQAfZSHPRiDEtse8BeYhyQMqHHpMFx85UBcC3Y6PXIZ9+VbBcOyN+h8KmjsqK++m0jOGaXVZbUUie2mTqzp5pIxQY1ol89koOvwlAKbrd0k/6Evf1Su
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ddf0562-9cad-4faf-a128-08d58ffc2241
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603328);SRVR:BL2PR02MB306;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB306;3:MClMkOquiJYNpdFi/nzv5Ms97u0pZkWhwZ5U4V3GRx6HHUCr3iq3PuuFmuO27YavvUqpz1GE8jvXbtksF/gh09f7BLRnbmLD5uqL56nsHnCL43Gt4rQISRvmfCVv7MNslaYbnZRjPufq3EoVrESOErCuzsXVfNqP+i10cu0vn+pxgrvq/1z93gZEAh+Rm9zVPodOGf7SwbuAy0FSBoDEKbcG4jedWiXSfSskChbnM7+X5sW4YQ5m889g7TEbkEOT8pzlDT3wcGVOPWXkYp2jwTzJ7rkOSlD/W3qVLhkpOu9Zw/FToYWeRfZxCX9Uw836q3IcIzvPOw7R87tbtyk+atCkoNVnh62lRMWt1xXRQkU=;25:YY75rMvY9eqrXUgM5LfrsJwR0x4biVROs7Ha3R07CWPzwURYa7grKxuA5PiBBfbuaweRxZYb63/S5Qc5O24HowlmXO5cog91iQTf+wP7HnipFVlSNEn8ji75XSKyexRUZaF1wrXYn6OERGDVqulucwH0oYoQhSgamWqvmxyEhU9xh84zIi5neX8QIW9AdxGxTFUWrTeGDBIEm/VWba+/zio0Lf0Ezju/JkEaLuIvcCS5PeT/nS6qHSGzE6X1r6CxDygfH1RmWtq+WuPcHgOpKRNepM+mW2wtpY+w8dxL1DSqW+doHgNdeQ4YORxOvmi7yEbaQ7k7cNIrGHJpT7MWoQ==
X-MS-TrafficTypeDiagnostic: BL2PR02MB306:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB306;31:hHNBKFEvp+EIzLTbDO1xZvYhsdq2DiAZ1BDc+XBAmIWaeyPby2QhdVF3KyY2UEDKBdTXU31eB4e0KT/2PFlbcxQnxbmeNRx/FvC4dXLIk5clEWu3V0C9MVI34v5LWunAGb6NhYFvNETOvxYpGZs91kl2EoEyOzh0nRmalDoL/59MZBihmqglNK4gbGyGueakyarmOwTXa1q+3w9jkG6wBtp5vUO7iBPJflDI+mXwT/k=;4:6Z4A+Sf2SduqlbZjPido9YKYPdbuA69j8TnovbzJAatiLtXkwpuhGdNTwUPbhXf4JXdoy0GoR0AfW2S0wDHo+2DK0yZfLWwiNR6wnQGG0OblCUnEr6rOE4MlujXTxJVxohxdcdMG/YrCk7X4uYYFUXVfiPcpPfDMNyqz1Q7aAoC8DKEXgV5VdDBbq93roSQLOvhOTDWkH8wk57eeaB1z3Ff4Mz0Tmmf6OnSX3zwU3bw80nKLTEOTqj6e0z174C1vBGVl0112x9e9ZFE2P2rGc0aM6UKiYdBHY3v0euS7PQqDrWMj2m/eh3PVPq5wtzUL
X-Microsoft-Antispam-PRVS: <BL2PR02MB30684F183B6117C276C5DF1D0A90@BL2PR02MB306.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6096035)(20161123565025)(20161123556025)(20161123563025)(20161123559100)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:BL2PR02MB306;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR02MB306;
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB306;23:SdIzmWXa7MhZDeZ5kIVuISRt98Z8gaeKmg9yJTgpqL?=
 =?us-ascii?Q?NKHF7j2Zwy03GU0ZGvIK0Lnis6y21I2iar3OZgRwLCJJWcsNCoMGwRHUNlqN?=
 =?us-ascii?Q?pX8axtPENZLoP7QforipeXgqeIchtFt6I7zTt/7r2haYrmhFUqejQ34Kw5/5?=
 =?us-ascii?Q?Gpjr82QZ2XlS+6HIb2xBg4/1V3O1dwzTJbeWuYe8uYMAIlj4kQ2OOJtnv/GY?=
 =?us-ascii?Q?htZ7t6LHWcRWFiXkOJc1jxxY5ARmA/AG/uHf5O2uJ5lBGjE2h1kcxbcjSuAz?=
 =?us-ascii?Q?3aEFn6IFR65JXDBChyMr2XnSwJ11yRS/1iGP27E1kGXpM7uBwM6Mn0lOoP/b?=
 =?us-ascii?Q?BVlsnWYwOctggsxc1J1rur92gtlqOTjU7rjyUMcR++nNA3oyzk2ge3eUE+Hw?=
 =?us-ascii?Q?QyFqoxbNthSzXRW059+8x9MGgcVEzIDpL6mHpzGMHWMec+UNeKOjpbuptbK3?=
 =?us-ascii?Q?yOet5h3LF/z86iHAPWgg4KMsfdQdgZQzAUPEHW1ByXHr/nNtga0NZdZ7rUmZ?=
 =?us-ascii?Q?YlVHrhqr7QyTmCH5KcESgI48pGar3R267wXCsjouw4dVUgz1SG1EtkN4Tblg?=
 =?us-ascii?Q?/B5LDHrHFEMFc+WYQiVHeaEI5oRQbivZRyUMfyhSOz0zW3w38kavGOPhzZU6?=
 =?us-ascii?Q?OlizErmqtiN5ortaxEXndHZh0jz4SJa9aznj3BpXqZPYLbI5gCGpLivmy8OR?=
 =?us-ascii?Q?kwzFtFVVJLFw9BeZN/LRpRmeNMYFScbhPFajF+RJJOPT1tdePDJdCOLubUsj?=
 =?us-ascii?Q?hSG3fCjPMeRDbTxljZ1FvxIqVmRHsSOOzmddj6mwi2b164LHk09VUkzKvjh/?=
 =?us-ascii?Q?k/Wg4BxQ8yjca08TLvVs3+Lt1Z2y+bF/FUywepOJl5fUXhOxb0zRcpFhEWX9?=
 =?us-ascii?Q?glwbuflhDIp6+qenK1LndxSNVbbWOaGiUJAqYGTj4YZFJ2MRApYsdfC2fC/e?=
 =?us-ascii?Q?G2R0XZ4lCiHdysTQLpgXoOO7rTl2aA0dizOsIQ0qikMMBOwU6vIuW2tirrsf?=
 =?us-ascii?Q?V11UjsQr3mdMVQQPN3h80YGCllfoy4NqPE4CYR2C6oOtSTuj5M6qucvuIiYQ?=
 =?us-ascii?Q?mLhrGARCm8VbPzxkFZTLC6nfvUBZUC5A7a2g4I+V5aF7zPVg5HbDRBCvrmb0?=
 =?us-ascii?Q?RgR4GFtz1GLuYS0+hOUDiDJcnAjAUc+XP7gqQEq+++xSZDGuOCOFwjM4lHMn?=
 =?us-ascii?Q?u0mMlteRmyYRTJ0pw2Qt/Qe65DDp0uGoxoNHU+q2o3OqKpFvFp9KDqM/CRd2?=
 =?us-ascii?Q?a7HbQV85/dt1MphCgkMw0QH2Jp77lWI8w5IR8wyZAL4jkxGdMXh8i5fijEDw?=
 =?us-ascii?Q?JazaT5x/AKMClpUyWsv3br7q/cbsURysH2bBWpiXFeYD6svdcqT7dbyScFlT?=
 =?us-ascii?Q?25R3xPj3FzomRobrjaurBwzfI=3D?=
X-Microsoft-Antispam-Message-Info: 92C7TkvaqB6OVK7fb/4SyKbGC647ggF2XE6Uw0TLl9xfhnkvvyoq4xy2xCLQlXdR7GugVVf9CatsBqZoVcUIltA5t3OMgz6U0+O7adQhnF1dw7FQIG0lwOdVaW6tTbnhtCQ3G4Wo6T5rhACJRqJ6I4yyZSzN3SKUYPVrcarTp7zAOwgXfxq2k8FnjqORvthc
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB306;6:/K6u/CIeK7JnX2xSEM4I2GndddWEE3GifWnGoCbYL2DJubr61g/LX+G0yv7Qqjmiktj7c/3HOwGsTsffxEJacymM7HqAgXdyN3DacdtOE75xtpPpmV8+Bwv69sdEq//0kixJ3/OM9LF1TRKdsrJ7hIqusrLJcrWEWMkixH0p5+lwXHgm4tcJ+oPpsvMetq1T74C36JtdhB1t8N0yKyY/1bHgcUpvuwbrCsapzIFSW8SbqpGIsbsm2rk6UDprJGNTfzI8vGQZoGYq9a1aRuyrqkYXg7YXi6onWGHAQPupSoOdAjxSS9rfHsfl6s6aGv+yk6XZ/yLssk5T3I5VQ395CK7kEusYcKnBeG1VHn66xYU=;5:1eLHY4j5w8tieWqFVCgWhWX3RQsMF/ZeW7oDuE6nVy08s2UJwNlSYfTdrmfeLPllE061O4Mfc8Mbjfn8VBQwGFGpE04SrDIz7YPuRS2nQlan7BGXBmNElqr0Tjicu5j0SYLWF9/k56udK5sxA/xvc1VdSWN2YsUfRn3YHkcH6MM=;24:K+fEmZrDthF+k5zAliAqAHrtGOfjzTMfOX9RwV5a1qyPSK4irPki25MEP7FwW2O/gly9xwNbMAtpWC8BCiG36T9OjgKC4S+jp5j2cNkFjpo=;7:X/TXiHFIGtLPlifbKwhnK8cJ3mRYO6RWnxAUbFEaH3myc1iEGrigoROFMOufuMFsAQm2xmpinn6ToFkd9OYa7JQld3YKZpT/efOzrskH4E7H6/lK6npQTovrmY42+IeyHBz3ufbWl+ajYDf+lekWO98D7s64+j8kGSBWN9MUwGNy6xJagvzHw99gHj6BXE2EKeae45SN7nk4Q4fZhiJ9ew4IbRxd5JQ3hVYmnhockrwYCVHufb0i1m+2PDhD31fZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 13:52:20.2831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddf0562-9cad-4faf-a128-08d58ffc2241
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB306
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harini Katakam <harinik@xilinx.com>

TSU clock needs to be enabled/disabled as per support in devicetree
and it should also be controlled during suspend/resume (WOL has no
dependency on this clock).

Signed-off-by: Harini Katakam <harinik@xilinx.com>
---
 drivers/net/ethernet/cadence/macb.h      |  3 ++-
 drivers/net/ethernet/cadence/macb_main.c | 30 +++++++++++++++++++++++++-----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 8665982..9e7fb14 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1074,7 +1074,7 @@ struct macb_config {
 	unsigned int		dma_burst_length;
 	int	(*clk_init)(struct platform_device *pdev, struct clk **pclk,
 			    struct clk **hclk, struct clk **tx_clk,
-			    struct clk **rx_clk);
+			    struct clk **rx_clk, struct clk **tsu_clk);
 	int	(*init)(struct platform_device *pdev);
 	int	jumbo_max_len;
 };
@@ -1154,6 +1154,7 @@ struct macb {
 	struct clk		*hclk;
 	struct clk		*tx_clk;
 	struct clk		*rx_clk;
+	struct clk		*tsu_clk;
 	struct net_device	*dev;
 	union {
 		struct macb_stats	macb;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f4030c1..ae61927 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3245,7 +3245,7 @@ static void macb_probe_queues(void __iomem *mem,
 
 static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 			 struct clk **hclk, struct clk **tx_clk,
-			 struct clk **rx_clk)
+			 struct clk **rx_clk, struct clk **tsu_clk)
 {
 	struct macb_platform_data *pdata;
 	int err;
@@ -3279,6 +3279,10 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 	if (IS_ERR(*rx_clk))
 		*rx_clk = NULL;
 
+	*tsu_clk = devm_clk_get(&pdev->dev, "tsu_clk");
+	if (IS_ERR(*tsu_clk))
+		*tsu_clk = NULL;
+
 	err = clk_prepare_enable(*pclk);
 	if (err) {
 		dev_err(&pdev->dev, "failed to enable pclk (%u)\n", err);
@@ -3303,8 +3307,17 @@ static int macb_clk_init(struct platform_device *pdev, struct clk **pclk,
 		goto err_disable_txclk;
 	}
 
+	err = clk_prepare_enable(*tsu_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable tsu_clk (%u)\n", err);
+		goto err_disable_rxclk;
+	}
+
 	return 0;
 
+err_disable_rxclk:
+	clk_disable_unprepare(*rx_clk);
+
 err_disable_txclk:
 	clk_disable_unprepare(*tx_clk);
 
@@ -3754,13 +3767,14 @@ static const struct net_device_ops at91ether_netdev_ops = {
 
 static int at91ether_clk_init(struct platform_device *pdev, struct clk **pclk,
 			      struct clk **hclk, struct clk **tx_clk,
-			      struct clk **rx_clk)
+			      struct clk **rx_clk, struct clk **tsu_clk)
 {
 	int err;
 
 	*hclk = NULL;
 	*tx_clk = NULL;
 	*rx_clk = NULL;
+	*tsu_clk = NULL;
 
 	*pclk = devm_clk_get(&pdev->dev, "ether_clk");
 	if (IS_ERR(*pclk))
@@ -3898,11 +3912,12 @@ static int macb_probe(struct platform_device *pdev)
 {
 	const struct macb_config *macb_config = &default_gem_config;
 	int (*clk_init)(struct platform_device *, struct clk **,
-			struct clk **, struct clk **,  struct clk **)
-					      = macb_config->clk_init;
+			struct clk **, struct clk **,  struct clk **,
+			struct clk **) = macb_config->clk_init;
 	int (*init)(struct platform_device *) = macb_config->init;
 	struct device_node *np = pdev->dev.of_node;
 	struct clk *pclk, *hclk = NULL, *tx_clk = NULL, *rx_clk = NULL;
+	struct clk *tsu_clk = NULL;
 	unsigned int queue_mask, num_queues;
 	struct macb_platform_data *pdata;
 	bool native_io;
@@ -3930,7 +3945,7 @@ static int macb_probe(struct platform_device *pdev)
 		}
 	}
 
-	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk);
+	err = clk_init(pdev, &pclk, &hclk, &tx_clk, &rx_clk, &tsu_clk);
 	if (err)
 		return err;
 
@@ -3967,6 +3982,7 @@ static int macb_probe(struct platform_device *pdev)
 	bp->hclk = hclk;
 	bp->tx_clk = tx_clk;
 	bp->rx_clk = rx_clk;
+	bp->tsu_clk = tsu_clk;
 	if (macb_config)
 		bp->jumbo_max_len = macb_config->jumbo_max_len;
 
@@ -4064,6 +4080,7 @@ static int macb_probe(struct platform_device *pdev)
 	clk_disable_unprepare(hclk);
 	clk_disable_unprepare(pclk);
 	clk_disable_unprepare(rx_clk);
+	clk_disable_unprepare(tsu_clk);
 
 	return err;
 }
@@ -4091,6 +4108,7 @@ static int macb_remove(struct platform_device *pdev)
 		clk_disable_unprepare(bp->hclk);
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
+		clk_disable_unprepare(bp->tsu_clk);
 		of_node_put(bp->phy_node);
 		free_netdev(dev);
 	}
@@ -4117,6 +4135,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		clk_disable_unprepare(bp->pclk);
 		clk_disable_unprepare(bp->rx_clk);
 	}
+	clk_disable_unprepare(bp->tsu_clk);
 
 	return 0;
 }
@@ -4137,6 +4156,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 		clk_prepare_enable(bp->tx_clk);
 		clk_prepare_enable(bp->rx_clk);
 	}
+	clk_prepare_enable(bp->tsu_clk);
 
 	netif_device_attach(netdev);
 
-- 
2.7.4
