Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95684C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DA2C208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA2C208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeG0NXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:23:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729541AbeG0NXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:23:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B530F9DB2EC0;
        Fri, 27 Jul 2018 20:02:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.382.0; Fri, 27 Jul 2018
 20:01:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <derek.chickles@caviumnetworks.com>,
        <satananda.burla@caviumnetworks.com>,
        <felix.manlunas@caviumnetworks.com>,
        <raghu.vatsavayi@caviumnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] liquidio: remove redundant function cn23xx_dump_vf_iq_regs
Date:   Fri, 27 Jul 2018 19:57:24 +0800
Message-ID: <20180727115724.18964-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree callers.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../ethernet/cavium/liquidio/cn23xx_vf_device.c    | 30 ----------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
index 91dce8b..962bb62 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_vf_device.c
@@ -682,33 +682,3 @@ int cn23xx_setup_octeon_vf_device(struct octeon_device *oct)
 
 	return 0;
 }
-
-void cn23xx_dump_vf_iq_regs(struct octeon_device *oct)
-{
-	u32 regval, q_no;
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_DOORBELL_0 [0x%x]: 0x%016llx\n",
-		CN23XX_VF_SLI_IQ_DOORBELL(0),
-		CVM_CAST64(octeon_read_csr64(
-					oct, CN23XX_VF_SLI_IQ_DOORBELL(0))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_BASEADDR_0 [0x%x]: 0x%016llx\n",
-		CN23XX_VF_SLI_IQ_BASE_ADDR64(0),
-		CVM_CAST64(octeon_read_csr64(
-			oct, CN23XX_VF_SLI_IQ_BASE_ADDR64(0))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_FIFO_RSIZE_0 [0x%x]: 0x%016llx\n",
-		CN23XX_VF_SLI_IQ_SIZE(0),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_VF_SLI_IQ_SIZE(0))));
-
-	for (q_no = 0; q_no < oct->sriov_info.rings_per_vf; q_no++) {
-		dev_dbg(&oct->pci_dev->dev, "SLI_PKT[%d]_INPUT_CTL [0x%x]: 0x%016llx\n",
-			q_no, CN23XX_VF_SLI_IQ_PKT_CONTROL64(q_no),
-			CVM_CAST64(octeon_read_csr64(
-				oct, CN23XX_VF_SLI_IQ_PKT_CONTROL64(q_no))));
-	}
-
-	pci_read_config_dword(oct->pci_dev, CN23XX_CONFIG_PCIE_DEVCTL, &regval);
-	dev_dbg(&oct->pci_dev->dev, "Config DevCtl [0x%x]: 0x%08x\n",
-		CN23XX_CONFIG_PCIE_DEVCTL, regval);
-}
-- 
2.7.0


