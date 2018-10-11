Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D1C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311212085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 311212085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeJKQZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:25:10 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKQZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:25:10 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpD39-1fKB061WgR-00qiOw; Thu, 11 Oct 2018 10:58:37 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MpD39-1fKB061WgR-00qiOw; Thu, 11 Oct 2018 10:58:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kumar Sanghvi <kumaras@chelsio.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Arjun Vynipadath <arjun@chelsio.com>,
        Atul Gupta <atul.gupta@chelsio.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] cxgb4: fix thermal configuration dependencies
Date:   Thu, 11 Oct 2018 10:57:57 +0200
Message-Id: <20181011085835.2567446-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:iSkPomLYnvkhpqZJ3IXRNKLcq2sBTzcW8bNdNjoORvg+tymxATu
 eGAo6UCvL+XRQNmDhhqdcWz53EZkTrYoeNQMbY5FN1WnAK6x45H8XJWPC9WU9kFiQNAV8Vl
 V13IMUFr1M1/SUty2mUW3P3ifVtme7ZV9zGVh3cxWdhCAf0DeSgBBZQLXvLsYmaIT3Wy6/O
 AvctUHraiwSLagz/rofrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ge6PJOvOkL0=:FaI4jXAc2U/oSWxt0FI6Cx
 rQOYK3fl8Np8G9HQoBUJGRLVOOlbAZ6TOQlRhhDzxrqf1jzWNxxSmTTl0HYixwX+sgiSNfK4t
 Nb9kGKbl/9Fr782Y/WrbbG3rLkUQXpRP7gwhlhrFhk4oqdEN869Chxd+1ugK/NvwDCcjY5Gy5
 G0cb6S1kWuBx1SWmVUJUSjNrCB5xkWjcApwlTUMDab6vCy88K9c/m6j/kpkwNVYlx+/9HopIL
 OZg9bVsQsu/1C+jxyA/rwRtPrb9tBbikR62x3yzTQXmlWcDLWBEPNQQknqD9pxOxxNrVV0Z70
 6HhO2Yqg6n++3YggaX9aUxECxLCYKsEDJA/WFJGC7WlmlG27aUhY6LHy/g3UOlHYAWe9gkoQY
 Qvm+H9QLzwoJzS+opAr6sB46mZSGMWb4aaL0Dgge7u47ltVh9nkRAFmXZK2wtA/Pzl5a6KH+/
 5eoufPopKL+ZqwtkOkZVUuhI8rNJ3ytnbTjsM20o88FoI/ouH1VbbQdbloNpkG9+p/d4ZuNgb
 wJRIt9m/qo22/OsE56zNVWVfoWdRaSwKBmnD9/mSfTTuuvfel8GruXeYiB2UbjNgol0QIRJ+A
 2jMIEhlqvrNWBWrKUAo+gRmWp148M8oxECT8t9r8loqsQ/6sfWo5KJwYq4Wcvi3Ls3XQ54xG5
 6b5+ZHwc2KxIHjycDcHOrZ+eVqGmKNx4eQJB5AlP7epAJkcsZVVCk72m/cPYfOQ4E4Zk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_THERMAL=m, we get a build error:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c: In function 'cxgb4_thermal_get_trip_type':
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c:48:11: error: 'struct adapter' has no member named 'ch_thermal'

Once that is fixed by using IS_ENABLED() checks, we get a link error
against the thermal subsystem when cxgb4 is built-in:

drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_init':
cxgb4_thermal.c:(.text+0x180): undefined reference to `thermal_zone_device_register'
drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.o: In function `cxgb4_thermal_remove':
cxgb4_thermal.c:(.text+0x1e0): undefined reference to `thermal_zone_device_unregister'

Finally, since CONFIG_THERMAL can be =m, the Makefile fails to pick up the
extra file into built-in.a, and we get another link failure against the
cxgb4_thermal_init/cxgb4_thermal_remove files, so the Makefile has to
be adapted as well to work for both CONFIG_THERMAL=y and =m.

Fixes: b18719157762 ("cxgb4: Add thermal zone support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/chelsio/Kconfig            |  1 +
 drivers/net/ethernet/chelsio/cxgb4/Makefile     |  4 +++-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      |  6 ++----
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 10 ++++------
 4 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/Kconfig b/drivers/net/ethernet/chelsio/Kconfig
index e2cdfa75673f..75c1c5ed2387 100644
--- a/drivers/net/ethernet/chelsio/Kconfig
+++ b/drivers/net/ethernet/chelsio/Kconfig
@@ -67,6 +67,7 @@ config CHELSIO_T3
 config CHELSIO_T4
 	tristate "Chelsio Communications T4/T5/T6 Ethernet support"
 	depends on PCI && (IPV6 || IPV6=n)
+	depends on THERMAL || !THERMAL
 	select FW_LOADER
 	select MDIO
 	select ZLIB_DEFLATE
diff --git a/drivers/net/ethernet/chelsio/cxgb4/Makefile b/drivers/net/ethernet/chelsio/cxgb4/Makefile
index 91d8a885deba..78e5d17a1d5f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/Makefile
+++ b/drivers/net/ethernet/chelsio/cxgb4/Makefile
@@ -12,4 +12,6 @@ cxgb4-objs := cxgb4_main.o l2t.o smt.o t4_hw.o sge.o clip_tbl.o cxgb4_ethtool.o
 cxgb4-$(CONFIG_CHELSIO_T4_DCB) +=  cxgb4_dcb.o
 cxgb4-$(CONFIG_CHELSIO_T4_FCOE) +=  cxgb4_fcoe.o
 cxgb4-$(CONFIG_DEBUG_FS) += cxgb4_debugfs.o
-cxgb4-$(CONFIG_THERMAL) += cxgb4_thermal.o
+ifdef CONFIG_THERMAL
+cxgb4-objs += cxgb4_thermal.o
+endif
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index 95909f0686b1..b16f4b3ef4c5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -891,7 +891,7 @@ struct mps_encap_entry {
 	atomic_t refcnt;
 };
 
-#ifdef CONFIG_THERMAL
+#if IS_ENABLED(CONFIG_THERMAL)
 struct ch_thermal {
 	struct thermal_zone_device *tzdev;
 	int trip_temp;
@@ -1017,7 +1017,7 @@ struct adapter {
 
 	/* Dump buffer for collecting logs in kdump kernel */
 	struct vmcoredd_data vmcoredd;
-#ifdef CONFIG_THERMAL
+#if IS_ENABLED(CONFIG_THERMAL)
 	struct ch_thermal ch_thermal;
 #endif
 };
@@ -1875,9 +1875,7 @@ int t4_set_vlan_acl(struct adapter *adap, unsigned int mbox, unsigned int vf,
 		    u16 vlan);
 int cxgb4_dcb_enabled(const struct net_device *dev);
 
-#ifdef CONFIG_THERMAL
 int cxgb4_thermal_init(struct adapter *adap);
 int cxgb4_thermal_remove(struct adapter *adap);
-#endif /* CONFIG_THERMAL */
 
 #endif /* __CXGB4_H__ */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 309f8c2226a5..05a46926016a 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5863,10 +5863,9 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!is_t4(adapter->params.chip))
 		cxgb4_ptp_init(adapter);
 
-#ifdef CONFIG_THERMAL
-	if (!is_t4(adapter->params.chip) && (adapter->flags & FW_OK))
+	if (IS_ENABLED(CONFIG_THERMAL) &&
+	    !is_t4(adapter->params.chip) && (adapter->flags & FW_OK))
 		cxgb4_thermal_init(adapter);
-#endif /* CONFIG_THERMAL */
 
 	print_adapter_info(adapter);
 	return 0;
@@ -5933,9 +5932,8 @@ static void remove_one(struct pci_dev *pdev)
 
 		if (!is_t4(adapter->params.chip))
 			cxgb4_ptp_stop(adapter);
-#ifdef CONFIG_THERMAL
-		cxgb4_thermal_remove(adapter);
-#endif
+		if (IS_ENABLED(CONFIG_THERMAL))
+			cxgb4_thermal_remove(adapter);
 
 		/* If we allocated filters, free up state associated with any
 		 * valid filters ...
-- 
2.18.0

