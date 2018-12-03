Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E233C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC86A20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC86A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbeLCMJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:09:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeLCMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:09:20 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0666152B7FBAD;
        Mon,  3 Dec 2018 20:08:30 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 20:08:22 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH v3 0/3]  hisi_sas: DIF support
Date:   Mon, 3 Dec 2018 20:09:50 +0800
Message-ID: <1543838994-30028-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset introduces support to the driver for DIF (or PI -protection
information).

We are dropping DIX support for now, based on issues discussed in the
following:
https://marc.info/?l=linux-scsi&m=154357719329297&w=4

We will only support PI in v3 hw at the moment, even though previous hw
versions also support it.

The series is broken down as follows:
- Fix pre-existing sparse warnings
- Tidy sg table size config
- Some tidy-up to accept PI support
- Add components for PI support for main and v3 driver

Difference v1->v2:
- drop scsi_prot_op_normal()

v2->v3:
- fix sparse warnings
- drop DIX support

John Garry (1):
  scsi: hisi_sas: Fix warnings detected by sparse

Xiang Chen (3):
  scsi: hisi_sas: Relocate some code to reduce complexity
  scsi: hisi_sas: Make sg_tablesize consistent value
  scsi: hisi_sas: Add support for DIF feature for v3 hw

 drivers/scsi/hisi_sas/hisi_sas.h       |  20 ++-
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 248 +++++++++++++++++++++++----------
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  17 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  68 +++++----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 227 +++++++++++++++++++++++++++---
 5 files changed, 448 insertions(+), 132 deletions(-)

-- 
1.9.1

