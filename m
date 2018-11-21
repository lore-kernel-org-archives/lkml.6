Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05968C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BBF21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BBF21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeKVA6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:58:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:15571 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbeKVA6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:58:00 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7556484350E38;
        Wed, 21 Nov 2018 22:23:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.408.0; Wed, 21 Nov 2018 22:23:11 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <hch@infradead.org>,
        <maier@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/3]  hisi_sas: DIF/DIX support
Date:   Wed, 21 Nov 2018 22:24:30 +0800
Message-ID: <1542810273-134731-1-git-send-email-john.garry@huawei.com>
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
versions also support it.

The series is broken down as follows:
- Tidy sg table size config
- Some tidy-up to accept PI support
- Add components for PI support for main and v3 driver

Difference v1->v2:
- drop scsi_prot_op_normal()

Xiang Chen (3):
  scsi: hisi_sas: Relocate some code to reduce complexity
  scsi: hisi_sas: Make sg_tablesize consistent value
  scsi: hisi_sas: Add support for DIF/DIX feature for v3 hw

 drivers/scsi/hisi_sas/hisi_sas.h       |  18 +++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 242 ++++++++++++++++++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |   2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 192 +++++++++++++++++++++++++-
 5 files changed, 380 insertions(+), 76 deletions(-)

-- 
1.9.1

