Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D21EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133D72083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133D72083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbeGZOjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:39:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730263AbeGZOjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:39:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8DDE9DF530DF3;
        Thu, 26 Jul 2018 21:22:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.382.0; Thu, 26 Jul 2018
 21:22:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linyunsheng@huawei.com>, <matthias.bgg@gmail.com>,
        <lipeng321@huawei.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: hns: Make many functions static
Date:   Thu, 26 Jul 2018 21:19:58 +0800
Message-ID: <20180726131958.15532-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:73:20: warning: symbol 'hns_ae_get_handle' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:332:6: warning: symbol 'hns_ae_stop' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:360:6: warning: symbol 'hns_ae_toggle_ring_irq' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:580:6: warning: symbol 'hns_ae_update_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:663:6: warning: symbol 'hns_ae_get_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:695:6: warning: symbol 'hns_ae_get_strings' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:728:5: warning: symbol 'hns_ae_get_sset_count' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:774:6: warning: symbol 'hns_ae_update_led_status' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:786:5: warning: symbol 'hns_ae_cpld_set_led_id' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:798:6: warning: symbol 'hns_ae_get_regs' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c:823:5: warning: symbol 'hns_ae_get_regs_len' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c:342:6: warning: symbol 'hns_gmac_update_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:934:12: warning: symbol 'hns_mac_get_vaddr' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:953:5: warning: symbol 'hns_mac_get_cfg' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:343:6: warning: symbol 'hns_dsaf_srst_chns' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:366:1: warning: symbol 'hns_dsaf_srst_chns_acpi' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:373:6: warning: symbol 'hns_dsaf_roce_srst' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:387:6: warning: symbol 'hns_dsaf_roce_srst_acpi' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:571:5: warning: symbol 'hns_mac_get_sfp_prsnt' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c:589:5: warning: symbol 'hns_mac_get_sfp_prsnt_acpi' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:31:12: warning: symbol 'g_dsaf_mode_match' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:45:5: warning: symbol 'hns_dsaf_get_cfg' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:962:6: warning: symbol 'hns_dsaf_tcam_addr_get' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2087:6: warning: symbol 'hns_dsaf_port_work_rate_cfg' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c:2837:5: warning: symbol 'hns_dsaf_roce_reset' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c:76:5: warning: symbol 'hns_ppe_common_get_cfg' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c:107:6: warning: symbol 'hns_ppe_common_free_cfg' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c:340:6: warning: symbol 'hns_ppe_uninit_ex' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c:708:5: warning: symbol 'hns_rcb_get_ring_num' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c:744:14: warning: symbol 'hns_rcb_common_get_vaddr' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c:314:6: warning: symbol 'hns_xgmac_update_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_enet.c:1303:6: warning: symbol 'hns_nic_update_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_enet.c:1585:6: warning: symbol 'hns_nic_poll_controller' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_enet.c:1938:6: warning: symbol 'hns_set_multicast_list' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_enet.c:1960:6: warning: symbol 'hns_nic_set_rx_mode' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:661:6: warning: symbol 'hns_get_ringparam' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:811:6: warning: symbol 'hns_get_channels' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:828:6: warning: symbol 'hns_get_ethtool_stats' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:886:6: warning: symbol 'hns_get_strings' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:976:5: warning: symbol 'hns_get_sset_count' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1010:5: warning: symbol 'hns_phy_led_set' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1032:5: warning: symbol 'hns_set_phys_id' was not declared. Should it be static?
drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1106:6: warning: symbol 'hns_get_regs' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  | 30 +++++++++++-----------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  8 +++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 14 +++++-----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c | 13 +++++-----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  7 ++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  4 +--
 .../net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c    |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  8 +++---
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   | 24 +++++++++--------
 10 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
index bd68379..e6aad30 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c
@@ -70,8 +70,8 @@ static struct ring_pair_cb *hns_ae_get_ring_pair(struct hnae_queue *q)
 	return container_of(q, struct ring_pair_cb, q);
 }
 
-struct hnae_handle *hns_ae_get_handle(struct hnae_ae_dev *dev,
-				      u32 port_id)
+static struct hnae_handle *hns_ae_get_handle(struct hnae_ae_dev *dev,
+					     u32 port_id)
 {
 	int vfnum_per_port;
 	int qnum_per_vf;
@@ -329,7 +329,7 @@ static int hns_ae_start(struct hnae_handle *handle)
 	return 0;
 }
 
-void hns_ae_stop(struct hnae_handle *handle)
+static void hns_ae_stop(struct hnae_handle *handle)
 {
 	struct hns_mac_cb *mac_cb = hns_get_mac_cb(handle);
 
@@ -357,7 +357,7 @@ static void hns_ae_reset(struct hnae_handle *handle)
 	}
 }
 
