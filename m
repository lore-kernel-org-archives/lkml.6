Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDDC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9962084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9962084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeI2N6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:58:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59236 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbeI2N5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:57:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D8A420000D;
        Sat, 29 Sep 2018 09:30:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BEC1200147;
        Sat, 29 Sep 2018 09:30:18 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E5EBA402FC;
        Sat, 29 Sep 2018 15:30:12 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 2/5] MAINTAINERS: update files maintained under DPAA2 PTP/ETHERNET
Date:   Sat, 29 Sep 2018 15:26:42 +0800
Message-Id: <20180929072645.20027-2-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180929072645.20027-1-yangbo.lu@nxp.com>
References: <20180929072645.20027-1-yangbo.lu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files maintained under DPAA2 PTP/ETHERNET needs to
be updated since dpaa2 ptp driver had been moved into
drivers/net/ethernet/freescale/dpaa2/.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Updated files rtc* as dpaa2-ptp*.
---
 MAINTAINERS |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15565de..de33537 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4530,7 +4530,11 @@ DPAA2 ETHERNET DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/ethernet/freescale/dpaa2
+F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-eth*
+F:	drivers/net/ethernet/freescale/dpaa2/dpni*
+F:	drivers/net/ethernet/freescale/dpaa2/dpkg.h
+F:	drivers/net/ethernet/freescale/dpaa2/Makefile
+F:	drivers/net/ethernet/freescale/dpaa2/Kconfig
 
 DPAA2 ETHERNET SWITCH DRIVER
 M:	Ioana Radulescu <ruxandra.radulescu@nxp.com>
@@ -4541,9 +4545,10 @@ F:	drivers/staging/fsl-dpaa2/ethsw
 
 DPAA2 PTP CLOCK DRIVER
 M:	Yangbo Lu <yangbo.lu@nxp.com>
-L:	linux-kernel@vger.kernel.org
+L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/staging/fsl-dpaa2/rtc
+F:	drivers/net/ethernet/freescale/dpaa2/dpaa-ptp*
+F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 
 DPT_I2O SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
-- 
1.7.1

