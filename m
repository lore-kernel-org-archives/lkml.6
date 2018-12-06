Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B24FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B03B20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B03B20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbeLFNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:33:36 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15644 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728448AbeLFNdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:33:36 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8BC9CEFD3DA31;
        Thu,  6 Dec 2018 21:33:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Thu, 6 Dec 2018 21:33:19 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v4 0/5]  hisi_sas: DIF support
Date:   Thu, 6 Dec 2018 21:34:39 +0800
Message-ID: <1544103284-100497-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces support to the driver for DIF/DIX.

We are making DIX support as RFC for now, based on issues discussed in the
following:
https://marc.info/?l=linux-scsi&m=154357719329297&w=4 and
https://marc.info/?l=linux-scsi&m=154406987703456&w=2

We will only support PI in v3 hw at the moment, even though previous hw
versions also support it.

The series is broken down as follows:
- Fix pre-existing sparse warnings
- Tidy sg table size config
- Some tidy-up to accept PI support
- Add components for PI support for main and v3 driver

Differences:
v3->v4:
- re-add DIX support as RFC - do not commit please!
- also DIX support is labelled experimental in the driver

v2->v3:
- fix sparse warnings
- drop DIX support

v1->v2:
- drop scsi_prot_op_normal()

John Garry (1):
  scsi: hisi_sas: Fix warnings detected by sparse

Xiang Chen (4):
  scsi: hisi_sas: Relocate some code to reduce complexity
  scsi: hisi_sas: Make sg_tablesize consistent value
  scsi: hisi_sas: Add support for DIF feature for v3 hw
  scsi: hisi_sas: Add support for DIX feature for v3 hw as experimental

 drivers/scsi/hisi_sas/hisi_sas.h       |  21 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 246 ++++++++++++++++++++++++---------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  17 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  68 +++++----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 243 +++++++++++++++++++++++++++++---
 5 files changed, 464 insertions(+), 131 deletions(-)

-- 
1.9.1

