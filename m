Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36641C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086F2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbeILNVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:21:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726442AbeILNUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:20:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF386C3346FE;
        Wed, 12 Sep 2018 16:17:27 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Wed, 12 Sep 2018
 16:17:20 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <zhaohongjiang@huawei.com>,
        <hare@suse.com>, <dan.j.williams@intel.com>, <jthumshirn@suse.de>,
        <hch@lst.de>, <huangdaode@hisilicon.com>,
        <chenxiang66@hisilicon.com>, <miaoxie@huawei.com>,
        Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 0/5] scsi: libsas: some code cleanups and bug fixes
Date:   Wed, 12 Sep 2018 16:29:41 +0800
Message-ID: <20180912082946.34814-1-yanaijie@huawei.com>
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

Jason Yan (5):
  scsi: libsas: delete dead code in scsi_transport_sas.c
  scsi: libsas: check the lldd callback correctly
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

