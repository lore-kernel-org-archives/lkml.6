Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751658AbeBZRYt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:24:49 -0500
Received: from mail-db5eur01on0062.outbound.protection.outlook.com ([104.47.2.62]:2949
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751515AbeBZRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:24:43 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radu Bulie <radu-andrei.bulie@nxp.com>
Subject: [net-next v2 4/4] dpaa_eth: Add allmulti option
Date: Mon, 26 Feb 2018 11:24:04 -0600
Message-Id: <20180226172404.25584-5-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180226172404.25584-1-madalin.bucur@nxp.com>
References: <20180226172404.25584-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CY4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:910:4d::30) To DB6PR04MB3271.eurprd04.prod.outlook.com
 (2603:10a6:6:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1842bc76-9b6c-4ffe-5413-08d57d3dd084
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR04MB3271;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;3:47v18i7mmLWFRywkqnQ1a7la4DpDXTalXl4JtdBeObNObSUZpogVfg7+Ta5ZCNhcXY4u5Z7g/DgUAv+Fg3PvP3FK+IFBK+JwZ2o/dELWRUSuFB0el3xibd2NvMBJButiZMZ1Fc6lJpNnJP6PZMLB8ZVeh5pRZv9Pf+gCeLcu53S4tckwBHaJgfc40UmIKNhKtF/A6Lepmw1RVLmSgq/QptNjZutlhCskMYaE9VLsdC0LJOD/UD3Ilx0MOpqUe4NW;25:hGXny/Er5mCmbELBrDs5UQy9i8fEpLBIMDAjbvcRICNXJMPnVaYE0d4TQNd5xgYK7rZ7PCsGtmCvogloC17VJ1OVIUxZW8rskosnY9sQG2VevYPsk/P/zEXzX5PZnEWfsXDjRewUwOK1Ht2nKNhzUQO3J7zmWahCujwXw2/xIbtzVVNKdrPox03y33CR5U6fWzm5gzZtN/epW3+fNEf8h29/5cFjvs3lYYsKVGrP9CyoBvYKgBDcQmTSxV6j3dFLtbKZJNoIkehQkJQi+kb+9VCc7NlEQ1dd3eqKxnUnkpll+Xc+QR3fwfM46qac6qnqcBxAsumwAWxfSlSP9P+VWg==;31:3fm8Czv3j+RNJ9v0//INYljkw1mI8ajIF57WvCtxUK09NWROlGIGYoUDPdh1jP6/lJ75nF1cgKy3/LMNYOlA32a0QlQyk4CUSGNNlaw6vURQHQuGYg7r0NKgS4Y/mIqfeWVEldl1NdYUDD8bH92eMth3ekApl4rTSOaVFUGYvKPYpSk/vXItwijUS5Xr03p4A68VWRQoAVL2l6T7lFlm3SnLXJ4EssjXOCWkK4+LAL0=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3271:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;20:ZVmT/ZHMO9yC3XOjrMWO+PZDzFiHci+cUsH9zi2vLD3SJvxDI+nwpaixP8vX6TBzVfGiamADdydO+e189DWez7ze1i9KLJDmbzabvXaF3smSPOD4IjI32nHc/KTnMvp4Qj3HbpHsF6X3YguUzR/acCcPz+euq/YvY0DLAHOyFnwfiPNfWlRwdi8ZtZ4QtrkKDEJMU1Z1zhnoBf6xlRPsGPRVKzUMez/DvuYpV0hHGyIlY5n5/Htbt3vR8ZpLB5NN6GSMx1HKgB+n3mMn+93PCbjOarTcDNp7DcEX8FmwRg9KUDSverz451cx6afuZ7KC6hcwlvUzP15BeZiyCRMKLi7E/6tzpMNL4MhV0gFIdVjo8POu2Mn7NxqwiMiCNIhzIGPxE+qSoWpcSK+HDdIaz+U3NBIGZ/zq4oIwgoz0Od1CHH5A2RtidfVfxvY+ubWz8ch8qOTkNHyb9hOdOOHCReD9XDrLO97sdVgXQZUNkL7z4a23VqLkm+GGLiYCKNSf;4:A72nowjp2FJdfA7mERgMIQ65q+oZT5KUUuwV2dYgTQEONEbldApRmWkG+b+B0Wy6iIeiMxp5934PxnpEunrxdWhDVBe0UFkjiNw+36ipyCGPXCoZyOERZV3FE6BoP17y8Oj5SlYpL1CL0pkMqzuN9eUnhF79R6Z54S7LsdRnoIU1X61WVoI0a/yx22voIihgVaBUqNbi5H/0m3HY3aO6YTXyohTXhynIU9mwpcJKXG6/8ddl+Nr75b7ROrkeacZshlznaIJi8vCoouQRC3G1/74PK0K09aXQyrzxlMAuMpqscdQ4swrrbeC4nUPHsE0I
X-Microsoft-Antispam-PRVS: <DB6PR04MB3271C6E4AC012D715B553C38ECC10@DB6PR04MB3271.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3271;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3271;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(8676002)(81156014)(66066001)(76176011)(81166006)(68736007)(7736002)(305945005)(386003)(316002)(2351001)(50226002)(106356001)(16586007)(47776003)(25786009)(26005)(4326008)(51416003)(8936002)(52116002)(6506007)(16526019)(97736004)(43066004)(2361001)(53936002)(6486002)(6116002)(3846002)(6916009)(2950100002)(6666003)(186003)(5660300001)(50466002)(105586002)(2906002)(3450700001)(36756003)(575784001)(86362001)(1076002)(48376002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3271;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3271;23:CJxKFb+sT6/sN0U1YUVoOEn4AiYE6E+8eLm8cyrvE?=
 =?us-ascii?Q?fWrcVnIM9ZbwsCy0RdgH1L7kBNEAODAQ3ikEfCTTtJ00aAl4Xiafv7+oBjlm?=
 =?us-ascii?Q?YgdKBjsz9yIDTLIzPzkMjW32ZwznpPGS+9PZ+79AW7YSj/mpSV0BVac40IO4?=
 =?us-ascii?Q?c4b0PNBcTpWK7Y6QsG8OlYB+ORFd6AgeKRudrPzQFpUj8OktFZQ47cPjjgjZ?=
 =?us-ascii?Q?6qZXJQ5Y1MMQovE2la4O5r07ueHZ2EIhwrXpzEa/B3X6H7BtKz4N6Jb7sKOA?=
 =?us-ascii?Q?e5muMgEhReEN1MU4OGKhkM+DuPrz0iBjfdTt/zz41e3iM9sQQ7UrNAD5+yJe?=
 =?us-ascii?Q?aQjk6TFkiwXq1GJf1fI9G5Yz8dAA6dBddCNjLrqUpEKATEtBQfz6kYhWK1PL?=
 =?us-ascii?Q?DpZ9D04zKnOzdfTYxJpGqH0UYyh7riboMopKgTo8StRSTuMJbwhsx9aMahmq?=
 =?us-ascii?Q?h8xTMqES35wEjLBRQsYQJWLRgptPgjuxWTEjD4zTFriwB8htj9v+GU0G7q8p?=
 =?us-ascii?Q?oT7qAw+R5Js6TYYqqPcVrz75Pm5REnt5anE8jssjWPeBUG8hWJZSMie8Nh36?=
 =?us-ascii?Q?K1tHKt/Ywga2SNGOPAA1x+C/zoAeRhEJBTPyFn3rDqcFAM27z442uIQ9KSjl?=
 =?us-ascii?Q?ZEGgNYsNgujPPfdvt034EbV4NVP7b01erkFZtPnM5tokfp1jcJp2qPDILjv8?=
 =?us-ascii?Q?P/nDhp88DOl27/QJJixZt1j5Q918Ie/eBiU23JeN1SClJ/bUi82bkk1NEYsX?=
 =?us-ascii?Q?oHdIox04rcfRyjtfabAKpUNu7yu2EJ1QsFFcN+kVyUHxWUoqOfFLcardXxK0?=
 =?us-ascii?Q?VS2i7CybJSUpT9IQV95ylUK9z26QyEwOQ+OGsyvfcO8upcoI/jq8aFfpwmTI?=
 =?us-ascii?Q?Tl3zIlpZ0sUDhGB2eRPK7nlU3o0aq0jE/zoX6LX6burQxyXe/OyI+J7SNYVV?=
 =?us-ascii?Q?qkuYxAUVUMsSMA2ZXVauzX00cpd/lXPRPd9kkxXhKb6lhkUi7k+VAzzygvGs?=
 =?us-ascii?Q?vidKXPeAKfQ/Ts44+Hze/qJaB1y2lbAED/CHdy2Lni7/qX8fPfc449A1hOg7?=
 =?us-ascii?Q?IjFAcfUNQFa8o6vkOLOV3cgarBuf5DeCMQQ3Swh6dOOY+tpP65qxXi24H/yf?=
 =?us-ascii?Q?FyyMixWJVaNl3npNtpE0xrK6xVWNrl+riW1QfAExu5BXY1aq93cEjI2FUGQc?=
 =?us-ascii?Q?wUsuhUtDR3LmI0r4QG9sCkomvYmt0LECaL+QRkoEtqnHNY6U4wtqQc20g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;6:f433rdbXXKXiQzMrC78KGbD9lNCk+Vp+LLwTc1Kc5EQKqFk7PnaystdyNCyLjW1tn7OE9MEqTKcvMLem1pum94KXiJVY6aULg9ba9LC4DICOiJlcIfcZaNswcyvfSEqO4kSISuVAeHjQhxAsKTk3z8sRPK9bXirhRO1gbrDYi88gTbaDKsTAkvEdG0B+hAG721MZiUDbyWgTc8hs0yWWQzTfgfqaDQ6F96mDFQuS7A5ymOigrPjReFRKw9dXIlJx/v22k0asiRGFXjqKXOgye2/8ugPbg6fz6TgzRfckCXhIB6NmjH+ZZY/FuLfqHtFfkJD2ccU1DilRZN7P9UvFkywDzQYq34IXEOIochEMxJk=;5:lcQcFuZBIOtqES2G2IC/OgKTgjY5hPzxGnP57lZe0kxSIyuvUTVoVVod48v87d9Q7qNmPU6u/egqQcaoqu3hDhwbp0v9na5pPkeQn/w6HIN7ew8CeZp4ErNV0Lz+giiCwSRAQh/dHKyyhr3t0IIl6+VxOtL/jjl+xA856Tel6oc=;24:gnKRUkAjVXLJwpJGutzR3hMGMd6f2hZJHAIjTwq1y8bOm+xpMYQ7AG33C5Ueo2zUgQg1c/whdh0GD5+rJRrxtP1DXabvKIrfoudyGCwGlrw=;7:I1IXQDOxtJxH2+KQn3TZPZeamykOLPADIEycLstu1HlDw0vKOF+8FBGbGel7XIrt+GB9K5nqW18AkLSmZ0gHdBLqQ0HVA+oLWi0TKw+ch6WlAbbrTSCUhubeCeLElps40IstyNxigoLw07fyCKKaj3ImbHiC7+3rnnFrlsuLoFcMsQa0rD1mdC/oW4LAEfutlWxBxeq/jkMem2AEbyS9DqJ4CrcWt+KhRjypWA2BMSGfGLQAbwZWSt/HQL2M+Nx6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 17:24:37.7447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1842bc76-9b6c-4ffe-5413-08d57d3dd084
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Bulie <radu-andrei.bulie@nxp.com>

This patch adds allmulticast option for memac, dtsec
and 10GEC controllers.

Signed-off-by: Radu Bulie <radu-andrei.bulie@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 10 +++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 19 ++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c | 32 +++++++++++++++++++++--
 drivers/net/ethernet/freescale/fman/fman_memac.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c  | 33 +++++++++++++++++++++---
 drivers/net/ethernet/freescale/fman/fman_tgec.h  |  1 +
 drivers/net/ethernet/freescale/fman/mac.c        |  3 +++
 drivers/net/ethernet/freescale/fman/mac.h        |  2 ++
 9 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 9bd0ff0..159dc2d 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -454,6 +454,16 @@ static void dpaa_set_rx_mode(struct net_device *net_dev)
 				  err);
 	}
 
