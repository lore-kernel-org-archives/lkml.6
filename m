Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D7EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EAC20C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 02:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EAC20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeIYIsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 04:48:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12689 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbeIYIsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 04:48:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41A541959E2F3;
        Tue, 25 Sep 2018 10:43:22 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Tue, 25 Sep 2018
 10:43:16 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH v3 0/5] scsi: libsas: some code cleanups and bug fixes
Date:   Tue, 25 Sep 2018 10:56:49 +0800
Message-ID: <20180925025654.44053-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I split some code cleanups and bug fixes patches from my earlier series:
https://lkml.org/lkml/2018/5/28/2154

These patches are separate to the subject of the earlier series and are just
small fixes. Hope it is much easier to review and test.

v2: fix some typos and add reviewed-by tags.
v3: change the wording suggested by Christoph Hellwig.

Jason Yan (5):
  scsi: libsas: delete dead code in scsi_transport_sas.c
  scsi: libsas: make the lldd_port_deformed method optional
  scsi: libsas: always unregister the old device if going to discover
    new
  scsi: libsas: check the ata device status by ata_dev_enabled()
  scsi: libsas: fix a race condition when smp task timeout

 drivers/scsi/hisi_sas/hisi_sas_main.c |  9 ++-------
 drivers/scsi/libsas/sas_ata.c         |  2 +-
 drivers/scsi/libsas/sas_discover.c    |  2 +-
 drivers/scsi/libsas/sas_expander.c    | 22 +++++++++-------------
 drivers/scsi/scsi_transport_sas.c     |  2 --
 5 files changed, 13 insertions(+), 24 deletions(-)

-- 
2.14.4

