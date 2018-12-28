Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41B22146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbeL1IPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:15:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728006AbeL1IPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:15:00 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD35548501178;
        Fri, 28 Dec 2018 16:14:55 +0800 (CST)
Received: from localhost.localdomain (10.175.34.53) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 16:14:47 +0800
From:   Xue Chaojing <xuechaojing@huawei.com>
To:     <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <xuechaojing@huawei.com>,
        <netdev@vger.kernel.org>, <wulike1@huawei.com>,
        <chiqijun@huawei.com>, <fy.wang@huawei.com>, <tony.qu@huawei.com>,
        <luoshaokai@huawei.com>
Subject: [PATCH 1/1] net-next/hinic:add shutdown callback
Date:   Fri, 28 Dec 2018 00:20:40 +0000
Message-ID: <20181228002040.1256-1-xuechaojing@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.34.53]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add shutdown callback for hinic.

Signed-off-by: Xue Chaojing <xuechaojing@huawei.com>
---
 drivers/net/ethernet/huawei/hinic/hinic_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 6d48dc62a44b..76ca8a518dca 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -1106,6 +1106,13 @@ static void hinic_remove(struct pci_dev *pdev)
 	dev_info(&pdev->dev, "HiNIC driver - removed\n");
 }
 
+static void hinic_shutdown(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+
+	dev_info(&pdev->dev, "HiNIC driver - shutdown\n");
+}
+
 static const struct pci_device_id hinic_pci_table[] = {
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_QUAD_PORT_25GE), 0},
 	{ PCI_VDEVICE(HUAWEI, HINIC_DEV_ID_DUAL_PORT_25GE), 0},
@@ -1119,6 +1126,7 @@ static struct pci_driver hinic_driver = {
 	.id_table       = hinic_pci_table,
 	.probe          = hinic_probe,
 	.remove         = hinic_remove,
+	.shutdown       = hinic_shutdown,
 };
 
 module_pci_driver(hinic_driver);
-- 
2.17.1

