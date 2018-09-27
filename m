Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5709921580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709921580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbeI0ReG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:34:06 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38094 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbeI0ReG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:34:06 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8034E1A0023;
        Thu, 27 Sep 2018 13:16:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E2C1D1A00A1;
        Thu, 27 Sep 2018 13:16:12 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 49C0D402DB;
        Thu, 27 Sep 2018 19:16:07 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Date:   Thu, 27 Sep 2018 19:12:27 +0800
Message-Id: <20180927111228.46118-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move DPAA2 PTP driver out of staging/
since the dpaa2-eth had been moved out.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/Kconfig             |    9 +--------
 drivers/net/ethernet/freescale/dpaa2/Kconfig       |   15 +++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/Makefile      |    6 ++++--
 .../ethernet/freescale/dpaa2}/dprtc-cmd.h          |    0
 .../rtc => net/ethernet/freescale/dpaa2}/dprtc.c   |    0
 .../rtc => net/ethernet/freescale/dpaa2}/dprtc.h   |    0
 .../rtc => net/ethernet/freescale/dpaa2}/rtc.c     |    0
 .../rtc => net/ethernet/freescale/dpaa2}/rtc.h     |    0
 drivers/staging/fsl-dpaa2/Kconfig                  |    8 --------
 drivers/staging/fsl-dpaa2/Makefile                 |    1 -
 drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 -------
 11 files changed, 20 insertions(+), 26 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/Kconfig
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc-cmd.h (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.c (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.h (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/rtc.c (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/rtc.h (100%)
 delete mode 100644 drivers/staging/fsl-dpaa2/rtc/Makefile

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 7a30276..d3a62bc 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -96,13 +96,6 @@ config GIANFAR
 	  on the 8540.
 
 source "drivers/net/ethernet/freescale/dpaa/Kconfig"
-
-config FSL_DPAA2_ETH
-	tristate "Freescale DPAA2 Ethernet"
-	depends on FSL_MC_BUS && FSL_MC_DPIO
-	depends on NETDEVICES && ETHERNET
-	---help---
-	  Ethernet driver for Freescale DPAA2 SoCs, using the
-	  Freescale MC bus driver
+source "drivers/net/ethernet/freescale/dpaa2/Kconfig"
 
 endif # NET_VENDOR_FREESCALE
diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
new file mode 100644
index 0000000..44c5c3a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -0,0 +1,15 @@
+config FSL_DPAA2_ETH
+	tristate "Freescale DPAA2 Ethernet"
+	depends on FSL_MC_BUS && FSL_MC_DPIO
+	depends on NETDEVICES && ETHERNET
+	help
+	  Ethernet driver for Freescale DPAA2 SoCs, using the
+	  Freescale MC bus driver
+
+config FSL_DPAA2_PTP_CLOCK
+	tristate "Freescale DPAA2 PTP Clock"
+	depends on FSL_DPAA2_ETH && POSIX_TIMERS
+	select PTP_1588_CLOCK
+	help
+	  This driver adds support for using the DPAA2 1588 timer module
+	  as a PTP clock.
diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
index 9315ecd..312e37f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Makefile
+++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
@@ -3,9 +3,11 @@
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
 
-obj-$(CONFIG_FSL_DPAA2_ETH) += fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-rtc.o
 
-fsl-dpaa2-eth-objs    := dpaa2-eth.o dpaa2-ethtool.o dpni.o
+fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o
+fsl-dpaa2-rtc-objs	:= rtc.o dprtc.o
 
 # Needed by the tracing framework
 CFLAGS_dpaa2-eth.o := -I$(src)
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h
rename to drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc.c b/drivers/net/ethernet/freescale/dpaa2/dprtc.c
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc.c
rename to drivers/net/ethernet/freescale/dpaa2/dprtc.c
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc.h b/drivers/net/ethernet/freescale/dpaa2/dprtc.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc.h
rename to drivers/net/ethernet/freescale/dpaa2/dprtc.h
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.c b/drivers/net/ethernet/freescale/dpaa2/rtc.c
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/rtc.c
rename to drivers/net/ethernet/freescale/dpaa2/rtc.c
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.h b/drivers/net/ethernet/freescale/dpaa2/rtc.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/rtc.h
rename to drivers/net/ethernet/freescale/dpaa2/rtc.h
diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 59aaae7..991e154 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -16,11 +16,3 @@ config FSL_DPAA2_ETHSW
 	---help---
 	Driver for Freescale DPAA2 Ethernet Switch. Select
 	BRIDGE to have support for bridge tools.
-
-config FSL_DPAA2_PTP_CLOCK
-	tristate "Freescale DPAA2 PTP Clock"
-	depends on FSL_DPAA2_ETH && POSIX_TIMERS
-	select PTP_1588_CLOCK
-	help
-	  This driver adds support for using the DPAA2 1588 timer module
-	  as a PTP clock.
diff --git a/drivers/staging/fsl-dpaa2/Makefile b/drivers/staging/fsl-dpaa2/Makefile
index 464f242..c92ab98 100644
--- a/drivers/staging/fsl-dpaa2/Makefile
+++ b/drivers/staging/fsl-dpaa2/Makefile
@@ -3,4 +3,3 @@
 #
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW)		+= ethsw/
-obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= rtc/
diff --git a/drivers/staging/fsl-dpaa2/rtc/Makefile b/drivers/staging/fsl-dpaa2/rtc/Makefile
deleted file mode 100644
index 5468da0..0000000
--- a/drivers/staging/fsl-dpaa2/rtc/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for the Freescale DPAA2 PTP clock
-#
-
-obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK) += dpaa2-rtc.o
-
-dpaa2-rtc-objs := rtc.o dprtc.o
-- 
1.7.1

