Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C60ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9E32146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeGQOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:20:58 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbeGQOU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:20:58 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M4mmf-1fxdTO3J2j-00z2A8; Tue, 17 Jul 2018 15:47:59 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: cavium: add missing PCI dependencies
Date:   Tue, 17 Jul 2018 15:46:34 +0200
Message-Id: <20180717134756.3447762-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:VvaSDVWeXPwusucKUtJPk7TWrAODsv33WpRbynSu/LXc6mlsubi
 aivXqR/HRz4LqGwnjDJ35V1PWYN1QNvXh6HhBFx+NRa3bjrol0WuiOKHtESJknhA0HWj4qG
 T3bzELEwIzhbZhthF+/krLKDXtuH/R35sq31qd5rlhcGiikJiUUXSB4XsF2bRadONPpt1P9
 qXjQ8p78WOVm9EDaN1AdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J9PsQi9gCeo=:TnSHoxXu1pmoP/AyB3beAH
 f1Wg5iwEiLlDDz812xuEKtxiQpYDx09pPWt39LkT40o89eEtrUJ8HBoQB0uQQ3zAwzM3uCB0n
 TFpZv1DvlzGOKmUWofaYdzJuKMfwXA4xsUWnwuzGakb5kKiuRKVQ+VGi3bLz7vVtOVsiGFUTn
 6fMn6VXaaCwDmAezoBYA7YVOz3+JzHQ5XytFvo0bj19EIPPGnvU+D/mxSJyIA86YziI/bCkOh
 oqXrRaD870qR0KfgTUhC0rQhCSiDdMr/Pg9dLsCkfibLXJkq409QcmUtv5oqx8Qx2dDosye8j
 KhFJpccpwDThxMaLanHP4fLLdIDgTNzyELk+fkWYGxiYaH/Ztb02WBcF4Ox8gBXo9zxj/D97y
 Bnx1YtVLR0uTheJJNZQJ2iUE5zM9GJaw803eri74pkw79NBfSp8L8kSZ5bszpoxvxkHgVq8yI
 amr6RoAr6Ir9yF43V/Q/66VuBeG6PfbuK8YYeVx0Vw2jttNiPXy7MVh3NiS3J7m2OK3gUNAYz
 +WqkD9Ca7W50P0KqJmNxfhYAuEeQCJutlbnlduvRXzawbmx/y4j0GfK14APmjLJ4i17ey16LX
 284FSp2iDAVSwh0TbWdnnZHjANlgtNqxf6D/1HMBK4q6DP5zKUVKbZc652XX2eBYmvoTz/+8t
 JizqyEwTOYAO4lA4Av53o1iGW/rSBVUHjD9axurQZianJ7u8+WK9+tck33csR6eOqJdI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While some of the cavium drivers don't require PCI support, most
others do, as shown by these build failures:

WARNING: unmet direct dependencies detected for MDIO_THUNDER
  Depends on [n]: NETDEVICES [=y] && MDIO_BUS [=y] && 64BIT [=y] && PCI [=n]
  Selected by [y]:
  - THUNDER_NIC_BGX [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_CAVIUM [=y] && 64BIT [=y]
  - THUNDER_NIC_RGX [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_CAVIUM [=y] && 64BIT [=y]
drivers/net/ethernet/cavium/thunder/nicvf_main.c: In function 'nicvf_set_irq_affinity':
drivers/net/ethernet/cavium/thunder/nicvf_main.c:1095:25: error: implicit declaration of function 'pci_irq_vector'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/thunder/nic_main.c: In function 'nic_mbx_intr_handler':
drivers/net/ethernet/cavium/thunder/nic_main.c:1135:13: error: implicit declaration of function 'pci_irq_vector'; did you mean 'rcu_irq_enter'? [-Werror=implicit-function-declaration]
In file included from drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:27:
drivers/net/ethernet/cavium/liquidio/octeon_main.h: In function 'octeon_unmap_pci_barx':
drivers/net/ethernet/cavium/liquidio/octeon_main.h:97:3: error: implicit declaration of function 'pci_release_region'; did you mean 'pci_release_regions'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c: In function 'octeon_mbox_process_cmd':
drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c:263:3: error: implicit declaration of function 'pcie_capability_set_word'; did you mean 'has_capability_noaudit'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c: In function 'setup_cn23xx_octeon_pf_device':
drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c:1315:22: error: 'data32' is used uninitialized in this function [-Werror=uninitialized]
drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c: In function 'cn23xx_dump_vf_iq_regs':
include/linux/dynamic_debug.h:135:3: error: 'regval' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/net/ethernet/cavium/liquidio/lio_core.c: In function 'octeon_setup_interrupt':
drivers/net/ethernet/cavium/liquidio/lio_core.c:1067:17: error: invalid application of 'sizeof' to incomplete type 'struct msix_entry'
drivers/net/ethernet/cavium/liquidio/octeon_main.h: In function 'octeon_unmap_pci_barx':
drivers/net/ethernet/cavium/liquidio/octeon_main.h:97:3: error: implicit declaration of function 'pci_release_region'; did you mean 'pci_release_regions'? [-Werror=implicit-function-declaration]

This adds back the minimum set of dependencies to get everything to
build cleanly again, but leaving the ones that build cleanly.

Fixes: 7e2bc7fb65d5 ("net: cavium: Drop dependency of NET_VENDOR_CAVIUM on PCI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/cavium/Kconfig | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
index 4c3a5c354497..80e2e93e4aad 100644
--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -14,7 +14,7 @@ if NET_VENDOR_CAVIUM
 
 config THUNDER_NIC_PF
 	tristate "Thunder Physical function driver"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	select THUNDER_NIC_BGX
 	---help---
 	  This driver supports Thunder's NIC physical function.
@@ -27,7 +27,7 @@ config THUNDER_NIC_PF
 config THUNDER_NIC_VF
 	tristate "Thunder Virtual function driver"
 	imply CAVIUM_PTP
-	depends on 64BIT
+	depends on 64BIT && PCI
 	---help---
 	  This driver supports Thunder's NIC virtual function
 
@@ -35,7 +35,7 @@ config	THUNDER_NIC_BGX
 	tristate "Thunder MAC interface driver (BGX)"
 	depends on 64BIT
 	select PHYLIB
-	select MDIO_THUNDER
+	select MDIO_THUNDER if PCI
 	select THUNDER_NIC_RGX
 	---help---
 	  This driver supports programming and controlling of MAC
@@ -45,7 +45,7 @@ config	THUNDER_NIC_RGX
 	tristate "Thunder MAC interface driver (RGX)"
 	depends on 64BIT
 	select PHYLIB
-	select MDIO_THUNDER
+	select MDIO_THUNDER if PCI
 	---help---
 	  This driver supports configuring XCV block of RGX interface
 	  present on CN81XX chip.
@@ -53,6 +53,7 @@ config	THUNDER_NIC_RGX
 config CAVIUM_PTP
 	tristate "Cavium PTP coprocessor as PTP clock"
 	depends on 64BIT
+	depends on PCI
 	imply PTP_1588_CLOCK
 	default y
 	---help---
@@ -66,6 +67,7 @@ config LIQUIDIO
 	tristate "Cavium LiquidIO support"
 	depends on 64BIT
 	depends on MAY_USE_DEVLINK
+	depends on PCI
 	imply PTP_1588_CLOCK
 	select FW_LOADER
 	select LIBCRC32C
-- 
2.9.0

