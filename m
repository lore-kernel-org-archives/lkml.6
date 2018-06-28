Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7601FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6A327387
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6A327387
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966115AbeF1Msb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:48:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966044AbeF1Ms0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:48:26 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51AC2D6E2DC9F;
        Thu, 28 Jun 2018 20:48:12 +0800 (CST)
Received: from vm107-55-164.huawei.com (100.107.55.164) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.382.0; Thu, 28 Jun 2018 20:48:05 +0800
From:   Xiaowei Song <songxiaowei@hisilicon.com>
To:     <wangbinghui@hisilicon.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dimitrysh@google.com>
CC:     <chenyao11@huawei.com>, <songxiaowei@hisilicon.com>
Subject: [PATCH v5 0/1] *** PCI: kirin: Add MSI support ***
Date:   Thu, 28 Jun 2018 20:48:02 +0800
Message-ID: <20180628124803.110315-1-songxiaowei@hisilicon.com>
X-Mailer: git-send-email 2.11.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.55.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before Version Patches
======================
patch v4
https://patchwork.kernel.org/patch/10402399/
patch v3
https://www.spinics.net/lists/linux-pci/msg72322.html
patch v2
https://www.spinics.net/lists/kernel/msg2797610.html

patch v1
https://www.spinics.net/lists/kernel/msg2796410.html

Changes between V5 and V4
=========================
1. rebase the patch based on Linux next-version branch.
2. fix issues according to review comments from Andy Shevchenko and Lorenzo.
   (1) Del MSI irq handler for DW handle it, while Kirin only read the number from DT,
   (2) Use the function dw_pcie_msi_init directly if CONFIG_PCI_MSI is enabled.

Changes between V4 and V3
=========================
1. remove DT binding patch, for Wei Xu had applied it.
2. fix issues according to review comments from Andy Shevchenko.
   (1) Take the msi number get and request as a seperate function,
   (2) Use the result of  platform_get_irq as return val.

Changes between V3 and V2
=========================
1. fix issues according to review comments
   (1)from Bjorn Helgaas: Check for 'pci->pp.msi_irq < 0'.
   (2)from Bjorn Helgaas: Update the message of 'msi irq' in dev_err().

Changes between V2 and V1
=========================
1. seperate DT binding patch.
2. fix issues according to review comments
   (1)from Bjorn Helgaas: Update the style of subject and changelog.
   (2)from Bjorn Helgaas: Add msi irq number in the message.
   (3)from Bjorn Helgaas: Delete unnecessary code 'pci->pp.root_bus_nr = -1'.
   (4)from Dmitry Shmidt: Fix typing error. Replace 'interrupts-names' of 'interrupt-names'.

Xiaowei Song (1):
  PCI: kirin: Add MSI support

 drivers/pci/dwc/pcie-kirin.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.11.GIT

