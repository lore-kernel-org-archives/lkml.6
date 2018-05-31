Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755081AbeEaMwV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:52:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38653 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754894AbeEaMwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:52:19 -0400
From: John Garry <john.garry@huawei.com>
To: <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/9] hisi_sas: some misc changes
Date: Thu, 31 May 2018 20:50:41 +0800
Message-ID: <1527771050-200916-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces some more minor misc changes to the driver.
Patches of note include:
- Pre-allocate slot DMA buffers
- some fixes for host reset handling

John Garry (2):
  scsi: hisi_sas: Add missing PHY spinlock init
  scsi: hisi_sas: Update a couple of register settings for v3 hw

Xiang Chen (2):
  scsi: hisi_sas: Use dmam_alloc_coherent()
  scsi: hisi_sas: Pre-allocate slot DMA buffers

Xiaofei Tan (5):
  scsi: hisi_sas: Only process broadcast change in phy_bcast_v3_hw()
  scsi: hisi_sas: Fix the conflict between dev gone and host reset
  scsi: hisi_sas: Adjust task reject period during host reset
  scsi: hisi_sas: Add a flag to filter PHY events during reset
  scsi: hisi_sas: Release all remaining resources in clear nexus ha

 drivers/scsi/hisi_sas/hisi_sas.h       |  10 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 214 +++++++++++++++------------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  16 ++-
 5 files changed, 122 insertions(+), 124 deletions(-)

-- 
1.9.1
