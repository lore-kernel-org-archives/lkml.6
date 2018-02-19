Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeBSQMC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:12:02 -0500
Received: from mail-ve1eur01on0059.outbound.protection.outlook.com ([104.47.1.59]:39872
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753111AbeBSQLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:11:21 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
        Radu Bulie <radu-andrei.bulie@nxp.com>
Subject: [PATCH net-next 4/4] dpaa_eth: Add allmulti option
Date: Mon, 19 Feb 2018 10:10:44 -0600
Message-Id: <20180219161044.30279-5-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180219161044.30279-1-madalin.bucur@nxp.com>
References: <20180219161044.30279-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.1]
X-ClientProxiedBy: MWHPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:301:39::33) To VI1PR04MB3278.eurprd04.prod.outlook.com
 (2603:10a6:802:f::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eea91b06-5b44-4bf0-5976-08d577b3690a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR04MB3278;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;3:P/tDzBDC0zEtusj4mHqBK48P9CMsYwUs3U3IkpcqePjATiAYujp9SIjFoilckQ8sIARk2wydzfl6Kmxhn1Vekn2gtUo5UBc1mYMIz63f0kJ75/+gJYNchQmtPx+yJl8+BStIp5MtlCpyv975PwxIS2GufhGm6Ew7CzjMrlrNswc284sO8710rTsW9DWWrgrDSIvm32EAupFhXOl34A3uSuxHNCTnF33L8GGTYuVtFwxui/euiCfh9a26ePaoZQfo;25:hi9Y/qzBgMgoYe+MGfKvoDoujPLZW7ADHXVUzRTEmvP9pledW5Yn1xHmqWbzB7HJ5FdkasnbUOjL3T2b8jta3H5CtiXSFXA35dOTvKe9yqOD3ZT34AN8+6N0YiblWkuEaZJfgmjltjeNbIx/kMKTg2ww0APn4+N1/hr1pBwvOHPsg2kJfeKhJs26COfmcq3NO63gzJNKd53WnN51rTB4HXQhSlVm0p5imRibg0jOGpBXUIgCqLQm6/4LeQCrCd+AMb0/O2QcO+J4DPMDtJy0kPqgoeHKKtLi83LX9nsN9B887i+/IGrsfDIOzKAe2qOkzHoHfqnioU1wTA+Cohroqw==;31:ANhzskjF7ApAskiTgc+K/2WXeUVVmZZpYRC/zMD12meLfgKhh4CdnhdSPZAlnG2pEOGtP//R3eolab0mqpvaeocefsyc8io7l1yxKcWl5B3ugjDkwMc5wb2syQkg3hgE1Ap2AFj4R+5q6bgqBa17tT0chdVFdI8DwWnmKuiHua03SSRJijJnxwTI8O8a5PUUZKr395w0NBvZPWJ01Hf6Z45uuvD5C/eY1YX3ebrXSE0=
X-MS-TrafficTypeDiagnostic: VI1PR04MB3278:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;20:1GzSLKgKn9jbO7Eb9tMEyhl4RBfcoEsIVxGfwcUJ7JN+fdYulfxaZj56/CsX8y30r6oKP0MtqnLRo8YTt1WEpKSHQCqMct2lzYe5EgOW4uLQ3JQT/xOIlFuYxbmrIzNApvDbge27SGQRGpVAuEbvX+5vU6EUATzJUu8iiTqMLD1A2t1m0rO0QuXJGef7lrgD5aUIOgD8VKj8PX24VdQo0tmGlomg9CXodWuArXecDHt/RIMeGZqMZ33aLQVMuxInrjvCdvInqJlOUNcyGCnJ2sOLkDBjE03Hl1gPaA/DCn/M/fxDkwWLxHlI+HG+UhN4wsANGK8aK3pJxBDxAWDSsCUfCmVIA0EaBC1HRGciHd0H7hnjVGLDgF43KtHw9rGjKPZFOUTbbnpLcdwApjSneXGhokwMqVPG9NwWiDRxVH/fa8LU0fc93lZWhTwUagSVvaaHdY+lbsWOnNbOZ1MxcapuyjhAaJCUICULFA0NmCZJhWKJx1GcTYV1Uc91J+3t;4:gTil7LIFgUzduTVt8u9E1bvIJxr6Qa2JrCko8hzlXqgeGJlEU8AvrQX4p0Ou2UcwdvJcPTGD9X/ArY1ivVSSa+nvBZ/0gzCIb4zak6PeQ2gu6dF2f3hSWaTHNurcQFF5rOC9ySYAvv3jdZSSSMzcnZxUIpt7cn5O/ypkHZhTtD/IPwO20n8ODUN+ae+607ZBv03Eez6BjeJhurG/CNwLY+5vDqmV2KhQMkqH8w4oq4/82h4b/X5lLKCq0H1I4MtkcISnDEcJW+nVNhIV+l5C3cInAiEphtZu9s6mnqMa5rnVoFr2MT4DqhROBt9ZBdCp
X-Microsoft-Antispam-PRVS: <VI1PR04MB32789DC0B13A2A9C222E666BECC80@VI1PR04MB3278.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB3278;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3278;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(68736007)(105586002)(26005)(43066004)(6486002)(16526019)(3846002)(81156014)(81166006)(6116002)(66066001)(575784001)(8676002)(1076002)(186003)(2906002)(47776003)(86362001)(50226002)(2361001)(3450700001)(2351001)(478600001)(6506007)(386003)(4326008)(7736002)(36756003)(76176011)(52116002)(51416003)(48376002)(50466002)(305945005)(25786009)(6512007)(6916009)(5660300001)(2950100002)(8936002)(6666003)(316002)(106356001)(16586007)(97736004)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3278;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB3278;23:AADIBkpQ7i6Ltt9wmKf7SBGnRWbyXBOSyJ2HvTVBH?=
 =?us-ascii?Q?qW/10/Wp6y1lf9PYAWOHlAjnlBo0TNd45zy6wIvXIPvx1auV5rwjGxTyEQXh?=
 =?us-ascii?Q?zB0ol9ClDUpck55hfgRPqogZWkMPTpISHhFxfU76sPN+XG8S23piFoMpCpqa?=
 =?us-ascii?Q?ldH++Xl+fWAz18raP9uNze4NW+l6y8u18bjzmZh1WePg3oJZW/sIvX9xXX5Y?=
 =?us-ascii?Q?q91475kEiomRwS5isg+4zJcRudaFId63XpfZ3BnLQQ2S+jCSP+UHu/QQGi47?=
 =?us-ascii?Q?XuUY8PpnDFv364cnETXyhoJbxEs9jjDadEWBiAtUm202x5yurYjxiqeCtpSR?=
 =?us-ascii?Q?47PNL18l8ZtJmUiW0U4mw8w9fn6c9IZBChz7nvPSiKj9v0IN1WQABO2vdrm0?=
 =?us-ascii?Q?oLZIC4HmA78lwYjTWJgzLmm50GPYSmxxGgyX16IlcfsRHkoCUz19n+cFIqlQ?=
 =?us-ascii?Q?0CGzdHw4SkhrQlzCUP9QINNH4o7SfuZd+CKE7NRqZDWvT+hGp3+l2lcx4HnW?=
 =?us-ascii?Q?hOiuVERe0mY0bN8slfFdV3euJvQMYboE5A4Ykip9ZmnTNfyJHTIUT4bGeC9S?=
 =?us-ascii?Q?H52Wk99FnSq1mk2wYH9zcpYDiYQ7MmxCx8HJivGt9u2xorQI5CDJcEmbDcNJ?=
 =?us-ascii?Q?MLSzwHBHwGiO/Oz++AYza9Ch5NkY7fkIqDTkiv53V469PDAfWv5+hx8Boadq?=
 =?us-ascii?Q?s9lxzyGY8C1eNNYdmIGWGz+93xC5Kd0w+N6Ca9uBicGkMY5aHw3qUh5RQeLg?=
 =?us-ascii?Q?NwRWLL6OJVBek3tO9hvdDA0UIiof/Qyo8twkxauGUPcUcfx0nwHOJIMyNf3+?=
 =?us-ascii?Q?U9BtdZZpLkWWjLM2NTubZ2jIcE4zGhTnoJEfTpubP+C1qA6/Kg9FpVM58t0q?=
 =?us-ascii?Q?J1yd+vAOLI4L54HqTVZsc3ApCkD+pgkoqr3183DcYPeJ1L3dhbK7c4cR8AOb?=
 =?us-ascii?Q?sMy4+XWcP1UdbOnLafDO7QZ6rSZQSbS27IY62N69v4y0IwSR3gIwfsPVXSfx?=
 =?us-ascii?Q?2debCjTfK1n3t23ckka5H0gA3mfIO/L+yvcbdt4ySIz9r/+CuUNlq2rZFoVw?=
 =?us-ascii?Q?yzmRbYhgDaaQI9vvDUKtTjbjG9C5VxrgdnyYLxtG+/6QHuG4mn9u3U+VWcfP?=
 =?us-ascii?Q?vJcnPweTW33lzU90bdx9fBx5LmoSzDQP7QtjNkqqPH0mk6cPyb6w+SJselL8?=
 =?us-ascii?Q?sVoIaVUwGTUXqyd32bIk/T/qb32CSZMgvj70+Ga6DIZI2dcfnVzAGfrvQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB3278;6:+u/LScnvFo2gQa9K09Q2rxBsN59GnMK7VyAaPCa3wrITcC3UbHSs1GB+ebu9Wgw6Wdgwvtpc81RhzKTfwRiI+4N2BCCaLc2XKVtBawKOyizG0yrpkBqwuPu9Plrx1wDd/mk2NOV67oMG6KA0uBuRVlnDMrjjd/JmqvJRjja4WO/Du5nBdG7MpN/NBz495/O9PMTVZtMfdLrdzsYkOiwOitSKVYCWVrk2+Fk6Btyg6lApFCUIhD+JoZPoU6ryQEe+EZ22jLFQ5NZGvKMoKE58dv8c9mKgC8649TVis7EarJdiFUGnwwJY+5YpI0InXV8guaBmUxFGC4AT7pwmSfNXpRf7K52OyLGH5+qVa8ZB/4Y=;5:raocFpSkieEJk6ib5GymGeq8Ze2nLLyJlIWR4pdB87a+TlLR4U+GZxemaepimVhFFu1IBUQRIw+gKtIHRnoxsS+q+GXREaPjcXuphEVlpscXOr/ADbeZyoU05SSvj/zvrJD4jsCy1rGLoBKkAUrdrbR5KKYd+tffEzj6uL7+RcQ=;24:eyw6d+qVokzLZu5E4s3Jc+80gYAlbKPaxYjctPnSPVt+CBLjleVg3vfY1UY8SB5+/6w662TfTT23pjv5C8qR9k8JrN3r/5wMYn+h3AopZ8U=;7:4hNDYe7vv6AWvmtHcbH17rbna+geYx9munJrvB+/f/7YoEFxOL72mbaRdGw1nshzriKVG/L7bWEj7zV7ofEKhUC5rFq/rPsjXUg5Ugu6+Opt5dSi1oeMGhvXtVrU4LrEblFYdqcgjIgh/s06FvM4QTZxQo8m02+1mfkzvO7aHEOmtms6byxagrGRG7P7gqRU+a/xMqjWiygItQ0GumhOoeSkgAlRIsDeER3FauWss5a6izTkiz209ukg1SHnTumT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:11:17.5274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eea91b06-5b44-4bf0-5976-08d577b3690a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3278
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
index 2f53e8b..092c6c2 100644
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
