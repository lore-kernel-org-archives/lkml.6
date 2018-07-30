Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA5FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17ECE20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17ECE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeG3MiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 08:38:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbeG3MiX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 08:38:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C21CC16541D54;
        Mon, 30 Jul 2018 19:03:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Mon, 30 Jul 2018
 19:03:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <derek.chickles@caviumnetworks.com>,
        <satananda.burla@caviumnetworks.com>,
        <felix.manlunas@caviumnetworks.com>,
        <raghu.vatsavayi@caviumnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] liquidio: remove redundant function cn23xx_dump_iq_regs
Date:   Mon, 30 Jul 2018 19:03:41 +0800
Message-ID: <20180730110341.1656-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no in-tree callers of cn23xx_dump_iq_regs.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 .../ethernet/cavium/liquidio/cn23xx_pf_device.c    | 44 ----------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
index e088ded..9f4f3c1d 100644
--- a/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
+++ b/drivers/net/ethernet/cavium/liquidio/cn23xx_pf_device.c
@@ -1417,50 +1417,6 @@ int validate_cn23xx_pf_config_info(struct octeon_device *oct,
 	return 0;
 }
 
-void cn23xx_dump_iq_regs(struct octeon_device *oct)
-{
-	u32 regval, q_no;
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_DOORBELL_0 [0x%x]: 0x%016llx\n",
-		CN23XX_SLI_IQ_DOORBELL(0),
-		CVM_CAST64(octeon_read_csr64
-			(oct, CN23XX_SLI_IQ_DOORBELL(0))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_BASEADDR_0 [0x%x]: 0x%016llx\n",
-		CN23XX_SLI_IQ_BASE_ADDR64(0),
-		CVM_CAST64(octeon_read_csr64
-			(oct, CN23XX_SLI_IQ_BASE_ADDR64(0))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_IQ_FIFO_RSIZE_0 [0x%x]: 0x%016llx\n",
-		CN23XX_SLI_IQ_SIZE(0),
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_IQ_SIZE(0))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_CTL_STATUS [0x%x]: 0x%016llx\n",
-		CN23XX_SLI_CTL_STATUS,
-		CVM_CAST64(octeon_read_csr64(oct, CN23XX_SLI_CTL_STATUS)));
-
-	for (q_no = 0; q_no < CN23XX_MAX_INPUT_QUEUES; q_no++) {
-		dev_dbg(&oct->pci_dev->dev, "SLI_PKT[%d]_INPUT_CTL [0x%x]: 0x%016llx\n",
-			q_no, CN23XX_SLI_IQ_PKT_CONTROL64(q_no),
-			CVM_CAST64(octeon_read_csr64
-				(oct, CN23XX_SLI_IQ_PKT_CONTROL64(q_no))));
-	}
-
-	pci_read_config_dword(oct->pci_dev, CN23XX_CONFIG_PCIE_DEVCTL, &regval);
-	dev_dbg(&oct->pci_dev->dev, "Config DevCtl [0x%x]: 0x%08x\n",
-		CN23XX_CONFIG_PCIE_DEVCTL, regval);
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_PRT[%d]_CFG [0x%llx]: 0x%016llx\n",
-		oct->pcie_port, CN23XX_DPI_SLI_PRTX_CFG(oct->pcie_port),
-		CVM_CAST64(lio_pci_readq(
-			oct, CN23XX_DPI_SLI_PRTX_CFG(oct->pcie_port))));
-
-	dev_dbg(&oct->pci_dev->dev, "SLI_S2M_PORT[%d]_CTL [0x%x]: 0x%016llx\n",
-		oct->pcie_port, CN23XX_SLI_S2M_PORTX_CTL(oct->pcie_port),
-		CVM_CAST64(octeon_read_csr64(
-			oct, CN23XX_SLI_S2M_PORTX_CTL(oct->pcie_port))));
-}
-
 int cn23xx_fw_loaded(struct octeon_device *oct)
 {
 	u64 val;
-- 
2.7.0