+	if (!!(net_dev->flags & IFF_ALLMULTI) != priv->mac_dev->allmulti) {
+		priv->mac_dev->allmulti = !priv->mac_dev->allmulti;
+		err = priv->mac_dev->set_allmulti(priv->mac_dev->fman_mac,
+						  priv->mac_dev->allmulti);
+		if (err < 0)
+			netif_err(priv, drv, net_dev,
+				  "mac_dev->set_allmulti() = %d\n",
+				  err);
+	}
+
 	err = priv->mac_dev->set_multi(net_dev, priv->mac_dev);
 	if (err < 0)
 		netif_err(priv, drv, net_dev, "mac_dev->set_multi() = %d\n",
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index ea43b49..9a581fa 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -1117,6 +1117,25 @@ int dtsec_add_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr)
 	return 0;
 }
 
+int dtsec_set_allmulti(struct fman_mac *dtsec, bool enable)
+{
+	u32 tmp;
+	struct dtsec_regs __iomem *regs = dtsec->regs;
+
+	if (!is_init_done(dtsec->dtsec_drv_param))
+		return -EINVAL;
+
+	tmp = ioread32be(&regs->rctrl);
+	if (enable)
+		tmp |= RCTRL_MPROM;
+	else
+		tmp &= ~RCTRL_MPROM;
+
+	iowrite32be(tmp, &regs->rctrl);
+
+	return 0;
+}
+
 int dtsec_del_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr)
 {
 	struct dtsec_regs __iomem *regs = dtsec->regs;
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.h b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
index c4467c0..1a689ad 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
@@ -55,5 +55,6 @@ int dtsec_set_exception(struct fman_mac *dtsec,
 int dtsec_add_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr);
 int dtsec_del_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr);
 int dtsec_get_version(struct fman_mac *dtsec, u32 *mac_version);
