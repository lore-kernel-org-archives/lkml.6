Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7448C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC121738
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEC121738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934697AbeGDLuv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:50:51 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:57216 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934162AbeGDLuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:50:17 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id 6bqE1y00S3XaVaC01bqEHe; Wed, 04 Jul 2018 13:50:16 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0005pn-DC; Wed, 04 Jul 2018 13:50:14 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fagIY-0007Jj-CH; Wed, 04 Jul 2018 13:50:14 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] net: ethernet: Add missing VENDOR to Cadence and Packet Engines symbols
Date:   Wed,  4 Jul 2018 13:50:12 +0200
Message-Id: <20180704115013.28078-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115013.28078-1-geert+renesas@glider.be>
References: <20180704115013.28078-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor guard Kconfig symbols for Cadence and Packet Engines use a
"NET_" prefix, while all other vendor guards use a "NET_VENDOR_"
prefix.  Hence make them consistent with the rest, and add the missing
trailing "S" for Packet Engines while at it.

As these options don't directly affect the kernel build, and default to
"y", this change has no impact on kernels built with existing
(def)configs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/Makefile              | 4 ++--
 drivers/net/ethernet/cadence/Kconfig       | 6 +++---
 drivers/net/ethernet/packetengines/Kconfig | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
index 8fbfe9ce2fa53a69..0c3ab7efff8c9ddb 100644
--- a/drivers/net/ethernet/Makefile
+++ b/drivers/net/ethernet/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_NET_VENDOR_AQUANTIA) += aquantia/
 obj-$(CONFIG_NET_VENDOR_ARC) += arc/
 obj-$(CONFIG_NET_VENDOR_ATHEROS) += atheros/
 obj-$(CONFIG_NET_VENDOR_AURORA) += aurora/
-obj-$(CONFIG_NET_CADENCE) += cadence/
+obj-$(CONFIG_NET_VENDOR_CADENCE) += cadence/
 obj-$(CONFIG_NET_VENDOR_BROADCOM) += broadcom/
 obj-$(CONFIG_NET_VENDOR_BROCADE) += brocade/
 obj-$(CONFIG_NET_CALXEDA_XGMAC) += calxeda/
@@ -68,7 +68,7 @@ obj-$(CONFIG_NET_VENDOR_NVIDIA) += nvidia/
 obj-$(CONFIG_LPC_ENET) += nxp/
 obj-$(CONFIG_NET_VENDOR_OKI) += oki-semi/
 obj-$(CONFIG_ETHOC) += ethoc.o
-obj-$(CONFIG_NET_PACKET_ENGINE) += packetengines/
+obj-$(CONFIG_NET_VENDOR_PACKET_ENGINES) += packetengines/
 obj-$(CONFIG_NET_VENDOR_PASEMI) += pasemi/
 obj-$(CONFIG_NET_VENDOR_QLOGIC) += qlogic/
 obj-$(CONFIG_NET_VENDOR_QUALCOMM) += qualcomm/
diff --git a/drivers/net/ethernet/cadence/Kconfig b/drivers/net/ethernet/cadence/Kconfig
index 427d65a1a1261095..b9984015ca8c1a68 100644
--- a/drivers/net/ethernet/cadence/Kconfig
+++ b/drivers/net/ethernet/cadence/Kconfig
@@ -2,7 +2,7 @@
 # Atmel device configuration
 #
 
-config NET_CADENCE
+config NET_VENDOR_CADENCE
 	bool "Cadence devices"
 	depends on HAS_IOMEM
 	default y
@@ -16,7 +16,7 @@ config NET_CADENCE
 	  the remaining Atmel network card questions. If you say Y, you will be
 	  asked for your specific card in the following questions.
 
-if NET_CADENCE
+if NET_VENDOR_CADENCE
 
 config MACB
 	tristate "Cadence MACB/GEM support"
@@ -48,4 +48,4 @@ config MACB_PCI
 	  To compile this driver as a module, choose M here: the module
 	  will be called macb_pci.
 
-endif # NET_CADENCE
+endif # NET_VENDOR_CADENCE
diff --git a/drivers/net/ethernet/packetengines/Kconfig b/drivers/net/ethernet/packetengines/Kconfig
index b5ea2a56106ef3c8..1df28f2edd1f9b05 100644
--- a/drivers/net/ethernet/packetengines/Kconfig
+++ b/drivers/net/ethernet/packetengines/Kconfig
@@ -2,7 +2,7 @@
 # Packet engine device configuration
 #
 
-config NET_PACKET_ENGINE
+config NET_VENDOR_PACKET_ENGINES
 	bool "Packet Engine devices"
 	default y
 	depends on PCI
@@ -14,7 +14,7 @@ config NET_PACKET_ENGINE
 	  the questions about packet engine devices. If you say Y, you will
 	  be asked for your specific card in the following questions.
 
-if NET_PACKET_ENGINE
+if NET_VENDOR_PACKET_ENGINES
 
 config HAMACHI
 	tristate "Packet Engines Hamachi GNIC-II support"
@@ -40,4 +40,4 @@ config YELLOWFIN
 	  To compile this driver as a module, choose M here: the module
 	  will be called yellowfin.  This is recommended.
 
-endif # NET_PACKET_ENGINE
+endif # NET_VENDOR_PACKET_ENGINES
-- 
2.17.1

