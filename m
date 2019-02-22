Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840F22075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfBVPcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:32:03 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45379 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBVPb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id E1F0F1868B;
        Fri, 22 Feb 2019 16:31:25 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 8o13lMMtVFCL; Fri, 22 Feb 2019 16:31:24 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 9C49718681;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E7521A069;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 534201A062;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 46F4E312B;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 453D080DC0; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 3/7] vop: Allow building on more systems
Date:   Fri, 22 Feb 2019 16:30:51 +0100
Message-Id: <20190222153056.18878-6-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222153056.18878-1-vincent.whitchurch@axis.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VOP_BUS does not actually depend on x86-64 or PCI or X86_DEV_DMA_OPS.

The dependency on X86_DEV_DMA_OPS has been unnecessary since commit
5657933dbb6e25fe ("treewide: Move dma_ops from struct dev_archdata into
struct device").

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/misc/mic/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
index 227cc7443671..242dcee14689 100644
--- a/drivers/misc/mic/Kconfig
+++ b/drivers/misc/mic/Kconfig
@@ -38,7 +38,6 @@ comment "VOP Bus Driver"
 
 config VOP_BUS
 	tristate "VOP Bus Driver"
-	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
 	help
 	  This option is selected by any driver which registers a
 	  device or driver on the VOP Bus, such as CONFIG_INTEL_MIC_HOST
@@ -132,7 +131,7 @@ comment "VOP Driver"
 
 config VOP
 	tristate "VOP Driver"
-	depends on 64BIT && PCI && X86 && VOP_BUS
+	depends on VOP_BUS
 	select VHOST_RING
 	select VIRTIO
 	help
-- 
2.20.0

