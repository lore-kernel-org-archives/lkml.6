Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96143208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96143208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388881AbeHWMin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:38:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbeHWMim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:38:42 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2D4AFCA6;
        Thu, 23 Aug 2018 09:09:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 291/324] net: cavium: Add fine-granular dependencies on PCI
Date:   Thu, 23 Aug 2018 09:55:57 +0200
Message-Id: <20180823075010.597415718@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

[ Upstream commit e40562abdf81f32356218d4196c33f5f93c040f7 ]

Add dependencies on PCI where necessary.

Fixes: 7e2bc7fb65 ("net: cavium: Drop dependency of NET_VENDOR_CAVIUM on PCI")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cavium/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/cavium/Kconfig
+++ b/drivers/net/ethernet/cavium/Kconfig
@@ -15,7 +15,7 @@ if NET_VENDOR_CAVIUM
 
 config THUNDER_NIC_PF
 	tristate "Thunder Physical function driver"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	select THUNDER_NIC_BGX
 	---help---
 	  This driver supports Thunder's NIC physical function.
@@ -28,13 +28,13 @@ config THUNDER_NIC_PF
 config THUNDER_NIC_VF
 	tristate "Thunder Virtual function driver"
 	imply CAVIUM_PTP
-	depends on 64BIT
+	depends on 64BIT && PCI
 	---help---
 	  This driver supports Thunder's NIC virtual function
 
 config	THUNDER_NIC_BGX
 	tristate "Thunder MAC interface driver (BGX)"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	select PHYLIB
 	select MDIO_THUNDER
 	select THUNDER_NIC_RGX
@@ -44,7 +44,7 @@ config	THUNDER_NIC_BGX
 
 config	THUNDER_NIC_RGX
 	tristate "Thunder MAC interface driver (RGX)"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	select PHYLIB
 	select MDIO_THUNDER
 	---help---
@@ -53,7 +53,7 @@ config	THUNDER_NIC_RGX
 
 config CAVIUM_PTP
 	tristate "Cavium PTP coprocessor as PTP clock"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	imply PTP_1588_CLOCK
 	default y
 	---help---
@@ -65,7 +65,7 @@ config CAVIUM_PTP
 
 config LIQUIDIO
 	tristate "Cavium LiquidIO support"
-	depends on 64BIT
+	depends on 64BIT && PCI
 	depends on MAY_USE_DEVLINK
 	imply PTP_1588_CLOCK
 	select FW_LOADER


