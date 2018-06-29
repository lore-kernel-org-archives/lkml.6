Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5E4C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A05E27D85
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 10:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A05E27D85
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755086AbeF2K44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 06:56:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59911 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753841AbeF2Kyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 06:54:40 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 153BF8A85C3C1;
        Fri, 29 Jun 2018 18:54:37 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.382.0; Fri, 29 Jun 2018 18:51:24 +0800
From:   Peng Li <lipeng321@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <lipeng321@huawei.com>
Subject: [PATCH net-next 08/10] net: hns3: give default option while dependency HNS3 set
Date:   Fri, 29 Jun 2018 19:23:03 +0800
Message-ID: <1530271385-49668-9-git-send-email-lipeng321@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
References: <1530271385-49668-1-git-send-email-lipeng321@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

Give default option for HNS3_HCLGE and HNS3_ENET will be helpful,
while dependency HNS3 is set. Meanwhile, use "if HNS3" section
instead of all the "depends on HNS3".

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
---
 drivers/net/ethernet/hisilicon/Kconfig | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
index 8bcf470..27edca8 100644
--- a/drivers/net/ethernet/hisilicon/Kconfig
+++ b/drivers/net/ethernet/hisilicon/Kconfig
@@ -85,10 +85,12 @@ config HNS3
 	  drivers(like ODP)to register with HNAE devices and their associated
 	  operations.
 
+if HNS3
+
 config HNS3_HCLGE
 	tristate "Hisilicon HNS3 HCLGE Acceleration Engine & Compatibility Layer Support"
+	default m
 	depends on PCI_MSI
-	depends on HNS3
 	---help---
 	  This selects the HNS3_HCLGE network acceleration engine & its hardware
 	  compatibility layer. The engine would be used in Hisilicon hip08 family of
@@ -97,16 +99,15 @@ config HNS3_HCLGE
 config HNS3_DCB
 	bool "Hisilicon HNS3 Data Center Bridge Support"
 	default n
-	depends on HNS3 && HNS3_HCLGE && DCB
+	depends on HNS3_HCLGE && DCB
 	---help---
 	  Say Y here if you want to use Data Center Bridging (DCB) in the HNS3 driver.
 
 	  If unsure, say N.
 
 config HNS3_HCLGEVF
-    tristate "Hisilicon HNS3VF Acceleration Engine & Compatibility Layer Support"
-    depends on PCI_MSI
-    depends on HNS3
+	tristate "Hisilicon HNS3VF Acceleration Engine & Compatibility Layer Support"
+	depends on PCI_MSI
 	depends on HNS3_HCLGE
     ---help---
 	  This selects the HNS3 VF drivers network acceleration engine & its hardware
@@ -115,11 +116,13 @@ config HNS3_HCLGEVF
 
 config HNS3_ENET
 	tristate "Hisilicon HNS3 Ethernet Device Support"
+	default m
 	depends on 64BIT && PCI
-	depends on HNS3
 	---help---
 	  This selects the Ethernet Driver for Hisilicon Network Subsystem 3 for hip08
 	  family of SoCs. This module depends upon HNAE3 driver to access the HNAE3
 	  devices and their associated operations.
 
+endif #HNS3
+
 endif # NET_VENDOR_HISILICON
-- 
1.9.1