+int dtsec_set_allmulti(struct fman_mac *dtsec, bool enable);
 
 #endif /* __DTSEC_H */
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index c029688..446a97b 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -350,6 +350,7 @@ struct fman_mac {
 	struct fman_rev_info fm_rev_info;
 	bool basex_if;
 	struct phy_device *pcsphy;
+	bool allmulti_enabled;
 };
 
 static void add_addr_in_paddr(struct memac_regs __iomem *regs, u8 *adr,
@@ -940,6 +941,29 @@ int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 	return 0;
 }
 
+int memac_set_allmulti(struct fman_mac *memac, bool enable)
+{
+	u32 entry;
+	struct memac_regs __iomem *regs = memac->regs;
+
+	if (!is_init_done(memac->memac_drv_param))
+		return -EINVAL;
+
+	if (enable) {
+		for (entry = 0; entry < HASH_TABLE_SIZE; entry++)
+			iowrite32be(entry | HASH_CTRL_MCAST_EN,
+				    &regs->hashtable_ctrl);
+	} else {
+		for (entry = 0; entry < HASH_TABLE_SIZE; entry++)
+			iowrite32be(entry & ~HASH_CTRL_MCAST_EN,
+				    &regs->hashtable_ctrl);
+	}
+
+	memac->allmulti_enabled = enable;
+
+	return 0;
+}
+
 int memac_del_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 {
 	struct memac_regs __iomem *regs = memac->regs;
@@ -963,8 +987,12 @@ int memac_del_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 			break;
 		}
 	}
