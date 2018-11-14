Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415FDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E4922507
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E4922507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbeKOAMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:12:48 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43231 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbeKOAMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:12:48 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C8E05EE182CD7;
        Wed, 14 Nov 2018 21:46:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 21:46:45 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <hare@suse.com>, <yanaijie@huawei.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <joe@perches.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH 0/5] libsas: Some logging tidy-up
Date:   Wed, 14 Nov 2018 21:47:44 +0800
Message-ID: <1542203269-174932-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset presents some logging tidy-up, namely removing the printk
wrappers and using pr_XXX() instead.

In addition, some log levels are revised, as previous levels (generally
debug) were too low.

Finally a referece to "pci" is removed from a log, and unreferenced dump
files are deleted.

John Garry (5):
  scsi: libsas: Delete sas_dump.{c, h}
  scsi: libsas: Use pr_fmt(fmt)
  scsi: libsas: Drop sas_printk()
  scsi: libsas: Drop SAS_DPRINTK() and revise logs levels
  scsi: libsas: Remove pcidev reference

 drivers/scsi/libsas/Makefile        |   3 +-
 drivers/scsi/libsas/sas_ata.c       |  24 ++--
 drivers/scsi/libsas/sas_discover.c  |  34 ++---
 drivers/scsi/libsas/sas_dump.c      |  63 ---------
 drivers/scsi/libsas/sas_dump.h      |  29 -----
 drivers/scsi/libsas/sas_event.c     |   1 -
 drivers/scsi/libsas/sas_expander.c  | 249 ++++++++++++++++++------------------
 drivers/scsi/libsas/sas_init.c      |  10 +-
 drivers/scsi/libsas/sas_internal.h  |  14 +-
 drivers/scsi/libsas/sas_phy.c       |   8 +-
 drivers/scsi/libsas/sas_port.c      |  23 ++--
 drivers/scsi/libsas/sas_scsi_host.c | 128 +++++++++---------
 12 files changed, 245 insertions(+), 341 deletions(-)
 delete mode 100644 drivers/scsi/libsas/sas_dump.c
 delete mode 100644 drivers/scsi/libsas/sas_dump.h

-- 
1.9.1