-void hns_ae_toggle_ring_irq(struct hnae_ring *ring, u32 mask)
+static void hns_ae_toggle_ring_irq(struct hnae_ring *ring, u32 mask)
 {
 	u32 flag;
 
@@ -577,8 +577,8 @@ static void hns_ae_get_coalesce_range(struct hnae_handle *handle,
 	*rx_usecs_high  = HNS_RCB_RX_USECS_HIGH;
 }
 
-void hns_ae_update_stats(struct hnae_handle *handle,
-			 struct net_device_stats *net_stats)
+static void hns_ae_update_stats(struct hnae_handle *handle,
+				struct net_device_stats *net_stats)
 {
 	int port;
 	int idx;
@@ -660,7 +660,7 @@ void hns_ae_update_stats(struct hnae_handle *handle,
 	net_stats->multicast = mac_cb->hw_stats.rx_mc_pkts;
 }
 
-void hns_ae_get_stats(struct hnae_handle *handle, u64 *data)
+static void hns_ae_get_stats(struct hnae_handle *handle, u64 *data)
 {
 	int idx;
 	struct hns_mac_cb *mac_cb;
@@ -692,8 +692,8 @@ void hns_ae_get_stats(struct hnae_handle *handle, u64 *data)
 		hns_dsaf_get_stats(vf_cb->dsaf_dev, p, vf_cb->port_index);
 }
 
-void hns_ae_get_strings(struct hnae_handle *handle,
-			u32 stringset, u8 *data)
+static void hns_ae_get_strings(struct hnae_handle *handle,
+			       u32 stringset, u8 *data)
 {
 	int port;
 	int idx;
@@ -725,7 +725,7 @@ void hns_ae_get_strings(struct hnae_handle *handle,
 		hns_dsaf_get_strings(stringset, p, port, dsaf_dev);
 }
 
-int hns_ae_get_sset_count(struct hnae_handle *handle, int stringset)
+static int hns_ae_get_sset_count(struct hnae_handle *handle, int stringset)
 {
 	u32 sset_count = 0;
 	struct hns_mac_cb *mac_cb;
@@ -771,7 +771,7 @@ static int hns_ae_config_loopback(struct hnae_handle *handle,
 	return ret;
 }
 
-void hns_ae_update_led_status(struct hnae_handle *handle)
+static void hns_ae_update_led_status(struct hnae_handle *handle)
 {
 	struct hns_mac_cb *mac_cb;
 
@@ -783,8 +783,8 @@ void hns_ae_update_led_status(struct hnae_handle *handle)
 	hns_set_led_opt(mac_cb);
 }
 
-int hns_ae_cpld_set_led_id(struct hnae_handle *handle,
-			   enum hnae_led_state status)
+static int hns_ae_cpld_set_led_id(struct hnae_handle *handle,
+				  enum hnae_led_state status)
 {
 	struct hns_mac_cb *mac_cb;
 
@@ -795,7 +795,7 @@ int hns_ae_cpld_set_led_id(struct hnae_handle *handle,
 	return hns_cpld_led_set_id(mac_cb, status);
 }
 
-void hns_ae_get_regs(struct hnae_handle *handle, void *data)
+static void hns_ae_get_regs(struct hnae_handle *handle, void *data)
 {
 	u32 *p = data;
 	int i;
@@ -820,7 +820,7 @@ void hns_ae_get_regs(struct hnae_handle *handle, void *data)
 		hns_dsaf_get_regs(vf_cb->dsaf_dev, vf_cb->port_index, p);
 }
 
-int hns_ae_get_regs_len(struct hnae_handle *handle)
+static int hns_ae_get_regs_len(struct hnae_handle *handle)
 {
 	u32 total_num;
 	struct hnae_vf_cb *vf_cb = hns_ae_get_vf_cb(handle);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
index 74bd260..5488c6e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c
@@ -339,7 +339,7 @@ static void hns_gmac_init(void *mac_drv)
 			   GMAC_TX_WATER_LINE_SHIFT, 8);
 }
 
-void hns_gmac_update_stats(void *mac_drv)
+static void hns_gmac_update_stats(void *mac_drv)
 {
 	struct mac_hw_stats *hw_stats = NULL;
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 9dcc576..6e5107d 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -931,8 +931,9 @@ static int hns_mac_get_mode(phy_interface_t phy_if)
 	}
 }
 
-u8 __iomem *hns_mac_get_vaddr(struct dsaf_device *dsaf_dev,
-			      struct hns_mac_cb *mac_cb, u32 mac_mode_idx)
+static u8 __iomem *
+hns_mac_get_vaddr(struct dsaf_device *dsaf_dev,
+		  struct hns_mac_cb *mac_cb, u32 mac_mode_idx)
 {
 	u8 __iomem *base = dsaf_dev->io_base;
 	int mac_id = mac_cb->mac_id;
@@ -950,7 +951,8 @@ u8 __iomem *hns_mac_get_vaddr(struct dsaf_device *dsaf_dev,
  * @mac_cb: mac control block
  * return 0 - success , negative --fail
  */
-int hns_mac_get_cfg(struct dsaf_device *dsaf_dev, struct hns_mac_cb *mac_cb)
+static int
+hns_mac_get_cfg(struct dsaf_device *dsaf_dev, struct hns_mac_cb *mac_cb)
 {
 	int ret;
 	u32 mac_mode_idx;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index 0ce07f6..7afc675 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -28,7 +28,7 @@
 #include "hns_dsaf_rcb.h"
 #include "hns_dsaf_misc.h"
 
-const char *g_dsaf_mode_match[DSAF_MODE_MAX] = {
+const static char *g_dsaf_mode_match[DSAF_MODE_MAX] = {
 	[DSAF_MODE_DISABLE_2PORT_64VM] = "2port-64vf",
 	[DSAF_MODE_DISABLE_6PORT_0VM] = "6port-16rss",
 	[DSAF_MODE_DISABLE_6PORT_16VM] = "6port-16vf",
@@ -42,7 +42,7 @@ static const struct acpi_device_id hns_dsaf_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, hns_dsaf_acpi_match);
 
-int hns_dsaf_get_cfg(struct dsaf_device *dsaf_dev)
+static int hns_dsaf_get_cfg(struct dsaf_device *dsaf_dev)
 {
 	int ret, i;
 	u32 desc_num;
@@ -959,7 +959,8 @@ static void hns_dsaf_tcam_mc_invld(struct dsaf_device *dsaf_dev, u32 address)
 	spin_unlock_bh(&dsaf_dev->tcam_lock);
 }
 
-void hns_dsaf_tcam_addr_get(struct dsaf_drv_tbl_tcam_key *mac_key, u8 *addr)
+static void
+hns_dsaf_tcam_addr_get(struct dsaf_drv_tbl_tcam_key *mac_key, u8 *addr)
 {
 	addr[0] = mac_key->high.bits.mac_0;
 	addr[1] = mac_key->high.bits.mac_1;
@@ -2084,8 +2085,9 @@ static void hns_dsaf_pfc_unit_cnt(struct dsaf_device *dsaf_dev, int  mac_id,
  * @dsaf_id: dsa fabric id
  * @xge_ge_work_mode
  */
-void hns_dsaf_port_work_rate_cfg(struct dsaf_device *dsaf_dev, int mac_id,
-				 enum dsaf_port_rate_mode rate_mode)
+static void
+hns_dsaf_port_work_rate_cfg(struct dsaf_device *dsaf_dev, int mac_id,
+			    enum dsaf_port_rate_mode rate_mode)
 {
 	u32 port_work_mode;
 
@@ -2834,7 +2836,7 @@ module_platform_driver(g_dsaf_driver);
  * @enable: false - request reset , true - drop reset
  * retuen 0 - success , negative -fail
  */
-int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
+static int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset)
 {
 	struct dsaf_device *dsaf_dev;
 	struct platform_device *pdev;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index acf2963..16294cd 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -340,7 +340,8 @@ static void hns_dsaf_xge_srst_by_port_acpi(struct dsaf_device *dsaf_dev,
  * bit18-19 for com/dfx
  * @enable: false - request reset , true - drop reset
  */
-void hns_dsaf_srst_chns(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
+static void
+hns_dsaf_srst_chns(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
 {
 	u32 reg_addr;
 
@@ -362,7 +363,7 @@ void hns_dsaf_srst_chns(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
  * bit18-19 for com/dfx
  * @enable: false - request reset , true - drop reset
  */
-void
+static void
 hns_dsaf_srst_chns_acpi(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
 {
 	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
@@ -370,7 +371,7 @@ hns_dsaf_srst_chns_acpi(struct dsaf_device *dsaf_dev, u32 msk, bool dereset)
 				   msk, dereset);
 }
 
-void hns_dsaf_roce_srst(struct dsaf_device *dsaf_dev, bool dereset)
+static void hns_dsaf_roce_srst(struct dsaf_device *dsaf_dev, bool dereset)
 {
 	if (!dereset) {
 		dsaf_write_sub(dsaf_dev, DSAF_SUB_SC_ROCEE_RESET_REQ_REG, 1);
@@ -384,7 +385,7 @@ void hns_dsaf_roce_srst(struct dsaf_device *dsaf_dev, bool dereset)
 	}
 }
 
-void hns_dsaf_roce_srst_acpi(struct dsaf_device *dsaf_dev, bool dereset)
+static void hns_dsaf_roce_srst_acpi(struct dsaf_device *dsaf_dev, bool dereset)
 {
 	hns_dsaf_acpi_srst_by_port(dsaf_dev, HNS_OP_RESET_FUNC,
 				   HNS_ROCE_RESET_FUNC, 0, dereset);
@@ -568,7 +569,7 @@ static phy_interface_t hns_mac_get_phy_if_acpi(struct hns_mac_cb *mac_cb)
 	return phy_if;
 }
 
-int hns_mac_get_sfp_prsnt(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
+static int hns_mac_get_sfp_prsnt(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
 {
 	u32 val = 0;
 	int ret;
@@ -586,7 +587,7 @@ int hns_mac_get_sfp_prsnt(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
 	return 0;
 }
 
-int hns_mac_get_sfp_prsnt_acpi(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
+static int hns_mac_get_sfp_prsnt_acpi(struct hns_mac_cb *mac_cb, int *sfp_prsnt)
 {
 	union acpi_object *obj;
 	union acpi_object obj_args, argv4;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index 93e71e2..1c3db67 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -73,7 +73,7 @@ hns_ppe_common_get_ioaddr(struct ppe_common_cb *ppe_common)
  * comm_index: common index
  * retuen 0 - success , negative --fail
  */
-int hns_ppe_common_get_cfg(struct dsaf_device *dsaf_dev, int comm_index)
+static int hns_ppe_common_get_cfg(struct dsaf_device *dsaf_dev, int comm_index)
 {
 	struct ppe_common_cb *ppe_common;
 	int ppe_num;
@@ -104,7 +104,8 @@ int hns_ppe_common_get_cfg(struct dsaf_device *dsaf_dev, int comm_index)
 	return 0;
 }
 
-void hns_ppe_common_free_cfg(struct dsaf_device *dsaf_dev, u32 comm_index)
+static void
+hns_ppe_common_free_cfg(struct dsaf_device *dsaf_dev, u32 comm_index)
 {
 	dsaf_dev->ppe_common[comm_index] = NULL;
 }
@@ -337,7 +338,7 @@ static void hns_ppe_uninit_hw(struct hns_ppe_cb *ppe_cb)
 	}
 }
 
-void hns_ppe_uninit_ex(struct ppe_common_cb *ppe_common)
+static void hns_ppe_uninit_ex(struct ppe_common_cb *ppe_common)
 {
 	u32 i;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index e2e2853..9d76e2e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -705,7 +705,7 @@ void hns_rcb_get_queue_mode(enum dsaf_mode dsaf_mode, u16 *max_vfn,
 	}
 }
 
-int hns_rcb_get_ring_num(struct dsaf_device *dsaf_dev)
+static int hns_rcb_get_ring_num(struct dsaf_device *dsaf_dev)
 {
 	switch (dsaf_dev->dsaf_mode) {
 	case DSAF_MODE_ENABLE_FIX:
@@ -741,7 +741,7 @@ int hns_rcb_get_ring_num(struct dsaf_device *dsaf_dev)
 	}
 }
 
-void __iomem *hns_rcb_common_get_vaddr(struct rcb_common_cb *rcb_common)
+static void __iomem *hns_rcb_common_get_vaddr(struct rcb_common_cb *rcb_common)
 {
 	struct dsaf_device *dsaf_dev = rcb_common->dsaf_dev;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
index 51e7e9f..40711af 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.c
@@ -311,7 +311,7 @@ static void hns_xgmac_config_max_frame_length(void *mac_drv, u16 newval)
 	dsaf_write_dev(drv, XGMAC_MAC_MAX_PKT_SIZE_REG, newval);
 }
 
-void hns_xgmac_update_stats(void *mac_drv)
+static void hns_xgmac_update_stats(void *mac_drv)
 {
 	struct mac_driver *drv = (struct mac_driver *)mac_drv;
 	struct mac_hw_stats *hw_stats = &drv->mac_cb->hw_stats;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 948b3e0..c2ac187 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -1300,7 +1300,7 @@ static int hns_nic_net_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-void hns_nic_update_stats(struct net_device *netdev)
+static void hns_nic_update_stats(struct net_device *netdev)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_handle *h = priv->ae_handle;
@@ -1582,7 +1582,7 @@ static int hns_nic_do_ioctl(struct net_device *netdev, struct ifreq *ifr,
 
 /* use only for netconsole to poll with the device without interrupt */
 #ifdef CONFIG_NET_POLL_CONTROLLER
-void hns_nic_poll_controller(struct net_device *ndev)
+static void hns_nic_poll_controller(struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 	unsigned long flags;
@@ -1935,7 +1935,7 @@ static int hns_nic_uc_unsync(struct net_device *netdev,
  *
  * return void
  */
-void hns_set_multicast_list(struct net_device *ndev)
+static void hns_set_multicast_list(struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 	struct hnae_handle *h = priv->ae_handle;
@@ -1957,7 +1957,7 @@ void hns_set_multicast_list(struct net_device *ndev)
 	}
 }
 
-void hns_nic_set_rx_mode(struct net_device *ndev)
+static void hns_nic_set_rx_mode(struct net_device *ndev)
 {
 	struct hns_nic_priv *priv = netdev_priv(ndev);
 	struct hnae_handle *h = priv->ae_handle;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
index 2e14a3a..3957205 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_ethtool.c
@@ -658,8 +658,8 @@ static void hns_nic_get_drvinfo(struct net_device *net_dev,
  * @dev: net device
  * @param: ethtool parameter
  */
-void hns_get_ringparam(struct net_device *net_dev,
-		       struct ethtool_ringparam *param)
+static void hns_get_ringparam(struct net_device *net_dev,
+			      struct ethtool_ringparam *param)
 {
 	struct hns_nic_priv *priv = netdev_priv(net_dev);
 	struct hnae_ae_ops *ops;
@@ -808,7 +808,8 @@ static int hns_set_coalesce(struct net_device *net_dev,
  * @dev: net device
  * @ch: channel info.
  */
-void hns_get_channels(struct net_device *net_dev, struct ethtool_channels *ch)
+static void
+hns_get_channels(struct net_device *net_dev, struct ethtool_channels *ch)
 {
 	struct hns_nic_priv *priv = netdev_priv(net_dev);
 
@@ -825,8 +826,8 @@ void hns_get_channels(struct net_device *net_dev, struct ethtool_channels *ch)
  * @stats: statistics info.
  * @data: statistics data.
  */
-void hns_get_ethtool_stats(struct net_device *netdev,
-			   struct ethtool_stats *stats, u64 *data)
+static void hns_get_ethtool_stats(struct net_device *netdev,
+				  struct ethtool_stats *stats, u64 *data)
 {
 	u64 *p = data;
 	struct hns_nic_priv *priv = netdev_priv(netdev);
@@ -883,7 +884,7 @@ void hns_get_ethtool_stats(struct net_device *netdev,
  * @stats: string set ID.
  * @data: objects data.
  */
-void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
+static void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_handle *h = priv->ae_handle;
@@ -973,7 +974,7 @@ void hns_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
  *
  * Return string set count.
  */
-int hns_get_sset_count(struct net_device *netdev, int stringset)
+static int hns_get_sset_count(struct net_device *netdev, int stringset)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_handle *h = priv->ae_handle;
@@ -1007,7 +1008,7 @@ int hns_get_sset_count(struct net_device *netdev, int stringset)
  *
  * Return 0 on success, negative on failure.
  */
-int hns_phy_led_set(struct net_device *netdev, int value)
+static int hns_phy_led_set(struct net_device *netdev, int value)
 {
 	int retval;
 	struct phy_device *phy_dev = netdev->phydev;
@@ -1029,7 +1030,8 @@ int hns_phy_led_set(struct net_device *netdev, int value)
  *
  * Return 0 on success, negative on failure.
  */
-int hns_set_phys_id(struct net_device *netdev, enum ethtool_phys_id_state state)
+static int
+hns_set_phys_id(struct net_device *netdev, enum ethtool_phys_id_state state)
 {
 	struct hns_nic_priv *priv = netdev_priv(netdev);
 	struct hnae_handle *h = priv->ae_handle;
@@ -1103,8 +1105,8 @@ int hns_set_phys_id(struct net_device *netdev, enum ethtool_phys_id_state state)
  * @cmd: ethtool cmd
  * @date: register data
  */
-void hns_get_regs(struct net_device *net_dev, struct ethtool_regs *cmd,
-		  void *data)
+static void hns_get_regs(struct net_device *net_dev, struct ethtool_regs *cmd,
+			 void *data)
 {
 	struct hns_nic_priv *priv = netdev_priv(net_dev);
 	struct hnae_ae_ops *ops;
-- 
2.7.0


