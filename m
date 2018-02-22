Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752114AbeBVXIa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:08:30 -0500
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:20512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751968AbeBVXHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:07:38 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 3/4] staging: octeon: Remove USE_ASYNC_IOBDMA macro.
Date: Thu, 22 Feb 2018 15:07:15 -0800
Message-Id: <20180222230716.21442-4-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222230716.21442-1-david.daney@cavium.com>
References: <20180222230716.21442-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:100::32)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0addedfd-2032-4f9a-3449-08d57a490e88
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:OtWlBBF1w0XvQ0g3c3AXQ5zmJQOXPS/d3hY+H+MzPvkvLBfVmC2qmjX1fFZYtn9LtH6efNDMI3b4oJ0vRnDuqGx/ZxbE7gC39qvHtzXrPa1lcyIueGYZzenJFSKO64jg+Hm5SAg946rnUwIAxILuLYkKEdVMgGHJ/WNWOtkoKDbYyuLkgo0wrn4jkAhOjf5gaKYpw2vYEQkBZlAgnWOjmp2dA1WeWKgz/k0r3uWEhZLogRd43h8qddqolRrVsl2M;25:JRG/dLL5PQIfbc30YuzLoINAOLcEmku/QY/r/rfFAfF3EiE/fsuWtCVraNNCBxP/P4yO2b/R1Nb3ilgnk7KoZh42AcXF3kpF+oyzsd/vGWxLbT2I4Ho+jaV8CmfYxY/X5b1PcSC+hBrlQLUjsSYtVyKnCUBaguNDfR/IHyfE7jbOXu4A0hnKZe6IjG4n/O96OSSgh6obPe8ln27NjdQ7tTWmX3WKA8KyR/I4R3cEoFi88zsvzqf41ASfTdj5sAzZ1qpE/Hmotgh8E9bG27j+HmEw6AJrqPp3Zee+CAc0wnk+EKyDEWLX6/yVJtjeUq6mQxQYtOtlqTjBplAo0MsZ1Q==;31:gvnaGnhHOjF2OInoe2X/nG9wPNiRPyyo44olyFqJTl17VZj8qPEfu11gA/UtZn+ORlVJtWNYEXkJI9BordPcgRJRbOZiO4u+6CAZW84ZBo2PjHZQtaUvO3R80wUQWr177q/+dn8ZVFm4SwIh6gTPc8NdhiCWrLFJitqqO4J6sXHnweEgYtEw234PpA0pXiG40l0qKWyDxSQPPLlPZXc9+wl89bdboKXVaglpgKhVUxI=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:uUPS8MJmM4FxfBCFn3BcsLaJsuy5S6TlFoY31FB9+GmsEKtrb82T4tqJLBOL5MUerS7/ZmdggS9DQFtdjFLd5zMt7vsXVqJRfDdOrVSVZTlV9+iaUWcnMvZOsDiVOXFUJHxFs6ivOESUPVPv/R5mndUgwvZvjZ8qIoaoeh9orfRIl6DB3FZvNhiq1c49myXyLmUHkbyCAyviBzI9VzytCski7BgnQQUjt+jjwNGOIJABK8x1JUTGwP3HiyosonJoFHyWAK1eQ40zY3KbwUz9+eCw/mWHHrtz6EK1XYVz3agu52ghtr2wkZ9AXGMdun1uD+cwjKh7qBLTpZ2w04rvIDME6KvTnusOOhfjucS9ctk4+14YUMJ4uzaO2awXTfu3sFQA0kUc0CzGt6X45maWzBBsZ3leutoTBWfyFF7Zcz4+c+lFYqoe6BvNSBIIDVkwKDKHwB16vO0jD2OXQtAg7qa0jq+ZabMBB3Vaxl4IpTimuhKJG26ISGzfrRJoUJ+y;4:pVt3ankVIqtFI0b+RATWZk7k1HmKkS+mhJAD/lg/YmD7R7pROpsamRU3xTxUOpKhSpsey/H4SOxUMVGPeMakcCbke72nrtNmAxbXGHJD5/SX6egRh9OecokKu9GaFn8FKLo7DQNUTVPu0N+4r7NuNHP4x0ZGN3wBRb/ixepvJDp5ZsXu4yKPS9ok4qaO2HJC66FozaxWaH0YYE5zh2SaNegvEtpZ0N5ANpwgxpQ8tGcJO6mycSStd8uKHg4ov/Y9W/wwR73KhyIy57nudieh/Q==
X-Microsoft-Antispam-PRVS: <DM5PR07MB31803382BA10247E265BAE0E97CD0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(53936002)(305945005)(53416004)(66066001)(107886003)(6486002)(69596002)(47776003)(6512007)(386003)(59450400001)(6506007)(26005)(5660300001)(50466002)(8676002)(81166006)(16526019)(81156014)(478600001)(316002)(16586007)(54906003)(8936002)(72206003)(48376002)(25786009)(4326008)(105586002)(50226002)(186003)(68736007)(3846002)(6116002)(2950100002)(1076002)(6916009)(6666003)(36756003)(2906002)(7736002)(52116002)(86362001)(76176011)(106356001)(97736004)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:02vTn/DnTObEeXoAIVufDPKrJKGMi5+Av4ckrv5rS?=
 =?us-ascii?Q?Gpc4IUcevajkeAdCK3fvCohMu3Ok/UJZkiasyRjuYlOBXxDlv+WX8tjhchBn?=
 =?us-ascii?Q?Mt8YPSUkZRNbrQXsQORNtZbBzWv+bywCGcy9q5rP66zObYF0xMA2qD+8pf1O?=
 =?us-ascii?Q?LRKOIP2mIPIab5I9aUI4UKnDL50g3w/XxBF0B80meOguOOTBP0eqtC0jJZmt?=
 =?us-ascii?Q?SFn8uD/g2dqY3RHTwuXBYYFgK8IfnkgoIroraFyRGVjj6xvhEiRsViFD9J0K?=
 =?us-ascii?Q?lOhYgwg03cTC6vSZ6Ma8YKEu7xJGq+ygMdnS4UafztMn7ZS6QopH+xsNSA9/?=
 =?us-ascii?Q?yoLAwRaaPcNda5P2/W/u5DI8dPy8JvpwXDlyzRPQr2U0yzkCoejbW0sv9CwN?=
 =?us-ascii?Q?M7UL0OCsFyKpLaseyvKe5RiDTK3Nmf4dUIu+q9IAgwYrbqj8eSZX5JyzP6Ki?=
 =?us-ascii?Q?hiw2d8dV0dc9o78PWxvUmGW1zHXnUwRAXRhoWk3uUXUDZirn67zEh6WgAHmm?=
 =?us-ascii?Q?Ulhzs9DBOuHz7Tay6HiAONmv16YJwithsJs+m8YgBsNQ9Vz5E+HjrdLoSJjp?=
 =?us-ascii?Q?qzsUpvfNKiIPc4gNxz4LN4iqd+kNmwII0/TncKf8q8GxJ0mPsCa8MFWGiOy/?=
 =?us-ascii?Q?8XrZ75845WDupTV8AhppwR/8kLnnBh2+vKqqNSHY8ML1QqrzZn/0V4xXhny/?=
 =?us-ascii?Q?NdSVMOmBr16gpSGHTQkvnS+6jzbjiCK9gC3nub55ipoce/TWYPaGuIqNPMXZ?=
 =?us-ascii?Q?LpLaZxbu4U/yLY5qK3g1CAUbnGW2UiSPZaLmhc+y/9ZnZZ3D05GXlNDqnm/i?=
 =?us-ascii?Q?h02oC3NW6heEueiz0utMSzlEKjoiWvx6sOHLXQ0stuiPY58vHRxe5lA19+rx?=
 =?us-ascii?Q?tAGmBuVO+o004rcmcrjo9dozlnCxP8unGaOraGtmEDGfNymoyaM+ibRXw3ZZ?=
 =?us-ascii?Q?CqRhwHy1KdRfxxvKbLR1SWgp2KErLuKdYgKYk6B0aKdv2nGsj8xUDsfsQYVJ?=
 =?us-ascii?Q?C5JMvvYTO30aRRL8RfoBm3dpAk0hsAnS9swafM6ZxRVEjGosrrC+C8WfB9/l?=
 =?us-ascii?Q?IiGtVqOZgly2ZxFmiwTboMwHaUCHqbAPjlVbBc5WRZtXYadBYwugRvLnRkzA?=
 =?us-ascii?Q?KxxkyLN0qjAFwdnqofCzKMorGJ8wZu0uu7ITqTWqYOAWs+T7Y/5uygx5+sIo?=
 =?us-ascii?Q?S+M/xECnhrhngTNGzbNzTigAYE649RhrY71fepIueyii9E28bnl6P6tNZT7W?=
 =?us-ascii?Q?eW+oOX6AKU0hogGBTQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:zrLTMcq8Kgtj7F+ENHDRfRDZMZH90IM5Jm/MHrVOlCfhO1L0yE7qIc3pQzu0J27oZgZn3v59b2tbJewE/ev2i/kpvVZaY2/VOoGY5xok66A8NA2D7zhL2kO0gY6kDhqj2MvK7Pa7ffZ+E1uzuj7CqtIS1kqy1b7LS4ntXZYsNXmFd3enQneaOWFrOQlhHH9NDAB3kbp22cTuUOve968kf3tWF3T3XHCwr33czZFgGsLgogQVjv0qjo6G7JrY21rVESJK7k2V8feRE0ENfxq3Q9j4UjCQ6kwu0IEJ0+Q4wGtjs4MQ0QcTiIZyyXHK3lKTtKklb7ejDtV6i8KKxqdsRBusN46ceCxlYl8GAShFGhQ=;5:LOfURH1ttJnpB2lSbNMZJPq5L29sWoQSp4AzPCvzzvxGxEoyNbU3KoAyl9u9xy3jEGoFc+RspoADiHc2bjf9NcM0HJcNw0Jl7b35NDFGrzyLUm2XaDZJ1xxnCrW5BdnrlM/ZfvvwemtKTFjPTSNMcPxI+7dwbfRL15/4Y/cXsNQ=;24:tBEJ0gVeW3c5eVJvOI4rMulZI3mE8Pnj3tejJ22RkSjF9b1knrVK25Mltp+3E8mzVllJOejscPlMqklhJSPg+qU/Yw4D0as0FLSJ2EzHjUI=;7:dCQpa2jcU/rVWHzZx7qHpr2nyvZXGg0ZPAMbsNtwIRaXM7ufBVj9DZVamdLTkB4gTQLztUolEWTeXbr8y0mhQrE5Iygx5tfwsO+BLNxI9DaW/3edLkh4H3xvgoPz8r1MKCQysHClfbQoPsjgL0XPUVqO+UpKH7HTLjDJVHUkBN3wgb49WTGWZzpSYp03WVtYZtdqvry4PgVZ3uaESB7HrjIvbqTx2U/X1lDNoZc6jzCZLNmFF0Ue0SStYMsuZv5Q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:07:33.1551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0addedfd-2032-4f9a-3449-08d57a490e88
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patch sets USE_ASYNC_IOBDMA to 1 unconditionally.  Remove
USE_ASYNC_IOBDMA from all if statements.  Remove dead code caused by
the change.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 drivers/staging/octeon/ethernet-defines.h |  6 ---
 drivers/staging/octeon/ethernet-rx.c      | 25 ++++-----
 drivers/staging/octeon/ethernet-tx.c      | 85 ++++++++++---------------------
 3 files changed, 37 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-defines.h b/drivers/staging/octeon/ethernet-defines.h
