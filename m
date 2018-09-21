Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D24EECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBB920673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBB920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391041AbeIUXSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:18:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388909AbeIUXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:18:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A2AAE3617D593;
        Sat, 22 Sep 2018 01:28:09 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Sat, 22 Sep 2018 01:28:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <z.liuxinliang@hisilicon.com>, <kong.kongxinwei@hisilicon.com>,
        <puck.chen@hisilicon.com>, <airlied@linux.ie>
CC:     <linuxarm@huawei.com>, <chris@chris-wilson.co.uk>,
        <dri-devel@lists.freedesktop.org>, <baowenyi@huawei.com>,
        <linux-kernel@vger.kernel.org>, <zourongrong@gmail.com>,
        <daniel.vetter@ffwll.ch>, John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] drm/hisilicon: hibmc: Use HUAWEI PCI vendor ID macro
Date:   Sat, 22 Sep 2018 01:25:27 +0800
Message-ID: <1537550727-21257-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
References: <1537550727-21257-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use Huawei PCI vendor ID macro from pci_ids.h file.

In addition, switch to use PCI_VDEVICE() instead of open coding.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index d4f6f1f..79b6bda 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -402,7 +402,7 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 }
 
 static struct pci_device_id hibmc_pci_table[] = {
-	{0x19e5, 0x1711, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VDEVICE(HUAWEI, 0x1711) },
 	{0,}
 };
 
-- 
1.9.1

