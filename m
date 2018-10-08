Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB4C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A22075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 07:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4A22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeJHO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 10:58:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46706 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeJHO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 10:58:45 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 38369200008;
        Mon,  8 Oct 2018 09:48:21 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1821F2000F2;
        Mon,  8 Oct 2018 09:48:17 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EBD4F402E2;
        Mon,  8 Oct 2018 15:48:10 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v3, 3/6] net: dpaa2: fix dependency of config FSL_DPAA2_ETH
Date:   Mon,  8 Oct 2018 15:44:27 +0800
Message-Id: <20181008074430.34379-3-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20181008074430.34379-1-yangbo.lu@nxp.com>
References: <20181008074430.34379-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NETDEVICES dependency and ETHERNET dependency hadn't
been required since dpaa2-eth was moved out of staging.
Also allowed COMPILE_TEST for dpaa2-eth.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v3:
	- Added this patch.
---
 drivers/net/ethernet/freescale/dpaa2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
index 67e6461..a7f365d 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -1,7 +1,7 @@
 config FSL_DPAA2_ETH
 	tristate "Freescale DPAA2 Ethernet"
 	depends on FSL_MC_BUS && FSL_MC_DPIO
-	depends on NETDEVICES && ETHERNET
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	help
 	  This is the DPAA2 Ethernet driver supporting Freescale SoCs
 	  with DPAA2 (DataPath Acceleration Architecture v2).
-- 
1.7.1

