Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3639C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501342086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501342086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbeJPR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:59:07 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeJPR7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:59:07 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiagR-1fgaUj2if9-00flZc; Tue, 16 Oct 2018 12:08:54 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiagR-1fgaUj2if9-00flZc; Tue, 16 Oct 2018 12:08:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Alexander Duyck <alexander.h.duyck@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ixgbe: fix XFRM_ALGO dependency
Date:   Tue, 16 Oct 2018 12:03:41 +0200
Message-Id: <20181016100848.1329843-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:S9WfBRF3MhorrZUyVsq1Po2o06VgBZk9FFPsT9K7GoQ+Ebch/IT
 tVgkMSDQIZMBmSV3lGFJG6/nZ/SkrG8N0+GPRoNQOe5waeMWsDa/pGAFD7yPQCFBYQa7DY1
 QBwSjQOmzOFGJpy+O1/Jr99wfnGqCToTfskyHnGs5ZbEj7C5xjFr0574xVjc/5w7bmzS2lv
 CY9Tos+ChHaLqJxVnAWew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/aa6vRZR+Ek=:DgDQEGEQ+6hXU811qaZ06+
 2VmdPpaFrkmYtHIg6Aidy00MJ8WXW/Ep7y5qJ6Rl/6EPi36pTANCz3B7MMz+VR230dQBioyB2
 VAz0o5S4Gx6IVZ1TTQP2wrV2TbZnK4n2WXmEtDBb4YCjT2dT1ki8959+SlhoaxEgSglOQzuaP
 pbC1ReRVmpfX/AYUIDICjpWNqLWv1Dj7JlKpbtTVW6hiXjAYZCt2vtmGUVsMOv7qQjfkH5mI8
 gJgCKT2HBDTz/GqmX28p8XPtsITFB4z3r4uol1OEHNYnrF1xIWYBXbC+z0dcR1i9VVP9aOhNU
 i6AdmdpS7UjLaaSRoahGudfobluRYufha5k+shq0M/bXJVoO+moXojz9YA1AVCqU3Mp7Kzt5q
 KkQv9bgYH6W3rpVgwR5tcmBrJuUjFmXGFaRQEdoIjHbVOi833d1wIaJI0dUNlD0mGpRMUQXaT
 a422dQ/dQ7N7JC7Yj9ZlC4O4iHnHjiAJtop5a2esxNYzU4/uAQdMraQhkJUb2ztC8G/h4tLI4
 3a8nRZkmJ/mdNChNGUTGj0sNnsIiT44vVn10T6xAIPdmlI3b2kV5W8+XZHl4YzJC5SplDfHVt
 FOi5Nfaj5DbxHgMk7XOogCNWnY3tNQLtwaknRrSMFtvwr5z5MWOA3NqwUcW6gjZVJDK0bZZyY
 mLfXKxxZhpEUEwh7Is8qTb+9Fzat2MRSfk/DCKrWyqQfoZsWsHuv5FhwDPcpzaEFUTC8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When XFRM_ALGO is not enabled, the new igxge ipsec code produces a
link error:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function `ixgbe_ipsec_vf_add_sa':
ixgbe_ipsec.c:(.text+0x1266): undefined reference to `xfrm_aead_get_byname'

Simply selectin XFRM_ALGO from here causes circular dependencies, so
to fix it, we probably want this slightly more complex solution that is
similar to what other drivers with XFRM offload do:

A separate Kconfig symbol now controls whether we include the ipsec
offload code. To keep the old behavior, this is left as 'default y'. The
dependency in XFRM_OFFLOAD still causes a circular dependency but is
not actually needed because this symbol is not user visible, so removing
that dependency on top makes it all work.

Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/Kconfig            | 10 ++++++++++
 drivers/net/ethernet/intel/ixgbe/Makefile     |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  8 ++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  6 +++---
 net/xfrm/Kconfig                              |  1 -
 5 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index b542aba6f0e8..d1db382d8299 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -194,6 +194,16 @@ config IXGBE_DCB
 
 	  If unsure, say N.
 
+config IXGBE_IPSEC
+	bool "IPSec XFRM cryptography-offload accelaration"
+	default n
+	depends on IXGBE
+	depends on XFRM_OFFLOAD
+	default y
+	select XFRM_ALGO
+	---help---
+	  Enable support for IPSec offload in ixgbe.ko
+
 config IXGBEVF
 	tristate "Intel(R) 10GbE PCI Express Virtual Function Ethernet support"
 	depends on PCI_MSI
