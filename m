Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90603C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9CA218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfAYOX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:23:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728315AbfAYOWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:22:03 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 361A4D6C0BC777513CE4;
        Fri, 25 Jan 2019 22:21:59 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Fri, 25 Jan 2019 22:21:50 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 00/13] hisi_sas: Misc fixes and other more minor patches
Date:   Fri, 25 Jan 2019 22:22:26 +0800
Message-ID: <1548426159-225679-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a misc assortment of fixes found during testing.

Also includes is some debugfs tidy-up and a patch missed from original
upstreaming.

John Garry (5):
  scsi: hisi_sas: No need to check return value of debugfs_create
    functions
  scsi: hisi_sas: Fix type casting and missing static qualifier in
    debugfs code
  scsi: hisi_sas: Some misc tidy-up
  scsi: hisi_sas: Fix to only call scsi_get_prot_op() for non-NULL
    scsi_cmnd
  scsi: hisi_sas: Add missing seq_printf() call in
    hisi_sas_show_row_32()

Luo Jiaxing (3):
  scsi: hisi_sas: Add debugfs ITCT file and add file operations
  scsi: hisi_sas: Reject setting programmed minimum linkrate > 1.5G
  scsi: hisi_sas: Correct memory allocation size for DQ debugfs

Xiang Chen (4):
  scsi: hisi_sas: send primitive NOTIFY to SSP situation only
  scsi: hisi_sas: shutdown axi bus to avoid exception CQ returned
  scsi: hisi_sas: remove the check of sas_dev status in
    hisi_sas_I_T_nexus_reset()
  scsi: hisi_sas: Remove unused parameter of function hisi_sas_alloc()

Xiaofei Tan (1):
  scsi: hisi_sas: Fix losing directly attached disk when hot-plug

 drivers/scsi/hisi_sas/hisi_sas.h       |  19 ++--
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 199 ++++++++++++++++++++-------------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   4 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  13 ++-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  48 +++++---
 5 files changed, 179 insertions(+), 104 deletions(-)

-- 
1.9.1