-	if (list_empty(&memac->multicast_addr_hash->lsts[hash]))
-		iowrite32be(hash & ~HASH_CTRL_MCAST_EN, &regs->hashtable_ctrl);
+
+	if (!memac->allmulti_enabled) {
+		if (list_empty(&memac->multicast_addr_hash->lsts[hash]))
+			iowrite32be(hash & ~HASH_CTRL_MCAST_EN,
+				    &regs->hashtable_ctrl);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.h b/drivers/net/ethernet/freescale/fman/fman_memac.h
index c4a6646..b5a5033 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.h
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.h
@@ -57,5 +57,6 @@ int memac_set_exception(struct fman_mac *memac,
 			enum fman_mac_exceptions exception, bool enable);
 int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr);
 int memac_del_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr);
+int memac_set_allmulti(struct fman_mac *memac, bool enable);
 
 #endif /* __MEMAC_H */
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index 4b0f3a5..284735d 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -217,6 +217,7 @@ struct fman_mac {
 	struct tgec_cfg *cfg;
 	void *fm;
 	struct fman_rev_info fm_rev_info;
+	bool allmulti_enabled;
 };
 
 static void set_mac_address(struct tgec_regs __iomem *regs, u8 *adr)
@@ -564,6 +565,29 @@ int tgec_add_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 	return 0;
 }
 