diff --git a/drivers/net/ethernet/intel/ixgbe/Makefile b/drivers/net/ethernet/intel/ixgbe/Makefile
index ca6b0c458e4a..4fb0d9e3f2da 100644
--- a/drivers/net/ethernet/intel/ixgbe/Makefile
+++ b/drivers/net/ethernet/intel/ixgbe/Makefile
@@ -17,4 +17,4 @@ ixgbe-$(CONFIG_IXGBE_DCB) +=  ixgbe_dcb.o ixgbe_dcb_82598.o \
 ixgbe-$(CONFIG_IXGBE_HWMON) += ixgbe_sysfs.o
 ixgbe-$(CONFIG_DEBUG_FS) += ixgbe_debugfs.o
 ixgbe-$(CONFIG_FCOE:m=y) += ixgbe_fcoe.o
-ixgbe-$(CONFIG_XFRM_OFFLOAD) += ixgbe_ipsec.o
+ixgbe-$(CONFIG_IXGBE_IPSEC) += ixgbe_ipsec.o
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index 7a7679e7be84..1d5d66436eac 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -770,9 +770,9 @@ struct ixgbe_adapter {
 #define IXGBE_RSS_KEY_SIZE     40  /* size of RSS Hash Key in bytes */
 	u32 *rss_key;
 
-#ifdef CONFIG_XFRM_OFFLOAD
+#ifdef CONFIG_IXGBE_IPSEC
 	struct ixgbe_ipsec *ipsec;
-#endif /* CONFIG_XFRM_OFFLOAD */
+#endif /* CONFIG_IXGBE_IPSEC */
 
 	/* AF_XDP zero-copy */
 	struct xdp_umem **xsk_umems;
@@ -1009,7 +1009,7 @@ void ixgbe_store_key(struct ixgbe_adapter *adapter);
 void ixgbe_store_reta(struct ixgbe_adapter *adapter);
 s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 		       u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
-#ifdef CONFIG_XFRM_OFFLOAD
+#ifdef CONFIG_IXGBE_IPSEC
 void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
 void ixgbe_stop_ipsec_offload(struct ixgbe_adapter *adapter);
 void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
@@ -1037,5 +1037,5 @@ static inline int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter,
 					u32 *mbuf, u32 vf) { return -EACCES; }
 static inline int ixgbe_ipsec_vf_del_sa(struct ixgbe_adapter *adapter,
 					u32 *mbuf, u32 vf) { return -EACCES; }
-#endif /* CONFIG_XFRM_OFFLOAD */
+#endif /* CONFIG_IXGBE_IPSEC */
 #endif /* _IXGBE_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 0049a2becd7e..113b38e0defb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8694,7 +8694,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 
 #endif /* IXGBE_FCOE */
 
-#ifdef CONFIG_XFRM_OFFLOAD
+#ifdef CONFIG_IXGBE_IPSEC
 	if (skb->sp && !ixgbe_ipsec_tx(tx_ring, first, &ipsec_tx))
 		goto out_drop;
 #endif
@@ -10190,7 +10190,7 @@ ixgbe_features_check(struct sk_buff *skb, struct net_device *dev,
 	 * the TSO, so it's the exception.
 	 */
 	if (skb->encapsulation && !(features & NETIF_F_TSO_MANGLEID)) {
-#ifdef CONFIG_XFRM_OFFLOAD
+#ifdef CONFIG_IXGBE_IPSEC
 		if (!skb->sp)
 #endif
 			features &= ~NETIF_F_TSO;
@@ -10883,7 +10883,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (hw->mac.type >= ixgbe_mac_82599EB)
 		netdev->features |= NETIF_F_SCTP_CRC;
 
-#ifdef CONFIG_XFRM_OFFLOAD
+#ifdef CONFIG_IXGBE_IPSEC
 #define IXGBE_ESP_FEATURES	(NETIF_F_HW_ESP | \
 				 NETIF_F_HW_ESP_TX_CSUM | \
 				 NETIF_F_GSO_ESP)
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 4a9ee2d83158..140270a13d54 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -8,7 +8,6 @@ config XFRM
 
 config XFRM_OFFLOAD
        bool
-       depends on XFRM
 
 config XFRM_ALGO
 	tristate
-- 
2.18.0

