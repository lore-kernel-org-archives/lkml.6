Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DFDC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BF52087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BF52087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeKUB17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:27:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeKUB16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:27:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4C72C7731268B;
        Tue, 20 Nov 2018 22:58:21 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 22:58:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/4] hisi_sas: DIF/DIX support
Date:   Tue, 20 Nov 2018 22:59:00 +0800
Message-ID: <1542725944-244183-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support to the driver for DIF/DIX (or PI -
protection information).

We will only support PI in v3 hw at the moment, even though previous hw
versions also support.

The series is broken down as follows:
- Add a generic helper for checking Scsi command normal operation
- Some tidy-up to accept PI support
- Add components for PI support for main and v3 driver

John Garry (1):
  scsi: Add scsi_prot_op_normal()

Xiang Chen (3):
  scsi: hisi_sas: Relocate some code to reduce complexity
  scsi: hisi_sas: Make sg_tablesize consistent value
  scsi: hisi_sas: Add support for DIF/DIX feature for v3 hw

 drivers/scsi/hisi_sas/hisi_sas.h       |  18 +++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 242 ++++++++++++++++++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 192 +++++++++++++++++++++++++-
 include/scsi/scsi_cmnd.h               |   5 +
 6 files changed, 385 insertions(+), 76 deletions(-)

-- 
1.9.1