index 33c71f86890b..15db928c4712 100644
--- a/drivers/staging/octeon/ethernet-defines.h
+++ b/drivers/staging/octeon/ethernet-defines.h
@@ -7,10 +7,6 @@
 
 /*
  * A few defines are used to control the operation of this driver:
- *  USE_ASYNC_IOBDMA
- *      Use asynchronous IO access to hardware. This uses Octeon's asynchronous
- *      IOBDMAs to issue IO accesses without stalling. Set this to zero
- *      to disable this. Note that IOBDMAs require CVMSEG.
  *  REUSE_SKBUFFS_WITHOUT_FREE
  *      Allows the TX path to free an skbuff into the FPA hardware pool. This
  *      can significantly improve performance for forwarding and bridging, but
@@ -29,8 +25,6 @@
 #define REUSE_SKBUFFS_WITHOUT_FREE  1
 #endif
 
-#define USE_ASYNC_IOBDMA	1
-
 /* Maximum number of SKBs to try to free per xmit packet. */
 #define MAX_OUT_QUEUE_DEPTH 1000
 
diff --git a/drivers/staging/octeon/ethernet-rx.c b/drivers/staging/octeon/ethernet-rx.c
index 5e271245273c..c1ae60ce11f5 100644
--- a/drivers/staging/octeon/ethernet-rx.c
+++ b/drivers/staging/octeon/ethernet-rx.c
@@ -198,11 +198,9 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 	/* Prefetch cvm_oct_device since we know we need it soon */
 	prefetch(cvm_oct_device);
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Save scratch in case userspace is using it */
-		CVMX_SYNCIOBDMA;
-		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-	}
+	/* Save scratch in case userspace is using it */
+	CVMX_SYNCIOBDMA;
+	old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
 
 	/* Only allow work for our group (and preserve priorities) */
 	if (OCTEON_IS_MODEL(OCTEON_CN68XX)) {
@@ -217,10 +215,8 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 			       BIT(rx_group->group));
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
-		did_work_request = 1;
-	}
+	cvmx_pow_work_request_async(CVMX_SCR_SCRATCH, CVMX_POW_NO_WAIT);
+	did_work_request = 1;
 
 	while (rx_count < budget) {
 		struct sk_buff *skb = NULL;
@@ -229,7 +225,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 		cvmx_wqe_t *work;
 		int port;
 
-		if (USE_ASYNC_IOBDMA && did_work_request)
+		if (did_work_request)
 			work = cvmx_pow_work_response_async(CVMX_SCR_SCRATCH);
 		else
 			work = cvmx_pow_work_request_sync(CVMX_POW_NO_WAIT);
@@ -257,7 +253,7 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 			sizeof(void *));
 		prefetch(pskb);
 