+int tgec_set_allmulti(struct fman_mac *tgec, bool enable)
+{
+	u32 entry;
+	struct tgec_regs __iomem *regs = tgec->regs;
+
+	if (!is_init_done(tgec->cfg))
+		return -EINVAL;
+
+	if (enable) {
+		for (entry = 0; entry < TGEC_HASH_TABLE_SIZE; entry++)
+			iowrite32be(entry | TGEC_HASH_MCAST_EN,
+				    &regs->hashtable_ctrl);
+	} else {
+		for (entry = 0; entry < TGEC_HASH_TABLE_SIZE; entry++)
+			iowrite32be(entry & ~TGEC_HASH_MCAST_EN,
+				    &regs->hashtable_ctrl);
+	}
+
+	tgec->allmulti_enabled = enable;
+
+	return 0;
+}
+
 int tgec_del_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 {
 	struct tgec_regs __iomem *regs = tgec->regs;
@@ -591,9 +615,12 @@ int tgec_del_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 			break;
 		}
 	}
-	if (list_empty(&tgec->multicast_addr_hash->lsts[hash]))
-		iowrite32be((hash & ~TGEC_HASH_MCAST_EN),
-			    &regs->hashtable_ctrl);
+
+	if (!tgec->allmulti_enabled) {
+		if (list_empty(&tgec->multicast_addr_hash->lsts[hash]))
+			iowrite32be((hash & ~TGEC_HASH_MCAST_EN),
+				    &regs->hashtable_ctrl);
+	}
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.h b/drivers/net/ethernet/freescale/fman/fman_tgec.h
index 514bba9..cbbd3b4 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.h
@@ -51,5 +51,6 @@ int tgec_set_exception(struct fman_mac *tgec,
 int tgec_add_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr);
 int tgec_del_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr);
 int tgec_get_version(struct fman_mac *tgec, u32 *mac_version);
+int tgec_set_allmulti(struct fman_mac *tgec, bool enable);
 
 #endif /* __TGEC_H */
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 88c0a06..4829dcd 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -470,6 +470,7 @@ static void setup_dtsec(struct mac_device *mac_dev)
 	mac_dev->set_tx_pause		= dtsec_set_tx_pause_frames;
 	mac_dev->set_rx_pause		= dtsec_accept_rx_pause_frames;
 	mac_dev->set_exception		= dtsec_set_exception;
+	mac_dev->set_allmulti		= dtsec_set_allmulti;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
@@ -488,6 +489,7 @@ static void setup_tgec(struct mac_device *mac_dev)
 	mac_dev->set_tx_pause		= tgec_set_tx_pause_frames;
 	mac_dev->set_rx_pause		= tgec_accept_rx_pause_frames;
 	mac_dev->set_exception		= tgec_set_exception;
+	mac_dev->set_allmulti		= tgec_set_allmulti;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
@@ -506,6 +508,7 @@ static void setup_memac(struct mac_device *mac_dev)
 	mac_dev->set_tx_pause		= memac_set_tx_pause_frames;
 	mac_dev->set_rx_pause		= memac_accept_rx_pause_frames;
 	mac_dev->set_exception		= memac_set_exception;
+	mac_dev->set_allmulti		= memac_set_allmulti;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index eefb335..b520cec 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -59,6 +59,7 @@ struct mac_device {
 	bool rx_pause_active;
 	bool tx_pause_active;
 	bool promisc;
+	bool allmulti;
 
 	int (*init)(struct mac_device *mac_dev);
 	int (*start)(struct mac_device *mac_dev);
@@ -66,6 +67,7 @@ struct mac_device {
 	void (*adjust_link)(struct mac_device *mac_dev);
 	int (*set_promisc)(struct fman_mac *mac_dev, bool enable);
 	int (*change_addr)(struct fman_mac *mac_dev, enet_addr_t *enet_addr);
+	int (*set_allmulti)(struct fman_mac *mac_dev, bool enable);
 	int (*set_multi)(struct net_device *net_dev,
 			 struct mac_device *mac_dev);
 	int (*set_rx_pause)(struct fman_mac *mac_dev, bool en);
-- 
2.1.0
