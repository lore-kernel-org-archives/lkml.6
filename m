Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC92C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAD2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbeLSPz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:55:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16159 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727767AbeLSPz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 10:55:57 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 121F6E015B4C5;
        Wed, 19 Dec 2018 23:55:51 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Wed, 19 Dec 2018 23:55:43 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/8] hisi_sas: debugfs support
Date:   Wed, 19 Dec 2018 23:56:38 +0800
Message-ID: <1545235006-151716-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds debugfs support for capturing driver state for
particular times when the HW has malfunctioned (and we must reset the HW).

Every controller HW version has had bugs. These bugs have been very
painful to debug. One useful tool to debug these is being able to capture
and export HW registers and driver control structures at point of failure.

This feature has been maintained out-of-tree for some time, so add it now.

Luo Jiaxing (8):
  scsi: hisi_sas: Create root and device debugfs directories
  scsi: hisi_sas: Alloc debugfs snapshot buffer memory for all registers
  scsi: hisi_sas: Take debugfs snapshot for all regs
  scsi: hisi_sas: Debugfs global register create file and add file
    operations
  scsi: hisi_sas: Add debugfs for port registers
  scsi: hisi_sas: Add debugfs CQ file and add file operations
  scsi: hisi_sas: Add debugfs DQ file and add file operations
  scsi: hisi_sas: Add debugfs IOST file and add file operations

 drivers/scsi/hisi_sas/hisi_sas.h       |  47 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 508 +++++++++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   9 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 174 ++++++++++-
 4 files changed, 732 insertions(+), 6 deletions(-)

-- 
1.9.1