-		if (USE_ASYNC_IOBDMA && rx_count < (budget - 1)) {
+		if (rx_count < (budget - 1)) {
 			cvmx_pow_work_request_async_nocheck(CVMX_SCR_SCRATCH,
 							    CVMX_POW_NO_WAIT);
 			did_work_request = 1;
@@ -400,10 +396,9 @@ static int cvm_oct_poll(struct oct_rx_group *rx_group, int budget)
 		cvmx_write_csr(CVMX_POW_PP_GRP_MSKX(coreid), old_group_mask);
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Restore the scratch area */
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
-	}
+	/* Restore the scratch area */
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+
 	cvm_oct_rx_refill_pool(0);
 
 	return rx_count;
diff --git a/drivers/staging/octeon/ethernet-tx.c b/drivers/staging/octeon/ethernet-tx.c
index df3441b815bb..2aa5fcb7ee32 100644
--- a/drivers/staging/octeon/ethernet-tx.c
+++ b/drivers/staging/octeon/ethernet-tx.c
@@ -176,23 +176,18 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		qos = 0;
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Save scratch in case userspace is using it */
-		CVMX_SYNCIOBDMA;
-		old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
-
-		/*
-		 * Fetch and increment the number of packets to be
-		 * freed.
-		 */
-		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
-					       FAU_NUM_PACKET_BUFFERS_TO_FREE,
-					       0);
-		cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
-					       priv->fau + qos * 4,
-					       MAX_SKB_TO_FREE);
-	}
+	/* Save scratch in case userspace is using it */
+	CVMX_SYNCIOBDMA;
+	old_scratch = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	old_scratch2 = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
+
+	/* Fetch and increment the number of packets to be freed. */
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH + 8,
+				       FAU_NUM_PACKET_BUFFERS_TO_FREE,
+				       0);
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH,
+				       priv->fau + qos * 4,
+				       MAX_SKB_TO_FREE);
 
 	/*
 	 * We have space for 6 segment pointers, If there will be more
@@ -201,22 +196,11 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(skb_shinfo(skb)->nr_frags > 5)) {
 		if (unlikely(__skb_linearize(skb))) {
 			queue_type = QUEUE_DROP;
-			if (USE_ASYNC_IOBDMA) {
-				/*
-				 * Get the number of skbuffs in use
-				 * by the hardware
-				 */
-				CVMX_SYNCIOBDMA;
-				skb_to_free =
-					cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-			} else {
-				/*
-				 * Get the number of skbuffs in use
-				 * by the hardware
-				 */
-				skb_to_free = cvmx_fau_fetch_and_add32(
-					priv->fau + qos * 4, MAX_SKB_TO_FREE);
-			}
+			/* Get the number of skbuffs in use by the
+			 * hardware
+			 */
+			CVMX_SYNCIOBDMA;
+			skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
 			skb_to_free = cvm_oct_adjust_skb_to_free(skb_to_free,
 								 priv->fau +
 								 qos * 4);
