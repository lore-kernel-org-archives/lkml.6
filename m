Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A9120850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A9120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731213AbeGROy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:54:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730987AbeGROyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:54:25 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B46627C5111B5;
        Wed, 18 Jul 2018 22:16:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.382.0; Wed, 18 Jul 2018 22:15:54 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/9] hisi_sas: Some misc patches
Date:   Wed, 18 Jul 2018 22:14:24 +0800
Message-ID: <1531923273-193768-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some misc patches, generally more minor in
importance.

However there is a patch to add a CPU barrier to the delivery path for
each hw version. We only saw this issue on v3 hw in hip08 chipset, where
the host CPU exhibits a looser memory model than in predecessors, and
software must enforce SMP coherency.

John Garry (1):
  scsi: hisi_sas: Drop hisi_sas_slot_abort()

Xiang Chen (2):
  scsi: hisi_sas: Tidy hisi_sas_task_prep()
  scsi: hisi_sas: Add SATA FIS check for v3 hw

Xiaofei Tan (6):
  scsi: hisi_sas: tidy channel interrupt handler for v3 hw
  scsi: hisi_sas: Fix the failure of recovering PHY from STP link
    timeout
  scsi: hisi_sas: tidy host controller reset function a bit
  scsi: hisi_sas: relocate some common code for v3 hw
  scsi: hisi_sas: Implement handlers of PCIe FLR for v3 hw
  scsi: hisi_sas: add memory barrier in task delivery function

 drivers/scsi/hisi_sas/hisi_sas.h       |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 113 ++++++--------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  20 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  18 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 274 ++++++++++++++++++++-------------
 5 files changed, 239 insertions(+), 190 deletions(-)

-- 
1.9.1