@@ -384,18 +368,10 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		pko_command.s.ipoffp1 = skb_network_offset(skb) + 1;
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		/* Get the number of skbuffs in use by the hardware */
-		CVMX_SYNCIOBDMA;
-		skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
-	} else {
-		/* Get the number of skbuffs in use by the hardware */
-		skb_to_free = cvmx_fau_fetch_and_add32(priv->fau + qos * 4,
-						       MAX_SKB_TO_FREE);
-		buffers_to_free =
-		    cvmx_fau_fetch_and_add32(FAU_NUM_PACKET_BUFFERS_TO_FREE, 0);
-	}
+	/* Get the number of skbuffs in use by the hardware */
+	CVMX_SYNCIOBDMA;
+	skb_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	buffers_to_free = cvmx_scratch_read64(CVMX_SCR_SCRATCH + 8);
 
 	skb_to_free = cvm_oct_adjust_skb_to_free(skb_to_free,
 						 priv->fau + qos * 4);
@@ -413,9 +389,7 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else {
 		queue_type = QUEUE_HW;
 	}
-	if (USE_ASYNC_IOBDMA)
-		cvmx_fau_async_fetch_and_add32(
-				CVMX_SCR_SCRATCH, FAU_TOTAL_TX_TO_CLEAN, 1);
+	cvmx_fau_async_fetch_and_add32(CVMX_SCR_SCRATCH, FAU_TOTAL_TX_TO_CLEAN, 1);
 
 	spin_lock_irqsave(&priv->tx_free_list[qos].lock, flags);
 
@@ -485,16 +459,11 @@ int cvm_oct_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_kfree_skb_any(t);
 	}
 
-	if (USE_ASYNC_IOBDMA) {
-		CVMX_SYNCIOBDMA;
-		total_to_clean = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
-		/* Restore the scratch area */
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
-		cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
-	} else {
-		total_to_clean = cvmx_fau_fetch_and_add32(
-						FAU_TOTAL_TX_TO_CLEAN, 1);
-	}
+	CVMX_SYNCIOBDMA;
+	total_to_clean = cvmx_scratch_read64(CVMX_SCR_SCRATCH);
+	/* Restore the scratch area */
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH, old_scratch);
+	cvmx_scratch_write64(CVMX_SCR_SCRATCH + 8, old_scratch2);
 
 	if (total_to_clean & 0x3ff) {
 		/*
-- 
2.14.3
